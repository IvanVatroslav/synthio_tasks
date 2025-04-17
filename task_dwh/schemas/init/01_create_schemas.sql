CREATE SCHEMA IF NOT EXISTS oltp_3nf;
CREATE SCHEMA IF NOT EXISTS star_dwh;
CREATE SCHEMA IF NOT EXISTS snowflake_dwh;
SET search_path TO oltp_3nf, star_dwh, snowflake_dwh, public;
GRANT USAGE ON SCHEMA oltp_3nf TO admin;
GRANT USAGE ON SCHEMA star_dwh TO admin;
GRANT USAGE ON SCHEMA snowflake_dwh TO admin;