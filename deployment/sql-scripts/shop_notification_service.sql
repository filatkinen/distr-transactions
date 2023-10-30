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

DROP DATABASE IF EXISTS shop_notification_service;
--
-- Name: shop_notification_service; Type: DATABASE; Schema: -; Owner: shop_notification_service_user
--

CREATE DATABASE shop_notification_service WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE shop_notification_service OWNER TO shop_notification_service_user;

\connect shop_notification_service

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
-- Name: notification; Type: TABLE; Schema: public; Owner: shop_notification_service_user
--

CREATE TABLE public.notification (
    notification_id bigint NOT NULL,
    order_id bigint NOT NULL,
    user_id bigint NOT NULL,
    notification_type text NOT NULL,
    status text NOT NULL
);


ALTER TABLE public.notification OWNER TO shop_notification_service_user;

--
-- Name: notification_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: shop_notification_service_user
--

CREATE SEQUENCE public.notification_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.notification_notification_id_seq OWNER TO shop_notification_service_user;

--
-- Name: notification_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shop_notification_service_user
--

ALTER SEQUENCE public.notification_notification_id_seq OWNED BY public.notification.notification_id;


--
-- Name: notification notification_id; Type: DEFAULT; Schema: public; Owner: shop_notification_service_user
--

ALTER TABLE ONLY public.notification ALTER COLUMN notification_id SET DEFAULT nextval('public.notification_notification_id_seq'::regclass);


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: shop_notification_service_user
--

COPY public.notification (notification_id, order_id, user_id, notification_type, status) FROM stdin;
\.


--
-- Name: notification_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shop_notification_service_user
--

SELECT pg_catalog.setval('public.notification_notification_id_seq', 1, false);


--
-- Name: notification_order_id_user_id_index; Type: INDEX; Schema: public; Owner: shop_notification_service_user
--

CREATE INDEX notification_order_id_user_id_index ON public.notification USING btree (order_id, user_id);


--
-- PostgreSQL database dump complete
--

