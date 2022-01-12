DELETE FROM historique;
DELETE FROM modele_type_capteur;
DELETE FROM type_capteur;
DELETE FROM capteur;
DELETE FROM modele_capteur;
DELETE FROM pompier_incident;
DELETE FROM vehicule_incident;
DELETE FROM pompier;
DELETE FROM vehicule_type_produit;
DELETE FROM type_produit;
DELETE FROM vehicule;
DELETE FROM caserne;
DELETE FROM incident;
DELETE FROM type_incident;
DELETE FROM detection;
DELETE FROM capteur_reset;

INSERT INTO type_capteur (id, libelle) OVERRIDING SYSTEM VALUE VALUES (1, 'Intensité feu');
INSERT INTO type_capteur (id, libelle) OVERRIDING SYSTEM VALUE VALUES (2, 'Niveau d''eau');
INSERT INTO type_capteur (id, libelle) OVERRIDING SYSTEM VALUE VALUES (3, 'Pression rocheuse');
INSERT INTO type_capteur (id, libelle) OVERRIDING SYSTEM VALUE VALUES (4, 'Electrocardiogramme');
INSERT INTO type_capteur (id, libelle) OVERRIDING SYSTEM VALUE VALUES (5, 'Fummée');

INSERT INTO type_incident (id,libelle) OVERRIDING SYSTEM VALUE VALUES (1,'FEU CLASSE A');
INSERT INTO type_incident (id,libelle) OVERRIDING SYSTEM VALUE VALUES (2,'FEU CLASSE B');
INSERT INTO type_incident (id,libelle) OVERRIDING SYSTEM VALUE VALUES (3,'FEU CLASSE C');
INSERT INTO type_incident (id,libelle) OVERRIDING SYSTEM VALUE VALUES (4,'FEU CLASSE D');
INSERT INTO type_incident (id,libelle) OVERRIDING SYSTEM VALUE VALUES (5,'FEU CLASSE F');
INSERT INTO type_incident (id,libelle) OVERRIDING SYSTEM VALUE VALUES (6,'INNONDATION');
INSERT INTO type_incident (id,libelle) OVERRIDING SYSTEM VALUE VALUES (7,'EBOULEMENT');
INSERT INTO type_incident (id,libelle) OVERRIDING SYSTEM VALUE VALUES (8,'ARRET CARDIAQUE');

INSERT INTO public.modele_capteur OVERRIDING SYSTEM VALUE VALUES (1, 'Modèle feu');

INSERT INTO public.modele_type_capteur (id_modele_capteur, id_type_capteur) VALUES (1, 1);

INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (48, 'Capteur48', 45.758536, 4.854065, 4, 7, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (18, 'Capteur18', 45.778420, 4.863849, 1, 7, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (6, 'Capteur6', 45.780217, 4.872602, 0, 5, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (67, 'Capteur67', 45.780935, 4.887364, 6, 6, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (37, 'Capteur37', 45.774228, 4.866595, 3, 6, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (36, 'Capteur36', 45.766682, 4.872431, 3, 5, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (34, 'Capteur34', 45.760692, 4.886334, 3, 3, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (2, 'Capteur2', 45.778420, 4.904013, 0, 1, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (63, 'Capteur63', 45.773509, 4.846856, 6, 2, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (60, 'Capteur60', 45.765005, 4.836729, 5, 9, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (58, 'Capteur58', 45.759494, 4.835871, 5, 7, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (57, 'Capteur57', 45.753264, 4.831580, 5, 6, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (56, 'Capteur56', 45.747992, 4.828491, 5, 5, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (15, 'Capteur15', 45.742000, 4.824371, 1, 4, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (47, 'Capteur47', 45.756499, 4.847028, 4, 6, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (46, 'Capteur46', 45.761770, 4.844625, 4, 5, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (45, 'Capteur45', 45.752665, 4.841192, 4, 4, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (44, 'Capteur44', 45.748111, 4.838103, 4, 3, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (43, 'Capteur43', 45.747752, 4.848916, 4, 2, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (42, 'Capteur42', 45.751706, 4.856296, 4, 1, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (41, 'Capteur41', 45.756020, 4.868483, 4, 0, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (30, 'Capteur30', 45.760812, 4.866080, 2, 9, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (29, 'Capteur29', 45.750388, 4.886334, 2, 8, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (27, 'Capteur27', 45.752066, 4.877065, 2, 6, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (26, 'Capteur26', 45.754462, 4.893886, 2, 5, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (24, 'Capteur24', 45.761531, 4.896804, 2, 3, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (23, 'Capteur23', 45.767281, 4.895602, 2, 2, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (22, 'Capteur22', 45.765364, 4.882558, 2, 1, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (21, 'Capteur21', 45.769317, 4.884102, 2, 0, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (12, 'Capteur12', 45.762968, 4.822998, 1, 1, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (11, 'Capteur11', 45.754702, 4.822827, 1, 0, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (9, 'Capteur9', 45.748830, 4.868140, 0, 8, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (8, 'Capteur8', 45.758775, 4.879296, 0, 7, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (7, 'Capteur7', 45.749789, 4.894229, 0, 6, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (17, 'Capteur17', 45.745355, 4.857670, 1, 6, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (28, 'Capteur28', 45.747153, 4.875864, 2, 7, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (55, 'Capteur55', 45.746913, 4.887192, 5, 4, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (66, 'Capteur66', 45.779855, 4.834499, 6, 5, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (40, 'Capteur40', 45.783567, 4.827461, 3, 9, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (35, 'Capteur35', 45.774228, 4.856640, 3, 4, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (25, 'Capteur25', 45.740921, 4.836558, 2, 4, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (32, 'Capteur32', 45.741880, 4.865737, 3, 1, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (20, 'Capteur20', 45.763448, 4.815103, 1, 9, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (10, 'Capteur10', 45.769916, 4.804118, 0, 9, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (59, 'Capteur59', 45.786683, 4.843423, 5, 8, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (70, 'Capteur70', 45.789677, 4.851147, 6, 9, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (69, 'Capteur69', 45.791353, 4.858013, 6, 8, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (14, 'Capteur14', 45.782849, 4.839993, 1, 3, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (38, 'Capteur38', 45.793269, 4.867625, 3, 7, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (19, 'Capteur19', 45.783330, 4.879640, 1, 8, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (68, 'Capteur68', 45.771593, 4.873461, 6, 7, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (52, 'Capteur52', 45.744636, 4.883072, 5, 1, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (51, 'Capteur51', 45.739603, 4.872946, 5, 0, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (50, 'Capteur50', 45.757697, 4.903326, 4, 9, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (49, 'Capteur49', 45.773869, 4.896804, 4, 8, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (64, 'Capteur64', 45.772312, 4.910192, 6, 3, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (31, 'Capteur31', 45.783210, 4.901781, 3, 0, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (33, 'Capteur33', 45.767640, 4.831409, 3, 2, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (1, 'Capteur1', 45.741760, 4.854237, 0, 0, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (3, 'Capteur3', 45.757098, 4.810468, 0, 2, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (4, 'Capteur4', 45.756019, 4.886849, 0, 3, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (5, 'Capteur5', 45.786084, 4.910535, 0, 4, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (54, 'Capteur54', 45.773510, 4.829178, 5, 3, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (16, 'Capteur16', 45.775545, 4.823856, 1, 5, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (39, 'Capteur39', 45.779017, 4.826431, 3, 8, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (53, 'Capteur53', 45.780813, 4.821281, 5, 2, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (13, 'Capteur13', 45.776862, 4.816990, 1, 2, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (61, 'Capteur61', 45.770277, 4.835186, 6, 0, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (62, 'Capteur62', 45.776503, 4.836559, 6, 1, 1);
INSERT INTO public.capteur OVERRIDING SYSTEM VALUE VALUES (65, 'Capteur65', 45.769439, 4.823341, 6, 4, 1);

INSERT INTO public.caserne OVERRIDING SYSTEM VALUE VALUES (1, 'Caserne de Villeurbanne', '10 Rue Salengro', '69100', 'Villeurbanne', '0618253305', '45.778813', '4.878202');
INSERT INTO public.caserne OVERRIDING SYSTEM VALUE VALUES (2, 'Caserne de Lyon', '57 Rue Bossuet', '69006', 'Lyon', '0912326545', '45.768254', '4.851651');

INSERT INTO public.pompier (id, nom, prenom, age, tel, annees_experience, energie, id_caserne) OVERRIDING SYSTEM VALUE VALUES (1, 'Pierre', 'Khettal', 21, '0874387512', 0, 20, 1);
INSERT INTO public.pompier (id, nom, prenom, age, tel, annees_experience, energie, id_caserne) OVERRIDING SYSTEM VALUE VALUES (2, 'Jean', 'Ferrat', 32, '089873748', 12, 80, 1);
INSERT INTO public.pompier (id, nom, prenom, age, tel, annees_experience, energie, id_caserne) OVERRIDING SYSTEM VALUE VALUES (3, 'Jeanne', 'Kartier', 26, '0782456123', 4, 60, 2);
INSERT INTO public.pompier (id, nom, prenom, age, tel, annees_experience, energie, id_caserne) OVERRIDING SYSTEM VALUE VALUES (4, 'Driss', 'Todu', 21, '0874387512', 0, 80, 2);
INSERT INTO public.pompier (id, nom, prenom, age, tel, annees_experience, energie, id_caserne) OVERRIDING SYSTEM VALUE VALUES (5, 'Remi', 'Fugras', 21, '089873748', 10, 80, 2);
INSERT INTO public.pompier (id, nom, prenom, age, tel, annees_experience, energie, id_caserne) OVERRIDING SYSTEM VALUE VALUES (6, 'Guillaume', 'Lequartier', 21, '0782456123', 4, 80, 1);

INSERT INTO public.vehicule (id, modele, num_immatriculation, capacite_personne, capacite_produit, longitude, latitude, id_caserne) OVERRIDING SYSTEM VALUE VALUES (1, 'V4HA2', '343-DA2-H3D', 6, 500, '4.878202', '45.778813', 1);
INSERT INTO public.vehicule (id, modele, num_immatriculation, capacite_personne, capacite_produit, longitude, latitude, id_caserne) OVERRIDING SYSTEM VALUE VALUES (2, 'V4HA6', '343-D8E-H3D', 5, 400, '4.851651', '45.768254', 2);
INSERT INTO public.vehicule (id, modele, num_immatriculation, capacite_personne, capacite_produit, longitude, latitude, id_caserne) OVERRIDING SYSTEM VALUE VALUES (3, 'V4HA2', '343-DA2-H3D', 6, 500, '4.878202', '45.778813', 2);
INSERT INTO public.vehicule (id, modele, num_immatriculation, capacite_personne, capacite_produit, longitude, latitude, id_caserne) OVERRIDING SYSTEM VALUE VALUES (4, 'V4HA6', '333-D8E-D38', 5, 400, '4.851651', '45.768254', 1);

INSERT INTO public.type_produit (id, libelle) OVERRIDING SYSTEM VALUE VALUES (1, 'Poudre');
INSERT INTO public.type_produit (id, libelle) OVERRIDING SYSTEM VALUE VALUES (2, 'Mousse');
INSERT INTO public.type_produit (id, libelle) OVERRIDING SYSTEM VALUE VALUES (3, 'Co2');

INSERT INTO public.vehicule_type_produit (id_vehicule, id_type_produit) OVERRIDING SYSTEM VALUE VALUES (1, 1);
INSERT INTO public.vehicule_type_produit (id_vehicule, id_type_produit) OVERRIDING SYSTEM VALUE VALUES (1, 2);
INSERT INTO public.vehicule_type_produit (id_vehicule, id_type_produit) OVERRIDING SYSTEM VALUE VALUES (2, 3);


-- INSERT INTO public.incident (longitude, latitude, criticite, id_type_incident, date_debut) VALUES (4.862041, 45.751625, 7, 1, NOW());
-- INSERT INTO public.incident (longitude, latitude, criticite, id_type_incident, date_debut) VALUES (4.842041, 45.781625, 7, 1, NOW());


ALTER SEQUENCE IF EXISTS public.vehicule_id_seq
    START 3;
ALTER SEQUENCE IF EXISTS public.type_capteur_id_seq
    START 6;ALTER SEQUENCE IF EXISTS public.vehicule_id_seq
    START 3;
ALTER SEQUENCE IF EXISTS public.type_produit_id_seq
    START 4;
ALTER SEQUENCE IF EXISTS public.type_incident_id_seq
    START 9;
ALTER SEQUENCE IF EXISTS public.pompier_id_seq
    START 4;
ALTER SEQUENCE IF EXISTS public.caserne_id_seq
    START 3;
ALTER SEQUENCE IF EXISTS public.type_produit_id_seq
    START 4;

