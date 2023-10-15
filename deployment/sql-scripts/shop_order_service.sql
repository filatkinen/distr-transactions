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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: order; Type: TABLE; Schema: public; Owner: shop_order_service_user
--

CREATE TABLE public."order" (
    order_id bigint NOT NULL,
    user_id integer NOT NULL,
    notification_type text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    approved_at timestamp with time zone,
    sum numeric NOT NULL,
    status text NOT NULL
);


ALTER TABLE public."order" OWNER TO shop_order_service_user;

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
-- Name: order_new; Type: TABLE; Schema: public; Owner: shop_order_service_user
--

CREATE TABLE public.order_new (
    order_id bigint NOT NULL,
    user_id integer NOT NULL,
    notification_type text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    approved_at timestamp with time zone,
    sum numeric NOT NULL,
    status text NOT NULL,
    order_items bytea NOT NULL
);


ALTER TABLE public.order_new OWNER TO shop_order_service_user;

--
-- Name: order_new_order_id_seq; Type: SEQUENCE; Schema: public; Owner: shop_order_service_user
--

CREATE SEQUENCE public.order_new_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_new_order_id_seq OWNER TO shop_order_service_user;

--
-- Name: order_new_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shop_order_service_user
--

ALTER SEQUENCE public.order_new_order_id_seq OWNED BY public.order_new.order_id;


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

ALTER SEQUENCE public.order_order_id_seq OWNED BY public."order".order_id;


--
-- Name: order order_id; Type: DEFAULT; Schema: public; Owner: shop_order_service_user
--

ALTER TABLE ONLY public."order" ALTER COLUMN order_id SET DEFAULT nextval('public.order_order_id_seq'::regclass);


--
-- Name: order_items order_item_id; Type: DEFAULT; Schema: public; Owner: shop_order_service_user
--

ALTER TABLE ONLY public.order_items ALTER COLUMN order_item_id SET DEFAULT nextval('public.order_items_order_item_id_seq'::regclass);


--
-- Name: order_new order_id; Type: DEFAULT; Schema: public; Owner: shop_order_service_user
--

ALTER TABLE ONLY public.order_new ALTER COLUMN order_id SET DEFAULT nextval('public.order_new_order_id_seq'::regclass);


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: shop_order_service_user
--



--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: shop_order_service_user
--



--
-- Data for Name: order_new; Type: TABLE DATA; Schema: public; Owner: shop_order_service_user
--



--
-- Name: order_items_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shop_order_service_user
--

SELECT pg_catalog.setval('public.order_items_order_item_id_seq', 1, false);


--
-- Name: order_new_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shop_order_service_user
--

SELECT pg_catalog.setval('public.order_new_order_id_seq', 1, false);


--
-- Name: order_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shop_order_service_user
--

SELECT pg_catalog.setval('public.order_order_id_seq', 1, false);


--
-- Name: order_items order_items_pk; Type: CONSTRAINT; Schema: public; Owner: shop_order_service_user
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pk PRIMARY KEY (order_item_id);


--
-- Name: order_new order_new_pk; Type: CONSTRAINT; Schema: public; Owner: shop_order_service_user
--

ALTER TABLE ONLY public.order_new
    ADD CONSTRAINT order_new_pk PRIMARY KEY (order_id);


--
-- Name: order order_pk; Type: CONSTRAINT; Schema: public; Owner: shop_order_service_user
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pk PRIMARY KEY (order_id);


--
-- Name: order_items order_items_order_order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: shop_order_service_user
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_order_id_fk FOREIGN KEY (order_id) REFERENCES public."order"(order_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: order_new order_new_order_order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: shop_order_service_user
--

ALTER TABLE ONLY public.order_new
    ADD CONSTRAINT order_new_order_order_id_fk FOREIGN KEY (order_id) REFERENCES public."order"(order_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

