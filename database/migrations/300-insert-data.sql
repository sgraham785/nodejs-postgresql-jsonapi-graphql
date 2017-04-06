/*
INSERT INTO navigation.menu_option (menu_title, route_uri, package_url) VALUES (
  'React', '/react', './path/to/local/package'
);
INSERT INTO navigation.menu_option (name) VALUES (
  'Angular', '/angular', './path/to/local/package'
);
INSERT INTO navigation.menu_option (name) VALUES (
  'Backbone', '/backbone', './path/to/local/package'
);
*/

\c patient_portal;

INSERT INTO navigation.industries (industry_name) VALUES ('Dental');
INSERT INTO navigation.industries (industry_name) VALUES ('Pet Care');

INSERT INTO navigation.menu_options (menu_title,route_uri,package_url) VALUES ('Messaging', 'messaging', 'https://cdn.com/mbundle.js');
INSERT INTO navigation.menu_options (menu_title,route_uri,package_url) VALUES ('Appointments', 'appointments', 'https://cdn.com/abundle.js');
INSERT INTO navigation.menu_options (menu_title,route_uri,package_url) VALUES ('Forms', 'forms', 'https://cdn.com/fbundle.js');

INSERT INTO navigation.industry_menu_options (industry_id,menu_option_id,display_order) VALUES (1,2,1);
INSERT INTO navigation.industry_menu_options (industry_id,menu_option_id,display_order) VALUES (1,1,2);
INSERT INTO navigation.industry_menu_options (industry_id,menu_option_id,display_order) VALUES (1,3,3);

INSERT INTO navigation.client_industry_menu_options (client_id,industry_menu_option_id) VALUES (4,1);
INSERT INTO navigation.client_industry_menu_options (client_id,industry_menu_option_id) VALUES (4,2);
INSERT INTO navigation.client_industry_menu_options (client_id,industry_menu_option_id) VALUES (4,3);

INSERT INTO navigation.consumer_menu_options (consumer_id,client_industry_menu_option_id) VALUES (5,2);
INSERT INTO navigation.consumer_menu_options (consumer_id,client_industry_menu_option_id) VALUES (5,3);