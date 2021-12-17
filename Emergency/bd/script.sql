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
-- TOC entry 3411 (class 0 OID 16419)
-- Dependencies: 209
-- Data for Name: capteur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.capteur (id, code, latitude, longitude, ligne, colonne, id_modele) FROM stdin;
64	Capteur64	7	3	6	3	1
65	Capteur65	7	4	6	4	1
31	Capteur31	3	0	3	0	1
33	Capteur33	3	2	3	2	1
66	Capteur66	7	6	6	5	1
1	Capteur1	0	0	0	0	1
3	Capteur3	0	2	0	2	1
4	Capteur4	0	3	0	3	1
5	Capteur5	0	4	0	4	1
16	Capteur16	1	6	1	5	1
34	Capteur34	3	3	3	3	1
36	Capteur36	3	6	3	5	1
37	Capteur37	3	7	3	6	1
67	Capteur67	7	7	6	6	1
6	Capteur6	0	6	0	5	1
18	Capteur18	1	8	1	7	1
48	Capteur48	4	8	4	7	1
49	Capteur49	4	9	4	8	1
50	Capteur50	4	10	4	9	1
51	Capteur51	6	0	5	0	1
52	Capteur52	6	1	5	1	1
68	Capteur68	7	8	6	7	1
19	Capteur19	1	9	1	8	1
38	Capteur38	3	8	3	7	1
39	Capteur39	3	9	3	8	1
40	Capteur40	3	10	3	9	1
69	Capteur69	7	9	6	8	1
70	Capteur70	7	10	6	9	1
59	Capteur59	6	9	5	8	1
10	Capteur10	0	10	0	9	1
20	Capteur20	1	10	1	9	1
32	Capteur32	3	1	3	1	1
25	Capteur25	2	4	2	4	1
35	Capteur35	3	4	3	4	1
53	Capteur53	6	2	5	2	1
54	Capteur54	6	3	5	3	1
55	Capteur55	6	4	5	4	1
28	Capteur28	2	8	2	7	1
17	Capteur17	1	7	1	6	1
7	Capteur7	0	7	0	6	1
8	Capteur8	0	8	0	7	1
9	Capteur9	0	9	0	8	1
11	Capteur11	1	0	1	0	1
12	Capteur12	1	1	1	1	1
13	Capteur13	1	2	1	2	1
14	Capteur14	1	3	1	3	1
21	Capteur21	2	0	2	0	1
22	Capteur22	2	1	2	1	1
23	Capteur23	2	2	2	2	1
24	Capteur24	2	3	2	3	1
26	Capteur26	2	6	2	5	1
27	Capteur27	2	7	2	6	1
29	Capteur29	2	9	2	8	1
30	Capteur30	2	10	2	9	1
41	Capteur41	4	0	4	0	1
42	Capteur42	4	1	4	1	1
43	Capteur43	4	2	4	2	1
44	Capteur44	4	3	4	3	1
45	Capteur45	4	4	4	4	1
46	Capteur46	4	6	4	5	1
47	Capteur47	4	7	4	6	1
15	Capteur15	1	4	1	4	1
56	Capteur56	6	6	5	5	1
57	Capteur57	6	7	5	6	1
58	Capteur58	6	8	5	7	1
60	Capteur60	6	10	5	9	1
61	Capteur61	7	0	6	0	1
62	Capteur62	7	1	6	1	1
63	Capteur63	7	2	6	2	1
2	Capteur2	0	1	0	1	1
\.


--
-- TOC entry 3420 (class 0 OID 16569)
-- Dependencies: 218
-- Data for Name: capteur_donnees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.capteur_donnees (id, id_type_capteur, id_capteur, valeur, date) FROM stdin;
\.


--
-- TOC entry 3412 (class 0 OID 16500)
-- Dependencies: 210
-- Data for Name: caserne; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.caserne (id, nom, adresse, code_postal, ville, tel, longitude, latitude) FROM stdin;
\.


--
-- TOC entry 3418 (class 0 OID 16540)
-- Dependencies: 216
-- Data for Name: detection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detection (id_incident, id_capteur) FROM stdin;
\.


--
-- TOC entry 3423 (class 0 OID 16588)
-- Dependencies: 221
-- Data for Name: historique; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.historique (id, id_capteur, id_type_capteur, valeur, date) FROM stdin;
\.


--
-- TOC entry 3417 (class 0 OID 16532)
-- Dependencies: 215
-- Data for Name: incident; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.incident (id, date_debut, date_fin, type, longitude, latitude, criticite, id_type_incident) FROM stdin;
\.


--
-- TOC entry 3419 (class 0 OID 16562)
-- Dependencies: 217
-- Data for Name: modele_capteur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.modele_capteur (id, libelle) FROM stdin;
1	Microbit feu
\.


--
-- TOC entry 3422 (class 0 OID 16583)
-- Dependencies: 220
-- Data for Name: modele_type_capteur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.modele_type_capteur (id_modele_capteur, id_type_capteur) FROM stdin;
\.


--
-- TOC entry 3413 (class 0 OID 16507)
-- Dependencies: 211
-- Data for Name: pompier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pompier (id, nom, prenom, age, tel, annees_experience, energie, id_caserne) FROM stdin;
\.


--
-- TOC entry 3416 (class 0 OID 16527)
-- Dependencies: 214
-- Data for Name: pompier_incident; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pompier_incident (id_pompier, id_incident) FROM stdin;
\.


--
-- TOC entry 3421 (class 0 OID 16576)
-- Dependencies: 219
-- Data for Name: type_capteur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.type_capteur (id, libelle) FROM stdin;
\.


--
-- TOC entry 3424 (class 0 OID 16633)
-- Dependencies: 222
-- Data for Name: type_incident; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.type_incident (id, libelle) FROM stdin;
\.


--
-- TOC entry 3414 (class 0 OID 16515)
-- Dependencies: 212
-- Data for Name: vehicule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vehicule (id, modele, num_immatriculation, capacite_personne, capactite_produit, type_produit, longitude, latitude, id_caserne) FROM stdin;
\.


--
-- TOC entry 3415 (class 0 OID 16522)
-- Dependencies: 213
-- Data for Name: vehicule_incident; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vehicule_incident (id_vehicule, id_incident) FROM stdin;
\.


--
-- TOC entry 3245 (class 2606 OID 16575)
-- Name: capteur_donnees capteur_donnees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur_donnees
    ADD CONSTRAINT capteur_donnees_pkey PRIMARY KEY (id_type_capteur);


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

