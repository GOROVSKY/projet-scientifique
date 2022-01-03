--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Started on 2021-12-17 09:25:20

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

--
-- TOC entry 209 (class 1259 OID 16419)
-- Name: capteur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.capteur (
    id numeric NOT NULL,
    code text,
    latitude numeric(8,0),
    longitude numeric(8,0),
    ligne integer,
    colonne integer,
    id_modele integer NOT NULL
);


ALTER TABLE public.capteur OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16569)
-- Name: capteur_donnees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.capteur_donnees (
    id integer NOT NULL,
    id_type_capteur integer NOT NULL,
    id_capteur integer NOT NULL,
    valeur numeric,
    date timestamp without time zone
);


ALTER TABLE public.capteur_donnees OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16500)
-- Name: caserne; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.caserne (
    id integer NOT NULL,
    nom text,
    adresse text,
    code_postal text,
    ville text,
    tel text,
    longitude text,
    latitude text
);


ALTER TABLE public.caserne OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16540)
-- Name: detection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detection (
    id_incident integer NOT NULL,
    id_capteur integer NOT NULL
);


ALTER TABLE public.detection OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16588)
-- Name: historique; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.historique (
    id integer NOT NULL,
    id_capteur integer NOT NULL,
    id_type_capteur integer NOT NULL,
    valeur numeric,
    date timestamp without time zone
);


ALTER TABLE public.historique OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16532)
-- Name: incident; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.incident (
    id integer NOT NULL,
    date_debut timestamp without time zone,
    date_fin timestamp without time zone,
    type text,
    longitude numeric(8,0),
    latitude numeric(8,0),
    criticite integer DEFAULT 1,
    id_type_incident integer
);


ALTER TABLE public.incident OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16562)
-- Name: modele_capteur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modele_capteur (
    id integer NOT NULL,
    libelle text NOT NULL
);


ALTER TABLE public.modele_capteur OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16583)
-- Name: modele_type_capteur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modele_type_capteur (
    id_modele_capteur integer NOT NULL,
    id_type_capteur integer NOT NULL
);


ALTER TABLE public.modele_type_capteur OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16507)
-- Name: pompier; Type: TABLE; Schema: public; Owner: postgres
--

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

--
-- TOC entry 214 (class 1259 OID 16527)
-- Name: pompier_incident; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pompier_incident (
    id_pompier integer NOT NULL,
    id_incident integer NOT NULL
);


ALTER TABLE public.pompier_incident OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16576)
-- Name: type_capteur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.type_capteur (
    id integer NOT NULL,
    libelle text
);


ALTER TABLE public.type_capteur OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16633)
-- Name: type_incident; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.type_incident (
    id integer NOT NULL,
    libelle text
);


ALTER TABLE public.type_incident OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16515)
-- Name: vehicule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicule (
    id integer NOT NULL,
    modele text,
    num_immatriculation text,
    capacite_personne integer,
    capactite_produit numeric,
    type_produit text,
    longitude numeric(8,0),
    latitude numeric(8,0),
    id_caserne integer NOT NULL
);


ALTER TABLE public.vehicule OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16522)
-- Name: vehicule_incident; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicule_incident (
    id_vehicule integer NOT NULL,
    id_incident integer NOT NULL
);


ALTER TABLE public.vehicule_incident OWNER TO postgres;


--
-- TOC entry 3245 (class 2606 OID 16575)
-- Name: capteur_donnees capteur_donnees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur_donnees
    ADD CONSTRAINT capteur_donnees_pkey PRIMARY KEY (id);


--
-- TOC entry 3223 (class 2606 OID 16506)
-- Name: caserne caserne_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caserne
    ADD CONSTRAINT caserne_pkey PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 16544)
-- Name: detection detection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detection
    ADD CONSTRAINT detection_pkey PRIMARY KEY (id_incident, id_capteur);


--
-- TOC entry 3254 (class 2606 OID 16594)
-- Name: historique historique_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historique
    ADD CONSTRAINT historique_pkey PRIMARY KEY (id_type_capteur);


--
-- TOC entry 3238 (class 2606 OID 16539)
-- Name: incident incident_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incident
    ADD CONSTRAINT incident_pkey PRIMARY KEY (id);


--
-- TOC entry 3243 (class 2606 OID 16568)
-- Name: modele_capteur modele_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele_capteur
    ADD CONSTRAINT modele_pkey PRIMARY KEY (id);


--
-- TOC entry 3251 (class 2606 OID 16587)
-- Name: modele_type_capteur modele_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele_type_capteur
    ADD CONSTRAINT modele_type_pkey PRIMARY KEY (id_modele_capteur, id_type_capteur);


--
-- TOC entry 3235 (class 2606 OID 16531)
-- Name: pompier_incident pompier_intervention_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pompier_incident
    ADD CONSTRAINT pompier_intervention_pkey PRIMARY KEY (id_pompier, id_incident);


--
-- TOC entry 3226 (class 2606 OID 16607)
-- Name: pompier pompier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pompier
    ADD CONSTRAINT pompier_pkey PRIMARY KEY (id);


--
-- TOC entry 3221 (class 2606 OID 16425)
-- Name: capteur sensor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur
    ADD CONSTRAINT sensor_pkey PRIMARY KEY (id);


--
-- TOC entry 3256 (class 2606 OID 16639)
-- Name: type_incident type_incident_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_incident
    ADD CONSTRAINT type_incident_pkey PRIMARY KEY (id);


--
-- TOC entry 3247 (class 2606 OID 16582)
-- Name: type_capteur type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_capteur
    ADD CONSTRAINT type_pkey PRIMARY KEY (id);


--
-- TOC entry 3231 (class 2606 OID 16526)
-- Name: vehicule_incident vehicule_intervention_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicule_incident
    ADD CONSTRAINT vehicule_intervention_pkey PRIMARY KEY (id_vehicule, id_incident);


--
-- TOC entry 3228 (class 2606 OID 16626)
-- Name: vehicule vehicule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicule
    ADD CONSTRAINT vehicule_pkey PRIMARY KEY (id);


--
-- TOC entry 3241 (class 1259 OID 16656)
-- Name: fki_fk_capteur; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_capteur ON public.detection USING btree (id_capteur);


--
-- TOC entry 3224 (class 1259 OID 16600)
-- Name: fki_fk_id_caserne; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_id_caserne ON public.pompier USING btree (id_caserne);


--
-- TOC entry 3217 (class 1259 OID 16673)
-- Name: fki_fk_id_modele; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_id_modele ON public.capteur USING btree (id_modele);


--
-- TOC entry 3218 (class 1259 OID 16493)
-- Name: fki_fk_id_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_id_type ON public.capteur USING btree (id_modele);


--
-- TOC entry 3252 (class 1259 OID 16667)
-- Name: fki_fk_id_type_capteur; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_id_type_capteur ON public.historique USING btree (id_type_capteur);


--
-- TOC entry 3232 (class 1259 OID 16619)
-- Name: fki_fk_incident; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_incident ON public.pompier_incident USING btree (id_incident);


--
-- TOC entry 3248 (class 1259 OID 16679)
-- Name: fki_fk_modele; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_modele ON public.modele_type_capteur USING btree (id_modele_capteur);


--
-- TOC entry 3233 (class 1259 OID 16613)
-- Name: fki_fk_pompier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_pompier ON public.pompier_incident USING btree (id_pompier);


--
-- TOC entry 3219 (class 1259 OID 16499)
-- Name: fki_fk_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_type ON public.capteur USING btree (id_modele);


--
-- TOC entry 3249 (class 1259 OID 16685)
-- Name: fki_fk_type_capteur; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_type_capteur ON public.modele_type_capteur USING btree (id_type_capteur);


--
-- TOC entry 3236 (class 1259 OID 16645)
-- Name: fki_fk_type_incident; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_type_incident ON public.incident USING btree (id_type_incident);


--
-- TOC entry 3229 (class 1259 OID 16632)
-- Name: fki_fk_vehicule; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_vehicule ON public.vehicule_incident USING btree (id_vehicule);


--
-- TOC entry 3265 (class 2606 OID 16651)
-- Name: detection fk_capteur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detection
    ADD CONSTRAINT fk_capteur FOREIGN KEY (id_capteur) REFERENCES public.capteur(id);


--
-- TOC entry 3270 (class 2606 OID 16657)
-- Name: historique fk_capteur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historique
    ADD CONSTRAINT fk_capteur FOREIGN KEY (id_capteur) REFERENCES public.capteur(id);


--
-- TOC entry 3258 (class 2606 OID 16595)
-- Name: pompier fk_id_caserne; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pompier
    ADD CONSTRAINT fk_id_caserne FOREIGN KEY (id_caserne) REFERENCES public.caserne(id);


--
-- TOC entry 3259 (class 2606 OID 16601)
-- Name: vehicule fk_id_caserne; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicule
    ADD CONSTRAINT fk_id_caserne FOREIGN KEY (id_caserne) REFERENCES public.caserne(id);


--
-- TOC entry 3257 (class 2606 OID 16668)
-- Name: capteur fk_id_modele; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur
    ADD CONSTRAINT fk_id_modele FOREIGN KEY (id_modele) REFERENCES public.modele_capteur(id);


--
-- TOC entry 3271 (class 2606 OID 16662)
-- Name: historique fk_id_type_capteur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historique
    ADD CONSTRAINT fk_id_type_capteur FOREIGN KEY (id_type_capteur) REFERENCES public.type_capteur(id);


--
-- TOC entry 3263 (class 2606 OID 16614)
-- Name: pompier_incident fk_incident; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pompier_incident
    ADD CONSTRAINT fk_incident FOREIGN KEY (id_incident) REFERENCES public.incident(id);


--
-- TOC entry 3261 (class 2606 OID 16620)
-- Name: vehicule_incident fk_incident; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicule_incident
    ADD CONSTRAINT fk_incident FOREIGN KEY (id_incident) REFERENCES public.incident(id);


--
-- TOC entry 3266 (class 2606 OID 16646)
-- Name: detection fk_incident; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detection
    ADD CONSTRAINT fk_incident FOREIGN KEY (id_incident) REFERENCES public.incident(id);


--
-- TOC entry 3268 (class 2606 OID 16674)
-- Name: modele_type_capteur fk_modele_capteur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele_type_capteur
    ADD CONSTRAINT fk_modele_capteur FOREIGN KEY (id_modele_capteur) REFERENCES public.modele_capteur(id);


--
-- TOC entry 3262 (class 2606 OID 16608)
-- Name: pompier_incident fk_pompier; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pompier_incident
    ADD CONSTRAINT fk_pompier FOREIGN KEY (id_pompier) REFERENCES public.pompier(id);


--
-- TOC entry 3269 (class 2606 OID 16680)
-- Name: modele_type_capteur fk_type_capteur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele_type_capteur
    ADD CONSTRAINT fk_type_capteur FOREIGN KEY (id_type_capteur) REFERENCES public.type_capteur(id);


--
-- TOC entry 3267 (class 2606 OID 16686)
-- Name: capteur_donnees fk_type_capteur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur_donnees
    ADD CONSTRAINT fk_type_capteur FOREIGN KEY (id_type_capteur) REFERENCES public.type_capteur(id);


--
-- TOC entry 3264 (class 2606 OID 16640)
-- Name: incident fk_type_incident; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incident
    ADD CONSTRAINT fk_type_incident FOREIGN KEY (id_type_incident) REFERENCES public.type_incident(id);


--
-- TOC entry 3260 (class 2606 OID 16627)
-- Name: vehicule_incident fk_vehicule; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicule_incident
    ADD CONSTRAINT fk_vehicule FOREIGN KEY (id_vehicule) REFERENCES public.vehicule(id);


-- Completed on 2021-12-17 09:25:20

--
-- PostgreSQL database dump complete
--

