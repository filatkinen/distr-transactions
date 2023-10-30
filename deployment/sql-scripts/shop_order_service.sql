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

DROP DATABASE IF EXISTS shop_order_service;
--
-- Name: shop_order_service; Type: DATABASE; Schema: -; Owner: shop_order_service_user
--

CREATE DATABASE shop_order_service WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE shop_order_service OWNER TO shop_order_service_user;

\connect shop_order_service

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
-- Name: order_items; Type: TABLE; Schema: public; Owner: shop_order_service_user
--

CREATE TABLE public.order_items (
    order_item_id bigint NOT NULL,
    order_id bigint NOT NULL,
    item_id integer NOT NULL,
    quantity smallint NOT NULL,
    price numeric
);


ALTER TABLE public.order_items OWNER TO shop_order_service_user;

--
-- Name: order_items_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: shop_order_service_user
--

CREATE SEQUENCE public.order_items_order_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_items_order_item_id_seq OWNER TO shop_order_service_user;

--
-- Name: order_items_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shop_order_service_user
--

ALTER SEQUENCE public.order_items_order_item_id_seq OWNED BY public.order_items.order_item_id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: shop_order_service_user
--

CREATE TABLE public.orders (
    order_id bigint NOT NULL,
    user_id integer NOT NULL,
    notification_type integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    approved_at timestamp with time zone NOT NULL,
    sum integer NOT NULL,
    status integer NOT NULL,
    detail text
);


ALTER TABLE public.orders OWNER TO shop_order_service_user;

--
-- Name: order_order_id_seq; Type: SEQUENCE; Schema: public; Owner: shop_order_service_user
--

CREATE SEQUENCE public.order_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_order_id_seq OWNER TO shop_order_service_user;

--
-- Name: order_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shop_order_service_user
--

ALTER SEQUENCE public.order_order_id_seq OWNED BY public.orders.order_id;


--
-- Name: order_items order_item_id; Type: DEFAULT; Schema: public; Owner: shop_order_service_user
--

ALTER TABLE ONLY public.order_items ALTER COLUMN order_item_id SET DEFAULT nextval('public.order_items_order_item_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: shop_order_service_user
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.order_order_id_seq'::regclass);


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: shop_order_service_user
--

COPY public.order_items (order_item_id, order_id, item_id, quantity, price) FROM stdin;
2	2	2	3	100
3	2	2	3	100
5	5	10	2	45
6	5	15	1	10
7	6	10	2	45
8	6	15	1	10
9	7	10	2	45
10	7	15	1	10
11	8	10	2	45
12	8	15	1	10
13	9	10	2	45
14	9	15	1	10
15	10	10	2	45
16	10	15	1	10
17	11	10	2	45
18	11	15	1	10
19	12	10	2	45
20	12	15	1	10
21	13	10	2	45
22	13	15	1	10
23	14	10	2	45
24	14	15	1	10
25	15	10	2	45
26	15	15	1	10
27	16	10	2	45
28	16	15	1	10
29	17	10	2	45
30	17	15	1	10
31	18	10	2	45
32	18	15	1	10
33	19	10	2	45
34	19	15	1	10
35	20	10	2	45
36	20	15	1	10
37	21	10	2	45
38	21	15	1	10
39	22	10	2	45
40	22	15	1	10
41	23	10	2	45
42	23	15	1	10
43	24	10	2	45
44	24	15	1	10
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: shop_order_service_user
--

COPY public.orders (order_id, user_id, notification_type, created_at, approved_at, sum, status, detail) FROM stdin;
5	2	1	2023-10-28 17:42:32.572146+03	2023-10-28 17:42:32.572146+03	10000	1	\N
6	2	1	2023-10-28 17:48:49.666509+03	2023-10-28 17:48:49.666509+03	10000	1	\N
7	2	1	2023-10-28 17:48:50.954353+03	2023-10-28 17:48:50.954353+03	10000	1	\N
2	1	1	2023-10-27 20:15:38.845333+03	2023-10-27 20:15:38.845333+03	23	7	\N
8	2	1	2023-10-30 18:35:13.395933+03	2023-10-30 18:35:13.395933+03	10000	2	
9	2	1	2023-10-30 18:39:03.108645+03	2023-10-30 18:39:03.108645+03	10000	2	
10	2	1	2023-10-30 19:12:53.108769+03	2023-10-30 19:12:53.108769+03	10000	1	\N
11	2	1	2023-10-30 19:14:37.771365+03	2023-10-30 19:14:37.781704+03	10000	2	
12	2	1	2023-10-30 19:17:37.035832+03	2023-10-30 19:17:37.039525+03	10000	2	
13	2	1	2023-10-30 19:20:09.812437+03	2023-10-30 19:20:09.814517+03	10000	2	
14	2	1	2023-10-30 19:22:40.44843+03	2023-10-30 19:22:40.45172+03	10000	2	
15	2	1	2023-10-30 19:25:17.849829+03	2023-10-30 19:25:17.851911+03	10000	2	
16	2	1	2023-10-30 19:32:46.670244+03	2023-10-30 19:32:46.678249+03	10000	2	
17	2	1	2023-10-30 20:31:38.34299+03	2023-10-30 20:41:32.631022+03	10000	3	[{"order_id":17,"serviceID":1,"status_at":"2023-10-30T20:31:38.736+03:00","status":2,"detail":""},{"order_id":17,"serviceID":2,"status_at":"2023-10-30T20:31:39.174+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:39.422+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:39.831+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:39.996+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:40.415+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:40.909+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:41.047+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:41.405+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:41.585+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:41.745+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:42.142+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:42.607+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:42.911+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:43.255+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:43.747+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:44.015+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:44.123+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:44.483+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:44.808+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:44.953+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:45.16+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:45.324+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:45.574+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:46.037+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:46.538+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:46.929+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:47.065+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:47.457+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:47.642+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:48.067+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:48.316+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:48.703+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:48.872+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:49.086+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:49.473+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:49.579+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:49.764+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:49.888+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:50.242+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:50.635+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:50.883+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:51.249+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:51.372+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:51.789+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:52.039+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:52.404+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:52.546+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:52.73+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:53.225+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:53.56+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:53.9+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:54.37+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:54.677+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:55.183+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:55.409+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:55.792+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:56.282+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:56.509+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:56.778+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:56.899+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:57.35+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:57.631+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:58.021+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:58.287+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:58.782+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:58.946+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:59.179+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:31:59.641+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:00.073+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:00.476+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:00.922+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:01.398+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:01.81+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:01.967+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:02.341+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:02.772+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:02.883+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:03.352+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:03.745+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:03.914+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:04.314+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:04.49+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:04.906+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:05.351+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:05.464+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:05.787+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:05.986+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:06.27+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:06.714+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:32:06.876+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:26.499+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:26.627+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:26.802+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:27.189+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:27.624+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:27.917+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:28.302+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:28.655+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:28.911+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:29.364+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:29.848+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:30.068+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:30.179+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:30.43+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:30.65+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:30.822+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:31.195+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:31.622+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:31.929+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:32.155+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:32.645+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:32.86+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:33.238+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:33.701+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:34.029+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:34.133+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:34.541+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:34.866+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:35.127+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:35.35+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:35.686+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:35.939+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:36.052+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:36.482+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:36.811+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:37.295+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:37.399+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:37.542+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:37.783+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:38.111+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:38.319+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:38.789+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:39.237+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:39.477+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:39.676+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:39.783+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:40.264+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:40.405+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:40.598+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:41.047+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:41.476+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:41.877+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:42.109+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:42.46+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:42.947+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:43.269+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:43.556+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:43.764+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:44+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:44.213+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:44.343+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:44.592+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:45.08+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:45.58+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:45.832+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:46.216+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:46.492+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:46.983+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:47.297+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:47.41+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:47.527+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:47.826+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:48.207+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:48.367+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:48.52+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:48.723+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:49.224+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:49.632+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:49.768+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:50.214+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:50.395+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:50.85+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:51.194+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:51.515+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:51.883+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:52.094+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:52.213+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:52.544+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:52.934+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:53.239+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:53.491+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:53.874+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:54.347+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:54.644+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:54.824+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:55.21+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:55.494+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:55.704+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:55.809+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:56.249+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:56.709+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:56.991+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:57.153+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:57.581+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:57.689+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:58.044+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:58.356+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:58.672+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:59.06+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:59.276+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:35:59.709+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:36:00.085+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:36:00.206+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:36:00.69+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:36:00.793+03:00","status":2,"detail":""},{"order_id":17,"serviceID":3,"status_at":"2023-10-30T20:41:32.621+03:00","status":2,"detail":""}]
18	2	1	2023-10-30 20:41:53.509118+03	2023-10-30 20:41:54.188391+03	10000	3	[{"order_id":18,"serviceID":1,"status_at":"2023-10-30T20:41:53.797+03:00","status":2,"detail":""},{"order_id":18,"serviceID":2,"status_at":"2023-10-30T20:41:53.905+03:00","status":2,"detail":""},{"order_id":18,"serviceID":3,"status_at":"2023-10-30T20:41:54.185+03:00","status":2,"detail":""}]
19	2	1	2023-10-30 20:43:53.256502+03	2023-10-30 20:44:04.305764+03	10000	3	[{"order_id":19,"serviceID":1,"status_at":"2023-10-30T20:44:03.755+03:00","status":2,"detail":""},{"order_id":19,"serviceID":2,"status_at":"2023-10-30T20:44:04.064+03:00","status":2,"detail":""},{"order_id":19,"serviceID":3,"status_at":"2023-10-30T20:44:04.296+03:00","status":2,"detail":""}]
20	2	1	2023-10-30 20:49:41.403016+03	2023-10-30 20:49:42.298068+03	10000	3	[{"order_id":20,"serviceID":1,"status_at":"2023-10-30T20:49:41.575+03:00","status":2,"detail":""},{"order_id":20,"serviceID":2,"status_at":"2023-10-30T20:49:42.021+03:00","status":2,"detail":""},{"order_id":20,"serviceID":3,"status_at":"2023-10-30T20:49:42.294+03:00","status":2,"detail":""}]
21	2	1	2023-10-30 20:50:48.666632+03	2023-10-30 20:50:49.873559+03	10000	3	[{"order_id":21,"serviceID":1,"status_at":"2023-10-30T20:50:49.044+03:00","status":2,"detail":""},{"order_id":21,"serviceID":2,"status_at":"2023-10-30T20:50:49.363+03:00","status":2,"detail":""},{"order_id":21,"serviceID":3,"status_at":"2023-10-30T20:50:49.864+03:00","status":2,"detail":""}]
22	2	1	2023-10-30 21:00:35.229923+03	2023-10-30 21:00:36.368742+03	10000	3	[{"order_id":22,"serviceID":1,"status_at":"2023-10-30T21:00:35.516+03:00","status":2,"detail":""},{"order_id":22,"serviceID":2,"status_at":"2023-10-30T21:00:35.974+03:00","status":2,"detail":""},{"order_id":22,"serviceID":3,"status_at":"2023-10-30T21:00:36.364+03:00","status":3,"detail":"Error notification"}]
23	2	1	2023-10-30 21:04:28.867239+03	2023-10-30 21:09:02.794455+03	10000	4	[{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:28.985+03:00","status":2,"detail":""},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:29.333+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:29.56+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:29.985+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:30.258+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:30.56+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:30.728+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:30.918+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:31.375+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:31.54+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:31.836+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:32.134+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:32.452+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:32.952+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:33.216+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:33.45+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:33.659+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:33.87+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:34.072+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:34.19+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:34.517+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:34.908+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:35.145+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:35.518+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:35.664+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:35.882+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:36.127+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:36.421+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:36.638+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:37.13+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:37.517+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:37.804+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:37.92+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:38.036+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:38.152+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:38.58+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:38.829+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:39.161+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:39.525+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:39.965+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:40.141+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:40.421+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:40.614+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:40.846+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:40.99+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:41.298+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:41.588+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:41.855+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:42.161+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:42.339+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:42.677+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:42.846+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:42.97+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:43.457+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:43.722+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:43.829+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:44.252+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:44.367+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:44.786+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:45.123+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:45.28+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:45.422+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:45.876+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:46.186+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:46.412+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:46.549+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:47.003+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:47.471+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:47.624+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:48.046+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:48.226+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:48.614+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:49.077+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:49.399+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:49.723+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:50.001+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:50.401+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:50.63+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:51.038+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:51.289+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:51.623+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:51.849+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:52.085+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:52.188+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:52.642+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:52.755+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:52.991+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:53.106+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:53.318+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:53.44+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:53.642+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:54.052+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:54.337+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:54.718+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:54.911+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:55.332+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:55.728+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:55.856+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:56.236+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:56.68+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:57.007+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:57.172+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:57.67+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:57.832+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:58.026+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:58.52+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:58.873+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:59.208+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:04:59.607+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:04:59.896+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:00.388+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:00.658+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:01.162+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:01.334+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:01.469+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:01.931+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:02.303+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:02.467+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:02.876+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:03.183+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:03.496+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:03.816+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:03.978+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:04.255+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:04.444+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:04.633+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:05.012+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:05.483+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:05.856+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:06.076+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:06.266+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:06.658+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:07.127+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:07.574+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:07.766+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:08.21+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:08.71+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:08.891+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:09.304+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:09.732+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:10.082+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:10.418+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:10.705+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:11.005+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:11.107+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:11.591+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:12.032+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:12.155+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:12.513+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:12.974+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:13.332+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:13.535+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:14.008+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:14.498+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:14.698+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:15.041+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:15.357+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:15.661+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:15.972+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:16.174+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:16.558+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:16.794+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:16.943+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:17.05+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:17.205+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:17.349+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:17.484+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:17.902+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:18.056+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:18.187+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:18.503+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:18.897+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:19.177+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:19.626+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:19.979+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:20.188+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:20.522+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:20.926+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:21.233+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:21.591+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:21.745+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:22.18+03:00","status":3,"detail":"Error payment"},{"order_id":23,"serviceID":1,"status_at":"2023-10-30T21:05:22.315+03:00","status":2,"detail":"Reserv canceled"},{"order_id":23,"serviceID":2,"status_at":"2023-10-30T21:05:22.76+03:00","status":3,"detail":"Error payment"}]
24	2	1	2023-10-30 21:09:38.659307+03	2023-10-30 21:09:39.101436+03	10000	4	[{"order_id":24,"serviceID":1,"status_at":"2023-10-30T21:09:38.964+03:00","status":2,"detail":""},{"order_id":24,"serviceID":2,"status_at":"2023-10-30T21:09:39.097+03:00","status":3,"detail":"Error payment"}]
\.


--
-- Name: order_items_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shop_order_service_user
--

SELECT pg_catalog.setval('public.order_items_order_item_id_seq', 44, true);


--
-- Name: order_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shop_order_service_user
--

SELECT pg_catalog.setval('public.order_order_id_seq', 24, true);


--
-- Name: order_items order_items_pk; Type: CONSTRAINT; Schema: public; Owner: shop_order_service_user
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pk PRIMARY KEY (order_item_id);


--
-- Name: orders orders_pk; Type: CONSTRAINT; Schema: public; Owner: shop_order_service_user
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pk PRIMARY KEY (order_id);


--
-- Name: order_items order_items_order_order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: shop_order_service_user
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_order_id_fk FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

