package modele;

import java.util.ArrayList;
import java.util.List;

public class Vehicule {

	private int id;
	private String modele;
	private String immatriculation;
	private int capacite_personne;
	private int capacite_produit;
	private float longitude;
	private float latitude;
	private List<TypeProduit> typesProduits;
	private int caserne_id;
	private Caserne caserne;
	
	public Vehicule(int id, String modele, String immatriculation, int capacite_personne, int capacite_produit,
			float longitude, float latitude,int caserne_id) {
		super();
		this.id = id;
		this.modele = modele;
		this.immatriculation = immatriculation;
		this.capacite_personne = capacite_personne;
		this.capacite_produit = capacite_produit;
		this.longitude = longitude;
		this.latitude = latitude;
		this.caserne_id=caserne_id;
		this.typesProduits=new ArrayList<TypeProduit>();
	}
	
	
	
	public int getCaserne_id() {
		return caserne_id;
	}



	public void setCaserne_id(int caserne_id) {
		this.caserne_id = caserne_id;
	}



	public Caserne getCaserne() {
		return caserne;
	}

	public void setCaserne(Caserne caserne) {
		this.caserne = caserne;
	}

	public List<TypeProduit> getTypesProduits(){
		return typesProduits;
	}
	
	public boolean containTypeProduit(int type_produit_id) {
		boolean ret = false;
		for(TypeProduit tp : this.getTypesProduits()) {
			if(tp.getId()==type_produit_id) {
				ret=true;
				return ret;
			}
		}
		return ret;
	}
	
	public void addTypeProduit(TypeProduit tp) {
		this.typesProduits.add(tp);
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getModele() {
		return modele;
	}
	public void setModele(String modele) {
		this.modele = modele;
	}
	public String getImmatriculation() {
		return immatriculation;
	}
	public void setImmatriculation(String immatriculation) {
		this.immatriculation = immatriculation;
	}
	public int getCapacite_personne() {
		return capacite_personne;
	}
	public void setCapacite_personne(int capacite_personne) {
		this.capacite_personne = capacite_personne;
	}
	public int getCapacite_produit() {
		return capacite_produit;
	}
	public void setCapacite_produit(int capacite_produit) {
		this.capacite_produit = capacite_produit;
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



	@Override
	public String toString() {
		return "Vehicule [id=" + id + ", modele=" + modele + ", immatriculation=" + immatriculation
				+ ", capacite_personne=" + capacite_personne + ", capacite_produit=" + capacite_produit + ", longitude="
				+ longitude + ", latitude=" + latitude + ", typesProduits=[" + typesProduits + "], caserne_id="
				+ caserne_id + ", caserne=" + caserne + "]";
	}
	
	
}
