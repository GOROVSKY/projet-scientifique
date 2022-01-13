package modele;

import java.util.ArrayList;
import java.util.List;

public class Caserne {

	private int id;
	private String nom;
	private String addresse;
	private String code_postal;
	private String telephone;
	private String ville;
	private float longitude;
	private float latidude;
	private List<Vehicule> vehicules;
	private List<Pompier> pompiers;
	
	
	public Caserne(int id, String nom, String addresse, String code_postal, String telephone, String ville,
			float longitude, float latidude) {
		super();
		this.id = id;
		this.nom = nom;
		this.addresse = addresse;
		this.code_postal = code_postal;
		this.telephone = telephone;
		this.ville = ville;
		this.longitude = longitude;
		this.latidude = latidude;
		this.vehicules = new ArrayList<Vehicule>();
		this.pompiers = new ArrayList<Pompier>();
	}
	
	public void addPompier(Pompier p) {
		this.pompiers.add(p);
	}
	
	
	public List<Vehicule> getVehicules() {
		return vehicules;
	}

	public List<Pompier> getPompiers() {
		return pompiers;
	}

	public void addVehicules(Vehicule v) {
		this.vehicules.add(v);
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getAddresse() {
		return addresse;
	}
	public void setAddresse(String addresse) {
		this.addresse = addresse;
	}
	public String getCode_postal() {
		return code_postal;
	}
	public void setCode_postal(String code_postal) {
		this.code_postal = code_postal;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getVille() {
		return ville;
	}
	public void setVille(String ville) {
		this.ville = ville;
	}
	public float getLongitude() {
		return longitude;
	}
	public void setLongitude(float longitude) {
		this.longitude = longitude;
	}
	public float getLatidude() {
		return latidude;
	}
	public void setLatidude(float latidude) {
		this.latidude = latidude;
	}

	@Override
	public String toString() {
		return "Caserne [id=" + id + ", nom=" + nom + ", addresse=" + addresse + ", code_postal=" + code_postal
				+ ", telephone=" + telephone + ", ville=" + ville + ", longitude=" + longitude + ", latidude="
				+ latidude + "]";
	}
	
	
	
}
