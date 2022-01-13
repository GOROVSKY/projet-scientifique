package emergency;
import java.io.IOException;
import java.math.BigDecimal;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
import java.util.ArrayList;
import java.util.Map;
import java.util.Random;
import java.util.TreeMap;

import org.json.JSONArray;
import org.json.JSONObject;

import modele.Caserne;
import modele.Incident;
import modele.Pompier;
import modele.TypeIncidentEnum;
import modele.TypeProduit;
import modele.Vehicule;
import modele.VehiculeTypeProduit;

public class EmergencyManager {
	
	private Map<Integer,Pompier> pompierMap ;
	private Map<Integer,TypeProduit> typeProduitMap;
	private Map<Integer,Vehicule> vehiculeMap;
	private Map<Integer,Caserne> caserneMap;

	
	public void loadPompierDisponible() {
		pompierMap=DatabaseDriver.getAllPompierDispo();
	}
	
	public void loadTypeProduit() {
		typeProduitMap=DatabaseDriver.getAllTypeProduit();
	}
	
	
	public void loadVehiculeDisponible() {
		vehiculeMap=DatabaseDriver.getAllVehiculeDispo();
	}
	
	public void loadCaserne(){
		caserneMap=DatabaseDriver.getAllCaserne();
	}
	
	public void ajouterProduitVehicule() {
		for(VehiculeTypeProduit vtp : DatabaseDriver.getAllVehiculeTypeProduit()) {
			System.out.println(vtp);
			if(vehiculeMap.containsKey(vtp.getId_vehicule())){
				vehiculeMap.get(vtp.getId_vehicule()).addTypeProduit(typeProduitMap.get(vtp.getId_type_produit()));
			}
		}
	}
	
	public void affecterPompierDansCaserne() {
		for(Integer pompierKey : pompierMap.keySet()) {
			Pompier p = pompierMap.get(pompierKey);
			p.setCaserne(caserneMap.get(p.getId_caserne()));
			caserneMap.get(p.getId_caserne()).addPompier(p);
		}
	}
	
	public void affecterVehiculeDansCaserne() {
		for(Integer vehiculeKey : vehiculeMap.keySet()) {
			Vehicule v = vehiculeMap.get(vehiculeKey);
			v.setCaserne(caserneMap.get(v.getCaserne_id()));
			caserneMap.get(v.getCaserne_id()).addVehicules(v);
		}
	}
	
	public void afficherRessourcesDisponibles() {
		for(Integer pompierKey : pompierMap.keySet()) {
			System.out.println(pompierMap.get(pompierKey));
		}
		for(Integer vehiculeKey : vehiculeMap.keySet()) {
			System.out.println(vehiculeMap.get(vehiculeKey));
		}
		for(Integer caserneKey : caserneMap.keySet()) {
			System.out.println(caserneMap.get(caserneKey));
		}
		
	}
	
	public void getAndTreatIncident() {
		System.out.println("****************STARTING INCIDENT TREATEMENT******************");
		ArrayList<Incident> incidentNotTreated = new ArrayList<Incident>();
		incidentNotTreated.addAll(DatabaseDriver.getIncidentNotTreated());
		for(Incident inc : incidentNotTreated) {
			System.out.println("*************Treating Incident********** :"+inc);
			TreeMap<Integer,Caserne> caserneOrderedByDistance = new TreeMap<Integer,Caserne>();
			for(Integer caserneKey : caserneMap.keySet()) {
				Caserne c = caserneMap.get(caserneKey);
				int distance_incident_to_caserne = (int)distance(inc.getLatitude(),c.getLatidude(),inc.getLongitude(),c.getLongitude(),0.0,0.0);
				caserneOrderedByDistance.put(distance_incident_to_caserne, c);
			}
			/// PICK VEHICULE AND POMPIER
			
			for(Integer caserneKey : caserneOrderedByDistance.keySet()) {
				Caserne closest_casern = caserneOrderedByDistance.get(caserneKey);
				//FIRE ONLY <5
				if(inc.getId_type()<=5) {
					Vehicule v = pickVehiculeWithAddaptedProduct(closest_casern,inc.getId_type(),inc.getCriticite());
					if(v!=null) {
						System.out.println("Appropriated casern is "+closest_casern);
						System.out.println("Vehicule with adapted product is :"+v);
						int nb_pompier_dispo=closest_casern.getPompiers().size();
						int nb_pompier_to_send=0;
						if(inc.getCriticite()<=4) {
							nb_pompier_to_send = new Random().nextInt(2,5); //4 Pompier max 
						}
						else if(inc.getCriticite()>=5 && inc.getCriticite()<=7) {
							nb_pompier_to_send = new Random().nextInt(3,6); //5 Pompier max
						}
						else if(inc.getCriticite()>7) {
							nb_pompier_to_send = 6;
						}
						ArrayList<Pompier> pompierToSend = new ArrayList<Pompier>();
						if(nb_pompier_dispo>nb_pompier_to_send) {
							for(int i = 0; i < nb_pompier_to_send; i++) {
							    if(inc.getCriticite()>7) {
							    	if(closest_casern.getPompiers().get(i).getAnneeExperience()>=3) {
							    		pompierToSend.add(closest_casern.getPompiers().get(i));
							    	}
							    }
							    else {
							    	pompierToSend.add(closest_casern.getPompiers().get(i));
							    }
							}
						}
						else {
							for(int i = 0; i < nb_pompier_dispo; i++) {
								pompierToSend.add(closest_casern.getPompiers().get(i));

							}
						}
						System.out.println("Number of pompier to send :"+nb_pompier_to_send);
						for(Pompier p :pompierToSend) {
							System.out.println("    "+p);
						}
						if(pompierToSend.isEmpty()) {
							System.out.println("Not enough pompier to be send in this casern ");
							continue;
						}
						closest_casern.getPompiers().removeAll(pompierToSend);
						closest_casern.getVehicules().remove(v);
						DatabaseDriver.InsertPompierVehiculeIncident(pompierToSend,v,inc);
						Runnable r = new MoveVehiculeToIncidentAndComeBackRunnable(v,inc,closest_casern);
						new Thread(r).start();
						break;
					}else {
						System.out.println("Failed to find vehicule with right product type in casern "+closest_casern);
					}
					
				}else if(inc.getId_type()==8) {
					Vehicule v = pickVehiculeArretCardiaque(closest_casern);
					if(v!=null) {
						ArrayList<Pompier> pompierToSend = new ArrayList<Pompier>();
						for(int i = 0; i < closest_casern.getPompiers().size(); i++) {
							if(i==2) {
								break;
							}
							pompierToSend.add(closest_casern.getPompiers().get(i));
						}
						if(pompierToSend.isEmpty()) {
							System.out.println("Not enough pompier to be send in this casern ");
							continue;
						}
						closest_casern.getPompiers().removeAll(pompierToSend);
						closest_casern.getVehicules().remove(v);
						DatabaseDriver.InsertPompierVehiculeIncident(pompierToSend,v,inc);
						Runnable r = new MoveVehiculeToIncidentAndComeBackRunnable(v,inc,closest_casern);
						new Thread(r).start();
						break;
					}
					
				}
			}

		}
		
	}
	
	
	private Vehicule pickVehiculeWithAddaptedProduct(Caserne c ,int id_type,int criticite) {
		//Peut être éteint avec tout types de produit
		if(id_type==TypeIncidentEnum.TypeIncidentEnumToId(TypeIncidentEnum.FEU_A) || id_type==TypeIncidentEnum.TypeIncidentEnumToId(TypeIncidentEnum.FEU_F)) {
			if(criticite>7) {
				for(Vehicule v : c.getVehicules()) {
					if(v.getCapacite_personne()>=5) {
						return v;
					}
				}
			}else {
				if(!c.getVehicules().isEmpty()) {
					return c.getVehicules().get(0);
				}
			}
		
		}// Extincteur a CO2 ou a mousse
		else if(id_type==TypeIncidentEnum.TypeIncidentEnumToId(TypeIncidentEnum.FEU_B)) {
			if(criticite>7) {
				for(Vehicule v : c.getVehicules()) {
					if(v.getCapacite_personne()>=5 && ( v.containTypeProduit(2)  || v.containTypeProduit(3)  )) {
						return v;
					}
				}
			}else {
				for(Vehicule v : c.getVehicules()) {
					if(( v.containTypeProduit(2)  || v.containTypeProduit(3)  )) {
						return v;
					}
				}
			}
		}//Seulement a poudre
		else if(id_type==TypeIncidentEnum.TypeIncidentEnumToId(TypeIncidentEnum.FEU_C) || id_type==TypeIncidentEnum.TypeIncidentEnumToId(TypeIncidentEnum.FEU_D) ) {
			if(criticite>7) {
				for(Vehicule v : c.getVehicules()) {
					if(v.getCapacite_personne()>=5 && ( v.containTypeProduit(1))) {
						return v;
					}
				}
			}else {
				for(Vehicule v : c.getVehicules()) {
					if(( v.containTypeProduit(1) )) {
						return v;
					}
				}
			}
		}
		return null;
	}
	
	private Vehicule pickVehiculeArretCardiaque(Caserne c) {
		if(c.getVehicules().isEmpty()) {
			return null;
		}else {
			Vehicule vToSend = c.getVehicules().get(0);
			for(Vehicule v : c.getVehicules()) {
				if(v.getCapacite_personne()<vToSend.getCapacite_personne()) {
					vToSend=v;
				}
			}
			return vToSend;
		}
		
	}
	

	/**
	 * Calculate distance between two points in latitude and longitude taking
	 * into account height difference. If you are not interested in height
	 * difference pass 0.0. Uses Haversine method as its base.
	 * 
	 * lat1, lon1 Start point lat2, lon2 End point el1 Start altitude in meters
	 * el2 End altitude in meters
	 * @returns Distance in Meters
	 */
	public static double distance(double lat1, double lat2, double lon1,
	        double lon2, double el1, double el2) {

	    final int R = 6371; // Radius of the earth

	    double latDistance = Math.toRadians(lat2 - lat1);
	    double lonDistance = Math.toRadians(lon2 - lon1);
	    double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
	            + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
	            * Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
	    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
	    double distance = R * c * 1000; // convert to meters

	    double height = el1 - el2;

	    distance = Math.pow(distance, 2) + Math.pow(height, 2);

	    return Math.sqrt(distance);
	}
	
	public class MoveVehiculeToIncidentAndComeBackRunnable implements Runnable {
		private Vehicule vehicule ;
		private Incident incident;
		private Caserne caserne;
		private static String mapbox_token="pk.eyJ1IjoiZmxvbW9uMzciLCJhIjoiY2tuaXY3NGcxMHJ1NzJucGd1OG1sZjM4YyJ9.tskhT43HR7bWJgsMgxoemA";
		
		public MoveVehiculeToIncidentAndComeBackRunnable(Vehicule v,Incident inc,Caserne c ) {
		       this.vehicule=v;
		       this.incident=inc;
		       this.caserne=c;
		}
		public void run() {
			System.out.println("Move Thread Started for incident="+this.incident+",vehicule_id="+this.vehicule);
			try {
				String coord_string = String.format("%f|%f;%f|%f", vehicule.getLongitude(),vehicule.getLatitude(),
						incident.getLongitude(),incident.getLatitude());
				coord_string=coord_string.replace(",", ".");
				coord_string=coord_string.replace("|", ",");
				String url_string = String.format("https://api.mapbox.com/directions/v5/mapbox/driving/%s?geometries=geojson&access_token=%s",
						coord_string,MoveVehiculeToIncidentAndComeBackRunnable.mapbox_token);  
				System.out.println("Request:"+url_string);
				HttpRequest request = HttpRequest.newBuilder()
						.uri(new URI(url_string))
						.GET()
						.build();
				HttpClient client = HttpClient.newHttpClient();
				try {
					HttpResponse<String> rep = client.send(request, BodyHandlers.ofString());
					//System.out.println(rep);
					System.out.println(rep.body());
					JSONArray array = new JSONArray("["+rep.body()+"]");  
					JSONObject object = array.getJSONObject(0);  
					JSONArray coordinatesArray = object.getJSONArray("routes").getJSONObject(0).getJSONObject("geometry").getJSONArray("coordinates");
					System.out.println(coordinatesArray);
					DatabaseDriver.insertIntoCapteurToReset(this.incident);
					for(int i=0; i < coordinatesArray.length(); i++)   
					{ 
						BigDecimal longitude = coordinatesArray.getJSONArray(i).getBigDecimal(0);
						BigDecimal latitude = coordinatesArray.getJSONArray(i).getBigDecimal(1);
						//System.out.println("longitude="+longitude+",latitude="+latitude);
						DatabaseDriver.moveVehicule(vehicule.getId(),longitude,latitude);
						System.out.println("Vehicule "+vehicule.getId()+" moved to longitude="+longitude+",latitude="+latitude);
						Thread.sleep(2000);
					}
					DatabaseDriver.deleteIncidentAndUpdateEndDate(this.incident.getId());
					for(int i=coordinatesArray.length()-1; i >=0; i--)   
					{ 
						BigDecimal longitude = coordinatesArray.getJSONArray(i).getBigDecimal(0);
						BigDecimal latitude = coordinatesArray.getJSONArray(i).getBigDecimal(1);
						//System.out.println("longitude="+longitude+",latitude="+latitude);
						DatabaseDriver.moveVehicule(vehicule.getId(),longitude,latitude);
						System.out.println("Vehicule "+vehicule.getId()+" moved to longitude="+longitude+",latitude="+latitude);
						Thread.sleep(2000);
					}
					DatabaseDriver.moveVehicule(vehicule.getId(),BigDecimal.valueOf(this.caserne.getLongitude()),BigDecimal.valueOf(this.caserne.getLatidude()));
					System.out.println("Vehicule "+vehicule.getId()+" finished moving");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			} catch (URISyntaxException e) {
				System.out.println("Failed to resolve URL "+e);
			}
		}
	}
	
	

}
