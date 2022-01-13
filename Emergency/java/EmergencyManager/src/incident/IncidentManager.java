package incident;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import emergency.DatabaseDriver;
import modele.Capteur;
import modele.CapteurDonnees;
import modele.TypeIncident;
import modele.TypeIncidentEnum;

public class IncidentManager {
	
	private  Map<Integer,Capteur> capteurMap;
	private  Map<Integer,TypeIncident> incidentMap;
	private  Map<Capteur,List<CapteurDonnees>> capteurDonnees;
	
	public void loadSensors() {
		setCapteurMap(DatabaseDriver.getAllCapteur());
	}
	
	public void loadTypeIncident() {
		setIncidentMap(DatabaseDriver.getAllTypeIncident());
	}
	
	public void analyseData() {
		for(Capteur c :this.capteurDonnees.keySet()) {
			int nb_occurence_feu = 0;
			int somme_intensite=0;
			int nb_occurence_electro = 0;
			for(CapteurDonnees cd : this.capteurDonnees.get(c)) {
				//Intensité feu
				if(cd.getType_capteur_id() == 1) {
					if(cd.getValue()>3 && cd.getValue()<6 ) {
						nb_occurence_feu+=1;
						somme_intensite+=cd.getValue();
					}else if(cd.getValue()>=6) {
						nb_occurence_feu+=2;
						somme_intensite+=cd.getValue()*2;
					}
				}
				if(cd.getType_capteur_id() == 4) {
					if(cd.getValue()<=20) {
						nb_occurence_electro+=1;
					}
				}
			}
			if(nb_occurence_feu>=3) {
				//int id_type_incident = TypeIncidentEnum.TypeIncidentEnumToId(TypeIncidentEnum.FEU_A);
				int id_type_incident = new Random().nextInt(1,6);//5 MAX
				int criticite = somme_intensite/nb_occurence_feu;
				if(!inDetection(c.getId(),id_type_incident)) {
					int id_incident = createIncident(new Date(),id_type_incident,c.getLongitude(),c.getLatitude(),criticite);
					createDetection(id_incident,c.getId(),id_type_incident);
					System.out.println("CREATING INCIDENT "+TypeIncidentEnum.idToTypeIncidentEnum(id_type_incident)+",CRIT:"+criticite);
				}
			}
			if(nb_occurence_electro>=4) {
				int id_type_incident = TypeIncidentEnum.TypeIncidentEnumToId(TypeIncidentEnum.ARRET_CARDIAQUE);
				int criticite = 7;
				if(!inDetection(c.getId(),id_type_incident)) {
					int id_incident = createIncident(new Date(),id_type_incident,c.getLongitude(),c.getLatitude(),criticite);
					createDetection(id_incident,c.getId(),id_type_incident);
					System.out.println("CREATING INCIDENT "+TypeIncidentEnum.ARRET_CARDIAQUE+",CRIT:"+criticite);
				}
			}
		};
	}
	
	private boolean inDetection(int id, int id_type_incident) {
		return DatabaseDriver.checkIfCapteurHasIncident(id, id_type_incident);
	}

	private void createDetection(int id_incident, int id, int type_incident) {
		DatabaseDriver.InsertDetection(id_incident, id, type_incident);
	}

	private int createIncident(Date date_debut,int id_type_incident,float longitude,float latitude,int criticite) {
		DatabaseDriver.InsertIncident(date_debut,id_type_incident,longitude,latitude,criticite);
		System.out.println("Incident Successfully stored in database");
		return DatabaseDriver.getLastIncidentId();
	}
	
	public void loadSensorData() {
		capteurDonnees=DatabaseDriver.getLast30secCapteurDonnees(getCapteurMap());
		for(Capteur c :this.capteurDonnees.keySet()) {
			for(CapteurDonnees cd : this.capteurDonnees.get(c)) {
				System.out.println(cd);
			}
		};
	}

	public Map<Integer, Capteur> getCapteurMap() {
		return capteurMap;
	}

	public void setCapteurMap(Map<Integer, Capteur> capteurMap) {
		this.capteurMap = capteurMap;
	}

	public Map<Integer, TypeIncident> getIncidentMap() {
		return incidentMap;
	}

	public void setIncidentMap(Map<Integer, TypeIncident> incidentMap) {
		this.incidentMap = incidentMap;
	}
}



