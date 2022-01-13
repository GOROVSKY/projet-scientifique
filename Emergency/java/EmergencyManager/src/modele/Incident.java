package modele;

import java.util.Date;

public class Incident {

	private int id;
	private Date date_debut;
	private Date date_fin ;
	private int id_type;
	private float longitude;
	private float latitude;
	private int criticite;
	
	
	
	public Incident(int id, Date date_debut, Date date_fin, int id_type, float longitude, float latitude,
			int criticite) {
		super();
		this.id = id;
		this.date_debut = date_debut;
		this.date_fin = date_fin;
		this.id_type = id_type;
		this.longitude = longitude;
		this.latitude = latitude;
		this.criticite = criticite;
	}
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getDate_debut() {
		return date_debut;
	}
	public void setDate_debut(Date date_debut) {
		this.date_debut = date_debut;
	}
	public Date getDate_fin() {
		return date_fin;
	}
	public void setDate_fin(Date date_fin) {
		this.date_fin = date_fin;
	}
	public int getId_type() {
		return id_type;
	}
	public void setId_type(int id_type) {
		this.id_type = id_type;
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
	public int getCriticite() {
		return criticite;
	}
	public void setCriticite(int criticite) {
		this.criticite = criticite;
	}


	@Override
	public String toString() {
		return "Incident [id=" + id + ", date_debut=" + date_debut + ", date_fin=" + date_fin + ", id_type=" + id_type
				+ ", longitude=" + longitude + ", latitude=" + latitude + ", criticite=" + criticite + "]";
	}
	
	
	
}
