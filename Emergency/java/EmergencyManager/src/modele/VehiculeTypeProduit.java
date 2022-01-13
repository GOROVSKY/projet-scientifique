package modele;

public class VehiculeTypeProduit {

	private int id_vehicule;
	private int id_type_produit;
	
	
	public VehiculeTypeProduit(int id_vehicule, int id_type_produit) {
		super();
		this.id_vehicule = id_vehicule;
		this.id_type_produit = id_type_produit;
	}
	
	public int getId_vehicule() {
		return id_vehicule;
	}
	public void setId_vehicule(int id_vehicule) {
		this.id_vehicule = id_vehicule;
	}
	public int getId_type_produit() {
		return id_type_produit;
	}
	public void setId_type_produit(int id_type_produit) {
		this.id_type_produit = id_type_produit;
	}

	@Override
	public String toString() {
		return "VehiculeTypeProduit [id_vehicule=" + id_vehicule + ", id_type_produit=" + id_type_produit + "]";
	}
	
	
}
