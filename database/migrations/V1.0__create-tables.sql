-- table creation
-- assumes the schema portal already does exist + all necessary groups/users are already created

-- drop all tables (order is important!)
-- \c todos;
SET search_path = todos;

-- object: todos.todo_items | type: TABLE --
-- DROP TABLE todos.todo_items;
CREATE TABLE users(
  user_id bigserial NOT NULL,
  first_name varchar NOT NULL,
  last_name varchar NOT NULL,
  email varchar NOT NULL,
  password varchar NOT NULL,
  code varchar NOT NULL,
  verified varchar NOT NULL,
  updated_at timestamp NOT NULL DEFAULT now(),
  created_at timestamp NOT NULL DEFAULT now(),
  CONSTRAINT users_id_pkey PRIMARY KEY (user_id)

);
-- ddl-end --
ALTER TABLE users OWNER TO todos_owner;
-- ddl-end --

-- object: client_menu_options_client_id_index | type: INDEX --
-- DROP INDEX navigation.client_menu_options_client_id_index;
CREATE INDEX users_user_id_index ON todos.users
USING btree
(
  user_id ASC NULLS LAST
);
-- ddl-end --

-- object: todos.todo_items | type: TABLE --
-- DROP TABLE todos.todo_items;
CREATE TABLE todo_items(
  todo_id bigserial NOT NULL,
  user_id bigint NOT NULL,
  text varchar NOT NULL,
  complete boolean NOT NULL default 'false',
  updated_at timestamp NOT NULL DEFAULT now(),
  created_at timestamp NOT NULL DEFAULT now(),
  CONSTRAINT todo_items_todo_id_pkey PRIMARY KEY (todo_id)

);
-- ddl-end --

ALTER TABLE todo_items OWNER TO todos_owner;
-- ddl-end --

CREATE INDEX todo_items_todo_id_index ON todos.todo_items
USING btree
(
  todo_id ASC NULLS LAST
);
-- ddl-end --


ALTER TABLE todos.todo_items ADD CONSTRAINT todos_user_id_fkey FOREIGN KEY (user_id)
REFERENCES todos.users (user_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
