--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO postgres;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    galaxy_shape character varying(20),
    diameter_kpc real,
    redshift_z numeric
);


ALTER TABLE public.galaxy OWNER TO postgres;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO postgres;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    orbital_period_days numeric,
    mass_kg numeric,
    surface_temp_k integer,
    planet_id integer
);


ALTER TABLE public.moon OWNER TO postgres;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO postgres;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(40) NOT NULL,
    mass_kg real,
    orbital_period_days numeric,
    has_liquid_water boolean,
    star_id integer
);


ALTER TABLE public.planet OWNER TO postgres;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO postgres;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    spectral_type character varying(10),
    mass_kg real,
    has_known_planets boolean,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO postgres;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO postgres;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: supernova; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supernova (
    supernova_id integer NOT NULL,
    name character varying(50) NOT NULL,
    app_mag numeric,
    distance_from_earth_ly integer,
    sn_type text,
    galaxy_id integer
);


ALTER TABLE public.supernova OWNER TO postgres;

--
-- Name: supernova_supernova_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supernova_supernova_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.supernova_supernova_id_seq OWNER TO postgres;

--
-- Name: supernova_supernova_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supernova_supernova_id_seq OWNED BY public.supernova.supernova_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Name: supernova supernova_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supernova ALTER COLUMN supernova_id SET DEFAULT nextval('public.supernova_supernova_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'Barred Spiral', 26.8, 0);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'Barred Spiral', 46.56, -0.00104);
INSERT INTO public.galaxy VALUES (3, 'Southern Pinwheel', 'Barred Spiral', 16.86, 0.0017);
INSERT INTO public.galaxy VALUES (4, 'Cigar', 'Starburst', 12.52, 0.000897);
INSERT INTO public.galaxy VALUES (5, 'Antennae', 'Interacting', 150, 0.00547);
INSERT INTO public.galaxy VALUES (6, 'Hoags Object', 'Ring', 121, 0.0424);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.moon VALUES (2, 'Moon', 73420000000000000000000, 27.32, 220, 1);
INSERT INTO public.moon VALUES (3, 'Io', 89400000000000000000000, 1.77, 130, 10);
INSERT INTO public.moon VALUES (4, 'Europa', 48000000000000000000000, 3.55, 102, 10);
INSERT INTO public.moon VALUES (5, 'Ganymede', 148200000000000000000000, 7.15, 110, 10);
INSERT INTO public.moon VALUES (6, 'Callisto', 107600000000000000000000, 16.69, 134, 10);
INSERT INTO public.moon VALUES (7, 'Mimas', 37500000000000000000, 0.942, 64, 11);
INSERT INTO public.moon VALUES (8, 'Enceladus', 108000000000000000000, 1.37, 75, 11);
INSERT INTO public.moon VALUES (9, 'Tethys', 618000000000000000000, 1.88, 64, 11);
INSERT INTO public.moon VALUES (10, 'Dione', 1095000000000000000000, 2.74, 87, 11);
INSERT INTO public.moon VALUES (11, 'Rhea', 2310000000000000000000, 4.52, 76, 11);
INSERT INTO public.moon VALUES (12, 'Titan', 134520000000000000000000, 15.95, 94, 11);
INSERT INTO public.moon VALUES (13, 'Iapetus', 1800000000000000000000, 79.32, 130, 11);
INSERT INTO public.moon VALUES (14, 'Miranda', 659000000000000000000, 1.41, 59, 12);
INSERT INTO public.moon VALUES (15, 'Ariel', 1350000000000000000000, 2.52, 58, 12);
INSERT INTO public.moon VALUES (16, 'Umbriel', 1200000000000000000000, 4.14, 61, 12);
INSERT INTO public.moon VALUES (17, 'Titania', 3500000000000000000000, 8.71, 60, 12);
INSERT INTO public.moon VALUES (18, 'Oberon', 3014000000000000000000, 13.46, 61, 12);
INSERT INTO public.moon VALUES (19, 'Hyperion', 5620000000000000000, 21.27, 93, 11);
INSERT INTO public.moon VALUES (20, 'Sycorax', 2500000000000000000, 1286, 65, 12);
INSERT INTO public.moon VALUES (21, 'Amalthea', 2080000000000000000, 0.498, 120, 10);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.planet VALUES (1, 'Earth', 5.972e+24, 365.25, true, 1);
INSERT INTO public.planet VALUES (2, 'Proxima Centauri b', 6.394e+24, 11.19, false, 2);
INSERT INTO public.planet VALUES (3, 'Draugr', 1.195e+23, 25.26, false, 3);
INSERT INTO public.planet VALUES (4, 'Poltergeist', 2.58e+25, 66.54, false, 3);
INSERT INTO public.planet VALUES (5, 'Phobetor', 2.351e+25, 96.21, false, 3);
INSERT INTO public.planet VALUES (6, '51 Pegasi b', 8.731e+27, 4.23, false, 5);
INSERT INTO public.planet VALUES (7, 'Mercury', 3.301e+23, 115.88, true, 1);
INSERT INTO public.planet VALUES (8, 'Venus', 4.868e+24, 583.92, false, 1);
INSERT INTO public.planet VALUES (9, 'Mars', 6.417e+23, 686.98, false, 1);
INSERT INTO public.planet VALUES (10, 'Jupiter', 1.898e+27, 4332.59, false, 1);
INSERT INTO public.planet VALUES (11, 'Saturn', 5.683e+26, 10759.22, false, 1);
INSERT INTO public.planet VALUES (12, 'Uranus', 8.681e+25, 30688.5, true, 1);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.star VALUES (1, 'Sun', 'G', 1.989e+30, true, 1);
INSERT INTO public.star VALUES (2, 'Proxima Centauri', 'M', 2.428e+29, true, 1);
INSERT INTO public.star VALUES (3, 'Lich', 'Pulsar', 2.784e+30, true, 1);
INSERT INTO public.star VALUES (4, 'Polaris', 'F', 1.074e+30, false, 1);
INSERT INTO public.star VALUES (5, 'Helvetios', 'G', 2.207e+30, true, 1);
INSERT INTO public.star VALUES (6, 'AF Andromadae', 'LBV', 1.69e+32, false, 2);


--
-- Data for Name: supernova; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.supernova VALUES (1, 'SN 1006', -7.5, 7200, 'Ia', 1);
INSERT INTO public.supernova VALUES (2, 'SN 1885A', 7, 2500000, 'Ia', 2);
INSERT INTO public.supernova VALUES (3, 'SN 1054', -6, 6500, 'II', 1);
INSERT INTO public.supernova VALUES (4, 'SN 1983N', 11.8, 15000000, 'Ib', 6);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 1, false);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 1, false);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 1, false);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.star_star_id_seq', 1, false);


--
-- Name: supernova_supernova_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supernova_supernova_id_seq', 1, false);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pk PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: supernova supernova_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supernova
    ADD CONSTRAINT supernova_name_key UNIQUE (name);


--
-- Name: supernova supernova_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supernova
    ADD CONSTRAINT supernova_pkey PRIMARY KEY (supernova_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: supernova supernova_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supernova
    ADD CONSTRAINT supernova_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA public TO freecodecamp;


--
-- Name: TABLE galaxy; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.galaxy TO freecodecamp;


--
-- Name: SEQUENCE galaxy_galaxy_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.galaxy_galaxy_id_seq TO freecodecamp;


--
-- Name: TABLE moon; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.moon TO freecodecamp;


--
-- Name: SEQUENCE moon_moon_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.moon_moon_id_seq TO freecodecamp;


--
-- Name: TABLE planet; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.planet TO freecodecamp;


--
-- Name: SEQUENCE planet_planet_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.planet_planet_id_seq TO freecodecamp;


--
-- Name: TABLE star; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.star TO freecodecamp;


--
-- Name: SEQUENCE star_star_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.star_star_id_seq TO freecodecamp;


--
-- Name: TABLE supernova; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.supernova TO freecodecamp;


--
-- Name: SEQUENCE supernova_supernova_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.supernova_supernova_id_seq TO freecodecamp;


--
-- PostgreSQL database dump complete
--

