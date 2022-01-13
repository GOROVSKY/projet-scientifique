package modele;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CapteurDonnees {
	
	private Capteur capteur;
	private int value;
	private Date timestamp;
	private int type_capteur_id;
	private static DateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");  
	public CapteurDonnees(Capteur capteur,int type_capteur_id, int value, Date timestamp) {
		super();
		this.capteur = capteur;
		this.value = value;
		this.timestamp = timestamp;
		this.type_capteur_id=type_capteur_id;
	}
	
	public int getType_capteur_id() {
		return type_capteur_id;
	}

	public void setType_capteur_id(int type_capteur_id) {
		this.type_capteur_id = type_capteur_id;
	}

	public Capteur getCapteur() {
		return capteur;
	}
	public void setCapteur(Capteur capteur) {
		this.capteur = capteur;
	}
	public int getValue() {
		return value;
	}
	public void setValue(int value) {
		this.value = value;
	}
	public Date getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}
	
	public String toString() {
	    String strDate = dateFormat.format(timestamp);
		return String.format("Capteur{%s},TYPE=%d,VALUE=%s,DATE=%s",this.capteur,this.type_capteur_id,this.getValue(),strDate);  
	}

}
