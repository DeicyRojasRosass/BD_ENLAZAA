-- PostgreSQL database dump
--
-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name db_enlazaa_auth; Type DATABASE; Schema -;
--

CREATE DATABASE db_enlazaa_auth WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';

\connect db_enlazaa_auth


-------------------------------------------------------
-------------------------------------------------------
REVOKE ALL ON SCHEMA public FROM public;
REVOKE ALL ON DATABASE db_enlazaa_auth FROM public;


CREATE ROLE grp_authbank WITH
NOLOGIN
NOSUPERUSER
NOINHERIT
NOCREATEDB
NOCREATEROLE
NOREPLICATION;

revoke all on schema public from grp_authbank;
revoke all on database db_enlazaa_auth from grp_authbank;

GRANT CONNECT ON DATABASE db_enlazaa_auth TO grp_authbank;

CREATE ROLE usr_authbank WITH
LOGIN
NOSUPERUSER
INHERIT
NOCREATEDB
NOCREATEROLE
NOREPLICATION
PASSWORD '12345*';

GRANT grp_authbank TO usr_authbank;
GRANT USAGE ON SCHEMA public TO grp_authbank;

-----------------------------

create extension "uuid-ossp";

--------------------------------

CREATE TABLE public.authentication_method (
	id int NOT NULL,
	"name" varchar(50) NOT NULL,
	alias varchar(50) NOT NULL,
	is_active bool NOT NULL DEFAULT false,
CONSTRAINT pk_authentication_method PRIMARY KEY (id)
);
CREATE UNIQUE INDEX authentication_method_pk ON public.authentication_method USING btree (id);



CREATE TABLE public.authentication_provider (
	id int NOT NULL,
	"name" varchar NOT NULL,
	alias varchar NOT NULL,
	is_active bool NOT NULL DEFAULT false
);
CREATE UNIQUE INDEX authentication_provider_pk ON public.authentication_provider USING btree (id);


CREATE TABLE public.users (
	id uuid NOT NULL DEFAULT uuid_generate_v4(),
	auth_method_id int NULL,
	name varchar(50),
	lastname varchar(50),
	username varchar(150) NOT NULL,
	"password" text NULL,
	full_name varchar(150) NOT NULL,
	sub varchar(150) NULL,
	image_url text NULL,
	is_active bool NOT NULL DEFAULT false,
	auth_provider_id int NULL,
	created_at timestamp not null DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_user PRIMARY KEY (id)
);



CREATE TABLE public.roles (
	id uuid NOT NULL DEFAULT uuid_generate_v4(),
	"name" varchar(50) NULL,
	alias varchar(50) NULL,
	description varchar(500) NULL,
	is_active bool NOT NULL DEFAULT false,
	CONSTRAINT ckc_alias_role CHECK (((alias IS NULL) OR ((alias)::text = upper((alias)::text)))),
	CONSTRAINT pk_role PRIMARY KEY (id)
);
CREATE UNIQUE INDEX rol_uq ON public.roles USING btree (name);


CREATE TABLE public.applications (
	id uuid NOT NULL DEFAULT uuid_generate_v4(),
	"name" varchar(150) NOT NULL,
	alias varchar(50) NOT NULL,
	url_redirection varchar(500),
	is_active bool NOT NULL DEFAULT false,
	created_at timestamp  not null DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_applications PRIMARY KEY (id)
);



CREATE TABLE public.users_roles (
	role_id uuid NOT NULL,
	user_id uuid NOT NULL,
	application_id uuid,
	by_default bool NOT NULL DEFAULT false,
	is_active bool NOT NULL DEFAULT false,
	CONSTRAINT pk_user_rol PRIMARY KEY (role_id, user_id)
);
CREATE UNIQUE INDEX user_rol_uq ON public.users_roles USING btree (user_id, role_id);
CREATE INDEX user_role_user_fk ON public.users_roles USING btree (user_id);


ALTER TABLE public.users_roles ADD CONSTRAINT fk_user_role_role FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE public.users_roles ADD CONSTRAINT fk_user_role_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE public.users_roles ADD CONSTRAINT fk_user_role_application FOREIGN KEY (application_id) REFERENCES public.applications(id) ON DELETE RESTRICT ON UPDATE RESTRICT;


CREATE TABLE public.users_applications (
	user_id uuid NOT NULL,
	application_id uuid NOT NULL,
	by_default bool NOT NULL DEFAULT false,
	is_active bool NOT NULL DEFAULT false,
	CONSTRAINT pk_user_application PRIMARY KEY (user_id,application_id)
);
CREATE UNIQUE INDEX user_application_uq ON public.users_applications USING btree (user_id, application_id);
CREATE INDEX users_applications_user_fk ON public.users_applications USING btree (user_id);


ALTER TABLE public.users_applications ADD CONSTRAINT fk_user_application_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE public.users_applications ADD CONSTRAINT fk_user_application_application FOREIGN KEY (application_id) REFERENCES public.applications(id) ON DELETE RESTRICT ON UPDATE RESTRICT;



---------PERMISOS--------------------------

GRANT SELECT,insert,UPDATE,DELETE ON public.users TO usr_authbank;
GRANT SELECT ON public.authentication_provider TO usr_authbank;
GRANT SELECT ON public.authentication_method TO usr_authbank;
GRANT SELECT ON public.roles TO usr_authbank;
GRANT SELECT ON public.applications TO usr_authbank;
GRANT SELECT,insert,UPDATE,DELETE ON public.users_roles TO usr_authbank;
GRANT SELECT,insert,UPDATE,DELETE ON public.users_applications TO usr_authbank;


--------INSERCION DE DATOS-----------------

INSERT INTO public.authentication_method (id,name,alias,is_active) values 
	(1,'Normal','USRPWD',true),(2,'Third Part','TPART',true);
	

INSERT INTO public.authentication_provider  (id,name,alias,is_active) values 
	(1,'Enlazaa','ENLAZAA',true),
	(2,'Google','GOOGLE',true),
	(3,'Microsoft','MICROSOFT',true),
	(4,'Facebook','FACEBOOK',true);


--users 

INSERT INTO public.users (id,auth_method_id,name,lastname,username,"password",full_name,sub,image_url,is_active,auth_provider_id) VALUES
	 ('ef1f9c43-bbc6-4604-92f6-473c6d30d515',2,'Mauricio','Vargas','femauro@gmail.com',NULL,'Félix Mauricio Vargas Hincapié','100061214360556331186','https://lh3.googleusercontent.com/a/AGNmyxaxLh821JeY2ZXq4TiXw7Vu0QyJkYBZfwR4_i2XJQ=s96-c',true,2),
	 ('9cad3d9b-02c9-4228-8db2-1bb4e9373dab',2,'Reinel','Ochoa','reinel.ochoa@ceinfes.com',NULL,'Reinel José Ochoa Quintero','9DpTF7P4cbKk9agnCNrUm7Cdakbn85wxcOZ6wU4GkgI',NULL,true,3);
	 
	 INSERT INTO public.users (id,auth_method_id,name,lastname,username,"password",full_name,sub,image_url,is_active,auth_provider_id) values ('798a71ae-521b-4af9-845d-0899a1348223',1,'Editor','enlazaa','editor@ceinfes.com','$2a$15$JrbxK0RF/NeWHwYDTkCLBexsB6fpxbAvn1lUtOhhJEGz.YVDKLrK.','editor enlazaa',null,null,true,1);
	  INSERT INTO public.users (id,auth_method_id,name,lastname,username,"password",full_name,sub,image_url,is_active,auth_provider_id) values ('f15c9720-3c05-4e38-a8ba-e7d8f12b9c42',1,'digitalizador','enlazaa','digitalizador@ceinfes.com','$2a$15$JrbxK0RF/NeWHwYDTkCLBexsB6fpxbAvn1lUtOhhJEGz.YVDKLrK.','digitalizador enlazaa',null,null,true,1);
	   INSERT INTO public.users (id,auth_method_id,name,lastname,username,"password",full_name,sub,image_url,is_active,auth_provider_id) values ('fa0c9b28-c34e-4ca4-82eb-b435647db2aa',1,'constructor','enlazaa','constructor@ceinfes.com','$2a$15$JrbxK0RF/NeWHwYDTkCLBexsB6fpxbAvn1lUtOhhJEGz.YVDKLrK.','constructor enlazaa',null,null,true,1);
	 

--roles

INSERT INTO public.roles (id,name,alias,is_active) values 
	('4adad571-c12b-4a8c-b774-82dcd86a87b5','Student','ESTUDIANTE',true),
	('ccd24c71-d8a2-4665-a838-8b27d51f654a','Teacher','DOCENTE',true);
INSERT INTO public.roles (id,name,alias,is_active) values
	('f7ed31ff-1944-45f9-b03d-44abc812c360','Constructed','CONSTRUCTOR',true);
INSERT INTO public.roles (id,name,alias,is_active) values
	('6316a4be-3e2c-4442-9cbb-b486b68b0e5a','digitizer','DIGITALIZADOR',true);
INSERT INTO public.roles (id,name,alias,is_active) values
	('fbfb276a-dbe3-4af2-8b81-a4e1a9d1fd54','editor','EDITOR',true);
	

--applications

INSERT INTO public.applications (id,name,alias,url_redirection,is_active) values
	('ff394485-896f-4604-baf6-d4e84743d9d2','Enlazaa','ENLAZAA','http://miltonochoa.synology.me:3001',true);
INSERT INTO public.applications (id,name,alias,url_redirection,is_active) values
	('2284cf0a-ec06-4a88-873a-86ae7d36b4a0','Banco de Preguntas','BANCOPREGUNTAS','http://miltonochoa.synology.me:3001',true);
INSERT INTO public.applications (id,name,alias,url_redirection,is_active) values
	('2fa77ac1-1bcd-478b-a694-4e1a0ca17665','Enlazaa','ENLAZAAINSTITUCIONAL','http://miltonochoa.synology.me:3001',true);



--users_roles
INSERT INTO public.users_roles (role_id,user_id,application_id,by_default,is_active) VALUES
	 ('f7ed31ff-1944-45f9-b03d-44abc812c360','ef1f9c43-bbc6-4604-92f6-473c6d30d515','2284cf0a-ec06-4a88-873a-86ae7d36b4a0',true,true),
	 ('f7ed31ff-1944-45f9-b03d-44abc812c360','9cad3d9b-02c9-4228-8db2-1bb4e9373dab','2284cf0a-ec06-4a88-873a-86ae7d36b4a0',true,true),
	 ('6316a4be-3e2c-4442-9cbb-b486b68b0e5a','9cad3d9b-02c9-4228-8db2-1bb4e9373dab','2284cf0a-ec06-4a88-873a-86ae7d36b4a0',true,true),
	 ('fbfb276a-dbe3-4af2-8b81-a4e1a9d1fd54','798a71ae-521b-4af9-845d-0899a1348223','2284cf0a-ec06-4a88-873a-86ae7d36b4a0',true,true),
	 ('6316a4be-3e2c-4442-9cbb-b486b68b0e5a','798a71ae-521b-4af9-845d-0899a1348223','2284cf0a-ec06-4a88-873a-86ae7d36b4a0',false,true),
	 ('f7ed31ff-1944-45f9-b03d-44abc812c360','798a71ae-521b-4af9-845d-0899a1348223','2284cf0a-ec06-4a88-873a-86ae7d36b4a0',false,true),
	 ('f7ed31ff-1944-45f9-b03d-44abc812c360','fa0c9b28-c34e-4ca4-82eb-b435647db2aa','2284cf0a-ec06-4a88-873a-86ae7d36b4a0',false,true),
	 ('6316a4be-3e2c-4442-9cbb-b486b68b0e5a','fa0c9b28-c34e-4ca4-82eb-b435647db2aa','2284cf0a-ec06-4a88-873a-86ae7d36b4a0',true,true),
	 ('6316a4be-3e2c-4442-9cbb-b486b68b0e5a','f15c9720-3c05-4e38-a8ba-e7d8f12b9c42','2284cf0a-ec06-4a88-873a-86ae7d36b4a0',true,true);
	


--users_applications

INSERT INTO public.users_applications (user_id,application_id,by_default,is_active) VALUES
	 ('ef1f9c43-bbc6-4604-92f6-473c6d30d515','2284cf0a-ec06-4a88-873a-86ae7d36b4a0',true,true),
	 ('9cad3d9b-02c9-4228-8db2-1bb4e9373dab','2284cf0a-ec06-4a88-873a-86ae7d36b4a0',true,true),
	 ('9cad3d9b-02c9-4228-8db2-1bb4e9373dab','ff394485-896f-4604-baf6-d4e84743d9d2',true,true),
	('798a71ae-521b-4af9-845d-0899a1348223','2284cf0a-ec06-4a88-873a-86ae7d36b4a0',true,true),
	('f15c9720-3c05-4e38-a8ba-e7d8f12b9c42','2284cf0a-ec06-4a88-873a-86ae7d36b4a0',true,true),
	('fa0c9b28-c34e-4ca4-82eb-b435647db2aa','2284cf0a-ec06-4a88-873a-86ae7d36b4a0',true,true);
	 
	 

