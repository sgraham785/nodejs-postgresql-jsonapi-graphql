-- Note: this script CAN'T run all commands in a single run
-- This file contains all the commands to create the todos schema but these commands will run at different points in time

DROP ROLE IF EXISTS todos_database_owner;

CREATE ROLE todos_database_owner;

-- group roles

DROP ROLE IF EXISTS todos_owner;

CREATE ROLE todos_owner
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;

DROP ROLE IF EXISTS todos_appuser;

CREATE ROLE todos_appuser
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;

DROP ROLE IF EXISTS todos_readonly;

CREATE ROLE todos_readonly
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;


-- login roles

DROP ROLE IF EXISTS todos_appuser_user;

CREATE ROLE todos_appuser_user LOGIN
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
ALTER ROLE todos_appuser_user
  SET search_path = todos;
ALTER ROLE todos_appuser_user
  SET bytea_output = 'escape';
GRANT todos_appuser TO todos_appuser_user;

DROP ROLE IF EXISTS todos_owner_user;

CREATE ROLE todos_owner_user LOGIN
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
ALTER ROLE todos_owner_user
  SET search_path = todos;
GRANT todos_owner TO todos_owner_user;

DROP ROLE IF EXISTS todos_readonly_user;

CREATE ROLE todos_readonly_user LOGIN
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
ALTER ROLE todos_readonly_user
  SET search_path = todos;
GRANT todos_readonly TO todos_readonly_user;
