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

--
-- TOC entry 209 (class 1259 OID 16419)
-- Name: capteur; Type: TABLE; Schema: public; Owner: postgres
--

DROP TABLE IF EXISTS capteur CASCADE;
DROP TABLE IF EXISTS capteur_donnees CASCADE;
DROP TABLE IF EXISTS caserne CASCADE;
DROP TABLE IF EXISTS detection CASCADE;
DROP TABLE IF EXISTS historique CASCADE;
DROP TABLE IF EXISTS incident CASCADE;
DROP TABLE IF EXISTS modele_capteur CASCADE;
DROP TABLE IF EXISTS modele_type_capteur CASCADE;
DROP TABLE IF EXISTS pompier CASCADE;
DROP TABLE IF EXISTS pompier_incident CASCADE;
DROP TABLE IF EXISTS type_capteur CASCADE;
DROP TABLE IF EXISTS type_incident CASCADE;
DROP TABLE IF EXISTS vehicule CASCADE;
DROP TABLE IF EXISTS vehicule_incident CASCADE;
DROP TABLE IF EXISTS type_produit CASCADE;
DROP TABLE IF EXISTS vehicule_type_produit CASCADE;



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
-- TOC entry 223 (class 1259 OID 16691)
-- Name: capteur_donnees_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.capteur_donnees ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.capteur_donnees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


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
    latitude numeric(8,6),
    longitude numeric(8,6)
);


ALTER TABLE public.caserne OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16692)
-- Name: caserne_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.caserne ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.caserne_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 16540)
-- Name: detection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE detection(
    id_incident integer NOT NULL,
    id_capteur integer NOT NULL,
    id_type_incident integer NOT NULL
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
-- TOC entry 225 (class 1259 OID 16693)
-- Name: historique_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.historique ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.historique_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 215 (class 1259 OID 16532)
-- Name: incident; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.incident (
    id integer NOT NULL,
    date_debut timestamp without time zone,
    date_fin timestamp without time zone,
    type text,
    latitude numeric(8,6),
    longitude numeric(8,6),
    criticite integer DEFAULT 1,
    id_type_incident integer
);


ALTER TABLE public.incident OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16694)
-- Name: incident_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.incident ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.incident_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


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
-- TOC entry 227 (class 1259 OID 16695)
-- Name: modele_capteur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.modele_capteur ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.modele_capteur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


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
-- TOC entry 228 (class 1259 OID 16696)
-- Name: pompier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.pompier ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.pompier_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


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
-- TOC entry 229 (class 1259 OID 16697)
-- Name: type_capteur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.type_capteur ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.type_capteur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


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
-- TOC entry 230 (class 1259 OID 16698)
-- Name: type_incident_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.type_incident ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.type_incident_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


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
    longitude numeric(8,6),
    latitude numeric(8,6),
    id_caserne integer NOT NULL
);


ALTER TABLE public.vehicule OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16699)
-- Name: vehicule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.vehicule ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.vehicule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


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
-- TOC entry 3420 (class 0 OID 16419)
-- Dependencies: 209
-- Data for Name: capteur; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- TOC entry 3429 (class 0 OID 16569)
-- Dependencies: 218
-- Data for Name: capteur_donnees; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3421 (class 0 OID 16500)
-- Dependencies: 210
-- Data for Name: caserne; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3427 (class 0 OID 16540)
-- Dependencies: 216
-- Data for Name: detection; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3432 (class 0 OID 16588)
-- Dependencies: 221
-- Data for Name: historique; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3426 (class 0 OID 16532)
-- Dependencies: 215
-- Data for Name: incident; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3428 (class 0 OID 16562)
-- Dependencies: 217
-- Data for Name: modele_capteur; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3431 (class 0 OID 16583)
-- Dependencies: 220
-- Data for Name: modele_type_capteur; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3422 (class 0 OID 16507)
-- Dependencies: 211
-- Data for Name: pompier; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3425 (class 0 OID 16527)
-- Dependencies: 214
-- Data for Name: pompier_incident; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3430 (class 0 OID 16576)
-- Dependencies: 219
-- Data for Name: type_capteur; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3433 (class 0 OID 16633)
-- Dependencies: 222
-- Data for Name: type_incident; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3423 (class 0 OID 16515)
-- Dependencies: 212
-- Data for Name: vehicule; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3424 (class 0 OID 16522)
-- Dependencies: 213
-- Data for Name: vehicule_incident; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 223
-- Name: capteur_donnees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.capteur_donnees_id_seq', 1, false);


--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 224
-- Name: caserne_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.caserne_id_seq', 1, false);


--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 225
-- Name: historique_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.historique_id_seq', 1, false);


--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 226
-- Name: incident_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.incident_id_seq', 1, false);


--
-- TOC entry 3452 (class 0 OID 0)
-- Dependencies: 227
-- Name: modele_capteur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.modele_capteur_id_seq', 1, false);


--
-- TOC entry 3453 (class 0 OID 0)
-- Dependencies: 228
-- Name: pompier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pompier_id_seq', 1, false);


--
-- TOC entry 3454 (class 0 OID 0)
-- Dependencies: 229
-- Name: type_capteur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.type_capteur_id_seq', 1, false);


--
-- TOC entry 3455 (class 0 OID 0)
-- Dependencies: 230
-- Name: type_incident_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.type_incident_id_seq', 1, false);


--
-- TOC entry 3456 (class 0 OID 0)
-- Dependencies: 231
-- Name: vehicule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vehicule_id_seq', 1, false);


--
-- TOC entry 3254 (class 2606 OID 16701)
-- Name: capteur_donnees capteur_donnes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur_donnees
    ADD CONSTRAINT capteur_donnes_pk PRIMARY KEY (id);


--
-- TOC entry 3232 (class 2606 OID 16506)
-- Name: caserne caserne_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.caserne
    ADD CONSTRAINT caserne_pkey PRIMARY KEY (id);


--
-- TOC entry 3249 (class 2606 OID 16544)
-- Name: detection detection_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detection
    ADD CONSTRAINT detection_pkey PRIMARY KEY (id_incident, id_capteur);


--
-- TOC entry 3263 (class 2606 OID 16594)
-- Name: historique historique_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historique
    ADD CONSTRAINT historique_pkey PRIMARY KEY (id_type_capteur);


--
-- TOC entry 3247 (class 2606 OID 16539)
-- Name: incident incident_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incident
    ADD CONSTRAINT incident_pkey PRIMARY KEY (id);


--
-- TOC entry 3252 (class 2606 OID 16568)
-- Name: modele_capteur modele_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele_capteur
    ADD CONSTRAINT modele_pkey PRIMARY KEY (id);


--
-- TOC entry 3260 (class 2606 OID 16587)
-- Name: modele_type_capteur modele_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele_type_capteur
    ADD CONSTRAINT modele_type_pkey PRIMARY KEY (id_modele_capteur, id_type_capteur);


--
-- TOC entry 3244 (class 2606 OID 16531)
-- Name: pompier_incident pompier_intervention_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pompier_incident
    ADD CONSTRAINT pompier_intervention_pkey PRIMARY KEY (id_pompier, id_incident);


--
-- TOC entry 3235 (class 2606 OID 16607)
-- Name: pompier pompier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pompier
    ADD CONSTRAINT pompier_pkey PRIMARY KEY (id);


--
-- TOC entry 3230 (class 2606 OID 16703)
-- Name: capteur sensor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur
    ADD CONSTRAINT sensor_pkey PRIMARY KEY (id);


--
-- TOC entry 3265 (class 2606 OID 16639)
-- Name: type_incident type_incident_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_incident
    ADD CONSTRAINT type_incident_pkey PRIMARY KEY (id);


--
-- TOC entry 3256 (class 2606 OID 16582)
-- Name: type_capteur type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_capteur
    ADD CONSTRAINT type_pkey PRIMARY KEY (id);


--
-- TOC entry 3240 (class 2606 OID 16526)
-- Name: vehicule_incident vehicule_intervention_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicule_incident
    ADD CONSTRAINT vehicule_intervention_pkey PRIMARY KEY (id_vehicule, id_incident);


--
-- TOC entry 3237 (class 2606 OID 16626)
-- Name: vehicule vehicule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicule
    ADD CONSTRAINT vehicule_pkey PRIMARY KEY (id);


--
-- TOC entry 3250 (class 1259 OID 16656)
-- Name: fki_fk_capteur; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_capteur ON public.detection USING btree (id_capteur);


--
-- TOC entry 3233 (class 1259 OID 16600)
-- Name: fki_fk_id_caserne; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_id_caserne ON public.pompier USING btree (id_caserne);


--
-- TOC entry 3226 (class 1259 OID 16673)
-- Name: fki_fk_id_modele; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_id_modele ON public.capteur USING btree (id_modele);


--
-- TOC entry 3227 (class 1259 OID 16493)
-- Name: fki_fk_id_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_id_type ON public.capteur USING btree (id_modele);


--
-- TOC entry 3261 (class 1259 OID 16667)
-- Name: fki_fk_id_type_capteur; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_id_type_capteur ON public.historique USING btree (id_type_capteur);


--
-- TOC entry 3241 (class 1259 OID 16619)
-- Name: fki_fk_incident; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_incident ON public.pompier_incident USING btree (id_incident);


--
-- TOC entry 3257 (class 1259 OID 16679)
-- Name: fki_fk_modele; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_modele ON public.modele_type_capteur USING btree (id_modele_capteur);


--
-- TOC entry 3242 (class 1259 OID 16613)
-- Name: fki_fk_pompier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_pompier ON public.pompier_incident USING btree (id_pompier);


--
-- TOC entry 3228 (class 1259 OID 16499)
-- Name: fki_fk_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_type ON public.capteur USING btree (id_modele);


--
-- TOC entry 3258 (class 1259 OID 16685)
-- Name: fki_fk_type_capteur; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_type_capteur ON public.modele_type_capteur USING btree (id_type_capteur);


--
-- TOC entry 3245 (class 1259 OID 16645)
-- Name: fki_fk_type_incident; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_type_incident ON public.incident USING btree (id_type_incident);


--
-- TOC entry 3238 (class 1259 OID 16632)
-- Name: fki_fk_vehicule; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_vehicule ON public.vehicule_incident USING btree (id_vehicule);


--
-- TOC entry 3275 (class 2606 OID 16704)
-- Name: detection fk_capteur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detection
    ADD CONSTRAINT fk_capteur FOREIGN KEY (id_capteur) REFERENCES public.capteur(id);

ALTER TABLE ONLY public.detection
    ADD CONSTRAINT fk_type_incident FOREIGN KEY (id_type_incident) REFERENCES public.type_incident(id);


--
-- TOC entry 3280 (class 2606 OID 16709)
-- Name: historique fk_capteur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historique
    ADD CONSTRAINT fk_capteur FOREIGN KEY (id_capteur) REFERENCES public.capteur(id);


--
-- TOC entry 3267 (class 2606 OID 16595)
-- Name: pompier fk_id_caserne; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pompier
    ADD CONSTRAINT fk_id_caserne FOREIGN KEY (id_caserne) REFERENCES public.caserne(id);


--
-- TOC entry 3268 (class 2606 OID 16601)
-- Name: vehicule fk_id_caserne; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicule
    ADD CONSTRAINT fk_id_caserne FOREIGN KEY (id_caserne) REFERENCES public.caserne(id);


--
-- TOC entry 3266 (class 2606 OID 16668)
-- Name: capteur fk_id_modele; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur
    ADD CONSTRAINT fk_id_modele FOREIGN KEY (id_modele) REFERENCES public.modele_capteur(id);


--
-- TOC entry 3279 (class 2606 OID 16662)
-- Name: historique fk_id_type_capteur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.historique
    ADD CONSTRAINT fk_id_type_capteur FOREIGN KEY (id_type_capteur) REFERENCES public.type_capteur(id);


--
-- TOC entry 3272 (class 2606 OID 16614)
-- Name: pompier_incident fk_incident; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pompier_incident
    ADD CONSTRAINT fk_incident FOREIGN KEY (id_incident) REFERENCES public.incident(id);


--
-- TOC entry 3270 (class 2606 OID 16620)
-- Name: vehicule_incident fk_incident; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicule_incident
    ADD CONSTRAINT fk_incident FOREIGN KEY (id_incident) REFERENCES public.incident(id);


--
-- TOC entry 3274 (class 2606 OID 16646)
-- Name: detection fk_incident; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detection
    ADD CONSTRAINT fk_incident FOREIGN KEY (id_incident) REFERENCES public.incident(id);


--
-- TOC entry 3277 (class 2606 OID 16674)
-- Name: modele_type_capteur fk_modele_capteur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele_type_capteur
    ADD CONSTRAINT fk_modele_capteur FOREIGN KEY (id_modele_capteur) REFERENCES public.modele_capteur(id);


--
-- TOC entry 3271 (class 2606 OID 16608)
-- Name: pompier_incident fk_pompier; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pompier_incident
    ADD CONSTRAINT fk_pompier FOREIGN KEY (id_pompier) REFERENCES public.pompier(id);


--
-- TOC entry 3278 (class 2606 OID 16680)
-- Name: modele_type_capteur fk_type_capteur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele_type_capteur
    ADD CONSTRAINT fk_type_capteur FOREIGN KEY (id_type_capteur) REFERENCES public.type_capteur(id);


--
-- TOC entry 3276 (class 2606 OID 16686)
-- Name: capteur_donnees fk_type_capteur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur_donnees
    ADD CONSTRAINT fk_type_capteur FOREIGN KEY (id_type_capteur) REFERENCES public.type_capteur(id);


--
-- TOC entry 3273 (class 2606 OID 16640)
-- Name: incident fk_type_incident; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incident
    ADD CONSTRAINT fk_type_incident FOREIGN KEY (id_type_incident) REFERENCES public.type_incident(id);


--
-- TOC entry 3269 (class 2606 OID 16627)
-- Name: vehicule_incident fk_vehicule; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicule_incident
    ADD CONSTRAINT fk_vehicule FOREIGN KEY (id_vehicule) REFERENCES public.vehicule(id);


-- Completed on 2022-01-03 15:57:55

--
-- PostgreSQL database dump complete
--


CREATE TABLE public.type_produit (
    id SERIAL NOT NULL PRIMARY KEY,
    libelle text NOT NULL
);


CREATE TABLE public.vehicule_type_produit(
    id_vehicule integer not NULL,
    id_type_produit integer not NULL
);

ALTER TABLE ONLY public.vehicule_type_produit
    ADD CONSTRAINT fk_vehicule FOREIGN KEY (id_vehicule) REFERENCES public.vehicule(id);

    
ALTER TABLE ONLY public.vehicule_type_produit
    ADD CONSTRAINT fk_type_produit FOREIGN KEY (id_type_produit) REFERENCES public.id_type_produit(id);