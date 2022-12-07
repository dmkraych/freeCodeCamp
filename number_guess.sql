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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: guess_stats; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.guess_stats (
    user_id integer NOT NULL,
    games_played integer DEFAULT 0,
    best_game integer
);


ALTER TABLE public.guess_stats OWNER TO freecodecamp;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(40) NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: guess_stats; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.guess_stats VALUES (27, 2, 55);
INSERT INTO public.guess_stats VALUES (26, 5, 135);
INSERT INTO public.guess_stats VALUES (29, 2, 466);
INSERT INTO public.guess_stats VALUES (28, 5, 102);
INSERT INTO public.guess_stats VALUES (32, 2, 243);
INSERT INTO public.guess_stats VALUES (31, 5, 116);
INSERT INTO public.guess_stats VALUES (34, 2, 745);
INSERT INTO public.guess_stats VALUES (33, 5, 90);
INSERT INTO public.guess_stats VALUES (30, 2, 9);
INSERT INTO public.guess_stats VALUES (36, 2, 190);
INSERT INTO public.guess_stats VALUES (35, 5, 186);
INSERT INTO public.guess_stats VALUES (38, 2, 353);
INSERT INTO public.guess_stats VALUES (37, 5, 232);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (26, 'user_1670450901595');
INSERT INTO public.users VALUES (27, 'user_1670450901594');
INSERT INTO public.users VALUES (28, 'user_1670450978369');
INSERT INTO public.users VALUES (29, 'user_1670450978368');
INSERT INTO public.users VALUES (30, 'wizard');
INSERT INTO public.users VALUES (31, 'user_1670451154353');
INSERT INTO public.users VALUES (32, 'user_1670451154352');
INSERT INTO public.users VALUES (33, 'user_1670451254775');
INSERT INTO public.users VALUES (34, 'user_1670451254774');
INSERT INTO public.users VALUES (35, 'user_1670451546009');
INSERT INTO public.users VALUES (36, 'user_1670451546008');
INSERT INTO public.users VALUES (37, 'user_1670451865012');
INSERT INTO public.users VALUES (38, 'user_1670451865011');


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 38, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: guess_stats guess_stats_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guess_stats
    ADD CONSTRAINT guess_stats_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--


