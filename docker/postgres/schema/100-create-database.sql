-- Note: this script CAN'T run all commands in a single run
-- This file contains all the commands to create the portal schema but these commands will run at different points in time
-- database
-- note: DROP command may not work in a script, must be run on its own

DROP DATABASE IF EXISTS patient_portal;

CREATE DATABASE patient_portal
  WITH OWNER = patient_portal_owner
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
     -- for Linux
       -- LC_COLLATE = 'en_US.UTF-8'
       -- LC_CTYPE = 'en_US.UTF-8'
     -- for Windows
       -- LC_COLLATE = 'English_United States.1252'
       -- LC_CTYPE = 'English_United States.1252'
       CONNECTION LIMIT = -1;

-- schema
-- note: you must be connected to the portal_menu database to run the schema creation
\c patient_portal;
DROP SCHEMA IF EXISTS navigation;

CREATE SCHEMA navigation
  AUTHORIZATION navigation_owner;

GRANT ALL ON SCHEMA navigation TO navigation_owner;
GRANT USAGE ON SCHEMA navigation TO navigation_appuser;
GRANT USAGE ON SCHEMA navigation TO navigation_readonly;
