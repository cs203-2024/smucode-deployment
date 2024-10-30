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
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    user_role character varying(255),
    username character varying(255) NOT NULL,
    CONSTRAINT users_user_role_check CHECK (((user_role)::text = ANY ((ARRAY['PLAYER'::character varying, 'ADMIN'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, user_role, username) FROM stdin;
c8df7a7b-6cc1-4c69-b867-5fb63130a14e	user1@example.com	password123	PLAYER	user1
c168f1db-4d2f-4a4b-a4c4-33fb51b5f5c9	user2@example.com	password123	PLAYER	user2
e4c78f15-9a71-4c2d-92d1-f28b59a3c3e7	user3@example.com	password123	PLAYER	user3
a9d2f714-8c3e-4b5f-9d6a-1b7c4e5f8a9b	user4@example.com	password123	PLAYER	user4
b1c3d5e7-9f8e-4d2c-1a3b-5c7d9e1f3a5b	user5@example.com	password123	PLAYER	user5
f2e4d6c8-1a9b-3c5d-7e8f-4b2a6c8d0e9f	user6@example.com	password123	PLAYER	user6
e3f5d7c9-2b1a-4d6e-8f0a-5c3b7d9e1f3f	user7@example.com	password123	PLAYER	user7
d4e6f8a0-3c2b-5e7f-9a1b-6d4c8e0f2a4b	user8@example.com	password123	PLAYER	user8
c5f7a9b1-4d3c-6f8a-0b2c-7e5d9f1a3b5c	user9@example.com	password123	PLAYER	user9
b6a8b0c2-5e4d-7a9b-1c3d-8f6e0a2b4c6d	user10@example.com	password123	PLAYER	user10
a7b9c1d3-6f5e-8a0b-2d4e-9a7f1b3c5d7e	user11@example.com	password123	PLAYER	user11
f8c0d2e4-7a6f-9b1c-3e5f-0b8a2c4d6e8f	user12@example.com	password123	PLAYER	user12
e9d1e3f5-8b7a-0c2d-4f6a-1c9b3d5e7f9a	user13@example.com	password123	PLAYER	user13
d0e2f4a6-9c8b-1d3e-5a7b-2d0c4e6f8a0b	user14@example.com	password123	PLAYER	user14
c1f3a5b7-0d9c-2e4f-6b8c-3e1d5f7a9b1c	user15@example.com	password123	PLAYER	user15
b2a4b6c8-1e0d-3f5a-7c9d-4f2e6a8b0c2d	user16@example.com	password123	PLAYER	user16
a3b5c7d9-2f1e-4a6b-8d0e-5a3f7b9c1d3e	user17@example.com	password123	PLAYER	user17
94c6d8e0-3a2f-5b7c-9e1f-6b4a8c0d2e4f	user18@example.com	password123	PLAYER	user18
85d7e9f1-4b3a-6c8d-0f2a-7c5b9d1e3f5a	user19@example.com	password123	PLAYER	user19
76e8f0a2-5c4b-7d9e-1a3b-8d6c0e2f4a6b	user20@example.com	password123	PLAYER	user20
67f9a1b3-6d5c-8e0f-2b4c-9e7d1f3a5b7c	user21@example.com	password123	PLAYER	user21
58a0b2c4-7e6d-9f1a-3c5d-0f8e2a4b6c8d	user22@example.com	password123	PLAYER	user22
49b1c3d5-8f7e-0a2b-4d6e-1a9f3b5c7d9e	user23@example.com	password123	PLAYER	user23
30c2d4e6-9a8f-1b3c-5e7f-2b0a4c6d8e0f	user24@example.com	password123	PLAYER	user24
21d3e5f7-0b9a-2c4d-6f8a-3c1b5d7e9f1a	user25@example.com	password123	PLAYER	user25
12e4f6a8-1c0b-3d5e-7a9b-4d2c6e8f0a2b	user26@example.com	password123	PLAYER	user26
03f5a7b9-2d1c-4e6f-8b0c-5e3d7f9a1b3c	user27@example.com	password123	PLAYER	user27
f4a6b8c0-3e2d-5f7a-9c1d-6f4e8a0b2c4d	user28@example.com	password123	PLAYER	user28
e5b7c9d1-4f3e-6a8b-0d2e-7a5f9b1c3d5e	user29@example.com	password123	PLAYER	user29
d6c8d0e2-5a4f-7b9c-1e3f-8b6a0c2d4e6f	user30@example.com	password123	PLAYER	user30
\.


--
-- Name: users uk6dotkott2kjsp8vw4d0m25fb7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk6dotkott2kjsp8vw4d0m25fb7 UNIQUE (email);


--
-- Name: users ukr43af9ap4edm43mmtq01oddj6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT ukr43af9ap4edm43mmtq01oddj6 UNIQUE (username);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--
