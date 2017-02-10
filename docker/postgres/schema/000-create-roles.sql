-- Note: this script CAN'T run all commands in a single run
-- This file contains all the commands to create the portal schema but these commands will run at different points in time

DROP ROLE IF EXISTS patient_portal_owner;

CREATE ROLE patient_portal_owner;

-- group roles

DROP ROLE IF EXISTS navigation_appuser;

CREATE ROLE navigation_appuser
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;

DROP ROLE IF EXISTS navigation_owner;

CREATE ROLE navigation_owner
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;

DROP ROLE IF EXISTS navigation_readonly;

CREATE ROLE navigation_readonly
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;


-- login roles

DROP ROLE IF EXISTS navigation_appuser_user;

CREATE ROLE navigation_appuser_user LOGIN
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
ALTER ROLE navigation_appuser_user
  SET search_path = navigation;
ALTER ROLE navigation_appuser_user
  SET bytea_output = 'escape';
GRANT navigation_appuser TO navigation_appuser_user;

DROP ROLE IF EXISTS navigation_owner_user;

CREATE ROLE navigation_owner_user LOGIN
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
ALTER ROLE navigation_owner_user
  SET search_path = navigation;
GRANT navigation_owner TO navigation_owner_user;

DROP ROLE IF EXISTS navigation_readonly_user;

CREATE ROLE navigation_readonly_user LOGIN
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
ALTER ROLE navigation_readonly_user
  SET search_path = navigation;
GRANT navigation_readonly TO navigation_readonly_user;
