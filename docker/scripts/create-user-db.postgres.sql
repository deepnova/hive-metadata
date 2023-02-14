SELECT 'CREATE DATABASE hms_db'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'hms_db')\gexec

DO
$do$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE  rolname = 'deep_hms') THEN
        CREATE role dlink_hms LOGIN PASSWORD 'deep_hms';
    END IF;
END
$do$;

ALTER DATABASE hms_db OWNER TO dlink_hms;
