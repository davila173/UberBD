 
------ CREACION DE TABLAS ------

CREATE TABLE CLIENTES
(
    ID INTEGER PRIMARY KEY NOT NULL,
    NOMBRES VARCHAR2(255) NULL,
    APELLIDOS VARCHAR2(255) NULL,
    FOTO VARCHAR2(255),
    CORREO VARCHAR2(255) NULL,
    CELULAR VARCHAR2(255) NULL,
    USUARIO VARCHAR2(255) NULL,
    CONTRASENA VARCHAR2(255) NULL,
    CODIGO_INVITADO VARCHAR2(255) NULL,
    IDIOMA_ID INTEGER NOT NULL,
    CIUDAD_ID INTEGER NOT NULL
);

CREATE TABLE MEDIOS_PAGO
(
    ID INTEGER PRIMARY KEY NOT NULL,
    DESCRIPCION VARCHAR2(255) NULL
);

CREATE TABLE SERVICIOS
(
    ID INTEGER PRIMARY KEY NOT NULL,
    FECHA VARCHAR2(255) NOT NULL,
    HORA VARCHAR2(255) NOT NULL,
    DISTANCIA DECIMAL (*,2) NULL,
    TIEMPO_REQUERIDO INTEGER NULL,
    DIRECCION_ORIGEN VARCHAR2(255) NULL,
    DIRECCION_DESTINO VARCHAR2(255) NULL,
    TARIFA DECIMAL (*,2) NULL,
    ESTADO VARCHAR2 (255) NULL,
    TARIFA_DINAMICA VARCHAR2(1) CHECK ((TARIFA_DINAMICA = 'V') OR (TARIFA_DINAMICA = 'F')),
    MEDIO_PAGO_ID INTEGER NOT NULL,
    CONDUCTOR_ID INTEGER NOT NULL,
    VEHICULO_ID INTEGER NOT NULL,
    CLIENTE_ID INTEGER NOT NULL,
    SERVICIO_COMPARTIDO_CLIENTE_ID INTEGER NULL
);

CREATE TABLE VEHICULOS
(
    ID INTEGER PRIMARY KEY NOT NULL,
    PLACA VARCHAR2(255) NULL,
    MARCA VARCHAR2(255) NULL,
    LINEA VARCHAR2(255) NULL,
    MODELO VARCHAR2(255) NULL,
    TIPO_SERVICIO VARCHAR2(255) CHECK(TIPO_SERVICIO IN ('UberX','Uber Black'))
);

CREATE TABLE CONDUCTORES_VEHICULOS
(
    ID INTEGER PRIMARY KEY NOT NULL,
    CONDUCTOR_ID INTEGER NOT NULL,
    VEHICULO_ID INTEGER NOT NULL
);

CREATE TABLE DETALLES_UBICACION_SERVICIOS
(
    ID INTEGER PRIMARY KEY NOT NULL,
    LATITUD VARCHAR2(255) NULL,
    LONGITUD VARCHAR2(255) NULL,
    SERVICIO_ID INTEGER NOT NULL
);

CREATE TABLE CLIENTES_EMPRESAS
(
    ID INTEGER PRIMARY KEY NOT NULL,
    CLIENTE_ID INTEGER NOT NULL,
    EMPRESA_ID INTEGER NOT NULL
);

CREATE TABLE FACTURAS
(
    ID INTEGER PRIMARY KEY NOT NULL,
    FECHA DATE,
    NUMERO INTEGER,
    SERVICIO_ID INTEGER NOT NULL
);
  
CREATE TABLE IDIOMAS 
(
    ID INTEGER PRIMARY KEY NOT NULL,
    DESCRIPCION VARCHAR2(255) NULL,
    ABREVIATURA VARCHAR2(255) NULL
);

CREATE TABLE PAISES 
(
    ID INTEGER PRIMARY KEY NOT NULL,
    NOMBRE VARCHAR2(255) NULL,
    MONEDA VARCHAR2(255)NULL,
    INDICATIVO VARCHAR2(255) NULL
);
 
CREATE TABLE CIUDADES
(
    ID INTEGER PRIMARY KEY NOT NULL,
    NOMBRE VARCHAR2(255) NULL,
    CODIGO_POSTAL VARCHAR2(255) NULL,
    PAIS_ID INTEGER NOT NULL
);
 
CREATE TABLE CLIENTES_MEDIOS_PAGO 
(
    ID INTEGER PRIMARY KEY NOT NULL,
    CLIENTE_ID INTEGER NOT NULL,
    MEDIO_PAGO_ID INTEGER NOT NULL,
    ENVIAR_CORREO VARCHAR2(1) CHECK ((ENVIAR_CORREO = 'V') OR (ENVIAR_CORREO = 'F')) NULL 
);
 
CREATE TABLE CODIGOS_PROMOCIONALES 
(
    ID INTEGER PRIMARY KEY NOT NULL,
    CODIGO VARCHAR2(255) NULL,
    CLIENTE_ID INTEGER NOT NULL
);

CREATE TABLE CONDUCTORES 
(
    ID INTEGER PRIMARY KEY NOT NULL,
    CEDULA VARCHAR2(255) NULL,
    NOMBRES VARCHAR2(255) NULL,
    APELIDOS VARCHAR2(255) NULL,
    FOTO VARCHAR2(255) NULL,
    CORREO VARCHAR2(255) NULL,
    CELULAR VARCHAR2(255) NULL,
    NUMERO_CUENTA VARCHAR2(255) NOT NULL,
    ENTIDAD_BANCARIA VARCHAR2(255)NOT NULL,
    IDIOMA_ID INTEGER NOT NULL,
    CIUDAD_ID INTEGER NOT NULL
);
 
CREATE TABLE EMPRESAS 
(
    ID INTEGER PRIMARY KEY NOT NULL,
    NIT VARCHAR2(255) NULL,
    NOMBRE VARCHAR2(255) NULL,
    DIRECCION VARCHAR2(255) NULL,
    TELEFONO VARCHAR2(255) NULL,
    CORREO VARCHAR2(255) NULL
);

CREATE TABLE EMPRESAS_MEDIOS_PAGO 
(
    ID INTEGER PRIMARY KEY NOT NULL,
    EMPRESA_ID INTEGER NOT NULL,
    MEDIO_PAGO_ID INTEGER NOT NULL
);

CREATE TABLE DETALLES_FACTURAS 
(
    ID INTEGER PRIMARY KEY NOT NULL,
    IVA DECIMAL (*,2),
    COMISION_UBER DECIMAL (*,2) DEFAULT 0.34,
    PROPINAS DECIMAL (*,2),
    HONORARIOS DECIMAL (*,2),
    REGARGOS DECIMAL (*,2),
    PEAJES DECIMAL (*,2),
    SUB_TOTAL DECIMAL (*,2),
    TOTAL DECIMAL (*,2),
    FACTURA_ID INTEGER NOT NULL
);

CREATE TABLE DETALLES_MEDIOS_PAGO
(
    ID INTEGER PRIMARY KEY NOT NULL,
    FRANQUICIA VARCHAR2(255) NULL,
    FECHA_EXPIRACION VARCHAR2(255) NULL,
    NUMERO_TARJETA VARCHAR2(255) NULL,
    CODIGO_CVV VARCHAR2(255) NULL,
    ENTIDAD_BANCARIA VARCHAR2(255) NULL,
    MEDIO_PAGO_ID INTEGER NOT NULL
);


--SE CREA LA SCUENCIA PARA DAR CONTROL A LA NUMERACION DE LA FACTURACION
CREATE SEQUENCE AGENCIES_SEQ
START WITH 1
INCREMENT BY 1
NOCYCLE;


------ CARDINALIDADES ------

--TABLA CLIENTES
ALTER TABLE CLIENTES
    ADD CONSTRAINT FK_CLIENTE_IDIOMA FOREIGN KEY (IDIOMA_ID) REFERENCES IDIOMAS (ID);
ALTER TABLE CLIENTES
    ADD CONSTRAINT FK_CLIENTE_CIUDAD FOREIGN KEY (CIUDAD_ID) REFERENCES CIUDADES (ID);
        
--TABLA SERVICIOS
ALTER TABLE SERVICIOS
    ADD CONSTRAINT FK_SERVICIO_MEDIO_PAGO FOREIGN KEY (MEDIO_PAGO_ID) REFERENCES MEDIOS_PAGO (ID);
ALTER TABLE SERVICIOS    
    ADD CONSTRAINT FK_SERVICIO_CONDUCTOR FOREIGN KEY (CONDUCTOR_ID) REFERENCES CONDUCTORES (ID);
ALTER TABLE SERVICIOS    
    ADD CONSTRAINT FK_SERVICIO_VEHICULO FOREIGN KEY (VEHICULO_ID) REFERENCES VEHICULOS (ID);
ALTER TABLE SERVICIOS     
    ADD CONSTRAINT FK_SERVICIO_CLIENTE FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTES (ID);
ALTER TABLE SERVICIOS     
    ADD CONSTRAINT FK_SERVICIO_COMPARTIDO_CLIENTE FOREIGN KEY (SERVICIO_COMPARTIDO_CLIENTE_ID) REFERENCES CLIENTES (ID);
    
--TABLA CONDUCTORES_VEHICULOS
ALTER TABLE CONDUCTORES_VEHICULOS
    ADD CONSTRAINT FK_CONDUCTOR_VEHICULO_CONDUCTO FOREIGN KEY (CONDUCTOR_ID) REFERENCES CONDUCTORES (ID);
ALTER TABLE CONDUCTORES_VEHICULOS
    ADD CONSTRAINT FK_CONDUCTOR_VEHICULO_VEHICULO FOREIGN KEY (VEHICULO_ID) REFERENCES VEHICULOS (ID);
    
--TABLA DETALLES_UBICACION_SERVICIOS
 ALTER TABLE DETALLES_UBICACION_SERVICIOS
    ADD CONSTRAINT FK_DETALLES_UBICACION_SERVICIO FOREIGN KEY (SERVICIO_ID) REFERENCES SERVICIOS (ID);
    
--TABLA CLIENTES_EMPRESAS
ALTER TABLE CLIENTES_EMPRESAS
    ADD CONSTRAINT FK_CLIENTES_EMPRESAS_CLIENTE FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTES (ID);
 ALTER TABLE CLIENTES_EMPRESAS    
    ADD CONSTRAINT FK_CLIENTES_EMPRESASA_EMPESA FOREIGN KEY (EMPRESA_ID) REFERENCES EMPRESAS (ID);
    
 --TABLA FACTURAS
 ALTER TABLE FACTURAS
    ADD CONSTRAINT FK_FACTURAS_SERVICIO FOREIGN KEY (SERVICIO_ID) REFERENCES SERVICIOS (ID);   
    
-- TABLA CIUDADES
ALTER TABLE CIUDADES
    ADD CONSTRAINT FK_CIUDAD_PAIS FOREIGN KEY (PAIS_ID) REFERENCES PAISES (ID);    
    
--TABLA CLIENTES_MEDIOS_PAGO 
ALTER TABLE CLIENTES_MEDIOS_PAGO
    ADD CONSTRAINT FK_CLIENTE_MEDIO_PAGO_CLIENTE FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTES (ID);
ALTER TABLE CLIENTES_MEDIOS_PAGO    
    ADD CONSTRAINT FK_CLIENTE_MEDIO_PAGO FOREIGN KEY (MEDIO_PAGO_ID) REFERENCES MEDIOS_PAGO (ID);
    
--TABLA CODIGOS_PROMOCIONALES 
ALTER TABLE CODIGOS_PROMOCIONALES
    ADD CONSTRAINT FK_COD_PROMOCIONALES_CLIENTE FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTES (ID); 
    
--TABLA CONDUCTORES
ALTER TABLE CONDUCTORES
    ADD CONSTRAINT FK_CONDUCTOR_IDIOMA FOREIGN KEY (IDIOMA_ID) REFERENCES IDIOMAS (ID); 
ALTER TABLE CONDUCTORES
    ADD CONSTRAINT FK_CONDUCTORES_CIUDAD FOREIGN KEY (CIUDAD_ID) REFERENCES CIUDADES (ID);  
    
--TABLA EMPRESAS_MEDIOS_PAGO
ALTER TABLE EMPRESAS_MEDIOS_PAGO
    ADD CONSTRAINT FK_MEDIOS_PAGO_EMPRESAS FOREIGN KEY (EMPRESA_ID) REFERENCES EMPRESAS (ID); 
ALTER TABLE EMPRESAS_MEDIOS_PAGO
    ADD CONSTRAINT FK_MEDIOS_PAGO_MEDIOPAGO FOREIGN KEY (MEDIO_PAGO_ID) REFERENCES MEDIOS_PAGO (ID);  
    
--TABLA DETALLES_MEDIOS_PAGO    
ALTER TABLE DETALLES_MEDIOS_PAGO
    ADD CONSTRAINT FK_MEDIOS_PAGO_DETALLE FOREIGN KEY (MEDIO_PAGO_ID) REFERENCES MEDIOS_PAGO (ID); 
    
--TABLA DETALLES_FACTURAS   
ALTER TABLE DETALLES_FACTURAS
    ADD CONSTRAINT FK_DETALLES_FACTURA FOREIGN KEY (FACTURA_ID) REFERENCES FACTURAS (ID); 


------ INSERCION DE INFORMACION ------

--CLIENTES

insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (1, 'Allsun', 'Boxer', 'http://dummyimage.com/224x108.png/dddddd/000000', 'aboxer0@infoseek.co.jp', '463-479-3291', 'aboxer0', 'N8X19EFuhlGg', '54973-3084', 501, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (2, 'Alyson', 'Cheesworth', 'http://dummyimage.com/221x167.bmp/cc0000/ffffff', 'acheesworth1@columbia.edu', '239-282-0793', 'acheesworth1', 'UIjlVmFJvb', '55648-422', 502, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (3, 'Camala', 'Count', 'http://dummyimage.com/225x242.jpg/dddddd/000000', 'ccount2@loc.gov', '824-931-4945', 'ccount2', 'H1RoXWY', '43269-853', 503, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (4, 'Bessie', 'Ovanesian', 'http://dummyimage.com/139x196.jpg/dddddd/000000', 'bovanesian3@lycos.com', '517-463-5869', 'bovanesian3', 'Een7i5Jy', '58599-004', 504, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (5, 'Peter', 'Budge', 'http://dummyimage.com/238x147.bmp/cc0000/ffffff', 'pbudge4@nps.gov', '626-977-7605', 'pbudge4', 'jh9mzl3N6AD', '41250-271', 505, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (6, 'Cami', 'Stevings', 'http://dummyimage.com/204x125.jpg/cc0000/ffffff', 'cstevings5@csmonitor.com', '486-490-2624', 'cstevings5', 'wPrB7Pa', '68001-231', 506, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (7, 'Craggy', 'Dmitrievski', 'http://dummyimage.com/148x241.jpg/ff4444/ffffff', 'cdmitrievski6@liveinternet.ru', '630-345-0500', 'cdmitrievski6', 'vmunJHNbUz', '0363-4009', 501, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (8, 'Kendra', 'Andreev', 'http://dummyimage.com/217x133.jpg/cc0000/ffffff', 'kandreev7@linkedin.com', '199-823-8281', 'kandreev7', 'Og0x33A8', '60505-0813', 502, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (9, 'Jesselyn', 'Darnborough', 'http://dummyimage.com/210x158.bmp/ff4444/ffffff', 'jdarnborough8@nytimes.com', '507-490-3041', 'jdarnborough8', 'rVi0zCnGVp', '10144-594', 503, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (10, 'Elonore', 'Thunnerclef', 'http://dummyimage.com/182x101.jpg/ff4444/ffffff', 'ethunnerclef9@washingtonpost.com', '880-867-4104', 'ethunnerclef9', 'j3H8br', '50436-6590', 504, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (11, 'Melony', 'Labat', 'http://dummyimage.com/203x183.bmp/ff4444/ffffff', 'mlabata@yandex.ru', '711-781-7508', 'mlabata', 'jD4gtmqh', '44946-1035', 505, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (12, 'Kendall', 'Walcher', 'http://dummyimage.com/186x250.jpg/5fa2dd/ffffff', 'kwalcherb@comsenz.com', '303-622-3771', 'kwalcherb', '8TB6TbV', '0574-2003', 506, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (13, 'Athena', 'Griswood', 'http://dummyimage.com/223x147.png/ff4444/ffffff', 'agriswoodc@constantcontact.com', '412-319-8507', 'agriswoodc', 'AitpEMUtu', '11673-259', 501, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (14, 'Melanie', 'Smaridge', 'http://dummyimage.com/222x169.png/dddddd/000000', 'msmaridged@moonfruit.com', '428-532-6778', 'msmaridged', 'Wb2BVEpO8', '63776-653', 502, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (15, 'Kory', 'Broadwell', 'http://dummyimage.com/126x164.bmp/ff4444/ffffff', 'kbroadwelle@goo.ne.jp', '404-808-3947', 'kbroadwelle', 'EtMiGhpAlnS0', '65044-4856', 503, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (16, 'Lethia', 'Attack', 'http://dummyimage.com/119x152.jpg/dddddd/000000', 'lattackf@ucla.edu', '936-699-3822', 'lattackf', 'xEPbIrAJUCzq', '49288-0928', 504, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (17, 'Manya', 'Baccup', 'http://dummyimage.com/153x166.jpg/dddddd/000000', 'mbaccupg@cloudflare.com', '811-664-8659', 'mbaccupg', 'y0aQwEzE', '54868-3384', 505, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (18, 'Lissi', 'Caunter', 'http://dummyimage.com/233x234.png/ff4444/ffffff', 'lcaunterh@hibu.com', '188-224-2305', 'lcaunterh', 'BuNb8XtK', '62011-0036', 506, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (19, 'Keri', 'Desborough', 'http://dummyimage.com/230x109.jpg/5fa2dd/ffffff', 'kdesboroughi@nsw.gov.au', '857-192-1460', 'kdesboroughi', 'tVyhNoOLia', '43353-837', 501, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (20, 'Ashly', 'Elliss', 'http://dummyimage.com/232x201.jpg/ff4444/ffffff', 'aellissj@behance.net', '987-817-6824', 'aellissj', 'rtVJ7O0R', '53808-0243', 502, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (21, 'Cassi', 'Vahey', 'http://dummyimage.com/146x226.png/5fa2dd/ffffff', 'cvaheyk@techcrunch.com', '490-639-3021', 'cvaheyk', 'Slq0aNVD', '35356-810', 503, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (22, 'Amitie', 'Paramore', 'http://dummyimage.com/152x203.jpg/ff4444/ffffff', 'aparamorel@blogtalkradio.com', '607-943-1747', 'aparamorel', 'ZAWKeFn9J7', '60429-113', 504, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (23, 'Diane-marie', 'Yven', 'http://dummyimage.com/138x145.bmp/dddddd/000000', 'dyvenm@bloglines.com', '741-322-7654', 'dyvenm', 'IbFKgT', '60760-914', 505, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (24, 'Patrice', 'Hamlyn', 'http://dummyimage.com/250x128.jpg/dddddd/000000', 'phamlynn@vk.com', '159-794-6714', 'phamlynn', 'xv8XM7ECHWcH', '55924-2001', 506, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (25, 'Eran', 'Bathowe', 'http://dummyimage.com/135x177.jpg/cc0000/ffffff', 'ebathoweo@netscape.com', '532-391-6876', 'ebathoweo', 'atu0EBJZj', '40104-002', 501, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (26, 'Arlin', 'Franceschelli', 'http://dummyimage.com/230x109.jpg/dddddd/000000', 'afranceschellip@plala.or.jp', '265-288-3572', 'afranceschellip', 'Uz1jmEA8', '50436-7601', 502, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (27, 'Felic', 'Proffer', 'http://dummyimage.com/153x225.png/dddddd/000000', 'fprofferq@webeden.co.uk', '342-544-3306', 'fprofferq', 'wN8Cq7L2CP6', '55154-5540', 503, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (28, 'Glen', 'Yea', 'http://dummyimage.com/157x129.png/5fa2dd/ffffff', 'gyear@ucla.edu', '637-404-6523', 'gyear', 'CtElYQWoP2W', '63354-126', 504, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (29, 'Shara', 'Rikkard', 'http://dummyimage.com/117x229.jpg/dddddd/000000', 'srikkards@dedecms.com', '280-200-1355', 'srikkards', 'WZXeBFZdSOR', '64679-781', 505, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (30, 'Leonanie', 'Mourant', 'http://dummyimage.com/105x217.png/5fa2dd/ffffff', 'lmourantt@networkadvertising.org', '105-471-4200', 'lmourantt', 'Dr1ak68J', '40032-121', 506, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (31, 'Greggory', 'Gatheral', 'http://dummyimage.com/238x112.jpg/cc0000/ffffff', 'ggatheralu@blogs.com', '690-243-7610', 'ggatheralu', 'VxseA6DdFt', '0603-1520', 501, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (32, 'Feodor', 'Keates', 'http://dummyimage.com/144x166.png/5fa2dd/ffffff', 'fkeatesv@dagondesign.com', '653-104-3582', 'fkeatesv', '3KbbqDxW0H', '58232-0059', 502, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (33, 'Graig', 'Iacovini', 'http://dummyimage.com/226x217.jpg/dddddd/000000', 'giacoviniw@slideshare.net', '618-792-0112', 'giacoviniw', 'lhj7aONT', '43269-675', 503, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (34, 'Toddie', 'Isack', 'http://dummyimage.com/215x167.bmp/cc0000/ffffff', 'tisackx@ftc.gov', '977-365-5276', 'tisackx', '4Pq0jllP', '0395-2685', 504, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (35, 'Bone', 'Durtnal', 'http://dummyimage.com/185x154.png/cc0000/ffffff', 'bdurtnaly@fema.gov', '863-117-7541', 'bdurtnaly', 'iYN4HS3', '60512-9058', 505, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (36, 'Chelsae', 'Perllman', 'http://dummyimage.com/120x114.png/5fa2dd/ffffff', 'cperllmanz@clickbank.net', '339-372-7274', 'cperllmanz', 'QRTCnNF', '76214-032', 506, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (37, 'Cecile', 'Darnborough', 'http://dummyimage.com/174x237.bmp/dddddd/000000', 'cdarnborough10@dailymotion.com', '739-847-0108', 'cdarnborough10', 'XhQwc6uqaM', '68645-140', 501, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (38, 'Barnard', 'Coupman', 'http://dummyimage.com/101x246.png/dddddd/000000', 'bcoupman11@slashdot.org', '930-465-1693', 'bcoupman11', 'Zz6Emsl', '21695-561', 502, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (39, 'Rebeca', 'Watsam', 'http://dummyimage.com/135x153.jpg/dddddd/000000', 'rwatsam12@sciencedaily.com', '465-672-6195', 'rwatsam12', '6dxwkxig4c4', '55154-5351', 503, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (40, 'Laurianne', 'Jeram', 'http://dummyimage.com/123x229.bmp/5fa2dd/ffffff', 'ljeram13@indiatimes.com', '953-654-5434', 'ljeram13', 'TCiJJBU', '10812-603', 504, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (41, 'Ev', 'Oxburgh', 'http://dummyimage.com/102x180.jpg/ff4444/ffffff', 'eoxburgh14@dailymail.co.uk', '385-284-3515', 'eoxburgh14', 'ifG0Ee9aKXSw', '61543-1758', 505, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (42, 'Kevan', 'Baysting', 'http://dummyimage.com/221x147.jpg/dddddd/000000', 'kbaysting15@discovery.com', '529-116-7385', 'kbaysting15', 'yChAYO0DCe9', '65162-574', 506, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (43, 'Myrvyn', 'Gormley', 'http://dummyimage.com/134x215.bmp/dddddd/000000', 'mgormley16@apache.org', '386-787-5356', 'mgormley16', 'aEj840gi', '41190-664', 501, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (44, 'Christen', 'Smalles', 'http://dummyimage.com/206x221.bmp/cc0000/ffffff', 'csmalles17@salon.com', '273-764-5148', 'csmalles17', '6kSy3Tkq3', '55513-002', 502, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (45, 'Demeter', 'Downie', 'http://dummyimage.com/128x148.bmp/ff4444/ffffff', 'ddownie18@istockphoto.com', '959-690-2506', 'ddownie18', 'Sc9XcqPK', '58831-1001', 503, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (46, 'Hattie', 'Canaan', 'http://dummyimage.com/136x221.jpg/5fa2dd/ffffff', 'hcanaan19@networksolutions.com', '214-190-8022', 'hcanaan19', 'eehWNycDF', '53808-0704', 504, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (47, 'Sibbie', 'Lower', 'http://dummyimage.com/181x158.jpg/cc0000/ffffff', 'slower1a@arstechnica.com', '222-847-5854', 'slower1a', 'grvV4rG1OEtC', '49349-981', 505, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (48, 'Ruthe', 'Gaine of England', 'http://dummyimage.com/176x101.jpg/dddddd/000000', 'rgaineofengland1b@prlog.org', '510-119-2998', 'rgaineofengland1b', 'WvXvXacI9W', '49967-279', 506, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (49, 'Ana', 'Joisce', 'http://dummyimage.com/220x174.jpg/cc0000/ffffff', 'ajoisce1c@mapquest.com', '924-295-7985', 'ajoisce1c', 'zU6osSHitM', '48951-3141', 501, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (50, 'Brina', 'Setterington', 'http://dummyimage.com/155x157.bmp/cc0000/ffffff', 'bsetterington1d@wired.com', '571-884-0800', 'bsetterington1d', 'lmdRyFvMhL', '57237-036', 502, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (51, 'Mil', 'Duding', 'http://dummyimage.com/192x138.jpg/5fa2dd/ffffff', 'mduding1e@spiegel.de', '454-730-4195', 'mduding1e', 'LgcJ87gvNO', '0555-9032', 503, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (52, 'Joella', 'Anyon', 'http://dummyimage.com/137x198.jpg/5fa2dd/ffffff', 'janyon1f@cnn.com', '865-461-3225', 'janyon1f', 'hDbPND', '52268-101', 504, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (53, 'Adria', 'Beckingham', 'http://dummyimage.com/245x240.jpg/5fa2dd/ffffff', 'abeckingham1g@scribd.com', '305-294-3626', 'abeckingham1g', 'ypIXX2yVh', '43846-0011', 505, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (54, 'Annabal', 'Di Pietro', 'http://dummyimage.com/188x131.png/dddddd/000000', 'adipietro1h@last.fm', '332-349-0278', 'adipietro1h', 'qJaDcvaF', '42998-964', 506, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (55, 'Mellie', 'Brenston', 'http://dummyimage.com/230x248.jpg/dddddd/000000', 'mbrenston1i@pbs.org', '511-584-4140', 'mbrenston1i', 'RB5Z2vnTJK8', '0603-5927', 501, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (56, 'Taffy', 'Blanque', 'http://dummyimage.com/146x235.png/cc0000/ffffff', 'tblanque1j@ed.gov', '536-937-9860', 'tblanque1j', 'mIJRWS2jsJ', '43353-393', 502, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (57, 'Eddie', 'Laker', 'http://dummyimage.com/193x132.bmp/ff4444/ffffff', 'elaker1k@sciencedaily.com', '210-107-1048', 'elaker1k', 'i9cQzc5m5a', '13107-060', 503, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (58, 'Tanitansy', 'Gai', 'http://dummyimage.com/164x140.png/5fa2dd/ffffff', 'tgai1l@tinyurl.com', '888-941-6165', 'tgai1l', 'YX00BM', '43857-0102', 504, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (59, 'Andie', 'Rachuig', 'http://dummyimage.com/109x228.bmp/5fa2dd/ffffff', 'arachuig1m@mtv.com', '362-817-4254', 'arachuig1m', 'iHwQNK', '65044-6690', 505, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (60, 'Ase', 'Sergison', 'http://dummyimage.com/216x240.jpg/ff4444/ffffff', 'asergison1n@altervista.org', '623-624-8745', 'asergison1n', '4VjfxqHxp', '0536-1011', 506, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (61, 'Karlotte', 'Hawsby', 'http://dummyimage.com/165x169.png/cc0000/ffffff', 'khawsby1o@posterous.com', '527-823-6844', 'khawsby1o', 'EZwFHGh', '24571-114', 501, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (62, 'Wendie', 'Bibby', 'http://dummyimage.com/224x201.png/5fa2dd/ffffff', 'wbibby1p@dagondesign.com', '867-667-7683', 'wbibby1p', 'WPg6RXbfhX', '49349-480', 502, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (63, 'Simone', 'Leslie', 'http://dummyimage.com/168x180.bmp/5fa2dd/ffffff', 'sleslie1q@dell.com', '659-887-2315', 'sleslie1q', 'wn0UD39BDVg', '53346-1201', 503, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (64, 'Marlane', 'Kurtis', 'http://dummyimage.com/245x105.jpg/dddddd/000000', 'mkurtis1r@cdbaby.com', '300-193-0773', 'mkurtis1r', 'WzSKRAjBrVis', '0378-4560', 504, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (65, 'Darla', 'Poltun', 'http://dummyimage.com/167x181.png/5fa2dd/ffffff', 'dpoltun1s@sfgate.com', '139-909-8934', 'dpoltun1s', 'Lm9hG9BKtOKa', '52125-440', 505, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (66, 'Vasily', 'Meeron', 'http://dummyimage.com/108x126.bmp/ff4444/ffffff', 'vmeeron1t@livejournal.com', '162-990-2347', 'vmeeron1t', '6siiUNOisM', '11822-0369', 506, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (67, 'Peggie', 'Lenchenko', 'http://dummyimage.com/143x199.jpg/5fa2dd/ffffff', 'plenchenko1u@hubpages.com', '134-463-1452', 'plenchenko1u', 'aMyRU5799dJ', '64159-6989', 501, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (68, 'Winny', 'Dubble', 'http://dummyimage.com/189x244.jpg/dddddd/000000', 'wdubble1v@360.cn', '310-643-5591', 'wdubble1v', '3ps9uO', '0179-0019', 502, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (69, 'Adey', 'Navein', 'http://dummyimage.com/175x210.bmp/ff4444/ffffff', 'anavein1w@fotki.com', '764-820-0511', 'anavein1w', '8YF31ERmdy', '49349-808', 503, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (70, 'Hiram', 'Mishaw', 'http://dummyimage.com/128x189.bmp/5fa2dd/ffffff', 'hmishaw1x@fema.gov', '687-778-3110', 'hmishaw1x', 'trsaoQF', '0310-0720', 504, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (71, 'Dasya', 'Whitington', 'http://dummyimage.com/224x213.png/cc0000/ffffff', 'dwhitington1y@seattletimes.com', '759-482-1565', 'dwhitington1y', '7KZd1J', '0409-4916', 505, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (72, 'Casandra', 'Raithbie', 'http://dummyimage.com/197x163.png/dddddd/000000', 'craithbie1z@springer.com', '659-906-6608', 'craithbie1z', 'cVDksPcXiGq', '59886-327', 506, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (73, 'Susannah', 'Babon', 'http://dummyimage.com/133x229.png/5fa2dd/ffffff', 'sbabon20@guardian.co.uk', '711-177-0739', 'sbabon20', '1WduzYh', '37000-211', 501, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (74, 'Trever', 'Vasler', 'http://dummyimage.com/154x216.png/5fa2dd/ffffff', 'tvasler21@netlog.com', '525-287-4428', 'tvasler21', 'ABKDvI2rhX', '54868-4733', 502, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (75, 'Mitzi', 'Bargh', 'http://dummyimage.com/200x247.jpg/cc0000/ffffff', 'mbargh22@amazon.co.uk', '922-530-0812', 'mbargh22', 'HeHa5Rs2KY4', '68428-102', 503, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (76, 'Genia', 'Neenan', 'http://dummyimage.com/250x133.jpg/5fa2dd/ffffff', 'gneenan23@vistaprint.com', '849-500-0195', 'gneenan23', 'tPLOQ1yjIOI', '68258-8905', 504, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (77, 'Milt', 'Goldhawk', 'http://dummyimage.com/141x107.png/5fa2dd/ffffff', 'mgoldhawk24@squarespace.com', '646-599-3817', 'mgoldhawk24', 'V2AmXFn7fVv', '0904-7912', 505, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (78, 'Sapphira', 'Luipold', 'http://dummyimage.com/196x218.jpg/cc0000/ffffff', 'sluipold25@google.com.br', '512-441-1180', 'sluipold25', 'wG1Z2lDP16', '55045-1266', 506, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (79, 'Sharl', 'Toohey', 'http://dummyimage.com/211x201.jpg/dddddd/000000', 'stoohey26@bravesites.com', '846-343-2525', 'stoohey26', 'BcFkxqO', '43547-277', 501, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (80, 'Jeanette', 'Eldritt', 'http://dummyimage.com/183x156.jpg/dddddd/000000', 'jeldritt27@usa.gov', '120-279-0699', 'jeldritt27', 'umWMkuV7yLx', '55758-003', 502, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (81, 'Halli', 'Mustill', 'http://dummyimage.com/140x167.bmp/ff4444/ffffff', 'hmustill28@ft.com', '525-322-1703', 'hmustill28', 'CGbZwYFj', '50804-252', 503, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (82, 'Rosana', 'Pittock', 'http://dummyimage.com/135x162.bmp/dddddd/000000', 'rpittock29@yelp.com', '459-256-1081', 'rpittock29', 'XBkgUBGKXWp', '51138-042', 504, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (83, 'Zonda', 'Hedley', 'http://dummyimage.com/150x134.jpg/cc0000/ffffff', 'zhedley2a@opera.com', '440-220-4202', 'zhedley2a', 'jG9eoOw', '0268-6178', 505, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (84, 'Zed', 'Mateev', 'http://dummyimage.com/106x203.jpg/dddddd/000000', 'zmateev2b@tripadvisor.com', '715-311-3056', 'zmateev2b', 'jGQKcdMr', '76439-102', 506, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (85, 'Ivonne', 'Boswell', 'http://dummyimage.com/194x153.jpg/dddddd/000000', 'iboswell2c@earthlink.net', '969-139-3658', 'iboswell2c', 'g3FdoB', '50436-3145', 501, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (86, 'Tannie', 'Wren', 'http://dummyimage.com/228x184.bmp/5fa2dd/ffffff', 'twren2d@prnewswire.com', '766-866-3729', 'twren2d', '5xghkZ2uu37w', '37000-010', 502, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (87, 'Raina', 'Habergham', 'http://dummyimage.com/227x180.png/dddddd/000000', 'rhabergham2e@macromedia.com', '274-742-9037', 'rhabergham2e', 'me16ISRrP', '55910-242', 503, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (88, 'Pavel', 'Acarson', 'http://dummyimage.com/123x120.png/5fa2dd/ffffff', 'pacarson2f@t-online.de', '750-169-4865', 'pacarson2f', 'KkcTIHYN7I', '60503-227', 504, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (89, 'Carolina', 'McAllan', 'http://dummyimage.com/205x118.png/cc0000/ffffff', 'cmcallan2g@vinaora.com', '963-752-3875', 'cmcallan2g', 'vQI47fNaUD2i', '59428-135', 505, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (90, 'Janenna', 'Kenwood', 'http://dummyimage.com/204x224.jpg/ff4444/ffffff', 'jkenwood2h@blinklist.com', '101-194-2360', 'jkenwood2h', 'U30Bxl', '54868-5524', 506, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (91, 'Hendrik', 'De Bruyn', 'http://dummyimage.com/146x119.jpg/ff4444/ffffff', 'hdebruyn2i@livejournal.com', '421-312-2654', 'hdebruyn2i', 'L7E5t1bOgCF', '51672-1349', 501, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (92, 'Ham', 'Constantinou', 'http://dummyimage.com/128x156.bmp/cc0000/ffffff', 'hconstantinou2j@businesswire.com', '272-799-8992', 'hconstantinou2j', 'tXlEyVA', '0378-7100', 502, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (93, 'Boris', 'Barendtsen', 'http://dummyimage.com/247x155.png/ff4444/ffffff', 'bbarendtsen2k@dedecms.com', '776-746-1249', 'bbarendtsen2k', 'Vgp4ygug', '0065-0652', 503, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (94, 'Wildon', 'Libbis', 'http://dummyimage.com/120x193.bmp/cc0000/ffffff', 'wlibbis2l@ebay.com', '173-445-7277', 'wlibbis2l', 'kcswdPRMSqTi', '15127-268', 504, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (95, 'Florette', 'Pennells', 'http://dummyimage.com/184x113.jpg/dddddd/000000', 'fpennells2m@netvibes.com', '999-555-1595', 'fpennells2m', 'tKBH27YSQD0K', '59900-211', 505, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (96, 'Quent', 'Docharty', 'http://dummyimage.com/246x132.bmp/cc0000/ffffff', 'qdocharty2n@nifty.com', '895-282-6803', 'qdocharty2n', 'iGvKEMjHktz4', '53150-315', 506, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (97, 'Sandie', 'Truswell', 'http://dummyimage.com/159x116.jpg/cc0000/ffffff', 'struswell2o@hao123.com', '499-795-8141', 'struswell2o', 'qNvaTYiW', '49288-0898', 501, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (98, 'Cordy', 'Jarret', 'http://dummyimage.com/125x159.jpg/ff4444/ffffff', 'cjarret2p@unc.edu', '729-120-3707', 'cjarret2p', 'ipAMifnw', '16590-947', 502, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (99, 'Garnet', 'Gaskamp', 'http://dummyimage.com/174x237.bmp/ff4444/ffffff', 'ggaskamp2q@netlog.com', '665-936-1504', 'ggaskamp2q', '6txDDWRyAJ', '51467-008', 503, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (100, 'Isadore', 'Tomini', 'http://dummyimage.com/163x211.bmp/5fa2dd/ffffff', 'itomini2r@google.ru', '664-282-1011', 'itomini2r', 'JmWTMXVFbo', '10144-427', 504, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (101, 'Barbabas', 'Littrick', 'http://dummyimage.com/216x129.png/5fa2dd/ffffff', 'blittrick2s@icio.us', '876-494-4837', 'blittrick2s', 'j7txk1qvmd', '49035-217', 505, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (102, 'Meryl', 'Flucker', 'http://dummyimage.com/155x134.png/dddddd/000000', 'mflucker2t@about.com', '546-239-9545', 'mflucker2t', '6OV47iXn', '47781-108', 506, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (103, 'Jerald', 'Asipenko', 'http://dummyimage.com/100x226.bmp/dddddd/000000', 'jasipenko2u@indiatimes.com', '483-702-5953', 'jasipenko2u', 'G3HMpmWap', '68788-9846', 501, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (104, 'Donn', 'Sink', 'http://dummyimage.com/208x188.png/cc0000/ffffff', 'dsink2v@com.com', '159-381-3191', 'dsink2v', 'Y0Nx5IzXL1aj', '41167-3301', 502, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (105, 'Taber', 'Mengo', 'http://dummyimage.com/224x238.bmp/cc0000/ffffff', 'tmengo2w@newyorker.com', '616-746-4547', 'tmengo2w', 'ZCj7LqeT', '65841-705', 503, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (106, 'Lukas', 'Impson', 'http://dummyimage.com/236x179.jpg/cc0000/ffffff', 'limpson2x@fda.gov', '405-240-4171', 'limpson2x', 'KuayAA', '63981-484', 504, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (107, 'Engracia', 'O''Doireidh', 'http://dummyimage.com/161x222.png/ff4444/ffffff', 'eodoireidh2y@timesonline.co.uk', '277-246-8995', 'eodoireidh2y', 'kqpCe1NOn', '0363-0555', 505, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (108, 'Cassie', 'Paridge', 'http://dummyimage.com/151x220.png/dddddd/000000', 'cparidge2z@is.gd', '185-292-6950', 'cparidge2z', '6hNkVBgXzW', '55312-468', 506, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (109, 'Myrtie', 'Skipsea', 'http://dummyimage.com/154x118.bmp/5fa2dd/ffffff', 'mskipsea30@answers.com', '474-438-4169', 'mskipsea30', 'jOhoGnx', '21695-826', 501, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (110, 'Becky', 'Schieferstein', 'http://dummyimage.com/160x142.bmp/dddddd/000000', 'bschieferstein31@hao123.com', '294-869-3566', 'bschieferstein31', 'mAQAnA', '40032-090', 502, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (111, 'Kristos', 'McLoney', 'http://dummyimage.com/231x237.jpg/5fa2dd/ffffff', 'kmcloney32@ask.com', '898-958-4487', 'kmcloney32', 'NcJ4xq61t', '10019-510', 503, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (112, 'Giacomo', 'Scothorne', 'http://dummyimage.com/180x197.png/ff4444/ffffff', 'gscothorne33@theguardian.com', '383-453-3773', 'gscothorne33', 'noIblVpa5', '54868-3046', 504, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (113, 'Corly', 'Jouanny', 'http://dummyimage.com/200x179.bmp/5fa2dd/ffffff', 'cjouanny34@homestead.com', '507-883-2229', 'cjouanny34', 'rMxxnF1o', '13537-608', 505, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (114, 'Lisle', 'Hazelby', 'http://dummyimage.com/199x228.jpg/dddddd/000000', 'lhazelby35@hhs.gov', '114-722-1441', 'lhazelby35', 'xdyp61sDxb', '52533-107', 506, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (115, 'Quinton', 'Gorsse', 'http://dummyimage.com/161x131.bmp/cc0000/ffffff', 'qgorsse36@google.ca', '471-352-6950', 'qgorsse36', 'sBiseDbY5Cpp', '65342-1381', 501, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (116, 'Ave', 'Slaymaker', 'http://dummyimage.com/139x210.jpg/dddddd/000000', 'aslaymaker37@prlog.org', '165-216-1934', 'aslaymaker37', 'd9cv7Qm', '63533-221', 502, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (117, 'Clayborne', 'Hadfield', 'http://dummyimage.com/141x157.png/5fa2dd/ffffff', 'chadfield38@themeforest.net', '222-687-5816', 'chadfield38', 'p6qRyRF', '37012-110', 503, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (118, 'Sonja', 'Huncote', 'http://dummyimage.com/165x198.png/5fa2dd/ffffff', 'shuncote39@epa.gov', '341-137-1145', 'shuncote39', 'gHGrakn46oF', '0168-0314', 504, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (119, 'Ase', 'Ahmed', 'http://dummyimage.com/159x186.png/ff4444/ffffff', 'aahmed3a@twitpic.com', '254-125-8989', 'aahmed3a', 'cPYdSouzpr', '48951-9010', 505, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (120, 'Joyan', 'Imison', 'http://dummyimage.com/159x223.bmp/5fa2dd/ffffff', 'jimison3b@chronoengine.com', '179-200-5516', 'jimison3b', 'F90Rh1xnbK1D', '0472-1255', 506, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (121, 'Lombard', 'Kryszka', 'http://dummyimage.com/125x205.png/dddddd/000000', 'lkryszka3c@geocities.jp', '604-299-4011', 'lkryszka3c', 'Dvq4pkS', '68703-045', 501, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (122, 'Eleni', 'Obey', 'http://dummyimage.com/158x164.png/dddddd/000000', 'eobey3d@goodreads.com', '422-637-4923', 'eobey3d', 'AR6PkD', '52584-795', 502, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (123, 'Hobey', 'Sudlow', 'http://dummyimage.com/120x114.png/ff4444/ffffff', 'hsudlow3e@ask.com', '167-908-9442', 'hsudlow3e', 'Czl2KQTu5', '30014-100', 503, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (124, 'Pia', 'Digle', 'http://dummyimage.com/182x103.png/ff4444/ffffff', 'pdigle3f@desdev.cn', '424-725-1675', 'pdigle3f', 'yOv2inuJzgu', '46123-027', 504, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (125, 'Carlita', 'Lurriman', 'http://dummyimage.com/158x133.jpg/cc0000/ffffff', 'clurriman3g@alexa.com', '801-767-1223', 'clurriman3g', 'itoEAh', '0603-0265', 505, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (126, 'Alvera', 'Sarjent', 'http://dummyimage.com/140x104.bmp/cc0000/ffffff', 'asarjent3h@themeforest.net', '399-375-4222', 'asarjent3h', 'g3RSB58KcSN', '53217-066', 506, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (127, 'Winonah', 'Findlater', 'http://dummyimage.com/128x179.bmp/ff4444/ffffff', 'wfindlater3i@mtv.com', '664-639-5488', 'wfindlater3i', 'z9onePwJbC', '49349-107', 501, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (128, 'Dodi', 'Mecco', 'http://dummyimage.com/128x233.png/ff4444/ffffff', 'dmecco3j@desdev.cn', '184-876-0152', 'dmecco3j', 'Pdfn6MFX6', '58232-4035', 502, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (129, 'Shandie', 'Beaument', 'http://dummyimage.com/244x132.png/ff4444/ffffff', 'sbeaument3k@bloomberg.com', '563-132-8734', 'sbeaument3k', 'zKYkAE', '0603-4211', 503, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (130, 'Bearnard', 'Keppel', 'http://dummyimage.com/171x243.bmp/5fa2dd/ffffff', 'bkeppel3l@github.com', '402-771-1893', 'bkeppel3l', 'WhxmOFlgS', '64942-1069', 504, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (131, 'Marji', 'Wannan', 'http://dummyimage.com/179x170.bmp/dddddd/000000', 'mwannan3m@lycos.com', '481-737-5594', 'mwannan3m', 'QA9i87', '51327-200', 505, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (132, 'Luis', 'Wills', 'http://dummyimage.com/245x130.png/5fa2dd/ffffff', 'lwills3n@rakuten.co.jp', '700-957-4020', 'lwills3n', '78nnYdO', '65954-007', 506, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (133, 'Toddie', 'Fife', 'http://dummyimage.com/111x121.png/cc0000/ffffff', 'tfife3o@baidu.com', '347-907-4256', 'tfife3o', 'tSJXJe', '61543-6087', 501, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (134, 'Hillie', 'Gerasch', 'http://dummyimage.com/180x212.jpg/dddddd/000000', 'hgerasch3p@1688.com', '831-482-0614', 'hgerasch3p', 'ZFVFUpFyk7O', '48951-4093', 502, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (135, 'Randolf', 'Chaffen', 'http://dummyimage.com/209x185.png/dddddd/000000', 'rchaffen3q@nhs.uk', '895-471-6110', 'rchaffen3q', '3yIcZV7S', '54473-151', 503, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (136, 'Aymer', 'Connick', 'http://dummyimage.com/168x127.bmp/dddddd/000000', 'aconnick3r@rambler.ru', '833-672-2689', 'aconnick3r', 'koXdM6ad', '0143-9888', 504, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (137, 'Arel', 'Dalyell', 'http://dummyimage.com/130x143.bmp/5fa2dd/ffffff', 'adalyell3s@scientificamerican.com', '125-675-9820', 'adalyell3s', 'fSXpdv8sgH', '55154-2434', 505, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (138, 'Goldia', 'Giffaut', 'http://dummyimage.com/186x111.bmp/5fa2dd/ffffff', 'ggiffaut3t@walmart.com', '727-849-3476', 'ggiffaut3t', 'BcDDgeNy2Tmi', '64942-1294', 506, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (139, 'Lynda', 'O'' Mulderrig', 'http://dummyimage.com/142x147.png/cc0000/ffffff', 'lomulderrig3u@rambler.ru', '166-217-1605', 'lomulderrig3u', 'CrPE7S803r', '55154-3197', 501, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (140, 'Selig', 'Donati', 'http://dummyimage.com/144x126.png/ff4444/ffffff', 'sdonati3v@yahoo.co.jp', '689-163-5279', 'sdonati3v', '7DVNxsdFbeUi', '0093-5290', 502, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (141, 'Claribel', 'Staddom', 'http://dummyimage.com/119x248.jpg/cc0000/ffffff', 'cstaddom3w@ocn.ne.jp', '537-969-1731', 'cstaddom3w', 'fT2qtC0NTn', '64764-155', 503, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (142, 'Fabiano', 'Fothergill', 'http://dummyimage.com/231x223.png/dddddd/000000', 'ffothergill3x@buzzfeed.com', '369-638-9113', 'ffothergill3x', '9u1gzg9ayeg', '59062-1303', 504, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (143, 'Gwenora', 'Whatmough', 'http://dummyimage.com/241x137.jpg/ff4444/ffffff', 'gwhatmough3y@elpais.com', '393-173-0006', 'gwhatmough3y', 'bbucz38aj', '0591-0503', 505, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (144, 'Sherm', 'Twidale', 'http://dummyimage.com/122x176.bmp/dddddd/000000', 'stwidale3z@hao123.com', '862-216-7347', 'stwidale3z', 'H66tBTprHOI1', '45865-342', 506, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (145, 'Brady', 'Weare', 'http://dummyimage.com/105x141.bmp/dddddd/000000', 'bweare40@go.com', '899-109-9589', 'bweare40', '0MLu78nE', '49349-647', 501, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (146, 'Gare', 'Shutle', 'http://dummyimage.com/156x125.png/cc0000/ffffff', 'gshutle41@ftc.gov', '335-646-1753', 'gshutle41', 'Otas6PWR', '36987-2002', 502, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (147, 'Arabella', 'Stubbington', 'http://dummyimage.com/204x240.jpg/5fa2dd/ffffff', 'astubbington42@vk.com', '837-667-3906', 'astubbington42', 'Uq1Bxxg', '34645-2105', 503, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (148, 'Esra', 'Burbank', 'http://dummyimage.com/158x225.jpg/cc0000/ffffff', 'eburbank43@sphinn.com', '120-347-4403', 'eburbank43', 'XV8eU6qJBou', '0179-0021', 504, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (149, 'Rossy', 'Grenfell', 'http://dummyimage.com/221x172.png/dddddd/000000', 'rgrenfell44@ucoz.com', '598-335-7633', 'rgrenfell44', 'Nofs11V', '53346-1317', 505, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (150, 'Pincus', 'Mumbray', 'http://dummyimage.com/110x122.bmp/cc0000/ffffff', 'pmumbray45@163.com', '851-549-3776', 'pmumbray45', 'i5aaJBzV2', '68016-144', 506, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (151, 'Catharina', 'Tesauro', 'http://dummyimage.com/192x190.jpg/5fa2dd/ffffff', 'ctesauro46@tumblr.com', '206-948-3680', 'ctesauro46', 'tpAuQ5uGjWDG', '30142-149', 501, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (152, 'Marcy', 'McIlwain', 'http://dummyimage.com/152x121.jpg/dddddd/000000', 'mmcilwain47@netvibes.com', '295-541-6677', 'mmcilwain47', 'UtXb0UO9ihQQ', '68196-300', 502, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (153, 'Francisca', 'Pirouet', 'http://dummyimage.com/100x212.png/5fa2dd/ffffff', 'fpirouet48@dedecms.com', '313-909-9461', 'fpirouet48', 'ns389cvCE4Sr', '67544-204', 503, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (154, 'Joana', 'Cossell', 'http://dummyimage.com/123x149.jpg/dddddd/000000', 'jcossell49@pcworld.com', '373-881-8707', 'jcossell49', 'C4bcbbeBJx', '50845-0100', 504, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (155, 'Cairistiona', 'Lidden', 'http://dummyimage.com/225x183.bmp/5fa2dd/ffffff', 'clidden4a@typepad.com', '771-791-5316', 'clidden4a', '90B7tcHuqyX', '0310-7820', 505, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (156, 'Kessiah', 'Hathway', 'http://dummyimage.com/197x216.jpg/cc0000/ffffff', 'khathway4b@imgur.com', '474-746-9995', 'khathway4b', 'F2p7b09', '67046-660', 506, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (157, 'Valery', 'Sybbe', 'http://dummyimage.com/102x163.png/cc0000/ffffff', 'vsybbe4c@ucoz.ru', '345-708-3450', 'vsybbe4c', 'ab1VOZ3R', '51414-600', 501, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (158, 'Sidnee', 'Chastel', 'http://dummyimage.com/191x142.jpg/dddddd/000000', 'schastel4d@ed.gov', '371-993-9734', 'schastel4d', 'lU0uaKhdP', '52959-757', 502, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (159, 'Neall', 'Hortop', 'http://dummyimage.com/236x247.png/5fa2dd/ffffff', 'nhortop4e@merriam-webster.com', '184-288-1013', 'nhortop4e', 'zhOkHEaWX', '54218-800', 503, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (160, 'Gustie', 'Duncklee', 'http://dummyimage.com/139x141.bmp/dddddd/000000', 'gduncklee4f@fotki.com', '678-504-7028', 'gduncklee4f', 'O3V2O4uk1cmG', '65841-744', 504, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (161, 'Hettie', 'Marchenko', 'http://dummyimage.com/203x119.jpg/ff4444/ffffff', 'hmarchenko4g@miibeian.gov.cn', '785-590-1387', 'hmarchenko4g', '99FhUunV', '48951-5023', 505, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (162, 'Kendell', 'Rome', 'http://dummyimage.com/182x217.jpg/dddddd/000000', 'krome4h@mtv.com', '255-218-4459', 'krome4h', 'c0dluBfoHi', '61715-035', 506, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (163, 'Britte', 'Toffolini', 'http://dummyimage.com/160x119.png/5fa2dd/ffffff', 'btoffolini4i@godaddy.com', '223-148-1626', 'btoffolini4i', 'UbB6NewoP', '42254-110', 501, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (164, 'Rorke', 'Barock', 'http://dummyimage.com/110x234.bmp/cc0000/ffffff', 'rbarock4j@simplemachines.org', '150-391-6419', 'rbarock4j', 'sibIiCdOe2j', '42002-207', 502, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (165, 'Gratia', 'Gemson', 'http://dummyimage.com/199x186.png/5fa2dd/ffffff', 'ggemson4k@prweb.com', '939-512-2544', 'ggemson4k', 'T7yC8kDn', '50419-325', 503, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (166, 'Valentin', 'Scholz', 'http://dummyimage.com/205x249.bmp/cc0000/ffffff', 'vscholz4l@theguardian.com', '873-983-9179', 'vscholz4l', 'pFM0k3', '60505-3670', 504, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (167, 'Felicity', 'Puddephatt', 'http://dummyimage.com/101x166.bmp/ff4444/ffffff', 'fpuddephatt4m@nba.com', '637-514-2972', 'fpuddephatt4m', '2nq5HT', '68788-9076', 505, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (168, 'Rona', 'Youel', 'http://dummyimage.com/190x223.bmp/dddddd/000000', 'ryouel4n@webs.com', '261-238-3216', 'ryouel4n', 'FdxLRQHg', '53808-0310', 506, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (169, 'Minette', 'Ord', 'http://dummyimage.com/231x217.bmp/dddddd/000000', 'mord4o@auda.org.au', '377-775-3131', 'mord4o', 'yJyryv4K', '68084-179', 501, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (170, 'Eugene', 'Schroter', 'http://dummyimage.com/224x152.png/cc0000/ffffff', 'eschroter4p@sitemeter.com', '717-380-7960', 'eschroter4p', 'naKnBVJ', '0002-8215', 502, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (171, 'Moll', 'Dibnah', 'http://dummyimage.com/237x137.bmp/ff4444/ffffff', 'mdibnah4q@rambler.ru', '876-281-7189', 'mdibnah4q', 'pG1RqzNwQ', '11980-180', 503, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (172, 'Conchita', 'Treen', 'http://dummyimage.com/132x149.png/dddddd/000000', 'ctreen4r@nyu.edu', '942-954-4012', 'ctreen4r', 'PRct3WNwdX', '64735-020', 504, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (173, 'Mattheus', 'Ties', 'http://dummyimage.com/213x237.png/cc0000/ffffff', 'mties4s@vinaora.com', '418-670-6895', 'mties4s', 'jpqMOO', '52343-026', 505, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (174, 'Camel', 'Sheilds', 'http://dummyimage.com/201x229.bmp/ff4444/ffffff', 'csheilds4t@apache.org', '736-977-6125', 'csheilds4t', '1mvS2Sgoy', '70253-128', 506, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (175, 'Trista', 'Ineson', 'http://dummyimage.com/119x188.bmp/ff4444/ffffff', 'tineson4u@bbc.co.uk', '574-635-0387', 'tineson4u', 'sEPHgF9p', '44911-0014', 501, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (176, 'Jim', 'Baynon', 'http://dummyimage.com/207x173.png/5fa2dd/ffffff', 'jbaynon4v@netscape.com', '401-329-8801', 'jbaynon4v', 'hDXIG7lGY', '62011-0248', 502, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (177, 'Verla', 'Iscowitz', 'http://dummyimage.com/240x188.bmp/cc0000/ffffff', 'viscowitz4w@yale.edu', '984-999-4563', 'viscowitz4w', 'J1048jcQhtj7', '0378-6727', 503, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (178, 'Rebbecca', 'Jedrychowski', 'http://dummyimage.com/116x223.png/cc0000/ffffff', 'rjedrychowski4x@sohu.com', '124-297-7484', 'rjedrychowski4x', 'BpB3zWMc2', '61589-6010', 504, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (179, 'Randy', 'Johnstone', 'http://dummyimage.com/198x117.bmp/cc0000/ffffff', 'rjohnstone4y@ca.gov', '291-172-8209', 'rjohnstone4y', 'qmTsrn1fs0', '59726-024', 505, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (180, 'Farly', 'Turneux', 'http://dummyimage.com/128x208.bmp/dddddd/000000', 'fturneux4z@studiopress.com', '818-694-1985', 'fturneux4z', 'L65aKw1K5LV', '68084-380', 506, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (181, 'Law', 'Tremoille', 'http://dummyimage.com/101x217.bmp/cc0000/ffffff', 'ltremoille50@tumblr.com', '473-642-9372', 'ltremoille50', 'UIhhf0A', '35356-091', 501, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (182, 'Edlin', 'Hugill', 'http://dummyimage.com/228x161.bmp/cc0000/ffffff', 'ehugill51@tmall.com', '173-877-5106', 'ehugill51', 'Jbo0aXwYG', '13533-618', 502, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (183, 'Deeanne', 'Abbatt', 'http://dummyimage.com/231x180.png/dddddd/000000', 'dabbatt52@hostgator.com', '881-312-8570', 'dabbatt52', 'Tb7MtzlC7H', '0924-5701', 503, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (184, 'Arluene', 'Stollard', 'http://dummyimage.com/151x203.jpg/5fa2dd/ffffff', 'astollard53@forbes.com', '658-772-7857', 'astollard53', 'SW5Wu3', '24208-485', 504, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (185, 'Lilian', 'Dunckley', 'http://dummyimage.com/234x222.bmp/ff4444/ffffff', 'ldunckley54@xing.com', '639-561-5610', 'ldunckley54', 'XUu0R1I', '54868-0016', 505, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (186, 'Carrie', 'Chapelhow', 'http://dummyimage.com/228x104.bmp/5fa2dd/ffffff', 'cchapelhow55@infoseek.co.jp', '637-633-6481', 'cchapelhow55', 'X8yH2F', '36987-1461', 506, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (187, 'Dietrich', 'Rappoport', 'http://dummyimage.com/167x218.jpg/ff4444/ffffff', 'drappoport56@noaa.gov', '134-646-8231', 'drappoport56', 'RpXT1McyV', '58318-002', 501, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (188, 'Tucky', 'Domenge', 'http://dummyimage.com/112x192.jpg/dddddd/000000', 'tdomenge57@house.gov', '476-422-6531', 'tdomenge57', 'JwLF0A', '55910-445', 502, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (189, 'Tina', 'Statton', 'http://dummyimage.com/133x211.bmp/cc0000/ffffff', 'tstatton58@nps.gov', '820-192-4716', 'tstatton58', 'dPkPaBEMCcW', '54868-4517', 503, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (190, 'Ripley', 'Wenderott', 'http://dummyimage.com/214x114.jpg/cc0000/ffffff', 'rwenderott59@zimbio.com', '812-990-3507', 'rwenderott59', 'h6JsSE', '61957-1016', 504, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (191, 'Artur', 'Vanyatin', 'http://dummyimage.com/138x152.bmp/dddddd/000000', 'avanyatin5a@jimdo.com', '562-469-6514', 'avanyatin5a', 'WHC8NtrDzFLo', '0088-2223', 505, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (192, 'Joane', 'Yackiminie', 'http://dummyimage.com/192x123.bmp/dddddd/000000', 'jyackiminie5b@google.nl', '845-440-2425', 'jyackiminie5b', '0MMV2ds', '36800-424', 506, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (193, 'Ailey', 'Haddington', 'http://dummyimage.com/202x215.jpg/dddddd/000000', 'ahaddington5c@europa.eu', '587-643-0434', 'ahaddington5c', '06HCm9i88', '68788-9132', 501, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (194, 'Edna', 'Gambie', 'http://dummyimage.com/150x132.jpg/5fa2dd/ffffff', 'egambie5d@360.cn', '114-310-1912', 'egambie5d', 'bhvK3FxdK', '21695-195', 502, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (195, 'Jackelyn', 'Jirasek', 'http://dummyimage.com/111x180.bmp/ff4444/ffffff', 'jjirasek5e@scribd.com', '109-645-9212', 'jjirasek5e', 'PAbadFQNVb', '59078-025', 503, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (196, 'Honor', 'Aldridge', 'http://dummyimage.com/241x229.jpg/ff4444/ffffff', 'haldridge5f@zdnet.com', '585-251-5478', 'haldridge5f', 'b4ZbKpmn', '65954-531', 504, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (197, 'Niel', 'Bryers', 'http://dummyimage.com/198x129.jpg/ff4444/ffffff', 'nbryers5g@myspace.com', '654-457-6038', 'nbryers5g', 'xffw6Lw', '0555-0701', 505, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (198, 'Gian', 'Willbond', 'http://dummyimage.com/204x167.png/5fa2dd/ffffff', 'gwillbond5h@patch.com', '508-879-4044', 'gwillbond5h', 'nB4Ubw7', '0173-0642', 506, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (199, 'Calypso', 'Eyeington', 'http://dummyimage.com/180x103.jpg/5fa2dd/ffffff', 'ceyeington5i@cbc.ca', '181-176-3028', 'ceyeington5i', 'pmeIm4', '68752-022', 501, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (200, 'Rosmunda', 'Trees', 'http://dummyimage.com/137x110.png/ff4444/ffffff', 'rtrees5j@cmu.edu', '133-483-7906', 'rtrees5j', 'kjsKkE66K', '48951-3104', 502, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (201, 'Barthel', 'Broun', 'http://dummyimage.com/113x222.png/ff4444/ffffff', 'bbroun5k@jigsy.com', '867-295-8749', 'bbroun5k', '1QLOEr', '0781-5204', 503, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (202, 'Read', 'Limpertz', 'http://dummyimage.com/166x168.png/ff4444/ffffff', 'rlimpertz5l@skype.com', '213-770-0562', 'rlimpertz5l', '7AClHq4S28Q', '64942-1089', 504, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (203, 'Fletcher', 'Wheldon', 'http://dummyimage.com/221x211.bmp/5fa2dd/ffffff', 'fwheldon5m@twitter.com', '345-687-1968', 'fwheldon5m', 'DU3xmeKBUhOp', '49348-267', 505, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (204, 'Vivyanne', 'Janko', 'http://dummyimage.com/105x219.png/ff4444/ffffff', 'vjanko5n@shutterfly.com', '381-285-3988', 'vjanko5n', 'JmJP3EhU', '13537-439', 506, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (205, 'Neille', 'Warlow', 'http://dummyimage.com/138x126.png/cc0000/ffffff', 'nwarlow5o@reference.com', '891-882-6629', 'nwarlow5o', 'uCqOdQF9U', '59630-780', 501, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (206, 'Daphna', 'Truce', 'http://dummyimage.com/221x160.bmp/dddddd/000000', 'dtruce5p@reference.com', '560-364-8111', 'dtruce5p', 'a0tGnq3rbP', '36987-2548', 502, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (207, 'Mary', 'Barlthrop', 'http://dummyimage.com/212x196.jpg/5fa2dd/ffffff', 'mbarlthrop5q@geocities.jp', '710-874-1072', 'mbarlthrop5q', 'paAV39QFlsdT', '68084-342', 503, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (208, 'Sansone', 'Boylin', 'http://dummyimage.com/148x143.png/ff4444/ffffff', 'sboylin5r@tumblr.com', '874-852-6352', 'sboylin5r', 'jzsRjNrWgk', '63739-080', 504, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (209, 'Susan', 'Bento', 'http://dummyimage.com/243x134.bmp/ff4444/ffffff', 'sbento5s@java.com', '530-781-5362', 'sbento5s', 'q9g58rChikgp', '54473-217', 505, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (210, 'Leonid', 'Portlock', 'http://dummyimage.com/180x237.png/ff4444/ffffff', 'lportlock5t@craigslist.org', '590-424-5038', 'lportlock5t', 'IqRm10mb', '76509-100', 506, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (211, 'Bordy', 'Resun', 'http://dummyimage.com/232x133.bmp/ff4444/ffffff', 'bresun5u@shutterfly.com', '541-275-4752', 'bresun5u', '835wgPxjjJki', '63323-297', 501, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (212, 'Erik', 'Jancso', 'http://dummyimage.com/117x231.png/dddddd/000000', 'ejancso5v@noaa.gov', '676-173-9229', 'ejancso5v', 'Jv5UDYaSwLOs', '63629-4353', 502, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (213, 'Egon', 'Hogsden', 'http://dummyimage.com/206x189.png/5fa2dd/ffffff', 'ehogsden5w@tinyurl.com', '147-599-8617', 'ehogsden5w', 'pHS7ojeH67v', '43269-638', 503, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (214, 'Devinne', 'Cortes', 'http://dummyimage.com/249x104.png/cc0000/ffffff', 'dcortes5x@reverbnation.com', '691-408-8335', 'dcortes5x', 'S0VRfy1veh', '0781-5225', 504, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (215, 'Virgina', 'Hatcher', 'http://dummyimage.com/180x182.jpg/dddddd/000000', 'vhatcher5y@tumblr.com', '975-940-9787', 'vhatcher5y', 'Pj1PsxkCpxAv', '45963-412', 505, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (216, 'Maxy', 'Plant', 'http://dummyimage.com/136x188.jpg/cc0000/ffffff', 'mplant5z@biblegateway.com', '769-369-1516', 'mplant5z', 'cXQ5Ezfc3', '45865-426', 506, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (217, 'Fancy', 'Angrove', 'http://dummyimage.com/237x103.png/dddddd/000000', 'fangrove60@dedecms.com', '303-375-9447', 'fangrove60', 'EnLZHvI4', '61314-342', 501, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (218, 'Betteanne', 'Darch', 'http://dummyimage.com/129x106.png/dddddd/000000', 'bdarch61@wp.com', '939-508-4008', 'bdarch61', '7UYaR9', '49349-729', 502, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (219, 'Pascal', 'Lodemann', 'http://dummyimage.com/121x103.png/5fa2dd/ffffff', 'plodemann62@ihg.com', '120-320-4265', 'plodemann62', 'q1uCZj6S', '41520-578', 503, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (220, 'Rudolf', 'de Pinna', 'http://dummyimage.com/138x106.bmp/ff4444/ffffff', 'rdepinna63@yale.edu', '240-580-5195', 'rdepinna63', 'CKeJqmKhWRs5', '58443-0015', 504, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (221, 'Georgy', 'Stalf', 'http://dummyimage.com/168x239.jpg/5fa2dd/ffffff', 'gstalf64@huffingtonpost.com', '670-438-7223', 'gstalf64', 'RRuiLaobfk', '0942-6488', 505, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (222, 'Dix', 'Naptin', 'http://dummyimage.com/165x248.png/cc0000/ffffff', 'dnaptin65@forbes.com', '470-684-4285', 'dnaptin65', 'TiPVrP', '49288-0808', 506, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (223, 'Andy', 'Woodroof', 'http://dummyimage.com/187x116.bmp/dddddd/000000', 'awoodroof66@omniture.com', '572-515-8186', 'awoodroof66', 'F7bS8NsKwUni', '36987-1736', 501, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (224, 'Kacey', 'Lovel', 'http://dummyimage.com/222x206.jpg/dddddd/000000', 'klovel67@xrea.com', '378-274-5605', 'klovel67', 'HK9eCsa1Bd', '66949-339', 502, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (225, 'Gertie', 'Ghiraldi', 'http://dummyimage.com/157x100.jpg/5fa2dd/ffffff', 'gghiraldi68@forbes.com', '706-212-3195', 'gghiraldi68', 'X7d2nIH2v', '58118-0570', 503, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (226, 'Marlo', 'Santon', 'http://dummyimage.com/235x152.bmp/5fa2dd/ffffff', 'msanton69@etsy.com', '422-190-7857', 'msanton69', 'TmjvQp', '75847-1704', 504, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (227, 'Ogdon', 'Sammons', 'http://dummyimage.com/172x110.jpg/dddddd/000000', 'osammons6a@meetup.com', '161-577-2485', 'osammons6a', '7tglcw9v8O', '0904-5940', 505, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (228, 'Bren', 'Duffan', 'http://dummyimage.com/155x224.png/ff4444/ffffff', 'bduffan6b@slate.com', '226-711-6601', 'bduffan6b', 'KK2DPlKwIKI', '0187-5200', 506, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (229, 'Hagan', 'Attenbrough', 'http://dummyimage.com/158x232.bmp/dddddd/000000', 'hattenbrough6c@flavors.me', '654-590-0763', 'hattenbrough6c', 'CR9mUT2u2xWo', '49571-002', 501, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (230, 'Garrett', 'Loosely', 'http://dummyimage.com/229x115.bmp/5fa2dd/ffffff', 'gloosely6d@utexas.edu', '817-355-1413', 'gloosely6d', 'BNYJCIgSgy', '29033-013', 502, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (231, 'Duff', 'Videneev', 'http://dummyimage.com/196x236.jpg/5fa2dd/ffffff', 'dvideneev6e@miitbeian.gov.cn', '150-882-7027', 'dvideneev6e', 'F0tPNAbgLz1k', '10812-907', 503, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (232, 'Fredia', 'OIlier', 'http://dummyimage.com/230x217.jpg/ff4444/ffffff', 'foilier6f@ehow.com', '184-367-2015', 'foilier6f', 'HD1JEa', '63736-312', 504, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (233, 'Enoch', 'Reavey', 'http://dummyimage.com/238x187.jpg/5fa2dd/ffffff', 'ereavey6g@blogger.com', '904-418-1996', 'ereavey6g', 'VxTLXK7hRm6', '21695-337', 505, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (234, 'Imelda', 'Brevitt', 'http://dummyimage.com/125x135.png/cc0000/ffffff', 'ibrevitt6h@ucla.edu', '429-627-0837', 'ibrevitt6h', 'MyJYHZ2bo', '64762-862', 506, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (235, 'Dorette', 'Salvidge', 'http://dummyimage.com/229x155.png/cc0000/ffffff', 'dsalvidge6i@xrea.com', '351-524-4197', 'dsalvidge6i', 'YRLHXnhbZnuw', '76125-667', 501, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (236, 'Kelcie', 'Leynton', 'http://dummyimage.com/158x234.png/dddddd/000000', 'kleynton6j@arstechnica.com', '957-706-1544', 'kleynton6j', 'dhTk2YCaUM', '37012-815', 502, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (237, 'Fern', 'Di Lucia', 'http://dummyimage.com/169x171.jpg/cc0000/ffffff', 'fdilucia6k@dmoz.org', '767-620-0068', 'fdilucia6k', 'plJFbUxthL', '60681-1277', 503, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (238, 'Kalinda', 'Espie', 'http://dummyimage.com/121x101.jpg/dddddd/000000', 'kespie6l@reddit.com', '668-567-4467', 'kespie6l', 'fYrHN3qPGM', '76214-006', 504, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (239, 'Guglielmo', 'Keson', 'http://dummyimage.com/102x114.bmp/dddddd/000000', 'gkeson6m@google.ca', '764-746-1561', 'gkeson6m', '42wD7WDo', '54569-1121', 505, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (240, 'Sybille', 'Millom', 'http://dummyimage.com/149x136.png/cc0000/ffffff', 'smillom6n@com.com', '578-993-9745', 'smillom6n', 'FojvFt2kB', '13734-142', 506, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (241, 'Karalee', 'Buggy', 'http://dummyimage.com/100x196.bmp/5fa2dd/ffffff', 'kbuggy6o@tinyurl.com', '718-143-1704', 'kbuggy6o', 'JI8GQkxXY', '59779-089', 501, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (242, 'Caroline', 'Phillippo', 'http://dummyimage.com/176x117.png/dddddd/000000', 'cphillippo6p@youku.com', '490-491-4541', 'cphillippo6p', 'NSf1BykYtlLu', '37205-165', 502, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (243, 'Cort', 'Laise', 'http://dummyimage.com/153x195.jpg/cc0000/ffffff', 'claise6q@samsung.com', '991-764-6914', 'claise6q', 'nD379I', '42507-810', 503, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (244, 'Shandra', 'Gatheral', 'http://dummyimage.com/145x181.jpg/ff4444/ffffff', 'sgatheral6r@icq.com', '219-661-8892', 'sgatheral6r', 'qTSAxMPnAT', '57520-0140', 504, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (245, 'Rosmunda', 'Meggison', 'http://dummyimage.com/139x196.bmp/ff4444/ffffff', 'rmeggison6s@wix.com', '341-634-2504', 'rmeggison6s', 'j24V9x5sHwJE', '49348-634', 505, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (246, 'Carolus', 'Driutti', 'http://dummyimage.com/174x163.bmp/ff4444/ffffff', 'cdriutti6t@blogtalkradio.com', '649-274-4667', 'cdriutti6t', '73du1Rv3OQ', '52685-383', 506, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (247, 'Conant', 'Jozefiak', 'http://dummyimage.com/180x123.jpg/cc0000/ffffff', 'cjozefiak6u@independent.co.uk', '935-645-4735', 'cjozefiak6u', '8hPomjhbli', '0781-1438', 501, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (248, 'Dana', 'Sprowson', 'http://dummyimage.com/214x147.png/ff4444/ffffff', 'dsprowson6v@smugmug.com', '510-491-4460', 'dsprowson6v', 'Pc9L66v', '68703-118', 502, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (249, 'Chucho', 'Collet', 'http://dummyimage.com/191x190.bmp/cc0000/ffffff', 'ccollet6w@apache.org', '561-458-4861', 'ccollet6w', 'TOR1ObXP6', '52584-503', 503, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (250, 'Mallissa', 'Ruddom', 'http://dummyimage.com/183x154.jpg/cc0000/ffffff', 'mruddom6x@princeton.edu', '472-641-3185', 'mruddom6x', 'h3mfb3j', '54868-5197', 504, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (251, 'Yehudi', 'Dossit', 'http://dummyimage.com/220x122.jpg/ff4444/ffffff', 'ydossit6y@1und1.de', '108-485-5934', 'ydossit6y', 'l0FejrnEuc', '67857-705', 505, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (252, 'Poppy', 'McGurgan', 'http://dummyimage.com/159x230.jpg/cc0000/ffffff', 'pmcgurgan6z@disqus.com', '720-965-0672', 'pmcgurgan6z', 'fzM9QFM9', '54838-555', 506, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (253, 'Ariela', 'Bisatt', 'http://dummyimage.com/117x177.bmp/ff4444/ffffff', 'abisatt70@amazon.com', '614-915-4657', 'abisatt70', 'zit3t3VYonW', '36987-2525', 501, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (254, 'Hasty', 'Oade', 'http://dummyimage.com/145x218.jpg/5fa2dd/ffffff', 'hoade71@bluehost.com', '856-250-1220', 'hoade71', 'ui03XZ0', '59400-001', 502, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (255, 'Raine', 'Malam', 'http://dummyimage.com/238x206.png/cc0000/ffffff', 'rmalam72@flickr.com', '336-910-9597', 'rmalam72', '2uRg2Ldads', '61442-117', 503, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (256, 'Corette', 'Compton', 'http://dummyimage.com/155x157.jpg/cc0000/ffffff', 'ccompton73@cnn.com', '373-552-6032', 'ccompton73', 'ue0p6Sp', '45984-0002', 504, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (257, 'Irvin', 'Leimster', 'http://dummyimage.com/159x222.bmp/cc0000/ffffff', 'ileimster74@nifty.com', '303-197-8512', 'ileimster74', 'ARlxMSVRC2', '11673-503', 505, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (258, 'Allx', 'Flippelli', 'http://dummyimage.com/131x183.bmp/cc0000/ffffff', 'aflippelli75@msu.edu', '756-283-3377', 'aflippelli75', 'Lf0zOPbOp', '0093-0738', 506, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (259, 'Sherwin', 'Dickinson', 'http://dummyimage.com/146x211.jpg/5fa2dd/ffffff', 'sdickinson76@jalbum.net', '671-346-5835', 'sdickinson76', '5yds8z2cA4o', '51263-3185', 501, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (260, 'Halette', 'MacGorley', 'http://dummyimage.com/205x146.png/dddddd/000000', 'hmacgorley77@opera.com', '256-982-6226', 'hmacgorley77', 'iI9ACliAbX5', '10812-328', 502, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (261, 'Gino', 'Pilmore', 'http://dummyimage.com/169x236.png/ff4444/ffffff', 'gpilmore78@washingtonpost.com', '431-318-8551', 'gpilmore78', 'SFgMfl', '63323-483', 503, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (262, 'Shandee', 'Mateev', 'http://dummyimage.com/157x139.png/dddddd/000000', 'smateev79@washington.edu', '116-707-4558', 'smateev79', 'QJs5NWAR', '0409-4279', 504, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (263, 'Baillie', 'Sweetnam', 'http://dummyimage.com/148x178.bmp/cc0000/ffffff', 'bsweetnam7a@fastcompany.com', '388-586-2349', 'bsweetnam7a', 'TB6YC4gJ', '49349-507', 505, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (264, 'Iago', 'Allwright', 'http://dummyimage.com/215x156.jpg/cc0000/ffffff', 'iallwright7b@wufoo.com', '277-524-2899', 'iallwright7b', 'jYIEXx3bEdG', '55154-0734', 506, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (265, 'Ofelia', 'Armfield', 'http://dummyimage.com/130x162.bmp/dddddd/000000', 'oarmfield7c@bloglovin.com', '270-189-6881', 'oarmfield7c', 'iVMhlxkQ', '55154-0155', 501, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (266, 'Puff', 'Pashe', 'http://dummyimage.com/222x221.png/ff4444/ffffff', 'ppashe7d@arizona.edu', '802-626-0762', 'ppashe7d', 'iMRjhVM', '47781-303', 502, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (267, 'Valentia', 'Ofener', 'http://dummyimage.com/137x166.bmp/dddddd/000000', 'vofener7e@japanpost.jp', '135-582-0384', 'vofener7e', 'e1AQoBCILPwK', '33342-047', 503, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (268, 'Merci', 'Fleischmann', 'http://dummyimage.com/139x190.png/5fa2dd/ffffff', 'mfleischmann7f@w3.org', '853-463-6979', 'mfleischmann7f', 'ipOgZeS', '68788-9050', 504, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (269, 'Marina', 'Kenshole', 'http://dummyimage.com/184x208.jpg/dddddd/000000', 'mkenshole7g@berkeley.edu', '712-604-9561', 'mkenshole7g', 'k66jY5', '54868-4959', 505, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (270, 'Klarrisa', 'Frantz', 'http://dummyimage.com/164x195.bmp/cc0000/ffffff', 'kfrantz7h@netscape.com', '867-830-9120', 'kfrantz7h', 'yOmjRPatJVJ8', '67046-166', 506, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (271, 'Cymbre', 'Emlyn', 'http://dummyimage.com/111x157.bmp/dddddd/000000', 'cemlyn7i@buzzfeed.com', '708-205-7189', 'cemlyn7i', 'FSZNZu2HU', '43406-0019', 501, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (272, 'Dare', 'Primett', 'http://dummyimage.com/190x110.bmp/5fa2dd/ffffff', 'dprimett7j@yahoo.co.jp', '325-688-8671', 'dprimett7j', 'zg93EonmWi', '37205-200', 502, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (273, 'Carmon', 'Iwanicki', 'http://dummyimage.com/248x159.bmp/dddddd/000000', 'ciwanicki7k@newsvine.com', '826-358-6545', 'ciwanicki7k', 'F3n5BU', '36987-2920', 503, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (274, 'Diena', 'Apfel', 'http://dummyimage.com/204x160.png/dddddd/000000', 'dapfel7l@harvard.edu', '741-907-1237', 'dapfel7l', 'qy86jYJU', '68479-160', 504, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (275, 'Wileen', 'Penfold', 'http://dummyimage.com/164x163.bmp/cc0000/ffffff', 'wpenfold7m@facebook.com', '279-766-3662', 'wpenfold7m', 'WAKtnw', '0091-2495', 505, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (276, 'Cully', 'Grievson', 'http://dummyimage.com/219x219.png/dddddd/000000', 'cgrievson7n@wix.com', '768-284-4322', 'cgrievson7n', 'vrCayu2f', '21130-357', 506, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (277, 'Elbertine', 'Kobu', 'http://dummyimage.com/217x128.jpg/cc0000/ffffff', 'ekobu7o@a8.net', '865-979-4719', 'ekobu7o', 'pOpxXSITjW', '49371-043', 501, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (278, 'Cicely', 'Henstone', 'http://dummyimage.com/201x121.png/dddddd/000000', 'chenstone7p@google.it', '149-656-1935', 'chenstone7p', 'mvXAseQb', '51442-534', 502, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (279, 'Dmitri', 'Garrood', 'http://dummyimage.com/114x214.jpg/5fa2dd/ffffff', 'dgarrood7q@ucoz.ru', '870-494-0567', 'dgarrood7q', 'hsSsE2Db', '50419-251', 503, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (280, 'Leopold', 'Mc Curlye', 'http://dummyimage.com/165x182.jpg/5fa2dd/ffffff', 'lmccurlye7r@blog.com', '355-202-8318', 'lmccurlye7r', '5UzLQ5H9', '54575-374', 504, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (281, 'Sam', 'Le Teve', 'http://dummyimage.com/147x125.jpg/5fa2dd/ffffff', 'sleteve7s@aol.com', '326-140-9956', 'sleteve7s', 'npJDqW3Ay9r', '63304-736', 505, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (282, 'Celene', 'Crinson', 'http://dummyimage.com/202x192.jpg/5fa2dd/ffffff', 'ccrinson7t@oaic.gov.au', '295-163-8878', 'ccrinson7t', 'IQYkFthRc', '43742-0010', 506, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (283, 'Melvyn', 'Gauthorpp', 'http://dummyimage.com/152x125.png/cc0000/ffffff', 'mgauthorpp7u@chicagotribune.com', '535-429-5458', 'mgauthorpp7u', 'gTqpui5', '37000-835', 501, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (284, 'Colas', 'Swinburne', 'http://dummyimage.com/175x176.jpg/cc0000/ffffff', 'cswinburne7v@ycombinator.com', '324-849-0972', 'cswinburne7v', 'oaOK2Z3cwb', '67919-020', 502, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (285, 'Timmie', 'Kelshaw', 'http://dummyimage.com/210x199.bmp/5fa2dd/ffffff', 'tkelshaw7w@sbwire.com', '948-600-2898', 'tkelshaw7w', 'os9HZeVJrE', '0054-8120', 503, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (286, 'Roma', 'Perford', 'http://dummyimage.com/223x127.bmp/dddddd/000000', 'rperford7x@chron.com', '442-127-9134', 'rperford7x', '52V97mt', '29500-7820', 504, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (287, 'Imojean', 'McGarrell', 'http://dummyimage.com/200x125.jpg/cc0000/ffffff', 'imcgarrell7y@yellowbook.com', '340-593-4153', 'imcgarrell7y', '8g7DFJpuJaX', '61869-0001', 505, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (288, 'Frederico', 'Berkley', 'http://dummyimage.com/153x137.png/ff4444/ffffff', 'fberkley7z@jigsy.com', '141-543-6547', 'fberkley7z', 'ALnICQGRDAj4', '51346-170', 506, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (289, 'Trevar', 'Jacqueme', 'http://dummyimage.com/224x123.bmp/ff4444/ffffff', 'tjacqueme80@yandex.ru', '424-483-1551', 'tjacqueme80', '1f7q603OC', '49967-324', 501, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (290, 'Filbert', 'Perfect', 'http://dummyimage.com/124x226.png/5fa2dd/ffffff', 'fperfect81@tinyurl.com', '499-643-6820', 'fperfect81', 'Yy2jlEC', '24208-004', 502, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (291, 'Alan', 'Schubart', 'http://dummyimage.com/240x136.bmp/5fa2dd/ffffff', 'aschubart82@cdc.gov', '237-940-2347', 'aschubart82', 'jtqQhm4rCb4', '33992-0375', 503, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (292, 'Rouvin', 'Raleston', 'http://dummyimage.com/146x138.jpg/5fa2dd/ffffff', 'rraleston83@go.com', '484-406-2588', 'rraleston83', 'lRVKbT', '0703-8776', 504, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (293, 'Nev', 'Minget', 'http://dummyimage.com/248x157.jpg/dddddd/000000', 'nminget84@nasa.gov', '553-273-4905', 'nminget84', 'wqWO1BbQQYa', '61360-2002', 505, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (294, 'Norry', 'Geraudy', 'http://dummyimage.com/113x135.png/5fa2dd/ffffff', 'ngeraudy85@google.co.jp', '453-529-4470', 'ngeraudy85', '5ZIRF7k7dT', '55154-7352', 506, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (295, 'Isador', 'Stovell', 'http://dummyimage.com/165x143.png/5fa2dd/ffffff', 'istovell86@guardian.co.uk', '137-326-1129', 'istovell86', 'hGluv5', '43857-0275', 501, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (296, 'Lorenzo', 'Le Gall', 'http://dummyimage.com/154x169.png/dddddd/000000', 'llegall87@studiopress.com', '214-448-3923', 'llegall87', 'kkdw6deD5', '65841-799', 502, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (297, 'Godart', 'Ashbe', 'http://dummyimage.com/157x234.bmp/5fa2dd/ffffff', 'gashbe88@istockphoto.com', '662-258-1632', 'gashbe88', '4NyvUuZjKhQw', '51079-285', 503, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (298, 'Chico', 'Burch', 'http://dummyimage.com/191x193.bmp/dddddd/000000', 'cburch89@mapy.cz', '229-657-2674', 'cburch89', 'GOTsqWwXIm', '0187-2201', 504, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (299, 'Torry', 'Kelsey', 'http://dummyimage.com/234x162.png/ff4444/ffffff', 'tkelsey8a@wp.com', '935-768-9081', 'tkelsey8a', 'SUArH51GxufH', '65044-3215', 505, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (300, 'Derrek', 'Rentz', 'http://dummyimage.com/131x134.bmp/dddddd/000000', 'drentz8b@gravatar.com', '915-457-4797', 'drentz8b', 'lg3bOlxDET', '0187-0994', 506, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (301, 'Gerianna', 'Gatheral', 'http://dummyimage.com/219x138.png/dddddd/000000', 'ggatheral8c@shinystat.com', '478-405-7020', 'ggatheral8c', 'ilfBuOWhk602', '10237-645', 501, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (302, 'Belita', 'Ivoshin', 'http://dummyimage.com/147x154.jpg/dddddd/000000', 'bivoshin8d@timesonline.co.uk', '612-549-3556', 'bivoshin8d', 'UcR1VPLokF', '41167-1002', 502, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (303, 'Rubina', 'Brearty', 'http://dummyimage.com/221x219.jpg/dddddd/000000', 'rbrearty8e@apache.org', '739-152-9757', 'rbrearty8e', 'IXGL6T7', '67405-830', 503, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (304, 'Octavia', 'Petofi', 'http://dummyimage.com/144x119.jpg/5fa2dd/ffffff', 'opetofi8f@eepurl.com', '240-332-1457', 'opetofi8f', 'f6HYxYyYPZ', '0025-0166', 504, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (305, 'Pru', 'Arnaldo', 'http://dummyimage.com/215x132.jpg/5fa2dd/ffffff', 'parnaldo8g@tumblr.com', '656-828-0817', 'parnaldo8g', 'mC4UvSo', '36987-2699', 505, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (306, 'Albina', 'Casassa', 'http://dummyimage.com/120x115.jpg/5fa2dd/ffffff', 'acasassa8h@homestead.com', '522-409-9722', 'acasassa8h', 'PA117Af', '33261-843', 506, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (307, 'Norry', 'Rule', 'http://dummyimage.com/135x184.png/ff4444/ffffff', 'nrule8i@engadget.com', '214-478-7710', 'nrule8i', 'ChV8OnAYb', '64942-1356', 501, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (308, 'Bertram', 'Baack', 'http://dummyimage.com/130x242.bmp/dddddd/000000', 'bbaack8j@zdnet.com', '432-226-8925', 'bbaack8j', 'm8LKmQVL7', '36987-2974', 502, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (309, 'Faith', 'Bowling', 'http://dummyimage.com/110x247.jpg/dddddd/000000', 'fbowling8k@sciencedaily.com', '644-491-8008', 'fbowling8k', 'H5B6egLtO', '52125-253', 503, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (310, 'Philipa', 'Wippermann', 'http://dummyimage.com/176x144.bmp/dddddd/000000', 'pwippermann8l@indiegogo.com', '561-191-2884', 'pwippermann8l', '23qLnx', '53489-478', 504, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (311, 'Ingar', 'Lafayette', 'http://dummyimage.com/183x147.png/ff4444/ffffff', 'ilafayette8m@biglobe.ne.jp', '429-923-2097', 'ilafayette8m', 'gF5cX25nDTK', '0172-5033', 505, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (312, 'Myron', 'Elsmore', 'http://dummyimage.com/116x198.jpg/5fa2dd/ffffff', 'melsmore8n@studiopress.com', '480-472-4423', 'melsmore8n', 'G6osIi0V', '53329-923', 506, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (313, 'Rosalinda', 'Servant', 'http://dummyimage.com/130x120.jpg/5fa2dd/ffffff', 'rservant8o@squidoo.com', '697-739-2823', 'rservant8o', 'QIjf4uO3C', '51079-700', 501, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (314, 'Markus', 'Padell', 'http://dummyimage.com/125x221.jpg/ff4444/ffffff', 'mpadell8p@t.co', '844-989-7732', 'mpadell8p', '4vZ4cCDkQ', '76436-133', 502, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (315, 'Kaiser', 'Stroban', 'http://dummyimage.com/114x229.bmp/ff4444/ffffff', 'kstroban8q@slashdot.org', '751-878-8361', 'kstroban8q', 'KvaGGH46', '65197-426', 503, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (316, 'Elsy', 'Goundsy', 'http://dummyimage.com/111x167.bmp/cc0000/ffffff', 'egoundsy8r@sina.com.cn', '562-306-3795', 'egoundsy8r', 'G8beBE', '56062-423', 504, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (317, 'Gracia', 'Vasiljevic', 'http://dummyimage.com/123x101.png/ff4444/ffffff', 'gvasiljevic8s@netvibes.com', '911-165-6532', 'gvasiljevic8s', 'Mr3R9Q', '0003-0894', 505, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (318, 'Ceciley', 'Bertelet', 'http://dummyimage.com/136x203.jpg/ff4444/ffffff', 'cbertelet8t@timesonline.co.uk', '444-116-3243', 'cbertelet8t', 'ePDo5dQvcT2', '62206-4750', 506, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (319, 'Arte', 'McClean', 'http://dummyimage.com/161x101.png/dddddd/000000', 'amcclean8u@mozilla.org', '884-596-7707', 'amcclean8u', '690qob8syo9', '68770-101', 501, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (320, 'Paquito', 'Staley', 'http://dummyimage.com/180x178.jpg/dddddd/000000', 'pstaley8v@cnn.com', '467-535-9571', 'pstaley8v', 'leR9KKJ8XI8', '61715-071', 502, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (321, 'Issi', 'Pilfold', 'http://dummyimage.com/112x233.png/cc0000/ffffff', 'ipilfold8w@uol.com.br', '397-548-1657', 'ipilfold8w', 'QeYBVip0rM', '55045-1259', 503, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (322, 'Luciana', 'Miebes', 'http://dummyimage.com/188x180.jpg/dddddd/000000', 'lmiebes8x@archive.org', '521-280-7211', 'lmiebes8x', 'hM3elDoi4vN', '49884-121', 504, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (323, 'Kinnie', 'Crookshanks', 'http://dummyimage.com/155x121.bmp/cc0000/ffffff', 'kcrookshanks8y@senate.gov', '475-385-3831', 'kcrookshanks8y', 'gFW3etXo', '63629-3377', 505, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (324, 'Joey', 'Walkden', 'http://dummyimage.com/206x156.jpg/5fa2dd/ffffff', 'jwalkden8z@yahoo.co.jp', '396-173-9281', 'jwalkden8z', 'TkqBLg0', '65841-757', 506, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (325, 'Gloria', 'McClelland', 'http://dummyimage.com/193x147.bmp/5fa2dd/ffffff', 'gmcclelland90@state.tx.us', '674-508-2838', 'gmcclelland90', 'c99aQLImO', '63629-1673', 501, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (326, 'Mahalia', 'Fearon', 'http://dummyimage.com/179x155.jpg/dddddd/000000', 'mfearon91@sogou.com', '519-966-6465', 'mfearon91', 'E3rwgyB7Y7k', '37000-714', 502, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (327, 'Kent', 'Simonett', 'http://dummyimage.com/248x215.jpg/ff4444/ffffff', 'ksimonett92@wsj.com', '512-478-3850', 'ksimonett92', 'HPOlbPrB', '55154-7458', 503, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (328, 'Dario', 'MacTeague', 'http://dummyimage.com/106x249.png/dddddd/000000', 'dmacteague93@twitpic.com', '748-490-4648', 'dmacteague93', 'JJ9dYPGFT9f3', '55154-2024', 504, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (329, 'Magdalena', 'Pering', 'http://dummyimage.com/129x112.png/dddddd/000000', 'mpering94@slate.com', '764-643-1535', 'mpering94', 'ccihwa', '37205-723', 505, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (330, 'Karisa', 'Gatchel', 'http://dummyimage.com/223x108.bmp/ff4444/ffffff', 'kgatchel95@yandex.ru', '121-654-9750', 'kgatchel95', 'mnWn4HNmN', '11344-919', 506, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (331, 'Vaclav', 'Candey', 'http://dummyimage.com/145x188.jpg/5fa2dd/ffffff', 'vcandey96@harvard.edu', '469-914-7415', 'vcandey96', 'ja9qfYROK', '49288-0583', 501, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (332, 'Christie', 'Hutcheon', 'http://dummyimage.com/203x150.bmp/ff4444/ffffff', 'chutcheon97@sitemeter.com', '298-759-1269', 'chutcheon97', 'k56ad1S', '60505-2583', 502, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (333, 'Miguela', 'Dillamore', 'http://dummyimage.com/172x226.png/dddddd/000000', 'mdillamore98@economist.com', '634-853-6104', 'mdillamore98', 'Juthn7oqA', '42673-001', 503, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (334, 'Madelina', 'Hedling', 'http://dummyimage.com/142x101.bmp/cc0000/ffffff', 'mhedling99@columbia.edu', '586-972-8476', 'mhedling99', 'KFLCOgGM', '54838-145', 504, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (335, 'Dasha', 'Tithecott', 'http://dummyimage.com/239x243.png/ff4444/ffffff', 'dtithecott9a@ebay.co.uk', '904-687-6702', 'dtithecott9a', 'L2LTNd', '49884-302', 505, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (336, 'Vivien', 'Luxford', 'http://dummyimage.com/115x240.png/cc0000/ffffff', 'vluxford9b@ox.ac.uk', '194-454-4196', 'vluxford9b', '2bQB1d7LjI', '0143-9857', 506, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (337, 'Lyell', 'Llewellyn', 'http://dummyimage.com/182x216.jpg/ff4444/ffffff', 'lllewellyn9c@topsy.com', '806-496-1352', 'lllewellyn9c', 'pedokDv', '54108-0333', 501, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (338, 'Tadeo', 'Bridewell', 'http://dummyimage.com/236x160.png/cc0000/ffffff', 'tbridewell9d@nyu.edu', '412-880-8891', 'tbridewell9d', 'BrAZFbX', '36800-737', 502, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (339, 'Frankie', 'Boddis', 'http://dummyimage.com/126x205.bmp/5fa2dd/ffffff', 'fboddis9e@about.me', '934-123-9378', 'fboddis9e', 'jpn6a2H', '52125-545', 503, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (340, 'Meta', 'Boullen', 'http://dummyimage.com/232x133.bmp/dddddd/000000', 'mboullen9f@buzzfeed.com', '527-531-7117', 'mboullen9f', 'm00d5HW', '37205-751', 504, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (341, 'Barth', 'Upham', 'http://dummyimage.com/234x169.png/5fa2dd/ffffff', 'bupham9g@hibu.com', '973-640-1629', 'bupham9g', '6LJnD0ea2DeV', '52709-1301', 505, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (342, 'Lynde', 'Flew', 'http://dummyimage.com/165x183.png/ff4444/ffffff', 'lflew9h@amazonaws.com', '562-212-9449', 'lflew9h', 'EvCp8Zw', '53675-155', 506, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (343, 'Laetitia', 'Rops', 'http://dummyimage.com/109x110.png/dddddd/000000', 'lrops9i@cdc.gov', '486-402-4882', 'lrops9i', 'SprkqG', '64117-982', 501, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (344, 'Arlin', 'Shackle', 'http://dummyimage.com/160x182.jpg/cc0000/ffffff', 'ashackle9j@businessweek.com', '266-685-2690', 'ashackle9j', 'dKUnaW', '58593-825', 502, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (345, 'Sybila', 'Neagle', 'http://dummyimage.com/157x210.png/cc0000/ffffff', 'sneagle9k@cnn.com', '358-171-1146', 'sneagle9k', '9H75cr', '52125-734', 503, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (346, 'Bird', 'Limming', 'http://dummyimage.com/207x133.jpg/cc0000/ffffff', 'blimming9l@japanpost.jp', '577-359-9514', 'blimming9l', 'qOTNyA', '42877-002', 504, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (347, 'Kurt', 'Langelay', 'http://dummyimage.com/101x126.bmp/dddddd/000000', 'klangelay9m@opensource.org', '339-934-0633', 'klangelay9m', '5Tw1Ly6gL', '68647-181', 505, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (348, 'Marge', 'Cescotti', 'http://dummyimage.com/151x212.jpg/dddddd/000000', 'mcescotti9n@cisco.com', '171-520-8920', 'mcescotti9n', '06dMDV2Qx', '23360-160', 506, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (349, 'Paulie', 'Bolles', 'http://dummyimage.com/182x191.jpg/cc0000/ffffff', 'pbolles9o@qq.com', '874-711-4216', 'pbolles9o', '0sRh1ZGkmb', '54569-0406', 501, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (350, 'Spense', 'Jakeman', 'http://dummyimage.com/207x125.bmp/5fa2dd/ffffff', 'sjakeman9p@ucla.edu', '518-486-4694', 'sjakeman9p', '2yjrR9', '55714-4416', 502, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (351, 'Maddie', 'Trimmill', 'http://dummyimage.com/135x124.png/cc0000/ffffff', 'mtrimmill9q@foxnews.com', '581-568-8143', 'mtrimmill9q', 'y98Vw1fuO', '64778-0217', 503, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (352, 'Anitra', 'Tanzig', 'http://dummyimage.com/220x110.bmp/cc0000/ffffff', 'atanzig9r@fotki.com', '579-141-9247', 'atanzig9r', 'ygNm3MAV6', '29978-601', 504, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (353, 'Shandy', 'Darmody', 'http://dummyimage.com/199x215.jpg/5fa2dd/ffffff', 'sdarmody9s@elegantthemes.com', '388-509-5970', 'sdarmody9s', 'nDmXmFU', '55714-2277', 505, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (354, 'Nissy', 'Eunson', 'http://dummyimage.com/156x120.jpg/cc0000/ffffff', 'neunson9t@state.tx.us', '647-971-9644', 'neunson9t', 'tweqxj20Y', '68258-5980', 506, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (355, 'Kimbra', 'Ivashchenko', 'http://dummyimage.com/204x242.png/dddddd/000000', 'kivashchenko9u@liveinternet.ru', '483-550-7483', 'kivashchenko9u', 'oya2rNc', '68462-253', 501, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (356, 'Lily', 'Minchindon', 'http://dummyimage.com/181x213.jpg/ff4444/ffffff', 'lminchindon9v@360.cn', '913-832-9727', 'lminchindon9v', 'jrv1NIVg', '54973-3158', 502, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (357, 'Ninon', 'Kilgallen', 'http://dummyimage.com/132x156.bmp/ff4444/ffffff', 'nkilgallen9w@360.cn', '806-362-2109', 'nkilgallen9w', 'QbgAmkOQq', '68788-0561', 503, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (358, 'Dre', 'Brakewell', 'http://dummyimage.com/128x149.bmp/ff4444/ffffff', 'dbrakewell9x@barnesandnoble.com', '869-838-9180', 'dbrakewell9x', 'tv13jkW9Qv', '49981-009', 504, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (359, 'Rachele', 'Rupprecht', 'http://dummyimage.com/241x199.bmp/dddddd/000000', 'rrupprecht9y@miitbeian.gov.cn', '533-763-6580', 'rrupprecht9y', 'TiN9Zid', '42254-129', 505, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (360, 'Ajay', 'Joice', 'http://dummyimage.com/221x250.png/ff4444/ffffff', 'ajoice9z@wsj.com', '589-376-3039', 'ajoice9z', 'ZkZTzf7OpJr', '24987-425', 506, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (361, 'Traci', 'Podmore', 'http://dummyimage.com/185x103.bmp/5fa2dd/ffffff', 'tpodmorea0@linkedin.com', '889-301-5316', 'tpodmorea0', 'KNKUkTe0', '0268-1181', 501, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (362, 'Goldarina', 'De Biasi', 'http://dummyimage.com/111x159.bmp/5fa2dd/ffffff', 'gdebiasia1@cpanel.net', '597-108-3365', 'gdebiasia1', 'ci9oh64lS', '55154-6967', 502, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (363, 'Corie', 'Mapston', 'http://dummyimage.com/207x172.jpg/cc0000/ffffff', 'cmapstona2@gov.uk', '535-854-8449', 'cmapstona2', 'GoG5aC', '49580-0126', 503, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (364, 'Collete', 'Purcell', 'http://dummyimage.com/191x120.bmp/dddddd/000000', 'cpurcella3@hp.com', '320-275-4737', 'cpurcella3', '4xl6qEM1w67', '61328-006', 504, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (365, 'Tommy', 'Kittredge', 'http://dummyimage.com/145x120.bmp/dddddd/000000', 'tkittredgea4@ovh.net', '169-728-4880', 'tkittredgea4', '84tId1ZL91J', '58118-0684', 505, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (366, 'Stefan', 'Radbond', 'http://dummyimage.com/206x175.jpg/dddddd/000000', 'sradbonda5@omniture.com', '398-341-4260', 'sradbonda5', '0tPrcLdu7', '0642-0076', 506, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (367, 'Artair', 'Hardway', 'http://dummyimage.com/140x134.png/5fa2dd/ffffff', 'ahardwaya6@bandcamp.com', '515-702-0203', 'ahardwaya6', 'Fps06F7', '0135-0560', 501, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (368, 'Tabby', 'Teas', 'http://dummyimage.com/203x157.png/5fa2dd/ffffff', 'tteasa7@photobucket.com', '833-717-5173', 'tteasa7', 'JuUx1pZ', '55045-3259', 502, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (369, 'Valerye', 'Filchagin', 'http://dummyimage.com/146x164.jpg/dddddd/000000', 'vfilchagina8@narod.ru', '585-219-1857', 'vfilchagina8', '48lAba8F', '63187-172', 503, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (370, 'Willy', 'Strother', 'http://dummyimage.com/170x168.bmp/dddddd/000000', 'wstrothera9@latimes.com', '287-476-7379', 'wstrothera9', 'h0KDHlxxT', '0245-0087', 504, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (371, 'Marcellina', 'Duckham', 'http://dummyimage.com/216x119.jpg/dddddd/000000', 'mduckhamaa@fotki.com', '417-841-1385', 'mduckhamaa', 'it9vib', '11523-7216', 505, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (372, 'Fredi', 'Gilyatt', 'http://dummyimage.com/194x206.png/dddddd/000000', 'fgilyattab@cmu.edu', '361-620-8067', 'fgilyattab', 'nVHLUQzo5do', '0113-0402', 506, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (373, 'Adel', 'Tolworthie', 'http://dummyimage.com/143x106.bmp/cc0000/ffffff', 'atolworthieac@xinhuanet.com', '253-664-7872', 'atolworthieac', 'fGuRsGBdyEgQ', '41520-022', 501, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (374, 'Land', 'Hayller', 'http://dummyimage.com/247x195.jpg/cc0000/ffffff', 'lhayllerad@ocn.ne.jp', '712-408-8585', 'lhayllerad', '0fSQoBzh74Ew', '51079-982', 502, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (375, 'Morgen', 'Goodbur', 'http://dummyimage.com/107x149.bmp/dddddd/000000', 'mgoodburae@sciencedirect.com', '672-389-4275', 'mgoodburae', 'rrFAMEUgK9MO', '0641-6000', 503, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (376, 'Sidney', 'Gange', 'http://dummyimage.com/146x100.png/dddddd/000000', 'sgangeaf@goo.ne.jp', '569-443-9067', 'sgangeaf', 'gkymoZV5RHmm', '67046-127', 504, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (377, 'Theodore', 'Dionisetto', 'http://dummyimage.com/186x118.jpg/dddddd/000000', 'tdionisettoag@sciencedaily.com', '675-778-3962', 'tdionisettoag', '2o4towyPhVxX', '0555-0589', 505, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (378, 'Torrie', 'Lowfill', 'http://dummyimage.com/153x134.bmp/dddddd/000000', 'tlowfillah@networkadvertising.org', '105-479-6798', 'tlowfillah', '7yFeVeRhjo', '68472-118', 506, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (379, 'Sibby', 'Seeviour', 'http://dummyimage.com/104x141.png/ff4444/ffffff', 'sseeviourai@ucsd.edu', '117-837-7189', 'sseeviourai', 'dOGVfO4ap23N', '25021-451', 501, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (380, 'Cordy', 'Mousdall', 'http://dummyimage.com/142x155.jpg/ff4444/ffffff', 'cmousdallaj@jimdo.com', '718-261-9228', 'cmousdallaj', '4XXeHMO', '62032-125', 502, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (381, 'Cherrita', 'Burnsall', 'http://dummyimage.com/214x217.jpg/ff4444/ffffff', 'cburnsallak@wired.com', '633-412-8230', 'cburnsallak', 'nKnjAoT69V', '44567-505', 503, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (382, 'Solomon', 'Tinsey', 'http://dummyimage.com/172x111.bmp/5fa2dd/ffffff', 'stinseyal@homestead.com', '793-253-4497', 'stinseyal', 'y8Xouri', '59762-0009', 504, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (383, 'Anjela', 'Rosenberg', 'http://dummyimage.com/233x180.bmp/ff4444/ffffff', 'arosenbergam@digg.com', '390-129-3527', 'arosenbergam', 'CD97yE57', '64725-2957', 505, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (384, 'Perceval', 'Kleinmann', 'http://dummyimage.com/134x232.jpg/dddddd/000000', 'pkleinmannan@sogou.com', '255-574-0219', 'pkleinmannan', 'enrMlL1ZU', '21695-684', 506, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (385, 'Elmo', 'Weeke', 'http://dummyimage.com/146x121.bmp/5fa2dd/ffffff', 'eweekeao@cisco.com', '958-172-0653', 'eweekeao', '9vvRMeQHfW', '0264-7780', 501, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (386, 'Meyer', 'Riste', 'http://dummyimage.com/177x207.bmp/5fa2dd/ffffff', 'mristeap@yellowpages.com', '747-121-8138', 'mristeap', 'RBCFTq3', '44237-016', 502, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (387, 'Marcille', 'Ledgerton', 'http://dummyimage.com/232x221.png/cc0000/ffffff', 'mledgertonaq@a8.net', '106-209-0930', 'mledgertonaq', 'Z4hPnGLm', '65044-6723', 503, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (388, 'Hammad', 'Murricanes', 'http://dummyimage.com/175x125.bmp/5fa2dd/ffffff', 'hmurricanesar@washington.edu', '544-227-5317', 'hmurricanesar', 'pQFFF4KQ', '49288-0169', 504, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (389, 'Giles', 'Hawkey', 'http://dummyimage.com/230x112.png/5fa2dd/ffffff', 'ghawkeyas@tumblr.com', '976-804-0853', 'ghawkeyas', 'hCuYGIS', '0555-1021', 505, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (390, 'Adrianna', 'Gwynn', 'http://dummyimage.com/148x201.png/dddddd/000000', 'agwynnat@miibeian.gov.cn', '702-856-8141', 'agwynnat', 'B0hsqVR', '68462-394', 506, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (391, 'Raimundo', 'Duesbury', 'http://dummyimage.com/219x106.png/cc0000/ffffff', 'rduesburyau@mlb.com', '921-725-3141', 'rduesburyau', '2QPlYhFwJS', '52685-460', 501, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (392, 'Grace', 'Weedon', 'http://dummyimage.com/162x151.png/ff4444/ffffff', 'gweedonav@furl.net', '877-832-2425', 'gweedonav', 'xG86U7Ml', '33261-600', 502, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (393, 'Wendell', 'Suttle', 'http://dummyimage.com/164x247.png/dddddd/000000', 'wsuttleaw@buzzfeed.com', '613-896-6526', 'wsuttleaw', '4hmD2fTl0yHT', '65862-658', 503, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (394, 'Valencia', 'Arling', 'http://dummyimage.com/123x211.jpg/dddddd/000000', 'varlingax@ft.com', '918-846-2329', 'varlingax', 'csbuTIGMb', '58892-318', 504, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (395, 'Anthe', 'MacCorkell', 'http://dummyimage.com/178x242.bmp/ff4444/ffffff', 'amaccorkellay@mayoclinic.com', '349-646-6510', 'amaccorkellay', 'jLa3VYf', '51346-191', 505, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (396, 'Adelind', 'McAneny', 'http://dummyimage.com/105x241.bmp/cc0000/ffffff', 'amcanenyaz@vkontakte.ru', '524-901-6326', 'amcanenyaz', 'fce8150eNano', '43598-004', 506, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (397, 'Willem', 'Taye', 'http://dummyimage.com/113x149.jpg/cc0000/ffffff', 'wtayeb0@ameblo.jp', '156-892-0534', 'wtayeb0', 'GlhRK7iIBgsW', '0113-2013', 501, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (398, 'Heywood', 'Husthwaite', 'http://dummyimage.com/146x217.bmp/dddddd/000000', 'hhusthwaiteb1@msu.edu', '231-222-9459', 'hhusthwaiteb1', 'y5vzRF', '59535-4311', 502, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (399, 'Malory', 'Greenhalf', 'http://dummyimage.com/148x242.bmp/5fa2dd/ffffff', 'mgreenhalfb2@tripadvisor.com', '327-274-9331', 'mgreenhalfb2', 'l3vLYt5q', '54569-1444', 503, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (400, 'Annadiane', 'Carvilla', 'http://dummyimage.com/168x155.png/cc0000/ffffff', 'acarvillab3@bizjournals.com', '429-708-6803', 'acarvillab3', 'JxaNon', '76282-202', 504, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (401, 'Nicoli', 'Lyokhin', 'http://dummyimage.com/160x129.jpg/cc0000/ffffff', 'nlyokhinb4@cyberchimps.com', '217-597-7563', 'nlyokhinb4', 'caoVT519x0h', '0187-1611', 505, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (402, 'Jacquenetta', 'Crate', 'http://dummyimage.com/183x196.png/ff4444/ffffff', 'jcrateb5@twitter.com', '478-374-2318', 'jcrateb5', 'kjdyt0FxDj', '63323-172', 506, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (403, 'Raul', 'Whitebrook', 'http://dummyimage.com/207x188.jpg/cc0000/ffffff', 'rwhitebrookb6@skype.com', '616-803-5574', 'rwhitebrookb6', 'TCfcc5gFWG', '55154-9610', 501, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (404, 'Georgi', 'Nilges', 'http://dummyimage.com/240x222.png/ff4444/ffffff', 'gnilgesb7@weebly.com', '188-857-8646', 'gnilgesb7', '6cWx66eKBkQ', '0498-0016', 502, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (405, 'Saloma', 'Lindenbluth', 'http://dummyimage.com/225x136.jpg/dddddd/000000', 'slindenbluthb8@state.gov', '414-411-7199', 'slindenbluthb8', '5TRlUvG', '68345-272', 503, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (406, 'Constance', 'Manhare', 'http://dummyimage.com/217x145.bmp/cc0000/ffffff', 'cmanhareb9@guardian.co.uk', '278-856-5832', 'cmanhareb9', 'cqG4Z20qvrJ', '41520-505', 504, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (407, 'Fidelio', 'Hedling', 'http://dummyimage.com/214x242.png/dddddd/000000', 'fhedlingba@sphinn.com', '425-952-1631', 'fhedlingba', '765OZh3gzK', '60681-2705', 505, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (408, 'Brittne', 'Larking', 'http://dummyimage.com/183x110.bmp/ff4444/ffffff', 'blarkingbb@time.com', '470-375-5438', 'blarkingbb', '1PR4pdu7LZ', '54868-6278', 506, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (409, 'Grete', 'Gile', 'http://dummyimage.com/235x180.png/cc0000/ffffff', 'ggilebc@naver.com', '796-789-8390', 'ggilebc', 'DQdMngSa', '61941-0132', 501, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (410, 'Griffie', 'Bader', 'http://dummyimage.com/106x242.jpg/ff4444/ffffff', 'gbaderbd@myspace.com', '120-284-9975', 'gbaderbd', 'EEMwcV', '68084-401', 502, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (411, 'Debi', 'Pavese', 'http://dummyimage.com/114x154.png/ff4444/ffffff', 'dpavesebe@squidoo.com', '150-312-5667', 'dpavesebe', 'mHPapj9FLSNX', '67938-1172', 503, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (412, 'Felicdad', 'Jagg', 'http://dummyimage.com/181x228.png/ff4444/ffffff', 'fjaggbf@sitemeter.com', '193-700-9466', 'fjaggbf', '0h9R7qS8j', '64117-831', 504, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (413, 'Erny', 'Cardiff', 'http://dummyimage.com/201x224.png/5fa2dd/ffffff', 'ecardiffbg@nationalgeographic.com', '171-257-5183', 'ecardiffbg', 'RklslczZbzFv', '16252-562', 505, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (414, 'Matthew', 'Sutherden', 'http://dummyimage.com/221x139.png/5fa2dd/ffffff', 'msutherdenbh@usnews.com', '495-312-9107', 'msutherdenbh', 'uNzBjHvs', '43419-515', 506, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (415, 'Robbie', 'Gilroy', 'http://dummyimage.com/142x166.png/5fa2dd/ffffff', 'rgilroybi@salon.com', '587-217-6673', 'rgilroybi', 'SglOWBef4Dk8', '47918-004', 501, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (416, 'Domingo', 'Meni', 'http://dummyimage.com/181x125.bmp/cc0000/ffffff', 'dmenibj@reverbnation.com', '131-929-0913', 'dmenibj', 'YCl5J4IpN4k2', '49349-700', 502, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (417, 'Biddie', 'Rosthorn', 'http://dummyimage.com/133x136.png/ff4444/ffffff', 'brosthornbk@behance.net', '462-976-7662', 'brosthornbk', '4omtnoBu', '54365-400', 503, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (418, 'Winnah', 'Pietzker', 'http://dummyimage.com/208x201.jpg/ff4444/ffffff', 'wpietzkerbl@sina.com.cn', '489-820-7264', 'wpietzkerbl', 'oA9WCvC8Us', '57664-116', 504, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (419, 'Carling', 'Gannicleff', 'http://dummyimage.com/119x138.bmp/5fa2dd/ffffff', 'cgannicleffbm@chicagotribune.com', '980-542-3631', 'cgannicleffbm', 'nwIFWc', '61442-121', 505, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (420, 'Josi', 'Laverock', 'http://dummyimage.com/212x216.bmp/5fa2dd/ffffff', 'jlaverockbn@reuters.com', '848-109-0695', 'jlaverockbn', '84qLN5uwAe', '0527-1475', 506, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (421, 'Ferris', 'Tippetts', 'http://dummyimage.com/156x180.jpg/cc0000/ffffff', 'ftippettsbo@liveinternet.ru', '919-765-5764', 'ftippettsbo', '71EmC1J', '12213-720', 501, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (422, 'Shirlee', 'Aizikov', 'http://dummyimage.com/212x182.png/dddddd/000000', 'saizikovbp@prweb.com', '487-215-9847', 'saizikovbp', 'UnS7GgWFQn', '37205-822', 502, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (423, 'Sandra', 'Varran', 'http://dummyimage.com/141x239.png/cc0000/ffffff', 'svarranbq@google.it', '361-678-5429', 'svarranbq', 'nLHpjB3uyh', '49999-818', 503, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (424, 'Obadias', 'Handy', 'http://dummyimage.com/125x241.bmp/cc0000/ffffff', 'ohandybr@hugedomains.com', '301-792-7946', 'ohandybr', 'AgPsdAVSm', '41250-903', 504, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (425, 'Nicholas', 'Knoble', 'http://dummyimage.com/237x130.png/dddddd/000000', 'nknoblebs@noaa.gov', '435-965-0756', 'nknoblebs', '0QAkrcG5Wr1', '34645-4021', 505, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (426, 'Gianina', 'Lancett', 'http://dummyimage.com/199x200.jpg/5fa2dd/ffffff', 'glancettbt@simplemachines.org', '361-578-7273', 'glancettbt', 'HffFVnU1', '43269-664', 506, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (427, 'Faustine', 'Bertolin', 'http://dummyimage.com/150x227.jpg/ff4444/ffffff', 'fbertolinbu@wisc.edu', '908-140-2147', 'fbertolinbu', '9suP6agEyP', '55264-020', 501, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (428, 'Selby', 'Murkus', 'http://dummyimage.com/172x123.bmp/dddddd/000000', 'smurkusbv@livejournal.com', '567-113-5754', 'smurkusbv', 'rnfDKEWnQPAa', '22431-582', 502, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (429, 'Burton', 'Mateja', 'http://dummyimage.com/175x171.bmp/cc0000/ffffff', 'bmatejabw@wordpress.org', '588-819-5166', 'bmatejabw', 'f2TY0zvWMfpt', '55154-5561', 503, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (430, 'Cos', 'Ringham', 'http://dummyimage.com/227x171.jpg/5fa2dd/ffffff', 'cringhambx@java.com', '664-372-7837', 'cringhambx', '7Qn4gk6vdq', '10237-741', 504, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (431, 'Keir', 'Kryska', 'http://dummyimage.com/216x142.bmp/dddddd/000000', 'kkryskaby@sun.com', '907-423-6336', 'kkryskaby', 'FtC5qe1l', '51079-465', 505, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (432, 'Langston', 'MacGilfoyle', 'http://dummyimage.com/154x242.jpg/dddddd/000000', 'lmacgilfoylebz@oakley.com', '714-262-6490', 'lmacgilfoylebz', 'Pm4u1ByNW0H', '67457-265', 506, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (433, 'Pammy', 'Whale', 'http://dummyimage.com/187x187.png/dddddd/000000', 'pwhalec0@studiopress.com', '370-593-0162', 'pwhalec0', 'WYTF90', '59630-629', 501, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (434, 'Erny', 'Bowller', 'http://dummyimage.com/218x177.bmp/dddddd/000000', 'ebowllerc1@pcworld.com', '703-361-1724', 'ebowllerc1', 'MR82wx', '65862-164', 502, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (435, 'Alberto', 'Deavin', 'http://dummyimage.com/203x143.png/5fa2dd/ffffff', 'adeavinc2@msu.edu', '850-405-2917', 'adeavinc2', 'EjhO0vTfi8G', '58232-9201', 503, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (436, 'Wilona', 'Medcalfe', 'http://dummyimage.com/117x170.jpg/cc0000/ffffff', 'wmedcalfec3@amazon.co.jp', '894-328-7312', 'wmedcalfec3', 'nElGwZD', '49738-300', 504, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (437, 'Dael', 'Broose', 'http://dummyimage.com/106x178.png/dddddd/000000', 'dbroosec4@privacy.gov.au', '415-875-7984', 'dbroosec4', '3q1nHJPD', '62670-4829', 505, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (438, 'Toddie', 'Bew', 'http://dummyimage.com/111x204.bmp/cc0000/ffffff', 'tbewc5@blog.com', '940-228-9913', 'tbewc5', 'ruxQ2wu', '0168-0056', 506, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (439, 'Brenda', 'Maryott', 'http://dummyimage.com/249x203.jpg/5fa2dd/ffffff', 'bmaryottc6@cdc.gov', '636-255-9253', 'bmaryottc6', 'AoiXbpL', '0268-0856', 501, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (440, 'Andra', 'Kippax', 'http://dummyimage.com/141x198.png/dddddd/000000', 'akippaxc7@globo.com', '713-103-3313', 'akippaxc7', 'D47sioHRk8', '47335-675', 502, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (441, 'Tripp', 'Kighly', 'http://dummyimage.com/110x144.jpg/dddddd/000000', 'tkighlyc8@businessinsider.com', '671-452-5033', 'tkighlyc8', 'gvZdqdNPVjEx', '35356-469', 503, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (442, 'Irwinn', 'Fransman', 'http://dummyimage.com/238x125.jpg/cc0000/ffffff', 'ifransmanc9@geocities.jp', '589-220-1851', 'ifransmanc9', 'Wrsaaml7o', '21695-555', 504, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (443, 'Karoline', 'Garroch', 'http://dummyimage.com/166x235.png/dddddd/000000', 'kgarrochca@google.ca', '387-196-0415', 'kgarrochca', '8RPAakIZawB', '0615-4513', 505, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (444, 'Simonette', 'Boncore', 'http://dummyimage.com/237x166.jpg/cc0000/ffffff', 'sboncorecb@cmu.edu', '710-778-5838', 'sboncorecb', 'iXX2k1Do', '55714-2204', 506, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (445, 'Sigrid', 'Dearl', 'http://dummyimage.com/107x211.jpg/dddddd/000000', 'sdearlcc@miitbeian.gov.cn', '478-225-4256', 'sdearlcc', 'vnsg7dlIOSgd', '11822-0692', 501, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (446, 'Crystie', 'Castanares', 'http://dummyimage.com/247x240.png/5fa2dd/ffffff', 'ccastanarescd@comcast.net', '442-971-3145', 'ccastanarescd', 'WRwvGKiF', '54162-015', 502, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (447, 'Lil', 'McIlvaney', 'http://dummyimage.com/180x220.png/ff4444/ffffff', 'lmcilvaneyce@columbia.edu', '600-771-2343', 'lmcilvaneyce', 'jqEo3kdYIJm', '0904-6088', 503, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (448, 'Brock', 'Kinney', 'http://dummyimage.com/176x184.png/dddddd/000000', 'bkinneycf@unicef.org', '463-309-3377', 'bkinneycf', 'TE0h1REj', '51134-0064', 504, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (449, 'Lynda', 'Evins', 'http://dummyimage.com/233x208.jpg/ff4444/ffffff', 'levinscg@networksolutions.com', '506-648-1867', 'levinscg', 'n246lmo', '57955-1830', 505, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (450, 'Ricca', 'Griniov', 'http://dummyimage.com/145x235.jpg/dddddd/000000', 'rgriniovch@msu.edu', '775-775-1625', 'rgriniovch', 'HTNNCXwZCS', '63739-557', 506, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (451, 'Ed', 'Peter', 'http://dummyimage.com/129x206.jpg/cc0000/ffffff', 'epeterci@elegantthemes.com', '738-233-0041', 'epeterci', 'IWdaoX', '60681-1403', 501, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (452, 'Lock', 'Slemming', 'http://dummyimage.com/114x113.bmp/ff4444/ffffff', 'lslemmingcj@google.co.jp', '336-327-0332', 'lslemmingcj', '76H1wYHT', '16590-992', 502, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (453, 'Jephthah', 'O''Day', 'http://dummyimage.com/179x184.bmp/dddddd/000000', 'jodayck@nydailynews.com', '316-749-4839', 'jodayck', 'OzHw2YC0Y', '16714-393', 503, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (454, 'Lauren', 'Worsnup', 'http://dummyimage.com/188x238.bmp/cc0000/ffffff', 'lworsnupcl@newsvine.com', '757-857-6351', 'lworsnupcl', 'EQKPkw', '0268-1021', 504, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (455, 'Isadore', 'Easen', 'http://dummyimage.com/118x120.jpg/5fa2dd/ffffff', 'ieasencm@ucoz.com', '391-555-6415', 'ieasencm', 'mVCnohf', '25021-202', 505, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (456, 'Ellwood', 'Weaver', 'http://dummyimage.com/172x220.bmp/ff4444/ffffff', 'eweavercn@wisc.edu', '699-489-0477', 'eweavercn', 'oetEwF', '68788-9047', 506, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (457, 'Nalani', 'Ritchard', 'http://dummyimage.com/162x131.jpg/cc0000/ffffff', 'nritchardco@huffingtonpost.com', '148-587-5094', 'nritchardco', 'yD3oETNPY', '56062-804', 501, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (458, 'Ambrosio', 'Gladbeck', 'http://dummyimage.com/177x130.jpg/dddddd/000000', 'agladbeckcp@ameblo.jp', '186-886-4928', 'agladbeckcp', 'nvR0YsQBf', '24987-097', 502, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (459, 'Somerset', 'Cadigan', 'http://dummyimage.com/129x152.bmp/ff4444/ffffff', 'scadigancq@feedburner.com', '747-802-0390', 'scadigancq', 'x8MYeFpDQD', '60193-100', 503, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (460, 'Keelia', 'Rissom', 'http://dummyimage.com/241x200.bmp/ff4444/ffffff', 'krissomcr@stumbleupon.com', '526-668-9804', 'krissomcr', 'aA3y7C', '58118-0105', 504, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (461, 'Valentijn', 'Pasticznyk', 'http://dummyimage.com/178x115.jpg/dddddd/000000', 'vpasticznykcs@microsoft.com', '882-431-0596', 'vpasticznykcs', '3iu4aF45', '0781-3178', 505, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (462, 'Cymbre', 'Caisley', 'http://dummyimage.com/220x248.png/dddddd/000000', 'ccaisleyct@clickbank.net', '169-410-2504', 'ccaisleyct', 'jHAPnuOpDnV', '36987-2712', 506, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (463, 'Fons', 'Ludgrove', 'http://dummyimage.com/110x185.jpg/ff4444/ffffff', 'fludgrovecu@ask.com', '232-137-8807', 'fludgrovecu', 'BtR3bSj', '62721-0118', 501, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (464, 'Vladamir', 'Balaison', 'http://dummyimage.com/233x116.jpg/5fa2dd/ffffff', 'vbalaisoncv@hhs.gov', '917-140-8933', 'vbalaisoncv', 'LuqkYNc', '51079-454', 502, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (465, 'Vance', 'Crommett', 'http://dummyimage.com/124x214.jpg/5fa2dd/ffffff', 'vcrommettcw@webeden.co.uk', '631-825-9804', 'vcrommettcw', 'wBX5BZsVne', '63304-437', 503, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (466, 'Eleonore', 'Kupisz', 'http://dummyimage.com/210x247.png/5fa2dd/ffffff', 'ekupiszcx@cbc.ca', '793-229-6153', 'ekupiszcx', 'Cn4v6ScIaD', '46122-259', 504, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (467, 'Myrwyn', 'Shaplin', 'http://dummyimage.com/247x155.jpg/ff4444/ffffff', 'mshaplincy@reference.com', '886-329-3118', 'mshaplincy', '7RTMbvbP5', '36987-1738', 505, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (468, 'Kendra', 'Gricks', 'http://dummyimage.com/195x137.bmp/dddddd/000000', 'kgrickscz@yahoo.com', '771-665-5408', 'kgrickscz', 'XXXQEnyQ', '60778-030', 506, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (469, 'Charis', 'Tromans', 'http://dummyimage.com/115x232.png/ff4444/ffffff', 'ctromansd0@google.co.jp', '616-121-9269', 'ctromansd0', 'xRDBa2C3f', '52125-725', 501, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (470, 'Damian', 'Addie', 'http://dummyimage.com/108x162.bmp/ff4444/ffffff', 'daddied1@youtu.be', '217-982-0436', 'daddied1', 'mu6g0r', '55648-965', 502, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (471, 'Ricki', 'Harrod', 'http://dummyimage.com/168x116.png/5fa2dd/ffffff', 'rharrodd2@usda.gov', '957-613-7807', 'rharrodd2', '7VCx2bX', '51824-473', 503, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (472, 'Audy', 'Jansky', 'http://dummyimage.com/143x165.bmp/cc0000/ffffff', 'ajanskyd3@goodreads.com', '760-674-8563', 'ajanskyd3', 'rKftQyp', '52125-507', 504, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (473, 'Blisse', 'MacKibbon', 'http://dummyimage.com/118x157.jpg/ff4444/ffffff', 'bmackibbond4@ibm.com', '398-858-6790', 'bmackibbond4', 'q24DhPtgjvDr', '59663-100', 505, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (474, 'Thadeus', 'Howroyd', 'http://dummyimage.com/118x227.png/dddddd/000000', 'thowroydd5@artisteer.com', '839-501-0563', 'thowroydd5', 'yvUv4XNoM', '68391-242', 506, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (475, 'Lazar', 'Carlyle', 'http://dummyimage.com/158x208.bmp/5fa2dd/ffffff', 'lcarlyled6@github.io', '169-213-5442', 'lcarlyled6', 'j3KLwaWjIE', '59667-0014', 501, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (476, 'Linet', 'Zoane', 'http://dummyimage.com/220x156.jpg/cc0000/ffffff', 'lzoaned7@wiley.com', '117-657-8025', 'lzoaned7', 'QuRYgA', '0056-0189', 502, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (477, 'Aloisia', 'Dungay', 'http://dummyimage.com/134x111.jpg/cc0000/ffffff', 'adungayd8@photobucket.com', '124-996-0374', 'adungayd8', 'vsJvV6hV4v', '55319-503', 503, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (478, 'Rosemaria', 'Scupham', 'http://dummyimage.com/173x172.bmp/cc0000/ffffff', 'rscuphamd9@e-recht24.de', '852-648-0632', 'rscuphamd9', 'ixBnhbuu4PJR', '63029-100', 504, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (479, 'Laney', 'Triebner', 'http://dummyimage.com/182x224.png/ff4444/ffffff', 'ltriebnerda@github.io', '166-945-2946', 'ltriebnerda', 'xFOJRM3M', '42236-002', 505, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (480, 'Tucky', 'Mattke', 'http://dummyimage.com/113x217.bmp/ff4444/ffffff', 'tmattkedb@dmoz.org', '294-238-1972', 'tmattkedb', 'tuaUb8', '55316-400', 506, 730);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (481, 'Parke', 'Hanbridge', 'http://dummyimage.com/171x207.bmp/cc0000/ffffff', 'phanbridgedc@unicef.org', '674-690-6654', 'phanbridgedc', 'KOT5TxqIc', '76058-105', 501, 711);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (482, 'Garret', 'Dunrige', 'http://dummyimage.com/236x243.jpg/ff4444/ffffff', 'gdunrigedd@t-online.de', '347-800-9878', 'gdunrigedd', 'xYSI46', '0173-0750', 502, 712);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (483, 'Sheilah', 'Eagar', 'http://dummyimage.com/109x111.bmp/ff4444/ffffff', 'seagarde@engadget.com', '514-732-8444', 'seagarde', '4rxMyDS', '41250-300', 503, 713);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (484, 'Ophelie', 'Kiwitz', 'http://dummyimage.com/229x234.bmp/ff4444/ffffff', 'okiwitzdf@gmpg.org', '420-516-9799', 'okiwitzdf', 'INO5kLeP', '15127-002', 504, 714);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (485, 'Staci', 'Whiffin', 'http://dummyimage.com/145x219.jpg/ff4444/ffffff', 'swhiffindg@mapquest.com', '564-973-5335', 'swhiffindg', 'vkFRdLM5', '49999-038', 505, 715);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (486, 'Sidoney', 'Filippone', 'http://dummyimage.com/162x122.jpg/cc0000/ffffff', 'sfilipponedh@mit.edu', '432-179-1368', 'sfilipponedh', '8X7BsyMbw', '50844-157', 506, 716);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (487, 'Archambault', 'Bartomeu', 'http://dummyimage.com/244x109.jpg/dddddd/000000', 'abartomeudi@columbia.edu', '927-350-2377', 'abartomeudi', 'tqGEooFlrwzH', '10356-831', 501, 717);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (488, 'Marnie', 'Davidovitch', 'http://dummyimage.com/192x172.jpg/cc0000/ffffff', 'mdavidovitchdj@godaddy.com', '147-830-8949', 'mdavidovitchdj', 'piGXxEJ', '63551-221', 502, 718);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (489, 'Olva', 'Bamlett', 'http://dummyimage.com/217x213.bmp/ff4444/ffffff', 'obamlettdk@europa.eu', '860-467-3923', 'obamlettdk', 'LPqPOE5Yjb', '12546-219', 503, 719);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (490, 'Fidela', 'Hedden', 'http://dummyimage.com/163x238.png/cc0000/ffffff', 'fheddendl@constantcontact.com', '944-198-5981', 'fheddendl', 'YQ05pzg5o6Nh', '57955-0724', 504, 720);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (491, 'Jillana', 'Skim', 'http://dummyimage.com/144x153.bmp/ff4444/ffffff', 'jskimdm@hud.gov', '110-704-3877', 'jskimdm', 'gTJaFcW', '13811-657', 505, 721);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (492, 'Robby', 'Samart', 'http://dummyimage.com/140x205.jpg/ff4444/ffffff', 'rsamartdn@businessinsider.com', '496-561-2348', 'rsamartdn', 'hilmwMOi3', '43063-232', 506, 722);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (493, 'Rockwell', 'Folds', 'http://dummyimage.com/155x225.png/dddddd/000000', 'rfoldsdo@lycos.com', '901-342-7031', 'rfoldsdo', 'AXmKdXS57N', '0009-0234', 501, 723);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (494, 'Hadleigh', 'Baylay', 'http://dummyimage.com/238x119.jpg/5fa2dd/ffffff', 'hbaylaydp@e-recht24.de', '525-378-4158', 'hbaylaydp', 'xyzz41MpNg5', '63629-1674', 502, 724);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (495, 'Ingram', 'Van Arsdall', 'http://dummyimage.com/224x245.png/cc0000/ffffff', 'ivanarsdalldq@g.co', '565-723-6548', 'ivanarsdalldq', 'KQMGrehJsJW', '51079-903', 503, 725);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (496, 'Jeth', 'Ricci', 'http://dummyimage.com/166x243.png/ff4444/ffffff', 'jriccidr@seattletimes.com', '469-730-8806', 'jriccidr', 'pK1hSfBqSt', '68479-013', 504, 726);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (497, 'Consuela', 'Kearley', 'http://dummyimage.com/117x109.bmp/cc0000/ffffff', 'ckearleyds@eepurl.com', '796-396-9549', 'ckearleyds', 'cD4w3hhOsoP0', '68462-555', 505, 727);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (498, 'Tabitha', 'Dupree', 'http://dummyimage.com/143x218.png/dddddd/000000', 'tdupreedt@eepurl.com', '914-292-7673', 'tdupreedt', '1GiTpdnnYBk1', '53808-0983', 506, 728);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (499, 'Trueman', 'Gregine', 'http://dummyimage.com/166x168.png/ff4444/ffffff', 'tgreginedu@acquirethisname.com', '932-409-6519', 'tgreginedu', 'nHppChV', '76237-223', 501, 729);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (500, 'Somerset', 'Peaurt', 'http://dummyimage.com/145x190.bmp/dddddd/000000', 'speaurtdv@github.com', '856-404-5170', 'speaurtdv', 'J9cRasnv', '63981-766', 502, 730);



--SERVICIOS
 
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2000, '2/22/2018', '9:49 PM', 14.71, 71, '0 Pankratz Junction', '961 Lindbergh Trail', 49644.7, 'CANCELADO', 'F', 1, 711, 862, 1, 2200);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2001, '2/10/2018', '8:08 AM', 44.84, 63, '9 Gale Trail', '1 Hollow Ridge Terrace', 29459.37, 'FINALIZADO', 'V', 2, 712, 865, 2, 2201);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2002, '6/25/2018', '6:41 AM', 93.46, 53, '9 Hoepker Crossing', '5 Crest Line Trail', 66683.1, 'CANCELADO', 'V', 3, 713, 821, 3, 2202);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2003, '5/17/2018', '11:39 AM', 89.41, 47, '8 Steensland Center', '1345 Sutherland Trail', 96442.34, 'FINALIZADO', 'F', 4, 714, 972, 4, 2203);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2004, '3/6/2018', '3:09 PM', 68.61, 27, '0035 Victoria Junction', '969 Merchant Junction', 68011.51, 'CANCELADO', 'F', 1, 715, 999, 5, 2204);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2005, '3/12/2018', '10:32 PM', 10.56, 25, '6517 Bellgrove Drive', '5915 Ronald Regan Center', 86929.03, 'FINALIZADO', 'V', 2, 716, 860, 6, 2205);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2006, '7/19/2018', '4:36 AM', 94.76, 34, '003 Comanche Alley', '45527 Superior Place', 43800.15, 'FINALIZADO', 'V', 3, 717, 842, 7, 2206);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2007, '1/10/2018', '2:21 AM', 91.84, 54, '41 Bunker Hill Center', '92 Daystar Point', 87984.19, 'CANCELADO', 'F', 4, 718, 871, 8, 2207);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2008, '2/9/2018', '9:16 AM', 97.83, 46, '4 Brickson Park Crossing', '24 Onsgard Road', 16630.83, 'CANCELADO', 'V', 1, 719, 855, 9, 2208);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2009, '2/18/2018', '6:36 AM', 80.73, 97, '49 Stang Parkway', '9251 Parkside Circle', 8348.77, 'FINALIZADO', 'F', 2, 720, 837, 10, 2209);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2010, '12/31/2017', '7:42 AM', 18.66, 44, '00345 Morning Court', '7034 Bobwhite Street', 99753.12, 'CANCELADO', 'F', 3, 721, 997, 11, 2210);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2011, '8/4/2018', '12:23 PM', 30.2, 87, '73290 Kingsford Pass', '0345 Bunker Hill Junction', 57771.86, 'FINALIZADO', 'F', 4, 722, 958, 12, 2211);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2012, '6/11/2018', '2:32 AM', 44.88, 39, '5448 Bay Court', '46810 Becker Terrace', 25216.7, 'FINALIZADO', 'V', 1, 723, 928, 13, 2212);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2013, '4/26/2018', '12:32 PM', 36.64, 72, '87 Forster Alley', '99449 Prairieview Lane', 76810.54, 'FINALIZADO', 'F', 2, 724, 936, 14, 2213);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2014, '12/22/2017', '1:39 PM', 17.93, 81, '7199 Morrow Junction', '914 Parkside Place', 69183.38, 'FINALIZADO', 'F', 3, 725, 887, 15, 2214);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2015, '6/19/2018', '11:37 PM', 48.12, 16, '70 Raven Drive', '3 Myrtle Pass', 79441.33, 'FINALIZADO', 'V', 4, 726, 810, 16, 2215);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2016, '9/29/2017', '7:04 PM', 22.98, 74, '72701 Oakridge Terrace', '246 Debra Avenue', 75915.7, 'CANCELADO', 'F', 1, 727, 809, 17, 2216);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2017, '11/4/2017', '1:55 AM', 2.1, 29, '3 Kings Plaza', '6 Independence Point', 30124.24, 'FINALIZADO', 'F', 2, 728, 894, 18, 2217);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2018, '9/28/2018', '1:22 PM', 74.78, 25, '24 Sunfield Drive', '98386 Anthes Road', 20666.94, 'FINALIZADO', 'V', 3, 729, 944, 19, 2218);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2019, '7/4/2018', '4:34 PM', 82.46, 39, '488 New Castle Drive', '3 Boyd Hill', 70712.27, 'FINALIZADO', 'F', 4, 730, 988, 20, 2219);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2020, '7/6/2018', '1:50 PM', 96.59, 26, '5 Valley Edge Junction', '84 Bluestem Drive', 84934.36, 'FINALIZADO', 'F', 1, 711, 802, 21, 2220);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2021, '10/4/2017', '11:14 AM', 1.11, 86, '53561 Vera Trail', '9459 Sunfield Crossing', 16607.1, 'CANCELADO', 'V', 2, 712, 872, 22, 2221);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2022, '9/9/2018', '9:07 PM', 85.9, 20, '782 Stang Avenue', '40247 Straubel Hill', 25691.89, 'FINALIZADO', 'V', 3, 713, 886, 23, 2222);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2023, '4/12/2018', '5:39 PM', 77.77, 24, '01 Havey Plaza', '90025 Shoshone Lane', 48888.61, 'CANCELADO', 'F', 4, 714, 886, 24, 2223);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2024, '5/13/2018', '9:08 AM', 31.19, 72, '87959 Gale Lane', '975 Merry Alley', 62098.59, 'FINALIZADO', 'V', 1, 715, 964, 25, 2224);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2025, '7/18/2018', '8:48 AM', 12.35, 42, '35961 Colorado Court', '6 Waywood Parkway', 29303.13, 'FINALIZADO', 'V', 2, 716, 983, 26, 2225);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2026, '5/18/2018', '8:25 AM', 32.79, 40, '1 Linden Way', '6 Lighthouse Bay Street', 91877.24, 'CANCELADO', 'V', 3, 717, 842, 27, 2226);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2027, '3/19/2018', '3:13 AM', 88.82, 63, '0 Trailsway Place', '4 Warbler Hill', 83473.0, 'CANCELADO', 'V', 4, 718, 845, 28, 2227);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2028, '3/31/2018', '5:37 PM', 95.73, 87, '69 Bunting Lane', '28596 Cascade Hill', 32719.26, 'CANCELADO', 'F', 1, 719, 893, 29, 2228);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2029, '4/25/2018', '1:26 PM', 50.11, 29, '9889 Bonner Point', '5393 Buhler Alley', 16886.79, 'FINALIZADO', 'V', 2, 720, 845, 30, 2229);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2030, '11/16/2017', '2:16 PM', 31.46, 50, '96878 Elka Place', '33 Loomis Park', 7285.89, 'CANCELADO', 'V', 3, 721, 913, 31, 2230);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2031, '1/3/2018', '7:19 AM', 35.42, 86, '772 Westridge Avenue', '345 Hallows Pass', 75672.04, 'CANCELADO', 'V', 4, 722, 851, 32, 2231);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2032, '9/14/2018', '4:35 PM', 6.32, 51, '2 Dayton Trail', '6057 Lyons Pass', 29162.52, 'FINALIZADO', 'V', 1, 723, 905, 33, 2232);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2033, '9/14/2018', '6:07 AM', 25.68, 5, '30587 2nd Street', '34 Charing Cross Circle', 67211.8, 'CANCELADO', 'F', 2, 724, 841, 34, 2233);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2034, '2/22/2018', '9:21 AM', 43.74, 1, '55 Manley Center', '06 Bunker Hill Way', 52791.18, 'FINALIZADO', 'F', 3, 725, 948, 35, 2234);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2035, '3/23/2018', '10:53 PM', 32.99, 81, '71 Dorton Center', '82 Manufacturers Place', 66375.19, 'CANCELADO', 'V', 4, 726, 968, 36, 2235);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2036, '2/14/2018', '9:17 PM', 75.27, 58, '5 Vahlen Plaza', '17 Welch Park', 30588.44, 'FINALIZADO', 'F', 1, 727, 970, 37, 2236);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2037, '2/11/2018', '11:12 AM', 18.36, 27, '78803 Lillian Street', '08 Hermina Junction', 86613.19, 'FINALIZADO', 'V', 2, 728, 984, 38, 2237);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2038, '1/24/2018', '11:31 AM', 9.23, 26, '27 Thierer Place', '3845 Bowman Circle', 70817.25, 'CANCELADO', 'F', 3, 729, 958, 39, 2238);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2039, '12/4/2017', '3:29 PM', 2.08, 44, '468 School Junction', '2 Mandrake Trail', 66656.24, 'FINALIZADO', 'F', 4, 730, 922, 40, 2239);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2040, '10/22/2017', '9:36 PM', 21.79, 27, '333 Lakeland Plaza', '40 Maple Wood Way', 18921.42, 'FINALIZADO', 'V', 1, 711, 924, 41, 2240);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2041, '1/15/2018', '6:56 PM', 97.3, 90, '22 Boyd Circle', '74 Eastlawn Circle', 29042.86, 'CANCELADO', 'F', 2, 712, 918, 42, 2241);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2042, '8/6/2018', '5:12 PM', 23.14, 73, '6 Rutledge Avenue', '6 Bunting Parkway', 16254.14, 'CANCELADO', 'V', 3, 713, 812, 43, 2242);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2043, '10/30/2017', '3:17 PM', 40.42, 95, '2 Welch Lane', '72 Westport Center', 49366.64, 'CANCELADO', 'V', 4, 714, 940, 44, 2243);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2044, '4/18/2018', '7:09 PM', 20.78, 23, '79928 Commercial Place', '7304 Harbort Terrace', 14741.49, 'FINALIZADO', 'F', 1, 715, 902, 45, 2244);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2045, '6/1/2018', '8:37 PM', 43.43, 1, '213 Cascade Parkway', '58019 Ridge Oak Plaza', 32086.83, 'CANCELADO', 'V', 2, 716, 954, 46, 2245);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2046, '1/18/2018', '2:46 PM', 24.11, 79, '6 Fremont Street', '6915 Hermina Pass', 10415.79, 'FINALIZADO', 'V', 3, 717, 967, 47, 2246);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2047, '7/24/2018', '7:17 AM', 58.21, 72, '62753 New Castle Alley', '8767 Mosinee Hill', 78544.61, 'CANCELADO', 'V', 4, 718, 889, 48, 2247);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2048, '6/16/2018', '6:25 AM', 1.74, 30, '0 Lakeland Court', '0097 Blue Bill Park Plaza', 24133.57, 'FINALIZADO', 'V', 1, 719, 910, 49, 2248);
insert into SERVICIOS (ID, FECHA, HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID, SERVICIO_COMPARTIDO_CLIENTE_ID ) values (2049, '6/9/2018', '11:50 AM', 23.19, 2, '149 Mayer Park', '3 Continental Court', 11537.74, 'CANCELADO', 'F', 2, 720, 888, 50, 2249);




--MEDIOS PAGO

insert into MEDIOS_PAGO (ID, DESCRIPCION) values (1, 'EFECTIVO');
insert into MEDIOS_PAGO (ID, DESCRIPCION) values (2, 'CREDITO');
insert into MEDIOS_PAGO (ID, DESCRIPCION) values (3, 'DEBITO');
insert into MEDIOS_PAGO (ID, DESCRIPCION) values (4, 'PAYPAL');


--IDIOMAS

insert into IDIOMAS (ID, DESCRIPCION, ABREVIATURA) values (501, 'INGLES', 'ING');
insert into IDIOMAS (ID, DESCRIPCION, ABREVIATURA) values (502, 'ESPAҏL', 'ESP');
insert into IDIOMAS (ID, DESCRIPCION, ABREVIATURA) values (503, 'ALEMAN', 'ALE');
insert into IDIOMAS (ID, DESCRIPCION, ABREVIATURA) values (504, 'PORTUGUES', 'POR');
insert into IDIOMAS (ID, DESCRIPCION, ABREVIATURA) values (505, 'FRANCES', 'FRA');
insert into IDIOMAS (ID, DESCRIPCION, ABREVIATURA) values (506, 'JAPONES', 'JAP');

--PAISES

insert into PAISES  (ID, NOMBRE, MONEDA, INDICATIVO) values (701, 'COLOMBIA', 'COP', '9196');
insert into PAISES  (ID, NOMBRE, MONEDA, INDICATIVO) values (702, 'USA', 'USD', '71540');
insert into PAISES  (ID, NOMBRE, MONEDA, INDICATIVO) values (703, 'BRASIL', 'REAL', '739');
insert into PAISES  (ID, NOMBRE, MONEDA, INDICATIVO) values (704, 'FRANCIA', 'EUR', '559');
insert into PAISES  (ID, NOMBRE, MONEDA, INDICATIVO) values (705, 'ALEMANIA', 'EUR', '4632');
insert into PAISES  (ID, NOMBRE, MONEDA, INDICATIVO) values (706, 'URUGUAY', 'PUR', '68');
insert into PAISES  (ID, NOMBRE, MONEDA, INDICATIVO) values (707, 'ARGENTINA', 'USD', '56');
insert into PAISES  (ID, NOMBRE, MONEDA, INDICATIVO) values (708, 'JAPON', 'YIN', '12');
insert into PAISES  (ID, NOMBRE, MONEDA, INDICATIVO) values (709, 'ITALIA', 'EUR', '21');
insert into PAISES  (ID, NOMBRE, MONEDA, INDICATIVO) values (710, 'PORTUGAL', 'EUR', '956');


--CIUDADES

insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (711, 'MEDELLIN', '05001', 701);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (712, 'BOGOTA', '05028', 701);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (713, 'NEW YORK', '45018', 702);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (714, 'MIAMI', '27716', 702);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (715, 'RIO DE JANEIRO', '32320', 703);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (716, 'BRASILIA', '944', 703);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (717, 'PARIS', '33215', 704);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (718, 'MONTPELLIER', '31277', 704);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (719, 'BERLIN', '424', 705);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (720, 'DORTMUND', '453405', 705);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (721, 'MONTEVIDEO', '41', 706);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (722, 'PUNTA DEL ESTE', '07251', 706);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (723, 'BUENOS AIRES', '8004', 707);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (724, 'MENDOZA', '55786', 707);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (725, 'TOKIO', '836', 708);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (726, 'OSAKA', '33145', 708);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (727, 'ROMA', '85', 709);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (728, 'MILA', '657', 709);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (729, 'LISBOA', '543434', 710);
insert into CIUDADES (ID, NOMBRE, CODIGO_POSTAL, PAIS_ID ) values (730, 'PORTO', '17741', 710);

--CLIENTES MEDIOS PAGOS

insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (1, 290, 4, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (2, 94, 4, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (3, 91, 2, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (4, 166, 1, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (5, 568, 4, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (6, 505, 1, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (7, 520, 2, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (8, 646, 2, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (9, 89, 1, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (10, 516, 4, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (11, 573, 1, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (12, 456, 1, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (13, 540, 2, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (14, 77, 4, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (15, 192, 4, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (16, 158, 1, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (17, 316, 3, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (18, 481, 4, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (19, 146, 2, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (20, 457, 1, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (21, 181, 1, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (22, 335, 1, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (23, 3, 4, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (24, 46, 3, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (25, 250, 2, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (26, 130, 1, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (27, 297, 4, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (28, 609, 4, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (29, 546, 3, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (30, 431, 3, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (31, 272, 4, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (32, 386, 1, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (33, 551, 3, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (34, 601, 2, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (35, 74, 3, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (36, 142, 3, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (37, 452, 2, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (38, 446, 3, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (39, 554, 1, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (40, 141, 1, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (41, 122, 3, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (42, 220, 4, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (43, 266, 3, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (44, 455, 3, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (45, 354, 4, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (46, 435, 2, 'V');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (47, 72, 1, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (48, 700, 2, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (49, 343, 2, 'F');
insert into CLIENTES_MEDIOS_PAGO (ID, CLIENTE_ID, MEDIO_PAGO_ID, ENVIAR_CORREO) values (50, 473, 4, 'F');

-- CODIGOS_PROMOCIONALES

insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (1, '54868-6194', 617);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (2, '0268-1318', 254);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (3, '55154-5040', 552);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (4, '43857-0321', 549);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (5, '59397-3310', 57);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (6, '37808-265', 216);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (7, '13734-127', 178);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (8, '55319-225', 379);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (9, '11523-7362', 372);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (10, '0186-0162', 470);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (11, '49288-0640', 128);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (12, '49999-818', 133);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (13, '68152-108', 669);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (14, '0049-3420', 177);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (15, '0268-6231', 363);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (16, '51138-068', 593);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (17, '76077-200', 496);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (18, '64578-0083', 558);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (19, '16571-203', 139);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (20, '49349-598', 364);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (21, '98132-882', 279);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (22, '0904-6085', 543);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (23, '0485-0206', 253);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (24, '49799-001', 127);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (25, '13734-126', 630);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (26, '64980-166', 383);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (27, '54868-4532', 558);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (28, '24571-105', 26);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (29, '0781-5409', 62);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (30, '68084-299', 354);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (31, '68151-2908', 291);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (32, '60631-040', 397);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (33, '10819-4075', 588);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (34, '50436-6924', 485);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (35, '36987-1703', 372);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (36, '24385-541', 191);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (37, '68788-9897', 665);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (38, '54868-5771', 683);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (39, '0013-2656', 626);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (40, '59779-590', 392);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (41, '64058-541', 154);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (42, '61727-321', 434);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (43, '54868-5132', 401);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (44, '52685-463', 200);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (45, '11673-563', 5);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (46, '52584-021', 96);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (47, '35356-763', 468);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (48, '43406-0113', 530);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (49, '0053-7680', 48);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, CLIENTE_ID) values (50, '60432-129', 191);

--CONDUCTORES

insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (888, '0910854750', 'Aeriel', 'Aicheson', 'https://robohash.org/estquiadolorum.png?size=50x50&set=set1', 'aaicheson0@google.cn', '434-805-9850', '6385507529353001', 'ITAU', 503, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (899, '3387059620', 'Ron', 'Castelletti', 'https://robohash.org/undeeiusvoluptatem.png?size=50x50&set=set1', 'rcastelletti1@typepad.com', '477-469-1514', '3586594965187642', 'GRUPO AVAL', 506, 723);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (834, '0005545900', 'Christy', 'Iacoviello', 'https://robohash.org/utinciduntexcepturi.png?size=50x50&set=set1', 'ciacoviello2@cam.ac.uk', '170-345-7988', '3534383445316754', 'BANCOLOMBIA', 505, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (819, '2524485773', 'Bartolomeo', 'Kimmins', 'https://robohash.org/dolorquasquia.jpg?size=50x50&set=set1', 'bkimmins3@icq.com', '647-246-1330', '5610109812485001', 'BANCOLOMBIA', 505, 725);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (823, '7145864754', 'Costanza', 'Duffet', 'https://robohash.org/voluptatemomnisex.png?size=50x50&set=set1', 'cduffet4@webeden.co.uk', '913-167-5046', '4936750548206754419', 'NEQUI', 501, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (897, '3436921440', 'Haroun', 'Tinson', 'https://robohash.org/estsitvel.png?size=50x50&set=set1', 'htinson5@abc.net.au', '509-911-8144', '5304795899617820', 'GRUPO AVAL', 503, 724);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (821, '1370800118', 'Krystle', 'Cunnington', 'https://robohash.org/seddolorumsoluta.png?size=50x50&set=set1', 'kcunnington6@europa.eu', '299-340-3372', '3540279404392889', 'BANCOLOMBIA', 503, 724);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (876, '8079571090', 'Lilah', 'Shovelin', 'https://robohash.org/ducimusmagniitaque.jpg?size=50x50&set=set1', 'lshovelin7@microsoft.com', '498-617-1628', '493670938501679721', 'BANCOLOMBIA', 505, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (813, '4591185443', 'Kirbie', 'Clemenceau', 'https://robohash.org/repudiandaeteneturdolores.bmp?size=50x50&set=set1', 'kclemenceau8@weather.com', '250-883-5980', '67623307127221146', 'DAVIVIENDA', 503, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (841, '7640374308', 'Adina', 'Tillerton', 'https://robohash.org/fugitvoluptasaliquam.jpg?size=50x50&set=set1', 'atillerton9@cnet.com', '297-809-6952', '3567970433386128', 'ITAU', 501, 723);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (806, '5915978800', 'Tuckie', 'Haugg', 'https://robohash.org/animiquisquamqui.png?size=50x50&set=set1', 'thaugga@t.co', '236-716-2591', '341315368550471', 'BANCOLOMBIA', 506, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (897, '5704683770', 'Inigo', 'Whithalgh', 'https://robohash.org/natusaspernaturat.png?size=50x50&set=set1', 'iwhithalghb@tripod.com', '118-504-2635', '6706344105739011', 'GRUPO AVAL', 505, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (895, '9702690722', 'Ailina', 'Humphries', 'https://robohash.org/ipsumnonvitae.png?size=50x50&set=set1', 'ahumphriesc@wiley.com', '506-975-8438', '5602242057914292', 'GRUPO AVAL', 501, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (802, '6415931008', 'Peggy', 'McGann', 'https://robohash.org/deseruntquiaasperiores.jpg?size=50x50&set=set1', 'pmcgannd@telegraph.co.uk', '564-238-8762', '3589200336058135', 'NEQUI', 506, 718);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (886, '8110985068', 'Clyde', 'Ridgers', 'https://robohash.org/rerumremautem.bmp?size=50x50&set=set1', 'cridgerse@liveinternet.ru', '324-673-6651', '5048379199697005', 'ITAU', 505, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (808, '5776087309', 'Noemi', 'Stirman', 'https://robohash.org/utconsequaturdoloremque.jpg?size=50x50&set=set1', 'nstirmanf@weather.com', '995-287-9132', '5100133775322511', 'GRUPO AVAL', 504, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (900, '6600473010', 'Asia', 'Ullett', 'https://robohash.org/adeterror.jpg?size=50x50&set=set1', 'aullettg@ning.com', '973-182-0215', '4903166914618748', 'BANCOLOMBIA', 506, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (850, '5918537228', 'Patti', 'Casper', 'https://robohash.org/eadistinctioanimi.png?size=50x50&set=set1', 'pcasperh@bigcartel.com', '679-364-8777', '5010120029212415', 'NEQUI', 506, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (818, '8149197486', 'Royce', 'Kindon', 'https://robohash.org/delectuseaet.bmp?size=50x50&set=set1', 'rkindoni@quantcast.com', '407-712-2394', '6761878557847998', 'BANCOLOMBIA', 501, 717);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (818, '2472783116', 'Shirl', 'Barlthrop', 'https://robohash.org/velsedtenetur.jpg?size=50x50&set=set1', 'sbarlthropj@ucla.edu', '716-916-4175', '3582280610035667', 'GRUPO AVAL', 502, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (853, '2213537518', 'Dreddy', 'Metham', 'https://robohash.org/eosquiaalias.jpg?size=50x50&set=set1', 'dmethamk@list-manage.com', '310-577-5035', '4405534939533494', 'BANCOLOMBIA', 503, 723);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (862, '5879626024', 'Jarrad', 'Meakes', 'https://robohash.org/enimrepellenduserror.bmp?size=50x50&set=set1', 'jmeakesl@umich.edu', '250-516-8143', '4913112808269055', 'GRUPO AVAL', 504, 711);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (887, '5698345546', 'Artus', 'Lamba', 'https://robohash.org/fugiateiusadipisci.bmp?size=50x50&set=set1', 'alambam@acquirethisname.com', '963-577-4956', '3543539143087760', 'DAVIVIENDA', 505, 716);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (889, '4979313132', 'Jarrad', 'Vanyushkin', 'https://robohash.org/etaspernaturconsequatur.png?size=50x50&set=set1', 'jvanyushkinn@engadget.com', '703-166-4151', '5602257487929157', 'GRUPO AVAL', 501, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (804, '6334189077', 'Gloriane', 'Pearcy', 'https://robohash.org/evenietesseillum.png?size=50x50&set=set1', 'gpearcyo@howstuffworks.com', '661-306-2240', '3555953813212159', 'ITAU', 505, 712);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (861, '4909315489', 'Gerrie', 'Verrills', 'https://robohash.org/optioetdolor.bmp?size=50x50&set=set1', 'gverrillsp@mapquest.com', '369-583-9721', '5602240416855990', 'GRUPO AVAL', 503, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (890, '0793223202', 'Onfroi', 'Scemp', 'https://robohash.org/autemutenim.bmp?size=50x50&set=set1', 'oscempq@ebay.co.uk', '567-543-6494', '3535393040012467', 'GRUPO AVAL', 501, 715);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (852, '9853503468', 'Cyndie', 'Flobert', 'https://robohash.org/eamolestiaealias.jpg?size=50x50&set=set1', 'cflobertr@1und1.de', '907-415-7463', '67595444216122226', 'BANCOLOMBIA', 501, 730);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (867, '4865262520', 'Birch', 'Ankers', 'https://robohash.org/etquivoluptatem.jpg?size=50x50&set=set1', 'bankerss@youtu.be', '306-547-3488', '6395347576703024', 'NEQUI', 504, 721);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (813, '0235990507', 'Amargo', 'Abdie', 'https://robohash.org/magnamvoluptasvoluptates.jpg?size=50x50&set=set1', 'aabdiet@cdbaby.com', '522-867-3618', '3569475636624943', 'NEQUI', 501, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (820, '9512511665', 'Shae', 'Scandred', 'https://robohash.org/voluptateremeius.jpg?size=50x50&set=set1', 'sscandredu@ask.com', '749-256-8103', '3546306616141699', 'ITAU', 506, 719);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (861, '1893881660', 'Liz', 'Shalcras', 'https://robohash.org/aliquamsuntenim.jpg?size=50x50&set=set1', 'lshalcrasv@irs.gov', '705-896-2865', '5610167364654879', 'ITAU', 506, 721);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (900, '0482164891', 'Henderson', 'Limmer', 'https://robohash.org/estaccusantiumest.jpg?size=50x50&set=set1', 'hlimmerw@census.gov', '441-470-1951', '4026968408028298', 'ITAU', 502, 714);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (883, '1637606516', 'Lynnett', 'Barrand', 'https://robohash.org/nostrumidautem.bmp?size=50x50&set=set1', 'lbarrandx@desdev.cn', '863-608-1188', '490331805236296187', 'GRUPO AVAL', 505, 717);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (817, '2669428967', 'Jannelle', 'Sapshed', 'https://robohash.org/etexercitationemvoluptatum.png?size=50x50&set=set1', 'jsapshedy@mail.ru', '782-245-8408', '3577066431599859', 'BANCOLOMBIA', 504, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (808, '9725771818', 'Wilhelmina', 'Clorley', 'https://robohash.org/delenitieteaque.bmp?size=50x50&set=set1', 'wclorleyz@godaddy.com', '646-665-3858', '3579050524061777', 'BANCOLOMBIA', 503, 721);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (888, '0792074998', 'Sherie', 'Betancourt', 'https://robohash.org/ipsamnemovel.png?size=50x50&set=set1', 'sbetancourt10@google.it', '219-329-6488', '372301538012230', 'NEQUI', 506, 719);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (878, '9694496594', 'Antin', 'McFarlan', 'https://robohash.org/temporatotamoptio.png?size=50x50&set=set1', 'amcfarlan11@utexas.edu', '751-953-8204', '3588047797152522', 'BANCOLOMBIA', 502, 714);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (839, '2519224576', 'Austin', 'Toke', 'https://robohash.org/fugautquas.jpg?size=50x50&set=set1', 'atoke12@discuz.net', '728-530-8251', '5018366016399176', 'NEQUI', 506, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (810, '9873749462', 'Boone', 'Courteney', 'https://robohash.org/doloribusauteum.png?size=50x50&set=set1', 'bcourteney13@about.me', '597-118-6332', '3569010540803166', 'ITAU', 505, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (900, '0454167504', 'Dexter', 'Haslock', 'https://robohash.org/doloresquibusdamnostrum.png?size=50x50&set=set1', 'dhaslock14@mysql.com', '128-852-4275', '5602232134915636', 'ITAU', 506, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (878, '9553905277', 'Jasmine', 'Patriche', 'https://robohash.org/utestquos.png?size=50x50&set=set1', 'jpatriche15@unc.edu', '465-101-8709', '3565404525063512', 'GRUPO AVAL', 502, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (809, '0173962955', 'Allie', 'Tilliard', 'https://robohash.org/nemoidcommodi.png?size=50x50&set=set1', 'atilliard16@soup.io', '107-820-1311', '3541196178299653', 'NEQUI', 503, 724);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (881, '6389967322', 'Viviyan', 'Lante', 'https://robohash.org/nihilevenietearum.jpg?size=50x50&set=set1', 'vlante17@g.co', '359-781-2363', '5007666159502293', 'BANCOLOMBIA', 505, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (841, '3573286860', 'Ashil', 'Sparkwill', 'https://robohash.org/aliasreiciendisullam.png?size=50x50&set=set1', 'asparkwill18@clickbank.net', '170-932-2572', '5602225802186639', 'ITAU', 502, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (841, '2965687351', 'Sutherlan', 'Trounce', 'https://robohash.org/estutquia.bmp?size=50x50&set=set1', 'strounce19@ucoz.com', '367-349-1067', '5283872046700554', 'DAVIVIENDA', 506, 718);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (896, '6628363279', 'Gunther', 'Bezzant', 'https://robohash.org/autdictasit.jpg?size=50x50&set=set1', 'gbezzant1a@howstuffworks.com', '134-655-7763', '3569592530083669', 'ITAU', 504, 711);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (900, '5009674181', 'Lowell', 'Torrejon', 'https://robohash.org/molestiasautab.png?size=50x50&set=set1', 'ltorrejon1b@bing.com', '328-986-2469', '3568413070741981', 'GRUPO AVAL', 504, 723);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (863, '7350863969', 'Emile', 'McChesney', 'https://robohash.org/perferendisexpeditaconsequatur.bmp?size=50x50&set=set1', 'emcchesney1c@google.nl', '349-789-8976', '3537707302423385', 'DAVIVIENDA', 503, 718);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (896, '8705309581', 'Isaak', 'Woolis', 'https://robohash.org/iurevoluptatemconsequatur.jpg?size=50x50&set=set1', 'iwoolis1d@boston.com', '284-774-4488', '4017951484745259', 'NEQUI', 504, 723);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (805, '3287551728', 'Danni', 'O''Quin', 'https://robohash.org/eligendiassumendarepudiandae.bmp?size=50x50&set=set1', 'doquin1e@shinystat.com', '767-844-0539', '3535320112445622', 'GRUPO AVAL', 503, 720);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (885, '9142267439', 'Lyndsey', 'Bartels', 'https://robohash.org/autemlaboreex.jpg?size=50x50&set=set1', 'lbartels1f@forbes.com', '128-508-0515', '30347631877999', 'NEQUI', 501, 721);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (807, '4892340103', 'Celestia', 'Vasyushkhin', 'https://robohash.org/voluptasnobisducimus.bmp?size=50x50&set=set1', 'cvasyushkhin1g@pinterest.com', '677-309-1741', '3563497041714107', 'ITAU', 505, 723);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (893, '4865696083', 'Broderic', 'Chotty', 'https://robohash.org/consecteturvoluptasnisi.png?size=50x50&set=set1', 'bchotty1h@businessweek.com', '997-283-1442', '3534178554753312', 'GRUPO AVAL', 502, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (896, '9842319490', 'Stefan', 'Dermot', 'https://robohash.org/nonducimusquis.jpg?size=50x50&set=set1', 'sdermot1i@addtoany.com', '823-240-1848', '3580224669427146', 'ITAU', 503, 711);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (898, '0142756504', 'Rourke', 'Dowe', 'https://robohash.org/saepeestut.bmp?size=50x50&set=set1', 'rdowe1j@exblog.jp', '631-483-6692', '3538678610149468', 'GRUPO AVAL', 504, 712);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (875, '6340117864', 'Sandye', 'Slingsby', 'https://robohash.org/molestiaeetveniam.bmp?size=50x50&set=set1', 'sslingsby1k@wp.com', '403-603-2770', '374283113663298', 'GRUPO AVAL', 501, 725);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (821, '3731634759', 'Arther', 'Emslie', 'https://robohash.org/nonsimiliqueest.jpg?size=50x50&set=set1', 'aemslie1l@nyu.edu', '291-177-1490', '30516961637674', 'DAVIVIENDA', 504, 720);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (895, '2249582750', 'Enrichetta', 'Alywen', 'https://robohash.org/etdoloreaccusamus.jpg?size=50x50&set=set1', 'ealywen1m@theglobeandmail.com', '486-490-9267', '5602255598967777', 'NEQUI', 503, 718);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (894, '3084985863', 'Coral', 'Osbaldeston', 'https://robohash.org/porrovelitqui.bmp?size=50x50&set=set1', 'cosbaldeston1n@bravesites.com', '675-806-5070', '3542832779207625', 'NEQUI', 504, 721);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (808, '9055330140', 'Xenia', 'Graber', 'https://robohash.org/dolordoloremvoluptas.bmp?size=50x50&set=set1', 'xgraber1o@si.edu', '183-173-9180', '201859814152829', 'ITAU', 504, 724);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (817, '2829283503', 'Harri', 'Winckworth', 'https://robohash.org/delenitiaaut.png?size=50x50&set=set1', 'hwinckworth1p@ebay.com', '683-168-6877', '3570182807409842', 'NEQUI', 501, 725);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (832, '7696702572', 'Betta', 'Velasquez', 'https://robohash.org/distinctioatquead.jpg?size=50x50&set=set1', 'bvelasquez1q@vimeo.com', '963-572-8800', '30395188973174', 'DAVIVIENDA', 504, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (830, '0888374119', 'Casie', 'Ladewig', 'https://robohash.org/temporaautdebitis.bmp?size=50x50&set=set1', 'cladewig1r@hugedomains.com', '218-180-1261', '3580119606313930', 'GRUPO AVAL', 502, 727);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (883, '6152817315', 'Pansie', 'Wreath', 'https://robohash.org/quiadictaneque.png?size=50x50&set=set1', 'pwreath1s@naver.com', '802-628-7002', '3575588878901779', 'NEQUI', 502, 727);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (873, '6609557012', 'Reider', 'Hilldrup', 'https://robohash.org/oditcorporislibero.bmp?size=50x50&set=set1', 'rhilldrup1t@webmd.com', '844-886-8395', '3544583081509558', 'BANCOLOMBIA', 505, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (850, '0877293201', 'Erminia', 'O''Finan', 'https://robohash.org/sitnisieum.bmp?size=50x50&set=set1', 'eofinan1u@devhub.com', '223-772-0573', '5048379861872225', 'NEQUI', 504, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (842, '9064702020', 'Adella', 'Corde', 'https://robohash.org/eaametconsectetur.jpg?size=50x50&set=set1', 'acorde1v@reference.com', '441-791-5926', '67598378615979017', 'DAVIVIENDA', 502, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (857, '1170374301', 'Graham', 'Vittel', 'https://robohash.org/dolorsuscipitdolores.jpg?size=50x50&set=set1', 'gvittel1w@tinypic.com', '545-263-2436', '5602239816439074', 'ITAU', 505, 711);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (812, '5649405735', 'Ephrayim', 'Kibard', 'https://robohash.org/necessitatibusliberoducimus.jpg?size=50x50&set=set1', 'ekibard1x@studiopress.com', '539-633-2600', '5602225670228637416', 'GRUPO AVAL', 502, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (805, '8866111937', 'Bastien', 'Gillhespy', 'https://robohash.org/minimalaudantiumet.png?size=50x50&set=set1', 'bgillhespy1y@t.co', '619-178-2202', '201718104436328', 'GRUPO AVAL', 505, 716);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (875, '4190193623', 'Jeri', 'Jowers', 'https://robohash.org/occaecativoluptatemconsequatur.png?size=50x50&set=set1', 'jjowers1z@hp.com', '686-899-0053', '5100141496491473', 'DAVIVIENDA', 504, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (848, '2982424096', 'Leona', 'Bleacher', 'https://robohash.org/magnaminmollitia.bmp?size=50x50&set=set1', 'lbleacher20@macromedia.com', '254-179-0217', '3583610135117245', 'NEQUI', 506, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (859, '0167999052', 'Luigi', 'Cavozzi', 'https://robohash.org/eaqueeaex.bmp?size=50x50&set=set1', 'lcavozzi21@google.co.uk', '213-900-2818', '201725528053779', 'GRUPO AVAL', 503, 727);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (885, '5556804036', 'Arman', 'Lokier', 'https://robohash.org/delectusipsamnesciunt.jpg?size=50x50&set=set1', 'alokier22@eepurl.com', '378-681-3014', '3551057834366814', 'DAVIVIENDA', 503, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (803, '8006677573', 'Lothario', 'Aicheson', 'https://robohash.org/asperioresdelenitivoluptatem.png?size=50x50&set=set1', 'laicheson23@twitter.com', '627-838-9242', '201533184762026', 'ITAU', 506, 727);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (878, '4900919055', 'Jared', 'Belliveau', 'https://robohash.org/omnisaperiamfacere.jpg?size=50x50&set=set1', 'jbelliveau24@deliciousdays.com', '926-547-5742', '4175000335898483', 'GRUPO AVAL', 503, 716);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (841, '5709465143', 'Celene', 'Waryk', 'https://robohash.org/doloremetitaque.png?size=50x50&set=set1', 'cwaryk25@irs.gov', '860-767-8339', '372301247763503', 'BANCOLOMBIA', 505, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (822, '1863000704', 'Amory', 'Dufall', 'https://robohash.org/laudantiumreprehenderitlabore.png?size=50x50&set=set1', 'adufall26@newsvine.com', '273-289-0553', '3569398207425369', 'NEQUI', 505, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (851, '9650479805', 'Lavina', 'Detoile', 'https://robohash.org/molestiaeundeut.jpg?size=50x50&set=set1', 'ldetoile27@disqus.com', '765-338-8650', '374283234126571', 'ITAU', 506, 720);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (826, '8988417534', 'Pattie', 'Flipek', 'https://robohash.org/minusconsequaturquia.bmp?size=50x50&set=set1', 'pflipek28@mapy.cz', '367-266-5141', '3539691942041070', 'ITAU', 504, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (848, '1929747195', 'Ruth', 'Revely', 'https://robohash.org/suntvoluptateprovident.bmp?size=50x50&set=set1', 'rrevely29@goodreads.com', '278-387-9464', '201569409489177', 'ITAU', 504, 725);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (855, '6933614182', 'Josephina', 'Paten', 'https://robohash.org/sapienteveroquia.png?size=50x50&set=set1', 'jpaten2a@abc.net.au', '831-590-8095', '5610017768471831051', 'BANCOLOMBIA', 503, 719);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (898, '3103610335', 'Olwen', 'Byford', 'https://robohash.org/teneturdoloribusvel.bmp?size=50x50&set=set1', 'obyford2b@vimeo.com', '383-688-9098', '3570306017677951', 'NEQUI', 501, 725);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (827, '6119551204', 'Nicolette', 'Washington', 'https://robohash.org/fugiatipsamaperiam.bmp?size=50x50&set=set1', 'nwashington2c@xrea.com', '644-602-2854', '374283649805298', 'BANCOLOMBIA', 505, 718);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (892, '5577957583', 'Bobine', 'Turfus', 'https://robohash.org/etaliquamquod.bmp?size=50x50&set=set1', 'bturfus2d@boston.com', '271-983-9134', '201803709249357', 'DAVIVIENDA', 505, 716);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (821, '1382405405', 'Orran', 'Jonas', 'https://robohash.org/utexpeditaeligendi.bmp?size=50x50&set=set1', 'ojonas2e@google.fr', '476-899-3898', '3582708408270682', 'ITAU', 505, 730);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (863, '0411524704', 'Rodrique', 'McFeat', 'https://robohash.org/velithicmolestias.bmp?size=50x50&set=set1', 'rmcfeat2f@mail.ru', '891-608-9013', '5048376422115599', 'DAVIVIENDA', 506, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (867, '7098791474', 'Shurlock', 'Merredy', 'https://robohash.org/cumquiaharum.bmp?size=50x50&set=set1', 'smerredy2g@meetup.com', '785-417-3064', '6304308614761742490', 'ITAU', 501, 717);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (801, '1255133228', 'Jerrine', 'Cund', 'https://robohash.org/quodnihilmagnam.png?size=50x50&set=set1', 'jcund2h@un.org', '572-129-6809', '6709428658973651556', 'NEQUI', 501, 711);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (889, '5161153121', 'Abraham', 'Thorwarth', 'https://robohash.org/rationevoluptasnihil.jpg?size=50x50&set=set1', 'athorwarth2i@examiner.com', '614-384-1934', '3545757705162403', 'BANCOLOMBIA', 505, 719);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (898, '9732172398', 'Hedy', 'Mathews', 'https://robohash.org/molestiasvelitvoluptas.png?size=50x50&set=set1', 'hmathews2j@google.pl', '274-888-8257', '3541583216006374', 'NEQUI', 503, 727);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (826, '7819559322', 'Tonya', 'Kensley', 'https://robohash.org/animimolestiasatque.png?size=50x50&set=set1', 'tkensley2k@hhs.gov', '823-922-2198', '341510279208918', 'GRUPO AVAL', 503, 724);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (807, '1276648200', 'Chic', 'Laird-Craig', 'https://robohash.org/suscipitillosit.jpg?size=50x50&set=set1', 'clairdcraig2l@addtoany.com', '937-300-8873', '3541068028364906', 'BANCOLOMBIA', 502, 720);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (865, '8269934402', 'Muire', 'Cufley', 'https://robohash.org/nemomaioresdolorem.bmp?size=50x50&set=set1', 'mcufley2m@pen.io', '330-704-2121', '3537955541326139', 'GRUPO AVAL', 505, 711);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (848, '4228296998', 'Avie', 'Priver', 'https://robohash.org/reprehenderitestofficiis.bmp?size=50x50&set=set1', 'apriver2n@fema.gov', '964-713-9692', '372301244563781', 'ITAU', 504, 712);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (872, '2076431888', 'Michal', 'Luxen', 'https://robohash.org/aliasveniamaut.jpg?size=50x50&set=set1', 'mluxen2o@blog.com', '955-378-3225', '5602223147753723053', 'NEQUI', 504, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (870, '6160315676', 'Nerissa', 'Gammon', 'https://robohash.org/sitquaequo.png?size=50x50&set=set1', 'ngammon2p@dedecms.com', '116-830-5206', '36756829489223', 'NEQUI', 504, 723);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (846, '5808280583', 'Sofie', 'Simeon', 'https://robohash.org/rerumporroet.bmp?size=50x50&set=set1', 'ssimeon2q@slashdot.org', '277-140-4789', '3547260377236074', 'GRUPO AVAL', 502, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (940, '1934260665', 'Hartwell', 'Fierman', 'https://robohash.org/estrerumut.bmp?size=50x50&set=set1', 'hfierman0@huffingtonpost.com', '744-279-2401', '3549998085727433', 'BANCOLOMBIA', 503, 711);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (923, '4011185906', 'Marlane', 'Errington', 'https://robohash.org/perspiciatisearepellendus.png?size=50x50&set=set1', 'merrington1@cbslocal.com', '465-204-4677', '374283476785738', 'DAVIVIENDA', 506, 730);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (907, '1498804152', 'Silvanus', 'Boules', 'https://robohash.org/doloremquesuntvoluptas.jpg?size=50x50&set=set1', 'sboules2@barnesandnoble.com', '217-533-4144', '3540197429976330', 'GRUPO AVAL', 503, 716);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (926, '6598758459', 'Gunner', 'Razoux', 'https://robohash.org/ametdebitisdeleniti.bmp?size=50x50&set=set1', 'grazoux3@state.gov', '766-706-1637', '67590404219967485', 'DAVIVIENDA', 504, 716);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (921, '5233604310', 'Ramsay', 'Lummus', 'https://robohash.org/repellatautemquisquam.png?size=50x50&set=set1', 'rlummus4@senate.gov', '654-203-9058', '5427865168332963', 'BANCOLOMBIA', 503, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (925, '8322819862', 'Sarena', 'Dohmann', 'https://robohash.org/etillumiste.jpg?size=50x50&set=set1', 'sdohmann5@jalbum.net', '145-561-9014', '3533919431653865', 'GRUPO AVAL', 502, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (937, '5976935141', 'Claudell', 'Zeplin', 'https://robohash.org/fugiateaerror.png?size=50x50&set=set1', 'czeplin6@army.mil', '858-572-9816', '36430489501681', 'NEQUI', 504, 719);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (910, '3609824131', 'Calvin', 'Liston', 'https://robohash.org/illoautdeleniti.jpg?size=50x50&set=set1', 'cliston7@odnoklassniki.ru', '190-253-3179', '30427126314714', 'GRUPO AVAL', 504, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (901, '7540933062', 'Chrissy', 'Baudou', 'https://robohash.org/voluptatemetomnis.jpg?size=50x50&set=set1', 'cbaudou8@mozilla.com', '754-734-1454', '3543388642543059', 'DAVIVIENDA', 504, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (911, '4900841560', 'Gorden', 'Duer', 'https://robohash.org/velitinventoreeveniet.bmp?size=50x50&set=set1', 'gduer9@i2i.jp', '511-320-6848', '5327229947784195', 'BANCOLOMBIA', 504, 730);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (914, '1459200780', 'Thurstan', 'Donalson', 'https://robohash.org/asperioresrepellendushic.jpg?size=50x50&set=set1', 'tdonalsona@skyrock.com', '547-413-9457', '4238574204705362', 'NEQUI', 506, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (925, '2333542098', 'Oralie', 'Aleshintsev', 'https://robohash.org/consecteturexplicabounde.png?size=50x50&set=set1', 'oaleshintsevb@linkedin.com', '820-894-6876', '3586241373936349', 'DAVIVIENDA', 505, 724);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (911, '2961892457', 'Orion', 'Fearnley', 'https://robohash.org/autnonoptio.bmp?size=50x50&set=set1', 'ofearnleyc@fda.gov', '240-283-1031', '5219784069311871', 'ITAU', 504, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (915, '7804474547', 'Alena', 'Bras', 'https://robohash.org/esttemporibusnon.png?size=50x50&set=set1', 'abrasd@miitbeian.gov.cn', '103-212-9447', '3570373028952633', 'NEQUI', 502, 721);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (911, '2069311465', 'Ilka', 'Enrrico', 'https://robohash.org/suscipitsitfugiat.png?size=50x50&set=set1', 'ienrricoe@kickstarter.com', '117-679-4091', '3574329318964932', 'DAVIVIENDA', 502, 712);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (935, '5822370772', 'Calv', 'Northridge', 'https://robohash.org/aspernaturtemporibuseveniet.jpg?size=50x50&set=set1', 'cnorthridgef@alibaba.com', '296-698-6252', '5422883885236883', 'GRUPO AVAL', 504, 730);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (917, '4068333556', 'Genni', 'Schafer', 'https://robohash.org/perspiciatisdictaut.bmp?size=50x50&set=set1', 'gschaferg@google.es', '615-889-0464', '5602232490579141244', 'BANCOLOMBIA', 501, 730);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (927, '8192420922', 'Delinda', 'Pearton', 'https://robohash.org/ipsamnoncupiditate.png?size=50x50&set=set1', 'dpeartonh@istockphoto.com', '543-686-6351', '201485306284811', 'BANCOLOMBIA', 502, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (933, '7804859341', 'Analiese', 'Bustard', 'https://robohash.org/ipsamidfugit.bmp?size=50x50&set=set1', 'abustardi@livejournal.com', '884-206-7396', '3589719502677048', 'ITAU', 504, 719);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (936, '5019489077', 'Karoly', 'Heigl', 'https://robohash.org/atquesuntcorrupti.bmp?size=50x50&set=set1', 'kheiglj@businessinsider.com', '237-228-0014', '560222594084811402', 'BANCOLOMBIA', 501, 719);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (910, '9871703562', 'Zackariah', 'Danilovic', 'https://robohash.org/dolorumvoluptatemlaborum.jpg?size=50x50&set=set1', 'zdanilovick@unc.edu', '441-834-6587', '5100143762482335', 'GRUPO AVAL', 503, 727);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (908, '4798897558', 'Redd', 'Bradley', 'https://robohash.org/reiciendisconsequaturunde.bmp?size=50x50&set=set1', 'rbradleyl@telegraph.co.uk', '606-922-2229', '5132627494998289', 'DAVIVIENDA', 505, 721);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (926, '8394916066', 'Raynell', 'Georgescu', 'https://robohash.org/debitisautemanimi.png?size=50x50&set=set1', 'rgeorgescum@facebook.com', '271-644-7027', '4017959250652120', 'DAVIVIENDA', 501, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (904, '3082601928', 'Elmira', 'Ganford', 'https://robohash.org/sedetnihil.bmp?size=50x50&set=set1', 'eganfordn@nasa.gov', '572-827-2371', '3541527675864955', 'GRUPO AVAL', 502, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (930, '2902616619', 'Guss', 'Ovitts', 'https://robohash.org/quaeratrepellendusofficia.bmp?size=50x50&set=set1', 'govittso@arstechnica.com', '471-874-0092', '6759817870558944', 'BANCOLOMBIA', 504, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (903, '3019655323', 'Evelyn', 'Balassi', 'https://robohash.org/harumerrorcupiditate.png?size=50x50&set=set1', 'ebalassip@newyorker.com', '251-463-9912', '30167806325453', 'GRUPO AVAL', 506, 720);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (923, '1417232102', 'Cullin', 'Wayland', 'https://robohash.org/quialaboriosamtotam.bmp?size=50x50&set=set1', 'cwaylandq@usgs.gov', '220-927-1339', '3540308857818098', 'BANCOLOMBIA', 504, 712);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (901, '3562437501', 'Tiffanie', 'Lambrick', 'https://robohash.org/minustemporaquaerat.jpg?size=50x50&set=set1', 'tlambrickr@friendfeed.com', '872-691-5425', '3565521199321890', 'GRUPO AVAL', 505, 727);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (915, '0431222800', 'Berty', 'Moncaster', 'https://robohash.org/nonomniset.jpg?size=50x50&set=set1', 'bmoncasters@prlog.org', '796-902-9299', '6334177023808041', 'DAVIVIENDA', 504, 714);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (937, '4431208658', 'Kania', 'Cottom', 'https://robohash.org/utharumad.jpg?size=50x50&set=set1', 'kcottomt@foxnews.com', '508-402-9190', '3544565759273914', 'ITAU', 505, 720);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (929, '4930391083', 'Ragnar', 'Maude', 'https://robohash.org/adipiscialiquamrepellendus.png?size=50x50&set=set1', 'rmaudeu@wordpress.org', '336-746-1413', '3583633620230109', 'NEQUI', 501, 724);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (933, '3479411541', 'Lyndsey', 'Canellas', 'https://robohash.org/placeatremitaque.bmp?size=50x50&set=set1', 'lcanellasv@usnews.com', '355-294-5522', '374283714676012', 'DAVIVIENDA', 506, 714);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (914, '3548189105', 'Pauli', 'Fenemore', 'https://robohash.org/voluptatemeaquemagnam.bmp?size=50x50&set=set1', 'pfenemorew@tinyurl.com', '454-275-6714', '3579028675280917', 'ITAU', 503, 717);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (936, '5271129535', 'Dru', 'Meany', 'https://robohash.org/suntinciduntdeleniti.png?size=50x50&set=set1', 'dmeanyx@yolasite.com', '859-831-8036', '30039385318813', 'GRUPO AVAL', 506, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (939, '0809872226', 'Roxanne', 'Mates', 'https://robohash.org/eaquosnihil.bmp?size=50x50&set=set1', 'rmatesy@xing.com', '753-650-3125', '5038313714534212744', 'NEQUI', 501, 715);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (931, '8382615309', 'Marlow', 'Ralls', 'https://robohash.org/doloremqueveniamet.png?size=50x50&set=set1', 'mrallsz@shareasale.com', '276-740-5551', '3568246351685521', 'GRUPO AVAL', 501, 727);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (937, '8836130356', 'Karen', 'Grandin', 'https://robohash.org/providentofficiisquia.jpg?size=50x50&set=set1', 'kgrandin10@microsoft.com', '925-985-7620', '201877335616940', 'GRUPO AVAL', 501, 711);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (928, '1213122260', 'Wat', 'Amber', 'https://robohash.org/voluptatibusautet.jpg?size=50x50&set=set1', 'wamber11@google.cn', '779-854-1075', '491118398148629353', 'ITAU', 504, 725);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (935, '4669684906', 'Kendra', 'Paule', 'https://robohash.org/nonsuscipitid.jpg?size=50x50&set=set1', 'kpaule12@goo.ne.jp', '231-152-1250', '30167962627312', 'NEQUI', 501, 720);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (939, '9267653253', 'Didi', 'Constantinou', 'https://robohash.org/laboreautmolestias.png?size=50x50&set=set1', 'dconstantinou13@wordpress.com', '606-731-2795', '201557022027441', 'ITAU', 504, 723);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (982, '7333288234', 'Oralie', 'Valek', 'https://robohash.org/temporedoloresconsequatur.jpg?size=50x50&set=set1', 'ovalek0@ihg.com', '390-972-5083', '337941162290034', 'NEQUI', 502, 715);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (969, '4476058248', 'Glenna', 'MacDougal', 'https://robohash.org/seddignissimosenim.jpg?size=50x50&set=set1', 'gmacdougal1@a8.net', '670-989-1134', '201848087404249', 'NEQUI', 506, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (981, '1445374595', 'Penelope', 'Westwater', 'https://robohash.org/estrerumasperiores.png?size=50x50&set=set1', 'pwestwater2@hatena.ne.jp', '118-481-0276', '4508932321817630', 'BANCOLOMBIA', 501, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (975, '2612801952', 'Karoly', 'Rumgay', 'https://robohash.org/corporisreiciendisdolorem.bmp?size=50x50&set=set1', 'krumgay3@gizmodo.com', '633-968-9473', '4041379900475', 'DAVIVIENDA', 506, 720);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (964, '4943497594', 'Sophronia', 'Artis', 'https://robohash.org/autaqui.png?size=50x50&set=set1', 'sartis4@cyberchimps.com', '951-586-0899', '3539847125981074', 'BANCOLOMBIA', 502, 712);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (978, '1710193875', 'Marietta', 'Bullman', 'https://robohash.org/facerevoluptatibusalias.bmp?size=50x50&set=set1', 'mbullman5@constantcontact.com', '859-672-3584', '4508707748248936', 'DAVIVIENDA', 503, 712);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (987, '4263519620', 'Jacinda', 'Morling', 'https://robohash.org/quirepudiandaevoluptatem.jpg?size=50x50&set=set1', 'jmorling6@fema.gov', '353-257-6823', '3567563954105082', 'ITAU', 501, 714);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (961, '5725504468', 'Aurore', 'Petrie', 'https://robohash.org/quibusdamdoloreaccusantium.png?size=50x50&set=set1', 'apetrie7@bizjournals.com', '786-493-4686', '3583102714462416', 'GRUPO AVAL', 505, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (988, '5912919846', 'Hinze', 'Crace', 'https://robohash.org/harumconsequaturquo.bmp?size=50x50&set=set1', 'hcrace8@ft.com', '399-192-6592', '3563900213453735', 'DAVIVIENDA', 501, 715);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (944, '9841910845', 'Bucky', 'Bendig', 'https://robohash.org/accusamusoccaecatimagnam.bmp?size=50x50&set=set1', 'bbendig9@hud.gov', '511-258-6271', '6372294850868536', 'NEQUI', 501, 714);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (999, '1382024606', 'Madel', 'Keitch', 'https://robohash.org/itaquevelitsed.png?size=50x50&set=set1', 'mkeitcha@skyrock.com', '718-484-1793', '5553221124974165', 'DAVIVIENDA', 506, 718);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (964, '9995162830', 'Bel', 'Dofty', 'https://robohash.org/undeautvoluptatem.jpg?size=50x50&set=set1', 'bdoftyb@loc.gov', '971-131-6170', '3588041714248455', 'NEQUI', 505, 715);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (976, '8257569348', 'Aubrey', 'Whybrow', 'https://robohash.org/autquinon.png?size=50x50&set=set1', 'awhybrowc@mashable.com', '326-403-6318', '3580714402731796', 'DAVIVIENDA', 504, 718);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (979, '5330168864', 'Derek', 'Yokelman', 'https://robohash.org/nesciuntvoluptatumconsequatur.jpg?size=50x50&set=set1', 'dyokelmand@xinhuanet.com', '747-886-4473', '201609351655712', 'ITAU', 506, 727);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (977, '8503073803', 'Dionis', 'Caslane', 'https://robohash.org/omniseosenim.jpg?size=50x50&set=set1', 'dcaslanee@nifty.com', '620-333-7185', '5010120430006828', 'NEQUI', 502, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (980, '1497755999', 'Philippe', 'Sandey', 'https://robohash.org/etautsed.png?size=50x50&set=set1', 'psandeyf@deviantart.com', '323-551-5162', '3569177932489738', 'GRUPO AVAL', 505, 716);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (960, '5283199061', 'Diego', 'MacGarrity', 'https://robohash.org/facerefugiatmolestias.jpg?size=50x50&set=set1', 'dmacgarrityg@domainmarket.com', '183-932-0820', '5602233609584949', 'DAVIVIENDA', 505, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (991, '3015892738', 'Pamelina', 'Brumfitt', 'https://robohash.org/utmaioresqui.png?size=50x50&set=set1', 'pbrumfitth@columbia.edu', '765-104-9945', '5602233759550799', 'BANCOLOMBIA', 501, 718);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (999, '6225568239', 'Nial', 'Burner', 'https://robohash.org/praesentiumculpafacere.bmp?size=50x50&set=set1', 'nburneri@cpanel.net', '480-684-8389', '3544970788048867', 'DAVIVIENDA', 506, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (960, '3629950558', 'Prentice', 'Carling', 'https://robohash.org/ullamtemporequi.bmp?size=50x50&set=set1', 'pcarlingj@yahoo.co.jp', '361-172-9213', '3571221707186875', 'DAVIVIENDA', 503, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (978, '0136202829', 'Stefano', 'Cantwell', 'https://robohash.org/voluptaterecusandaequam.png?size=50x50&set=set1', 'scantwellk@livejournal.com', '314-631-2270', '3559027892069917', 'ITAU', 503, 717);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (942, '4564009435', 'Dyana', 'Vaskov', 'https://robohash.org/illumreiciendislaborum.bmp?size=50x50&set=set1', 'dvaskovl@privacy.gov.au', '320-832-2775', '3571020089997804', 'ITAU', 504, 724);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (989, '7806747915', 'Alistair', 'Gosneye', 'https://robohash.org/aperiamharumet.png?size=50x50&set=set1', 'agosneyem@dagondesign.com', '834-618-8205', '3552260112535121', 'DAVIVIENDA', 501, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (947, '8939359038', 'Teodora', 'Sutcliffe', 'https://robohash.org/incidunteaquelaboriosam.jpg?size=50x50&set=set1', 'tsutcliffen@reuters.com', '564-713-1180', '201512941298235', 'BANCOLOMBIA', 501, 718);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (958, '7227448401', 'Dale', 'Gillfillan', 'https://robohash.org/autemplaceatet.png?size=50x50&set=set1', 'dgillfillano@rakuten.co.jp', '752-149-5668', '4667743391007', 'GRUPO AVAL', 506, 711);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (988, '5521085696', 'Hurleigh', 'Harlick', 'https://robohash.org/quamsaepehic.jpg?size=50x50&set=set1', 'hharlickp@cafepress.com', '105-307-7651', '36513741109953', 'BANCOLOMBIA', 501, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (972, '5848165416', 'Westbrooke', 'Redborn', 'https://robohash.org/reprehenderitipsumneque.bmp?size=50x50&set=set1', 'wredbornq@a8.net', '995-554-8507', '3572853586901807', 'DAVIVIENDA', 505, 721);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (977, '4660369285', 'Jorrie', 'Wiskar', 'https://robohash.org/maioressuscipitvelit.png?size=50x50&set=set1', 'jwiskarr@addtoany.com', '793-164-3391', '201951029096717', 'NEQUI', 506, 724);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (999, '3717067885', 'Augie', 'Seeks', 'https://robohash.org/autemquossed.bmp?size=50x50&set=set1', 'aseekss@i2i.jp', '551-765-2603', '490398196330690008', 'GRUPO AVAL', 505, 724);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (940, '5495227751', 'Faun', 'Mapston', 'https://robohash.org/necessitatibusdoloremsed.png?size=50x50&set=set1', 'fmapstont@mtv.com', '206-566-1607', '5108757433901191', 'GRUPO AVAL', 504, 712);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (966, '2727433417', 'Natasha', 'McClounan', 'https://robohash.org/sitveritatisnobis.bmp?size=50x50&set=set1', 'nmcclounanu@sina.com.cn', '262-580-6140', '201555819601170', 'ITAU', 503, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (948, '5055372427', 'Kingsley', 'Elcomb', 'https://robohash.org/exlaborumdicta.bmp?size=50x50&set=set1', 'kelcombv@gizmodo.com', '155-379-6512', '3549962235732958', 'BANCOLOMBIA', 505, 727);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (976, '7033702043', 'Nickie', 'Francino', 'https://robohash.org/laboreaspernaturfugiat.bmp?size=50x50&set=set1', 'nfrancinow@si.edu', '853-307-1606', '5198494554746400', 'BANCOLOMBIA', 506, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (976, '4118139065', 'Hayley', 'Rosberg', 'https://robohash.org/reprehenderitnatusitaque.jpg?size=50x50&set=set1', 'hrosbergx@a8.net', '262-274-8339', '372301217913658', 'GRUPO AVAL', 504, 717);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (959, '8761868035', 'Domenico', 'Breston', 'https://robohash.org/reiciendisaberror.png?size=50x50&set=set1', 'dbrestony@dion.ne.jp', '722-298-1402', '502035239983722255', 'DAVIVIENDA', 502, 715);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (979, '1811796133', 'Margy', 'Charlton', 'https://robohash.org/velitiurein.jpg?size=50x50&set=set1', 'mcharltonz@bizjournals.com', '479-546-7717', '30109488824189', 'GRUPO AVAL', 504, 711);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (994, '1633109089', 'Chrissie', 'Rowland', 'https://robohash.org/sintconsecteturlaborum.jpg?size=50x50&set=set1', 'crowland10@mlb.com', '686-955-0173', '3529135333217263', 'NEQUI', 505, 720);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (940, '8693191551', 'Gradey', 'Letessier', 'https://robohash.org/etatest.bmp?size=50x50&set=set1', 'gletessier11@360.cn', '520-107-0429', '63045956439885029', 'GRUPO AVAL', 504, 714);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (986, '3447341688', 'Miranda', 'Revie', 'https://robohash.org/doloribusquaeomnis.jpg?size=50x50&set=set1', 'mrevie12@etsy.com', '702-137-8379', '5602240673203009', 'GRUPO AVAL', 501, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (975, '1806790475', 'Rheta', 'Eassom', 'https://robohash.org/consecteturlaboreconsequatur.png?size=50x50&set=set1', 'reassom13@princeton.edu', '227-526-7444', '4041375427564', 'ITAU', 504, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (963, '2012496679', 'Angel', 'Billinge', 'https://robohash.org/debitisdoloremvoluptatibus.jpg?size=50x50&set=set1', 'abillinge14@elpais.com', '755-579-2166', '3543033211151914', 'GRUPO AVAL', 501, 721);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (980, '1887535942', 'Latrena', 'Threadgould', 'https://robohash.org/consequaturestvoluptatum.bmp?size=50x50&set=set1', 'lthreadgould15@mozilla.com', '717-235-5915', '30483398035016', 'DAVIVIENDA', 501, 712);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (945, '6788477949', 'Rockie', 'Breeds', 'https://robohash.org/quiamolestiaeitaque.png?size=50x50&set=set1', 'rbreeds16@cloudflare.com', '302-727-3317', '3557071689502641', 'GRUPO AVAL', 505, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (957, '0643780173', 'Renato', 'Duny', 'https://robohash.org/nostrummaximeomnis.bmp?size=50x50&set=set1', 'rduny17@gnu.org', '235-306-9927', '4844399341738373', 'ITAU', 504, 712);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (998, '0939199599', 'Marcela', 'McKimmie', 'https://robohash.org/perspiciatissintaut.bmp?size=50x50&set=set1', 'mmckimmie18@wiley.com', '889-565-4100', '5602214558399570', 'NEQUI', 506, 721);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (942, '5462017502', 'Thorn', 'Goodredge', 'https://robohash.org/pariaturerrorut.bmp?size=50x50&set=set1', 'tgoodredge19@skyrock.com', '878-970-5361', '5466355772317974', 'ITAU', 504, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (949, '5434466144', 'Kristian', 'Seine', 'https://robohash.org/utillummolestiae.bmp?size=50x50&set=set1', 'kseine1a@quantcast.com', '630-615-9467', '5602225760332357', 'ITAU', 501, 723);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (988, '5228772685', 'Demott', 'Larcher', 'https://robohash.org/earumprovidentenim.bmp?size=50x50&set=set1', 'dlarcher1b@smugmug.com', '313-864-7282', '3566610920275951', 'NEQUI', 501, 714);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (968, '9445628268', 'Rebeca', 'Dysart', 'https://robohash.org/aspernaturfugiatenim.bmp?size=50x50&set=set1', 'rdysart1c@yahoo.com', '124-172-3653', '3564225450703041', 'GRUPO AVAL', 504, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, NUMERO_CUENTA, ENTIDAD_BANCARIA, IDIOMA_ID, CIUDAD_ID) values (967, '3632049068', 'Xever', 'Shrimpton', 'https://robohash.org/laboreblanditiisaperiam.bmp?size=50x50&set=set1', 'xshrimpton1d@list-manage.com', '824-791-5628', '3580878689646553', 'ITAU', 506, 721);

-- VEHICULOS
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1128, '1C4RDHAG9FC095669', 'Suzuki', 1996, 'Sidekick', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1082, '1FT7W2A69EE072074', 'Dodge', 2008, 'Magnum', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1162, '5FRYD3H4XFB020832', 'Dodge', 2010, 'Grand Caravan', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1126, 'JN8AS5MT4BW026234', 'Audi', 2006, 'A4', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1027, '5N1AN0NU7EN452390', 'Mercedes-Benz', 2006, 'SL-Class', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1097, 'SCBFR7ZA8CC790657', 'Dodge', 1992, 'Ram Van B250', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1008, 'JTEBU5JR6D5041034', 'Dodge', 1992, 'D350 Club', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1169, '2HNYD28738H604003', 'Pontiac', 2000, 'Sunfire', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1084, '5GAKVCKD2FJ158582', 'Infiniti', 2010, 'G', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1166, '2T3BFREV7EW813340', 'Lotus', 1995, 'Esprit', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1104, 'WBAUP7C56BV108736', 'GMC', 1996, '1500', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1075, 'TRUDD38J991451140', 'BMW', 2004, 'M3', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1054, '1G6KF579X2U047821', 'Pontiac', 1986, 'Firebird', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1029, '4A37L2EF2AE130040', 'Isuzu', 1998, 'Trooper', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1095, 'WBAVC73557K289742', 'Ford', 2010, 'E350', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1090, '2HNYB1H61DH158421', 'Toyota', 2005, 'Tundra', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1024, '1GD422CG9EF894953', 'Isuzu', 1999, 'Trooper', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1094, '2LMHJ5AR8BB137991', 'Dodge', 2003, 'Ram 3500', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1067, '2B3CM5CTXBH398385', 'Chevrolet', 1995, 'Caprice', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1110, '1N6AA0EC3EN325382', 'Honda', 1984, 'Accord', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1057, 'YV4952CT2E1750833', 'Nissan', 1999, 'Quest', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1055, '1FTEX1E89AF117478', 'Volvo', 2007, 'S80', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1165, 'WAUUL78E36A349784', 'GMC', 2005, 'Envoy XUV', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1133, 'WDDPK4HA6CF159500', 'Nissan', 1994, 'Quest', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1188, 'WDBWK5EA6AF680700', 'Ford', 2011, 'E150', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1193, 'WAUDF98E38A911091', 'Buick', 2007, 'Lucerne', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1106, '137FA90391E887739', 'Dodge', 2003, 'Viper', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1070, '19UUA9F59EA980904', 'GMC', 2012, 'Savana 3500', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1198, '3VWJP7AT5CM748114', 'Mercedes-Benz', 2009, 'R-Class', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1084, 'WVGAV3AX6EW251057', 'Maybach', 2012, '62', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1034, '1FTEW1C86FK383450', 'Volkswagen', 2004, 'Jetta', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1115, '1G6DJ577280379144', 'Mercury', 2001, 'Sable', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1157, 'YV1622FS7C2398240', 'Porsche', 2006, '911', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1156, 'WDDGF4HB5DG302266', 'BMW', 2005, '760', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1124, '1G6DG5E56D0728607', 'Cadillac', 2000, 'Seville', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1048, 'WBAWR33539P514659', 'Toyota', 2009, 'Venza', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1110, 'WVWED7AJ1DW915338', 'Audi', 2002, 'S8', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1136, 'JN8AZ1MU6EW871779', 'Mitsubishi', 2011, 'Lancer', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1065, 'JTEBC3EH9C2110999', 'Toyota', 2002, 'Celica', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1147, 'SALWG2WF8EA745909', 'Mercury', 2001, 'Cougar', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1180, 'WAUKG58E35A478025', 'Dodge', 2000, 'Ram 1500', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1164, 'JN1AZ4EH9BM229601', 'Buick', 2000, 'Park Avenue', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1074, 'YV1672MK0D2940624', 'Buick', 1989, 'Electra', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1123, 'JN8AF5MR5BT793309', 'Dodge', 2007, 'Ram 2500', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1147, 'JH4CU2F4XCC214552', 'Chrysler', 1997, 'Town & Country', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1162, 'WAUBF78E67A093849', 'Audi', 2002, 'A6', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1073, '2LMDJ6JKXEB174889', 'Pontiac', 1969, 'Grand Prix', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1149, '3FA6P0D91DR383344', 'MINI', 2012, 'Cooper Countryman', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1119, '2HNYD18864H120467', 'Mercedes-Benz', 2012, 'SLS-Class', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1020, '2B3CK3CV4AH035963', 'GMC', 2005, 'Yukon', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1137, 'WAUDH78E98A438702', 'Mercedes-Benz', 2003, 'C-Class', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1143, 'WAUML64B33N873687', 'Toyota', 1992, 'Previa', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1025, '3N1AB7AP6FL977869', 'Chevrolet', 1999, 'Suburban 1500', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1159, '5GAKRBED3CJ393451', 'Chrysler', 1993, 'LeBaron', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1193, 'WUAW2AFC2FN390223', 'BMW', 2011, 'X5', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1163, 'WAUBT48H95K976787', 'Porsche', 1990, '911', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1051, '5NPDH4AE1DH202849', 'Chevrolet', 2010, 'Corvette', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1048, '1G6DL67A990449493', 'Jeep', 2001, 'Cherokee', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1156, '5J6TF2H54FL713394', 'Chrysler', 2009, '300', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1022, 'WAUKF78E18A671535', 'Ford', 2002, 'F150', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1042, 'WBASP0C51DC057921', 'GMC', 2002, 'Yukon XL 2500', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1168, '1G6AD5S31D0444056', 'GMC', 2011, 'Yukon XL 1500', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1193, '1FMEU6FE5AU497498', 'Chevrolet', 2009, 'Silverado 2500', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1016, 'WBANV13599C086423', 'Cadillac', 2005, 'SRX', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1112, 'WBAKE5C55BE897589', 'Land Rover', 2001, 'Discovery', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1114, 'WBAKB0C51CC330742', 'Porsche', 2012, 'Cayman', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1114, 'WAU2GAFC2EN224695', 'GMC', 1992, 'Sonoma Club', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1152, 'JTDKN3DPXF3117207', 'Isuzu', 1999, 'Trooper', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1097, '2C3CDXEJ0EH507550', 'Lexus', 2004, 'IS', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1013, 'WAUKFBFL6AA149963', 'Chevrolet', 2001, 'Express 2500', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1122, 'WBA1F5C59FV030016', 'Buick', 1989, 'Estate', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1106, '2G4WB55K531584069', 'Mazda', 2010, 'CX-7', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1018, 'WBA3D5C51EK977386', 'Jaguar', 2009, 'XK', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1005, 'WAUMFBFL5BN161346', 'GMC', 1993, 'Suburban 2500', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1143, '3D7JV1EP5BG349855', 'Toyota', 1998, 'Sienna', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1090, 'WBAGL83535D503790', 'Chevrolet', 2008, 'Silverado', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1043, 'WBADS43442G895274', 'Lexus', 2013, 'GS', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1042, 'WBAWL7C51AP383518', 'Toyota', 1992, 'Previa', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1105, '5UMDU93487L109481', 'Nissan', 2008, 'Frontier', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1197, '1HGCR2E55EA575569', 'Mazda', 1992, 'Navajo', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1110, '137FA84351E241974', 'Subaru', 2000, 'Outback', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1027, '1GYUCDEF0AR925513', 'Lexus', 2011, 'IS', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1135, 'WAUGL78E86A608038', 'Infiniti', 1997, 'Q', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1040, '1G6DC1E34C0842493', 'Pontiac', 1992, 'Grand Prix', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1194, '1G6KA5EY6AU801742', 'Chevrolet', 2009, 'Corvette', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1025, 'WAUGVAFR7BA037598', 'Oldsmobile', 1995, 'Ciera', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1058, '2C3CDZBG7FH584390', 'Lexus', 2000, 'ES', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1168, '3GYFK62897G327829', 'Mitsubishi', 1993, 'Mighty Max', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1034, 'JN1CV6EK1EM401166', 'Lexus', 2005, 'IS', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1118, '5GAKRAEDXBJ684389', 'Mazda', 2007, 'Mazda3', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1076, '1VWAS7A34FC210346', 'Chevrolet', 2006, 'Silverado 3500HD', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1007, '1FTEX1CM6BK004760', 'Saab', 1984, '900', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1149, 'WBANU53539B427427', 'Mazda', 1989, '626', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1082, 'WA1YD64B52N329203', 'Kia', 1999, 'Sportage', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1177, 'WAUVC58E95A000250', 'Jeep', 2010, 'Grand Cherokee', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1054, '19UUA8F28CA873355', 'Toyota', 2004, '4Runner', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1041, 'JTJBC1BA8B2712272', 'Chevrolet', 2012, 'Corvette', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1038, 'WAUKFAFL8CN505223', 'Mitsubishi', 2007, 'Lancer', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1100, 'WBANU5C52AB814264', 'Nissan', 2005, 'Maxima', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1046, '2HNYD182X4H435963', 'Buick', 1997, 'LeSabre', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1118, 'WBAWL13547P413858', 'Audi', 2009, 'A5', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1220, '1G6DM57T070852557', 'Buick', 2011, 'LaCrosse', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1202, '2B3CK9CVXAH175423', 'Toyota', 2011, 'Corolla', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1229, 'SCFAB22301K416722', 'Ford', 1989, 'Mustang', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1217, '1G6KE57Y52U106557', 'Volkswagen', 2001, 'Eurovan', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1274, '19UUA76537A925727', 'Mercury', 1998, 'Grand Marquis', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1233, 'WBA6A0C54ED710384', 'Volkswagen', 2010, 'GTI', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1292, 'KNAFK4A68F5875396', 'GMC', 2001, 'Savana 3500', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1277, '1N6AF0LY7FN661148', 'Acura', 1997, 'CL', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1274, '1FTMF1EW0AK437597', 'Buick', 1998, 'Riviera', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1234, '1G6AB5SX5D0581901', 'Audi', 2010, 'S6', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1268, 'WAUAC48H15K079202', 'Jeep', 2011, 'Patriot', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1227, '1FTWF3B55AE675816', 'Audi', 2002, 'Allroad', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1229, '3D73Y4CL1AG202559', 'Mitsubishi', 1994, 'Truck', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1272, 'WBA3B9C51DJ970634', 'Volkswagen', 1996, 'Jetta', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1235, '1GYS4JEF1CR736567', 'Isuzu', 1993, 'Rodeo', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1254, '5FRYD4H44FB972604', 'BMW', 2001, '525', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1291, '5N1AA0NC0BN883894', 'Nissan', 2004, 'Altima', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1202, '1GYFK63868R538681', 'Mitsubishi', 1999, 'Diamante', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1220, 'VNKKTUD3XFA426896', 'Chevrolet', 2007, 'Express 2500', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1255, '1GD21ZCG5BZ298431', 'Ford', 2006, 'Thunderbird', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1236, '1FTEW1CMXBF839935', 'Ford', 2003, 'Freestar', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1265, '1G4GA5ER0DF856526', 'Ford', 2003, 'E350', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1236, 'WBALL5C52CE542021', 'Volkswagen', 2007, 'Eos', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1279, 'JTDKTUD33DD185543', 'Dodge', 1992, 'Daytona', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1244, 'WAUEH74F46N654868', 'Toyota', 2012, 'Tacoma', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1231, 'WBAKP9C50ED828305', 'BMW', 2001, '5 Series', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1274, '1YVHZ8BH5B5895592', 'Dodge', 1997, 'Ram 2500', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1242, '5XYZT3LB8FG214069', 'Subaru', 1995, 'Impreza', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1212, 'JN1BJ0HP2FM772589', 'Ford', 1968, 'Mustang', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1215, '1G4HP57227U849967', 'Buick', 1989, 'Riviera', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1201, 'WAUEV94F97N367998', 'GMC', 2007, 'Envoy', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1299, '1FTWW3CY5AE843348', 'Pontiac', 2003, 'Aztek', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1290, '1GKS1FFJ4BR878266', 'Nissan', 2010, 'Pathfinder', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1282, '5N1AL0MM8EC980698', 'Toyota', 2007, 'Sequoia', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1296, '1G4HE57Y06U788921', 'Ford', 1999, 'Econoline E350', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1278, 'WAUAF78E26A196759', 'Pontiac', 2000, 'Firebird', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1222, 'JH4CL96986C797375', 'Mercury', 1986, 'Lynx', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1270, '1D7RV1CP3AS837487', 'Porsche', 1998, '911', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1209, 'WAURFAFR4EA642950', 'Audi', 2002, 'S4', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1263, '5UXFB93573L607370', 'Saab', 1989, '9000', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1223, 'SCBET9ZA4FC617019', 'Scion', 2010, 'tC', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1248, 'WVGEF9BP1ED403595', 'Toyota', 2010, 'Corolla', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1249, '1G6KF54954U422571', 'Volkswagen', 2008, 'Touareg 2', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1293, 'SAJWA0EXXE8202920', 'Ford', 2011, 'Mustang', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1223, '1N6AF0LX0EN432252', 'Mercury', 2000, 'Mountaineer', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1255, 'WBAEW53462P645372', 'Mercury', 1991, 'Cougar', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1233, '19UUA96299A037021', 'Mitsubishi', 1987, 'Truck', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1295, 'WBAKX6C53BC747265', 'Acura', 2004, 'RL', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1297, 'JTHFF2C29D2080862', 'Honda', 1987, 'Accord', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1273, '1G4GC5EC4BF328703', 'Chrysler', 1999, 'LHS', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1292, '5J8TB4H35DL474514', 'GMC', 1992, '3500 Club Coupe', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1202, 'WA1CGBFE1ED298401', 'Mazda', 1983, 'RX-7', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1244, 'WBAWC73598E643167', 'Mitsubishi', 1992, 'RVR', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1210, 'WVWED7AJXDW856533', 'Chevrolet', 2001, 'Camaro', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1233, '2G4GK5EX0E9517366', 'Nissan', 2012, 'JUKE', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1215, 'WBAWL13599P453999', 'GMC', 2001, 'Sierra 3500', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1267, 'JH4KA96504C436556', 'Saab', 1988, '9000', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1250, 'WAUKF98E15A156381', 'BMW', 1993, '5 Series', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1252, 'YV4612HM5F1639212', 'Isuzu', 1997, 'Hombre Space', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1277, 'JN1CV6AP3AM065063', 'Geo', 1996, 'Prizm', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1224, '5UXFB53554L290487', 'Land Rover', 2010, 'Range Rover', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1219, 'WBAKB4C56BC224406', 'Mazda', 2012, 'CX-9', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1268, 'WBADS33441G740698', 'Kia', 2008, 'Amanti', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1281, 'WBAAV33431E831595', 'Chevrolet', 2006, 'Suburban 1500', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1277, 'WAUGFAFR0CA568897', 'Chevrolet', 1993, 'Camaro', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1205, '1G6DA8EG4A0874505', 'Lotus', 2004, 'Exige', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1231, 'SALAK2V66FA003326', 'Dodge', 1996, 'Neon', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1241, '1C4NJCBA8DD486470', 'Isuzu', 1999, 'Trooper', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1250, '1FTEW1C85FK099369', 'Toyota', 1994, 'MR2', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1289, 'WAUKFAFL7CA821669', 'GMC', 1995, 'Vandura G1500', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1287, 'KMHTC6ADXFU826814', 'Audi', 2013, 'S4', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1246, '2FMDK3AKXCB380411', 'Lincoln', 2011, 'Navigator', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1244, 'WAUDF78E95A440242', 'Audi', 1997, 'A4', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1281, 'JN1CV6EK2AM894429', 'Ford', 2005, 'F-Series', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1255, '2C4RDGBG2ER688384', 'Mercury', 2008, 'Grand Marquis', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1242, 'JTDBT4K33A1383264', 'Honda', 1997, 'Passport', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1212, 'JM1NC2EFXA0257478', 'Chevrolet', 1953, 'Corvette', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1221, '4T1BB3EK1AU987941', 'Lexus', 2012, 'HS', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1254, 'WA1CYAFE7AD281829', 'Mazda', 1995, '323', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1246, 'WAUSG94F09N150355', 'Honda', 2002, 'CR-V', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1232, '1FTEX1C81AK193688', 'Ford', 2011, 'E-Series', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1246, 'SCFFDABE0AG259000', 'Volkswagen', 2007, 'GTI', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1202, '3C63D2JLXCG978633', 'Isuzu', 2001, 'Rodeo', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1245, 'WBA3A5G51FN765509', 'Volvo', 2000, 'S70', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1225, 'WUAGNAFG8CN180042', 'Mitsubishi', 1998, 'GTO', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1213, 'WBALW7C5XDD929197', 'Chevrolet', 2002, 'Suburban 1500', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1210, '3VW217AU1FM704811', 'GMC', 1993, 'Sonoma Club Coupe', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1257, 'NM0KS9BN9AT139105', 'Ford', 2000, 'Crown Victoria', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1262, '1GYUCHEF2AR724980', 'Mazda', 1994, 'MX-5', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1220, '1FBAX2CM4FK216880', 'Chevrolet', 2004, 'Aveo', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1263, '1G4HP57M89U385863', 'GMC', 1997, 'Savana 3500', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1296, 'WAUK2AFD9FN066638', 'Chevrolet', 1996, 'Corvette', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1277, '3D73M4HL7BG506887', 'Ford', 2003, 'ZX2', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1205, '3C3CFFJH9ET894548', 'Buick', 1992, 'Coachbuilder', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1257, '5TDBK3EH1BS007686', 'Audi', 1999, 'A6', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1230, '1GD12YEG0FF747361', 'Oldsmobile', 1998, 'Aurora', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1211, 'KMHGN4JE8FU821667', 'Ford', 1992, 'Ranger', 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1285, '1D4PT7GXXAW266211', 'GMC', 1992, 'Vandura 2500', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1284, 'WAULT68E52A022867', 'Toyota', 2000, 'MR2', 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1297, 'WAUBVAFA2AN839181', 'Volkswagen', 2003, 'Golf', 'UberX');

-- CONDUCTORES_VEHICULOS

insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1, 901, 1070);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (2, 856, 1107);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (3, 948, 1171);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (4, 840, 1194);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (5, 893, 1248);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (6, 811, 1077);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (7, 834, 1159);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (8, 800, 1282);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (9, 849, 1276);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (10, 917, 1050);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (11, 857, 1017);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (12, 832, 1135);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (13, 837, 1240);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (14, 973, 1208);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (15, 968, 1091);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (16, 820, 1244);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (17, 836, 1204);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (18, 966, 1123);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (19, 853, 1194);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (20, 908, 1142);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (21, 880, 1042);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (22, 919, 1134);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (23, 918, 1107);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (24, 907, 1187);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (25, 874, 1226);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (26, 957, 1161);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (27, 935, 1072);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (28, 874, 1030);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (29, 893, 1077);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (30, 869, 1030);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (31, 880, 1207);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (32, 909, 1190);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (33, 837, 1170);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (34, 926, 1179);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (35, 825, 1209);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (36, 954, 1234);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (37, 815, 1293);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (38, 853, 1255);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (39, 991, 1063);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (40, 866, 1192);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (41, 805, 1047);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (42, 960, 1262);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (43, 944, 1143);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (44, 960, 1225);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (45, 982, 1102);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (46, 852, 1153);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (47, 938, 1198);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (48, 917, 1286);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (49, 979, 1271);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (50, 880, 1260);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (51, 837, 1249);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (52, 816, 1184);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (53, 889, 1027);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (54, 1000, 1281);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (55, 953, 1136);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (56, 832, 1235);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (57, 924, 1232);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (58, 899, 1174);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (59, 872, 1216);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (60, 957, 1209);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (61, 831, 1126);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (62, 990, 1296);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (63, 867, 1122);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (64, 814, 1169);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (65, 827, 1026);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (66, 987, 1031);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (67, 876, 1160);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (68, 829, 1171);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (69, 920, 1098);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (70, 882, 1254);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (71, 850, 1146);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (72, 871, 1262);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (73, 919, 1184);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (74, 862, 1232);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (75, 895, 1205);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (76, 842, 1192);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (77, 991, 1094);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (78, 969, 1048);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (79, 966, 1270);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (80, 913, 1021);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (81, 914, 1113);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (82, 980, 1200);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (83, 826, 1054);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (84, 918, 1203);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (85, 890, 1218);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (86, 907, 1118);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (87, 834, 1127);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (88, 942, 1193);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (89, 993, 1285);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (90, 989, 1227);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (91, 843, 1210);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (92, 849, 1138);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (93, 959, 1221);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (94, 836, 1300);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (95, 802, 1258);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (96, 875, 1189);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (97, 805, 1184);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (98, 902, 1216);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (99, 996, 1050);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (100, 959, 1022);

--EMPRESAS

insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1370, '1554337194', 'Rhynoodle', '3 Shopko Parkway', '282-686-2926', 'lrichford0@patch.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1357, '4935937467', 'Thoughtbeat', '42 Kinsman Way', '747-875-2018', 'jlattimer1@epa.gov');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1364, '5394914095', 'Eabox', '75916 Schlimgen Junction', '287-622-4504', 'gmccuis2@youtube.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1331, '5861524289', 'Jetpulse', '8241 Union Drive', '519-611-3890', 'mseaton3@ox.ac.uk');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1351, '0167363298', 'Gigashots', '033 Becker Parkway', '663-784-9037', 'aoshavlan4@digg.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1307, '1310374473', 'Jaxnation', '105 Columbus Point', '645-535-0047', 'sperassi5@blogger.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1338, '6122011177', 'Dabjam', '354 Stang Center', '207-990-6062', 'hhartfleet6@redcross.org');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1393, '0353779199', 'Jazzy', '419 Jenna Hill', '148-198-7657', 'udoret7@1688.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1347, '2829590589', 'Photofeed', '174 Bay Plaza', '842-991-1749', 'zgorce8@dyndns.org');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1306, '4062552361', 'Babblestorm', '72917 Lighthouse Bay Park', '926-131-7245', 'rchishull9@deviantart.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1324, '7318251457', 'Aibox', '64 Carberry Place', '561-532-6212', 'ehazeltinea@wikia.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1393, '4239770351', 'Jabbertype', '223 Kipling Lane', '548-641-7121', 'abrickhamb@surveymonkey.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1333, '1093807458', 'Skinix', '0 Burning Wood Street', '311-738-6480', 'nbennitc@home.pl');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1316, '7366304700', 'Buzzdog', '7 Forest Hill', '760-884-3446', 'ykeherd@stumbleupon.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1312, '5109900779', 'Mynte', '992 Express Crossing', '266-518-6610', 'jsuerze@typepad.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1392, '3835757644', 'Jaxbean', '81 Mayer Crossing', '156-782-4044', 'rdekeyserf@usnews.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1363, '9890702770', 'Vitz', '36888 Del Mar Trail', '399-183-0828', 'wrosellinig@gov.uk');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1303, '5350893033', 'Aibox', '64740 Corscot Parkway', '873-903-0188', 'cbamletth@netlog.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1380, '4395844766', 'BlogXS', '12262 Donald Trail', '926-547-7637', 'kwickmani@microsoft.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1314, '7485405942', 'Livefish', '806 Sutherland Junction', '159-528-0925', 'asewartj@parallels.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1314, '3844828931', 'Avamm', '99 Twin Pines Pass', '652-980-5388', 'gkeytek@1und1.de');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1324, '7308009130', 'Tekfly', '47538 Welch Place', '368-953-1896', 'londrakl@hexun.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1309, '9519854703', 'Dazzlesphere', '803 Spenser Way', '535-985-2427', 'bfiddymentm@deliciousdays.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1369, '4996520744', 'Yamia', '42 Basil Park', '998-557-3755', 'lwilflingn@example.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1335, '5159559604', 'Jetwire', '90 Mendota Point', '212-680-3206', 'mselewayo@pbs.org');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1398, '9651756276', 'Shufflester', '81409 Melby Drive', '547-663-3801', 'nlascellp@hp.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1359, '4663237258', 'Tazz', '3 Coleman Parkway', '880-472-0844', 'mbursellq@google.co.jp');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1346, '4815163529', 'Vitz', '8 Arkansas Terrace', '220-118-1402', 'msimonour@newyorker.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1360, '8474595681', 'Katz', '86117 Bluestem Point', '955-391-0067', 'akarolczyks@de.vu');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1339, '2851508407', 'Skippad', '557 Sherman Court', '402-235-6995', 'ndinsdalet@washington.edu');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1384, '2959339509', 'Jabberbean', '3034 Hazelcrest Place', '734-103-0330', 'kinnocentiu@networkadvertising.org');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1324, '0585630585', 'Twitternation', '0873 Ilene Alley', '483-934-4830', 'csibberingv@abc.net.au');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1310, '3502975841', 'Katz', '88771 Fulton Place', '169-524-5747', 'kkunzelmannw@dell.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1314, '6886715518', 'Browsecat', '6 Fordem Lane', '450-352-9343', 'sdelapx@howstuffworks.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1346, '4985646067', 'Fadeo', '63 Thierer Place', '309-648-3137', 'emaray@ask.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1328, '1089127278', 'Yodel', '604 Jana Hill', '103-223-2072', 'lorangez@uiuc.edu');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1386, '2875415107', 'Voonyx', '663 Prairieview Court', '554-401-9467', 'tcanavan10@ycombinator.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1329, '2018907581', 'Yakijo', '7 Holy Cross Plaza', '626-646-2372', 'tliversedge11@g.co');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1323, '3578832960', 'Kwilith', '72811 Menomonie Parkway', '247-178-6121', 'mgettins12@businessinsider.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1328, '0842344969', 'Trunyx', '2 West Pass', '878-387-9655', 'teaden13@bloglines.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1345, '0174929331', 'Mydeo', '3217 Dwight Park', '267-651-0776', 'mhemphill14@w3.org');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1361, '6569722166', 'LiveZ', '1160 Eastwood Road', '578-331-7150', 'belwel15@apple.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1368, '7808160482', 'Twitternation', '906 Gerald Avenue', '451-558-2977', 'bbeavington16@discuz.net');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1352, '9861779884', 'Twitterwire', '2 Fallview Point', '451-353-0789', 'adunderdale17@skype.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1378, '5294447835', 'DabZ', '459 Kingsford Hill', '207-367-0644', 'cmusicka18@google.de');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1356, '8307451396', 'Aimbo', '06 Victoria Crossing', '555-490-3227', 'gtocknell19@arstechnica.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1316, '1211427552', 'Flipstorm', '827 Hazelcrest Terrace', '687-907-0858', 'rcolles1a@wufoo.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1398, '0181773821', 'Miboo', '1535 Birchwood Plaza', '834-246-8278', 'jturfes1b@histats.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1328, '0676513824', 'Realfire', '40 Monterey Point', '137-105-1014', 'hbenedict1c@alibaba.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1333, '8076775051', 'Tagfeed', '643 Morning Junction', '388-847-3676', 'ppitts1d@spiegel.de');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1327, '2702195385', 'Blogpad', '99129 Commercial Parkway', '715-969-0521', 'atugwell1e@wp.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1361, '3571034562', 'Camimbo', '6 Crowley Crossing', '311-203-5946', 'bcoopey1f@mediafire.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1398, '7268397380', 'Meevee', '7 North Plaza', '802-142-2052', 'bsharrock1g@google.com.hk');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1325, '5524348078', 'Tekfly', '9532 Cardinal Drive', '344-417-0544', 'cgoggin1h@cargocollective.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1355, '7099874772', 'Edgeclub', '0515 Manufacturers Hill', '619-696-7387', 'isherrocks1i@eepurl.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1376, '8893112140', 'Twitterlist', '9 Pleasure Trail', '724-128-8231', 'clodevick1j@homestead.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1348, '1817895915', 'Vipe', '093 Westport Center', '836-528-5668', 'redger1k@dot.gov');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1384, '6121974745', 'Meezzy', '41538 Anthes Street', '792-119-8525', 'gswalough1l@webnode.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1353, '3361243149', 'Jazzy', '509 Florence Plaza', '212-434-9658', 'jbrandino1m@istockphoto.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1315, '6090832960', 'Feedbug', '52 Moose Center', '282-763-8090', 'mterren1n@tamu.edu');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1323, '8515339005', 'Realbuzz', '34473 Eagan Avenue', '459-646-8182', 'ptibb1o@bravesites.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1325, '0823399796', 'Fadeo', '318 Everett Hill', '761-610-1398', 'bmiller1p@g.co');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1351, '7530513230', 'Dynazzy', '68 Hoard Place', '443-566-5526', 'rblofeld1q@foxnews.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1395, '4519005914', 'Yabox', '6905 Ohio Avenue', '209-709-2517', 'bkrates1r@mozilla.org');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1354, '2450138528', 'Yadel', '3 Ryan Trail', '520-352-4589', 'tdellow1s@vistaprint.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1356, '7102338139', 'Cogidoo', '5647 Bayside Circle', '125-886-3669', 'aargyle1t@uol.com.br');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1362, '4403881556', 'Oyondu', '62885 Kropf Court', '757-613-4403', 'cwhitney1u@usnews.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1327, '3913987444', 'Vinte', '60320 Eliot Park', '171-564-4724', 'pfuzzens1v@boston.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1307, '1534837299', 'Realfire', '096 Monterey Circle', '651-887-0876', 'oculley1w@slashdot.org');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1396, '0146818679', 'Yakitri', '1 Kipling Way', '567-861-6160', 'ljurick1x@1und1.de');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1391, '6260929013', 'Kaymbo', '9390 Division Terrace', '640-516-9355', 'casee1y@macromedia.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1400, '6781256386', 'Quire', '26062 Burrows Circle', '292-813-4043', 'ltheodore1z@reuters.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1357, '4956761694', 'Dabshots', '5 School Lane', '635-120-8640', 'pohalloran20@nyu.edu');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1384, '8493958913', 'Avaveo', '8864 Myrtle Plaza', '794-843-5131', 'kcheale21@dropbox.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1359, '4494349186', 'Feedfire', '56189 Pankratz Junction', '850-428-4178', 'bhinners22@newsvine.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1339, '3488615413', 'Kimia', '8 South Hill', '372-998-5431', 'otreace23@nsw.gov.au');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1392, '7448533029', 'Dabshots', '3444 Mifflin Plaza', '340-617-3059', 'pbainton24@last.fm');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1389, '3366903228', 'Quamba', '35049 Hagan Pass', '336-251-2211', 'lfaucherand25@tamu.edu');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1367, '7570024079', 'Edgeclub', '82383 8th Court', '100-186-8942', 'sworkes26@altervista.org');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1328, '6930005347', 'Feedbug', '109 Buhler Terrace', '956-485-2274', 'gbusk27@4shared.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1344, '1997117967', 'Demimbu', '1 Mesta Terrace', '106-654-9091', 'nbrownscombe28@un.org');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1392, '5329994608', 'Feedfire', '697 Moose Hill', '514-497-8317', 'cgilliard29@guardian.co.uk');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1314, '2799968333', 'Gigabox', '08 Colorado Drive', '436-691-1655', 'bmcewen2a@cdc.gov');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1400, '3495431055', 'Dynazzy', '11 Dunning Place', '484-331-4712', 'rthornebarrow2b@flickr.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1328, '2968124153', 'JumpXS', '3526 Jenifer Hill', '960-586-7160', 'tjessope2c@sogou.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1392, '6838058782', 'Teklist', '3998 Harper Hill', '684-903-8551', 'sglassard2d@fastcompany.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1348, '6547587819', 'Livefish', '48214 Hayes Street', '889-864-3082', 'bcrayden2e@seattletimes.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1314, '7250036408', 'Blogtag', '0 Luster Junction', '331-447-3176', 'lkield2f@pen.io');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1399, '6325794451', 'Skinix', '10 Saint Paul Plaza', '126-132-7598', 'ksouness2g@freewebs.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1352, '6932609002', 'Twitterwire', '197 Mayfield Drive', '116-225-0683', 'vgrayshon2h@rediff.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1330, '2882815557', 'Layo', '74970 Stuart Street', '798-993-1556', 'kleggitt2i@alibaba.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1328, '4238036999', 'Eire', '0 Golden Leaf Road', '546-318-6578', 'kdominik2j@dagondesign.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1346, '7315660437', 'Browsetype', '51 Eagan Crossing', '637-308-9483', 'astowers2k@mlb.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1372, '7681978801', 'Gigabox', '04857 Linden Trail', '834-671-3815', 'mthorowgood2l@biblegateway.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1337, '6168910085', 'Gigabox', '522 Laurel Trail', '864-490-3227', 'akinver2m@si.edu');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1331, '9880505743', 'Skyndu', '262 Jenifer Alley', '992-100-2007', 'egainsbury2n@mozilla.org');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1360, '7347261007', 'Youspan', '3432 Sage Road', '479-634-1387', 'eribbens2o@cisco.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1370, '8763249413', 'Flashdog', '86 Columbus Center', '234-719-2938', 'jgethouse2p@alexa.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1367, '7174639518', 'Kwimbee', '5 Di Loreto Place', '473-790-9717', 'sgarriock2q@cbslocal.com');
insert into EMPRESAS  (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (1375, '6301495268', 'Rhybox', '37 Russell Junction', '394-385-9668', 'kpetrecz2r@nih.gov');

--DETALLES MEDIOS PAGOS

insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1422, 'MASTERCARD', '7/17/2018', '348114636877169', '0115-1208', 'DAVIVIENDA', 4);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1424, 'AMERICAN EXPRESS', '9/25/2017', '3581592970936057', '59762-3719', 'GRUPO AVAL', 4);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1467, 'AMERICAN EXPRESS', '3/24/2018', '5602233473535233', '65162-669', 'NEQUI', 3);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1479, 'DINNERS CLUB', '3/27/2018', '3572998330307023', '0904-5880', 'NEQUI', 3);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1477, 'DINNERS CLUB', '6/13/2018', '201569842644131', '55289-310', 'DAVIVIENDA', 3);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1411, 'AMERICAN EXPRESS', '7/4/2018', '4936426280101436355', '58876-102', 'NEQUI', 4);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1437, 'VISA', '8/31/2018', '348857668124526', '45802-049', 'GRUPO AVAL', 3);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1500, 'DINNERS CLUB', '10/4/2017', '3551346734698867', '66613-8144', 'GRUPO AVAL', 4);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1407, 'DINNERS CLUB', '10/17/2017', '374283745327296', '51801-007', 'ITAU', 3);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1419, 'DINNERS CLUB', '12/14/2017', '3573466356880686', '0091-4085', 'GRUPO AVAL', 2);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1414, 'AMERICAN EXPRESS', '12/28/2017', '5007664011506727', '56062-008', 'BANCOLOMBIA', 1);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1492, 'MASTERCARD', '6/9/2018', '3549227657730983', '51209-004', 'ITAU', 3);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1440, 'MASTERCARD', '1/9/2018', '3589787374439789', '54868-5886', 'BANCOLOMBIA', 1);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1443, 'MASTERCARD', '10/2/2017', '4041376778734', '60429-031', 'NEQUI', 4);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1464, 'MASTERCARD', '4/23/2018', '6371530478320504', '61748-025', 'NEQUI', 4);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1432, 'MASTERCARD', '6/1/2018', '3557821123489486', '0924-5603', 'NEQUI', 3);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1410, 'MASTERCARD', '3/21/2018', '6333244811985661', '50988-280', 'ITAU', 3);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1415, 'AMERICAN EXPRESS', '9/13/2018', '4041592376057', '10812-925', 'NEQUI', 4);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1408, 'DINNERS CLUB', '12/6/2017', '3574732066913508', '60681-6300', 'BANCOLOMBIA', 3);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1484, 'VISA', '11/2/2017', '060406947881888594', '59535-1041', 'BANCOLOMBIA', 4);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1490, 'AMERICAN EXPRESS', '9/30/2017', '30398218480483', '10237-726', 'ITAU', 2);
insert into DETALLES_MEDIOS_PAGO (ID, FRANQUICIA, FECHA_EXPIRACION , NUMERO_TARJETA , CODIGO_CVV , ENTIDAD_BANCARIA , MEDIO_PAGO_ID) values (1458, 'MASTERCARD', '1/7/2018', '4041374528814298', '51879-161', 'BANCOLOMBIA', 3);

--- EMPRESAS MEDIOS PAGOS

insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (1, 1353, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (2, 1350, 3);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (3, 1304, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (4, 1329, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (5, 1315, 3);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (6, 1380, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (7, 1348, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (8, 1327, 3);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (9, 1383, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (10, 1391, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (11, 1308, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (12, 1396, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (13, 1358, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (14, 1392, 3);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (15, 1373, 3);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (16, 1312, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (17, 1400, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (18, 1302, 3);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (19, 1387, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (20, 1371, 3);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (21, 1360, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (22, 1321, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (23, 1354, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (24, 1392, 3);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (25, 1397, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (26, 1376, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (27, 1395, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (28, 1353, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (29, 1400, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (30, 1397, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (31, 1393, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (32, 1341, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (33, 1391, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (34, 1366, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (35, 1354, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (36, 1350, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (37, 1328, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (38, 1362, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (39, 1312, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (40, 1309, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (41, 1307, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (42, 1387, 3);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (43, 1379, 3);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (44, 1334, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (45, 1327, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (46, 1398, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (47, 1341, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (48, 1324, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (49, 1345, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (50, 1322, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (51, 1312, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (52, 1367, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (53, 1308, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (54, 1356, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (55, 1317, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (56, 1330, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (57, 1309, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (58, 1387, 3);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (59, 1378, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (60, 1337, 3);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (61, 1384, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (62, 1310, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (63, 1359, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (64, 1337, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (65, 1343, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (66, 1369, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (67, 1380, 3);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (68, 1344, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (69, 1396, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (70, 1331, 3);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (71, 1348, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (72, 1329, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (73, 1364, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (74, 1321, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (75, 1329, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (76, 1331, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (77, 1383, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (78, 1351, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (79, 1360, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (80, 1336, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (81, 1324, 3);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (82, 1301, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (83, 1318, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (84, 1392, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (85, 1343, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (86, 1313, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (87, 1375, 2);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (88, 1330, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (89, 1345, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (90, 1300, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (91, 1310, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (92, 1324, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (93, 1357, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (94, 1398, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (95, 1349, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (96, 1395, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (97, 1387, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (98, 1309, 1);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (99, 1342, 4);
insert into EMPRESAS_MEDIOS_PAGO (ID, EMPRESA_ID, MEDIO_PAGO_ID ) values (100, 1330, 3);

-- CLIENTES EMPRESAS

insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (1, 21, 1336);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (2, 469, 1339);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (3, 106, 1331);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (4, 558, 1302);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (5, 106, 1373);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (6, 35, 1379);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (7, 45, 1358);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (8, 354, 1368);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (9, 510, 1302);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (10, 3, 1343);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (11, 195, 1327);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (12, 630, 1325);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (13, 499, 1349);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (14, 365, 1343);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (15, 622, 1368);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (16, 186, 1315);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (17, 82, 1304);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (18, 652, 1345);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (19, 387, 1305);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (20, 155, 1326);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (21, 590, 1386);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (22, 441, 1348);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (23, 361, 1337);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (24, 684, 1398);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (25, 307, 1385);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (26, 57, 1317);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (27, 252, 1318);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (28, 542, 1305);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (29, 369, 1385);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (30, 567, 1311);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (31, 117, 1386);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (32, 139, 1370);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (33, 681, 1334);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (34, 278, 1304);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (35, 255, 1352);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (36, 263, 1339);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (37, 151, 1329);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (38, 76, 1301);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (39, 351, 1384);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (40, 14, 1376);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (41, 698, 1327);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (42, 157, 1313);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (43, 64, 1382);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (44, 536, 1388);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (45, 459, 1389);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (46, 514, 1345);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (47, 70, 1311);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (48, 453, 1332);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (49, 420, 1315);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (50, 676, 1303);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (51, 600, 1393);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (52, 412, 1383);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (53, 18, 1391);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (54, 27, 1305);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (55, 315, 1329);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (56, 500, 1335);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (57, 398, 1364);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (58, 86, 1309);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (59, 468, 1377);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (60, 512, 1353);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (61, 72, 1348);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (62, 231, 1324);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (63, 211, 1304);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (64, 266, 1319);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (65, 427, 1349);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (66, 216, 1377);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (67, 17, 1313);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (68, 15, 1393);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (69, 159, 1362);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (70, 185, 1302);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (71, 254, 1311);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (72, 685, 1376);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (73, 116, 1349);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (74, 432, 1311);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (75, 46, 1391);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (76, 646, 1398);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (77, 363, 1392);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (78, 613, 1313);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (79, 31, 1305);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (80, 696, 1348);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (81, 570, 1315);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (82, 464, 1340);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (83, 507, 1334);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (84, 152, 1368);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (85, 377, 1354);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (86, 595, 1306);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (87, 158, 1349);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (88, 575, 1329);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (89, 263, 1308);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (90, 688, 1398);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (91, 324, 1395);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (92, 69, 1321);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (93, 16, 1388);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (94, 352, 1379);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (95, 549, 1331);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (96, 218, 1319);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (97, 304, 1304);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (98, 111, 1314);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (99, 162, 1326);
insert into CLIENTES_EMPRESAS (ID, CLIENTE_ID , EMPRESA_ID ) values (100, 122, 1382);

--FACTURAS

insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2519, '5/9/2018', '3824300141', 2007);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2532, '4/9/2018', '6774309038', 2058);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2540, '9/20/2018', '1249043077', 2010);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2578, '10/17/2017', '5251863373', 2017);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2561, '8/25/2018', '1244109401', 2085);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2511, '2/14/2018', '0341505676', 2090);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2565, '6/16/2018', '0394456777', 2009);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2588, '8/10/2018', '6884392444', 2066);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2567, '3/17/2018', '9849935286', 2006);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2540, '3/3/2018', '3369618362', 2078);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2521, '10/9/2017', '7920416930', 2016);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2527, '12/6/2017', '3639722868', 2031);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2553, '1/16/2018', '6609284075', 2090);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2567, '9/12/2018', '9959067688', 2021);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2522, '6/18/2018', '0545659434', 2067);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2553, '9/30/2017', '0141467002', 2074);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2561, '1/12/2018', '2056272962', 2028);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2593, '5/17/2018', '5104945472', 2087);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2549, '2/3/2018', '5843483258', 2079);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2564, '9/16/2018', '6074095884', 2030);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2587, '8/17/2018', '9023752651', 2007);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2582, '5/12/2018', '3646882867', 2003);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2581, '2/7/2018', '4735920528', 2060);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2509, '2/19/2018', '2414797584', 2070);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2555, '1/13/2018', '0975548662', 2064);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2505, '10/28/2017', '9781416556', 2041);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2522, '7/13/2018', '9574197115', 2060);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2600, '12/30/2017', '4506723953', 2023);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2557, '9/21/2018', '1192172086', 2025);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2584, '8/31/2018', '4241665608', 2093);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2543, '11/15/2017', '4892532665', 2058);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2523, '5/15/2018', '4444907363', 2089);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2518, '5/13/2018', '1807607666', 2034);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2600, '7/4/2018', '7536312547', 2083);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2594, '12/14/2017', '3690854687', 2011);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2551, '1/8/2018', '7027421240', 2090);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2580, '1/24/2018', '3162455766', 2039);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2578, '8/19/2018', '2011780829', 2010);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2591, '1/3/2018', '0568928490', 2041);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2587, '7/1/2018', '9181820488', 2051);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2525, '9/23/2018', '4460363976', 2018);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2600, '8/8/2018', '4174339805', 2038);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2583, '10/23/2017', '1469817918', 2041);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2512, '3/27/2018', '2841713210', 2008);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2548, '1/1/2018', '0402843789', 2077);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2577, '9/12/2018', '5066159592', 2087);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2516, '3/31/2018', '1147995362', 2082);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2542, '11/16/2017', '0226379450', 2036);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2531, '6/9/2018', '4044630712', 2004);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2511, '10/11/2017', '5415067167', 2033);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2589, '2/23/2018', '4647737012', 2070);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2514, '1/30/2018', '4914171023', 2038);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2593, '11/26/2017', '0444789731', 2085);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2573, '5/22/2018', '9878575764', 2064);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2555, '2/7/2018', '1660872839', 2004);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2587, '10/1/2017', '1948801280', 2056);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2562, '11/15/2017', '8195486711', 2069);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2553, '12/26/2017', '1540976955', 2039);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2548, '4/21/2018', '8060068199', 2011);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2537, '10/31/2017', '5238887337', 2010);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2566, '4/12/2018', '4909820345', 2065);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2512, '9/2/2018', '0971979103', 2076);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2584, '5/12/2018', '7656276106', 2088);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2592, '8/7/2018', '6738538928', 2025);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2597, '7/28/2018', '9997260767', 2012);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2553, '8/15/2018', '9999350429', 2015);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2539, '2/24/2018', '3598157851', 2023);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2589, '1/29/2018', '7460671487', 2012);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2585, '12/9/2017', '6175051653', 2019);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2548, '8/22/2018', '6776144303', 2062);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2513, '12/6/2017', '9904278385', 2027);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2501, '10/31/2017', '5775555988', 2003);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2558, '8/24/2018', '5248024366', 2093);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2599, '12/24/2017', '3819884912', 2061);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2544, '7/16/2018', '2187326411', 2052);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2549, '2/4/2018', '2403760412', 2001);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2531, '6/29/2018', '9192500900', 2019);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2508, '1/25/2018', '0916728803', 2011);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2513, '1/1/2018', '6269453704', 2004);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2536, '10/5/2017', '4200382997', 2012);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2573, '12/10/2017', '0018853544', 2045);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2525, '12/10/2017', '0563686138', 2037);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2515, '8/2/2018', '5198830402', 2081);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2552, '10/15/2017', '7508926587', 2073);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2516, '12/22/2017', '1545829667', 2094);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2532, '12/20/2017', '5260772881', 2000);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2596, '2/5/2018', '6536344545', 2047);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2545, '9/3/2018', '2362231216', 2040);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2563, '12/24/2017', '5492933019', 2068);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2598, '7/3/2018', '6612746467', 2019);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2529, '10/8/2017', '8892039962', 2075);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2572, '11/6/2017', '3170083325', 2024);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2598, '12/17/2017', '8878617806', 2096);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2512, '6/4/2018', '0489995675', 2075);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2589, '12/11/2017', '9501197492', 2037);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2541, '10/9/2017', '4360836058', 2042);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2586, '9/19/2018', '5148011416', 2080);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2589, '8/19/2018', '5336734497', 2081);
insert into FACTURAS (ID , FECHA , NUMERO , SERVICIO_ID ) values (2542, '6/1/2018', '0257565264', 2058);

--SERVICIOS

insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2016, '4/30/2018', '10:19 AM', 60, 20, '7 Manley Alley', '911 Grayhawk Pass', 9442.54, 'Cancelado', 'F', 3, 936, 1145, 61, 2209);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2058, '3/3/2018', '10:40 AM', 85, 49, '2782 Hoepker Circle', '90948 Esch Hill', 8360.03, 'Cancelado', 'F', 3, 878, 1170, 281, 2274);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2002, '10/20/2017', '7:47 AM', 63, 6, '3 Northland Trail', '5 Annamark Pass', 8168.46, 'Finalizado', 'F', 2, 868, 1297, 424, 2235);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2092, '12/11/2017', '6:24 PM', 85, 49, '82 Ridge Oak Pass', '6777 Elmside Junction', 5432.57, 'Finalizado', 'F', 4, 964, 1006, 443, 2216);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2034, '3/26/2018', '4:29 AM', 64, 43, '46204 South Avenue', '865 Loftsgordon Pass', 7188.42, 'Cancelado', 'V', 1, 822, 1246, 574, 2210);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2057, '10/27/2017', '6:01 AM', 50, 27, '6 Claremont Hill', '0485 Mitchell Road', 6951.26, 'Finalizado', 'F', 1, 821, 1272, 62, 2282);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2064, '8/29/2018', '10:50 PM', 10, 30, '57 Mesta Junction', '84757 Sutherland Junction', 9960.46, 'Finalizado', 'V', 4, 868, 1272, 465, 2262);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2042, '11/3/2017', '11:10 PM', 39, 39, '63080 Nobel Trail', '8961 Arapahoe Road', 6422.95, 'Cancelado', 'V', 2, 806, 1070, 43, 2208);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2085, '1/31/2018', '3:13 AM', 2, 47, '4681 Sunnyside Point', '6192 Manufacturers Center', 8860.97, 'Cancelado', 'V', 4, 815, 1125, 181, 2231);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2048, '5/4/2018', '12:48 PM', 55, 33, '13 Burning Wood Hill', '2440 Mariners Cove Road', 9719.77, 'Finalizado', 'F', 2, 829, 1165, 599, 2296);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2020, '12/14/2017', '3:48 PM', 67, 18, '6888 Cottonwood Avenue', '4 Lawn Terrace', 8939.62, 'Cancelado', 'V', 4, 936, 1292, 650, 2290);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2011, '2/17/2018', '11:30 AM', 7, 7, '26705 Fair Oaks Road', '67734 Shopko Road', 5742.35, 'Finalizado', 'V', 3, 872, 1191, 39, 2293);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2091, '6/7/2018', '10:08 PM', 41, 22, '375 Rigney Parkway', '87 Transport Court', 7532.02, 'Finalizado', 'F', 4, 861, 1040, 449, 2292);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2073, '11/14/2017', '7:50 PM', 33, 10, '7210 Bunker Hill Way', '2074 Meadow Valley Terrace', 9388.72, 'Cancelado', 'F', 4, 840, 1132, 111, 2224);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2048, '7/27/2018', '12:52 PM', 86, 32, '2707 Northport Court', '5903 Transport Point', 7505.65, 'Cancelado', 'F', 4, 864, 1020, 334, 2261);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2057, '6/26/2018', '1:17 PM', 96, 35, '95644 Pierstorff Avenue', '16011 Messerschmidt Way', 9828.01, 'Finalizado', 'V', 4, 835, 1026, 35, 2250);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2035, '12/27/2017', '6:24 PM', 36, 48, '34 Carberry Parkway', '289 Delaware Terrace', 6219.45, 'Cancelado', 'F', 2, 986, 1173, 382, 2217);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2036, '7/31/2018', '2:02 AM', 10, 55, '45522 Monterey Junction', '4170 Eastwood Alley', 6160.15, 'Finalizado', 'V', 3, 932, 1063, 164, 2292);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2024, '10/3/2017', '12:37 PM', 90, 20, '406 Jenifer Parkway', '05 Sunbrook Way', 7055.88, 'Cancelado', 'F', 2, 902, 1094, 2, 2265);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2013, '7/10/2018', '3:17 AM', 32, 18, '255 Miller Alley', '147 Gulseth Hill', 8113.2, 'Finalizado', 'V', 4, 942, 1007, 192, 2255);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2012, '11/22/2017', '1:49 PM', 99, 39, '75 Coolidge Alley', '0 Muir Crossing', 9460.42, 'Cancelado', 'V', 3, 978, 1251, 121, 2225);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2008, '8/5/2018', '7:47 AM', 75, 41, '505 Kedzie Parkway', '8680 Paget Road', 7311.69, 'Finalizado', 'V', 2, 878, 1171, 358, 2268);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2010, '4/24/2018', '9:01 AM', 50, 47, '5630 Elka Trail', '4 Lakeland Terrace', 5467.43, 'Finalizado', 'F', 4, 992, 1226, 96, 2272);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2060, '4/17/2018', '2:20 PM', 7, 48, '740 Schiller Place', '3298 Huxley Point', 5592.46, 'Finalizado', 'V', 2, 808, 1087, 551, 2224);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2091, '4/1/2018', '2:05 AM', 97, 13, '240 Dakota Pass', '36039 Dexter Trail', 5429.87, 'Finalizado', 'V', 3, 944, 1211, 524, 2206);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2090, '12/20/2017', '8:54 PM', 36, 17, '137 Russell Center', '10519 Parkside Parkway', 8213.34, 'Cancelado', 'F', 1, 966, 1161, 667, 2229);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2044, '7/9/2018', '5:41 PM', 79, 43, '25 Hanson Court', '0 Farwell Parkway', 7669.53, 'Finalizado', 'V', 2, 872, 1115, 420, 2296);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2033, '8/9/2018', '8:45 PM', 30, 15, '949 Menomonie Road', '73 Tomscot Crossing', 9128.51, 'Finalizado', 'V', 4, 916, 1247, 437, 2213);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2080, '2/25/2018', '8:41 PM', 55, 42, '050 Crowley Crossing', '0 Dixon Alley', 5535.14, 'Cancelado', 'F', 1, 989, 1187, 400, 2202);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2018, '9/14/2018', '2:01 PM', 99, 29, '90398 Corry Hill', '62419 Daystar Place', 6228.53, 'Cancelado', 'F', 2, 989, 1121, 246, 2272);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2059, '4/1/2018', '10:29 PM', 38, 37, '57799 Farwell Pass', '78 Comanche Center', 7823.64, 'Finalizado', 'V', 4, 936, 1056, 592, 2265);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2087, '10/2/2017', '8:47 AM', 61, 31, '24331 Tennessee Junction', '7 Rigney Crossing', 9851.27, 'Cancelado', 'F', 4, 867, 1197, 495, 2207);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2082, '5/2/2018', '11:08 AM', 52, 17, '7 Stuart Circle', '63 Lindbergh Place', 6243.75, 'Finalizado', 'F', 2, 904, 1163, 632, 2217);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2036, '1/9/2018', '4:56 PM', 63, 1, '26 Hermina Alley', '35950 Forster Park', 5405.94, 'Finalizado', 'F', 4, 943, 1255, 97, 2219);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2002, '11/8/2017', '1:55 PM', 60, 15, '08740 Dexter Road', '96 Elka Lane', 7895.13, 'Cancelado', 'V', 4, 802, 1238, 113, 2260);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2071, '6/11/2018', '4:16 AM', 98, 54, '59571 Vera Road', '7 Crownhardt Lane', 6769.01, 'Finalizado', 'F', 3, 990, 1003, 546, 2288);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2050, '4/29/2018', '2:01 PM', 100, 31, '9 Luster Center', '2929 Miller Terrace', 7707.03, 'Finalizado', 'F', 1, 915, 1016, 573, 2208);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2018, '4/18/2018', '3:59 AM', 7, 4, '20159 Debs Junction', '72999 Laurel Plaza', 5018.61, 'Cancelado', 'F', 3, 886, 1216, 71, 2214);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2070, '2/24/2018', '3:41 AM', 92, 51, '31 New Castle Hill', '23 Eggendart Hill', 7297.43, 'Finalizado', 'F', 2, 957, 1244, 166, 2245);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2086, '1/5/2018', '11:12 AM', 19, 50, '34 Annamark Way', '55079 Straubel Parkway', 8417.58, 'Finalizado', 'F', 2, 889, 1176, 631, 2247);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2006, '6/4/2018', '11:44 AM', 69, 24, '756 Oriole Road', '88280 Badeau Terrace', 5504.79, 'Finalizado', 'F', 1, 982, 1088, 485, 2233);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2014, '11/19/2017', '2:04 PM', 81, 49, '9 Shelley Junction', '16 Pennsylvania Avenue', 9133.21, 'Finalizado', 'F', 4, 933, 1222, 139, 2201);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2082, '11/26/2017', '12:53 AM', 79, 20, '21458 Bunting Road', '7141 Gateway Alley', 7563.25, 'Cancelado', 'F', 2, 861, 1063, 116, 2239);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2090, '4/11/2018', '12:31 PM', 83, 10, '3887 Sherman Court', '04 Chive Parkway', 9378.41, 'Finalizado', 'F', 2, 935, 1105, 173, 2293);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2026, '10/27/2017', '12:59 PM', 50, 43, '67883 Mallard Trail', '4 Walton Park', 6704.93, 'Cancelado', 'V', 4, 970, 1239, 107, 2257);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2031, '10/2/2017', '3:19 AM', 92, 33, '2 Buhler Place', '9620 Spohn Park', 6030.99, 'Finalizado', 'F', 1, 815, 1014, 665, 2255);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2032, '4/20/2018', '2:16 PM', 43, 45, '66087 Oneill Crossing', '6108 Jay Hill', 5376.31, 'Finalizado', 'V', 4, 901, 1215, 298, 2214);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2066, '6/4/2018', '5:55 AM', 68, 18, '570 Thackeray Way', '043 Marcy Drive', 8270.57, 'Finalizado', 'F', 4, 891, 1207, 267, 2256);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2071, '11/30/2017', '5:50 AM', 95, 53, '50 Del Sol Crossing', '3 Dakota Place', 6600.06, 'Cancelado', 'V', 1, 872, 1168, 375, 2284);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2051, '2/26/2018', '10:49 PM', 12, 10, '232 Graedel Place', '386 Maryland Drive', 8990.82, 'Cancelado', 'F', 3, 869, 1289, 673, 2214);
insert into SERVICIOS (ID, FECHA , HORA , DISTANCIA , TIEMPO_REQUERIDO , DIRECCION_ORIGEN , DIRECCION_DESTINO , TARIFA , ESTADO , TARIFA_DINAMICA , MEDIO_PAGO_ID , CONDUCTOR_ID , VEHICULO_ID , CLIENTE_ID , SERVICIO_COMPARTIDO_CLIENTE_ID) values (2074, '7/10/2018', '3:55 AM', 37, 25, '44 Nevada Hill', '68 Tomscot Junction', 7286.83, 'Finalizado', 'V', 2, 867, 1014, 391, 2228);

--DETALLES UBICACION SERVICIOS

insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (1, 26.6674, 113.449709, 2076);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (2, 23.1497287, 113.3227193, 2057);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (3, -7.1508118, 111.9075351, 2006);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (4, -32.9809545, -58.0470008, 2089);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (5, -12.2001475, 44.4665485, 2060);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (6, 32.364918, 111.594957, 2036);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (7, 40.7345053, -111.8628205, 2033);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (8, 29.5580077, 106.5765328, 2078);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (9, 34.2872962, 133.9508311, 2029);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (10, '49.4992', '-98.00156', 2038);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (11, 7.6292088, 4.1872178, 2019);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (12, 30.67705, 120.618585, 2081);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (13, '7.45', '-11.9', 2001);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (14, 14.2038203, 121.1457666, 2082);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (15, 53.7636896, 18.1983893, 2024);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (16, -16.4443537, -39.0653656, 2006);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (17, 34.158997, 108.906994, 2068);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (18, 24.504737, 115.091672, 2014);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (19, 13.8156076, 102.6675575, 2026);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (20, 35.72154, 111.350842, 2010);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (21, 53.00942, 17.73989, 2011);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (22, 47.2550409, -1.5401497, 2097);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (23, 52.4709411, 4.826445, 2087);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (24, 47.02018, -68.1434996, 2016);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (25, 39.3404866, -9.2987056, 2060);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (26, 50.5429237, 3.086469, 2034);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (27, 33.8779889, 132.2526506, 2087);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (28, 35.2866986, 36.7415432, 2036);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (29, 5.199505, -74.886835, 2024);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (30, 10.4373128, 121.9944005, 2058);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (31, -11.5741352, -77.2663771, 2063);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (32, 32.5958283, -6.2694608, 2056);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (33, -26.2886266, 27.8454627, 2008);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (34, 14.7292113, -88.0338631, 2057);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (35, 39.4665574, -31.1474124, 2030);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (36, 35.7914051, 140.2792041, 2057);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (37, 13.2326269, -61.265623, 2048);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (38, 40.644621, 122.509131, 2097);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (39, 40.784068, 122.1039229, 2057);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (40, 48.1288628, 11.5089621, 2072);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (41, 21.8480091, -78.1165309, 2087);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (42, 38.5597722, 68.7870384, 2000);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (43, -8.7287229, 117.666952, 2017);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (44, 43.486492, 16.5996595, 2069);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (45, -6.8866676, 109.5389573, 2060);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (46, 41.2080707, -8.1650422, 2094);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (47, 39.816173, 77.37263, 2079);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (48, 56.9568013, 97.7357959, 2057);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (49, 43.0429124, 1.9038837, 2098);
insert into DETALLES_UBICACION_SERVICIOS (ID , LATITUD, LONGITUD, SERVICIO_ID ) values (50, 11.2666664, 122.5333328, 2048);


--DETALLES FACTURAS

insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5001, 0.19, 0.34, 3141.52, 6756.35, 14559.73, 10544.7, 22267, 32892, 2513);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5002, 0.19, 0.34, 2048.88, 5015.73, 1072.08, 9221.22, 15240, 25928, 2514);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5003, 0.19, 0.34, 3433.12, 6271.16, 10651.84, 9290.33, 16652, 32141, 2515);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5004, 0.19, 0.34, 3117.97, 7434.98, 1651.99, 12386.19, 22703, 34013, 2516);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5005, 0.19, 0.34, 3311.81, 5543.67, 8122.12, 9584.23, 21434, 31142, 2517);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5006, 0.19, 0.34, 3205.99, 6966.77, 16578.2, 12992.35, 15938, 39114, 2518);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5007, 0.19, 0.34, 4111.72, 6085.36, 5487.0, 13074.84, 17906, 35575, 2519);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5008, 0.19, 0.34, 1507.4, 6162.03, 8110.88, 11303.45, 22694, 26872, 2520);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5009, 0.19, 0.34, 3304.62, 7311.15, 13163.37, 12229.53, 24819, 38693, 2521);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5010, 0.19, 0.34, 2138.2, 5749.0, 2152.49, 10500.84, 15405, 29066, 2522);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5011, 0.19, 0.34, 2098.94, 7353.86, 17857.85, 9271.84, 20099, 18487, 2523);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5012, 0.19, 0.34, 2946.21, 6492.82, 6204.41, 11047.94, 16307, 21885, 2524);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5013, 0.19, 0.34, 2115.22, 7306.74, 14619.33, 13257.02, 19695, 21015, 2525);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5014, 0.19, 0.34, 2677.79, 7592.48, 4804.71, 9170.28, 20332, 35179, 2526);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5015, 0.19, 0.34, 4499.54, 7133.44, 19939.2, 11231.03, 24984, 26374, 2527);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5016, 0.19, 0.34, 1913.05, 6396.88, 3306.07, 12242.78, 22061, 18884, 2528);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5017, 0.19, 0.34, 4446.34, 7077.97, 13185.44, 13652.64, 18487, 32385, 2529);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5018, 0.19, 0.34, 3124.18, 6139.7, 1971.09, 10554.15, 24821, 38682, 2530);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5019, 0.19, 0.34, 2665.5, 7856.24, 15505.32, 10766.48, 15085, 27962, 2531);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5020, 0.19, 0.34, 2072.49, 7905.54, 11636.51, 11398.91, 15560, 27824, 2532);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5021, 0.19, 0.34, 1077.45, 7225.91, 18474.85, 10808.73, 16686, 26081, 2533);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5022, 0.19, 0.34, 4680.16, 5370.28, 9292.46, 10271.31, 16390, 33197, 2534);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5023, 0.19, 0.34, 2261.0, 6875.64, 3611.28, 13884.39, 23194, 20882, 2535);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5024, 0.19, 0.34, 3741.04, 7934.51, 19061.92, 9432.35, 20073, 38414, 2536);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5025, 0.19, 0.34, 2565.58, 6600.73, 11621.15, 9944.12, 20988, 15601, 2537);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5026, 0.19, 0.34, 2828.58, 6005.86, 19315.1, 10302.33, 19551, 40429, 2538);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5027, 0.19, 0.34, 1637.81, 6165.52, 9006.11, 12057.64, 16018, 36499, 2539);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5028, 0.19, 0.34, 4465.43, 7898.8, 11296.54, 12223.45, 20991, 35135, 2540);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5029, 0.19, 0.34, 1772.96, 6378.01, 10204.26, 12935.37, 19387, 30312, 2541);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5030, 0.19, 0.34, 4468.84, 7742.44, 12164.79, 10696.3, 23901, 43834, 2542);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5031, 0.19, 0.34, 3544.24, 5658.76, 16203.85, 13786.89, 16378, 22194, 2543);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5032, 0.19, 0.34, 1351.14, 5070.14, 16914.13, 9343.79, 24621, 16071, 2544);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5033, 0.19, 0.34, 1661.78, 5083.4, 5663.14, 13468.85, 16925, 25060, 2545);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5034, 0.19, 0.34, 4689.49, 6696.12, 3526.95, 13179.35, 21341, 19487, 2546);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5035, 0.19, 0.34, 4795.95, 6127.12, 19946.54, 10827.7, 22868, 29108, 2547);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5036, 0.19, 0.34, 4108.44, 6326.58, 5103.58, 13087.63, 15948, 18072, 2548);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5037, 0.19, 0.34, 1330.3, 5594.01, 1066.47, 13546.14, 23737, 43223, 2549);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5038, 0.19, 0.34, 3242.19, 7046.13, 14170.45, 11831.23, 16947, 42624, 2550);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5039, 0.19, 0.34, 4491.03, 7926.78, 1203.94, 9973.57, 20181, 41993, 2551);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5040, 0.19, 0.34, 2808.08, 7602.25, 14539.52, 10470.34, 22692, 16157, 2552);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5041, 0.19, 0.34, 3888.01, 7636.71, 13939.52, 11960.88, 19730, 40989, 2553);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5042, 0.19, 0.34, 3630.64, 6639.99, 16947.71, 11775.34, 20378, 40042, 2554);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5043, 0.19, 0.34, 1072.35, 7489.03, 13312.59, 12215.27, 16845, 16462, 2555);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5044, 0.19, 0.34, 3389.35, 5418.08, 12904.97, 12165.2, 21104, 22630, 2556);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5045, 0.19, 0.34, 1548.44, 7009.25, 14801.26, 13857.75, 15428, 37106, 2557);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5046, 0.19, 0.34, 3657.6, 6980.97, 12145.0, 9140.18, 22791, 27187, 2558);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5047, 0.19, 0.34, 3895.04, 7295.43, 13378.51, 12936.66, 21038, 37766, 2559);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5048, 0.19, 0.34, 2316.94, 7177.35, 9487.0, 12259.69, 20767, 32841, 2560);
insert into DETALLES_FACTURAS (ID, IVA, COMISION_UBER, PROPINAS, HONORARIOS, REGARGOS, PEAJES, SUB_TOTAL, TOTAL, FACTURA_ID) values (5049, 0.19, 0.34, 1019.44, 6038.76, 9074.36, 12263.47, 17753, 23591, 2561);
