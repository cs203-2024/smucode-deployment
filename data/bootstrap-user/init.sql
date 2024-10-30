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
-- Name: user_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_profile (
    id uuid NOT NULL,
    email character varying(255),
    losses integer NOT NULL,
    mu double precision NOT NULL,
    profile_image_url character varying(255),
    sigma double precision NOT NULL,
    skill_index double precision NOT NULL,
    username character varying(255),
    wins integer NOT NULL
);


ALTER TABLE public.user_profile OWNER TO postgres;

--
-- Data for Name: user_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_profile (id, username, profile_image_url, email, mu, sigma, skill_index, wins, losses) FROM stdin;
\.

INSERT INTO public.user_profile (id, username, profile_image_url, email, mu, sigma, skill_index, wins, losses) VALUES
('c8df7a7b-6cc1-4c69-b867-5fb63130a14e', 'user1', 'google.com', 'user1@example.com', 15.4, 7.2, 15.4 - 3 * 7.2, 0, 0),
('c168f1db-4d2f-4a4b-a4c4-33fb51b5f5c9', 'user2', 'google.com', 'user2@example.com', 28.9, 5.8, 28.9 - 3 * 5.8, 0, 0),
('e4c78f15-9a71-4c2d-92d1-f28b59a3c3e7', 'user3', 'google.com', 'user3@example.com', 22.3, 9.1, 22.3 - 3 * 9.1, 0, 0),
('a9d2f714-8c3e-4b5f-9d6a-1b7c4e5f8a9b', 'user4', 'google.com', 'user4@example.com', 31.5, 6.4, 31.5 - 3 * 6.4, 0, 0),
('b1c3d5e7-9f8e-4d2c-1a3b-5c7d9e1f3a5b', 'user5', 'google.com', 'user5@example.com', 19.8, 10.2, 19.8 - 3 * 10.2, 0, 0),
('f2e4d6c8-1a9b-3c5d-7e8f-4b2a6c8d0e9f', 'user6', 'google.com', 'user6@example.com', 33.2, 5.5, 33.2 - 3 * 5.5, 0, 0),
('e3f5d7c9-2b1a-4d6e-8f0a-5c3b7d9e1f3f', 'user7', 'google.com', 'user7@example.com', 12.7, 8.7, 12.7 - 3 * 8.7, 0, 0),
('d4e6f8a0-3c2b-5e7f-9a1b-6d4c8e0f2a4b', 'user8', 'google.com', 'user8@example.com', 27.1, 6.9, 27.1 - 3 * 6.9, 0, 0),
('c5f7a9b1-4d3c-6f8a-0b2c-7e5d9f1a3b5c', 'user9', 'google.com', 'user9@example.com', 16.9, 9.8, 16.9 - 3 * 9.8, 0, 0),
('b6a8b0c2-5e4d-7a9b-1c3d-8f6e0a2b4c6d', 'user10', 'google.com', 'user10@example.com', 29.4, 7.5, 29.4 - 3 * 7.5, 0, 0),
('a7b9c1d3-6f5e-8a0b-2d4e-9a7f1b3c5d7e', 'user11', 'google.com', 'user11@example.com', 24.6, 5.9, 24.6 - 3 * 5.9, 0, 0),
('f8c0d2e4-7a6f-9b1c-3e5f-0b8a2c4d6e8f', 'user12', 'google.com', 'user12@example.com', 34.8, 8.3, 34.8 - 3 * 8.3, 0, 0),
('e9d1e3f5-8b7a-0c2d-4f6a-1c9b3d5e7f9a', 'user13', 'google.com', 'user13@example.com', 18.2, 10.7, 18.2 - 3 * 10.7, 0, 0),
('d0e2f4a6-9c8b-1d3e-5a7b-2d0c4e6f8a0b', 'user14', 'google.com', 'user14@example.com', 25.9, 6.2, 25.9 - 3 * 6.2, 0, 0),
('c1f3a5b7-0d9c-2e4f-6b8c-3e1d5f7a9b1c', 'user15', 'google.com', 'user15@example.com', 13.5, 9.4, 13.5 - 3 * 9.4, 0, 0),
('b2a4b6c8-1e0d-3f5a-7c9d-4f2e6a8b0c2d', 'user16', 'google.com', 'user16@example.com', 30.7, 7.8, 30.7 - 3 * 7.8, 0, 0),
('a3b5c7d9-2f1e-4a6b-8d0e-5a3f7b9c1d3e', 'user17', 'google.com', 'user17@example.com', 21.4, 5.6, 21.4 - 3 * 5.6, 0, 0),
('94c6d8e0-3a2f-5b7c-9e1f-6b4a8c0d2e4f', 'user18', 'google.com', 'user18@example.com', 32.9, 8.9, 32.9 - 3 * 8.9, 0, 0),
('85d7e9f1-4b3a-6c8d-0f2a-7c5b9d1e3f5a', 'user19', 'google.com', 'user19@example.com', 17.6, 10.4, 17.6 - 3 * 10.4, 0, 0),
('76e8f0a2-5c4b-7d9e-1a3b-8d6c0e2f4a6b', 'user20', 'google.com', 'user20@example.com', 26.3, 6.7, 26.3 - 3 * 6.7, 0, 0),
('67f9a1b3-6d5c-8e0f-2b4c-9e7d1f3a5b7c', 'user21', 'google.com', 'user21@example.com', 14.8, 9.6, 14.8 - 3 * 9.6, 0, 0),
('58a0b2c4-7e6d-9f1a-3c5d-0f8e2a4b6c8d', 'user22', 'google.com', 'user22@example.com', 31.2, 7.3, 31.2 - 3 * 7.3, 0, 0),
('49b1c3d5-8f7e-0a2b-4d6e-1a9f3b5c7d9e', 'user23', 'google.com', 'user23@example.com', 20.5, 5.7, 20.5 - 3 * 5.7, 0, 0),
('30c2d4e6-9a8f-1b3c-5e7f-2b0a4c6d8e0f', 'user24', 'google.com', 'user24@example.com', 33.8, 8.5, 33.8 - 3 * 8.5, 0, 0),
('21d3e5f7-0b9a-2c4d-6f8a-3c1b5d7e9f1a', 'user25', 'google.com', 'user25@example.com', 16.3, 10.9, 16.3 - 3 * 10.9, 0, 0),
('12e4f6a8-1c0b-3d5e-7a9b-4d2c6e8f0a2b', 'user26', 'google.com', 'user26@example.com', 27.8, 6.5, 27.8 - 3 * 6.5, 0, 0),
('03f5a7b9-2d1c-4e6f-8b0c-5e3d7f9a1b3c', 'user27', 'google.com', 'user27@example.com', 11.9, 9.2, 11.9 - 3 * 9.2, 0, 0),
('f4a6b8c0-3e2d-5f7a-9c1d-6f4e8a0b2c4d', 'user28', 'google.com', 'user28@example.com', 29.6, 7.6, 29.6 - 3 * 7.6, 0, 0),
('e5b7c9d1-4f3e-6a8b-0d2e-7a5f9b1c3d5e', 'user29', 'google.com', 'user29@example.com', 23.1, 5.4, 23.1 - 3 * 5.4, 0, 0),
('d6c8d0e2-5a4f-7b9c-1e3f-8b6a0c2d4e6f', 'user30', 'google.com', 'user30@example.com', 34.2, 8.1, 34.2 - 3 * 8.1, 0, 0);



--
-- Name: user_profile uk9551piq2wp9kh4kket0wr65vt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT uk9551piq2wp9kh4kket0wr65vt UNIQUE (username);


--
-- Name: user_profile uktcks72p02h4dp13cbhxne17ad; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT uktcks72p02h4dp13cbhxne17ad UNIQUE (email);


--
-- Name: user_profile user_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--
