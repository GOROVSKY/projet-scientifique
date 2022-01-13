package modele;

public enum TypeIncidentEnum {
		  
	   FEU_A,FEU_B,FEU_C,FEU_D,FEU_F,INNONDATION,EBOULEMENT,ARRET_CARDIAQUE; 
	     
		public static int TypeIncidentEnumToId(TypeIncidentEnum typeIncidentEnum) {
			switch(typeIncidentEnum) {
			  case FEU_A:
				  return 1;
			  case FEU_B:
				  return 2;
			  case FEU_C:
				  return 3;
			  case FEU_D:
				  return 4;
			  case FEU_F:
				  return 5;
			  case INNONDATION:
				  return 6;
			  case EBOULEMENT:
				  return 7;
			  case ARRET_CARDIAQUE:
				  return 8;
			  default:
			    return 0;
			}
		}
		
		public static TypeIncidentEnum idToTypeIncidentEnum(int id) {
			switch(id) {
			  case 1:
				  return FEU_A;
			  case 2:
				  return FEU_B;
			  case 3:
				  return FEU_C;
			  case 4:
				  return FEU_D;
			  case 5:
				  return FEU_F;
			  case 6:
				  return INNONDATION;
			  case 7:
				  return EBOULEMENT;
			  case 8:
				  return ARRET_CARDIAQUE;
			  default:
			    return null;
			}

		}
}
