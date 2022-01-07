package models;

import java.util.ArrayList;
import java.util.Random;
import java.lang.*;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

public class Sensor {
	
	public int id;
	public int idModele;
	public String modele;
	public String code;
	public float longitude;
	public float latitude;
	public int ligne;
	public int colonne;
	public String valeur;
	
	public static final int valeurMin = 1;
	public static final int valeurMax = 9;
	
	public static ArrayList<Sensor> sensors;

	
	public Sensor(int id,int idModele, String modele, String code, float longitude, float latitude, int ligne, int colonne, String valeur) {
		this.id = id;
		this.idModele = idModele;
		this.modele = modele;
		this.code = code;
		this.longitude = longitude;
		this.latitude = latitude;
		this.ligne = ligne;
		this.colonne = colonne;
		this.valeur = valeur;
	}
	
	public Sensor(int id, String code, float longitude, float latitude,  String valeur) {
		this.id = id;
		this.code = code;
		this.longitude = longitude;
		this.latitude = latitude;
		this.valeur = valeur;
	}
	
	public Sensor(int id,int idModele) {
		this.id = id;
		this.idModele = idModele;
	}
	
	
	public void DetectFire() {
		// int aléatoire compris dans [0,9]
		/*if (this.typeId == Type.INTENSITY.valeur) {			
			this.valeur = new Random().nextInt(Sensor.valeurMax - Sensor.valeurMin + 1) + Sensor.valeurMin;
		}*/
	}
	
	public void DetectNothing() {
		this.valeur = "0";
	}
	
	public String ToJson() {
		ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
		try {
			return ow.writeValueAsString(this);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public String toString()
	{
		return "Capteur id :" + id + " modele :" + modele + " longitude :" + longitude + " latitude :" + latitude + " valeur :" + valeur;
	}
}
