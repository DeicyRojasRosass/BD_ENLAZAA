--
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
-- Name db_enlazaa_questions; Type DATABASE; Schema -;
--

CREATE DATABASE db_enlazaa_product WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';

\connect db_enlazaa_product


-------------------------------------------------------
-------------------------------------------------------
REVOKE ALL ON SCHEMA public FROM public;
REVOKE ALL ON DATABASE db_enlazaa_product FROM public;


CREATE ROLE grp_enlazaa WITH
NOLOGIN
NOSUPERUSER
NOINHERIT
NOCREATEDB
NOCREATEROLE
NOREPLICATION;

revoke all on schema public from grp_enlazaa;
revoke all on database db_enlazaa_product from grp_enlazaa;

GRANT CONNECT ON DATABASE db_enlazaa_product TO grp_enlazaa;

CREATE ROLE usr_product WITH
LOGIN
NOSUPERUSER
INHERIT
NOCREATEDB
NOCREATEROLE
NOREPLICATION
PASSWORD '12345*';

GRANT grp_enlazaa TO usr_product;
GRANT USAGE ON SCHEMA public TO grp_enlazaa;


create TABLE public.lines (
   id int  not null,
   "name" character varying(100)  not null,
   alias character varying(100)  not null,
   orderoflist int  not null,
   is_active bool  not null DEFAULT false,
   created_at timestamp  not null DEFAULT CURRENT_TIMESTAMP,
constraint lines_pk PRIMARY KEY (id)
);


create TABLE public.categories (
   id int  not null,
   "name" character varying(100)  not null,
   line_id int,
   alias character varying(100)  not null,
   orderoflist int  not null,
   is_active bool  not null DEFAULT false,
   created_at timestamp  not null DEFAULT CURRENT_TIMESTAMP,
constraint categories_pk PRIMARY KEY (id)
);

alter table public.categories add constraint categories_lines_fk foreign key (line_id) references public.lines(id);



create TABLE public.materialtypes (
   id int  not null ,
   "name" character varying(100)  not null,
   alias character varying(100)  not null,
   category_id int,
   cycle int,
   orderoflist int  not null,
   is_active bool  not null DEFAULT false,
   created_at timestamp  not null DEFAULT CURRENT_TIMESTAMP,
constraint typematerials_pk PRIMARY KEY (id)
);
alter table public.materialtypes add constraint materialtypes_categorys_fk foreign key (category_id) references public.categories(id);



-----PERMISOS--------------------------

GRANT SELECT ON public.categories TO usr_product;
GRANT SELECT ON public.lines TO usr_product;
GRANT SELECT ON public.materialtypes TO usr_product;



---INSERCION DE DATOS ------------------

--LINEA DE PRODUCTO:

INSERT INTO public.lines(id,name,alias,orderoflist,is_active,created_at) VALUES
     (1,'Evaluación Externa','EV',1,true,CURRENT_TIMESTAMP),
     (2,'Formación Para Estudiante','FE',2,true,CURRENT_TIMESTAMP),
     (3,'Actualización Docente','AD',3,true,CURRENT_TIMESTAMP),
     (4,'Editorial','ED',4,true,CURRENT_TIMESTAMP),
     (5,'Ceinfes Tech','CT',5,true,CURRENT_TIMESTAMP);


----CATEGORIAS:

INSERT INTO public.categories (id,"name",line_id,alias,orderoflist,is_active,created_at) VALUES
     (1,'Simulacro 11º',1,'SIMG11',2,true,CURRENT_TIMESTAMP),
     (2,'Libros Grado 11',4,'LIBG11',10,true,CURRENT_TIMESTAMP),
     (6,'Cartillas PreUNAL',4,'CARPREU',17,true,CURRENT_TIMESTAMP),
     (8,'Horas Clase Particulares',2,'HCLAS',18,false,CURRENT_TIMESTAMP),
     (9,'Modulos',1,'MODUL',8,false,CURRENT_TIMESTAMP),
     (10,'Tablet',1,'TABLET',12,false,CURRENT_TIMESTAMP),
     (12,'Martes de Prueba',1,'MPRUBA',1,true,CURRENT_TIMESTAMP),
     (13,'Ciudadanas',1,'CIUDAD',8,true,CURRENT_TIMESTAMP),
     (15,'Mi Primer Martes',1,'MPMPR',9,true,CURRENT_TIMESTAMP),
     (16,'Saberes',1,'SABER',7,true,CURRENT_TIMESTAMP);
INSERT INTO public.categories (id,"name",line_id,alias,orderoflist,is_active,created_at) VALUES
     (17,'Pensar',1,'PENSAR',6,true,CURRENT_TIMESTAMP),
     (18,'Integradas',1,'INTEG',16,true,CURRENT_TIMESTAMP),
     (19,'Talleres Estud.',2,'TLLREST',44,true,CURRENT_TIMESTAMP),
     (22,'Libros Grado 10',4,'LIBG10',11,true,CURRENT_TIMESTAMP),
     (23,'Libros Grado 9',4,'LIBG9',12,true,CURRENT_TIMESTAMP),
     (25,'Libros Grado 5',4,'LIBG5',13,true,CURRENT_TIMESTAMP),
     (26,'Libros Grado 3',4,'LIBG3',29,false,CURRENT_TIMESTAMP),
     (27,'Libros Docentes',4,'LIBDOC',14,true,CURRENT_TIMESTAMP),
     (28,'Libros Pre-Unal',4,'LBRPREU',16,true,CURRENT_TIMESTAMP),
     (29,'Cartillas Pre-Icfes',4,'CARTPREI',37,true,CURRENT_TIMESTAMP);
INSERT INTO public.categories (id,"name",line_id,alias,orderoflist,is_active,created_at) VALUES
     (30,'Admon. Plataforma',1,'PLATF',11,false,CURRENT_TIMESTAMP),
     (32,'Cartilla Docente',1,'CARTILLA',7,false,CURRENT_TIMESTAMP),
     (35,'Estudiantes Pre-Icfes',1,'ESTPREI',10,false,CURRENT_TIMESTAMP),
     (36,'Libros Lectura Crítica',4,'LBLC',15,true,CURRENT_TIMESTAMP),
     (37,'Horas Clase Pre-ICFES',2,'HPREI',40,true,CURRENT_TIMESTAMP),
     (38,'Horas Clase Pre-U',2,'HPREU',20,false,CURRENT_TIMESTAMP),
     (39,'Horas Clase Diplomado',3,'HDIPL',39,true,CURRENT_TIMESTAMP),
     (40,'Conferencia Doc',3,'CNFDOC',35,true,CURRENT_TIMESTAMP),
     (41,'Horas Clase Capacitació',2,'HCAP',21,false,CURRENT_TIMESTAMP),
     (42,'Agendas CEINFES',1,'AGENDA',31,true,CURRENT_TIMESTAMP);
INSERT INTO public.categories (id,"name",line_id,alias,orderoflist,is_active,created_at) VALUES
     (43,'Cartillas',2,'CARTILLA',18,true,CURRENT_TIMESTAMP),
     (45,'Hoja Encuesta Sesió',1,'HENCUE',19,true,CURRENT_TIMESTAMP),
     (46,'Paquete Diamond',2,'PDIAM',21,true,CURRENT_TIMESTAMP),
     (51,'Diplomado',3,'Diplo',36,true,CURRENT_TIMESTAMP),
     (53,'PreSABER 11º',2,'PSBER11',23,true,CURRENT_TIMESTAMP),

     (54,'PreSABER 10º',2,'PSBER10',24,true,CURRENT_TIMESTAMP),
     (55,'PreSABER 9°',2,'PSBER9',25,true,CURRENT_TIMESTAMP),
     (57,'Administración PreIcfes',1,'ADM',14,false,CURRENT_TIMESTAMP),
     (58,'Volante',4,'Vol',46,true,CURRENT_TIMESTAMP),
     (59,'Talleres Docente',3,'TLLDOC',43,true,CURRENT_TIMESTAMP);
INSERT INTO public.categories (id,"name",line_id,alias,orderoflist,is_active,created_at) VALUES
     (60,'Kit 11º',2,'KIT11',27,true,CURRENT_TIMESTAMP),
     (61,'Kit 10º',2,'KIT10',28,true,CURRENT_TIMESTAMP),
     (62,'Kit 9º',2,'KIT9',29,true,CURRENT_TIMESTAMP),
     (63,'Kit 5º',2,'KIT5',30,true,CURRENT_TIMESTAMP),
     (64,'Kit Lectura Crítica',2,'KLECRIT',31,true,CURRENT_TIMESTAMP),
     (65,'Martes De Prueba Plus',1,'MPPL',15,true,CURRENT_TIMESTAMP),
     (66,'PreSABER 11º Plata',2,'PSBER11PL',42,true,CURRENT_TIMESTAMP),
     (67,'Pre Universitario',2,'PREU',33,true,CURRENT_TIMESTAMP),
     (68,'Conferencia',2,'CONFEST',34,true,CURRENT_TIMESTAMP),
     (69,'Herramientas Metodológicas Docente',4,'HMETDOC',38,true,CURRENT_TIMESTAMP);
INSERT INTO public.categories (id,"name",line_id,alias,orderoflist,is_active,created_at) VALUES
     (70,'Simulacros 10º',1,'SIMG10',3,true,CURRENT_TIMESTAMP),
     (71,'Simulacro UNAL',1,'SIMUNAL',4,true,CURRENT_TIMESTAMP),
     (72,'Hoja Respuesta',1,'HRESP',20,true,CURRENT_TIMESTAMP),
     (73,'Carné',2,'Carné',33,false,CURRENT_TIMESTAMP),
     (74,'Tarjetas',4,'TAR',45,true,CURRENT_TIMESTAMP),
     (75,'Afiches',4,'Afiches',30,true,CURRENT_TIMESTAMP),
     (76,'Calendarios',4,'CAL',32,true,CURRENT_TIMESTAMP),
     (77,'Simulacro Lectura Crítica',1,'SIMLC',5,true,CURRENT_TIMESTAMP),
     (78,'Esfero',1,'ESFERO',37,true,CURRENT_TIMESTAMP),
     (79,'Sticker para recepción de hojas de respuesta',4,'Sticker',47,false,CURRENT_TIMESTAMP);
INSERT INTO public.categories (id,"name",line_id,alias,orderoflist,is_active,created_at) VALUES
     (80,'Encuestas para cursos Preicfes ',4,'Encuestas',48,false,CURRENT_TIMESTAMP),
     (81,'Portafolio de Servicio',1,'PORTAFOLIO',38,true,CURRENT_TIMESTAMP),
     (82,'Mód. Enseñanza Aprendizaje',5,'MEAP',45,true,CURRENT_TIMESTAMP),
     (83,'Martes de Prueba Virtual',5,'MPVIR',1,true,CURRENT_TIMESTAMP),
     (84,'Pensar Virtual',5,'PENVIR',6,true,CURRENT_TIMESTAMP),
     (85,'Simulacros 11º Virtual',5,'SIM11VIR',2,true,CURRENT_TIMESTAMP),
     (86,'Simulacros 10º Virtual',5,'SIM10VIR',3,true,CURRENT_TIMESTAMP),
     (87,'Ciudadanas Virtual',5,'CIUVIR',8,true,CURRENT_TIMESTAMP),
     (88,'Simulacro Lectura Crítica Virtual',5,'SIMLCVIR',5,true,CURRENT_TIMESTAMP),
     (89,'Martes De Prueba Gold',1,'MPG',1,true,CURRENT_TIMESTAMP);
INSERT INTO public.categories (id,"name",line_id,alias,orderoflist,is_active,created_at) VALUES
     (90,'Martes De Prueba Gold Virtual',5,'MPGVIR',1,true,CURRENT_TIMESTAMP),
     (91,'Saberes Virtual',5,'SABVIR',7,true,CURRENT_TIMESTAMP),
     (92,'PreSABER 9º Virtual',5,'PS9VIR',46,true,CURRENT_TIMESTAMP),
     (93,'PreSABER 10º Virtual',5,'PS10VIR',47,true,CURRENT_TIMESTAMP),
     (94,'PreSABER 11º Virtual',5,'PS11VIR',48,true,CURRENT_TIMESTAMP),
     (95,'PreSABER 11º Plata Virtual',5,'PS11PVIR',49,true,CURRENT_TIMESTAMP),
     (96,'Horas Clase Virtual',5,'HCVIR',50,true,CURRENT_TIMESTAMP),
     (97,'Kit 11º Virtual',5,'KIT11VIR',51,true,CURRENT_TIMESTAMP),
     (98,'Kit 10º Virtual',5,'KIT10VIR',52,true,CURRENT_TIMESTAMP),
     (99,'Talleres Estud. Virtual',5,'TLLESTVIR',53,true,CURRENT_TIMESTAMP);
INSERT INTO public.categories (id,"name",line_id,alias,orderoflist,is_active,created_at) VALUES
     (100,'Paquete Diamond Virtual',5,'PDIAMV',54,true,CURRENT_TIMESTAMP),
     (101,'Libros Método 84h',4,'LIBMG1',49,true,CURRENT_TIMESTAMP);


------TIPO DE MATERIAL

INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (1,'Simulacro D9',1,1,4,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (2,'Simulacro S9',1,1,5,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (3,'Simulacro F9',1,1,6,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (4,'Simulacro SM-10',70,1,10,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (5,'Simulacro D3',1,1,18,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (6,'Simulacro D2',1,1,19,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (7,'Saber 11 (Negro)',2,1,4,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (8,'SABERes 11 2014',2,1,5,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (9,'Modulo Pre-icfes',9,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (10,'Módulo UNAL',9,1,6,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (11,'Simulacro MD4',1,1,15,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (12,'Simulacro MS4',1,2,18,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (13,'Simulacro MF4',1,3,17,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (14,'Horas Clases Pre-Icfes',37,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (15,'Simulacro DIAGN UNAL',71,1,30,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (16,'Simulacro SEGUI UNAL',71,2,31,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (17,'Simulacro FINAL UNAL',71,3,32,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (18,'Talleres Docente',59,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (19,'Pasaporte U Matemáticas',6,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (20,'Pasaporte U Sociales',6,1,2,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (21,'Pasaporte U Naturales',6,1,3,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (22,'Pasaporte U Análisis Textual',6,1,4,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (23,'Cartillas Desafios',29,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (24,'Libro Argollado Exámenes UNAL',28,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (25,'Tablet Pre-Icfes',10,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (26,'Prueba No 1',12,1,1,true,'MP1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (27,'Prueba No 2',12,1,2,true,'MP2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (28,'Prueba No 3',12,1,3,true,'MP3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (29,'Prueba No 4',12,1,4,true,'MP4',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (30,'Prueba No 5',12,1,5,true,'MP5',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (31,'Prueba No 6',12,2,6,true,'MP6',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (32,'Prueba No 7',12,2,7,true,'MP7',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (33,'Prueba No 8',12,2,8,true,'MP8',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (34,'Prueba No 9',12,2,9,true,'MP9',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (35,'Prueba No 10',12,2,10,true,'MP10',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (36,'Prueba No 11',12,3,11,true,'MP11',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (37,'Prueba No 12',12,3,12,true,'MP12',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (38,'Prueba No 13',12,3,13,true,'MP13',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (39,'Prueba No 14',12,3,14,true,'MP14',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (40,'Prueba No 15',12,3,15,true,'MP15',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (41,'Prueba No 16',12,4,16,true,'MP16',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (42,'Prueba No 17',12,4,17,true,'MP17',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (43,'Prueba No 18',12,4,18,true,'MP18',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (44,'Prueba No 19',12,4,19,true,'MP19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (45,'Prueba No 20',12,4,20,true,'MP20',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (46,'Ciudadanas 1',13,1,1,true,'CIU1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (47,'Ciudadanas 2',13,2,2,true,'CIU2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (48,'Ciudadanas 3',13,3,3,true,'CIU3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (49,'Ciudadanas 4',13,4,4,true,'CIU4',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (50,'Mi Prueba No 1',15,1,1,true,'MPM1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (51,'Mi Prueba No 2',15,2,2,true,'MPM2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (52,'Mi Prueba No 3',15,3,3,true,'MPM3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (53,'Mi Prueba No 4',15,4,4,true,'MPM4',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (54,'SB-Diagnóstico',16,1,1,true,'SBD',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (55,'SB-Seguimiento',16,2,2,true,'SBS',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (56,'SB-Final',16,3,3,true,'SBF',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (57,'Integrada 1',18,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (58,'Integrada 2',18,1,2,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (59,'Integrada 3',18,1,3,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (60,'Integrada 4',18,1,4,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (61,'Pensar 1',17,1,1,true,'PNS1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (62,'Pensar 2',17,2,2,true,'PNS2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (63,'Pensar 3',17,3,3,true,'PNS3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (64,'Pensar 4',17,4,4,true,'PNS4',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (65,'Prueba CN-1',1,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (66,'Simulacro PS2',70,1,9,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (67,'Simulacro LC Intermedio',77,1,91,true,'LCI',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (68,'Simulacro LC Avanzado',77,2,92,true,'LCA',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (69,'Simulacro MDS',1,1,16,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (70,'Talleres De Lectura Crítica',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (71,'Pasaporte U Análisis Imagen',6,1,5,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (72,'Saberes 9-10',23,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (73,'Saber Hacer En El Aula',27,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (74,'Simulacro AD10',70,1,10,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (75,'Simulacro AD11',1,1,13,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (76,'Simulacro AS10',70,2,11,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (77,'Simulacro AS11',1,2,2,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (78,'Simulacro AF10',70,3,12,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (79,'Simulacro AF11',1,3,15,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (80,'Lectores de lo literal a lo crítico',2,1,3,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (81,'Libro Conceptos 10',22,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (82,'Tablet Pre-Unal',10,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (83,'Cartilla Lectura Crítica',29,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (84,'Talleres Estudiante',19,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (85,'Horas Particulares',8,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (86,'Admon. Plataforma',30,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (87,'Simulacro LC Básico',77,1,90,true,'LCB',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (88,'Horas Clase Pre-U',38,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (89,'Cartilla Docente Biologia',32,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (90,'Cartilla Docente Matematicas',32,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (91,'Cartilla Docente Sociales y CC',32,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (92,'Cartilla Docente Lectura Critica',32,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (93,'Cartilla Docente Quimica',32,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (94,'Cartilla Docente Fisica',32,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (95,'Cartilla Docente Ingles',32,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (96,'Cartilla Docente CTS',32,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (97,'Libro Lectura Crítica',36,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (98,'Cartilla Docente Blanco y Negro',32,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (99,'Simulacro BS11',1,2,5,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (100,'Simulacro CS2',1,2,11,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (101,'Simulacro CF19',1,1,8,true,'CF19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (102,'Prueba Especial LC',77,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (103,'Simulacro BF11',1,3,4,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (104,'Simulacro PF3',70,3,7,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (105,'Horas Clase Diplomado',39,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (106,'Conferencia Doc',40,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (107,'Horas Clase Capacitación',41,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (108,'Media Jornada Desafíos (MDS)',1,1,33,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (109,'Libro Saberes 9-10 Sin Logo',23,1,2,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (110,'Agenda ',42,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (111,'Cartillas Plan Lector',43,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (112,'Cartillas Análisis de Gráficas',43,1,2,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (113,'Simulacro BD10',70,1,1,true,'BD10',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (114,'Simulacro BD11',1,1,3,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (115,'Simulacro CD1',1,1,6,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (116,'Simulacro PD1',70,1,4,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (117,'Hoja Encuesta Sesión',45,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (118,'Entrenamiento al Saber 2016',2,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (119,'Simulacro BS10',70,2,3,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (120,'Simulacro BF10',70,3,2,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (121,'Paquete Diamond AAMO',46,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (122,'Cartilla Taller Comprensión de Textos',43,1,3,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (123,'Simulacro CF3',1,0,9,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (124,'Sticker Tintas En Adhesivo',45,1,2,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (125,'SABERes 5',25,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (126,'Administración PreIcfes',57,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (127,'PreI 104 (2 Libros + 3 Simulacros)',53,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (128,'PreI 84 (2 Libros + 3 Simulacros)',54,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (129,'72 Horas + 1 Libro + 3 Simulacros',55,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (130,'Volante Pre Icfes 11',58,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (131,'Volante Pre Icfes 10',58,1,2,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (132,'Volante Pre Unal',58,1,3,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (133,'Volante Martes De Prueba',58,1,4,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (134,'Pasaporte U Biología',6,1,6,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (135,'Pasaporte U Química',6,1,7,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (136,'Pasaporte U Física',6,1,8,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (137,'Simulacro CD19',1,1,7,true,'CD19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (138,'Simulacro CS19',1,1,10,true,'CS19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (139,'Simulacro PD19',70,1,5,true,'PD19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (140,'Simulacro PS19',70,1,8,true,'PS19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (141,'Simulacro PF19',70,1,6,true,'PF19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (142,'SABERes 11 104',2,1,6,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (143,'SABERes 11 Plata 2016',2,1,7,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (144,'Diseño Pruebas A Partir De MBE',51,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (145,'Metodología Diseño Curricular',51,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (146,'Simulacro H11',1,1,12,true,'H11',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (147,'Simulacro H12',1,1,13,true,'H12',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (148,'Simulacro H13',1,1,14,true,'H13',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (149,'Construcción De Preguntas En El MBE',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (150,'Elementos Que Componen Un Diseño Curricular Basado En Competencias " Antes De Entrar Al Aula"',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (151,'Cómo Desarrollar Multiperpectivismo En El Aula De Clase',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (152,'Cómo Desarrollar Pensamiento Sistémico En El Aula De Clase',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (153,'Componentes Para El Diseño De Clases Exitosas',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (154,'Análisis De Gráficas Y Esquemas ',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (155,'Taller Semana De Capacitación',19,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (156,'Taller De Lectura Crítica (12 horas) - Institucional',19,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (157,'Talleres Refuerzo',19,1,1,true,'TERE',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (158,'Elementos Generales Del MBE',40,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (159,'El Diseño Curricular: Una Herramienta De Gestión De Procesos Académicos',40,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (160,'Herramientas Metodológicas Docente PREI',69,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (161,'Herramientas Metodológicas Docente PreU',69,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (162,'Pasaporte U Tomo 1',28,1,2,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (163,'Pasaporte U Tomo 2',28,1,3,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (164,'Entrenamiento al Saber',2,1,2,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (165,'Nivel 1',46,1,1,true,'N1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (166,'Nivel 2',46,1,2,true,'N2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (167,'Nivel 3',46,1,3,true,'N3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (168,'Nivel 4',46,1,4,true,'N4',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (169,'Nivel 5',46,1,5,true,'N5',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (170,'Nivel 6',46,1,6,true,'N6',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (171,'Nivel 7',46,1,7,true,'N7',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (172,'Nivel 8',46,1,8,true,'N8',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (173,'Nivel 9',46,1,9,true,'N9',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (174,'Nivel 10',46,1,10,true,'N10',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (175,'Nivel 11',46,1,11,true,'N11',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (176,'Nivel 12',46,1,12,true,'N12',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (177,'Nivel 13',46,1,13,true,'N13',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (178,'Nivel 14',46,1,14,true,'N14',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (179,'Taller Especial',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (180,'Saberes 9º',23,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (181,'Volante Ciudadanas',58,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (182,'Simulacro LC Intermedio 2019',77,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (183,'HR Martes De Prueba',72,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (184,'HR Simulacro',72,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (185,'HR Pensar',72,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (186,'HR Saberes',72,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (187,'HR Ciudadanas',72,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (188,'Carné Estudiante',73,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (189,'Aplicación 2',73,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (190,'Aplicación 3',73,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (191,'Volante Saberes 11',58,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (192,'PreI 72 Horas + 1 Libro + 2 Simulacros',66,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (193,'Conferencia Metodológica',68,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (194,'Taller Diagnóstico Curricular',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (195,'Simulacro PD-19',70,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (196,'Simulacro PS-19',70,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (197,'Simulacro PF-19',70,1,1,false,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (198,'Semana de Alto Rendimiento',19,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (199,'Simulacro UNAL Aplicación 1',71,1,33,true,'SUA1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (200,'Simulacro UNAL Aplicación 2',71,2,34,true,'SUA2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (201,'Simulacro UNAL Aplicación 3',71,3,35,true,'SUA3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (202,'Acercamiento a la evaluación desde la lógica de los procesos (MBE)',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (203,'Uso de referentes en evaluación',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (204,'Acciones de mejoramiento',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (205,'Gestión por procesos',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (206,'Elementos del diagnóstico interno',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (207,'Evaluación adaptativa',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (208,'Estudio de caso',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (209,'Pensamiento visual-Visual Thinking',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (210,'Gamificación',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (211,'Aula Invertida',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (212,'STEAM',59,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (213,'Evaluación adaptativa',51,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (214,'Estudio de caso',51,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (215,'Pensamiento visual-Visual Thinking',51,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (216,'Gamificación',51,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (217,'Aula Invertida',51,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (218,'STEAM',51,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (219,'Tarjeta',74,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (220,'Afiche',75,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (221,'Calendarios',76,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (222,'Esferos Be+',78,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (223,'Simulacro UNAL MP',71,3,36,true,'SUMP',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (224,'SABERes 11 84',2,1,8,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (225,'Sticker para recepción de hojas de respuesta',79,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (226,'Encuestas para cursos Preicfes ',80,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (227,'Portafolio de Servicio',81,1,1,true,'NULL',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (228,'Módulo 1 S+D',82,1,1,true,'S+DM1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (229,'Módulo 2 S+D',82,1,2,true,'S+DM2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (230,'Módulo 3 S+D',82,1,3,true,'S+DM3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (231,'Módulo 4 S+D',82,1,4,true,'S+DM4',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (232,'Módulo 5 S+D',82,1,5,true,'S+DM5',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (233,'Módulo 6 S+D',82,2,6,true,'S+DM6',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (234,'Módulo 7 S+D',82,2,7,true,'S+DM7',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (235,'Módulo 8 S+D',82,2,8,true,'S+DM8',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (236,'Módulo 9 S+D',82,2,9,true,'S+DM9',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (237,'Módulo 10 S+D',82,2,10,true,'S+DM10',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (238,'Módulo 11 S+D',82,3,11,true,'S+DM11',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (239,'Módulo 12 S+D',82,3,12,true,'S+DM12',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (240,'Módulo 13 S+D',82,3,13,true,'S+DM13',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (241,'Módulo 14 S+D',82,3,14,true,'S+DM14',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (242,'Módulo 15 S+D',82,3,15,true,'S+DM15',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (243,'Módulo 16 S+D',82,4,16,true,'S+DM16',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (244,'Módulo 17 S+D',82,4,17,true,'S+DM17',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (245,'Módulo 18 S+D',82,4,18,true,'S+DM18',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (246,'Módulo 19 S+D',82,4,19,true,'S+DM19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (247,'Módulo 20 S+D',82,4,20,true,'S+DM20',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (248,'Prueba No 1 Virtual',83,1,1,true,'MP1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (249,'Prueba No 2 Virtual',83,1,2,true,'MP2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (250,'Prueba No 3 Virtual',83,1,3,true,'MP3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (251,'Prueba No 4 Virtual',83,1,4,true,'MP4',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (252,'Prueba No 5 Virtual',83,1,5,true,'MP5',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (253,'Prueba No 6 Virtual',83,2,6,true,'MP6',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (254,'Prueba No 7 Virtual',83,2,7,true,'MP7',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (255,'Prueba No 8 Virtual',83,2,8,true,'MP8',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (256,'Prueba No 9 Virtual',83,2,9,true,'MP9',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (257,'Prueba No 10 Virtual',83,2,10,true,'MP10',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (258,'Prueba No 11 Virtual',83,3,11,true,'MP11',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (259,'Prueba No 12 Virtual',83,3,12,true,'MP12',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (260,'Prueba No 13 Virtual',83,3,13,true,'MP13',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (261,'Prueba No 14 Virtual',83,3,14,true,'MP14',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (262,'Prueba No 15 Virtual',83,3,15,true,'MP15',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (263,'Prueba No 16 Virtual',83,4,16,true,'MP16',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (264,'Prueba No 17 Virtual',83,4,17,true,'MP17',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (265,'Prueba No 18 Virtual',83,4,18,true,'MP18',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (266,'Prueba No 19 Virtual',83,4,19,true,'MP19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (267,'Prueba No 20 Virtual',83,4,20,true,'MP20',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (268,'Pensar 1 Virtual',84,1,1,true,'PNS1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (269,'Pensar 2 Virtual',84,1,2,true,'PNS2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (270,'Pensar 3 Virtual',84,1,3,true,'PNS3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (271,'Pensar 4 Virtual',84,1,4,true,'PNS4',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (272,'PD19 Virtual',86,1,1,true,'PD19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (273,'PS19 Virtual',86,1,2,true,'PS19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (274,'PF19 Virtual',86,1,3,true,'PF19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (275,'Simulacro H11 Virtual',85,1,38,true,'H11',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (276,'Simulacro H12 Virtual',85,1,37,true,'H12',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (277,'Simulacro H13 Virtual',85,1,24,true,'H13',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (278,'Simulacro CD19 Virtual',85,1,39,true,'CD19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (279,'Simulacro CS19 Virtual',85,1,40,true,'CS19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (280,'Simulacro CF19 Virtual',85,1,64,true,'CF19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (281,'Simulacro LC Básico Virtual',88,1,90,true,'LCB',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (282,'Simulacro LC Intermedio Virtual',88,1,91,true,'LCI',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (283,'Simulacro LC Avanzado Virtual',88,2,92,true,'LCA',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (284,'Ciudadanas 1 Virtual',87,1,1,true,'CIU1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (285,'Ciudadanas 2 Virtual',87,2,2,true,'CIU2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (286,'Ciudadanas 3 Virtual',87,3,3,true,'CIU3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (287,'Ciudadanas 4 Virtual',87,4,4,true,'CIU4',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (288,'Prueba No 1',89,1,1,true,'MPG1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (289,'Prueba No 2',89,1,2,true,'MPG2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (290,'Prueba No 3',89,1,3,true,'MPG3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (291,'Prueba No 4',89,1,4,true,'MPG4',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (292,'Prueba No 5',89,1,5,true,'MPG5',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (293,'Prueba No 1 Virtual',90,1,1,true,'MPGV1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (294,'Prueba No 2 Virtual',90,1,2,true,'MPGV2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (295,'Prueba No 3 Virtual',90,1,3,true,'MPGV3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (296,'Prueba No 4 Virtual',90,1,4,true,'MPGV4',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (297,'Prueba No 5 Virtual',90,1,5,true,'MPGV5',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (298,'Simulacro GO1',1,1,19,true,'GO1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (299,'Simulacro GO2',1,1,20,true,'GO2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (300,'Simulacro GO3',1,1,21,true,'GO3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (301,'Simulacro AR1',70,1,13,true,'AR1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (302,'Simulacro AR2',70,1,14,true,'AR2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (303,'Simulacro AR3',70,1,15,true,'AR3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (304,'Simulacro GO1 Virtual',85,1,65,true,'GO1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (305,'Simulacro GO2 Virtual',85,1,66,true,'GO2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (306,'Simulacro GO3 Virtual',85,1,67,true,'GO3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (307,'Simulacro AR1 Virtual',86,1,4,true,'AR1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (308,'Simulacro AR2 Virtual',86,1,5,true,'AR2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (309,'Simulacro AR3 Virtual',86,1,6,true,'AR3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (310,'Aplicación Lenguaje 1 Virtual',91,1,1,true,'SBL1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (311,'Aplicación Matemáticas 1 Virtual',91,1,2,true,'SBM1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (312,'Aplicación Lenguaje 2 Virtual',91,2,3,true,'SBL2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (313,'Aplicación Matemáticas 2 Virtual',91,2,4,true,'SBM2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (314,'Aplicación Lenguaje 3 Virtual',91,3,5,true,'SBL3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (315,'Aplicación Matemáticas 3 Virtual',91,3,6,true,'SBM3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (316,'Aplicación Lenguaje 1',16,1,1,true,'SBL1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (317,'Aplicación Matemáticas 1',16,1,2,true,'SBM1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (318,'Aplicación Lenguaje 2',16,2,3,true,'SBL2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (319,'Aplicación Matemáticas 2',16,2,4,true,'SBM2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (320,'Aplicación Lenguaje 3 ',16,3,5,true,'SBL3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (321,'Aplicación Matemáticas 3',16,3,6,true,'SBM3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (322,'Horas Clase Pre-ICFES Virtual',96,1,1,true,'HCPVIR',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (323,'Nivel 1',100,1,1,true,'N1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (324,'Nivel 2',100,1,2,true,'N2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (325,'Nivel 3',100,1,3,true,'N3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (326,'Nivel 4',100,1,4,true,'N4',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (327,'Nivel 5',100,1,5,true,'N5',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (328,'Nivel 6',100,1,6,true,'N6',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (329,'Nivel 7',100,1,7,true,'N7',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (330,'Nivel 8',100,1,8,true,'N8',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (331,'Nivel 9',100,1,9,true,'N9',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (332,'Nivel 10',100,1,10,true,'N10',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (333,'Nivel 11',100,1,11,true,'N11',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (334,'Nivel 12',100,1,12,true,'N12',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (335,'Nivel 13',100,1,13,true,'N13',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (336,'Nivel 14',100,1,14,true,'N14',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (337,'Simulacro CENA1',85,1,68,true,'CENA1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (338,'Aplicación Ciencias 1',16,1,7,true,'SBC1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (339,'Aplicación Ciencias 2',16,2,8,true,'SBC2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (340,'Aplicación Ciencias 3',16,3,9,true,'SBC3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (341,'Aplicación Ciencias 1 Virtual',91,1,7,true,'SBC1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (342,'Aplicación Ciencias 2 Virtual',91,2,8,true,'SBC2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (343,'Aplicación Ciencias 3 Virtual',91,3,9,true,'SBC3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (344,'Prueba No 6 Virtual',90,2,6,true,'MPGV6',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (345,'Prueba No 7 Virtual',90,2,7,true,'MPGV7',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (346,'Prueba No 8 Virtual',90,2,8,true,'MPGV8',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (347,'Prueba No 9 Virtual',90,2,9,true,'MPGV9',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (348,'Prueba No 10 Virtual',90,2,10,true,'MPGV10',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (349,'Prueba No 11 Virtual ',90,3,11,true,'MPGV11',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (350,'Prueba No 12 Virtual',90,3,12,true,'MPGV12',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (351,'Prueba No 13 Virtual',90,3,13,true,'MPGV13',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (352,'Prueba No 14 Virtual',90,3,14,true,'MPGV14',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (353,'Prueba No 15 Virtual',90,3,15,true,'MPGV15',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (354,'Prueba No 16 Virtual',90,4,16,true,'MPGV16',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (355,'Prueba No 17 Virtual',90,4,17,true,'MPGV17',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (356,'Prueba No 18 Virtual',90,4,18,true,'MPGV18',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (357,'Prueba No 19 Virtual',90,4,19,true,'MPGV19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (358,'Prueba No 20 Virtual',90,4,20,true,'MPGV20',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (359,'Prueba No 6',89,2,6,true,'MPG6',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (360,'Prueba No 7',89,2,7,true,'MPG7',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (361,'Prueba No 8',89,2,8,true,'MPG8',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (362,'Prueba No 9',89,2,9,true,'MPG9',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (363,'Prueba No 10',89,2,10,true,'MPG10',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (364,'Prueba No 11',89,3,11,true,'MPG11',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (365,'Prueba No 12',89,3,12,true,'MPG12',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (366,'Prueba No 13',89,3,13,true,'MPG13',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (367,'Prueba No 14',89,3,14,true,'MPG14',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (368,'Prueba No 15',89,3,15,true,'MPG15',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (369,'Prueba No 16',89,4,16,true,'MPG16',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (370,'Prueba No 17',89,4,17,true,'MPG17',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (371,'Prueba No 18',89,4,18,true,'MPG18',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (372,'Prueba No 19',89,4,19,true,'MPG19',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (373,'Prueba No 20',89,4,20,true,'MPG20',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (374,'Aplicación Ciencias Sociales 1',16,1,10,true,'SBCS1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (375,'Aplicación Ciencias Sociales 2',16,1,11,true,'SBCS2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (376,'Aplicación Ciencias Sociales 3',16,1,12,true,'SBCS3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (377,'Libro grado 1°',101,1,1,true,'LBG1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (378,'Libro grado 2°',101,1,2,true,'LBG2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (379,'Libro grado 3°',101,1,3,true,'LBG3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (380,'Libro grado 4°',101,1,4,true,'LBG4',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (381,'Libro grado 5°',101,1,5,true,'LBG5',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (382,'Libro grado 6°',101,1,6,true,'LBG6',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (383,'Libro grado 7°',101,1,7,true,'LBG7',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (384,'Libro grado 8°',101,1,8,true,'LBG8',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (385,'Libro grado 9°',101,1,9,true,'LBG9',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (386,'Libro grado 10°',101,1,10,true,'LBG10',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (387,'Libro grado 11°',101,1,11,true,'LBG11',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (388,'SB - Aplicación 1',16,1,13,true,'SB1',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (389,'SB - Aplicación 2',16,1,14,true,'SB2',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (390,'SB - Aplicación 3',16,1,15,true,'SB3',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (391,'SABERes11 104-23',2,1,1,true,'LSB11_23',CURRENT_TIMESTAMP);
INSERT INTO public.materialtypes(id,name,category_id,cycle,orderoflist,is_active,alias,created_at) VALUES (392,'Horas Clases Pre-Unal (Horas Clases Pre-Unal)',67,1,1,true,'HCPU',CURRENT_TIMESTAMP);

