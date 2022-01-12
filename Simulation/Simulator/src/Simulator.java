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
			while(true)
			{
				// Récupération des capteurs
				ArrayList<Sensor> sensors = serverApi.getSensors("capteur");
				
				Scanner reader = new Scanner(System.in);

				System.out.println("Affichage des capteurs");
				for(int i=0;i<sensors.size();i++)
				{
					System.out.println(sensors.get(i).toString());
				}
				System.out.println("Entrer l'id du capteur a simuler");
				int id = reader.nextInt();
				System.out.println("Entrer l'id type du capteur");
				int idT = reader.nextInt();
				System.out.println("Entrer la valeur du capteur");
				int val = reader.nextInt();
				JSONObject json = new JSONObject();
				json.put("valeur", val);
				DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
			    LocalDateTime now = LocalDateTime.now();  
				json.put("date", now);
				json.put("id", id);
				json.put("idTypeCapteur", idT);
				serverApi.post("capteur_donnees", json.toString());
				sensors = serverApi.getSensors("capteur");
				Thread.sleep(1000);
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