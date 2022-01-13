package emergency;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import modele.Capteur;
import modele.CapteurDonnees;
import modele.Caserne;
import modele.Incident;
import modele.Pompier;
import modele.TypeIncident;
import modele.TypeProduit;
import modele.Vehicule;
import modele.VehiculeTypeProduit;

public class DatabaseDriver {
	
	public static String connexionString = "jdbc:postgresql://192.168.43.144:5432/Emergency";
	public static String user = "postgres";
	public static String password = "pierre";
			
	public static Map<Integer,Capteur> getAllCapteur() {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	         return null;
	      }
	      System.out.println("Opened database successfully");
		try {
			Statement stmt = null;
			stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery( "SELECT * FROM capteur;" );
	        HashMap<Integer,Capteur> capteurMap = new HashMap<Integer,Capteur>();
	        while ( rs.next() ) {
	            int id = rs.getInt("id");
	            String  code = rs.getString("code");
	            float longitude  = rs.getFloat("longitude");
	            float latitude  = rs.getFloat("latitude");
	            int modele_id  = rs.getInt("id_modele");
	            Capteur c = new Capteur(id,modele_id,code,longitude,latitude);
	            capteurMap.put(id, c);
	         }
	         rs.close();
	         stmt.close();
	         conn.close();
	         return capteurMap;
		}catch(Exception e) {
			System.err.println(e.getClass().getName()+": "+e.getMessage());
		}
		return null;
	}
	
	public static Map<Integer,TypeIncident> getAllTypeIncident() {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	         return null;
	      }
	      System.out.println("Opened database successfully");
		try {
			Statement stmt = null;
			stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery( "SELECT * FROM type_incident;" );
	        HashMap<Integer,TypeIncident> incidentMap = new HashMap<Integer,TypeIncident>();
	        while ( rs.next() ) {
	            int id = rs.getInt("id");
	            String  libelle = rs.getString("libelle");
	            TypeIncident ti = new TypeIncident(id,libelle);
	            incidentMap.put(id, ti);
	         }
	         rs.close();
	         stmt.close();
	         conn.close();
	         return incidentMap;
		}catch(Exception e) {
			System.err.println(e.getClass().getName()+": "+e.getMessage());
		}
		return null;
	}
	
	public static Map<Capteur,List<CapteurDonnees>> getLast30secCapteurDonnees(Map<Integer,Capteur> capteurMap) {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	         return null;
	      }
	      System.out.println("Opened database successfully");
		try {
			Statement stmt = null;
			stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery( "SELECT * FROM historique where date>=current_timestamp - INTERVAL '25 second' ;;" );
	        Map<Capteur,List<CapteurDonnees>> allCapteurDonnees = new HashMap<Capteur,List<CapteurDonnees>>();
	        while ( rs.next() ) {
	            int id = rs.getInt("id");
	            int type_capteur_id = rs.getInt("id_type_capteur");
	            int id_capteur  = rs.getInt("id_capteur");
	            int value  = rs.getInt("valeur");
	            Date timestamp = rs.getTimestamp("date");
	            Capteur capteur = capteurMap.get(id_capteur);
	            CapteurDonnees capteur_donnees = new CapteurDonnees(capteur,type_capteur_id,value,timestamp);
	            if(allCapteurDonnees.containsKey(capteur)) {
	            	allCapteurDonnees.get(capteur).add(capteur_donnees);
	            }else {
	            	allCapteurDonnees.put(capteur, new ArrayList<CapteurDonnees>());
	            	allCapteurDonnees.get(capteur).add(capteur_donnees);
	            }
	         }
	         rs.close();
	         stmt.close();
	         conn.close();
	         return allCapteurDonnees;
		}catch(Exception e) {
			System.err.println(e.getClass().getName()+": "+e.getMessage());
		}
		return null;
	}
	
	public static void InsertIncident(Date date_debut,int id_type_incident,float longitude,float latitude,int criticite) {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	         Statement stmt = null;
	         stmt = conn.createStatement();
	         String sql = "INSERT INTO INCIDENT (date_debut,longitude,latitude,criticite,id_type_incident) "
	            + "VALUES ('"+date_debut+"', "+longitude+", "+latitude+", "+criticite+", "+id_type_incident+" );";
	         stmt.executeUpdate(sql);

	         stmt.close();
	         conn.commit();
	         conn.close();
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	      }
	      System.out.println("Opened database successfully");
	}
	
	public static void InsertDetection(int id_incident, int id, int type_incident) {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	         Statement stmt = null;
	         stmt = conn.createStatement();
	         String sql = "INSERT INTO detection (id_incident,id_capteur,id_type_incident) "
	            + "VALUES ("+id_incident+","+id+","+type_incident+");";
	         stmt.executeUpdate(sql);

	         stmt.close();
	         conn.commit();
	         conn.close();
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	      }
	      System.out.println("Opened database successfully");
	}
	
	public static Map<Integer,Pompier> getAllPompierDispo() {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	         return null;
	      }
	      System.out.println("Opened database successfully");
		try {
			Statement stmt = null;
			stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery( "SELECT * FROM pompier where (pompier.id not in (select id_pompier from pompier_incident)) or (pompier.id in (select id_pompier from pompier_incident where date_fin is not NULL ));" );
	        HashMap<Integer,Pompier> pompierMap = new HashMap<Integer,Pompier>();
	        while ( rs.next() ) {
	            int id = rs.getInt("id");
	            String  nom = rs.getString("nom");
	            String  prenom = rs.getString("prenom");
	            int age  = rs.getInt("age");
	            String tel  = rs.getString("tel");
	            int id_caserne  = rs.getInt("id_caserne");
	            int experience  = rs.getInt("annees_experience");
	            int energie  = rs.getInt("energie");
	            Pompier p = new Pompier(id,nom,prenom,age,tel,experience,energie,id_caserne);
	            pompierMap.put(id, p);
	         }
	         rs.close();
	         stmt.close();
	         conn.close();
	         return pompierMap;
		}catch(Exception e) {
			System.err.println(e.getClass().getName()+": "+e.getMessage());
		}
		return null;
	}
	
	public static Map<Integer,TypeProduit> getAllTypeProduit() {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	         return null;
	      }
	      System.out.println("Opened database successfully");
		try {
			Statement stmt = null;
			stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery( "SELECT * FROM type_produit;" );
	        HashMap<Integer,TypeProduit> typeProduitMap = new HashMap<Integer,TypeProduit>();
	        while ( rs.next() ) {
	            int id = rs.getInt("id");
	            String  libelle = rs.getString("libelle");
	            TypeProduit tp = new TypeProduit(id,libelle);
	            typeProduitMap.put(id, tp);
	         }
	         rs.close();
	         stmt.close();
	         conn.close();
	         return typeProduitMap;
		}catch(Exception e) {
			System.err.println(e.getClass().getName()+": "+e.getMessage());
		}
		return null;
	}
	
	public static List<VehiculeTypeProduit> getAllVehiculeTypeProduit() {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	         return null;
	      }
	      System.out.println("Opened database successfully");
		try {
			Statement stmt = null;
			stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery( "SELECT * FROM vehicule_type_produit;" );
	        ArrayList<VehiculeTypeProduit> typeProduitVehiculeList = new ArrayList<VehiculeTypeProduit>();
	        while ( rs.next() ) {
	            int id_vehicule = rs.getInt("id_vehicule");
	            int id_type_produit = rs.getInt("id_type_produit");
	            VehiculeTypeProduit vtp = new VehiculeTypeProduit(id_vehicule,id_type_produit);
	            typeProduitVehiculeList.add(vtp);
	         }
	         rs.close();
	         stmt.close();
	         conn.close();
	         return typeProduitVehiculeList;
		}catch(Exception e) {
			System.err.println(e.getClass().getName()+": "+e.getMessage());
		}
		return null;
	}
	
	public static Map<Integer,Vehicule> getAllVehiculeDispo() {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	         return null;
	      }
	      System.out.println("Opened database successfully");
		try {
			Statement stmt = null;
			stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery( "SELECT * FROM vehicule where (vehicule.id not in (select id_vehicule from vehicule_incident)) or (vehicule.id in (select id_vehicule from vehicule_incident where date_fin is not NULL ));" );
	        HashMap<Integer,Vehicule> vehiculeMap = new HashMap<Integer,Vehicule>();
	        while ( rs.next() ) {
	            int id = rs.getInt("id");
	            String  modele = rs.getString("modele");
	            String  immatriculation = rs.getString("modele");
	            int capacite_produit = rs.getInt("capacite_produit");
	            int capacite_personne = rs.getInt("capacite_personne");
	            float longitude = rs.getFloat("longitude");
	            float latitude = rs.getFloat("latitude");
	            int id_caserne = rs.getInt("id_caserne");
	            Vehicule veh = new Vehicule(id,modele,immatriculation,capacite_personne,capacite_produit,longitude,latitude,id_caserne);
	            vehiculeMap.put(id, veh);
	         }
	         rs.close();
	         stmt.close();
	         conn.close();
	         return vehiculeMap;
		}catch(Exception e) {
			System.err.println(e.getClass().getName()+": "+e.getMessage());
		}
		return null;
	}
	
	public static Map<Integer,Caserne> getAllCaserne() {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	         return null;
	      }
	      System.out.println("Opened database successfully");
		try {
			Statement stmt = null;
			stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery( "SELECT * FROM caserne;" );
	        HashMap<Integer,Caserne> caserneMap = new HashMap<Integer,Caserne>();
	        while ( rs.next() ) {
	            int id = rs.getInt("id");
	            String  nom = rs.getString("nom");
	            String  adresse = rs.getString("adresse");
	            String  code_postal = rs.getString("code_postal");
	            String  ville = rs.getString("ville");
	            String  tel = rs.getString("tel");
	            float longitude = rs.getFloat("longitude");
	            float latitude = rs.getFloat("latitude");
	            Caserne cas = new Caserne(id,nom,adresse,code_postal,tel,ville,longitude,latitude);
	            caserneMap.put(id, cas);
	         }
	         rs.close();
	         stmt.close();
	         conn.close();
	         return caserneMap;
		}catch(Exception e) {
			System.err.println(e.getClass().getName()+": "+e.getMessage());
		}
		return null;
	}
	
	
	public static List<Incident> getIncidentNotTreated(){
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	         return null;
	      }
	      System.out.println("Opened database successfully");
		try {
			Statement stmt = null;
			stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery( "SELECT * from incident where incident.date_fin is NULL and incident.id not IN ("
	        		+ "SELECT id_incident from vehicule_incident where vehicule_incident.date_fin is NULL);" );
	        ArrayList<Incident> incidentNotTreatedList = new ArrayList<Incident>();
	        while ( rs.next() ) {
	            int id = rs.getInt("id");
	            int id_type_incident = rs.getInt("id_type_incident");
	            int criticite = rs.getInt("criticite");
	            Date date_debut = rs.getTimestamp("date_debut");
	            Date date_fin = rs.getTimestamp("date_fin");
	            float longitude = rs.getFloat("longitude");
	            float latitude = rs.getFloat("latitude");
	            Incident inc = new Incident(id,date_debut,date_fin,id_type_incident,longitude,latitude,criticite);
	            incidentNotTreatedList.add(inc);
	         }
	         rs.close();
	         stmt.close();
	         conn.close();
	         return incidentNotTreatedList;
		}catch(Exception e) {
			System.err.println(e.getClass().getName()+": "+e.getMessage());
		}
		return null;
		
	}

	public static void InsertPompierVehiculeIncident(ArrayList<Pompier> pompierToSend, Vehicule v, Incident inc) {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	         Statement stmt = null;
	         stmt = conn.createStatement();
	         
	         for(Pompier p : pompierToSend) {
	        	 String sql = "INSERT INTO pompier_incident (id_pompier,id_incident,date_debut) "
	     	            + "VALUES ( "+p.getId()+","+inc.getId()+",'"+new Date()+"' );";
	     	     stmt.executeUpdate(sql);
	         }
	         
	         String sql = "INSERT INTO vehicule_incident (id_vehicule,id_incident,date_debut) "
	     	            + "VALUES ( "+v.getId()+","+inc.getId()+",'"+new Date()+"' );";
	     	 stmt.executeUpdate(sql);
	         
	         stmt.close();
	         conn.commit();
	         conn.close();
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	      }
	      System.out.println("Inserted Pompier Incident in Database");
		
	}

	public static int getLastIncidentId() {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	         return 0;
	      }
	      System.out.println("Opened database successfully");
		try {
			Statement stmt = null;
			stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery("SELECT id FROM incident order by id desc limit 1;" );
	        int id = 0;
	        while ( rs.next() ) {
	            id = rs.getInt("id");
	         }
	         rs.close();
	         stmt.close();
	         conn.close();
	         return id;
		}catch(Exception e) {
			System.err.println(e.getClass().getName()+": "+e.getMessage());
		}
		return 0;
	}

	public static boolean checkIfCapteurHasIncident(int id, int id_type_incident) {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	         return true;
	      }
	      System.out.println("Opened database successfully");
		try {
			boolean ret = true;
			Statement stmt = null;
			stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery("SELECT * FROM detection,incident where id_capteur="+id+" and detection.id_incident=incident.id \r\n"
	        		+ "and incident.date_fin is NULL; " );
	        if (!rs.isBeforeFirst() ) {    
	            //System.out.println("No data");
	        	System.out.println("Capteur has no incident "+id+",id_type_incident="+id_type_incident);
	            ret=false;
	        } 
	        rs.close();
	        stmt.close();
	        conn.close();
	        if(ret) {
	        	System.out.println("Capteur already has incident "+id+",id_type_incident="+id_type_incident);
	        }
	        return ret;
		}catch(Exception e) {
			System.err.println(e.getClass().getName()+": "+e.getMessage());
		}
		return true;
		
	}
	
	
	public static void moveVehicule(int vehicule_id, BigDecimal longitude, BigDecimal latitude) {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	      }
	      System.out.println("Opened database successfully");
		try {
			String sql = "UPDATE vehicule set longitude=?,latitude=? where id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
	        pstmt.setBigDecimal(1, longitude);
	        pstmt.setBigDecimal(2, latitude);
	        pstmt.setInt(3, vehicule_id);
	        pstmt.executeUpdate();
	        pstmt.close();
	        conn.commit();
	        conn.close();
		}catch(Exception e) {
			System.err.println(e.getClass().getName()+": "+e.getMessage());
		}

	}

	public static void deleteIncidentAndUpdateEndDate(int incident_id) {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	      }
	      System.out.println("Opened database successfully");
		try {
			Date date = new Date();
			Timestamp date_fin = new Timestamp(date.getTime());
			String sql = "update pompier_incident set date_fin=? where id_incident=? ";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setTimestamp(1, date_fin);
			pstmt.setInt(2, incident_id);
			pstmt.executeUpdate();

			sql = "update vehicule_incident set date_fin=? where id_incident=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setTimestamp(1, date_fin);
			pstmt.setInt(2, incident_id);
			pstmt.executeUpdate();
			
			
			sql = "update incident set date_fin=? where id=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setTimestamp(1, date_fin);
			pstmt.setInt(2, incident_id);
			pstmt.executeUpdate();
			
			
	        pstmt.close();
	        conn.commit();
	        conn.close();
		}catch(Exception e) {
			System.err.println(e.getClass().getName()+": "+e.getMessage());
		}
		
	}

	public static void insertIntoCapteurToReset(Incident incident) {
		Connection conn = null;
		try {
	         Class.forName("org.postgresql.Driver");
	         conn = DriverManager.getConnection(connexionString,user,password);
	         conn.setAutoCommit(false);
	      } catch (Exception e) {
	         System.err.println(e.getClass().getName()+": "+e.getMessage());
	      }
		try {
			Statement stmt = null;
			stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery( "SELECT * from detection where id_incident="+incident.getId()+";" );
	        int capteur_id = 0;
	        while ( rs.next() ) {
	            capteur_id = rs.getInt("id_capteur");
	        }
	        rs.close();
	        stmt.close();
	        
	        String sql = "INSERT into capteur_reset values (?,?)";
	        PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, capteur_id);
			if(incident.getId_type()<=5) {
				pstmt.setInt(2, 1);
			}else if(incident.getId_type()==8) {
				pstmt.setInt(2, 4);
			}
			pstmt.executeUpdate();
	        pstmt.close();
	        conn.commit();
	        conn.close();
		}catch(Exception e) {
			System.err.println(e.getClass().getName()+": "+e.getMessage());
		}
		
	}
	
}
