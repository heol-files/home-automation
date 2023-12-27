-- CREATE DATABASE nodered_db;

DROP SCHEMA IF EXISTS nodered_schema CASCADE;

-- Create nodered user if it does not exist
DO
$BODY$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_user WHERE usename = 'nodered_user') THEN
        CREATE USER nodered_user NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL 'infinity';
    END IF;
END
$BODY$;

-- SET user settings
ALTER USER nodered_user PASSWORD 'HO2021node!' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL 'infinity';
GRANT CONNECT ON DATABASE nodered_db TO nodered_user;

-- CREATE schema for nodered
CREATE SCHEMA nodered_schema AUTHORIZATION nodered_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA nodered_schema to nodered_user;

CREATE TABLE nodered_schema.rssi
(
    series TEXT NOT NULL,
    value TEXT NOT NULL,
    epochms bigint DEFAULT (extract(epoch from now()) * 1000)
);
ALTER TABLE nodered_schema.rssi OWNER TO nodered_user;

CREATE TABLE nodered_schema.retries
(
    series TEXT NOT NULL,
    value TEXT NOT NULL,
    epochms bigint DEFAULT (extract(epoch from now()) * 1000)
);
ALTER TABLE nodered_schema.retries OWNER TO nodered_user;

CREATE TABLE nodered_schema.temperature
(
    series TEXT NOT NULL,
    value TEXT NOT NULL,
    epochms bigint DEFAULT (extract(epoch from now()) * 1000)
);
ALTER TABLE nodered_schema.temperature OWNER TO nodered_user;

CREATE TABLE nodered_schema.light
(
    series TEXT NOT NULL,
    value TEXT NOT NULL,
    epochms bigint DEFAULT (extract(epoch from now()) * 1000)
);
ALTER TABLE nodered_schema.light OWNER TO nodered_user;

CREATE TABLE nodered_schema.battery
(
    series TEXT NOT NULL,
    value TEXT NOT NULL,
    epochms bigint DEFAULT (extract(epoch from now()) * 1000)
);
ALTER TABLE nodered_schema.battery OWNER TO nodered_user;

CREATE TABLE nodered_schema.moisture
(
    series TEXT NOT NULL,
    value TEXT NOT NULL,
    epochms bigint DEFAULT (extract(epoch from now()) * 1000)
);
ALTER TABLE nodered_schema.moisture OWNER TO nodered_user;

CREATE TABLE nodered_schema.conductivity
(
    series TEXT NOT NULL,
    value TEXT NOT NULL,
    epochms bigint DEFAULT (extract(epoch from now()) * 1000)
);
ALTER TABLE nodered_schema.conductivity OWNER TO nodered_user;


