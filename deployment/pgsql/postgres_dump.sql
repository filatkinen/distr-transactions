CREATE DATABASE shop_order_service WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
CREATE DATABASE shop_order_workflow WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
CREATE DATABASE shop_payment_service WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
CREATE DATABASE shop_warehouse_service WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
CREATE DATABASE shop_notification_service WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';

CREATE USER shop_order_service_user WITH ENCRYPTED PASSWORD 'pass';
CREATE USER shop_order_workflow_user WITH ENCRYPTED PASSWORD 'pass';
CREATE USER shop_payment_service_user WITH ENCRYPTED PASSWORD 'pass';
CREATE USER shop_warehouse_service_user WITH ENCRYPTED PASSWORD 'pass';
CREATE USER shop_notification_service_user WITH ENCRYPTED PASSWORD 'pass';


ALTER DATABASE shop_order_service OWNER TO shop_order_service_user;
ALTER DATABASE shop_order_workflow OWNER TO shop_order_workflow_user;
ALTER DATABASE shop_payment_service OWNER TO shop_payment_service_user;
ALTER DATABASE shop_warehouse_service OWNER TO shop_warehouse_service_user;
ALTER DATABASE shop_notification_service OWNER TO shop_notification_service_user;

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

DROP DATABASE IF EXISTS shop_order_workflow;
--
-- Name: shop_order_workflow; Type: DATABASE; Schema: -; Owner: shop_order_workflow_user
--

CREATE DATABASE shop_order_workflow WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE shop_order_workflow OWNER TO shop_order_workflow_user;

\connect shop_order_workflow

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
-- Name: order_new; Type: TABLE; Schema: public; Owner: shop_order_workflow_user
--

CREATE TABLE public.order_new (
    order_id bigint NOT NULL,
    user_id integer NOT NULL,
    notification_type integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    approved_at timestamp with time zone,
    sum integer NOT NULL,
    status integer NOT NULL,
    order_items bytea NOT NULL
);


ALTER TABLE public.order_new OWNER TO shop_order_workflow_user;

--
-- Name: service_status; Type: TABLE; Schema: public; Owner: shop_order_workflow_user
--

CREATE TABLE public.service_status (
    status_id bigint NOT NULL,
    order_id bigint NOT NULL,
    service_id smallint NOT NULL,
    status_at timestamp with time zone NOT NULL,
    status integer NOT NULL,
    detail text
);


ALTER TABLE public.service_status OWNER TO shop_order_workflow_user;

--
-- Name: service_status_status_id_seq; Type: SEQUENCE; Schema: public; Owner: shop_order_workflow_user
--

CREATE SEQUENCE public.service_status_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.service_status_status_id_seq OWNER TO shop_order_workflow_user;

--
-- Name: service_status_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: shop_order_workflow_user
--

ALTER SEQUENCE public.service_status_status_id_seq OWNED BY public.service_status.status_id;


--
-- Name: service_status status_id; Type: DEFAULT; Schema: public; Owner: shop_order_workflow_user
--

ALTER TABLE ONLY public.service_status ALTER COLUMN status_id SET DEFAULT nextval('public.service_status_status_id_seq'::regclass);


--
-- Data for Name: order_new; Type: TABLE DATA; Schema: public; Owner: shop_order_workflow_user
--

COPY public.order_new (order_id, user_id, notification_type, created_at, approved_at, sum, status, order_items) FROM stdin;
1	1	1	2023-10-29 19:27:06.731507+03	2023-10-29 19:27:06.731507+03	23	1	\\x5b312c325d
15	2	1	2023-10-30 19:25:17.848936+03	2023-10-30 19:25:17.848938+03	10000	1	\\x5b7b226974656d5f6964223a31302c227175616e74697479223a322c227072696365223a34357d2c7b226974656d5f6964223a31352c227175616e74697479223a312c227072696365223a31307d5d
16	2	1	2023-10-30 19:32:46.669392+03	2023-10-30 19:32:46.669394+03	10000	1	\\x5b7b226974656d5f6964223a31302c227175616e74697479223a322c227072696365223a34357d2c7b226974656d5f6964223a31352c227175616e74697479223a312c227072696365223a31307d5d
17	2	1	2023-10-30 20:31:38.342146+03	2023-10-30 20:31:38.342149+03	10000	1	\\x5b7b226974656d5f6964223a31302c227175616e74697479223a322c227072696365223a34357d2c7b226974656d5f6964223a31352c227175616e74697479223a312c227072696365223a31307d5d
18	2	1	2023-10-30 20:41:53.508048+03	2023-10-30 20:41:53.50805+03	10000	1	\\x5b7b226974656d5f6964223a31302c227175616e74697479223a322c227072696365223a34357d2c7b226974656d5f6964223a31352c227175616e74697479223a312c227072696365223a31307d5d
19	2	1	2023-10-30 20:43:53.255476+03	2023-10-30 20:43:53.255479+03	10000	1	\\x5b7b226974656d5f6964223a31302c227175616e74697479223a322c227072696365223a34357d2c7b226974656d5f6964223a31352c227175616e74697479223a312c227072696365223a31307d5d
20	2	1	2023-10-30 20:49:41.402031+03	2023-10-30 20:49:41.402034+03	10000	1	\\x5b7b226974656d5f6964223a31302c227175616e74697479223a322c227072696365223a34357d2c7b226974656d5f6964223a31352c227175616e74697479223a312c227072696365223a31307d5d
21	2	1	2023-10-30 20:50:48.665711+03	2023-10-30 20:50:48.665714+03	10000	1	\\x5b7b226974656d5f6964223a31302c227175616e74697479223a322c227072696365223a34357d2c7b226974656d5f6964223a31352c227175616e74697479223a312c227072696365223a31307d5d
22	2	1	2023-10-30 21:00:35.228836+03	2023-10-30 21:00:35.228838+03	10000	1	\\x5b7b226974656d5f6964223a31302c227175616e74697479223a322c227072696365223a34357d2c7b226974656d5f6964223a31352c227175616e74697479223a312c227072696365223a31307d5d
23	2	1	2023-10-30 21:04:28.866439+03	2023-10-30 21:04:28.866441+03	10000	1	\\x5b7b226974656d5f6964223a31302c227175616e74697479223a322c227072696365223a34357d2c7b226974656d5f6964223a31352c227175616e74697479223a312c227072696365223a31307d5d
24	2	1	2023-10-30 21:09:38.658129+03	2023-10-30 21:09:38.658132+03	10000	1	\\x5b7b226974656d5f6964223a31302c227175616e74697479223a322c227072696365223a34357d2c7b226974656d5f6964223a31352c227175616e74697479223a312c227072696365223a31307d5d
\.


--
-- Data for Name: service_status; Type: TABLE DATA; Schema: public; Owner: shop_order_workflow_user
--

COPY public.service_status (status_id, order_id, service_id, status_at, status, detail) FROM stdin;
2	1	3	2023-10-29 19:28:52.300602+03	1	OK
1	1	2	2023-10-29 19:28:45.600849+03	2	error
3	16	1	2023-10-30 20:28:40.653+03	2	
4	15	1	2023-10-30 20:28:40.845+03	2	
5	15	2	2023-10-30 20:30:13.053+03	2	
6	16	2	2023-10-30 20:30:13.168+03	2	
7	17	1	2023-10-30 20:31:38.736+03	2	
8	17	2	2023-10-30 20:31:39.174+03	2	
9	17	3	2023-10-30 20:31:39.422+03	2	
10	17	3	2023-10-30 20:31:39.831+03	2	
11	17	3	2023-10-30 20:31:39.996+03	2	
12	17	3	2023-10-30 20:31:40.415+03	2	
13	17	3	2023-10-30 20:31:40.909+03	2	
14	17	3	2023-10-30 20:31:41.047+03	2	
15	17	3	2023-10-30 20:31:41.405+03	2	
16	17	3	2023-10-30 20:31:41.585+03	2	
17	17	3	2023-10-30 20:31:41.745+03	2	
18	17	3	2023-10-30 20:31:42.142+03	2	
19	17	3	2023-10-30 20:31:42.607+03	2	
20	17	3	2023-10-30 20:31:42.911+03	2	
21	17	3	2023-10-30 20:31:43.255+03	2	
22	17	3	2023-10-30 20:31:43.747+03	2	
23	17	3	2023-10-30 20:31:44.015+03	2	
24	17	3	2023-10-30 20:31:44.123+03	2	
25	17	3	2023-10-30 20:31:44.483+03	2	
26	17	3	2023-10-30 20:31:44.808+03	2	
27	17	3	2023-10-30 20:31:44.953+03	2	
28	17	3	2023-10-30 20:31:45.16+03	2	
29	17	3	2023-10-30 20:31:45.324+03	2	
30	17	3	2023-10-30 20:31:45.574+03	2	
31	17	3	2023-10-30 20:31:46.037+03	2	
32	17	3	2023-10-30 20:31:46.538+03	2	
33	17	3	2023-10-30 20:31:46.929+03	2	
34	17	3	2023-10-30 20:31:47.065+03	2	
35	17	3	2023-10-30 20:31:47.457+03	2	
36	17	3	2023-10-30 20:31:47.642+03	2	
37	17	3	2023-10-30 20:31:48.067+03	2	
38	17	3	2023-10-30 20:31:48.316+03	2	
39	17	3	2023-10-30 20:31:48.703+03	2	
40	17	3	2023-10-30 20:31:48.872+03	2	
41	17	3	2023-10-30 20:31:49.086+03	2	
42	17	3	2023-10-30 20:31:49.473+03	2	
43	17	3	2023-10-30 20:31:49.579+03	2	
44	17	3	2023-10-30 20:31:49.764+03	2	
45	17	3	2023-10-30 20:31:49.888+03	2	
46	17	3	2023-10-30 20:31:50.242+03	2	
47	17	3	2023-10-30 20:31:50.635+03	2	
48	17	3	2023-10-30 20:31:50.883+03	2	
49	17	3	2023-10-30 20:31:51.249+03	2	
50	17	3	2023-10-30 20:31:51.372+03	2	
51	17	3	2023-10-30 20:31:51.789+03	2	
52	17	3	2023-10-30 20:31:52.039+03	2	
53	17	3	2023-10-30 20:31:52.404+03	2	
54	17	3	2023-10-30 20:31:52.546+03	2	
55	17	3	2023-10-30 20:31:52.73+03	2	
56	17	3	2023-10-30 20:31:53.225+03	2	
57	17	3	2023-10-30 20:31:53.56+03	2	
58	17	3	2023-10-30 20:31:53.9+03	2	
59	17	3	2023-10-30 20:31:54.37+03	2	
60	17	3	2023-10-30 20:31:54.677+03	2	
61	17	3	2023-10-30 20:31:55.183+03	2	
62	17	3	2023-10-30 20:31:55.409+03	2	
63	17	3	2023-10-30 20:31:55.792+03	2	
64	17	3	2023-10-30 20:31:56.282+03	2	
65	17	3	2023-10-30 20:31:56.509+03	2	
66	17	3	2023-10-30 20:31:56.778+03	2	
67	17	3	2023-10-30 20:31:56.899+03	2	
68	17	3	2023-10-30 20:31:57.35+03	2	
69	17	3	2023-10-30 20:31:57.631+03	2	
70	17	3	2023-10-30 20:31:58.021+03	2	
71	17	3	2023-10-30 20:31:58.287+03	2	
72	17	3	2023-10-30 20:31:58.782+03	2	
73	17	3	2023-10-30 20:31:58.946+03	2	
74	17	3	2023-10-30 20:31:59.179+03	2	
75	17	3	2023-10-30 20:31:59.641+03	2	
76	17	3	2023-10-30 20:32:00.073+03	2	
77	17	3	2023-10-30 20:32:00.476+03	2	
78	17	3	2023-10-30 20:32:00.922+03	2	
79	17	3	2023-10-30 20:32:01.398+03	2	
80	17	3	2023-10-30 20:32:01.81+03	2	
81	17	3	2023-10-30 20:32:01.967+03	2	
82	17	3	2023-10-30 20:32:02.341+03	2	
83	17	3	2023-10-30 20:32:02.772+03	2	
84	17	3	2023-10-30 20:32:02.883+03	2	
85	17	3	2023-10-30 20:32:03.352+03	2	
86	17	3	2023-10-30 20:32:03.745+03	2	
87	17	3	2023-10-30 20:32:03.914+03	2	
88	17	3	2023-10-30 20:32:04.314+03	2	
89	17	3	2023-10-30 20:32:04.49+03	2	
90	17	3	2023-10-30 20:32:04.906+03	2	
91	17	3	2023-10-30 20:32:05.351+03	2	
92	17	3	2023-10-30 20:32:05.464+03	2	
93	17	3	2023-10-30 20:32:05.787+03	2	
94	17	3	2023-10-30 20:32:05.986+03	2	
95	17	3	2023-10-30 20:32:06.27+03	2	
96	17	3	2023-10-30 20:32:06.714+03	2	
97	17	3	2023-10-30 20:32:06.876+03	2	
98	17	3	2023-10-30 20:35:26.499+03	2	
99	17	3	2023-10-30 20:35:26.627+03	2	
100	17	3	2023-10-30 20:35:26.802+03	2	
101	17	3	2023-10-30 20:35:27.189+03	2	
102	17	3	2023-10-30 20:35:27.624+03	2	
103	17	3	2023-10-30 20:35:27.917+03	2	
104	17	3	2023-10-30 20:35:28.302+03	2	
105	17	3	2023-10-30 20:35:28.655+03	2	
106	17	3	2023-10-30 20:35:28.911+03	2	
107	17	3	2023-10-30 20:35:29.364+03	2	
108	17	3	2023-10-30 20:35:29.848+03	2	
109	17	3	2023-10-30 20:35:30.068+03	2	
110	17	3	2023-10-30 20:35:30.179+03	2	
111	17	3	2023-10-30 20:35:30.43+03	2	
112	17	3	2023-10-30 20:35:30.65+03	2	
113	17	3	2023-10-30 20:35:30.822+03	2	
114	17	3	2023-10-30 20:35:31.195+03	2	
115	17	3	2023-10-30 20:35:31.622+03	2	
116	17	3	2023-10-30 20:35:31.929+03	2	
117	17	3	2023-10-30 20:35:32.155+03	2	
118	17	3	2023-10-30 20:35:32.645+03	2	
119	17	3	2023-10-30 20:35:32.86+03	2	
120	17	3	2023-10-30 20:35:33.238+03	2	
121	17	3	2023-10-30 20:35:33.701+03	2	
122	17	3	2023-10-30 20:35:34.029+03	2	
123	17	3	2023-10-30 20:35:34.133+03	2	
124	17	3	2023-10-30 20:35:34.541+03	2	
125	17	3	2023-10-30 20:35:34.866+03	2	
126	17	3	2023-10-30 20:35:35.127+03	2	
127	17	3	2023-10-30 20:35:35.35+03	2	
128	17	3	2023-10-30 20:35:35.686+03	2	
129	17	3	2023-10-30 20:35:35.939+03	2	
130	17	3	2023-10-30 20:35:36.052+03	2	
131	17	3	2023-10-30 20:35:36.482+03	2	
132	17	3	2023-10-30 20:35:36.811+03	2	
133	17	3	2023-10-30 20:35:37.295+03	2	
134	17	3	2023-10-30 20:35:37.399+03	2	
135	17	3	2023-10-30 20:35:37.542+03	2	
136	17	3	2023-10-30 20:35:37.783+03	2	
137	17	3	2023-10-30 20:35:38.111+03	2	
138	17	3	2023-10-30 20:35:38.319+03	2	
139	17	3	2023-10-30 20:35:38.789+03	2	
140	17	3	2023-10-30 20:35:39.237+03	2	
141	17	3	2023-10-30 20:35:39.477+03	2	
142	17	3	2023-10-30 20:35:39.676+03	2	
143	17	3	2023-10-30 20:35:39.783+03	2	
144	17	3	2023-10-30 20:35:40.264+03	2	
145	17	3	2023-10-30 20:35:40.405+03	2	
146	17	3	2023-10-30 20:35:40.598+03	2	
147	17	3	2023-10-30 20:35:41.047+03	2	
148	17	3	2023-10-30 20:35:41.476+03	2	
149	17	3	2023-10-30 20:35:41.877+03	2	
150	17	3	2023-10-30 20:35:42.109+03	2	
151	17	3	2023-10-30 20:35:42.46+03	2	
152	17	3	2023-10-30 20:35:42.947+03	2	
153	17	3	2023-10-30 20:35:43.269+03	2	
154	17	3	2023-10-30 20:35:43.556+03	2	
155	17	3	2023-10-30 20:35:43.764+03	2	
156	17	3	2023-10-30 20:35:44+03	2	
157	17	3	2023-10-30 20:35:44.213+03	2	
158	17	3	2023-10-30 20:35:44.343+03	2	
159	17	3	2023-10-30 20:35:44.592+03	2	
160	17	3	2023-10-30 20:35:45.08+03	2	
161	17	3	2023-10-30 20:35:45.58+03	2	
162	17	3	2023-10-30 20:35:45.832+03	2	
163	17	3	2023-10-30 20:35:46.216+03	2	
164	17	3	2023-10-30 20:35:46.492+03	2	
165	17	3	2023-10-30 20:35:46.983+03	2	
166	17	3	2023-10-30 20:35:47.297+03	2	
167	17	3	2023-10-30 20:35:47.41+03	2	
168	17	3	2023-10-30 20:35:47.527+03	2	
169	17	3	2023-10-30 20:35:47.826+03	2	
170	17	3	2023-10-30 20:35:48.207+03	2	
171	17	3	2023-10-30 20:35:48.367+03	2	
172	17	3	2023-10-30 20:35:48.52+03	2	
173	17	3	2023-10-30 20:35:48.723+03	2	
174	17	3	2023-10-30 20:35:49.224+03	2	
175	17	3	2023-10-30 20:35:49.632+03	2	
176	17	3	2023-10-30 20:35:49.768+03	2	
177	17	3	2023-10-30 20:35:50.214+03	2	
178	17	3	2023-10-30 20:35:50.395+03	2	
179	17	3	2023-10-30 20:35:50.85+03	2	
180	17	3	2023-10-30 20:35:51.194+03	2	
181	17	3	2023-10-30 20:35:51.515+03	2	
182	17	3	2023-10-30 20:35:51.883+03	2	
183	17	3	2023-10-30 20:35:52.094+03	2	
184	17	3	2023-10-30 20:35:52.213+03	2	
185	17	3	2023-10-30 20:35:52.544+03	2	
186	17	3	2023-10-30 20:35:52.934+03	2	
187	17	3	2023-10-30 20:35:53.239+03	2	
188	17	3	2023-10-30 20:35:53.491+03	2	
189	17	3	2023-10-30 20:35:53.874+03	2	
190	17	3	2023-10-30 20:35:54.347+03	2	
191	17	3	2023-10-30 20:35:54.644+03	2	
192	17	3	2023-10-30 20:35:54.824+03	2	
193	17	3	2023-10-30 20:35:55.21+03	2	
194	17	3	2023-10-30 20:35:55.494+03	2	
195	17	3	2023-10-30 20:35:55.704+03	2	
196	17	3	2023-10-30 20:35:55.809+03	2	
197	17	3	2023-10-30 20:35:56.249+03	2	
198	17	3	2023-10-30 20:35:56.709+03	2	
199	17	3	2023-10-30 20:35:56.991+03	2	
200	17	3	2023-10-30 20:35:57.153+03	2	
201	17	3	2023-10-30 20:35:57.581+03	2	
202	17	3	2023-10-30 20:35:57.689+03	2	
203	17	3	2023-10-30 20:35:58.044+03	2	
204	17	3	2023-10-30 20:35:58.356+03	2	
205	17	3	2023-10-30 20:35:58.672+03	2	
206	17	3	2023-10-30 20:35:59.06+03	2	
207	17	3	2023-10-30 20:35:59.276+03	2	
208	17	3	2023-10-30 20:35:59.709+03	2	
209	17	3	2023-10-30 20:36:00.085+03	2	
210	17	3	2023-10-30 20:36:00.206+03	2	
211	17	3	2023-10-30 20:36:00.69+03	2	
212	17	3	2023-10-30 20:36:00.793+03	2	
213	17	3	2023-10-30 20:41:32.621+03	2	
214	18	1	2023-10-30 20:41:53.797+03	2	
215	18	2	2023-10-30 20:41:53.905+03	2	
216	18	3	2023-10-30 20:41:54.185+03	2	
217	19	1	2023-10-30 20:44:03.755+03	2	
218	19	2	2023-10-30 20:44:04.064+03	2	
219	19	3	2023-10-30 20:44:04.296+03	2	
220	20	1	2023-10-30 20:49:41.575+03	2	
221	20	2	2023-10-30 20:49:42.021+03	2	
222	20	3	2023-10-30 20:49:42.294+03	2	
223	21	1	2023-10-30 20:50:49.044+03	2	
224	21	2	2023-10-30 20:50:49.363+03	2	
225	21	3	2023-10-30 20:50:49.864+03	2	
226	22	1	2023-10-30 21:00:35.516+03	2	
227	22	2	2023-10-30 21:00:35.974+03	2	
228	22	3	2023-10-30 21:00:36.364+03	3	Error notification
229	23	1	2023-10-30 21:04:28.985+03	2	
230	23	2	2023-10-30 21:04:29.333+03	3	Error payment
231	23	1	2023-10-30 21:04:29.56+03	2	Reserv canceled
232	23	2	2023-10-30 21:04:29.985+03	3	Error payment
233	23	1	2023-10-30 21:04:30.258+03	2	Reserv canceled
234	23	2	2023-10-30 21:04:30.56+03	3	Error payment
235	23	1	2023-10-30 21:04:30.728+03	2	Reserv canceled
236	23	2	2023-10-30 21:04:30.918+03	3	Error payment
237	23	1	2023-10-30 21:04:31.375+03	2	Reserv canceled
238	23	2	2023-10-30 21:04:31.54+03	3	Error payment
239	23	1	2023-10-30 21:04:31.836+03	2	Reserv canceled
240	23	2	2023-10-30 21:04:32.134+03	3	Error payment
241	23	1	2023-10-30 21:04:32.452+03	2	Reserv canceled
242	23	2	2023-10-30 21:04:32.952+03	3	Error payment
243	23	1	2023-10-30 21:04:33.216+03	2	Reserv canceled
244	23	2	2023-10-30 21:04:33.45+03	3	Error payment
245	23	1	2023-10-30 21:04:33.659+03	2	Reserv canceled
246	23	2	2023-10-30 21:04:33.87+03	3	Error payment
247	23	1	2023-10-30 21:04:34.072+03	2	Reserv canceled
248	23	2	2023-10-30 21:04:34.19+03	3	Error payment
249	23	1	2023-10-30 21:04:34.517+03	2	Reserv canceled
250	23	2	2023-10-30 21:04:34.908+03	3	Error payment
251	23	1	2023-10-30 21:04:35.145+03	2	Reserv canceled
252	23	2	2023-10-30 21:04:35.518+03	3	Error payment
253	23	1	2023-10-30 21:04:35.664+03	2	Reserv canceled
254	23	2	2023-10-30 21:04:35.882+03	3	Error payment
255	23	1	2023-10-30 21:04:36.127+03	2	Reserv canceled
256	23	2	2023-10-30 21:04:36.421+03	3	Error payment
257	23	1	2023-10-30 21:04:36.638+03	2	Reserv canceled
258	23	2	2023-10-30 21:04:37.13+03	3	Error payment
259	23	1	2023-10-30 21:04:37.517+03	2	Reserv canceled
260	23	2	2023-10-30 21:04:37.804+03	3	Error payment
261	23	1	2023-10-30 21:04:37.92+03	2	Reserv canceled
262	23	2	2023-10-30 21:04:38.036+03	3	Error payment
263	23	1	2023-10-30 21:04:38.152+03	2	Reserv canceled
264	23	2	2023-10-30 21:04:38.58+03	3	Error payment
265	23	1	2023-10-30 21:04:38.829+03	2	Reserv canceled
266	23	2	2023-10-30 21:04:39.161+03	3	Error payment
267	23	1	2023-10-30 21:04:39.525+03	2	Reserv canceled
268	23	2	2023-10-30 21:04:39.965+03	3	Error payment
269	23	1	2023-10-30 21:04:40.141+03	2	Reserv canceled
270	23	2	2023-10-30 21:04:40.421+03	3	Error payment
271	23	1	2023-10-30 21:04:40.614+03	2	Reserv canceled
272	23	2	2023-10-30 21:04:40.846+03	3	Error payment
273	23	1	2023-10-30 21:04:40.99+03	2	Reserv canceled
274	23	2	2023-10-30 21:04:41.298+03	3	Error payment
275	23	1	2023-10-30 21:04:41.588+03	2	Reserv canceled
276	23	2	2023-10-30 21:04:41.855+03	3	Error payment
277	23	1	2023-10-30 21:04:42.161+03	2	Reserv canceled
278	23	2	2023-10-30 21:04:42.339+03	3	Error payment
279	23	1	2023-10-30 21:04:42.677+03	2	Reserv canceled
280	23	2	2023-10-30 21:04:42.846+03	3	Error payment
281	23	1	2023-10-30 21:04:42.97+03	2	Reserv canceled
282	23	2	2023-10-30 21:04:43.457+03	3	Error payment
283	23	1	2023-10-30 21:04:43.722+03	2	Reserv canceled
284	23	2	2023-10-30 21:04:43.829+03	3	Error payment
285	23	1	2023-10-30 21:04:44.252+03	2	Reserv canceled
286	23	2	2023-10-30 21:04:44.367+03	3	Error payment
287	23	1	2023-10-30 21:04:44.786+03	2	Reserv canceled
288	23	2	2023-10-30 21:04:45.123+03	3	Error payment
289	23	1	2023-10-30 21:04:45.28+03	2	Reserv canceled
290	23	2	2023-10-30 21:04:45.422+03	3	Error payment
291	23	1	2023-10-30 21:04:45.876+03	2	Reserv canceled
292	23	2	2023-10-30 21:04:46.186+03	3	Error payment
293	23	1	2023-10-30 21:04:46.412+03	2	Reserv canceled
294	23	2	2023-10-30 21:04:46.549+03	3	Error payment
295	23	1	2023-10-30 21:04:47.003+03	2	Reserv canceled
296	23	2	2023-10-30 21:04:47.471+03	3	Error payment
297	23	1	2023-10-30 21:04:47.624+03	2	Reserv canceled
298	23	2	2023-10-30 21:04:48.046+03	3	Error payment
299	23	1	2023-10-30 21:04:48.226+03	2	Reserv canceled
300	23	2	2023-10-30 21:04:48.614+03	3	Error payment
301	23	1	2023-10-30 21:04:49.077+03	2	Reserv canceled
302	23	2	2023-10-30 21:04:49.399+03	3	Error payment
303	23	1	2023-10-30 21:04:49.723+03	2	Reserv canceled
304	23	2	2023-10-30 21:04:50.001+03	3	Error payment
305	23	1	2023-10-30 21:04:50.401+03	2	Reserv canceled
306	23	2	2023-10-30 21:04:50.63+03	3	Error payment
307	23	1	2023-10-30 21:04:51.038+03	2	Reserv canceled
308	23	2	2023-10-30 21:04:51.289+03	3	Error payment
309	23	1	2023-10-30 21:04:51.623+03	2	Reserv canceled
310	23	2	2023-10-30 21:04:51.849+03	3	Error payment
311	23	1	2023-10-30 21:04:52.085+03	2	Reserv canceled
312	23	2	2023-10-30 21:04:52.188+03	3	Error payment
313	23	1	2023-10-30 21:04:52.642+03	2	Reserv canceled
314	23	2	2023-10-30 21:04:52.755+03	3	Error payment
315	23	1	2023-10-30 21:04:52.991+03	2	Reserv canceled
316	23	2	2023-10-30 21:04:53.106+03	3	Error payment
317	23	1	2023-10-30 21:04:53.318+03	2	Reserv canceled
318	23	2	2023-10-30 21:04:53.44+03	3	Error payment
319	23	1	2023-10-30 21:04:53.642+03	2	Reserv canceled
320	23	2	2023-10-30 21:04:54.052+03	3	Error payment
321	23	1	2023-10-30 21:04:54.337+03	2	Reserv canceled
322	23	2	2023-10-30 21:04:54.718+03	3	Error payment
323	23	1	2023-10-30 21:04:54.911+03	2	Reserv canceled
324	23	2	2023-10-30 21:04:55.332+03	3	Error payment
325	23	1	2023-10-30 21:04:55.728+03	2	Reserv canceled
326	23	2	2023-10-30 21:04:55.856+03	3	Error payment
327	23	1	2023-10-30 21:04:56.236+03	2	Reserv canceled
328	23	2	2023-10-30 21:04:56.68+03	3	Error payment
329	23	1	2023-10-30 21:04:57.007+03	2	Reserv canceled
330	23	2	2023-10-30 21:04:57.172+03	3	Error payment
331	23	1	2023-10-30 21:04:57.67+03	2	Reserv canceled
332	23	2	2023-10-30 21:04:57.832+03	3	Error payment
333	23	1	2023-10-30 21:04:58.026+03	2	Reserv canceled
334	23	2	2023-10-30 21:04:58.52+03	3	Error payment
335	23	1	2023-10-30 21:04:58.873+03	2	Reserv canceled
336	23	2	2023-10-30 21:04:59.208+03	3	Error payment
337	23	1	2023-10-30 21:04:59.607+03	2	Reserv canceled
338	23	2	2023-10-30 21:04:59.896+03	3	Error payment
339	23	1	2023-10-30 21:05:00.388+03	2	Reserv canceled
340	23	2	2023-10-30 21:05:00.658+03	3	Error payment
341	23	1	2023-10-30 21:05:01.162+03	2	Reserv canceled
342	23	2	2023-10-30 21:05:01.334+03	3	Error payment
343	23	1	2023-10-30 21:05:01.469+03	2	Reserv canceled
344	23	2	2023-10-30 21:05:01.931+03	3	Error payment
345	23	1	2023-10-30 21:05:02.303+03	2	Reserv canceled
346	23	2	2023-10-30 21:05:02.467+03	3	Error payment
347	23	1	2023-10-30 21:05:02.876+03	2	Reserv canceled
348	23	2	2023-10-30 21:05:03.183+03	3	Error payment
349	23	1	2023-10-30 21:05:03.496+03	2	Reserv canceled
350	23	2	2023-10-30 21:05:03.816+03	3	Error payment
351	23	1	2023-10-30 21:05:03.978+03	2	Reserv canceled
352	23	2	2023-10-30 21:05:04.255+03	3	Error payment
353	23	1	2023-10-30 21:05:04.444+03	2	Reserv canceled
354	23	2	2023-10-30 21:05:04.633+03	3	Error payment
355	23	1	2023-10-30 21:05:05.012+03	2	Reserv canceled
356	23	2	2023-10-30 21:05:05.483+03	3	Error payment
357	23	1	2023-10-30 21:05:05.856+03	2	Reserv canceled
358	23	2	2023-10-30 21:05:06.076+03	3	Error payment
359	23	1	2023-10-30 21:05:06.266+03	2	Reserv canceled
360	23	2	2023-10-30 21:05:06.658+03	3	Error payment
361	23	1	2023-10-30 21:05:07.127+03	2	Reserv canceled
362	23	2	2023-10-30 21:05:07.574+03	3	Error payment
363	23	1	2023-10-30 21:05:07.766+03	2	Reserv canceled
364	23	2	2023-10-30 21:05:08.21+03	3	Error payment
365	23	1	2023-10-30 21:05:08.71+03	2	Reserv canceled
366	23	2	2023-10-30 21:05:08.891+03	3	Error payment
367	23	1	2023-10-30 21:05:09.304+03	2	Reserv canceled
368	23	2	2023-10-30 21:05:09.732+03	3	Error payment
369	23	1	2023-10-30 21:05:10.082+03	2	Reserv canceled
370	23	2	2023-10-30 21:05:10.418+03	3	Error payment
371	23	1	2023-10-30 21:05:10.705+03	2	Reserv canceled
372	23	2	2023-10-30 21:05:11.005+03	3	Error payment
373	23	1	2023-10-30 21:05:11.107+03	2	Reserv canceled
374	23	2	2023-10-30 21:05:11.591+03	3	Error payment
375	23	1	2023-10-30 21:05:12.032+03	2	Reserv canceled
376	23	2	2023-10-30 21:05:12.155+03	3	Error payment
377	23	1	2023-10-30 21:05:12.513+03	2	Reserv canceled
378	23	2	2023-10-30 21:05:12.974+03	3	Error payment
379	23	1	2023-10-30 21:05:13.332+03	2	Reserv canceled
380	23	2	2023-10-30 21:05:13.535+03	3	Error payment
381	23	1	2023-10-30 21:05:14.008+03	2	Reserv canceled
382	23	2	2023-10-30 21:05:14.498+03	3	Error payment
383	23	1	2023-10-30 21:05:14.698+03	2	Reserv canceled
384	23	2	2023-10-30 21:05:15.041+03	3	Error payment
385	23	1	2023-10-30 21:05:15.357+03	2	Reserv canceled
386	23	2	2023-10-30 21:05:15.661+03	3	Error payment
387	23	1	2023-10-30 21:05:15.972+03	2	Reserv canceled
388	23	2	2023-10-30 21:05:16.174+03	3	Error payment
389	23	1	2023-10-30 21:05:16.558+03	2	Reserv canceled
390	23	2	2023-10-30 21:05:16.794+03	3	Error payment
391	23	1	2023-10-30 21:05:16.943+03	2	Reserv canceled
392	23	2	2023-10-30 21:05:17.05+03	3	Error payment
393	23	1	2023-10-30 21:05:17.205+03	2	Reserv canceled
394	23	2	2023-10-30 21:05:17.349+03	3	Error payment
395	23	1	2023-10-30 21:05:17.484+03	2	Reserv canceled
396	23	2	2023-10-30 21:05:17.902+03	3	Error payment
397	23	1	2023-10-30 21:05:18.056+03	2	Reserv canceled
398	23	2	2023-10-30 21:05:18.187+03	3	Error payment
399	23	1	2023-10-30 21:05:18.503+03	2	Reserv canceled
400	23	2	2023-10-30 21:05:18.897+03	3	Error payment
401	23	1	2023-10-30 21:05:19.177+03	2	Reserv canceled
402	23	2	2023-10-30 21:05:19.626+03	3	Error payment
403	23	1	2023-10-30 21:05:19.979+03	2	Reserv canceled
404	23	2	2023-10-30 21:05:20.188+03	3	Error payment
405	23	1	2023-10-30 21:05:20.522+03	2	Reserv canceled
406	23	2	2023-10-30 21:05:20.926+03	3	Error payment
407	23	1	2023-10-30 21:05:21.233+03	2	Reserv canceled
408	23	2	2023-10-30 21:05:21.591+03	3	Error payment
409	23	1	2023-10-30 21:05:21.745+03	2	Reserv canceled
410	23	2	2023-10-30 21:05:22.18+03	3	Error payment
411	23	1	2023-10-30 21:05:22.315+03	2	Reserv canceled
412	23	2	2023-10-30 21:05:22.76+03	3	Error payment
413	24	1	2023-10-30 21:09:38.964+03	2	
414	24	2	2023-10-30 21:09:39.097+03	3	Error payment
\.


--
-- Name: service_status_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: shop_order_workflow_user
--

SELECT pg_catalog.setval('public.service_status_status_id_seq', 414, true);


--
-- Name: order_new order_new_pk; Type: CONSTRAINT; Schema: public; Owner: shop_order_workflow_user
--

ALTER TABLE ONLY public.order_new
    ADD CONSTRAINT order_new_pk PRIMARY KEY (order_id);


--
-- Name: service_status service_status_pk; Type: CONSTRAINT; Schema: public; Owner: shop_order_workflow_user
--

ALTER TABLE ONLY public.service_status
    ADD CONSTRAINT service_status_pk PRIMARY KEY (status_id);


--
-- Name: service_status_order_id_service_id_index; Type: INDEX; Schema: public; Owner: shop_order_workflow_user
--

CREATE INDEX service_status_order_id_service_id_index ON public.service_status USING btree (order_id, service_id);


--
-- Name: service_status service_status_order_new_order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: shop_order_workflow_user
--

ALTER TABLE ONLY public.service_status
    ADD CONSTRAINT service_status_order_new_order_id_fk FOREIGN KEY (order_id) REFERENCES public.order_new(order_id);


--
-- PostgreSQL database dump complete
--

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

DROP DATABASE IF EXISTS shop_warehouse_service;
--
-- Name: shop_warehouse_service; Type: DATABASE; Schema: -; Owner: shop_warehouse_service_user
--

CREATE DATABASE shop_warehouse_service WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE shop_warehouse_service OWNER TO shop_warehouse_service_user;

\connect shop_warehouse_service

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

COPY public.invoice (invoice_id, invoice_at, invoice_type, invoice_requisite) FROM stdin;
\.


--
-- Data for Name: invoice_items; Type: TABLE DATA; Schema: public; Owner: shop_warehouse_service_user
--

COPY public.invoice_items (invoice_id, item_id, item_quantity) FROM stdin;
\.


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: shop_warehouse_service_user
--

COPY public.items (item_id, quantity) FROM stdin;
\.


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

