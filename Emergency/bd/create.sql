--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Started on 2022-01-03 15:57:55

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';
SET default_table_access_method = heap;

DROP TABLE IF EXISTS public.capteur CASCADE;
DROP TABLE IF EXISTS public.capteur_donnees CASCADE;
DROP TABLE IF EXISTS public.caserne CASCADE;
DROP TABLE IF EXISTS public.detection CASCADE;
DROP TABLE IF EXISTS public.historique CASCADE;
DROP TABLE IF EXISTS public.incident CASCADE;
DROP TABLE IF EXISTS public.modele_capteur CASCADE;
DROP TABLE IF EXISTS public.modele_type_capteur CASCADE;
DROP TABLE IF EXISTS public.pompier CASCADE;
DROP TABLE IF EXISTS public.pompier_incident CASCADE;
DROP TABLE IF EXISTS public.type_capteur CASCADE;
DROP TABLE IF EXISTS public.type_incident CASCADE;
DROP TABLE IF EXISTS public.vehicule CASCADE;
DROP TABLE IF EXISTS public.vehicule_incident CASCADE;
DROP TABLE IF EXISTS public.type_produit CASCADE;
DROP TABLE IF EXISTS public.vehicule_type_produit CASCADE;

DROP SEQUENCE IF EXISTS public.id_capteur;
DROP SEQUENCE IF EXISTS public.id_caserne;
DROP SEQUENCE IF EXISTS public.id_modele_capteur;
DROP SEQUENCE IF EXISTS public.id_pompier;
DROP SEQUENCE IF EXISTS public.id_type_capteur;
DROP SEQUENCE IF EXISTS public.id_vehicule;
DROP SEQUENCE IF EXISTS public.type_produit_id_seq;

CREATE TABLE public.capteur (
    id integer NOT NULL,
    code text,
    latitude numeric(8,6),
    longitude numeric(8,6),
    ligne integer,
    colonne integer,
    id_modele integer NOT NULL
);


ALTER TABLE public.capteur OWNER TO postgres;


CREATE TABLE public.capteur_donnees (
    id integer NOT NULL,
    id_type_capteur integer NOT NULL,
    id_capteur integer NOT NULL,
    valeur numeric,
    date timestamp without time zone
);

ALTER TABLE public.capteur_donnees OWNER TO postgres;

ALTER TABLE public.capteur_donnees ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.capteur_donnees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


CREATE TABLE public.caserne (
    id integer NOT NULL,
    nom text,
    adresse text,
    code_postal text,
    ville text,
    tel text,
    latitude numeric(8,6),
    longitude numeric(8,6)
);

ALTER TABLE public.caserne OWNER TO postgres;

ALTER TABLE public.caserne ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.caserne_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE public.detection(
    id_incident integer NOT NULL,
    id_capteur integer NOT NULL,
    id_type_incident integer NOT NULL
);

ALTER TABLE public.detection OWNER TO postgres;


CREATE TABLE public.historique (
    id integer NOT NULL,
    id_capteur integer NOT NULL,
    id_type_capteur integer NOT NULL,
    valeur numeric,
    date timestamp without time zone
);


ALTER TABLE public.historique OWNER TO postgres;

ALTER TABLE public.historique ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.historique_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE public.incident (
    id integer NOT NULL,
    date_debut timestamp without time zone,
    date_fin timestamp without time zone,
    latitude numeric(8,6),
    longitude numeric(8,6),
    criticite integer DEFAULT 1,
    id_type_incident integer
);


ALTER TABLE public.incident OWNER TO postgres;

ALTER TABLE public.incident ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.incident_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


CREATE TABLE public.modele_capteur (
    id integer NOT NULL,
    libelle text NOT NULL
);

ALTER TABLE public.modele_capteur OWNER TO postgres;

ALTER TABLE public.modele_capteur ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.modele_capteur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


CREATE TABLE public.modele_type_capteur (
    id_modele_capteur integer NOT NULL,
    id_type_capteur integer NOT NULL
);

ALTER TABLE public.modele_type_capteur OWNER TO postgres;


CREATE TABLE public.pompier (
    id integer NOT NULL,
    nom text NOT NULL,
    prenom text NOT NULL,
    age numeric,
    tel text,
    annees_experience numeric,
    energie numeric DEFAULT 100,
    id_caserne integer
);

ALTER TABLE public.pompier OWNER TO postgres;

ALTER TABLE public.pompier ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.pompier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


CREATE TABLE public.pompier_incident (
    id_pompier integer NOT NULL,
    id_incident integer NOT NULL,
    date_debut timestamp without time zone,
    date_fin timestamp without time zone
);

ALTER TABLE public.pompier_incident OWNER TO postgres;


CREATE TABLE public.type_capteur (
    id integer NOT NULL,
    libelle text
);

ALTER TABLE public.type_capteur OWNER TO postgres;

ALTER TABLE public.type_capteur ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.type_capteur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE public.type_incident (
    id integer NOT NULL,
    libelle text
);

ALTER TABLE public.type_incident OWNER TO postgres;

ALTER TABLE public.type_incident ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.type_incident_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


CREATE TABLE public.vehicule (
    id integer NOT NULL,
    modele text,
    num_immatriculation text,
    capacite_personne integer,
    capacite_produit numeric,
    longitude numeric(8,6),
    latitude numeric(8,6),
    id_caserne integer NOT NULL
);

ALTER TABLE public.vehicule OWNER TO postgres;

ALTER TABLE public.vehicule ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.vehicule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


CREATE TABLE public.vehicule_incident (
    id_vehicule integer NOT NULL,
    id_incident integer NOT NULL,
    date_debut timestamp without time zone,
    date_fin timestamp without time zone
);

ALTER TABLE public.vehicule_incident OWNER TO postgres;


CREATE TABLE public.type_produit (
    id INTEGER NOT NULL,
    libelle TEXT NOT NULL
);
ALTER TABLE public.type_produit OWNER TO postgres;

ALTER TABLE public.type_produit ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.type_produit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


CREATE TABLE public.vehicule_type_produit(
    id_vehicule INTEGER not NULL,
    id_type_produit INTEGER not NULL
);

ALTER TABLE public.vehicule_type_produit OWNER TO postgres;





SELECT pg_catalog.setval('public.capteur_donnees_id_seq', 1, false);
SELECT pg_catalog.setval('public.caserne_id_seq', 1, false);
SELECT pg_catalog.setval('public.historique_id_seq', 1, false);
SELECT pg_catalog.setval('public.incident_id_seq', 1, false);
SELECT pg_catalog.setval('public.modele_capteur_id_seq', 1, false);
SELECT pg_catalog.setval('public.pompier_id_seq', 1, false);
SELECT pg_catalog.setval('public.type_capteur_id_seq', 1, false);
SELECT pg_catalog.setval('public.type_incident_id_seq', 1, false);
SELECT pg_catalog.setval('public.vehicule_id_seq', 1, false);
SELECT pg_catalog.setval('public.type_produit_id_seq', 1, false);


ALTER TABLE ONLY public.capteur_donnees
    ADD CONSTRAINT capteur_donnes_pk PRIMARY KEY (id);

ALTER TABLE ONLY public.caserne
    ADD CONSTRAINT caserne_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.detection
    ADD CONSTRAINT detection_pkey PRIMARY KEY (id_incident, id_capteur);

ALTER TABLE ONLY public.historique
    ADD CONSTRAINT historique_pkey PRIMARY KEY (id_type_capteur);

ALTER TABLE ONLY public.incident
    ADD CONSTRAINT incident_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.modele_capteur
    ADD CONSTRAINT modele_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.modele_type_capteur
    ADD CONSTRAINT modele_type_pkey PRIMARY KEY (id_modele_capteur, id_type_capteur);

ALTER TABLE ONLY public.pompier_incident
    ADD CONSTRAINT pompier_intervention_pkey PRIMARY KEY (id_pompier, id_incident);

ALTER TABLE ONLY public.pompier
    ADD CONSTRAINT pompier_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.capteur
    ADD CONSTRAINT sensor_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.type_incident
    ADD CONSTRAINT type_incident_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.type_capteur
    ADD CONSTRAINT type_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.vehicule_incident
    ADD CONSTRAINT vehicule_intervention_pkey PRIMARY KEY (id_vehicule, id_incident);

ALTER TABLE ONLY public.vehicule
    ADD CONSTRAINT vehicule_pkey PRIMARY KEY (id);
	
ALTER TABLE ONLY public.type_produit
    ADD CONSTRAINT type_produit_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.vehicule_type_produit
    ADD CONSTRAINT vehicule_type_produit_pkey PRIMARY KEY (id_vehicule, id_type_produit);

	

CREATE INDEX fki_fk_capteur ON public.detection USING btree (id_capteur);
CREATE INDEX fki_fk_id_caserne ON public.pompier USING btree (id_caserne);
CREATE INDEX fki_fk_id_modele ON public.capteur USING btree (id_modele);
CREATE INDEX fki_fk_id_type ON public.capteur USING btree (id_modele);
CREATE INDEX fki_fk_id_type_capteur ON public.historique USING btree (id_type_capteur);
CREATE INDEX fki_fk_incident ON public.pompier_incident USING btree (id_incident);
CREATE INDEX fki_fk_modele ON public.modele_type_capteur USING btree (id_modele_capteur);
CREATE INDEX fki_fk_pompier ON public.pompier_incident USING btree (id_pompier);
CREATE INDEX fki_fk_type ON public.capteur USING btree (id_modele);
CREATE INDEX fki_fk_type_capteur ON public.modele_type_capteur USING btree (id_type_capteur);
CREATE INDEX fki_fk_type_incident ON public.incident USING btree (id_type_incident);
CREATE INDEX fki_fk_vehicule ON public.vehicule_incident USING btree (id_vehicule);
CREATE INDEX fki_fk_vehicule_type_produit ON public.vehicule_type_produit USING btree (id_vehicule);
CREATE INDEX fki_fk_type_produit_vehicule_type_produit ON public.vehicule_type_produit USING btree (id_type_produit);



ALTER TABLE ONLY public.detection
    ADD CONSTRAINT fk_capteur FOREIGN KEY (id_capteur) REFERENCES public.capteur(id);

ALTER TABLE ONLY public.detection
    ADD CONSTRAINT fk_type_incident FOREIGN KEY (id_type_incident) REFERENCES public.type_incident(id);
	
ALTER TABLE ONLY public.detection
    ADD CONSTRAINT fk_incident FOREIGN KEY (id_incident) REFERENCES public.incident(id);

ALTER TABLE ONLY public.historique
    ADD CONSTRAINT fk_capteur FOREIGN KEY (id_capteur) REFERENCES public.capteur(id);

ALTER TABLE ONLY public.pompier
    ADD CONSTRAINT fk_id_caserne FOREIGN KEY (id_caserne) REFERENCES public.caserne(id);

ALTER TABLE ONLY public.vehicule
    ADD CONSTRAINT fk_id_caserne FOREIGN KEY (id_caserne) REFERENCES public.caserne(id);

ALTER TABLE ONLY public.capteur
    ADD CONSTRAINT fk_id_modele FOREIGN KEY (id_modele) REFERENCES public.modele_capteur(id);

ALTER TABLE ONLY public.historique
    ADD CONSTRAINT fk_id_type_capteur FOREIGN KEY (id_type_capteur) REFERENCES public.type_capteur(id);

ALTER TABLE ONLY public.pompier_incident
    ADD CONSTRAINT fk_incident FOREIGN KEY (id_incident) REFERENCES public.incident(id);

ALTER TABLE ONLY public.vehicule_incident
    ADD CONSTRAINT fk_incident FOREIGN KEY (id_incident) REFERENCES public.incident(id);

ALTER TABLE ONLY public.modele_type_capteur
    ADD CONSTRAINT fk_modele_capteur FOREIGN KEY (id_modele_capteur) REFERENCES public.modele_capteur(id);

ALTER TABLE ONLY public.pompier_incident
    ADD CONSTRAINT fk_pompier FOREIGN KEY (id_pompier) REFERENCES public.pompier(id);

ALTER TABLE ONLY public.modele_type_capteur
    ADD CONSTRAINT fk_type_capteur FOREIGN KEY (id_type_capteur) REFERENCES public.type_capteur(id);

ALTER TABLE ONLY public.capteur_donnees
    ADD CONSTRAINT fk_type_capteur FOREIGN KEY (id_type_capteur) REFERENCES public.type_capteur(id);

ALTER TABLE ONLY public.incident
    ADD CONSTRAINT fk_type_incident FOREIGN KEY (id_type_incident) REFERENCES public.type_incident(id);

ALTER TABLE ONLY public.vehicule_incident
    ADD CONSTRAINT fk_vehicule FOREIGN KEY (id_vehicule) REFERENCES public.vehicule(id);

ALTER TABLE ONLY public.vehicule_type_produit
    ADD CONSTRAINT fk_vehicule FOREIGN KEY (id_vehicule) REFERENCES public.vehicule(id);

ALTER TABLE ONLY public.vehicule_type_produit
    ADD CONSTRAINT fk_type_produit FOREIGN KEY (id_type_produit) REFERENCES public.type_produit(id);