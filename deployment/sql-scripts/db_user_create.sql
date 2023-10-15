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

