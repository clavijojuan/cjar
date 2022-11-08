--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

-- Started on 2022-11-08 08:58:31

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
-- TOC entry 5 (class 2615 OID 1839658)
-- Name: piezas; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA piezas;


ALTER SCHEMA piezas OWNER TO postgres;

--
-- TOC entry 7 (class 2615 OID 1839659)
-- Name: plantas; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA plantas;


ALTER SCHEMA plantas OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 1839660)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 3208 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 1839897)
-- Name: animal; Type: TABLE; Schema: piezas; Owner: postgres
--

CREATE TABLE piezas.animal (
    id integer NOT NULL,
    especie_fk integer NOT NULL,
    genero_fk integer NOT NULL,
    convenio_fk integer,
    familia_fk integer NOT NULL,
    locacion_fk integer NOT NULL,
    nombre character varying(40),
    repositorio character varying(40),
    fecha_colecta date,
    identificador_alterno character varying(10)
);


ALTER TABLE piezas.animal OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 1839895)
-- Name: animal_id_seq; Type: SEQUENCE; Schema: piezas; Owner: postgres
--

CREATE SEQUENCE piezas.animal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE piezas.animal_id_seq OWNER TO postgres;

--
-- TOC entry 3209 (class 0 OID 0)
-- Dependencies: 225
-- Name: animal_id_seq; Type: SEQUENCE OWNED BY; Schema: piezas; Owner: postgres
--

ALTER SEQUENCE piezas.animal_id_seq OWNED BY piezas.animal.id;


--
-- TOC entry 218 (class 1259 OID 1839845)
-- Name: convenio; Type: TABLE; Schema: piezas; Owner: postgres
--

CREATE TABLE piezas.convenio (
    id integer NOT NULL,
    nombre character varying
);


ALTER TABLE piezas.convenio OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 1839843)
-- Name: convenio_id_seq; Type: SEQUENCE; Schema: piezas; Owner: postgres
--

CREATE SEQUENCE piezas.convenio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE piezas.convenio_id_seq OWNER TO postgres;

--
-- TOC entry 3210 (class 0 OID 0)
-- Dependencies: 217
-- Name: convenio_id_seq; Type: SEQUENCE OWNED BY; Schema: piezas; Owner: postgres
--

ALTER SEQUENCE piezas.convenio_id_seq OWNED BY piezas.convenio.id;


--
-- TOC entry 210 (class 1259 OID 1839810)
-- Name: localidad; Type: TABLE; Schema: piezas; Owner: postgres
--

CREATE TABLE piezas.localidad (
    id integer NOT NULL,
    nombre character varying(40),
    pais character varying(40),
    latitud real,
    longitud real,
    polaridad character varying(10),
    altura double precision,
    comentario character varying(180)
);


ALTER TABLE piezas.localidad OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 1839808)
-- Name: localidad_id_seq; Type: SEQUENCE; Schema: piezas; Owner: postgres
--

CREATE SEQUENCE piezas.localidad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE piezas.localidad_id_seq OWNER TO postgres;

--
-- TOC entry 3211 (class 0 OID 0)
-- Dependencies: 209
-- Name: localidad_id_seq; Type: SEQUENCE OWNED BY; Schema: piezas; Owner: postgres
--

ALTER SEQUENCE piezas.localidad_id_seq OWNED BY piezas.localidad.id;


--
-- TOC entry 208 (class 1259 OID 1839799)
-- Name: foto; Type: TABLE; Schema: plantas; Owner: postgres
--

CREATE TABLE plantas.foto (
    id integer NOT NULL,
    ruta character varying
);


ALTER TABLE plantas.foto OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 1839797)
-- Name: foto_id_seq; Type: SEQUENCE; Schema: plantas; Owner: postgres
--

CREATE SEQUENCE plantas.foto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE plantas.foto_id_seq OWNER TO postgres;

--
-- TOC entry 3212 (class 0 OID 0)
-- Dependencies: 207
-- Name: foto_id_seq; Type: SEQUENCE OWNED BY; Schema: plantas; Owner: postgres
--

ALTER SEQUENCE plantas.foto_id_seq OWNED BY plantas.foto.id;


--
-- TOC entry 228 (class 1259 OID 1839940)
-- Name: planta; Type: TABLE; Schema: plantas; Owner: postgres
--

CREATE TABLE plantas.planta (
    id integer NOT NULL,
    foto_fk integer,
    especie_fk integer NOT NULL,
    genero_fk integer NOT NULL,
    familia_fk integer NOT NULL,
    unidad_fk integer NOT NULL,
    locacion_fk integer NOT NULL,
    tipo_planta_fk integer NOT NULL,
    fecha_coleccion date,
    importancia character varying(40),
    medidas character varying(40)
);


ALTER TABLE plantas.planta OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 1839938)
-- Name: planta_id_seq; Type: SEQUENCE; Schema: plantas; Owner: postgres
--

CREATE SEQUENCE plantas.planta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE plantas.planta_id_seq OWNER TO postgres;

--
-- TOC entry 3213 (class 0 OID 0)
-- Dependencies: 227
-- Name: planta_id_seq; Type: SEQUENCE OWNED BY; Schema: plantas; Owner: postgres
--

ALTER SEQUENCE plantas.planta_id_seq OWNED BY plantas.planta.id;


--
-- TOC entry 220 (class 1259 OID 1839856)
-- Name: tipo_planta; Type: TABLE; Schema: plantas; Owner: postgres
--

CREATE TABLE plantas.tipo_planta (
    id integer NOT NULL,
    nombre character varying
);


ALTER TABLE plantas.tipo_planta OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 1839854)
-- Name: tipo_planta_id_seq; Type: SEQUENCE; Schema: plantas; Owner: postgres
--

CREATE SEQUENCE plantas.tipo_planta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE plantas.tipo_planta_id_seq OWNER TO postgres;

--
-- TOC entry 3214 (class 0 OID 0)
-- Dependencies: 219
-- Name: tipo_planta_id_seq; Type: SEQUENCE OWNED BY; Schema: plantas; Owner: postgres
--

ALTER SEQUENCE plantas.tipo_planta_id_seq OWNED BY plantas.tipo_planta.id;


--
-- TOC entry 216 (class 1259 OID 1839834)
-- Name: unidad; Type: TABLE; Schema: plantas; Owner: postgres
--

CREATE TABLE plantas.unidad (
    id integer NOT NULL,
    nombre character varying
);


ALTER TABLE plantas.unidad OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 1839832)
-- Name: unidad_id_seq; Type: SEQUENCE; Schema: plantas; Owner: postgres
--

CREATE SEQUENCE plantas.unidad_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE plantas.unidad_id_seq OWNER TO postgres;

--
-- TOC entry 3215 (class 0 OID 0)
-- Dependencies: 215
-- Name: unidad_id_seq; Type: SEQUENCE OWNED BY; Schema: plantas; Owner: postgres
--

ALTER SEQUENCE plantas.unidad_id_seq OWNED BY plantas.unidad.id;


--
-- TOC entry 224 (class 1259 OID 1839882)
-- Name: especie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.especie (
    id integer NOT NULL,
    genero_fk integer NOT NULL,
    nombre character varying(40)
);


ALTER TABLE public.especie OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 1839880)
-- Name: especie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.especie_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.especie_id_seq OWNER TO postgres;

--
-- TOC entry 3216 (class 0 OID 0)
-- Dependencies: 223
-- Name: especie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.especie_id_seq OWNED BY public.especie.id;


--
-- TOC entry 214 (class 1259 OID 1839826)
-- Name: familia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.familia (
    id integer NOT NULL,
    nombre character varying(40)
);


ALTER TABLE public.familia OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 1839824)
-- Name: familia_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.familia_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.familia_id_seq OWNER TO postgres;

--
-- TOC entry 3217 (class 0 OID 0)
-- Dependencies: 213
-- Name: familia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.familia_id_seq OWNED BY public.familia.id;


--
-- TOC entry 222 (class 1259 OID 1839867)
-- Name: genero; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genero (
    id integer NOT NULL,
    familia_fk integer NOT NULL,
    nombre character varying(40)
);


ALTER TABLE public.genero OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 1839865)
-- Name: genero_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.genero_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genero_id_seq OWNER TO postgres;

--
-- TOC entry 3218 (class 0 OID 0)
-- Dependencies: 221
-- Name: genero_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.genero_id_seq OWNED BY public.genero.id;


--
-- TOC entry 212 (class 1259 OID 1839818)
-- Name: locacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locacion (
    id integer NOT NULL,
    latitud real,
    longitud real,
    nombre character varying(40),
    pais character varying(40)
);


ALTER TABLE public.locacion OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 1839816)
-- Name: locacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locacion_id_seq OWNER TO postgres;

--
-- TOC entry 3219 (class 0 OID 0)
-- Dependencies: 211
-- Name: locacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locacion_id_seq OWNED BY public.locacion.id;


--
-- TOC entry 204 (class 1259 OID 1839774)
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rol (
    id integer NOT NULL,
    nombre character varying NOT NULL,
    acceso_plantas boolean NOT NULL,
    acceso_piezas boolean NOT NULL
);


ALTER TABLE public.rol OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 1839772)
-- Name: rol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rol_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rol_id_seq OWNER TO postgres;

--
-- TOC entry 3220 (class 0 OID 0)
-- Dependencies: 203
-- Name: rol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rol_id_seq OWNED BY public.rol.id;


--
-- TOC entry 206 (class 1259 OID 1839785)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id integer NOT NULL,
    usuario character varying NOT NULL,
    contrasena character varying NOT NULL,
    rol_fk integer NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 1839783)
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_id_seq OWNER TO postgres;

--
-- TOC entry 3221 (class 0 OID 0)
-- Dependencies: 205
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;


--
-- TOC entry 2978 (class 2604 OID 1839900)
-- Name: animal id; Type: DEFAULT; Schema: piezas; Owner: postgres
--

ALTER TABLE ONLY piezas.animal ALTER COLUMN id SET DEFAULT nextval('piezas.animal_id_seq'::regclass);


--
-- TOC entry 2974 (class 2604 OID 1839848)
-- Name: convenio id; Type: DEFAULT; Schema: piezas; Owner: postgres
--

ALTER TABLE ONLY piezas.convenio ALTER COLUMN id SET DEFAULT nextval('piezas.convenio_id_seq'::regclass);


--
-- TOC entry 2970 (class 2604 OID 1839813)
-- Name: localidad id; Type: DEFAULT; Schema: piezas; Owner: postgres
--

ALTER TABLE ONLY piezas.localidad ALTER COLUMN id SET DEFAULT nextval('piezas.localidad_id_seq'::regclass);


--
-- TOC entry 2969 (class 2604 OID 1839802)
-- Name: foto id; Type: DEFAULT; Schema: plantas; Owner: postgres
--

ALTER TABLE ONLY plantas.foto ALTER COLUMN id SET DEFAULT nextval('plantas.foto_id_seq'::regclass);


--
-- TOC entry 2979 (class 2604 OID 1839943)
-- Name: planta id; Type: DEFAULT; Schema: plantas; Owner: postgres
--

ALTER TABLE ONLY plantas.planta ALTER COLUMN id SET DEFAULT nextval('plantas.planta_id_seq'::regclass);


--
-- TOC entry 2975 (class 2604 OID 1839859)
-- Name: tipo_planta id; Type: DEFAULT; Schema: plantas; Owner: postgres
--

ALTER TABLE ONLY plantas.tipo_planta ALTER COLUMN id SET DEFAULT nextval('plantas.tipo_planta_id_seq'::regclass);


--
-- TOC entry 2973 (class 2604 OID 1839837)
-- Name: unidad id; Type: DEFAULT; Schema: plantas; Owner: postgres
--

ALTER TABLE ONLY plantas.unidad ALTER COLUMN id SET DEFAULT nextval('plantas.unidad_id_seq'::regclass);


--
-- TOC entry 2977 (class 2604 OID 1839885)
-- Name: especie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especie ALTER COLUMN id SET DEFAULT nextval('public.especie_id_seq'::regclass);


--
-- TOC entry 2972 (class 2604 OID 1839829)
-- Name: familia id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.familia ALTER COLUMN id SET DEFAULT nextval('public.familia_id_seq'::regclass);


--
-- TOC entry 2976 (class 2604 OID 1839870)
-- Name: genero id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genero ALTER COLUMN id SET DEFAULT nextval('public.genero_id_seq'::regclass);


--
-- TOC entry 2971 (class 2604 OID 1839821)
-- Name: locacion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locacion ALTER COLUMN id SET DEFAULT nextval('public.locacion_id_seq'::regclass);


--
-- TOC entry 2967 (class 2604 OID 1839777)
-- Name: rol id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol ALTER COLUMN id SET DEFAULT nextval('public.rol_id_seq'::regclass);


--
-- TOC entry 2968 (class 2604 OID 1839788)
-- Name: usuario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);


--
-- TOC entry 3200 (class 0 OID 1839897)
-- Dependencies: 226
-- Data for Name: animal; Type: TABLE DATA; Schema: piezas; Owner: postgres
--

COPY piezas.animal (id, especie_fk, genero_fk, convenio_fk, familia_fk, locacion_fk, nombre, repositorio, fecha_colecta, identificador_alterno) FROM stdin;
\.


--
-- TOC entry 3192 (class 0 OID 1839845)
-- Dependencies: 218
-- Data for Name: convenio; Type: TABLE DATA; Schema: piezas; Owner: postgres
--

COPY piezas.convenio (id, nombre) FROM stdin;
\.


--
-- TOC entry 3184 (class 0 OID 1839810)
-- Dependencies: 210
-- Data for Name: localidad; Type: TABLE DATA; Schema: piezas; Owner: postgres
--

COPY piezas.localidad (id, nombre, pais, latitud, longitud, polaridad, altura, comentario) FROM stdin;
\.


--
-- TOC entry 3182 (class 0 OID 1839799)
-- Dependencies: 208
-- Data for Name: foto; Type: TABLE DATA; Schema: plantas; Owner: postgres
--

COPY plantas.foto (id, ruta) FROM stdin;
\.


--
-- TOC entry 3202 (class 0 OID 1839940)
-- Dependencies: 228
-- Data for Name: planta; Type: TABLE DATA; Schema: plantas; Owner: postgres
--

COPY plantas.planta (id, foto_fk, especie_fk, genero_fk, familia_fk, unidad_fk, locacion_fk, tipo_planta_fk, fecha_coleccion, importancia, medidas) FROM stdin;
\.


--
-- TOC entry 3194 (class 0 OID 1839856)
-- Dependencies: 220
-- Data for Name: tipo_planta; Type: TABLE DATA; Schema: plantas; Owner: postgres
--

COPY plantas.tipo_planta (id, nombre) FROM stdin;
\.


--
-- TOC entry 3190 (class 0 OID 1839834)
-- Dependencies: 216
-- Data for Name: unidad; Type: TABLE DATA; Schema: plantas; Owner: postgres
--

COPY plantas.unidad (id, nombre) FROM stdin;
\.


--
-- TOC entry 3198 (class 0 OID 1839882)
-- Dependencies: 224
-- Data for Name: especie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.especie (id, genero_fk, nombre) FROM stdin;
\.


--
-- TOC entry 3188 (class 0 OID 1839826)
-- Dependencies: 214
-- Data for Name: familia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.familia (id, nombre) FROM stdin;
\.


--
-- TOC entry 3196 (class 0 OID 1839867)
-- Dependencies: 222
-- Data for Name: genero; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genero (id, familia_fk, nombre) FROM stdin;
\.


--
-- TOC entry 3186 (class 0 OID 1839818)
-- Dependencies: 212
-- Data for Name: locacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locacion (id, latitud, longitud, nombre, pais) FROM stdin;
\.


--
-- TOC entry 3178 (class 0 OID 1839774)
-- Dependencies: 204
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rol (id, nombre, acceso_plantas, acceso_piezas) FROM stdin;
1	Administrador	t	t
2	Investigador	t	f
3	Invitado	f	t
\.


--
-- TOC entry 3180 (class 0 OID 1839785)
-- Dependencies: 206
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id, usuario, contrasena, rol_fk) FROM stdin;
1	camilo-test-cjar	$2a$06$UhEueyhVMntVQ7LJIVDH/.9AyPxPmk4JVsAuP7ysO0NKmcuDAJvPS	1
2	camilo-test-cjar-investigador	$2a$06$godHuEjyA83krmZ0NEq8Qe3xy1ARRzC6a5TyqRFLI9HzcJ1whtQEy	2
3	camilo-test-cjar-invitado	$2a$06$49L8xkJyGMu7mbNeDLHddeoogBi1QF1m9WQ/z/EtN78Kg8CHXX.zO	3
\.


--
-- TOC entry 3222 (class 0 OID 0)
-- Dependencies: 225
-- Name: animal_id_seq; Type: SEQUENCE SET; Schema: piezas; Owner: postgres
--

SELECT pg_catalog.setval('piezas.animal_id_seq', 2, true);


--
-- TOC entry 3223 (class 0 OID 0)
-- Dependencies: 217
-- Name: convenio_id_seq; Type: SEQUENCE SET; Schema: piezas; Owner: postgres
--

SELECT pg_catalog.setval('piezas.convenio_id_seq', 1, false);


--
-- TOC entry 3224 (class 0 OID 0)
-- Dependencies: 209
-- Name: localidad_id_seq; Type: SEQUENCE SET; Schema: piezas; Owner: postgres
--

SELECT pg_catalog.setval('piezas.localidad_id_seq', 1, false);


--
-- TOC entry 3225 (class 0 OID 0)
-- Dependencies: 207
-- Name: foto_id_seq; Type: SEQUENCE SET; Schema: plantas; Owner: postgres
--

SELECT pg_catalog.setval('plantas.foto_id_seq', 5, true);


--
-- TOC entry 3226 (class 0 OID 0)
-- Dependencies: 227
-- Name: planta_id_seq; Type: SEQUENCE SET; Schema: plantas; Owner: postgres
--

SELECT pg_catalog.setval('plantas.planta_id_seq', 16, true);


--
-- TOC entry 3227 (class 0 OID 0)
-- Dependencies: 219
-- Name: tipo_planta_id_seq; Type: SEQUENCE SET; Schema: plantas; Owner: postgres
--

SELECT pg_catalog.setval('plantas.tipo_planta_id_seq', 4, true);


--
-- TOC entry 3228 (class 0 OID 0)
-- Dependencies: 215
-- Name: unidad_id_seq; Type: SEQUENCE SET; Schema: plantas; Owner: postgres
--

SELECT pg_catalog.setval('plantas.unidad_id_seq', 6, true);


--
-- TOC entry 3229 (class 0 OID 0)
-- Dependencies: 223
-- Name: especie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.especie_id_seq', 1, true);


--
-- TOC entry 3230 (class 0 OID 0)
-- Dependencies: 213
-- Name: familia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.familia_id_seq', 34, true);


--
-- TOC entry 3231 (class 0 OID 0)
-- Dependencies: 221
-- Name: genero_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genero_id_seq', 2, true);


--
-- TOC entry 3232 (class 0 OID 0)
-- Dependencies: 211
-- Name: locacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locacion_id_seq', 1, true);


--
-- TOC entry 3233 (class 0 OID 0)
-- Dependencies: 203
-- Name: rol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rol_id_seq', 3, true);


--
-- TOC entry 3234 (class 0 OID 0)
-- Dependencies: 205
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_seq', 3, true);


--
-- TOC entry 3010 (class 2606 OID 1839902)
-- Name: animal animal_pkey; Type: CONSTRAINT; Schema: piezas; Owner: postgres
--

ALTER TABLE ONLY piezas.animal
    ADD CONSTRAINT animal_pkey PRIMARY KEY (id);


--
-- TOC entry 2993 (class 2606 OID 1839853)
-- Name: convenio convenio_pkey; Type: CONSTRAINT; Schema: piezas; Owner: postgres
--

ALTER TABLE ONLY piezas.convenio
    ADD CONSTRAINT convenio_pkey PRIMARY KEY (id);


--
-- TOC entry 2985 (class 2606 OID 1839815)
-- Name: localidad localidad_pkey; Type: CONSTRAINT; Schema: piezas; Owner: postgres
--

ALTER TABLE ONLY piezas.localidad
    ADD CONSTRAINT localidad_pkey PRIMARY KEY (id);


--
-- TOC entry 2983 (class 2606 OID 1839807)
-- Name: foto foto_pkey; Type: CONSTRAINT; Schema: plantas; Owner: postgres
--

ALTER TABLE ONLY plantas.foto
    ADD CONSTRAINT foto_pkey PRIMARY KEY (id);


--
-- TOC entry 3031 (class 2606 OID 1839945)
-- Name: planta planta_pkey; Type: CONSTRAINT; Schema: plantas; Owner: postgres
--

ALTER TABLE ONLY plantas.planta
    ADD CONSTRAINT planta_pkey PRIMARY KEY (id);


--
-- TOC entry 2995 (class 2606 OID 1839864)
-- Name: tipo_planta tipo_planta_pkey; Type: CONSTRAINT; Schema: plantas; Owner: postgres
--

ALTER TABLE ONLY plantas.tipo_planta
    ADD CONSTRAINT tipo_planta_pkey PRIMARY KEY (id);


--
-- TOC entry 2991 (class 2606 OID 1839842)
-- Name: unidad unidad_pkey; Type: CONSTRAINT; Schema: plantas; Owner: postgres
--

ALTER TABLE ONLY plantas.unidad
    ADD CONSTRAINT unidad_pkey PRIMARY KEY (id);


--
-- TOC entry 3002 (class 2606 OID 1839887)
-- Name: especie especie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especie
    ADD CONSTRAINT especie_pkey PRIMARY KEY (id);


--
-- TOC entry 2989 (class 2606 OID 1839831)
-- Name: familia familia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.familia
    ADD CONSTRAINT familia_pkey PRIMARY KEY (id);


--
-- TOC entry 2998 (class 2606 OID 1839872)
-- Name: genero genero_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genero
    ADD CONSTRAINT genero_pkey PRIMARY KEY (id);


--
-- TOC entry 2987 (class 2606 OID 1839823)
-- Name: locacion locacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locacion
    ADD CONSTRAINT locacion_pkey PRIMARY KEY (id);


--
-- TOC entry 2981 (class 2606 OID 1839782)
-- Name: rol rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pkey PRIMARY KEY (id);


--
-- TOC entry 3004 (class 1259 OID 1839928)
-- Name: animal_fkindex1; Type: INDEX; Schema: piezas; Owner: postgres
--

CREATE INDEX animal_fkindex1 ON piezas.animal USING btree (locacion_fk);


--
-- TOC entry 3005 (class 1259 OID 1839929)
-- Name: animal_fkindex2; Type: INDEX; Schema: piezas; Owner: postgres
--

CREATE INDEX animal_fkindex2 ON piezas.animal USING btree (convenio_fk);


--
-- TOC entry 3006 (class 1259 OID 1839930)
-- Name: animal_fkindex3; Type: INDEX; Schema: piezas; Owner: postgres
--

CREATE INDEX animal_fkindex3 ON piezas.animal USING btree (familia_fk);


--
-- TOC entry 3007 (class 1259 OID 1839931)
-- Name: animal_fkindex4; Type: INDEX; Schema: piezas; Owner: postgres
--

CREATE INDEX animal_fkindex4 ON piezas.animal USING btree (genero_fk);


--
-- TOC entry 3008 (class 1259 OID 1839932)
-- Name: animal_fkindex5; Type: INDEX; Schema: piezas; Owner: postgres
--

CREATE INDEX animal_fkindex5 ON piezas.animal USING btree (especie_fk);


--
-- TOC entry 3011 (class 1259 OID 1839933)
-- Name: ifk_rel_14; Type: INDEX; Schema: piezas; Owner: postgres
--

CREATE INDEX ifk_rel_14 ON piezas.animal USING btree (locacion_fk);


--
-- TOC entry 3012 (class 1259 OID 1839934)
-- Name: ifk_rel_15; Type: INDEX; Schema: piezas; Owner: postgres
--

CREATE INDEX ifk_rel_15 ON piezas.animal USING btree (convenio_fk);


--
-- TOC entry 3013 (class 1259 OID 1839935)
-- Name: ifk_rel_16; Type: INDEX; Schema: piezas; Owner: postgres
--

CREATE INDEX ifk_rel_16 ON piezas.animal USING btree (familia_fk);


--
-- TOC entry 3014 (class 1259 OID 1839936)
-- Name: ifk_rel_17; Type: INDEX; Schema: piezas; Owner: postgres
--

CREATE INDEX ifk_rel_17 ON piezas.animal USING btree (genero_fk);


--
-- TOC entry 3015 (class 1259 OID 1839937)
-- Name: ifk_rel_18; Type: INDEX; Schema: piezas; Owner: postgres
--

CREATE INDEX ifk_rel_18 ON piezas.animal USING btree (especie_fk);


--
-- TOC entry 3016 (class 1259 OID 1839988)
-- Name: ifk_rel_05; Type: INDEX; Schema: plantas; Owner: postgres
--

CREATE INDEX ifk_rel_05 ON plantas.planta USING btree (tipo_planta_fk);


--
-- TOC entry 3017 (class 1259 OID 1839989)
-- Name: ifk_rel_06; Type: INDEX; Schema: plantas; Owner: postgres
--

CREATE INDEX ifk_rel_06 ON plantas.planta USING btree (locacion_fk);


--
-- TOC entry 3018 (class 1259 OID 1839990)
-- Name: ifk_rel_07; Type: INDEX; Schema: plantas; Owner: postgres
--

CREATE INDEX ifk_rel_07 ON plantas.planta USING btree (unidad_fk);


--
-- TOC entry 3019 (class 1259 OID 1839991)
-- Name: ifk_rel_08; Type: INDEX; Schema: plantas; Owner: postgres
--

CREATE INDEX ifk_rel_08 ON plantas.planta USING btree (familia_fk);


--
-- TOC entry 3020 (class 1259 OID 1839992)
-- Name: ifk_rel_09; Type: INDEX; Schema: plantas; Owner: postgres
--

CREATE INDEX ifk_rel_09 ON plantas.planta USING btree (genero_fk);


--
-- TOC entry 3021 (class 1259 OID 1839993)
-- Name: ifk_rel_12; Type: INDEX; Schema: plantas; Owner: postgres
--

CREATE INDEX ifk_rel_12 ON plantas.planta USING btree (especie_fk);


--
-- TOC entry 3022 (class 1259 OID 1839994)
-- Name: ifk_rel_13; Type: INDEX; Schema: plantas; Owner: postgres
--

CREATE INDEX ifk_rel_13 ON plantas.planta USING btree (foto_fk);


--
-- TOC entry 3023 (class 1259 OID 1839981)
-- Name: planta_fkindex1; Type: INDEX; Schema: plantas; Owner: postgres
--

CREATE INDEX planta_fkindex1 ON plantas.planta USING btree (tipo_planta_fk);


--
-- TOC entry 3024 (class 1259 OID 1839982)
-- Name: planta_fkindex2; Type: INDEX; Schema: plantas; Owner: postgres
--

CREATE INDEX planta_fkindex2 ON plantas.planta USING btree (locacion_fk);


--
-- TOC entry 3025 (class 1259 OID 1839983)
-- Name: planta_fkindex3; Type: INDEX; Schema: plantas; Owner: postgres
--

CREATE INDEX planta_fkindex3 ON plantas.planta USING btree (unidad_fk);


--
-- TOC entry 3026 (class 1259 OID 1839984)
-- Name: planta_fkindex4; Type: INDEX; Schema: plantas; Owner: postgres
--

CREATE INDEX planta_fkindex4 ON plantas.planta USING btree (familia_fk);


--
-- TOC entry 3027 (class 1259 OID 1839985)
-- Name: planta_fkindex5; Type: INDEX; Schema: plantas; Owner: postgres
--

CREATE INDEX planta_fkindex5 ON plantas.planta USING btree (genero_fk);


--
-- TOC entry 3028 (class 1259 OID 1839986)
-- Name: planta_fkindex6; Type: INDEX; Schema: plantas; Owner: postgres
--

CREATE INDEX planta_fkindex6 ON plantas.planta USING btree (especie_fk);


--
-- TOC entry 3029 (class 1259 OID 1839987)
-- Name: planta_fkindex7; Type: INDEX; Schema: plantas; Owner: postgres
--

CREATE INDEX planta_fkindex7 ON plantas.planta USING btree (foto_fk);


--
-- TOC entry 3000 (class 1259 OID 1839893)
-- Name: especie_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX especie_fkindex1 ON public.especie USING btree (genero_fk);


--
-- TOC entry 2996 (class 1259 OID 1839878)
-- Name: genero_fkindex1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX genero_fkindex1 ON public.genero USING btree (familia_fk);


--
-- TOC entry 3003 (class 1259 OID 1839894)
-- Name: ifk_rel_02; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ifk_rel_02 ON public.especie USING btree (genero_fk);


--
-- TOC entry 2999 (class 1259 OID 1839879)
-- Name: ifk_rel_10; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ifk_rel_10 ON public.genero USING btree (familia_fk);


--
-- TOC entry 3035 (class 2606 OID 1839908)
-- Name: animal animal_convenio_fk_fkey; Type: FK CONSTRAINT; Schema: piezas; Owner: postgres
--

ALTER TABLE ONLY piezas.animal
    ADD CONSTRAINT animal_convenio_fk_fkey FOREIGN KEY (convenio_fk) REFERENCES piezas.convenio(id);


--
-- TOC entry 3036 (class 2606 OID 1839923)
-- Name: animal animal_especie_fk_fkey; Type: FK CONSTRAINT; Schema: piezas; Owner: postgres
--

ALTER TABLE ONLY piezas.animal
    ADD CONSTRAINT animal_especie_fk_fkey FOREIGN KEY (especie_fk) REFERENCES public.especie(id);


--
-- TOC entry 3037 (class 2606 OID 1839913)
-- Name: animal animal_familia_fk_fkey; Type: FK CONSTRAINT; Schema: piezas; Owner: postgres
--

ALTER TABLE ONLY piezas.animal
    ADD CONSTRAINT animal_familia_fk_fkey FOREIGN KEY (familia_fk) REFERENCES public.familia(id);


--
-- TOC entry 3038 (class 2606 OID 1839918)
-- Name: animal animal_genero_fk_fkey; Type: FK CONSTRAINT; Schema: piezas; Owner: postgres
--

ALTER TABLE ONLY piezas.animal
    ADD CONSTRAINT animal_genero_fk_fkey FOREIGN KEY (genero_fk) REFERENCES public.genero(id);


--
-- TOC entry 3039 (class 2606 OID 1839903)
-- Name: animal animal_locacion_fk_fkey; Type: FK CONSTRAINT; Schema: piezas; Owner: postgres
--

ALTER TABLE ONLY piezas.animal
    ADD CONSTRAINT animal_locacion_fk_fkey FOREIGN KEY (locacion_fk) REFERENCES public.locacion(id);


--
-- TOC entry 3044 (class 2606 OID 1839971)
-- Name: planta planta_especie_fk_fkey; Type: FK CONSTRAINT; Schema: plantas; Owner: postgres
--

ALTER TABLE ONLY plantas.planta
    ADD CONSTRAINT planta_especie_fk_fkey FOREIGN KEY (especie_fk) REFERENCES public.especie(id);


--
-- TOC entry 3040 (class 2606 OID 1839961)
-- Name: planta planta_familia_fk_fkey; Type: FK CONSTRAINT; Schema: plantas; Owner: postgres
--

ALTER TABLE ONLY plantas.planta
    ADD CONSTRAINT planta_familia_fk_fkey FOREIGN KEY (familia_fk) REFERENCES public.familia(id);


--
-- TOC entry 3045 (class 2606 OID 1839976)
-- Name: planta planta_foto_fk_fkey; Type: FK CONSTRAINT; Schema: plantas; Owner: postgres
--

ALTER TABLE ONLY plantas.planta
    ADD CONSTRAINT planta_foto_fk_fkey FOREIGN KEY (foto_fk) REFERENCES plantas.foto(id);


--
-- TOC entry 3046 (class 2606 OID 1839966)
-- Name: planta planta_genero_fk_fkey; Type: FK CONSTRAINT; Schema: plantas; Owner: postgres
--

ALTER TABLE ONLY plantas.planta
    ADD CONSTRAINT planta_genero_fk_fkey FOREIGN KEY (genero_fk) REFERENCES public.genero(id);


--
-- TOC entry 3041 (class 2606 OID 1839951)
-- Name: planta planta_locacion_fk_fkey; Type: FK CONSTRAINT; Schema: plantas; Owner: postgres
--

ALTER TABLE ONLY plantas.planta
    ADD CONSTRAINT planta_locacion_fk_fkey FOREIGN KEY (locacion_fk) REFERENCES public.locacion(id);


--
-- TOC entry 3042 (class 2606 OID 1839946)
-- Name: planta planta_tipo_planta_fk_fkey; Type: FK CONSTRAINT; Schema: plantas; Owner: postgres
--

ALTER TABLE ONLY plantas.planta
    ADD CONSTRAINT planta_tipo_planta_fk_fkey FOREIGN KEY (tipo_planta_fk) REFERENCES plantas.tipo_planta(id);


--
-- TOC entry 3043 (class 2606 OID 1839956)
-- Name: planta planta_unidad_fk_fkey; Type: FK CONSTRAINT; Schema: plantas; Owner: postgres
--

ALTER TABLE ONLY plantas.planta
    ADD CONSTRAINT planta_unidad_fk_fkey FOREIGN KEY (unidad_fk) REFERENCES plantas.unidad(id);


--
-- TOC entry 3034 (class 2606 OID 1839888)
-- Name: especie especie_genero_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.especie
    ADD CONSTRAINT especie_genero_fk_fkey FOREIGN KEY (genero_fk) REFERENCES public.genero(id);


--
-- TOC entry 3033 (class 2606 OID 1839873)
-- Name: genero genero_familia_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genero
    ADD CONSTRAINT genero_familia_fk_fkey FOREIGN KEY (familia_fk) REFERENCES public.familia(id);


--
-- TOC entry 3032 (class 2606 OID 1839792)
-- Name: usuario rol_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT rol_fk FOREIGN KEY (rol_fk) REFERENCES public.rol(id);


-- Completed on 2022-11-08 08:58:32

--
-- PostgreSQL database dump complete
--

