package modele;

public class TypeIncident {

	
	private int id;
	private String libelle;
	
	public TypeIncident(int id, String libelle) {
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
	
	public String toString() {
		return String.format("ID=%d,LIBELLE=%s",this.getId(),this.getLibelle());  
	}
	
	
}
