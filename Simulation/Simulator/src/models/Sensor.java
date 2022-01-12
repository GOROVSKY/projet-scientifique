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
	public int idTypeCapteur;
	public String modele;
	public String typeCapteur;
	public String code;
	public float longitude;
	public float latitude;
	public int ligne;
	public int colonne;
	public String valeur;
	
	public static final int valeurMin = 1;
	public static final int valeurMax = 9;
	
	public static ArrayList<Sensor> sensors;

	
	public Sensor(int id,int idModele,int idTypeCapteur, String modele,String typeCapteur, String code, float longitude, float latitude, int ligne, int colonne, String valeur) {
		this.id = id;
		this.idModele = idModele;
		this.idTypeCapteur=idTypeCapteur;
		this.modele = modele;
		this.typeCapteur = typeCapteur;
		this.code = code;
		this.longitude = longitude;
		this.latitude = latitude;
		this.ligne = ligne;
		this.colonne = colonne;
		this.valeur = valeur;
	}

	
	public Sensor(int id,int idTypeCapteur) {
		this.id = id;
		this.idTypeCapteur = idTypeCapteur;
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
		return "Capteur id :" + id +" | type capteur : " + typeCapteur +
				" | id type capteur :" + idTypeCapteur +" | modele : " + modele +
				" | valeur : " + valeur;
	}
}
