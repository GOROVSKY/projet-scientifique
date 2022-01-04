import java.io.IOException;
import java.util.ArrayList;

import models.Sensor;

public class Simulator {
	public static void main(String[] args) {

		ServerApi serverApi = new ServerApi();
		
		try {
			// Récupération des capteurs
			ArrayList<Sensor> sensors = serverApi.getSensors("sensors");
			

			// Simulation d'un incendie
			for(int i = 0; i <3; i++) {
				//Feu allumé
				Sensor sensorRandom = sensors.get((int)(Math.random() * sensors.size()));
				sensorRandom.DetectFire();
				System.out.println("Sensor random : " + sensorRandom.ToJson());
				serverApi.post("sensor", sensorRandom.ToJson());
				
				Thread.sleep(5000);
				
//				//Feu éteint
//				sensorRandom.DetectNothing();
//				serverApi.post("sensor", sensorRandom.ToJson());
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}