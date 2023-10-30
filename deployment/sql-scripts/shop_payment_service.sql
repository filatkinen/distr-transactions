--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4 (Ubuntu 15.4-0ubuntu0.23.04.1)
-- Dumped by pg_dump version 15.4 (Ubuntu 15.4-0ubuntu0.23.04.1)

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

DROP DATABASE IF EXISTS shop_payment_service;
--
-- Name: shop_payment_service; Type: DATABASE; Schema: -; Owner: shop_payment_service_user
--

CREATE DATABASE shop_payment_service WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE shop_payment_service OWNER TO shop_payment_service_user;

\connect shop_payment_service

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
-- Name: payment; Type: TABLE; Schema: public; Owner: shop_payment_service_user
--

CREATE TABLE public.payment (
    payment_id bigint NOT NULL,
    order_id bigint NOT NULL,
    payment_type text NOT NULL,
    payment_at timestamp with time zone NOT NULL,
    sum numeric NOT NULL,
    status text NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.payment OWNER TO shop_payment_service_user;

--
-- Name: payment_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: shop_payment_service_user
--

CREATE SEQUENCE public.payment_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_payment_id_seq OWNER TO shop_payment_service_user;

--
-- Name: payment_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shop_payment_service_user
--

ALTER SEQUENCE public.payment_payment_id_seq OWNED BY public.payment.payment_id;


--
-- Name: payment payment_id; Type: DEFAULT; Schema: public; Owner: shop_payment_service_user
--

ALTER TABLE ONLY public.payment ALTER COLUMN payment_id SET DEFAULT nextval('public.payment_payment_id_seq'::regclass);


--
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: shop_payment_service_user
--

COPY public.payment (payment_id, order_id, payment_type, payment_at, sum, status, user_id) FROM stdin;
\.


--
-- Name: payment_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shop_payment_service_user
--

SELECT pg_catalog.setval('public.payment_payment_id_seq', 1, false);


--
-- Name: payment payment_pk; Type: CONSTRAINT; Schema: public; Owner: shop_payment_service_user
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pk PRIMARY KEY (payment_id);


--
-- Name: payment_order_id_user_id_index; Type: INDEX; Schema: public; Owner: shop_payment_service_user
--

CREATE INDEX payment_order_id_user_id_index ON public.payment USING btree (order_id, user_id);


--
-- PostgreSQL database dump complete
--

