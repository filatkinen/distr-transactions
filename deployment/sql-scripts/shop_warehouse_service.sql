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

ALTER TABLE ONLY public.invoice_items DROP CONSTRAINT invoice_items_invoice_invoice_id_fk;
DROP INDEX public.items_item_id_uindex;
ALTER TABLE ONLY public.invoice DROP CONSTRAINT invoice_pk;
ALTER TABLE ONLY public.invoice_items DROP CONSTRAINT invoice_items_pk;
ALTER TABLE public.invoice ALTER COLUMN invoice_id DROP DEFAULT;
DROP TABLE public.items;
DROP TABLE public.invoice_items;
DROP SEQUENCE public.invoice_invoice_id_seq;
DROP TABLE public.invoice;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: invoice; Type: TABLE; Schema: public; Owner: shop_warehouse_service_user
--

CREATE TABLE public.invoice (
    invoice_id bigint NOT NULL,
    invoice_at timestamp with time zone NOT NULL,
    invoice_type text NOT NULL,
    invoice_requisite text NOT NULL
);


ALTER TABLE public.invoice OWNER TO shop_warehouse_service_user;

--
-- Name: invoice_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: shop_warehouse_service_user
--

CREATE SEQUENCE public.invoice_invoice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoice_invoice_id_seq OWNER TO shop_warehouse_service_user;

--
-- Name: invoice_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shop_warehouse_service_user
--

ALTER SEQUENCE public.invoice_invoice_id_seq OWNED BY public.invoice.invoice_id;


--
-- Name: invoice_items; Type: TABLE; Schema: public; Owner: shop_warehouse_service_user
--

CREATE TABLE public.invoice_items (
    invoice_id bigint NOT NULL,
    item_id bigint NOT NULL,
    item_quantity integer NOT NULL
);


ALTER TABLE public.invoice_items OWNER TO shop_warehouse_service_user;

--
-- Name: items; Type: TABLE; Schema: public; Owner: shop_warehouse_service_user
--

CREATE TABLE public.items (
    item_id bigint NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.items OWNER TO shop_warehouse_service_user;

--
-- Name: invoice invoice_id; Type: DEFAULT; Schema: public; Owner: shop_warehouse_service_user
--

ALTER TABLE ONLY public.invoice ALTER COLUMN invoice_id SET DEFAULT nextval('public.invoice_invoice_id_seq'::regclass);


--
-- Data for Name: invoice; Type: TABLE DATA; Schema: public; Owner: shop_warehouse_service_user
--



--
-- Data for Name: invoice_items; Type: TABLE DATA; Schema: public; Owner: shop_warehouse_service_user
--



--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: shop_warehouse_service_user
--



--
-- Name: invoice_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shop_warehouse_service_user
--

SELECT pg_catalog.setval('public.invoice_invoice_id_seq', 1, false);


--
-- Name: invoice_items invoice_items_pk; Type: CONSTRAINT; Schema: public; Owner: shop_warehouse_service_user
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT invoice_items_pk PRIMARY KEY (invoice_id, item_id);


--
-- Name: invoice invoice_pk; Type: CONSTRAINT; Schema: public; Owner: shop_warehouse_service_user
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_pk PRIMARY KEY (invoice_id);


--
-- Name: items_item_id_uindex; Type: INDEX; Schema: public; Owner: shop_warehouse_service_user
--

CREATE UNIQUE INDEX items_item_id_uindex ON public.items USING btree (item_id);


--
-- Name: invoice_items invoice_items_invoice_invoice_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: shop_warehouse_service_user
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT invoice_items_invoice_invoice_id_fk FOREIGN KEY (invoice_id) REFERENCES public.invoice(invoice_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

