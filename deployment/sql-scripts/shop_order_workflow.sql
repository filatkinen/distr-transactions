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

ALTER TABLE ONLY public.service_status DROP CONSTRAINT service_status_order_new_order_id_fk;
ALTER TABLE ONLY public.service_status DROP CONSTRAINT service_status_pk;
ALTER TABLE ONLY public.order_new DROP CONSTRAINT order_new_pk;
ALTER TABLE public.order_new ALTER COLUMN order_id DROP DEFAULT;
DROP TABLE public.service_status;
DROP SEQUENCE public.order_new_order_id_seq;
DROP TABLE public.order_new;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: order_new; Type: TABLE; Schema: public; Owner: shop_order_workflow_user
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


ALTER TABLE public.order_new OWNER TO shop_order_workflow_user;

--
-- Name: order_new_order_id_seq; Type: SEQUENCE; Schema: public; Owner: shop_order_workflow_user
--

CREATE SEQUENCE public.order_new_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_new_order_id_seq OWNER TO shop_order_workflow_user;

--
-- Name: order_new_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shop_order_workflow_user
--

ALTER SEQUENCE public.order_new_order_id_seq OWNED BY public.order_new.order_id;


--
-- Name: service_status; Type: TABLE; Schema: public; Owner: shop_order_workflow_user
--

CREATE TABLE public.service_status (
    order_id bigint NOT NULL,
    service_id smallint NOT NULL,
    status_at timestamp with time zone NOT NULL,
    status text NOT NULL
);


ALTER TABLE public.service_status OWNER TO shop_order_workflow_user;

--
-- Name: order_new order_id; Type: DEFAULT; Schema: public; Owner: shop_order_workflow_user
--

ALTER TABLE ONLY public.order_new ALTER COLUMN order_id SET DEFAULT nextval('public.order_new_order_id_seq'::regclass);


--
-- Data for Name: order_new; Type: TABLE DATA; Schema: public; Owner: shop_order_workflow_user
--



--
-- Data for Name: service_status; Type: TABLE DATA; Schema: public; Owner: shop_order_workflow_user
--



--
-- Name: order_new_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shop_order_workflow_user
--

SELECT pg_catalog.setval('public.order_new_order_id_seq', 1, false);


--
-- Name: order_new order_new_pk; Type: CONSTRAINT; Schema: public; Owner: shop_order_workflow_user
--

ALTER TABLE ONLY public.order_new
    ADD CONSTRAINT order_new_pk PRIMARY KEY (order_id);


--
-- Name: service_status service_status_pk; Type: CONSTRAINT; Schema: public; Owner: shop_order_workflow_user
--

ALTER TABLE ONLY public.service_status
    ADD CONSTRAINT service_status_pk PRIMARY KEY (order_id, service_id);


--
-- Name: service_status service_status_order_new_order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: shop_order_workflow_user
--

ALTER TABLE ONLY public.service_status
    ADD CONSTRAINT service_status_order_new_order_id_fk FOREIGN KEY (order_id) REFERENCES public.order_new(order_id);


--
-- PostgreSQL database dump complete
--

