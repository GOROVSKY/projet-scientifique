package modele;

public class TypeCapteur {

	private int id;
	private String libelle;
	
	
	public TypeCapteur(int id, String libelle) {
		super();
		this.id = id;
		this.libelle = libelle;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getLibelle() {
		return libelle;
	}
	
	public void setLibelle(String libelle) {
		this.libelle = libelle;
	}

	
	
}
