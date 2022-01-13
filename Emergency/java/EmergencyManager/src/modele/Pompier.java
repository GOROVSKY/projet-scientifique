package modele;

public class Pompier {
	
	private int id;
	private String nom;
	private String prenom;
	private int age;
	private String telephone;
	private int anneeExperience;
	private int energie;
	private int id_caserne;
	private Caserne caserne;
	
	
	public Pompier(int id,String nom,String prenom,int age,String telephone,
			int anneeExperience,int energie,int id_caserne) {
		this.id=id;
		this.nom=nom;
		this.prenom=prenom;
		this.age=age;
		this.telephone=telephone;
		this.anneeExperience=anneeExperience;
		this.energie=energie;
		this.id_caserne=id_caserne;
		
	}



	public Caserne getCaserne() {
		return caserne;
	}



	public void setCaserne(Caserne caserne) {
		this.caserne = caserne;
	}



	public int getId_caserne() {
		return id_caserne;
	}


	public void setId_caserne(int id_caserne) {
		this.id_caserne = id_caserne;
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



	public String getPrenom() {
		return prenom;
	}



	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}



	public int getAge() {
		return age;
	}



	public void setAge(int age) {
		this.age = age;
	}



	public String getTelephone() {
		return telephone;
	}



	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}



	public int getAnneeExperience() {
		return anneeExperience;
	}



	public void setAnneeExperience(int anneeExperience) {
		this.anneeExperience = anneeExperience;
	}



	public int getEnergie() {
		return energie;
	}



	public void setEnergie(int energie) {
		this.energie = energie;
	}



	@Override
	public String toString() {
		return "Pompier [id=" + id + ", nom=" + nom + ", prenom=" + prenom + ", age=" + age + ", telephone=" + telephone
				+ ", anneeExperience=" + anneeExperience + ", energie=" + energie + ", id_caserne=" + id_caserne
				+ ", caserne=[" + caserne + "]]";
	}

	
	
}
