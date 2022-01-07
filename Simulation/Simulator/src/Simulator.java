import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Scanner;

import org.json.JSONObject;

import api.ServerApi;
import models.Sensor;

public class Simulator {
	public static void main(String[] args) {

		ServerApi serverApi = new ServerApi();
		
		try 
		{
			// Récupération des capteurs
			ArrayList<Sensor> sensors = serverApi.getSensors("capteur");
			
			Scanner reader = new Scanner(System.in);
			System.out.println("Selectionner le mode de fonctionnement du simulateur : Automatique (1) / Manuel (2)");
			int n = reader.nextInt();
			switch(n)
			{
				case 1:
				{
					// Simulation d'un incendie
					for(int i = 0; i <3; i++) {
						//Feu allumé
						Sensor sensorRandom = sensors.get((int)(Math.random() * sensors.size()));
						sensorRandom.DetectFire();
						System.out.println("Sensor random : " + sensorRandom.ToJson());
						serverApi.post("sensor", sensorRandom.ToJson());
						
						Thread.sleep(5000);
						
//						//Feu éteint
//						sensorRandom.DetectNothing();
//						serverApi.post("capteur", sensorRandom.ToJson());
						reader.close();

					}
					break;
				}
				case 2:
				{
					while(true)
					{
						System.out.println("Affichage des capteurs");
						for(int i=0;i<sensors.size();i++)
						{
							System.out.println(sensors.get(i).toString());
						}
						System.out.println("Entrer l'id du capteur a simuler");
						int id = reader.nextInt();
						System.out.println("Entrer l'intensit� de feu");
						int val = reader.nextInt();
						JSONObject json = new JSONObject();
						json.put("valeur", val);
						DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
					    LocalDateTime now = LocalDateTime.now();  
						json.put("date", now);
						json.put("id", id);
						serverApi.post("capteur_donnees", json.toString());
						sensors = serverApi.getSensors("capteur");
						Thread.sleep(1000);
					}
				}	
				default:
				{
					System.out.println("Erreur de saisie");
				}
			}
		} 
		catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}