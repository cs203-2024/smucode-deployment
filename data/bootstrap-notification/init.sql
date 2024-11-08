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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: notification_recipients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification_recipients (
    notification_id uuid NOT NULL,
    recipient character varying(255)
);


ALTER TABLE public.notification_recipients OWNER TO postgres;

--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id uuid NOT NULL,
    category character varying(255),
    created_at timestamp(6) without time zone,
    is_read boolean NOT NULL,
    message character varying(255) NOT NULL,
    tournament_id uuid NOT NULL,
    tournament_name character varying(255) NOT NULL,
    type character varying(255),
    CONSTRAINT notifications_category_check CHECK (((category)::text = ANY ((ARRAY['ALERT'::character varying, 'GENERAL'::character varying])::text[]))),
    CONSTRAINT notifications_type_check CHECK (((type)::text = ANY ((ARRAY['SIGNUP_CLOSED'::character varying, 'REGISTRATION_ACCEPTED'::character varying, 'REGISTRATION_REJECTED'::character varying, 'ROUND_STARTED'::character varying, 'ROUND_END'::character varying, 'SUSPICIOUS_BEHAVIOUR'::character varying, 'TOURNAMENT_START'::character varying, 'TOURNAMENT_END'::character varying, 'BRACKET_COMPLETED'::character varying, 'SYSTEM'::character varying])::text[])))
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Data for Name: notification_recipients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_recipients (notification_id, participant) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, category, created_at, is_read, message, tournament_id, tournament_name, type) FROM stdin;
\.


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: notification_recipients notification_recipients_notification_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_recipients
    ADD CONSTRAINT notification_recipients_notification_id_fkey FOREIGN KEY (notification_id) REFERENCES public.notifications(id);


--
-- PostgreSQL database dump complete
--
