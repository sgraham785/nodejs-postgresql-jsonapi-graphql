-- table creation
-- assumes the schema portal already does exist + all necessary groups/users are already created

-- drop all tables (order is important!)
\c patient_portal;
SET search_path = navigation;

-- object: navigation.menu_options | type: TABLE --
-- DROP TABLE navigation.menu_options;
CREATE TABLE navigation.menu_options(
  menu_option_id bigserial NOT NULL,
  menu_title varchar NOT NULL,
  route_uri varchar NOT NULL,
  package_url varchar NOT NULL,
  updated_at timestamp NOT NULL DEFAULT now(),
  created_at timestamp NOT NULL DEFAULT now(),
  CONSTRAINT menu_options_menu_option_id_pkey PRIMARY KEY (menu_option_id)

);
-- ddl-end --
ALTER TABLE navigation.menu_options OWNER TO navigation_owner;
-- ddl-end --

-- object: navigation.client_industry_menu_options | type: TABLE --
-- DROP TABLE navigation.client_industry_menu_options;
CREATE TABLE navigation.client_industry_menu_options(
  client_industry_menu_option_id bigserial NOT NULL,
  client_id bigint NOT NULL,
  industry_menu_option_id bigint NOT NULL,
  updated_at timestamp NOT NULL DEFAULT now(),
  created_at timestamp NOT NULL DEFAULT now(),
  CONSTRAINT client_industry_menu_option_id_pkey PRIMARY KEY (client_industry_menu_option_id)

);
-- ddl-end --
-- object: client_menu_options_client_id_index | type: INDEX --
-- DROP INDEX navigation.client_menu_options_client_id_index;
CREATE INDEX client_menu_options_client_id_index ON navigation.client_industry_menu_options
USING btree
(
  client_id ASC NULLS LAST
);
-- ddl-end --

-- object: client_industry_menu_options_industry_menu_option_id_index | type: INDEX --
-- DROP INDEX navigation.client_industry_menu_options_industry_menu_option_id_index;
CREATE INDEX client_industry_menu_options_industry_menu_option_id_index ON navigation.client_industry_menu_options
USING btree
(
  industry_menu_option_id ASC NULLS LAST
);
-- ddl-end --


-- object: navigation.consumer_menu_options | type: TABLE --
-- DROP TABLE navigation.consumer_menu_options;
CREATE TABLE navigation.consumer_menu_options(
  consumer_menu_option_id serial NOT NULL,
  consumer_id bigint NOT NULL,
  client_industry_menu_option_id bigint NOT NULL,
  updated_at timestamp NOT NULL DEFAULT now(),
  created_at timestamp NOT NULL DEFAULT now(),
  CONSTRAINT consumer_menu_options_consumer_menu_option_id_pkey PRIMARY KEY (consumer_menu_option_id)

);
-- ddl-end --
-- object: consumer_menu_options_consumer_id_index | type: INDEX --
-- DROP INDEX navigation.consumer_menu_options_consumer_id_index;
CREATE INDEX consumer_menu_options_consumer_id_index ON navigation.consumer_menu_options
USING btree
(
  consumer_id ASC NULLS LAST
);
-- ddl-end --

-- object: consumer_menu_options_client_industry_menu_option_id_index | type: INDEX --
-- DROP INDEX navigation.consumer_menu_options_client_industry_menu_option_id_index;
CREATE INDEX consumer_menu_options_client_industry_menu_option_id_index ON navigation.consumer_menu_options
USING btree
(
  client_industry_menu_option_id ASC NULLS LAST
);
-- ddl-end --


-- object: navigation.industries | type: TABLE --
-- DROP TABLE navigation.industries;
CREATE TABLE navigation.industries(
  industry_id bigserial NOT NULL,
  industry_name varchar NOT NULL,
  updated_at timestamp NOT NULL DEFAULT now(),
  created_at timestamp NOT NULL DEFAULT now(),
  CONSTRAINT industries_industry_id_pkey PRIMARY KEY (industry_id)

);
-- ddl-end --
-- object: navigation.industry_menu_options | type: TABLE --
-- DROP TABLE navigation.industry_menu_options;
CREATE TABLE navigation.industry_menu_options(
  industry_menu_option_id bigserial NOT NULL,
  industry_id bigint NOT NULL,
  menu_option_id bigint NOT NULL,
  display_order integer NOT NULL,
  updated_at timestamp NOT NULL DEFAULT now(),
  created_at timestamp NOT NULL DEFAULT now(),
  CONSTRAINT industry_menu_options_industry_menu_option_id_pkey PRIMARY KEY (industry_menu_option_id)

);
-- ddl-end --
-- object: industry_menu_options_industry_id_index | type: INDEX --
-- DROP INDEX navigation.industry_menu_options_industry_id_index;
CREATE INDEX industry_menu_options_industry_id_index ON navigation.industry_menu_options
USING btree
(
  industry_id ASC NULLS LAST
);
-- ddl-end --

-- object: industry_menu_options_menu_option_id_index | type: INDEX --
-- DROP INDEX navigation.industry_menu_options_menu_option_id_index;
CREATE INDEX industry_menu_options_menu_option_id_index ON navigation.industry_menu_options
USING btree
(
  menu_option_id ASC NULLS LAST
);
-- ddl-end --


-- object: client_industry_menu_options_industry_menu_option_id_fkey | type: CONSTRAINT --
-- ALTER TABLE navigation.client_industry_menu_options DROP CONSTRAINT client_industry_menu_options_industry_menu_option_id_fkey;
ALTER TABLE navigation.client_industry_menu_options ADD CONSTRAINT client_industry_menu_options_industry_menu_option_id_fkey FOREIGN KEY (industry_menu_option_id)
REFERENCES navigation.industry_menu_options (industry_menu_option_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: consumer_menu_options_client_industry_menu_option_id_fkey | type: CONSTRAINT --
-- ALTER TABLE navigation.consumer_menu_options DROP CONSTRAINT consumer_menu_options_client_industry_menu_option_id_fkey;
ALTER TABLE navigation.consumer_menu_options ADD CONSTRAINT consumer_menu_options_client_industry_menu_option_id_fkey FOREIGN KEY (client_industry_menu_option_id)
REFERENCES navigation.client_industry_menu_options (client_industry_menu_option_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: industry_menu_options_industry_id_fkey | type: CONSTRAINT --
-- ALTER TABLE navigation.industry_menu_options DROP CONSTRAINT industry_menu_options_industry_id_fkey;
ALTER TABLE navigation.industry_menu_options ADD CONSTRAINT industry_menu_options_industry_id_fkey FOREIGN KEY (industry_id)
REFERENCES navigation.industries (industry_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


-- object: industry_menu_options_menu_option_id_fkey | type: CONSTRAINT --
-- ALTER TABLE navigation.industry_menu_options DROP CONSTRAINT industry_menu_options_menu_option_id_fkey;
ALTER TABLE navigation.industry_menu_options ADD CONSTRAINT industry_menu_options_menu_option_id_fkey FOREIGN KEY (menu_option_id)
REFERENCES navigation.menu_options (menu_option_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

