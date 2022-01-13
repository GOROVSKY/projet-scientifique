package emergency;

import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;


public class EmergencyMain {

	public static void main(String args[]) {
		//databaseDriver = new DatabaseDriver();
		
		Timer getIncidentAndSendPompier = new Timer() ;
		TimerTask task = new EmergencyMain.getIncidentAndSendPompierTimerTask();
		getIncidentAndSendPompier.scheduleAtFixedRate(task , new Date(), 40000);
		
	}
	
	public static class getIncidentAndSendPompierTimerTask extends TimerTask {
		  @Override
		  public void run() {
			  EmergencyManager emergencyManager = new EmergencyManager();
			  emergencyManager.loadPompierDisponible();
			  emergencyManager.loadCaserne();
			  emergencyManager.loadVehiculeDisponible();
			  emergencyManager.loadTypeProduit();
			  emergencyManager.ajouterProduitVehicule();
			  emergencyManager.affecterPompierDansCaserne();
			  emergencyManager.affecterVehiculeDansCaserne();
			  
			  emergencyManager.afficherRessourcesDisponibles();
			  emergencyManager.getAndTreatIncident();
		  }
	}
	
}
