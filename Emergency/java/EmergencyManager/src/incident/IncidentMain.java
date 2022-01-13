package incident;

import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;


public class IncidentMain {

	public static void main(String args[]) {
		//databaseDriver = new DatabaseDriver();
		
		Timer getDataAndCheckForIncidentTimer = new Timer() ;
		TimerTask task = new IncidentMain.getDataAndCheckForIncidentTimerTask();
		getDataAndCheckForIncidentTimer.scheduleAtFixedRate(task , new Date(), 30000);
		
	}
	
	public static class getDataAndCheckForIncidentTimerTask extends TimerTask {
		  @Override
		  public void run() {
			  IncidentManager incidentManager = new IncidentManager();
			  incidentManager.loadSensors();
			  incidentManager.loadTypeIncident();
//			  System.out.println(incidentManager.getCapteurMap().get(1));
//			  System.out.println(incidentManager.getIncidentMap().get(4));
			  incidentManager.loadSensorData();
			  incidentManager.analyseData();
			  System.out.println("Incident checking finished");
		  }
	}
}
