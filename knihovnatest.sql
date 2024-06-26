--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Ubuntu 14.9-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 16.2

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: seq_autor; Type: SEQUENCE; Schema: public; Owner: rimnacm
--

CREATE SEQUENCE public.seq_autor
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_autor OWNER TO rimnacm;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: autor; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.autor (
    id_autor integer DEFAULT nextval('public.seq_autor'::regclass) NOT NULL,
    jmeno character varying(64) NOT NULL,
    prijmeni character varying(64) NOT NULL
);


ALTER TABLE public.autor OWNER TO rimnacm;

--
-- Name: autorstvi; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.autorstvi (
    id_kniha integer NOT NULL,
    id_autor integer NOT NULL
);


ALTER TABLE public.autorstvi OWNER TO rimnacm;

--
-- Name: clenskyprispevek; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.clenskyprispevek (
    id_uzivatel integer NOT NULL,
    rok integer NOT NULL,
    platnyod timestamp without time zone NOT NULL,
    platnydo timestamp without time zone NOT NULL,
    vyse numeric(7,2) NOT NULL
);


ALTER TABLE public.clenskyprispevek OWNER TO rimnacm;

--
-- Name: doporuceni; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.doporuceni (
    id_uzivatel integer NOT NULL,
    id_uzivateldoporuceny integer NOT NULL
);


ALTER TABLE public.doporuceni OWNER TO rimnacm;

--
-- Name: exemplar; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.exemplar (
    cislo integer NOT NULL,
    id_kniha integer NOT NULL
);


ALTER TABLE public.exemplar OWNER TO rimnacm;

--
-- Name: kniha; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.kniha (
    id_kniha integer NOT NULL,
    isbn character(17) NOT NULL,
    nazev character varying(64) NOT NULL,
    rokvydani integer,
    anotace text,
    id_vydavatelstvi integer NOT NULL,
    url character varying(255) NOT NULL
);


ALTER TABLE public.kniha OWNER TO rimnacm;

--
-- Name: kniha_id_kniha_seq; Type: SEQUENCE; Schema: public; Owner: rimnacm
--

CREATE SEQUENCE public.kniha_id_kniha_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kniha_id_kniha_seq OWNER TO rimnacm;

--
-- Name: kniha_id_kniha_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rimnacm
--

ALTER SEQUENCE public.kniha_id_kniha_seq OWNED BY public.kniha.id_kniha;


--
-- Name: knihazanr; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.knihazanr (
    id_kniha integer NOT NULL,
    id_zanr integer NOT NULL
);


ALTER TABLE public.knihazanr OWNER TO rimnacm;

--
-- Name: komentar; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.komentar (
    id_uzivatel integer NOT NULL,
    id_kniha integer NOT NULL,
    vydan timestamp without time zone NOT NULL,
    nazev character varying(128) NOT NULL,
    obsah text NOT NULL
);


ALTER TABLE public.komentar OWNER TO rimnacm;

--
-- Name: operace; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.operace (
    id_operace integer NOT NULL,
    id_kniha integer NOT NULL,
    cislo integer NOT NULL,
    id_uzivatel integer NOT NULL,
    cenadenfloat real NOT NULL,
    cenaden numeric(7,2) NOT NULL,
    pokutadenfloat real NOT NULL,
    pokutaden numeric(7,2) NOT NULL,
    id_zamestnanecvypujcil integer NOT NULL,
    vypujcenood timestamp without time zone NOT NULL,
    vypujcenodo timestamp without time zone NOT NULL,
    id_zamestnanecvratil integer NOT NULL,
    stav integer,
    vraceno timestamp without time zone,
    CONSTRAINT operacestav CHECK (((stav >= '-100'::integer) AND (stav <= 100)))
);


ALTER TABLE public.operace OWNER TO rimnacm;

--
-- Name: operace_id_operace_seq; Type: SEQUENCE; Schema: public; Owner: rimnacm
--

CREATE SEQUENCE public.operace_id_operace_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.operace_id_operace_seq OWNER TO rimnacm;

--
-- Name: operace_id_operace_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rimnacm
--

ALTER SEQUENCE public.operace_id_operace_seq OWNED BY public.operace.id_operace;


--
-- Name: osobniudaje; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.osobniudaje (
    id_uzivatel integer NOT NULL,
    jmeno character varying(64) NOT NULL,
    prijmeni character varying(64) NOT NULL,
    narozen date NOT NULL,
    obec character varying NOT NULL,
    cp character varying(16) NOT NULL,
    ulice character varying(64) NOT NULL
);


ALTER TABLE public.osobniudaje OWNER TO rimnacm;

--
-- Name: pokus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pokus (
    id_pokus integer NOT NULL,
    nazev character varying(32) NOT NULL
);


ALTER TABLE public.pokus OWNER TO postgres;

--
-- Name: pokus_id_pokus_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pokus_id_pokus_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pokus_id_pokus_seq OWNER TO postgres;

--
-- Name: pokus_id_pokus_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pokus_id_pokus_seq OWNED BY public.pokus.id_pokus;


--
-- Name: rezervace; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.rezervace (
    id_uzivatel integer NOT NULL,
    id_kniha integer NOT NULL
);


ALTER TABLE public.rezervace OWNER TO rimnacm;

--
-- Name: seq_zanr; Type: SEQUENCE; Schema: public; Owner: rimnacm
--

CREATE SEQUENCE public.seq_zanr
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seq_zanr OWNER TO rimnacm;

--
-- Name: sledujici; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.sledujici (
    id_uzivatel integer NOT NULL,
    id_uzivatelsledujici integer NOT NULL
);


ALTER TABLE public.sledujici OWNER TO rimnacm;

--
-- Name: uzivatel; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.uzivatel (
    id_uzivatel integer NOT NULL,
    login character varying(64) NOT NULL,
    heslo bytea NOT NULL
);


ALTER TABLE public.uzivatel OWNER TO rimnacm;

--
-- Name: uzivatel_id_uzivatel_seq; Type: SEQUENCE; Schema: public; Owner: rimnacm
--

CREATE SEQUENCE public.uzivatel_id_uzivatel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.uzivatel_id_uzivatel_seq OWNER TO rimnacm;

--
-- Name: uzivatel_id_uzivatel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rimnacm
--

ALTER SEQUENCE public.uzivatel_id_uzivatel_seq OWNED BY public.uzivatel.id_uzivatel;


--
-- Name: vydavatelstvi; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.vydavatelstvi (
    id_vydavatelstvi integer NOT NULL,
    nazev character varying(64)
);


ALTER TABLE public.vydavatelstvi OWNER TO rimnacm;

--
-- Name: vydavatelstvi_id_vydavatelství_seq; Type: SEQUENCE; Schema: public; Owner: rimnacm
--

CREATE SEQUENCE public."vydavatelstvi_id_vydavatelství_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."vydavatelstvi_id_vydavatelství_seq" OWNER TO rimnacm;

--
-- Name: vydavatelstvi_id_vydavatelství_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rimnacm
--

ALTER SEQUENCE public."vydavatelstvi_id_vydavatelství_seq" OWNED BY public.vydavatelstvi.id_vydavatelstvi;


--
-- Name: zakaznik; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.zakaznik (
    id_uzivatel integer NOT NULL,
    id_zamestnaneczalozil integer NOT NULL,
    zalozen timestamp without time zone DEFAULT now()
);


ALTER TABLE public.zakaznik OWNER TO rimnacm;

--
-- Name: zamestnanec; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.zamestnanec (
    id_uzivatel integer NOT NULL,
    rodnecislo character(11) NOT NULL,
    telefon character varying(18) NOT NULL,
    mistnost character varying(16) NOT NULL,
    id_nadrizenyzamestnanec integer
);


ALTER TABLE public.zamestnanec OWNER TO rimnacm;

--
-- Name: zanr; Type: TABLE; Schema: public; Owner: rimnacm
--

CREATE TABLE public.zanr (
    id_zanr integer DEFAULT nextval('public.seq_zanr'::regclass) NOT NULL,
    nazev character varying(64),
    id_nadzanr integer
);


ALTER TABLE public.zanr OWNER TO rimnacm;

--
-- Name: kniha id_kniha; Type: DEFAULT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.kniha ALTER COLUMN id_kniha SET DEFAULT nextval('public.kniha_id_kniha_seq'::regclass);


--
-- Name: operace id_operace; Type: DEFAULT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.operace ALTER COLUMN id_operace SET DEFAULT nextval('public.operace_id_operace_seq'::regclass);


--
-- Name: pokus id_pokus; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pokus ALTER COLUMN id_pokus SET DEFAULT nextval('public.pokus_id_pokus_seq'::regclass);


--
-- Name: uzivatel id_uzivatel; Type: DEFAULT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.uzivatel ALTER COLUMN id_uzivatel SET DEFAULT nextval('public.uzivatel_id_uzivatel_seq'::regclass);


--
-- Name: vydavatelstvi id_vydavatelstvi; Type: DEFAULT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.vydavatelstvi ALTER COLUMN id_vydavatelstvi SET DEFAULT nextval('public."vydavatelstvi_id_vydavatelství_seq"'::regclass);


--
-- Data for Name: autor; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.autor (id_autor, jmeno, prijmeni) FROM stdin;
1	Petr	Vladyka
2	Jan	Tuček
3	Martin	Harák
4	Marta	Galewska-Kustra
5	Joanna	Klos
6	Radek	Vystavěl
\.


--
-- Data for Name: autorstvi; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.autorstvi (id_kniha, id_autor) FROM stdin;
1	1
2	2
3	2
4	3
5	4
5	5
7	6
\.


--
-- Data for Name: clenskyprispevek; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.clenskyprispevek (id_uzivatel, rok, platnyod, platnydo, vyse) FROM stdin;
5	2024	2024-02-01 00:00:00	2025-01-31 00:00:00	500.00
5	2023	2023-02-01 00:00:00	2024-01-31 00:00:00	500.00
5	2022	2022-02-01 00:00:00	2023-01-31 00:00:00	800.00
5	2021	2021-12-01 00:00:00	2022-01-31 00:00:00	300.00
6	2024	2024-03-27 00:00:00	2025-03-26 00:00:00	800.00
\.


--
-- Data for Name: doporuceni; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.doporuceni (id_uzivatel, id_uzivateldoporuceny) FROM stdin;
\.


--
-- Data for Name: exemplar; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.exemplar (cislo, id_kniha) FROM stdin;
1	1
2	1
1	2
2	2
3	2
4	2
5	2
6	2
7	2
8	2
1	3
2	3
3	3
4	3
5	3
6	3
7	3
8	3
1	4
2	4
3	4
1	5
2	5
\.


--
-- Data for Name: kniha; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.kniha (id_kniha, isbn, nazev, rokvydani, anotace, id_vydavatelstvi, url) FROM stdin;
1	978-80-242-6064-8	Učení a paměť pravou hemisférou	2018	Autor vystudoval pedagogickou fakultu UK a v současnosti pracuje jako specializovaný lektor na využití potenciálu mozku. Pořádá vysokoškolské semináře s celostátní akreditací, v nichž se soustředí především na téma komunikace a zážitkové alternativní metody ve vyučování. Přes dvacet let vede kurzy zaměřené na práci s pravou mozkovou hemisférou, progresivní učení, psychologii a rozvoj kreativního myšlení. Ve své knize, se zabývá otázkou zlepšování paměti, a jak sám říká v úvodu, publikace je určená pro všechny, kteří mají pocit, že tradičními metodami si toho normálně moc nezapamatují anebo se už léta učí cizí jazyk, ale stále jsou na jednom místě. Kniha je pojatá formou rozhovoru, v němž autor odpovídá na nejčastější dotazy, vysvětluje svou metodu a podává návod, jak postupovat.	1	https://www.databazeknih.cz/knihy/uceni-a-pamet-pravou-hemisferou-389670
3	978-80-271-0466-6	Auta první republiky	2017		2	https://www.luxor.cz/v/1495861/auta-prvni-republiky
4	978-80-271-3801-2	Ozubnicové a pozemní lanové dráhy Evropy	2023	Pozemní lanové a ozubnicové dráhy představují nejen oblíbený dopravní prostředek, ale často i velmi zajímavé technické a technologické řešení. V Evropě jich nejvíce najdeme – asi ne překvapivě – v alpských zemích (především ve Švýcarsku), na pozoruhodné trati ale můžeme narazit po celé Evropě včetně Česka a Slovenska. Výpravná publikace se věnuje hlavně drahám, které jsou v běžném provozu: historii jejich vzniku, technickým aspektům a zajímavostem, nechybí historické i současné fotografie a mapky tratí. Přehled je doplněn technickým úvodem k problematice drah překonávajících náročné stoupání, vysvětlením pojmu „šikmé výtahy“, popisem zajímavých zaniklých nebo transformovaných tratí a také stručnými turistickými tipy. Jízda lanovkou nebo zubačkou se totiž může při vašich cestách po Evropě stát jedním z největších zážitků!	2	https://www.luxor.cz/v/1974794/ozubnicove-a-pozemni-lanove-drahy-evropy
5	978-80-242-9703-3	Péťa umí vyprávět	2024	Pátý díl Péťových dobrodružství je tu! Tentokrát Péťu čekají velké změny: narodí se mu totiž nový sourozenec. Umí už vaše děťátko mluvit? S Péťou a jeho nejbližšími si procvičí své vypravěčské dovednosti. Pod každou velkou ilustrací najdete navíc další obrázky, které dětem pomohou popisovat a vyprávět. Co strana, to také otázka na téma, které děti v tomto věku začíná neobyčejně zajímat – vlastní narození. Vyprávějte, popisujte a povídejte si, užívejte si společně strávené chvíle.	3	https://www.luxor.cz/v/1999397/peta-umi-vypravet
7	978-80-908144-0-0	Databáze a SQL pro začátečníky	2021	Databáze jsou v počítačovém světě všudypřítomné. Najdete je v informačních systémech podniků, úřadů, škol, v internetových obchodech, v grafických, výpočetních či obchodních systémech. Znalost databází a neoddělitelně s nimi spjatého jazyka SQL tak patří k základní výbavě informatiků, ale nejen jich. Pracují s nimi sice především programátoři a správci systémů, jejich znalost je však nezřídka požadována i na ekonomických pozicích větších firem. Jak však začít, když je chcete studovat? Běžné knihy jako by byly psány pro ty, kdo již problematice rozumí. Postupují tak rychle, že se čtenář-začátečník ve výkladu brzy ztratí. A právě nedostatek knih o databázích a SQL na úvodní úrovni byl motivem vzniku knihy této. Jednotlivá témata zde najdete vysvětlena velice názorně a především po malých krůčcích, tempem přiměřeným čtenáři, který se s oborem prvně seznamuje. Kniha je organizována do podoby série řešených úloh, aby vás rychle vtáhla do akce, abyste si vše sami vyzkoušeli a o realizovaných úkonech a příkazech přemýšleli. Úlohy jsou vybrány tak, aby vás posunuly vždy o kousek dál, a ve většině případů odráží problémy řešené v reálné praxi zjednodušené na samé jádro. Publikace zkušeného autora, z jehož učebnic pronikají do počítačové problematiky zájemci po celém světě, je vzhledem k detailnímu výkladu vhodná nejen pro výuku ve školách, ale také k samostudiu.	4	https://www.luxor.cz/v/1893244/databaze-a-sql-pro-zacatecniky
2	978-80-247-5966-1	Auta v Československu 1945-1990	2024	Kniha připomíná více než 150 modelů automobilů, které se v Československu prodávaly v letech 1945 až 1990. Osobní vozy tří desítek různých značek pocházely z tuzemské výroby, ale také z dovozu, ať už z východní, nebo západní Evropy, výjimečně i z Japonska a Jižní Koreje. Popisy automobilů ilustruje 450 převážně barevných fotografií a kreseb.	2	https://www.luxor.cz/v/1996237/auta-v-ceskoslovensku-1945-1990
\.


--
-- Data for Name: knihazanr; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.knihazanr (id_kniha, id_zanr) FROM stdin;
1	1
1	2
1	3
2	1
2	2
1	4
1	5
3	1
3	2
3	4
3	5
4	1
4	2
4	4
4	6
5	1
5	7
\.


--
-- Data for Name: komentar; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.komentar (id_uzivatel, id_kniha, vydan, nazev, obsah) FROM stdin;
6	3	2024-04-04 11:08:04.217497	Super kniha	Naprosty banger
\.


--
-- Data for Name: operace; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.operace (id_operace, id_kniha, cislo, id_uzivatel, cenadenfloat, cenaden, pokutadenfloat, pokutaden, id_zamestnanecvypujcil, vypujcenood, vypujcenodo, id_zamestnanecvratil, stav, vraceno) FROM stdin;
\.


--
-- Data for Name: osobniudaje; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.osobniudaje (id_uzivatel, jmeno, prijmeni, narozen, obec, cp, ulice) FROM stdin;
1	Martin	Řimnáč	1966-06-30	Písek	244/8	náměstí Táboritů
3	Adéla	Řimnáčová	1966-06-30	Tábor	16	Na Pískách
5	Jan	Novak	1990-01-01	Praha	123	Hlavní
\.


--
-- Data for Name: pokus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pokus (id_pokus, nazev) FROM stdin;
1	rimnacm
2	student
4	student2
\.


--
-- Data for Name: rezervace; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.rezervace (id_uzivatel, id_kniha) FROM stdin;
5	1
5	4
6	1
5	5
6	5
\.


--
-- Data for Name: sledujici; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.sledujici (id_uzivatel, id_uzivatelsledujici) FROM stdin;
\.


--
-- Data for Name: uzivatel; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.uzivatel (id_uzivatel, login, heslo) FROM stdin;
1	rimnacm	\\x03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4
2	rimnack	\\x5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5
3	rimnaca	\\x34d128f5b3dede622e107438fbefabdf0519ebab21ac7b6f2075f974d09ce524
4	rimnacz	\\x5570b8fffb53088e058bb8676e9ff407906055343b2aeb12877b68e971f2bedd
5	uzitnyjosef	\\x2c910d64bd543f71a6ae05525bc0a20479277330bc3c9452789589725f8cf90b
6	uzitnaklara	\\xab98a00514445bb6571a3893b7ec3291ef9a2278dbf322b7bbe21e47c1cc886d
7	newuser	\\xdeadbeef
\.


--
-- Data for Name: vydavatelstvi; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.vydavatelstvi (id_vydavatelstvi, nazev) FROM stdin;
1	Universum (ČR)
2	Grada
3	Pikola
4	Moderní programování
\.


--
-- Data for Name: zakaznik; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.zakaznik (id_uzivatel, id_zamestnaneczalozil, zalozen) FROM stdin;
6	1	2024-03-27 10:44:20.942188
5	1	2021-11-30 11:23:41
2	1	2015-01-02 10:15:00
3	1	2020-10-10 12:00:00
\.


--
-- Data for Name: zamestnanec; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.zamestnanec (id_uzivatel, rodnecislo, telefon, mistnost, id_nadrizenyzamestnanec) FROM stdin;
1	670630/1234	+420 777 661 234	KN-E:306a	\N
2	670630/1235	+420 777 661 235	KN-E:306b	\N
3	670630/1236	+420 777 661 236	KN-E:306b	\N
4	670630/1237	+420 777 661 237	KN-E:311	1
\.


--
-- Data for Name: zanr; Type: TABLE DATA; Schema: public; Owner: rimnacm
--

COPY public.zanr (id_zanr, nazev, id_nadzanr) FROM stdin;
1	Literatura česká	\N
2	Literatura naučná	\N
3	Osobní rozvoj a styl	2
4	Encyklopedie	\N
5	Automobilismus	2
6	Železnice	\N
7	Dětské knihy	\N
\.


--
-- Name: kniha_id_kniha_seq; Type: SEQUENCE SET; Schema: public; Owner: rimnacm
--

SELECT pg_catalog.setval('public.kniha_id_kniha_seq', 7, true);


--
-- Name: operace_id_operace_seq; Type: SEQUENCE SET; Schema: public; Owner: rimnacm
--

SELECT pg_catalog.setval('public.operace_id_operace_seq', 1, false);


--
-- Name: pokus_id_pokus_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pokus_id_pokus_seq', 4, true);


--
-- Name: seq_autor; Type: SEQUENCE SET; Schema: public; Owner: rimnacm
--

SELECT pg_catalog.setval('public.seq_autor', 6, true);


--
-- Name: seq_zanr; Type: SEQUENCE SET; Schema: public; Owner: rimnacm
--

SELECT pg_catalog.setval('public.seq_zanr', 7, true);


--
-- Name: uzivatel_id_uzivatel_seq; Type: SEQUENCE SET; Schema: public; Owner: rimnacm
--

SELECT pg_catalog.setval('public.uzivatel_id_uzivatel_seq', 6, true);


--
-- Name: vydavatelstvi_id_vydavatelství_seq; Type: SEQUENCE SET; Schema: public; Owner: rimnacm
--

SELECT pg_catalog.setval('public."vydavatelstvi_id_vydavatelství_seq"', 4, true);


--
-- Name: autor autor_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.autor
    ADD CONSTRAINT autor_pkey PRIMARY KEY (id_autor);


--
-- Name: autorstvi autorstvi_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.autorstvi
    ADD CONSTRAINT autorstvi_pkey PRIMARY KEY (id_kniha, id_autor);


--
-- Name: clenskyprispevek clenskyprispevek_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.clenskyprispevek
    ADD CONSTRAINT clenskyprispevek_pkey PRIMARY KEY (rok, id_uzivatel);


--
-- Name: doporuceni doporuceni_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.doporuceni
    ADD CONSTRAINT doporuceni_pkey PRIMARY KEY (id_uzivateldoporuceny, id_uzivatel);


--
-- Name: exemplar exemplar_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.exemplar
    ADD CONSTRAINT exemplar_pkey PRIMARY KEY (cislo, id_kniha);


--
-- Name: kniha kniha_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.kniha
    ADD CONSTRAINT kniha_pkey PRIMARY KEY (id_kniha);


--
-- Name: knihazanr knihazanr_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.knihazanr
    ADD CONSTRAINT knihazanr_pkey PRIMARY KEY (id_kniha, id_zanr);


--
-- Name: komentar komentar_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.komentar
    ADD CONSTRAINT komentar_pkey PRIMARY KEY (vydan, id_kniha, id_uzivatel);


--
-- Name: osobniudaje osobniudaje_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.osobniudaje
    ADD CONSTRAINT osobniudaje_pkey PRIMARY KEY (id_uzivatel);


--
-- Name: pokus pokus_nazev_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pokus
    ADD CONSTRAINT pokus_nazev_key UNIQUE (nazev);


--
-- Name: pokus pokus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pokus
    ADD CONSTRAINT pokus_pkey PRIMARY KEY (id_pokus);


--
-- Name: rezervace rezervace_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.rezervace
    ADD CONSTRAINT rezervace_pkey PRIMARY KEY (id_uzivatel, id_kniha);


--
-- Name: sledujici sledujici_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.sledujici
    ADD CONSTRAINT sledujici_pkey PRIMARY KEY (id_uzivatelsledujici, id_uzivatel);


--
-- Name: uzivatel uzivatel_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.uzivatel
    ADD CONSTRAINT uzivatel_pkey PRIMARY KEY (id_uzivatel);


--
-- Name: vydavatelstvi vydavatelstvi_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.vydavatelstvi
    ADD CONSTRAINT vydavatelstvi_pkey PRIMARY KEY (id_vydavatelstvi);


--
-- Name: zakaznik zakaznik_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.zakaznik
    ADD CONSTRAINT zakaznik_pkey PRIMARY KEY (id_uzivatel);


--
-- Name: zamestnanec zamestnanec_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.zamestnanec
    ADD CONSTRAINT zamestnanec_pkey PRIMARY KEY (id_uzivatel);


--
-- Name: zanr zanr_pkey; Type: CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.zanr
    ADD CONSTRAINT zanr_pkey PRIMARY KEY (id_zanr);


--
-- Name: autoruq; Type: INDEX; Schema: public; Owner: rimnacm
--

CREATE UNIQUE INDEX autoruq ON public.autor USING btree (jmeno, prijmeni);


--
-- Name: knihanazevvydavatelstvirokuq; Type: INDEX; Schema: public; Owner: rimnacm
--

CREATE UNIQUE INDEX knihanazevvydavatelstvirokuq ON public.kniha USING btree (nazev, rokvydani, id_vydavatelstvi);


--
-- Name: knihaurluq; Type: INDEX; Schema: public; Owner: rimnacm
--

CREATE UNIQUE INDEX knihaurluq ON public.kniha USING btree (url);


--
-- Name: komentarnazevvydanuq; Type: INDEX; Schema: public; Owner: rimnacm
--

CREATE UNIQUE INDEX komentarnazevvydanuq ON public.komentar USING btree (vydan, nazev);


--
-- Name: operaceexemplaruq; Type: INDEX; Schema: public; Owner: rimnacm
--

CREATE UNIQUE INDEX operaceexemplaruq ON public.operace USING btree (id_kniha, cislo, vypujcenood);


--
-- Name: operacezakaznikuq; Type: INDEX; Schema: public; Owner: rimnacm
--

CREATE UNIQUE INDEX operacezakaznikuq ON public.operace USING btree (id_uzivatel, vypujcenood);


--
-- Name: operacezamestanecvratiluq; Type: INDEX; Schema: public; Owner: rimnacm
--

CREATE UNIQUE INDEX operacezamestanecvratiluq ON public.operace USING btree (id_zamestnanecvratil, vraceno);


--
-- Name: operacezamestnanecvypujciluq; Type: INDEX; Schema: public; Owner: rimnacm
--

CREATE UNIQUE INDEX operacezamestnanecvypujciluq ON public.operace USING btree (id_zamestnanecvypujcil, vypujcenood);


--
-- Name: osobniudajejpnuq; Type: INDEX; Schema: public; Owner: rimnacm
--

CREATE UNIQUE INDEX osobniudajejpnuq ON public.osobniudaje USING btree (jmeno, prijmeni, narozen);


--
-- Name: uzivatelloginuq; Type: INDEX; Schema: public; Owner: rimnacm
--

CREATE UNIQUE INDEX uzivatelloginuq ON public.uzivatel USING btree (login);


--
-- Name: vydavatelstviuq; Type: INDEX; Schema: public; Owner: rimnacm
--

CREATE UNIQUE INDEX vydavatelstviuq ON public.vydavatelstvi USING btree (nazev);


--
-- Name: zamestnanecrcuq; Type: INDEX; Schema: public; Owner: rimnacm
--

CREATE UNIQUE INDEX zamestnanecrcuq ON public.zamestnanec USING btree (rodnecislo);


--
-- Name: zanruq; Type: INDEX; Schema: public; Owner: rimnacm
--

CREATE UNIQUE INDEX zanruq ON public.zanr USING btree (nazev);


--
-- Name: autorstvi autorstviautor; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.autorstvi
    ADD CONSTRAINT autorstviautor FOREIGN KEY (id_autor) REFERENCES public.autor(id_autor);


--
-- Name: autorstvi autorstviknihy; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.autorstvi
    ADD CONSTRAINT autorstviknihy FOREIGN KEY (id_kniha) REFERENCES public.kniha(id_kniha);


--
-- Name: clenskyprispevek clenskyprispeveksetzakaznik; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.clenskyprispevek
    ADD CONSTRAINT clenskyprispeveksetzakaznik FOREIGN KEY (id_uzivatel) REFERENCES public.zakaznik(id_uzivatel);


--
-- Name: doporuceni doporucenizakaznik; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.doporuceni
    ADD CONSTRAINT doporucenizakaznik FOREIGN KEY (id_uzivateldoporuceny) REFERENCES public.zakaznik(id_uzivatel);


--
-- Name: doporuceni doporucenyzakaznik; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.doporuceni
    ADD CONSTRAINT doporucenyzakaznik FOREIGN KEY (id_uzivatel) REFERENCES public.zakaznik(id_uzivatel);


--
-- Name: exemplar exemplarsetkniha; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.exemplar
    ADD CONSTRAINT exemplarsetkniha FOREIGN KEY (id_kniha) REFERENCES public.kniha(id_kniha);


--
-- Name: komentar komentarknihy; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.komentar
    ADD CONSTRAINT komentarknihy FOREIGN KEY (id_kniha) REFERENCES public.kniha(id_kniha);


--
-- Name: komentar komentarzakaznika; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.komentar
    ADD CONSTRAINT komentarzakaznika FOREIGN KEY (id_uzivatel) REFERENCES public.zakaznik(id_uzivatel);


--
-- Name: zamestnanec nadrizenyzamestnanec; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.zamestnanec
    ADD CONSTRAINT nadrizenyzamestnanec FOREIGN KEY (id_nadrizenyzamestnanec) REFERENCES public.zamestnanec(id_uzivatel);


--
-- Name: zanr nadzanr; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.zanr
    ADD CONSTRAINT nadzanr FOREIGN KEY (id_nadzanr) REFERENCES public.zanr(id_zanr);


--
-- Name: operace operaceexemplare; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.operace
    ADD CONSTRAINT operaceexemplare FOREIGN KEY (cislo, id_kniha) REFERENCES public.exemplar(cislo, id_kniha);


--
-- Name: operace operacezakaznika; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.operace
    ADD CONSTRAINT operacezakaznika FOREIGN KEY (id_uzivatel) REFERENCES public.zakaznik(id_uzivatel);


--
-- Name: rezervace rezervaceknihy; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.rezervace
    ADD CONSTRAINT rezervaceknihy FOREIGN KEY (id_kniha) REFERENCES public.kniha(id_kniha);


--
-- Name: rezervace rezervacezakaznika; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.rezervace
    ADD CONSTRAINT rezervacezakaznika FOREIGN KEY (id_uzivatel) REFERENCES public.zakaznik(id_uzivatel);


--
-- Name: sledujici sledovanyzakaznik; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.sledujici
    ADD CONSTRAINT sledovanyzakaznik FOREIGN KEY (id_uzivatel) REFERENCES public.zakaznik(id_uzivatel);


--
-- Name: sledujici sledujicizakaznik; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.sledujici
    ADD CONSTRAINT sledujicizakaznik FOREIGN KEY (id_uzivatelsledujici) REFERENCES public.zakaznik(id_uzivatel);


--
-- Name: osobniudaje uzivatelmuzemit; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.osobniudaje
    ADD CONSTRAINT uzivatelmuzemit FOREIGN KEY (id_uzivatel) REFERENCES public.uzivatel(id_uzivatel);


--
-- Name: operace vracejicizamestnanec; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.operace
    ADD CONSTRAINT vracejicizamestnanec FOREIGN KEY (id_zamestnanecvratil) REFERENCES public.zamestnanec(id_uzivatel);


--
-- Name: kniha vydavatel; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.kniha
    ADD CONSTRAINT vydavatel FOREIGN KEY (id_vydavatelstvi) REFERENCES public.vydavatelstvi(id_vydavatelstvi);


--
-- Name: operace vypucujicizamestnanec; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.operace
    ADD CONSTRAINT vypucujicizamestnanec FOREIGN KEY (id_zamestnanecvypujcil) REFERENCES public.zamestnanec(id_uzivatel);


--
-- Name: zakaznik zakaznikisauzivatel; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.zakaznik
    ADD CONSTRAINT zakaznikisauzivatel FOREIGN KEY (id_uzivatel) REFERENCES public.uzivatel(id_uzivatel);


--
-- Name: zakaznik zakaznikzalozenzamestnancem; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.zakaznik
    ADD CONSTRAINT zakaznikzalozenzamestnancem FOREIGN KEY (id_zamestnaneczalozil) REFERENCES public.zamestnanec(id_uzivatel);


--
-- Name: zamestnanec zamestnanecisauzivatel; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.zamestnanec
    ADD CONSTRAINT zamestnanecisauzivatel FOREIGN KEY (id_uzivatel) REFERENCES public.uzivatel(id_uzivatel);


--
-- Name: knihazanr zanrknihy_kniha; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.knihazanr
    ADD CONSTRAINT zanrknihy_kniha FOREIGN KEY (id_kniha) REFERENCES public.kniha(id_kniha);


--
-- Name: knihazanr zanrknihy_zanr; Type: FK CONSTRAINT; Schema: public; Owner: rimnacm
--

ALTER TABLE ONLY public.knihazanr
    ADD CONSTRAINT zanrknihy_zanr FOREIGN KEY (id_zanr) REFERENCES public.zanr(id_zanr);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO rimnacm;


--
-- Name: SEQUENCE seq_autor; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON SEQUENCE public.seq_autor TO dbs24;
GRANT ALL ON SEQUENCE public.seq_autor TO teachers;


--
-- Name: TABLE autor; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.autor TO teachers;
GRANT ALL ON TABLE public.autor TO dbs24;


--
-- Name: TABLE autorstvi; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.autorstvi TO teachers;
GRANT ALL ON TABLE public.autorstvi TO dbs24;


--
-- Name: TABLE clenskyprispevek; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.clenskyprispevek TO teachers;
GRANT ALL ON TABLE public.clenskyprispevek TO dbs24;


--
-- Name: TABLE doporuceni; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.doporuceni TO teachers;
GRANT ALL ON TABLE public.doporuceni TO dbs24;


--
-- Name: TABLE exemplar; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.exemplar TO teachers;
GRANT ALL ON TABLE public.exemplar TO dbs24;


--
-- Name: TABLE kniha; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.kniha TO teachers;
GRANT ALL ON TABLE public.kniha TO dbs24;


--
-- Name: SEQUENCE kniha_id_kniha_seq; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON SEQUENCE public.kniha_id_kniha_seq TO dbs24;
GRANT ALL ON SEQUENCE public.kniha_id_kniha_seq TO teachers;


--
-- Name: TABLE knihazanr; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.knihazanr TO teachers;
GRANT ALL ON TABLE public.knihazanr TO dbs24;


--
-- Name: TABLE komentar; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.komentar TO teachers;
GRANT ALL ON TABLE public.komentar TO dbs24;


--
-- Name: TABLE operace; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.operace TO teachers;
GRANT ALL ON TABLE public.operace TO dbs24;


--
-- Name: SEQUENCE operace_id_operace_seq; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON SEQUENCE public.operace_id_operace_seq TO dbs24;
GRANT ALL ON SEQUENCE public.operace_id_operace_seq TO teachers;


--
-- Name: TABLE osobniudaje; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.osobniudaje TO teachers;
GRANT ALL ON TABLE public.osobniudaje TO dbs24;


--
-- Name: TABLE pokus; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.pokus TO teachers;
GRANT ALL ON TABLE public.pokus TO dbs24;


--
-- Name: SEQUENCE pokus_id_pokus_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.pokus_id_pokus_seq TO dbs24;
GRANT ALL ON SEQUENCE public.pokus_id_pokus_seq TO teachers;


--
-- Name: TABLE rezervace; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.rezervace TO teachers;
GRANT ALL ON TABLE public.rezervace TO dbs24;


--
-- Name: SEQUENCE seq_zanr; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON SEQUENCE public.seq_zanr TO dbs24;
GRANT ALL ON SEQUENCE public.seq_zanr TO teachers;


--
-- Name: TABLE sledujici; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.sledujici TO teachers;
GRANT ALL ON TABLE public.sledujici TO dbs24;


--
-- Name: TABLE uzivatel; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.uzivatel TO teachers;
GRANT ALL ON TABLE public.uzivatel TO dbs24;


--
-- Name: SEQUENCE uzivatel_id_uzivatel_seq; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON SEQUENCE public.uzivatel_id_uzivatel_seq TO dbs24;
GRANT ALL ON SEQUENCE public.uzivatel_id_uzivatel_seq TO teachers;


--
-- Name: TABLE vydavatelstvi; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.vydavatelstvi TO teachers;
GRANT ALL ON TABLE public.vydavatelstvi TO dbs24;


--
-- Name: SEQUENCE "vydavatelstvi_id_vydavatelství_seq"; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON SEQUENCE public."vydavatelstvi_id_vydavatelství_seq" TO dbs24;
GRANT ALL ON SEQUENCE public."vydavatelstvi_id_vydavatelství_seq" TO teachers;


--
-- Name: TABLE zakaznik; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.zakaznik TO teachers;
GRANT ALL ON TABLE public.zakaznik TO dbs24;


--
-- Name: TABLE zamestnanec; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.zamestnanec TO teachers;
GRANT ALL ON TABLE public.zamestnanec TO dbs24;


--
-- Name: TABLE zanr; Type: ACL; Schema: public; Owner: rimnacm
--

GRANT ALL ON TABLE public.zanr TO teachers;
GRANT ALL ON TABLE public.zanr TO dbs24;


--
-- PostgreSQL database dump complete
--

