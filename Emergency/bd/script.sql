--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Started on 2022-01-03 15:37:45

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

--
-- TOC entry 3420 (class 0 OID 16419)
-- Dependencies: 209
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

INSERT INTO public.modele_capteur OVERRIDING SYSTEM VALUE VALUES (1, 'Microbit feu');


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


-- Completed on 2022-01-03 15:37:46

--
-- PostgreSQL database dump complete
--

