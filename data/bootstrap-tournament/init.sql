--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0 (Debian 17.0-1.pgdg120+1)
-- Dumped by pg_dump version 17.0 (Debian 17.0-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: band; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.band AS ENUM (
    'lower',
    'middle',
    'upper'
);


ALTER TYPE public.band OWNER TO postgres;

--
-- Name: format; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.format AS ENUM (
    'single-elimination',
    'double-elimination',
    'round-robin'
);


ALTER TYPE public.format OWNER TO postgres;

--
-- Name: role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.role AS ENUM (
    'admin',
    'user'
);


ALTER TYPE public.role OWNER TO postgres;

--
-- Name: signup_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.signup_status AS ENUM (
    'open',
    'closed'
);


ALTER TYPE public.signup_status OWNER TO postgres;

--
-- Name: status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status AS ENUM (
    'upcoming',
    'ongoing',
    'completed'
);


ALTER TYPE public.status OWNER TO postgres;

--
-- Name: set_bracket_seq_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_bracket_seq_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Calculate the next bracketSeqId for the given roundId
    NEW.seq_id := COALESCE(
        (SELECT MAX(seq_id) + 1 FROM brackets WHERE round_id = NEW.round_id),
        1
    );
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_bracket_seq_id() OWNER TO postgres;

--
-- Name: set_round_seq_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_round_seq_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Calculate the next roundSeqId for the given tournamentId
    NEW.seq_id := COALESCE(
        (SELECT MAX(seq_id) + 1 FROM rounds WHERE tournament_id = NEW.tournament_id),
        1
    );
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_round_seq_id() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;


--
-- Name: brackets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brackets (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tournament_id uuid NOT NULL,
    round_id uuid NOT NULL,
    status character varying(255) DEFAULT 'upcoming'::public.status NOT NULL,
    winner character varying(255),
    seq_id integer NOT NULL,
    player1 character varying(255),
    player1_score integer,
    player2 character varying(255),
    player2_score integer
);


ALTER TABLE public.brackets OWNER TO postgres;

--
-- Name: brackets_seq_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.brackets_seq_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.brackets_seq_id_seq OWNER TO postgres;

--
-- Name: brackets_seq_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.brackets_seq_id_seq OWNED BY public.brackets.seq_id;


--
-- Name: rounds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rounds (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tournament_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    status character varying(255) DEFAULT 'upcoming'::public.status,
    seq_id integer NOT NULL
);


ALTER TABLE public.rounds OWNER TO postgres;

--
-- Name: rounds_seq_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rounds_seq_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rounds_seq_id_seq OWNER TO postgres;

--
-- Name: rounds_seq_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rounds_seq_id_seq OWNED BY public.rounds.seq_id;


--
-- Name: tournament_participants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tournament_participants (
    tournament_id uuid NOT NULL,
    participant character varying(255)
);


ALTER TABLE public.tournament_participants OWNER TO postgres;

--
-- Name: tournament_signups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tournament_signups (
    tournament_id uuid NOT NULL,
    signup character varying(255)
);


ALTER TABLE public.tournament_signups OWNER TO postgres;

--
-- Name: tournaments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tournaments (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    format character varying(50) NOT NULL,
    capacity integer NOT NULL,
    icon character varying(255),
    time_weight integer NOT NULL,
    mem_weight integer NOT NULL,
    test_case_weight integer NOT NULL,
    status character varying(255) NOT NULL,
    signup_start_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    signup_end_date timestamp without time zone NOT NULL,
    band character varying(255),
    organiser character varying(255),
    current_round character varying(255)
);


ALTER TABLE public.tournaments OWNER TO postgres;

--
-- Name: brackets seq_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brackets ALTER COLUMN seq_id SET DEFAULT nextval('public.brackets_seq_id_seq'::regclass);


--
-- Name: rounds seq_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rounds ALTER COLUMN seq_id SET DEFAULT nextval('public.rounds_seq_id_seq'::regclass);


--
-- Data for Name: brackets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brackets (id, tournament_id, round_id, status, winner, seq_id, player1, player1_score, player2, player2_score) FROM stdin;
8fcbe01a-05e2-4c84-9123-ad3dbf9a9119	ecc30185-9cfe-441c-96d5-629b0c2bec27	797b83e7-85f4-473b-a7d5-abf227eb51bb	upcoming	\N	1	\N	0	\N	0
913762f4-fad0-4627-aa29-ad860bfade9a	960a05ea-7151-41b9-9d79-689bbd75c74d	824ebd4b-dbc1-4201-ba7f-c1957ea0032b	upcoming	\N	1	\N	0	\N	0
20d7431d-fb96-4c59-aa17-099cecc57d73	09d82050-01d6-49fc-86bc-bfd84c3890df	58644b67-a6bc-466a-b9f0-03fea8aaa988	upcoming	\N	1	\N	0	\N	0
20d7431d-fb96-4c59-aa17-099cecc57d74	27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	58644b67-a6bc-466a-b9f0-03fea8aaa985	upcoming	\N	1	\N	0	\N	0
20d7431d-fb96-4c59-aa17-099cecc57d75	27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	58644b67-a6bc-466a-b9f0-03fea8aaa985	upcoming	\N	2	\N	0	\N	0
20d7431d-fb96-4c59-aa17-099cecc57d76	27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	58644b67-a6bc-466a-b9f0-03fea8aaa985	upcoming	\N	3	\N	0	\N	0
20d7431d-fb96-4c59-aa17-099cecc57d77	27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	58644b67-a6bc-466a-b9f0-03fea8aaa985	upcoming	\N	4	\N	0	\N	0
20d7431d-fb96-4c59-aa17-099cecc57d78	27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	58644b67-a6bc-466a-b9f0-03fea8aaa986	upcoming	\N	1	\N	0	\N	0
20d7431d-fb96-4c59-aa17-099cecc57d79	27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	58644b67-a6bc-466a-b9f0-03fea8aaa986	upcoming	\N	2	\N	0	\N	0
20d7431d-fb96-4c59-aa17-099cecc57d81	27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	58644b67-a6bc-466a-b9f0-03fea8aaa987	upcoming	\N	1	\N	0	\N	0
\.


--
-- Data for Name: rounds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rounds (id, tournament_id, name, start_date, end_date, status, seq_id) FROM stdin;
797b83e7-85f4-473b-a7d5-abf227eb51bb	ecc30185-9cfe-441c-96d5-629b0c2bec27	Round of 2	\N	\N	upcoming	1
824ebd4b-dbc1-4201-ba7f-c1957ea0032b	960a05ea-7151-41b9-9d79-689bbd75c74d	Round of 2	\N	\N	upcoming	1
58644b67-a6bc-466a-b9f0-03fea8aaa988	09d82050-01d6-49fc-86bc-bfd84c3890df	Round of 2	\N	\N	upcoming	1
58644b67-a6bc-466a-b9f0-03fea8aaa985	27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	Round of 8	\N	\N	upcoming	1
58644b67-a6bc-466a-b9f0-03fea8aaa986	27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	Round of 4	\N	\N	upcoming	2
58644b67-a6bc-466a-b9f0-03fea8aaa987	27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	Round of 2	\N	\N	upcoming	3
\.


--
-- Data for Name: tournament_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tournament_participants (tournament_id, participant) FROM stdin;
\.


--
-- Data for Name: tournament_signups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tournament_signups (tournament_id, signup) FROM stdin;
b9b464b3-018b-416e-91f7-1ecbbea67442	user1
b9b464b3-018b-416e-91f7-1ecbbea67442	user2
b9b464b3-018b-416e-91f7-1ecbbea67442	user3
b9b464b3-018b-416e-91f7-1ecbbea67442	user4
b9b464b3-018b-416e-91f7-1ecbbea67442	user5
b9b464b3-018b-416e-91f7-1ecbbea67442	user6
b9b464b3-018b-416e-91f7-1ecbbea67442	user7
b9b464b3-018b-416e-91f7-1ecbbea67442	user8
b9b464b3-018b-416e-91f7-1ecbbea67442	user9
b9b464b3-018b-416e-91f7-1ecbbea67442	user10
b9b464b3-018b-416e-91f7-1ecbbea67442	user11
b9b464b3-018b-416e-91f7-1ecbbea67442	user12
b9b464b3-018b-416e-91f7-1ecbbea67442	user13
b9b464b3-018b-416e-91f7-1ecbbea67442	user14
b9b464b3-018b-416e-91f7-1ecbbea67442	user15
b9b464b3-018b-416e-91f7-1ecbbea67442	user16
b9b464b3-018b-416e-91f7-1ecbbea67442	user17
b9b464b3-018b-416e-91f7-1ecbbea67442	user18
b9b464b3-018b-416e-91f7-1ecbbea67442	user19
b9b464b3-018b-416e-91f7-1ecbbea67442	user20
b9b464b3-018b-416e-91f7-1ecbbea67442	user21
b9b464b3-018b-416e-91f7-1ecbbea67442	user22
b9b464b3-018b-416e-91f7-1ecbbea67442	user23
b9b464b3-018b-416e-91f7-1ecbbea67442	user24
b9b464b3-018b-416e-91f7-1ecbbea67442	user25
b9b464b3-018b-416e-91f7-1ecbbea67442	user26
b9b464b3-018b-416e-91f7-1ecbbea67442	user27
b9b464b3-018b-416e-91f7-1ecbbea67442	user28
b9b464b3-018b-416e-91f7-1ecbbea67442	user29
b9b464b3-018b-416e-91f7-1ecbbea67442	user30
1d706cf4-35e7-4454-a828-8006e44b7505	user1
1d706cf4-35e7-4454-a828-8006e44b7505	user2
1d706cf4-35e7-4454-a828-8006e44b7505	user3
1d706cf4-35e7-4454-a828-8006e44b7505	user4
1d706cf4-35e7-4454-a828-8006e44b7505	user5
1d706cf4-35e7-4454-a828-8006e44b7505	user6
1d706cf4-35e7-4454-a828-8006e44b7505	user7
1d706cf4-35e7-4454-a828-8006e44b7505	user8
1d706cf4-35e7-4454-a828-8006e44b7505	user9
1d706cf4-35e7-4454-a828-8006e44b7505	user10
1d706cf4-35e7-4454-a828-8006e44b7505	user11
1d706cf4-35e7-4454-a828-8006e44b7505	user12
1d706cf4-35e7-4454-a828-8006e44b7505	user13
1d706cf4-35e7-4454-a828-8006e44b7505	user14
1d706cf4-35e7-4454-a828-8006e44b7505	user15
1d706cf4-35e7-4454-a828-8006e44b7505	user16
1d706cf4-35e7-4454-a828-8006e44b7505	user17
1d706cf4-35e7-4454-a828-8006e44b7505	user18
1d706cf4-35e7-4454-a828-8006e44b7505	user19
1d706cf4-35e7-4454-a828-8006e44b7505	user20
1d706cf4-35e7-4454-a828-8006e44b7505	user21
1d706cf4-35e7-4454-a828-8006e44b7505	user22
1d706cf4-35e7-4454-a828-8006e44b7505	user23
1d706cf4-35e7-4454-a828-8006e44b7505	user24
1d706cf4-35e7-4454-a828-8006e44b7505	user25
1d706cf4-35e7-4454-a828-8006e44b7505	user26
1d706cf4-35e7-4454-a828-8006e44b7505	user27
1d706cf4-35e7-4454-a828-8006e44b7505	user28
1d706cf4-35e7-4454-a828-8006e44b7505	user29
1d706cf4-35e7-4454-a828-8006e44b7505	user30
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user1
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user2
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user3
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user4
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user5
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user6
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user7
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user8
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user9
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user10
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user11
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user12
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user13
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user14
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user15
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user16
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user17
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user18
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user19
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user20
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user21
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user22
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user23
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user24
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user25
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user26
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user27
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user28
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user29
04c4d78b-541f-4cfd-ae26-e0c542661c4a	user30
ecc30185-9cfe-441c-96d5-629b0c2bec27	user1
ecc30185-9cfe-441c-96d5-629b0c2bec27	user2
ecc30185-9cfe-441c-96d5-629b0c2bec27	user3
ecc30185-9cfe-441c-96d5-629b0c2bec27	user4
ecc30185-9cfe-441c-96d5-629b0c2bec27	user5
ecc30185-9cfe-441c-96d5-629b0c2bec27	user6
ecc30185-9cfe-441c-96d5-629b0c2bec27	user7
ecc30185-9cfe-441c-96d5-629b0c2bec27	user8
ecc30185-9cfe-441c-96d5-629b0c2bec27	user9
ecc30185-9cfe-441c-96d5-629b0c2bec27	user10
960a05ea-7151-41b9-9d79-689bbd75c74d	user1
960a05ea-7151-41b9-9d79-689bbd75c74d	user2
960a05ea-7151-41b9-9d79-689bbd75c74d	user3
960a05ea-7151-41b9-9d79-689bbd75c74d	user4
960a05ea-7151-41b9-9d79-689bbd75c74d	user5
960a05ea-7151-41b9-9d79-689bbd75c74d	user6
960a05ea-7151-41b9-9d79-689bbd75c74d	user7
960a05ea-7151-41b9-9d79-689bbd75c74d	user8
960a05ea-7151-41b9-9d79-689bbd75c74d	user9
960a05ea-7151-41b9-9d79-689bbd75c74d	user10
09d82050-01d6-49fc-86bc-bfd84c3890df	user1
09d82050-01d6-49fc-86bc-bfd84c3890df	user2
09d82050-01d6-49fc-86bc-bfd84c3890df	user3
09d82050-01d6-49fc-86bc-bfd84c3890df	user4
09d82050-01d6-49fc-86bc-bfd84c3890df	user5
09d82050-01d6-49fc-86bc-bfd84c3890df	user6
09d82050-01d6-49fc-86bc-bfd84c3890df	user7
09d82050-01d6-49fc-86bc-bfd84c3890df	user8
09d82050-01d6-49fc-86bc-bfd84c3890df	user9
09d82050-01d6-49fc-86bc-bfd84c3890df	user10
27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	user1
27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	user2
27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	user3
27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	user4
27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	user5
27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	user6
27db2b6d-c4b2-4882-8e52-8c2f381e1a3d	user7
\.
DELETE FROM public.tournament_signups WHERE tournament_id
in ('04c4d78b-541f-4cfd-ae26-e0c542661c4a',
'1d706cf4-35e7-4454-a828-8006e44b7505',
'b9b464b3-018b-416e-91f7-1ecbbea67442');

--
-- Data for Name: tournaments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tournaments (id, name, description, start_date, end_date, format, capacity, icon, time_weight, mem_weight, test_case_weight, status, signup_start_date, signup_end_date, band, organiser, current_round) FROM stdin;
\.

INSERT INTO public.tournaments (id, name, description, start_date, end_date, format, capacity, icon, time_weight, mem_weight, test_case_weight, status, signup_start_date, signup_end_date, band, organiser, current_round) VALUES
('b9b464b3-018b-416e-91f7-1ecbbea67442', 'Upper Time 16p Battles!', 'Tournament with max 16 participants', now(), now() + interval '1 day', 'single-elimination', 16, NULL, 50, 25, 25, 'upcoming', now(), now() + interval '6 minutes', 'upper', 'admin', NULL),
('1d706cf4-35e7-4454-a828-8006e44b7505', 'Middle Time 16p Battles!', 'Tournament with max 16 participants', now(), now() + interval '1 day', 'single-elimination', 16, NULL, 50, 25, 25, 'upcoming', now(), now() + interval '6 minutes', 'middle', 'admin', NULL),
('04c4d78b-541f-4cfd-ae26-e0c542661c4a', 'Lower Time 16p Battles!', 'Tournament with max 16 participants', now(), now() + interval '1 day', 'single-elimination', 16, NULL, 50, 25, 25, 'upcoming', now(), now() + interval '6 minutes', 'lower', 'admin', NULL),
('ecc30185-9cfe-441c-96d5-629b0c2bec27', 'Upper Time 2p Battles!', 'May the fastest win!', now(), now() + interval '1 day', 'single-elimination', 2, '', 100, 0, 0, 'upcoming', now(), now() + interval '6 minutes', 'upper', 'admin', NULL),
('960a05ea-7151-41b9-9d79-689bbd75c74d', 'Middle Time 2p Battles!', 'May the fastest win!', now(), now() + interval '1 day', 'single-elimination', 2, '', 100, 0, 0, 'upcoming', now(), now() + interval '6 minutes', 'middle', 'admin', NULL),
('09d82050-01d6-49fc-86bc-bfd84c3890df', 'Lower Time 2p Battles!', 'May the fastest win!', now(), now() + interval '1 day', 'single-elimination', 2, '', 100, 0, 0, 'upcoming', now(), now() + interval '6 minutes', 'lower', 'admin', NULL);
('27db2b6d-c4b2-4882-8e52-8c2f381e1a3d', 'Demo Tournament', 'Demo', now(), now() + interval '1 day', 'single-elimination', 8, '', 65, 15, 20, 'upcoming', now - interval '1 day', now(), 'middle', 'admin', NULL);

DELETE FROM public.tournaments where id in
('04c4d78b-541f-4cfd-ae26-e0c542661c4a',
'1d706cf4-35e7-4454-a828-8006e44b7505',
'b9b464b3-018b-416e-91f7-1ecbbea67442');

--
-- Name: brackets brackets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brackets
    ADD CONSTRAINT brackets_pkey PRIMARY KEY (id);


--
-- Name: rounds rounds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rounds
    ADD CONSTRAINT rounds_pkey PRIMARY KEY (id);


--
-- Name: tournaments tournaments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tournaments
    ADD CONSTRAINT tournaments_pkey PRIMARY KEY (id);

--
-- Name: brackets unique_round_bracket_seq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brackets
    ADD CONSTRAINT unique_round_bracket_seq UNIQUE (round_id, seq_id);


--
-- Name: rounds unique_tournament_round_seq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rounds
    ADD CONSTRAINT unique_tournament_round_seq UNIQUE (tournament_id, seq_id);


--
-- Name: brackets trigger_set_bracket_seq_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_set_bracket_seq_id BEFORE INSERT ON public.brackets FOR EACH ROW EXECUTE FUNCTION public.set_bracket_seq_id();


--
-- Name: rounds trigger_set_round_seq_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_set_round_seq_id BEFORE INSERT ON public.rounds FOR EACH ROW EXECUTE FUNCTION public.set_round_seq_id();


--
-- Name: tournament_participants tournament_participants_tournament_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tournament_participants
    ADD CONSTRAINT unique_tournament_participant UNIQUE (tournament_id, participant),
    ADD CONSTRAINT tournament_participants_tournament_id_fkey FOREIGN KEY (tournament_id) REFERENCES public.tournaments(id) ON DELETE CASCADE;


--
-- Name: brackets brackets_round_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brackets
    ADD CONSTRAINT brackets_tournamet_id_fkey FOREIGN KEY (tournament_id) REFERENCES public.tournaments(id) ON DELETE CASCADE,
    ADD CONSTRAINT brackets_round_id_fkey FOREIGN KEY (round_id) REFERENCES public.rounds(id) ON DELETE CASCADE;
    -- ADD CONSTRAINT brackets_player1_fkey FOREIGN KEY (tournament_id, player1) REFERENCES public.tournament_participants(tournament_id, participant),
    -- ADD CONSTRAINT brackets_player2_fkey FOREIGN KEY (tournament_id, player2) REFERENCES public.tournament_participants(tournament_id, participant);


--
-- Name: rounds rounds_tournament_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rounds
    ADD CONSTRAINT rounds_tournament_id_fkey FOREIGN KEY (tournament_id) REFERENCES public.tournaments(id) ON DELETE CASCADE;


--
-- Name: tournament_signups tournament_signups_tournament_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tournament_signups
    ADD CONSTRAINT tournament_signups_tournament_id_fkey FOREIGN KEY (tournament_id) REFERENCES public.tournaments(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--
