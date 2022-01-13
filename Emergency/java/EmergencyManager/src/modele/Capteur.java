package modele;

public class Capteur {
	
	private int id;
	private int id_modele;
	private String code;
	private float longitude;
	private float latitude;

	public Capteur(int id, int id_modele, String code, float longitude, float latitude) {
		super();
		this.id = id;
		this.id_modele = id_modele;
		this.code = code;
		this.longitude = longitude;
		this.latitude = latitude;
	}
	
	
	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getId_modele() {
		return id_modele;
	}


	public void setId_modele(int id_modele) {
		this.id_modele = id_modele;
	}


	public String getCode() {
		return code;
	}


	public void setCode(String code) {
		this.code = code;
	}


	public float getLongitude() {
		return longitude;
	}


	public void setLongitude(float longitude) {
		this.longitude = longitude;
	}


	public float getLatitude() {
		return latitude;
	}


	public void setLatitude(float latitude) {
		this.latitude = latitude;
	}

	public String toString() {
		return String.format("ID=%d,MODELE=%d,CODE=%s,LONG=%f,LAT=%f",this.getId(),this.getId_modele(),this.getCode(),this.getLongitude(),this.getLatitude());  
	}
}
