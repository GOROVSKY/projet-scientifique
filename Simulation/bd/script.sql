--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Started on 2022-01-03 17:13:01

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
-- TOC entry 214 (class 1259 OID 16776)
-- Name: capteur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.capteur (
    id integer NOT NULL,
    code text,
    latitude numeric(8,0),
    longitude numeric(8,0),
    ligne integer,
    colonne integer,
    id_modele integer NOT NULL
);


ALTER TABLE public.capteur OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16791)
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
-- TOC entry 216 (class 1259 OID 16796)
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
-- TOC entry 211 (class 1259 OID 16751)
-- Name: modele_capteur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modele_capteur (
    id integer NOT NULL,
    libelle text NOT NULL
);


ALTER TABLE public.modele_capteur OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16756)
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
-- TOC entry 213 (class 1259 OID 16759)
-- Name: modele_type_capteur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modele_type_capteur (
    id_modele_capteur integer NOT NULL,
    id_type_capteur integer NOT NULL
);


ALTER TABLE public.modele_type_capteur OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16743)
-- Name: type_capteur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.type_capteur (
    id integer NOT NULL,
    libelle text
);


ALTER TABLE public.type_capteur OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16748)
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
-- TOC entry 3345 (class 0 OID 16776)
-- Dependencies: 214
-- Data for Name: capteur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.capteur VALUES (64, 'Capteur64', 7, 3, 6, 3, 1);
INSERT INTO public.capteur VALUES (65, 'Capteur65', 7, 4, 6, 4, 1);
INSERT INTO public.capteur VALUES (31, 'Capteur31', 3, 0, 3, 0, 1);
INSERT INTO public.capteur VALUES (33, 'Capteur33', 3, 2, 3, 2, 1);
INSERT INTO public.capteur VALUES (66, 'Capteur66', 7, 6, 6, 5, 1);
INSERT INTO public.capteur VALUES (1, 'Capteur1', 0, 0, 0, 0, 1);
INSERT INTO public.capteur VALUES (3, 'Capteur3', 0, 2, 0, 2, 1);
INSERT INTO public.capteur VALUES (4, 'Capteur4', 0, 3, 0, 3, 1);
INSERT INTO public.capteur VALUES (5, 'Capteur5', 0, 4, 0, 4, 1);
INSERT INTO public.capteur VALUES (16, 'Capteur16', 1, 6, 1, 5, 1);
INSERT INTO public.capteur VALUES (34, 'Capteur34', 3, 3, 3, 3, 1);
INSERT INTO public.capteur VALUES (36, 'Capteur36', 3, 6, 3, 5, 1);
INSERT INTO public.capteur VALUES (37, 'Capteur37', 3, 7, 3, 6, 1);
INSERT INTO public.capteur VALUES (67, 'Capteur67', 7, 7, 6, 6, 1);
INSERT INTO public.capteur VALUES (6, 'Capteur6', 0, 6, 0, 5, 1);
INSERT INTO public.capteur VALUES (18, 'Capteur18', 1, 8, 1, 7, 1);
INSERT INTO public.capteur VALUES (48, 'Capteur48', 4, 8, 4, 7, 1);
INSERT INTO public.capteur VALUES (49, 'Capteur49', 4, 9, 4, 8, 1);
INSERT INTO public.capteur VALUES (50, 'Capteur50', 4, 10, 4, 9, 1);
INSERT INTO public.capteur VALUES (51, 'Capteur51', 6, 0, 5, 0, 1);
INSERT INTO public.capteur VALUES (52, 'Capteur52', 6, 1, 5, 1, 1);
INSERT INTO public.capteur VALUES (68, 'Capteur68', 7, 8, 6, 7, 1);
INSERT INTO public.capteur VALUES (19, 'Capteur19', 1, 9, 1, 8, 1);
INSERT INTO public.capteur VALUES (38, 'Capteur38', 3, 8, 3, 7, 1);
INSERT INTO public.capteur VALUES (39, 'Capteur39', 3, 9, 3, 8, 1);
INSERT INTO public.capteur VALUES (40, 'Capteur40', 3, 10, 3, 9, 1);
INSERT INTO public.capteur VALUES (69, 'Capteur69', 7, 9, 6, 8, 1);
INSERT INTO public.capteur VALUES (70, 'Capteur70', 7, 10, 6, 9, 1);
INSERT INTO public.capteur VALUES (59, 'Capteur59', 6, 9, 5, 8, 1);
INSERT INTO public.capteur VALUES (10, 'Capteur10', 0, 10, 0, 9, 1);
INSERT INTO public.capteur VALUES (20, 'Capteur20', 1, 10, 1, 9, 1);
INSERT INTO public.capteur VALUES (32, 'Capteur32', 3, 1, 3, 1, 1);
INSERT INTO public.capteur VALUES (25, 'Capteur25', 2, 4, 2, 4, 1);
INSERT INTO public.capteur VALUES (35, 'Capteur35', 3, 4, 3, 4, 1);
INSERT INTO public.capteur VALUES (53, 'Capteur53', 6, 2, 5, 2, 1);
INSERT INTO public.capteur VALUES (54, 'Capteur54', 6, 3, 5, 3, 1);
INSERT INTO public.capteur VALUES (55, 'Capteur55', 6, 4, 5, 4, 1);
INSERT INTO public.capteur VALUES (28, 'Capteur28', 2, 8, 2, 7, 1);
INSERT INTO public.capteur VALUES (17, 'Capteur17', 1, 7, 1, 6, 1);
INSERT INTO public.capteur VALUES (7, 'Capteur7', 0, 7, 0, 6, 1);
INSERT INTO public.capteur VALUES (8, 'Capteur8', 0, 8, 0, 7, 1);
INSERT INTO public.capteur VALUES (9, 'Capteur9', 0, 9, 0, 8, 1);
INSERT INTO public.capteur VALUES (11, 'Capteur11', 1, 0, 1, 0, 1);
INSERT INTO public.capteur VALUES (12, 'Capteur12', 1, 1, 1, 1, 1);
INSERT INTO public.capteur VALUES (13, 'Capteur13', 1, 2, 1, 2, 1);
INSERT INTO public.capteur VALUES (14, 'Capteur14', 1, 3, 1, 3, 1);
INSERT INTO public.capteur VALUES (21, 'Capteur21', 2, 0, 2, 0, 1);
INSERT INTO public.capteur VALUES (22, 'Capteur22', 2, 1, 2, 1, 1);
INSERT INTO public.capteur VALUES (23, 'Capteur23', 2, 2, 2, 2, 1);
INSERT INTO public.capteur VALUES (24, 'Capteur24', 2, 3, 2, 3, 1);
INSERT INTO public.capteur VALUES (26, 'Capteur26', 2, 6, 2, 5, 1);
INSERT INTO public.capteur VALUES (27, 'Capteur27', 2, 7, 2, 6, 1);
INSERT INTO public.capteur VALUES (29, 'Capteur29', 2, 9, 2, 8, 1);
INSERT INTO public.capteur VALUES (30, 'Capteur30', 2, 10, 2, 9, 1);
INSERT INTO public.capteur VALUES (41, 'Capteur41', 4, 0, 4, 0, 1);
INSERT INTO public.capteur VALUES (42, 'Capteur42', 4, 1, 4, 1, 1);
INSERT INTO public.capteur VALUES (43, 'Capteur43', 4, 2, 4, 2, 1);
INSERT INTO public.capteur VALUES (44, 'Capteur44', 4, 3, 4, 3, 1);
INSERT INTO public.capteur VALUES (45, 'Capteur45', 4, 4, 4, 4, 1);
INSERT INTO public.capteur VALUES (46, 'Capteur46', 4, 6, 4, 5, 1);
INSERT INTO public.capteur VALUES (47, 'Capteur47', 4, 7, 4, 6, 1);
INSERT INTO public.capteur VALUES (15, 'Capteur15', 1, 4, 1, 4, 1);
INSERT INTO public.capteur VALUES (56, 'Capteur56', 6, 6, 5, 5, 1);
INSERT INTO public.capteur VALUES (57, 'Capteur57', 6, 7, 5, 6, 1);
INSERT INTO public.capteur VALUES (58, 'Capteur58', 6, 8, 5, 7, 1);
INSERT INTO public.capteur VALUES (60, 'Capteur60', 6, 10, 5, 9, 1);
INSERT INTO public.capteur VALUES (61, 'Capteur61', 7, 0, 6, 0, 1);
INSERT INTO public.capteur VALUES (62, 'Capteur62', 7, 1, 6, 1, 1);
INSERT INTO public.capteur VALUES (63, 'Capteur63', 7, 2, 6, 2, 1);
INSERT INTO public.capteur VALUES (2, 'Capteur2', 0, 1, 0, 1, 1);


--
-- TOC entry 3346 (class 0 OID 16791)
-- Dependencies: 215
-- Data for Name: capteur_donnees; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3342 (class 0 OID 16751)
-- Dependencies: 211
-- Data for Name: modele_capteur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.modele_capteur OVERRIDING SYSTEM VALUE VALUES (1, 'Microbit feu');


--
-- TOC entry 3344 (class 0 OID 16759)
-- Dependencies: 213
-- Data for Name: modele_type_capteur; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3340 (class 0 OID 16743)
-- Dependencies: 209
-- Data for Name: type_capteur; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3353 (class 0 OID 0)
-- Dependencies: 216
-- Name: capteur_donnees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.capteur_donnees_id_seq', 1, false);


--
-- TOC entry 3354 (class 0 OID 0)
-- Dependencies: 212
-- Name: modele_capteur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.modele_capteur_id_seq', 1, false);


--
-- TOC entry 3355 (class 0 OID 0)
-- Dependencies: 210
-- Name: type_capteur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.type_capteur_id_seq', 1, false);


--
-- TOC entry 3196 (class 2606 OID 16798)
-- Name: capteur_donnees capteur_donnes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur_donnees
    ADD CONSTRAINT capteur_donnes_pk PRIMARY KEY (id);


--
-- TOC entry 3185 (class 2606 OID 16758)
-- Name: modele_capteur modele_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele_capteur
    ADD CONSTRAINT modele_pkey PRIMARY KEY (id);


--
-- TOC entry 3189 (class 2606 OID 16763)
-- Name: modele_type_capteur modele_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele_type_capteur
    ADD CONSTRAINT modele_type_pkey PRIMARY KEY (id_modele_capteur, id_type_capteur);


--
-- TOC entry 3194 (class 2606 OID 16782)
-- Name: capteur sensor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur
    ADD CONSTRAINT sensor_pkey PRIMARY KEY (id);


--
-- TOC entry 3183 (class 2606 OID 16750)
-- Name: type_capteur type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.type_capteur
    ADD CONSTRAINT type_pkey PRIMARY KEY (id);


--
-- TOC entry 3190 (class 1259 OID 16783)
-- Name: fki_fk_id_modele; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_id_modele ON public.capteur USING btree (id_modele);


--
-- TOC entry 3191 (class 1259 OID 16784)
-- Name: fki_fk_id_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_id_type ON public.capteur USING btree (id_modele);


--
-- TOC entry 3186 (class 1259 OID 16764)
-- Name: fki_fk_modele; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_modele ON public.modele_type_capteur USING btree (id_modele_capteur);


--
-- TOC entry 3192 (class 1259 OID 16785)
-- Name: fki_fk_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_type ON public.capteur USING btree (id_modele);


--
-- TOC entry 3187 (class 1259 OID 16765)
-- Name: fki_fk_type_capteur; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_type_capteur ON public.modele_type_capteur USING btree (id_type_capteur);


--
-- TOC entry 3199 (class 2606 OID 16786)
-- Name: capteur fk_id_modele; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur
    ADD CONSTRAINT fk_id_modele FOREIGN KEY (id_modele) REFERENCES public.modele_capteur(id);


--
-- TOC entry 3197 (class 2606 OID 16766)
-- Name: modele_type_capteur fk_modele_capteur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele_type_capteur
    ADD CONSTRAINT fk_modele_capteur FOREIGN KEY (id_modele_capteur) REFERENCES public.modele_capteur(id);


--
-- TOC entry 3198 (class 2606 OID 16771)
-- Name: modele_type_capteur fk_type_capteur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modele_type_capteur
    ADD CONSTRAINT fk_type_capteur FOREIGN KEY (id_type_capteur) REFERENCES public.type_capteur(id);


--
-- TOC entry 3200 (class 2606 OID 16799)
-- Name: capteur_donnees fk_type_capteur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.capteur_donnees
    ADD CONSTRAINT fk_type_capteur FOREIGN KEY (id_type_capteur) REFERENCES public.type_capteur(id);


-- Completed on 2022-01-03 17:13:01

--
-- PostgreSQL database dump complete
--

