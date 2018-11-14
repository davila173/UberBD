--6 CREACION DE TABLAS

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
    TIPO NVARCHAR2(256) NOT NULL CHECK(TIPO IN ('PAYPAL','TARJETA DE CREDITO','ANDROID','CUENTA DE AHORROS','TARJETA DEBITO')),
    DESCRIPCION VARCHAR2(255) NULL,
    CLIENTE_ID INTEGER NOT NULL
);

CREATE TABLE SERVICIOS
(
    ID INTEGER PRIMARY KEY NOT NULL,
    FECHA VARCHAR2(255) NULL,
    HORA TIMESTAMP NOT NULL,
    DISTANCIA DECIMAL (*,2) NULL,
    TIEMPO_REQUERIDO INTEGER NULL,
    DIRECCION_ORIGEN VARCHAR2(255) NULL,
    DIRECCION_DESTINO VARCHAR2(255) NULL,
    ESTADO VARCHAR2 (255) NULL CHECK(ESTADO IN ('REALIZADO','EN CURSO', 'SUSPEDIDO', 'CANCELADO')),
    TARIFA_DINAMICA VARCHAR2(1) CHECK ((TARIFA_DINAMICA = 'V') OR (TARIFA_DINAMICA = 'F')),
    CONDUCTORES_VEHICULOS_ID INTEGER NOT NULL,
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
    FECHA VARCHAR2(255) NULL,
    NUMERO INTEGER,
    VALOR DECIMAL (*,2),
    SERVICIO_ID INTEGER NOT NULL,
    MEDIO_PAGO_ID INTEGER NOT NULL
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
    VALOR_KILOMETRO NUMBER NOT NULL,
    VALOR_POR_MINUTO NUMBER NOT NULL,
    TARIFA_BASE NUMBER NOT NULL,
    CODIGO_POSTAL VARCHAR2(255) NULL,
    PAIS_ID INTEGER NOT NULL
 );
 
 CREATE TABLE EMAILS
 (
    ID INTEGER PRIMARY KEY NOT NULL,
    CLIENTE_ID INTEGER NOT NULL,
    EMAIL VARCHAR2(256) NOT NULL
 );
 
 CREATE TABLE ENVIO_RECIBOS
 (
    ID INTEGER PRIMARY KEY NOT NULL,
    EMAIL_ID INTEGER NOT NULL,
    MEDIO_PAGO_ID INTEGER NOT NULL
 );
 
 CREATE TABLE CODIGOS_PROMOCIONALES 
 (
    ID INTEGER PRIMARY KEY NOT NULL,
    CODIGO VARCHAR2(255) NULL,
    VALOR DECIMAL(*,2),
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
    IDIOMA_ID INTEGER NOT NULL,
    CIUDAD_ID INTEGER NOT NULL
);

CREATE TABLE PAGOS_CONDUCTORES
(
    ID INTEGER PRIMARY KEY NOT NULL,
    VALOR DECIMAL(*,2) NOT NULL,
    FECHA_CORTE_INICIAL TIMESTAMP,
    FECHA_CORTE_FINAL TIMESTAMP,
    OBSERVACIONES NVARCHAR2(256),
    NUMERO_CUENTA VARCHAR2(255) NOT NULL,
    MEDIO_PAGO_ID INTEGER NOT NULL,
    CONDUCTOR_ID INTEGER NOT NULL
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
    CONCEPTO NVARCHAR2(256),
    VALOR DECIMAL (*,2),
    FACTURA_ID INTEGER NOT NULL
);
 

--SE CREA LA SCUENCIA PARA DAR CONTROL A LA NUMERACION DE LA FACTURACION
    CREATE SEQUENCE AGENCIES_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;
	
	
	------ INSERCION DE INFORMACION ------ 

SET DEFINE OFF
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (1, 'Tomi', 'Churchyard', 'https://robohash.org/ullamdictamaiores.jpg?size=50x50&set=set1', 'tchurchyard0@hubpages.com', '970-570-1182', 'tchurchyard0', 'Ig91o8f3G', 'tfm8WypjThJ', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (2, 'Randi', 'Gouldeby', 'https://robohash.org/quidemquiaeligendi.png?size=50x50&set=set1', 'rgouldeby1@china.com.cn', '369-971-9913', 'rgouldeby1', 'uPmwjFRFl3', '8OTfjyPcrI4o', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (3, 'Ruperta', 'Risby', 'https://robohash.org/necessitatibusetut.bmp?size=50x50&set=set1', 'rrisby2@icio.us', '603-779-2469', 'rrisby2', 'Y7eSiqH9hX', 'hXNksQpMY', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (4, 'Olvan', 'McIlroy', 'https://robohash.org/ullamveritatisconsequatur.jpg?size=50x50&set=set1', 'omcilroy3@rambler.ru', '755-835-1660', 'omcilroy3', 'LQPR2Al', 'D25JNSM', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (5, 'Averell', 'Poon', 'https://robohash.org/sedhicvoluptas.jpg?size=50x50&set=set1', 'apoon4@usnews.com', '652-332-0870', 'apoon4', 'Nt2h9D5', 'rv3I6xgIk', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (6, 'Meaghan', 'Bohje', 'https://robohash.org/aspernaturdolorvoluptas.jpg?size=50x50&set=set1', 'mbohje5@toplist.cz', '180-379-9610', 'mbohje5', 'N3aKIIXx', '8j6qmuD', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (7, 'Lanae', 'LAbbet', 'https://robohash.org/undeeumaspernatur.jpg?size=50x50&set=set1', 'llabbet6@mediafire.com', '833-276-2680', 'llabbet6', 'XI5zgImZA0sZ', 'atLXUAJrNUJe', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (8, 'Johna', 'Rembrant', 'https://robohash.org/quisharumet.png?size=50x50&set=set1', 'jrembrant7@ovh.net', '948-230-5670', 'jrembrant7', '0rBTUDMgieR9', 'iTRDbNcZt', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (9, 'Nanette', 'Emtage', 'https://robohash.org/quisvoluptatemvoluptate.jpg?size=50x50&set=set1', 'nemtage8@usatoday.com', '701-758-9209', 'nemtage8', 'meLh0ydjNI', 'f6EQIEA3c7b', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (10, 'Georgy', 'Bonallick', 'https://robohash.org/illumvoluptateseligendi.bmp?size=50x50&set=set1', 'gbonallick9@mayoclinic.com', '609-774-9679', 'gbonallick9', 'qDMSesUo', 'Iid8mjmql', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (11, 'Kerrin', 'Brothwell', 'https://robohash.org/voluptatemcorruptiqui.bmp?size=50x50&set=set1', 'kbrothwella@moonfruit.com', '896-447-6542', 'kbrothwella', 'iA9apaPzOTTS', '9mMMS5FI6', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (12, 'Ramsey', 'Filimore', 'https://robohash.org/uteiusrepellendus.bmp?size=50x50&set=set1', 'rfilimoreb@prweb.com', '111-289-4179', 'rfilimoreb', 'ulFre1PYm', 'qg5DP0KFd', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (13, 'Anatole', 'Duligall', 'https://robohash.org/beataeiustoullam.jpg?size=50x50&set=set1', 'aduligallc@xing.com', '488-477-8310', 'aduligallc', 'J67zcN', 'uf8uxy', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (14, 'Pollyanna', 'Acreman', 'https://robohash.org/autfacereodio.jpg?size=50x50&set=set1', 'pacremand@kickstarter.com', '147-984-2123', 'pacremand', 'RQ6DvG', 'KZnWnwl', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (15, 'Belinda', 'Sanham', 'https://robohash.org/reprehenderitquibeatae.jpg?size=50x50&set=set1', 'bsanhame@mayoclinic.com', '398-205-1426', 'bsanhame', 'PsI59Jm4CPk', 'faqAFO', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (16, 'Sharla', 'Cosley', 'https://robohash.org/voluptatemsolutasuscipit.jpg?size=50x50&set=set1', 'scosleyf@bravesites.com', '368-107-7904', 'scosleyf', '20FLpLTxfYgY', '4jMYhg', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (17, 'Neil', 'Mathew', 'https://robohash.org/eosundemollitia.png?size=50x50&set=set1', 'nmathewg@hibu.com', '253-510-5270', 'nmathewg', 'a4xppW0', '03TS4353w', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (18, 'Fanni', 'Sturgess', 'https://robohash.org/doloremqueexcepturivelit.bmp?size=50x50&set=set1', 'fsturgessh@unesco.org', '921-486-0958', 'fsturgessh', 'ALE1cDoNMmV', 'x1MKxq', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (19, 'Marijo', 'Drever', 'https://robohash.org/aliquamlaborenon.bmp?size=50x50&set=set1', 'mdreveri@phoca.cz', '873-803-3780', 'mdreveri', 'KE0fWL9hig', '9txEJHj', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (20, 'Constantia', 'Ecclestone', 'https://robohash.org/sitidaccusantium.jpg?size=50x50&set=set1', 'cecclestonej@cdbaby.com', '352-709-5200', 'cecclestonej', 'iOpffj8bHK', 'cGGxqxLSns', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (21, 'Zerk', 'Aleksandrev', 'https://robohash.org/cumqueutblanditiis.bmp?size=50x50&set=set1', 'zaleksandrevk@photobucket.com', '672-299-9251', 'zaleksandrevk', 'OLlGih', 'TyXePW', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (22, 'Zonda', 'Girardin', 'https://robohash.org/iddolorex.png?size=50x50&set=set1', 'zgirardinl@rambler.ru', '206-218-8768', 'zgirardinl', 'CLOrIXSVR', 'zNlML4', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (23, 'Kerianne', 'Behneke', 'https://robohash.org/ullamexnon.png?size=50x50&set=set1', 'kbehnekem@myspace.com', '536-871-4670', 'kbehnekem', 'saGFNfs', 'LkfUpJ', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (24, 'Karon', 'Adam', 'https://robohash.org/ametquasideleniti.png?size=50x50&set=set1', 'kadamn@cloudflare.com', '317-243-2932', 'kadamn', 'OKEJQJBbf5y', 'PIyVO9AarF', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (25, 'Mitchael', 'Boughton', 'https://robohash.org/rerumeadolor.jpg?size=50x50&set=set1', 'mboughtono@vk.com', '894-783-3102', 'mboughtono', '6KQmjFCUY', '574z8XE0H', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (26, 'Peggy', 'Wildsmith', 'https://robohash.org/doloresquamvoluptatem.jpg?size=50x50&set=set1', 'pwildsmithp@hatena.ne.jp', '883-361-6046', 'pwildsmithp', 'mPk5jLjWJpB', 'XpReAhYiix', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (27, 'Carlie', 'Longlands', 'https://robohash.org/voluptasarchitectoexplicabo.png?size=50x50&set=set1', 'clonglandsq@google.de', '709-499-3804', 'clonglandsq', 'gB5lklS07X', '7RaSi3GyiB', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (28, 'Jillene', 'Celloni', 'https://robohash.org/quiquiest.bmp?size=50x50&set=set1', 'jcellonir@live.com', '114-650-8935', 'jcellonir', 'QtIva0wHe', 'lemctAgrMCLS', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (29, 'Ailee', 'Cowmeadow', 'https://robohash.org/repellendusteneturconsequatur.png?size=50x50&set=set1', 'acowmeadows@bloglovin.com', '295-996-1258', 'acowmeadows', 'B5V7LnC', 'g9sELbqmUs', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (30, 'Nevile', 'Padfield', 'https://robohash.org/liberodebitisautem.png?size=50x50&set=set1', 'npadfieldt@amazon.co.jp', '254-306-9257', 'npadfieldt', 'D6BzS19X', 'HAIBGh4gabTX', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (31, 'Mackenzie', 'Walsh', 'https://robohash.org/quaeratsintut.png?size=50x50&set=set1', 'mwalshu@yolasite.com', '480-745-8061', 'mwalshu', '0YFYRm5ob76', 'D4Uy05bqzed', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (32, 'Elden', 'Chominski', 'https://robohash.org/quietet.bmp?size=50x50&set=set1', 'echominskiv@github.com', '455-917-9900', 'echominskiv', 'r91hxfU', 'qGzbSTBHJi', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (33, 'Joshua', 'Culpen', 'https://robohash.org/quiatotamut.jpg?size=50x50&set=set1', 'jculpenw@imgur.com', '281-958-7469', 'jculpenw', 'fKAIA36Xyb', 'hTkvV45Sz', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (34, 'Maddalena', 'Macknish', 'https://robohash.org/itaqueremplaceat.bmp?size=50x50&set=set1', 'mmacknishx@bloglovin.com', '546-361-4974', 'mmacknishx', 'I2WaykAYfr', 'xuYSjvo8blk', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (35, 'Ernst', 'Di Ruggiero', 'https://robohash.org/nullaquisvoluptatem.jpg?size=50x50&set=set1', 'ediruggieroy@aboutads.info', '572-494-6366', 'ediruggieroy', 'jRzQMEi', 'oIb4SuBH8y', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (36, 'Gretta', 'Legan', 'https://robohash.org/autullamneque.jpg?size=50x50&set=set1', 'gleganz@go.com', '746-122-2232', 'gleganz', 'xIsY9got', '9Al4A7', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (37, 'Jedd', 'Hallex', 'https://robohash.org/ipsaeaqueautem.png?size=50x50&set=set1', 'jhallex10@wiley.com', '190-913-5501', 'jhallex10', 'scP1SJ', 'pLcnVmDTTV2', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (38, 'Roscoe', 'Gerardet', 'https://robohash.org/corruptidelenitinihil.jpg?size=50x50&set=set1', 'rgerardet11@virginia.edu', '647-243-0908', 'rgerardet11', 'e8qskCD', '5VXyre1', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (39, 'Cherey', 'Phipp', 'https://robohash.org/fugitquidemet.jpg?size=50x50&set=set1', 'cphipp12@wix.com', '484-524-0505', 'cphipp12', 'lNtxNfi', '0Yx8qkmD', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (40, 'Hillard', 'Haking', 'https://robohash.org/omnisvoluptateneque.png?size=50x50&set=set1', 'hhaking13@icq.com', '348-462-9729', 'hhaking13', 'pyR9G46Mm', '2GUF1L5l3q', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (41, 'Hewie', 'Gouly', 'https://robohash.org/utliberoearum.jpg?size=50x50&set=set1', 'hgouly14@reference.com', '432-868-5510', 'hgouly14', '0p34apz20Zwk', 'hLlfQ2ZKU', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (42, 'Lemar', 'Barbary', 'https://robohash.org/rerumfacilisbeatae.png?size=50x50&set=set1', 'lbarbary15@odnoklassniki.ru', '911-718-6411', 'lbarbary15', 'BWxAjnb9Xr8', '98eRL0', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (43, 'Ronny', 'Barbrook', 'https://robohash.org/aliasaspernaturiure.jpg?size=50x50&set=set1', 'rbarbrook16@free.fr', '368-261-5070', 'rbarbrook16', 'BjxrP9', 'TjlNSD4', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (44, 'Esta', 'Smullen', 'https://robohash.org/etipsamsit.bmp?size=50x50&set=set1', 'esmullen17@businesswire.com', '636-625-8970', 'esmullen17', 'YTxAnq', 'tkeBH6pKM', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (45, 'Jilleen', 'Millbank', 'https://robohash.org/voluptatemdoloresdeserunt.jpg?size=50x50&set=set1', 'jmillbank18@latimes.com', '120-260-7977', 'jmillbank18', 'oMPqnoVkwrI', 'UDQIybtpyVrD', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (46, 'Renie', 'Guierre', 'https://robohash.org/eosautest.bmp?size=50x50&set=set1', 'rguierre19@oaic.gov.au', '844-514-0420', 'rguierre19', 'OrkCZQhv', 'aAtpsH7gPp', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (47, 'Damiano', 'Strickett', 'https://robohash.org/excepturiplaceatet.jpg?size=50x50&set=set1', 'dstrickett1a@uol.com.br', '586-863-6749', 'dstrickett1a', 'bFgs0VqCtKC', 'FVd368Iy4Yn', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (48, 'Debby', 'Gillbard', 'https://robohash.org/sintconsequunturnam.bmp?size=50x50&set=set1', 'dgillbard1b@geocities.jp', '317-514-2100', 'dgillbard1b', 'R9nCQRCZt', 'TtNab5bIXWPx', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (49, 'Francyne', 'Haughton', 'https://robohash.org/harumcorruptieum.jpg?size=50x50&set=set1', 'fhaughton1c@list-manage.com', '322-708-8322', 'fhaughton1c', 'KNWaunWpzF', 'T8aOkuHzyD', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (50, 'Gustave', 'Olifard', 'https://robohash.org/harumsuntet.bmp?size=50x50&set=set1', 'golifard1d@reverbnation.com', '349-899-6963', 'golifard1d', 'KVZgvb', 'IwAm0SgV1', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (51, 'Lola', 'Striker', 'https://robohash.org/deseruntvoluptatemiste.jpg?size=50x50&set=set1', 'lstriker1e@yale.edu', '818-940-0440', 'lstriker1e', 'woov7CPOcN3', '5DelXiqON4', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (52, 'Cristie', 'Bowhay', 'https://robohash.org/autemutquam.bmp?size=50x50&set=set1', 'cbowhay1f@weibo.com', '124-994-0083', 'cbowhay1f', 'tADHVim', 'Igc9S3Pv', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (53, 'Worthington', 'Showt', 'https://robohash.org/velitfacilisatque.bmp?size=50x50&set=set1', 'wshowt1g@spiegel.de', '479-992-1470', 'wshowt1g', 'BmwQHW', 'q3LHJc7', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (54, 'Brent', 'Douris', 'https://robohash.org/fugiatquianatus.bmp?size=50x50&set=set1', 'bdouris1h@nymag.com', '563-124-3263', 'bdouris1h', 'Io0UxM0Dw', 'ZZxCmb2k', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (55, 'Bonni', 'Loutheane', 'https://robohash.org/similiqueetquisquam.bmp?size=50x50&set=set1', 'bloutheane1i@jimdo.com', '721-359-6092', 'bloutheane1i', 'BtqXemDc3SU', '64fkEVe', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (56, 'Berkly', 'Sancias', 'https://robohash.org/cumquierror.jpg?size=50x50&set=set1', 'bsancias1j@mashable.com', '216-386-2519', 'bsancias1j', '7Ll00J', '0z4JW4', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (57, 'Jerrilyn', 'Wennam', 'https://robohash.org/quosvoluptatemcumque.png?size=50x50&set=set1', 'jwennam1k@squidoo.com', '706-739-4913', 'jwennam1k', 'Jrdhmtamy', 'HY06NidLji', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (58, 'Franchot', 'Pydcock', 'https://robohash.org/estarchitectoipsam.jpg?size=50x50&set=set1', 'fpydcock1l@nydailynews.com', '608-517-8886', 'fpydcock1l', 'sYARt8pUt', 'UjC6hQ', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (59, 'Siward', 'Fears', 'https://robohash.org/providentcupiditateodit.bmp?size=50x50&set=set1', 'sfears1m@amazon.co.jp', '209-580-6862', 'sfears1m', 'iufZcSCBk2', 'CIpOBfaNMbe', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (60, 'Sapphire', 'Colton', 'https://robohash.org/quaerataspernaturveniam.bmp?size=50x50&set=set1', 'scolton1n@yahoo.co.jp', '826-451-9750', 'scolton1n', 'XkdZosR0t', 'sEgYZ9OyTh', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (61, 'Lanny', 'Raisher', 'https://robohash.org/ducimusmolestiaeillum.bmp?size=50x50&set=set1', 'lraisher1o@wp.com', '934-226-6986', 'lraisher1o', 'ukGcGzKhvfs', '50HXHNSOgMCL', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (62, 'Hyacinthia', 'Scollan', 'https://robohash.org/doloreautemlaborum.bmp?size=50x50&set=set1', 'hscollan1p@geocities.jp', '263-898-7940', 'hscollan1p', 'izEnDcIt8UW', 'oiISxTqDBB7', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (63, 'Manolo', 'Yosevitz', 'https://robohash.org/idpariaturalias.bmp?size=50x50&set=set1', 'myosevitz1q@artisteer.com', '541-743-9006', 'myosevitz1q', 'IzeUfE4QLX', 'EreHMM7CxM', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (64, 'Lizzy', 'Brusle', 'https://robohash.org/commodietarchitecto.bmp?size=50x50&set=set1', 'lbrusle1r@usda.gov', '418-294-7526', 'lbrusle1r', 'MlfLAL3', 'x1hYq7rWf', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (65, 'Mabelle', 'Cheng', 'https://robohash.org/etautlabore.bmp?size=50x50&set=set1', 'mcheng1s@vinaora.com', '817-120-5435', 'mcheng1s', 'esPCOy0Q7', 'nuJSXJ5', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (66, 'Aland', 'Ebbrell', 'https://robohash.org/modiimpeditut.jpg?size=50x50&set=set1', 'aebbrell1t@constantcontact.com', '915-288-9109', 'aebbrell1t', 'yFstYsnTrK', 'dzRdRoLTv1o7', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (67, 'Tanya', 'McGillacoell', 'https://robohash.org/iureducimusratione.jpg?size=50x50&set=set1', 'tmcgillacoell1u@mail.ru', '305-753-5341', 'tmcgillacoell1u', '1qOENjFB1Ki', '8XOsmbYvInDi', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (68, 'Laural', 'Corke', 'https://robohash.org/nobisrerumharum.jpg?size=50x50&set=set1', 'lcorke1v@tinypic.com', '989-984-9541', 'lcorke1v', '7SrPH4o', 'tCx7B5', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (69, 'Jeniffer', 'Dmtrovic', 'https://robohash.org/placeatimpeditmaxime.jpg?size=50x50&set=set1', 'jdmtrovic1w@constantcontact.com', '127-326-7374', 'jdmtrovic1w', 'lYmjQR', 'Olb4Z2xx', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (70, 'Barbabas', 'Bretland', 'https://robohash.org/ipsamsintvitae.png?size=50x50&set=set1', 'bbretland1x@cbsnews.com', '923-625-9177', 'bbretland1x', 'MZKou2', 'lBzGT8pl', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (71, 'Zed', 'Ferrea', 'https://robohash.org/ipsumreiciendissed.jpg?size=50x50&set=set1', 'zferrea1y@yolasite.com', '863-802-5747', 'zferrea1y', 'k68JV9', 'ov2u8BNTCkK', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (72, 'Seumas', 'Yesinin', 'https://robohash.org/quireprehenderitrecusandae.jpg?size=50x50&set=set1', 'syesinin1z@freewebs.com', '634-197-0040', 'syesinin1z', 'yftk5vuL1', 'ZQTFHf', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (73, 'Mark', 'Peplay', 'https://robohash.org/accusantiumquidemomnis.bmp?size=50x50&set=set1', 'mpeplay20@phoca.cz', '328-731-8138', 'mpeplay20', 'DH8WBnrleYT', 'NBSWmBQuZcwT', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (74, 'Wolfie', 'Blabey', 'https://robohash.org/natusvitaeut.png?size=50x50&set=set1', 'wblabey21@cnn.com', '119-415-8372', 'wblabey21', 'YhXg8womcnbG', 'oj5HVdPBVmzy', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (75, 'Care', 'Scrivinor', 'https://robohash.org/voluptatesnullapraesentium.png?size=50x50&set=set1', 'cscrivinor22@imageshack.us', '899-209-2034', 'cscrivinor22', 'GCEuV5cvVrz', '9q0nD7gsG', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (76, 'Demetria', 'Songist', 'https://robohash.org/itaqueaccusamusmolestiae.jpg?size=50x50&set=set1', 'dsongist23@disqus.com', '888-133-5853', 'dsongist23', 'hLA1LAZ', 'b0OWkz', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (77, 'Mellicent', 'Moth', 'https://robohash.org/doloresaccusantiumet.png?size=50x50&set=set1', 'mmoth24@bbb.org', '969-540-7646', 'mmoth24', 'KMkRuLKb2Wy', 'ac3BcngIAIH', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (78, 'Helene', 'Ranger', 'https://robohash.org/repellendusquovoluptates.png?size=50x50&set=set1', 'hranger25@cisco.com', '878-551-1477', 'hranger25', 'Upt7eIgfhmDe', 'CvCiJ5p', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (79, 'Benny', 'Scopham', 'https://robohash.org/nobisquisquod.bmp?size=50x50&set=set1', 'bscopham26@timesonline.co.uk', '253-519-7159', 'bscopham26', 'XWNIhT', '2XiIUgBT6Hs', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (80, 'Carlynn', 'Bowkley', 'https://robohash.org/officiaidnon.png?size=50x50&set=set1', 'cbowkley27@shop-pro.jp', '439-172-9675', 'cbowkley27', 'QrQJ9bw', 'q0jyxBCcs', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (81, 'Terrel', 'Kobu', 'https://robohash.org/sedinlaborum.bmp?size=50x50&set=set1', 'tkobu28@google.com', '585-392-5345', 'tkobu28', 'Uw0sbryh', '5FMZq3J8sRsT', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (82, 'Valdemar', 'Yeeles', 'https://robohash.org/explicaboinea.png?size=50x50&set=set1', 'vyeeles29@nba.com', '192-151-8201', 'vyeeles29', 'oJebE1x', '5raTBhHvNDe6', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (83, 'Keene', 'Lukasik', 'https://robohash.org/eosautveniam.bmp?size=50x50&set=set1', 'klukasik2a@dropbox.com', '437-337-9255', 'klukasik2a', 'QegsLisObm', 'mPL1Jfj', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (84, 'Cristionna', 'Gherardini', 'https://robohash.org/aliquamquonon.jpg?size=50x50&set=set1', 'cgherardini2b@mtv.com', '992-666-9789', 'cgherardini2b', 'CLfsqKhpg', 'KSVYd0', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (85, 'Mattheus', 'Pycock', 'https://robohash.org/quiporromaxime.jpg?size=50x50&set=set1', 'mpycock2c@ox.ac.uk', '259-251-1766', 'mpycock2c', 'ZgbNIFj', 'odxy8txJ', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (86, 'Lenka', 'Lyver', 'https://robohash.org/quirepellatconsequatur.png?size=50x50&set=set1', 'llyver2d@wix.com', '565-741-4583', 'llyver2d', 'Z2CkOqoA', 'qMJaUBqKyy', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (87, 'Merwyn', 'Gronaller', 'https://robohash.org/providentquiaamet.bmp?size=50x50&set=set1', 'mgronaller2e@slideshare.net', '273-644-2359', 'mgronaller2e', 'HpSQzd', 'VQBa5oW5E', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (88, 'Corrina', 'Wile', 'https://robohash.org/eiusdictaillo.png?size=50x50&set=set1', 'cwile2f@senate.gov', '801-342-7945', 'cwile2f', 'b1KcH7jcDRW', 'ri8bLwbxyD', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (89, 'Anetta', 'Drabble', 'https://robohash.org/repudiandaevelitminus.png?size=50x50&set=set1', 'adrabble2g@msn.com', '136-373-9259', 'adrabble2g', '9UiL8eoqrBZ', 't6b08d', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (90, 'Flor', 'Belcher', 'https://robohash.org/eumestmolestias.bmp?size=50x50&set=set1', 'fbelcher2h@people.com.cn', '706-933-4831', 'fbelcher2h', 'eubK8t', 'ySmt3P', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (91, 'Kimmi', 'Baudinot', 'https://robohash.org/utperferendissapiente.png?size=50x50&set=set1', 'kbaudinot2i@odnoklassniki.ru', '847-522-4738', 'kbaudinot2i', 'PgD6Hym4a', '6CflyLHBq2', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (92, 'Bernelle', 'Slafford', 'https://robohash.org/nonillocupiditate.jpg?size=50x50&set=set1', 'bslafford2j@geocities.jp', '925-288-0464', 'bslafford2j', '7XLvB5XYZ8', 'OioRfFB', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (93, 'Hobey', 'Bowland', 'https://robohash.org/autemminusenim.png?size=50x50&set=set1', 'hbowland2k@mayoclinic.com', '568-937-7428', 'hbowland2k', 'JIsBAE', 'GhCKd2dzJ', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (94, 'Ferdinanda', 'Babbs', 'https://robohash.org/laboriosamitaqueillo.jpg?size=50x50&set=set1', 'fbabbs2l@quantcast.com', '920-602-1160', 'fbabbs2l', 'bPBPsrXhg', 'IWhj0LP', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (95, 'Cathleen', 'Fusedale', 'https://robohash.org/sitautet.jpg?size=50x50&set=set1', 'cfusedale2m@google.co.uk', '713-578-1108', 'cfusedale2m', 'aNZ11qCP', 'CEw2sgPe', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (96, 'Krystalle', 'Verity', 'https://robohash.org/praesentiumetneque.png?size=50x50&set=set1', 'kverity2n@intel.com', '891-194-8944', 'kverity2n', 'gZghCnUrVbHI', 'WGjFw9', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (97, 'Maryellen', 'Daal', 'https://robohash.org/autperferendisquisquam.bmp?size=50x50&set=set1', 'mdaal2o@a8.net', '617-768-0322', 'mdaal2o', 'n4OfT4', 'Q3FQqFbU', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (98, 'Marina', 'Fearn', 'https://robohash.org/eosetet.jpg?size=50x50&set=set1', 'mfearn2p@microsoft.com', '888-682-0432', 'mfearn2p', 'JdeexeG4nbRn', '0DL8AdulKi', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (99, 'Link', 'Wike', 'https://robohash.org/enimestrem.png?size=50x50&set=set1', 'lwike2q@webeden.co.uk', '133-234-1207', 'lwike2q', 'FMbcplbCc', 'xF8gLw2', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (100, 'Aurelie', 'Shimwall', 'https://robohash.org/saepeeanesciunt.jpg?size=50x50&set=set1', 'ashimwall2r@furl.net', '591-879-2940', 'ashimwall2r', '2yQtBzkf82t0', 'OeTHwxpcWD1', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (101, 'Hallie', 'Sheriff', 'https://robohash.org/quibusdammagniut.png?size=50x50&set=set1', 'hsheriff2s@jugem.jp', '610-720-4448', 'hsheriff2s', 'ez8GgR6', 'C9ZDkiT', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (102, 'Julie', 'Gridley', 'https://robohash.org/itaqueesta.jpg?size=50x50&set=set1', 'jgridley2t@ycombinator.com', '945-285-7508', 'jgridley2t', 'WLFmBixKgpt', 'B1wdXTG', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (103, 'Nettle', 'Degnen', 'https://robohash.org/laborumaperiamnemo.bmp?size=50x50&set=set1', 'ndegnen2u@hubpages.com', '356-267-9318', 'ndegnen2u', 'WVsW7f', 'sqiL4tryB', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (104, 'Douglas', 'Catterick', 'https://robohash.org/officiisetcum.bmp?size=50x50&set=set1', 'dcatterick2v@acquirethisname.com', '838-107-9741', 'dcatterick2v', 'o2uByQtIQMc9', 'y2Uq6t', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (105, 'Claiborn', 'Jonsson', 'https://robohash.org/idquidemet.bmp?size=50x50&set=set1', 'cjonsson2w@cbc.ca', '301-566-3145', 'cjonsson2w', 'Sh5mOMa5m9', 'DP8zNn4g5S', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (106, 'Dare', 'Hedgeman', 'https://robohash.org/quodsapientequas.bmp?size=50x50&set=set1', 'dhedgeman2x@bloglovin.com', '401-361-3940', 'dhedgeman2x', 'nCmyNqC6PkNJ', 'KL78bx4ar', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (107, 'Moreen', 'Martine', 'https://robohash.org/quoomnisvoluptatibus.png?size=50x50&set=set1', 'mmartine2y@webmd.com', '229-547-3581', 'mmartine2y', 'sYPjg9HYGv', 'LUnTUMKHWK', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (108, 'Harlan', 'McCarrell', 'https://robohash.org/excepturisolutaducimus.bmp?size=50x50&set=set1', 'hmccarrell2z@hugedomains.com', '196-958-0498', 'hmccarrell2z', 'fOIlZcF4', '9rbkPRpNnfJ', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (109, 'Godfree', 'Newitt', 'https://robohash.org/illumsuntsapiente.png?size=50x50&set=set1', 'gnewitt30@flavors.me', '276-739-6862', 'gnewitt30', 'sNjI64M', 'HOgGUlcSLT', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (110, 'Nicholle', 'Hirtzmann', 'https://robohash.org/illosuntqui.bmp?size=50x50&set=set1', 'nhirtzmann31@census.gov', '218-713-9639', 'nhirtzmann31', 'Y1z0vy', 'i5aQkAmddam', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (111, 'Janeva', 'Towey', 'https://robohash.org/rerumsaepevoluptas.bmp?size=50x50&set=set1', 'jtowey32@statcounter.com', '585-609-0047', 'jtowey32', 'MzxJP54Xox', 'X2YNrkm7Y', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (112, 'Jobye', 'Aspinal', 'https://robohash.org/sitetpraesentium.jpg?size=50x50&set=set1', 'jaspinal33@123-reg.co.uk', '626-519-2816', 'jaspinal33', 'chjbcRGhc', 'e98OYow', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (113, 'Binny', 'Dilrew', 'https://robohash.org/totamrerumreiciendis.bmp?size=50x50&set=set1', 'bdilrew34@imageshack.us', '458-192-8415', 'bdilrew34', 'n8OoVANXww', 'qbLKGbmL', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (114, 'Berri', 'Georgeson', 'https://robohash.org/dolorumautdeleniti.bmp?size=50x50&set=set1', 'bgeorgeson35@ustream.tv', '491-606-3114', 'bgeorgeson35', 'g6tAjKbJipgl', '8jHR9sbvKp', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (115, 'Merrili', 'Posvner', 'https://robohash.org/etcupiditateet.png?size=50x50&set=set1', 'mposvner36@nifty.com', '548-696-6133', 'mposvner36', 'D3zoPmoHl5', '5sBSybpIYsv1', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (116, 'Giles', 'Akehurst', 'https://robohash.org/distinctiodolorenesciunt.bmp?size=50x50&set=set1', 'gakehurst37@salon.com', '907-453-6370', 'gakehurst37', 'FqSDQwcSl', 'GFcJES2AK5', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (117, 'Beniamino', 'Thumim', 'https://robohash.org/estvelvoluptatem.png?size=50x50&set=set1', 'bthumim38@is.gd', '395-601-1889', 'bthumim38', 'jtsmQs1', '3SXSLeMd8', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (118, 'Geoffry', 'Degoe', 'https://robohash.org/voluptatemrerumrem.png?size=50x50&set=set1', 'gdegoe39@quantcast.com', '560-884-4108', 'gdegoe39', '4fk6sWN', 'EsIw0vB', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (119, 'Delila', 'Wong', 'https://robohash.org/nihilaliquidnon.bmp?size=50x50&set=set1', 'dwong3a@hubpages.com', '720-344-5476', 'dwong3a', '0m93cpNqGm', '8yHHfVD', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (120, 'Otes', 'Brakewell', 'https://robohash.org/itaqueinsed.png?size=50x50&set=set1', 'obrakewell3b@ox.ac.uk', '302-164-6019', 'obrakewell3b', 'BW9iGj', 'SAcQR2', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (121, 'Benedicta', 'Doers', 'https://robohash.org/necessitatibuseostempora.jpg?size=50x50&set=set1', 'bdoers3c@symantec.com', '104-555-8831', 'bdoers3c', 'u9MPQUrMKv6z', 'yrMykyTtFHF', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (122, 'Carlen', 'Maccree', 'https://robohash.org/errorconsequatursequi.png?size=50x50&set=set1', 'cmaccree3d@mit.edu', '908-755-2713', 'cmaccree3d', 'AcLFoMhPX4aG', 'lhZ9sLcZLlwb', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (123, 'Dame', 'Spatig', 'https://robohash.org/commodipraesentiumaliquid.bmp?size=50x50&set=set1', 'dspatig3e@independent.co.uk', '468-731-7996', 'dspatig3e', 'Scqu6husne4Q', 'h3SMVpH7Ekag', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (124, 'Elbert', 'Spaule', 'https://robohash.org/amethicquos.bmp?size=50x50&set=set1', 'espaule3f@fastcompany.com', '797-788-4004', 'espaule3f', 'tH23C8', 'UZIYQkl2D9GN', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (125, 'Alfy', 'Jewer', 'https://robohash.org/sintutaliquam.jpg?size=50x50&set=set1', 'ajewer3g@i2i.jp', '418-963-9236', 'ajewer3g', 'Zp2B5BIAwwb', 'hPvKkIQ', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (126, 'Kathryn', 'Jury', 'https://robohash.org/sequiquiaut.bmp?size=50x50&set=set1', 'kjury3h@tiny.cc', '134-631-6125', 'kjury3h', 'hlL95lgD9As3', '4dspER9ex', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (127, 'Wade', 'Yurasov', 'https://robohash.org/exercitationemrerumdelectus.bmp?size=50x50&set=set1', 'wyurasov3i@cnet.com', '892-743-5678', 'wyurasov3i', 'Wje2ZJ', 'YtJDxmXy', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (128, 'Nathan', 'Heugh', 'https://robohash.org/utrerumerror.jpg?size=50x50&set=set1', 'nheugh3j@about.com', '340-759-5504', 'nheugh3j', 'MGhhPEAu', 'JCz6gCyByLvT', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (129, 'Irwin', 'Dowry', 'https://robohash.org/etmolestiasaccusamus.png?size=50x50&set=set1', 'idowry3k@cbslocal.com', '269-217-7497', 'idowry3k', 'zaeMeEba3', 'NLOm0PWG', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (130, 'Felicdad', 'Brownbridge', 'https://robohash.org/quasinecessitatibusiste.bmp?size=50x50&set=set1', 'fbrownbridge3l@deviantart.com', '948-308-7724', 'fbrownbridge3l', 'UJ4nrb1VL', 'wMXahbVigw9g', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (131, 'Willi', 'Mardling', 'https://robohash.org/nondoloreaut.jpg?size=50x50&set=set1', 'wmardling3m@wordpress.org', '664-943-5840', 'wmardling3m', 'vcIyVSvU', 'CS0phEiI', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (132, 'Pauly', 'Mollon', 'https://robohash.org/liberonumquamarchitecto.bmp?size=50x50&set=set1', 'pmollon3n@discovery.com', '597-216-3133', 'pmollon3n', '5fn4Ni', 'vtNxsx', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (133, 'Farrah', 'Nother', 'https://robohash.org/etiureminus.png?size=50x50&set=set1', 'fnother3o@prweb.com', '346-655-6706', 'fnother3o', 'MFxZxqw1', '6EPqxts', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (134, 'Harwilll', 'Postgate', 'https://robohash.org/quirecusandaemagnam.jpg?size=50x50&set=set1', 'hpostgate3p@skype.com', '839-648-0916', 'hpostgate3p', '9d46CuoXP', 'X2Lg6AMPgpe', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (135, 'Irma', 'MacAleese', 'https://robohash.org/recusandaesintet.jpg?size=50x50&set=set1', 'imacaleese3q@bing.com', '662-803-4450', 'imacaleese3q', 'f8bkwkU', 'HwhJyTKVJZNJ', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (136, 'Pierce', 'Moffet', 'https://robohash.org/culpablanditiissed.png?size=50x50&set=set1', 'pmoffet3r@google.com.br', '731-934-6764', 'pmoffet3r', 'aRP2Af30VZR', 'QbEvaXHkc', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (137, 'Ethelin', 'Seydlitz', 'https://robohash.org/quiadelenitiautem.png?size=50x50&set=set1', 'eseydlitz3s@hostgator.com', '749-671-4091', 'eseydlitz3s', 'ovlPibrED', 'CcgZvK4K4rB', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (138, 'Griz', 'Andriveau', 'https://robohash.org/dignissimosaccusamusvitae.png?size=50x50&set=set1', 'gandriveau3t@reddit.com', '524-501-7199', 'gandriveau3t', 'NLuvuQ', 'RBnkxVc5ydic', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (139, 'Niven', 'Digges', 'https://robohash.org/doloremquenihilesse.png?size=50x50&set=set1', 'ndigges3u@noaa.gov', '105-744-6663', 'ndigges3u', 'KB6DLTrCt6n', 'eIjbPIb', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (140, 'Nikolai', 'Iacopini', 'https://robohash.org/errorfacerepossimus.bmp?size=50x50&set=set1', 'niacopini3v@bravesites.com', '853-598-8170', 'niacopini3v', 'L3TFNqSB', '3gjRReIx', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (141, 'Rollin', 'Calafato', 'https://robohash.org/etipsaquod.png?size=50x50&set=set1', 'rcalafato3w@elegantthemes.com', '280-943-0582', 'rcalafato3w', 'yv5MtoIIF', 'yOEufs9eEB4g', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (142, 'Lucio', 'Lambertazzi', 'https://robohash.org/ullamnihilaliquid.bmp?size=50x50&set=set1', 'llambertazzi3x@hugedomains.com', '641-558-6684', 'llambertazzi3x', 'MawGl0toZt', '392lTKTLU4mZ', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (143, 'Gerick', 'Aps', 'https://robohash.org/ipsumevenietsoluta.png?size=50x50&set=set1', 'gaps3y@goodreads.com', '154-530-1885', 'gaps3y', 'ocqrf1YS7j', 'gOnduZhF8h', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (144, 'Carmina', 'Franchyonok', 'https://robohash.org/ipsumsuntdolor.jpg?size=50x50&set=set1', 'cfranchyonok3z@wix.com', '410-641-4435', 'cfranchyonok3z', '5KjCkWtcB', 'Ny9hnUGIT', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (145, 'Aaron', 'Tetford', 'https://robohash.org/repudiandaeliberonobis.jpg?size=50x50&set=set1', 'atetford40@google.it', '763-225-3210', 'atetford40', 'OrHWjHdr', 'XQHAFFq0JCJn', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (146, 'Cookie', 'Valsler', 'https://robohash.org/rationevoluptatemaut.bmp?size=50x50&set=set1', 'cvalsler41@macromedia.com', '692-622-9312', 'cvalsler41', 'J2WjBKqlj7BD', 'bmuNyWXuI', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (147, 'Augustina', 'Orum', 'https://robohash.org/similiqueoditquas.png?size=50x50&set=set1', 'aorum42@symantec.com', '784-496-3947', 'aorum42', 'XkZzmf', '26QY4vh', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (148, 'Cyrill', 'Wilcinskis', 'https://robohash.org/quosvoluptassoluta.bmp?size=50x50&set=set1', 'cwilcinskis43@jiathis.com', '523-848-0902', 'cwilcinskis43', 'YBoJ8f', '27d6ZeSal', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (149, 'Theresita', 'Bortolozzi', 'https://robohash.org/consequaturprovidentaut.png?size=50x50&set=set1', 'tbortolozzi44@vk.com', '174-889-4911', 'tbortolozzi44', 'ggsref7', 'NSejALQmMl', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (150, 'Gusta', 'Cozby', 'https://robohash.org/voluptatemnumquamsed.bmp?size=50x50&set=set1', 'gcozby45@123-reg.co.uk', '763-739-0352', 'gcozby45', 'qFbaK5', 'hGWw45GpB', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (151, 'Hugues', 'Reeds', 'https://robohash.org/quomoditempore.jpg?size=50x50&set=set1', 'hreeds46@imageshack.us', '981-586-0924', 'hreeds46', 'AGWbkoS', '9Bdq60i', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (152, 'Sianna', 'Sherlock', 'https://robohash.org/nonnumquamvelit.bmp?size=50x50&set=set1', 'ssherlock47@seesaa.net', '124-847-6855', 'ssherlock47', 'I3oNpuRrl3', '7OqYWvaBtP', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (153, 'Stanislaus', 'Rattrie', 'https://robohash.org/estquisdistinctio.bmp?size=50x50&set=set1', 'srattrie48@sciencedirect.com', '428-863-3443', 'srattrie48', 'UmIXOa4acP', 'm21YZtK', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (154, 'Brandy', 'Swaden', 'https://robohash.org/inciduntpossimusaut.jpg?size=50x50&set=set1', 'bswaden49@businessweek.com', '243-377-9316', 'bswaden49', '74wXvtSdo', 'CKnjdcriC', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (155, 'Koenraad', 'Mash', 'https://robohash.org/quiutenim.png?size=50x50&set=set1', 'kmash4a@tripod.com', '113-949-3432', 'kmash4a', 'NdNLfk24', '8y8UuT', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (156, 'Garth', 'Western', 'https://robohash.org/distinctioetvoluptates.bmp?size=50x50&set=set1', 'gwestern4b@google.co.uk', '654-809-5185', 'gwestern4b', 'raKSJ56lYjF0', 'PvwyWC2', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (157, 'Durante', 'Hasard', 'https://robohash.org/maioresquodnemo.jpg?size=50x50&set=set1', 'dhasard4c@topsy.com', '261-898-2329', 'dhasard4c', '6D9T1SHbjz', 'Hbi0VoZ1mg', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (158, 'Delmer', 'Vellacott', 'https://robohash.org/optiositcorrupti.jpg?size=50x50&set=set1', 'dvellacott4d@cdbaby.com', '530-774-6136', 'dvellacott4d', 'JwwjEx67l', 'rbwxDnVmd41', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (159, 'Hill', 'Demsey', 'https://robohash.org/aliquamofficiisenim.bmp?size=50x50&set=set1', 'hdemsey4e@elegantthemes.com', '942-195-2646', 'hdemsey4e', 'i0NGh831HvG', 'XXnpE8ug', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (160, 'Augusta', 'Breston', 'https://robohash.org/etvoluptasreprehenderit.jpg?size=50x50&set=set1', 'abreston4f@amazon.co.jp', '961-732-2899', 'abreston4f', '4Acek0ocH', 'C2UKQmNCY9r', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (161, 'Stefanie', 'Bails', 'https://robohash.org/nemonecessitatibusquisquam.jpg?size=50x50&set=set1', 'sbails4g@wufoo.com', '442-953-9287', 'sbails4g', 'nzBeluWk1i', '0XITqKkG', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (162, 'Augustin', 'Navaro', 'https://robohash.org/sitrerumveritatis.png?size=50x50&set=set1', 'anavaro4h@rediff.com', '706-585-4662', 'anavaro4h', 'iCMW6Uytzl', 'fkSHLcyKYPn1', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (163, 'Terrance', 'Symmons', 'https://robohash.org/nisiinciduntcorrupti.bmp?size=50x50&set=set1', 'tsymmons4i@skype.com', '744-493-5605', 'tsymmons4i', 'b7ULWX0J', 'VG8tZM', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (164, 'Virginie', 'Bickerstaff', 'https://robohash.org/adipisciseddeleniti.jpg?size=50x50&set=set1', 'vbickerstaff4j@nhs.uk', '663-403-6799', 'vbickerstaff4j', 'hdjFRSMnTU8', 'zUBrqttvNkX', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (165, 'Seka', 'Chaize', 'https://robohash.org/etliberoillum.jpg?size=50x50&set=set1', 'schaize4k@topsy.com', '544-508-3771', 'schaize4k', 'HGvIk1r', 'ekROU8cL', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (166, 'Dorena', 'Hegg', 'https://robohash.org/architectodoloret.bmp?size=50x50&set=set1', 'dhegg4l@yale.edu', '757-444-6105', 'dhegg4l', 'STk2te6yU', 'RiAKI9MT', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (167, 'Glynda', 'Mungane', 'https://robohash.org/dolorumetnostrum.bmp?size=50x50&set=set1', 'gmungane4m@chicagotribune.com', '473-595-5191', 'gmungane4m', 't8fIvedikyf', 'wEnxgvYM', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (168, 'Dianna', 'Spencers', 'https://robohash.org/quoestnam.png?size=50x50&set=set1', 'dspencers4n@tiny.cc', '947-805-8801', 'dspencers4n', '0kYfjtTR', 'kExqWs7S4', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (169, 'Benjamin', 'Compson', 'https://robohash.org/delenitiestdolorem.png?size=50x50&set=set1', 'bcompson4o@imgur.com', '977-705-5974', 'bcompson4o', 'SOGOXUr', 'H2gyEIv5RTd', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (170, 'Thorin', 'Larmett', 'https://robohash.org/eumexpeditaa.jpg?size=50x50&set=set1', 'tlarmett4p@prnewswire.com', '181-643-2339', 'tlarmett4p', 'zS1BnE8pVyDr', '8VxIK7pSXy', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (171, 'Smitty', 'Spieck', 'https://robohash.org/ipsumetsuscipit.jpg?size=50x50&set=set1', 'sspieck4q@sciencedaily.com', '682-830-5329', 'sspieck4q', 'O9mnlO', 'xE6LIpNK', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (172, 'Gifford', 'Bampton', 'https://robohash.org/nobismagnamquia.bmp?size=50x50&set=set1', 'gbampton4r@latimes.com', '327-667-7395', 'gbampton4r', 'MfFfBGHwWJ', 'sjvUbTZ4UQY', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (173, 'Juan', 'Pharro', 'https://robohash.org/sitcommodiest.png?size=50x50&set=set1', 'jpharro4s@soundcloud.com', '607-592-3595', 'jpharro4s', 'Z0HRhNzdy', 'jFS2G4b5A', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (174, 'Sutherlan', 'Jellico', 'https://robohash.org/teneturquosaccusamus.bmp?size=50x50&set=set1', 'sjellico4t@imdb.com', '279-343-4766', 'sjellico4t', 'VmHlVzDnKwht', '6mzxC4NGG1P', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (175, 'Dinnie', 'Hardwick', 'https://robohash.org/repudiandaemagnamtenetur.png?size=50x50&set=set1', 'dhardwick4u@i2i.jp', '314-234-6176', 'dhardwick4u', 'DYHUCjd', 'GGqe9cGg', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (176, 'Karlotte', 'Battison', 'https://robohash.org/porrohicvoluptatum.png?size=50x50&set=set1', 'kbattison4v@deviantart.com', '349-833-1457', 'kbattison4v', 'D41pjb', 'kuJA347rQR', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (177, 'Lindy', 'Greenrod', 'https://robohash.org/illoerrorqui.png?size=50x50&set=set1', 'lgreenrod4w@yahoo.co.jp', '202-934-8680', 'lgreenrod4w', 'Bc8sPyugE6iX', 'oBlOSbHcIB8N', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (178, 'Adella', 'Bentick', 'https://robohash.org/sednecessitatibusodio.png?size=50x50&set=set1', 'abentick4x@wikia.com', '326-268-1753', 'abentick4x', '3m06nw9', 'EIpB4Vdxq', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (179, 'Meggi', 'Kinch', 'https://robohash.org/corruptiipsamprovident.bmp?size=50x50&set=set1', 'mkinch4y@rambler.ru', '361-161-8831', 'mkinch4y', 'sIMdVY', 'cSQezF', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (180, 'Slade', 'Kerins', 'https://robohash.org/eumdoloresut.bmp?size=50x50&set=set1', 'skerins4z@tinypic.com', '716-782-8559', 'skerins4z', 'FjawKh3oy', 'Q6Yu4eq', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (181, 'Bernadine', 'Gasticke', 'https://robohash.org/totamestqui.png?size=50x50&set=set1', 'bgasticke50@google.it', '667-437-7249', 'bgasticke50', 'x9BxZLDyDp', 'E9RvPUf', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (182, 'Hasheem', 'Harrow', 'https://robohash.org/exercitationemillovoluptatem.bmp?size=50x50&set=set1', 'hharrow51@w3.org', '760-418-3865', 'hharrow51', '4TdHbBC', 'JcaKjFLsoO', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (183, 'Craggie', 'Kemson', 'https://robohash.org/sintlaborumomnis.jpg?size=50x50&set=set1', 'ckemson52@washingtonpost.com', '946-671-2569', 'ckemson52', 'VBfL9ub6F4yh', 'HcfgxlSJp', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (184, 'Cort', 'Andri', 'https://robohash.org/estillovelit.png?size=50x50&set=set1', 'candri53@washington.edu', '228-889-9266', 'candri53', 'qEEBy30CiX', 'OPjPGgP45t', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (185, 'Hamel', 'Bater', 'https://robohash.org/laudantiumexpeditaconsectetur.bmp?size=50x50&set=set1', 'hbater54@accuweather.com', '776-337-2010', 'hbater54', '1RFijpP6hTn', 'UrOx9D', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (186, 'Griff', 'Labrone', 'https://robohash.org/vitaequissimilique.bmp?size=50x50&set=set1', 'glabrone55@theglobeandmail.com', '910-485-7378', 'glabrone55', 'bjxMJE', 'aiW53SaBNh', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (187, 'Alfreda', 'Brakewell', 'https://robohash.org/quicumquefugit.bmp?size=50x50&set=set1', 'abrakewell56@fda.gov', '715-268-3943', 'abrakewell56', 'o2ayYAdMExCp', 'Vl6wCNb', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (188, 'Cherrita', 'Grishkov', 'https://robohash.org/vitaevoluptatembeatae.png?size=50x50&set=set1', 'cgrishkov57@bing.com', '820-872-1264', 'cgrishkov57', 'bZ9oQGpn7LV', 'JL3nggSsVfX4', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (189, 'Windham', 'Von Helmholtz', 'https://robohash.org/veritatiscommodiharum.png?size=50x50&set=set1', 'wvonhelmholtz58@ning.com', '343-961-7517', 'wvonhelmholtz58', 'TFNB5hmr', 'oCH7u0', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (190, 'Ronnie', 'Edling', 'https://robohash.org/oditaliquidet.png?size=50x50&set=set1', 'redling59@jimdo.com', '367-161-1256', 'redling59', 'prwGUFCERqHa', 'JCEsrEcYCE', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (191, 'Dun', 'Carverhill', 'https://robohash.org/etvoluptasvoluptatem.jpg?size=50x50&set=set1', 'dcarverhill5a@etsy.com', '863-904-6252', 'dcarverhill5a', 'mJBv7x', 'VaqwGQIR40oM', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (192, 'Stanley', 'Feragh', 'https://robohash.org/doloresnonaspernatur.png?size=50x50&set=set1', 'sferagh5b@webmd.com', '481-597-9407', 'sferagh5b', 'FOwhpQFu', 'X3deMqmQzHWZ', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (193, 'Donalt', 'Metts', 'https://robohash.org/autestreiciendis.jpg?size=50x50&set=set1', 'dmetts5c@bloglines.com', '585-848-1321', 'dmetts5c', '1DVTI9FDwT', '5DcH58C', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (194, 'Seana', 'Beltzner', 'https://robohash.org/temporaautet.png?size=50x50&set=set1', 'sbeltzner5d@yellowpages.com', '258-189-0311', 'sbeltzner5d', 'Ju3WS8L9i', 'sDa1s8', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (195, 'Evangelina', 'Teece', 'https://robohash.org/estfugiatquia.bmp?size=50x50&set=set1', 'eteece5e@t.co', '576-854-8528', 'eteece5e', 'pxbqlckdg', 'jB55GNP', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (196, 'Lisette', 'Aslam', 'https://robohash.org/quosinteaque.jpg?size=50x50&set=set1', 'laslam5f@miitbeian.gov.cn', '374-209-3727', 'laslam5f', 'NGIJgo', '8MjPys', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (197, 'Melli', 'Ketcher', 'https://robohash.org/quodoloribusid.bmp?size=50x50&set=set1', 'mketcher5g@spiegel.de', '948-380-9786', 'mketcher5g', 'Bv1D2NOSCkWd', '8ibMyTOtLgj', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (198, 'Terrijo', 'Hennington', 'https://robohash.org/eosullamquisquam.bmp?size=50x50&set=set1', 'thennington5h@so-net.ne.jp', '551-965-1776', 'thennington5h', '2zAf4Pev', 'LRBniu', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (199, 'Luz', 'Iddons', 'https://robohash.org/sedipsamharum.bmp?size=50x50&set=set1', 'liddons5i@t-online.de', '648-972-1998', 'liddons5i', 'adyblbmR5ul', 'h6ivwY1Y', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (200, 'Rosy', 'McGill', 'https://robohash.org/aspernaturmolestiaequo.png?size=50x50&set=set1', 'rmcgill5j@bizjournals.com', '326-374-7902', 'rmcgill5j', 'PXtfE3', 'Nr4Kau27txIT', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (201, 'Wendye', 'Rolfi', 'https://robohash.org/nonofficiisamet.bmp?size=50x50&set=set1', 'wrolfi5k@infoseek.co.jp', '220-242-1183', 'wrolfi5k', '4CoH4G', 'agbxdC5CykcS', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (202, 'Gertruda', 'Samuel', 'https://robohash.org/mollitianecessitatibusea.png?size=50x50&set=set1', 'gsamuel5l@woothemes.com', '660-928-5944', 'gsamuel5l', 'uivPWiLFQeP0', 'QRq2yhWvo', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (203, 'Sherrie', 'Toward', 'https://robohash.org/quiafacilissit.bmp?size=50x50&set=set1', 'stoward5m@meetup.com', '262-223-1045', 'stoward5m', 'Xu6nguJq', 'i8Xh4vkhS', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (204, 'Malcolm', 'Duncombe', 'https://robohash.org/eiussintaut.png?size=50x50&set=set1', 'mduncombe5n@ucoz.com', '954-318-4713', 'mduncombe5n', 'ynBYyHCfi', '8aD93fBMy', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (205, 'Kally', 'Whapple', 'https://robohash.org/etconsequaturdelectus.jpg?size=50x50&set=set1', 'kwhapple5o@tumblr.com', '108-999-0276', 'kwhapple5o', '2HuedfF26dys', 'yo3BkuHs', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (206, 'Ted', 'Lutas', 'https://robohash.org/suntquidemtotam.bmp?size=50x50&set=set1', 'tlutas5p@ycombinator.com', '812-273-6790', 'tlutas5p', 'mbsVdOYmC', 'KaBzwOEkUWt', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (207, 'Kerstin', 'Shearn', 'https://robohash.org/omnissedconsequuntur.bmp?size=50x50&set=set1', 'kshearn5q@plala.or.jp', '535-800-5369', 'kshearn5q', 'i1pfiq', 'jVy7nxayTf', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (208, 'Patrizio', 'Pasmore', 'https://robohash.org/doloremsitut.png?size=50x50&set=set1', 'ppasmore5r@myspace.com', '798-722-4836', 'ppasmore5r', 'L2joaE7K', 'h6rT6RIB0J4', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (209, 'Sol', 'Livingston', 'https://robohash.org/exullamaliquam.png?size=50x50&set=set1', 'slivingston5s@altervista.org', '295-894-0083', 'slivingston5s', '1mj4xH6vnV3W', 'Pt4TAxTbq14', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (210, 'Kimberli', 'Cumbridge', 'https://robohash.org/odioanimieveniet.png?size=50x50&set=set1', 'kcumbridge5t@state.tx.us', '290-108-3176', 'kcumbridge5t', 'LHrekXn', 'aRIzFzhQ', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (211, 'Lorinda', 'De Ferrari', 'https://robohash.org/nobisaspernatursequi.jpg?size=50x50&set=set1', 'ldeferrari5u@guardian.co.uk', '102-483-0772', 'ldeferrari5u', 'jOcX8Jbbq', '65OWkdE', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (212, 'Thelma', 'Heaslip', 'https://robohash.org/magniautcumque.jpg?size=50x50&set=set1', 'theaslip5v@nymag.com', '893-127-7352', 'theaslip5v', 'E4nC8RwJs', 'xqxQfLq7JB8C', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (213, 'Gustaf', 'Calder', 'https://robohash.org/doloremdoloremquenam.jpg?size=50x50&set=set1', 'gcalder5w@netvibes.com', '924-854-0954', 'gcalder5w', 'mlkP0gCt2', 'feyYz6', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (214, 'Allin', 'Rasper', 'https://robohash.org/essequaeratmaxime.jpg?size=50x50&set=set1', 'arasper5x@psu.edu', '950-718-7630', 'arasper5x', 'cxPpouL', '9jnOfStnQB7u', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (215, 'Clemente', 'Dudderidge', 'https://robohash.org/ettotamnumquam.png?size=50x50&set=set1', 'cdudderidge5y@ameblo.jp', '123-339-6605', 'cdudderidge5y', 'CAmh18Q049AC', 'ndMoOZI6B', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (216, 'Kassey', 'Dorot', 'https://robohash.org/sedearumnon.png?size=50x50&set=set1', 'kdorot5z@house.gov', '459-700-9375', 'kdorot5z', 'FxSUDcP9v1O', 'r5jP9u', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (217, 'Sheppard', 'Clemon', 'https://robohash.org/inciduntvelitquam.png?size=50x50&set=set1', 'sclemon60@boston.com', '138-817-0175', 'sclemon60', 'uiaIYPjaJ', 'K9dfyRL', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (218, 'Hilary', 'Whittick', 'https://robohash.org/doloremsimiliqueperferendis.png?size=50x50&set=set1', 'hwhittick61@gov.uk', '453-568-6646', 'hwhittick61', 'FfQDu9Yqs0', 'bzuBPYxL', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (219, 'Willetta', 'Sterland', 'https://robohash.org/omnismolestiaealiquam.bmp?size=50x50&set=set1', 'wsterland62@craigslist.org', '707-869-5836', 'wsterland62', 'LZBNhd7a', '77x4lU', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (220, 'Klemens', 'Peebles', 'https://robohash.org/quaesintut.png?size=50x50&set=set1', 'kpeebles63@e-recht24.de', '350-638-2673', 'kpeebles63', 'GhPrspX', 'BLTNOG8xf', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (221, 'Lutero', 'Goalley', 'https://robohash.org/maximenesciuntlaudantium.jpg?size=50x50&set=set1', 'lgoalley64@dot.gov', '460-718-1087', 'lgoalley64', '21AVNfR5bFwQ', 'dLZ39PXKhgmm', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (222, 'Wilek', 'Linforth', 'https://robohash.org/autametut.jpg?size=50x50&set=set1', 'wlinforth65@free.fr', '668-432-0612', 'wlinforth65', 'eZPy44SWbbiE', 'I0vBb4bxW', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (223, 'Gweneth', 'Monteath', 'https://robohash.org/voluptasdoloribusalias.bmp?size=50x50&set=set1', 'gmonteath66@ning.com', '638-496-0292', 'gmonteath66', '6GYfC9sY5O7', '6ecoM4PZ4c0', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (224, 'Lissie', 'Jakubovski', 'https://robohash.org/perferendisquamqui.bmp?size=50x50&set=set1', 'ljakubovski67@issuu.com', '164-163-6205', 'ljakubovski67', 'RkhJNdD', 'ENSr9XjSd', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (225, 'Amie', 'Janks', 'https://robohash.org/distinctioquibusdamvoluptas.png?size=50x50&set=set1', 'ajanks68@earthlink.net', '694-758-0735', 'ajanks68', 'Uf3XQm3', 'gKcZ7pQD', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (226, 'Eward', 'Willmetts', 'https://robohash.org/repudiandaeconsequaturest.jpg?size=50x50&set=set1', 'ewillmetts69@samsung.com', '869-552-9766', 'ewillmetts69', 'wMqa5TxM', '55WHyEd4OA', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (227, 'Hersch', 'Mourant', 'https://robohash.org/consequuntureaqueerror.bmp?size=50x50&set=set1', 'hmourant6a@ed.gov', '920-654-9376', 'hmourant6a', 'aKHvCGSGpB6', 'hl8QmHYP', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (228, 'Biddy', 'Wanley', 'https://robohash.org/nesciuntharumnihil.jpg?size=50x50&set=set1', 'bwanley6b@twitter.com', '891-413-6971', 'bwanley6b', 'Y815dkEfdTg', 'gB6LxEo', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (229, 'Josephine', 'Flacknoe', 'https://robohash.org/quiaautsunt.png?size=50x50&set=set1', 'jflacknoe6c@squarespace.com', '338-644-8440', 'jflacknoe6c', 'W8my0TY2', 'j499DZy', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (230, 'Arthur', 'Dibble', 'https://robohash.org/reiciendisvoluptatemet.jpg?size=50x50&set=set1', 'adibble6d@pinterest.com', '624-353-1119', 'adibble6d', 'IwgLbAlR8t7', 'fsn0AM', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (231, 'Bailie', 'Scruby', 'https://robohash.org/enimautemconsectetur.png?size=50x50&set=set1', 'bscruby6e@army.mil', '871-317-6737', 'bscruby6e', 'KzyxEFDXcK', 'QCtxVDj', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (232, 'Betta', 'Escolme', 'https://robohash.org/dignissimosesteligendi.png?size=50x50&set=set1', 'bescolme6f@yellowpages.com', '453-919-6660', 'bescolme6f', 'GSiYzyOu', 'ZIqEF0', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (233, 'Karina', 'Falkner', 'https://robohash.org/undeeosnesciunt.bmp?size=50x50&set=set1', 'kfalkner6g@buzzfeed.com', '467-920-7748', 'kfalkner6g', 'ChiXUWbk', 'hYNIhxSgXys', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (234, 'Antone', 'O''Shavlan', 'https://robohash.org/delenitiautnesciunt.bmp?size=50x50&set=set1', 'aoshavlan6h@fastcompany.com', '713-472-5899', 'aoshavlan6h', 'Z258SoFDTu', '8mMaZE4zuOSE', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (235, 'Ashien', 'Barbosa', 'https://robohash.org/consequaturabest.bmp?size=50x50&set=set1', 'abarbosa6i@sogou.com', '117-884-1909', 'abarbosa6i', 'kmPD5dCgp', 'vcNmvSYH', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (236, 'Thorsten', 'Withinshaw', 'https://robohash.org/voluptatumrecusandaereprehenderit.bmp?size=50x50&set=set1', 'twithinshaw6j@bigcartel.com', '206-914-9947', 'twithinshaw6j', '2kVThSM', 'Pu4TNR7xNEPm', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (237, 'Wilie', 'Burhouse', 'https://robohash.org/nisioccaecatiea.bmp?size=50x50&set=set1', 'wburhouse6k@g.co', '211-556-3140', 'wburhouse6k', 'IDvA8zIqPxS', 'DmmXSOVg', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (238, 'Idell', 'Sidery', 'https://robohash.org/distinctioliberoaspernatur.bmp?size=50x50&set=set1', 'isidery6l@japanpost.jp', '892-239-9121', 'isidery6l', '3jiZdeLLH', 'JyzqxGFu7UT', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (239, 'Nari', 'Skeggs', 'https://robohash.org/optiosintaut.jpg?size=50x50&set=set1', 'nskeggs6m@boston.com', '462-648-1383', 'nskeggs6m', '5gnmjL9rO5m', 'RXXmc5C', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (240, 'Dan', 'Childers', 'https://robohash.org/inciduntquiconsequatur.bmp?size=50x50&set=set1', 'dchilders6n@bluehost.com', '422-670-9349', 'dchilders6n', 'xWzzjkxg', 'rWaLu2ogrxXo', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (241, 'Brenna', 'Laundon', 'https://robohash.org/eadoloremaspernatur.jpg?size=50x50&set=set1', 'blaundon6o@skype.com', '120-393-0870', 'blaundon6o', 'Z5ovBJ', 'wOqyzIR4r', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (242, 'Hayes', 'Owttrim', 'https://robohash.org/rationesitdolorum.jpg?size=50x50&set=set1', 'howttrim6p@time.com', '391-905-7336', 'howttrim6p', 'rel4VvnB', 'oxdi4gBU', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (243, 'Allianora', 'Treat', 'https://robohash.org/nisiexreprehenderit.jpg?size=50x50&set=set1', 'atreat6q@tamu.edu', '337-759-1269', 'atreat6q', 'sZbL7MMF', '2NgxRtnfYuw9', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (244, 'Orion', 'Ludovico', 'https://robohash.org/quassequiquia.jpg?size=50x50&set=set1', 'oludovico6r@illinois.edu', '875-612-3882', 'oludovico6r', 'nqpUTrSsKdny', 'IEyPZdZTWuZ', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (245, 'Neda', 'Torr', 'https://robohash.org/facerecommodimaiores.jpg?size=50x50&set=set1', 'ntorr6s@moonfruit.com', '982-802-3637', 'ntorr6s', '4s7i4O', 'EvblfNsuus', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (246, 'Karoly', 'D''eath', 'https://robohash.org/quiautet.bmp?size=50x50&set=set1', 'kdeath6t@zdnet.com', '622-479-4670', 'kdeath6t', 'JhodSaM0', 'Is6J1noAR', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (247, 'Adel', 'Hamsher', 'https://robohash.org/molestiasoccaecatiqui.bmp?size=50x50&set=set1', 'ahamsher6u@omniture.com', '926-383-5215', 'ahamsher6u', 'mrAJCkIp', '0OCwLl4zX', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (248, 'Fred', 'Minci', 'https://robohash.org/inciduntquiconsequatur.bmp?size=50x50&set=set1', 'fminci6v@google.nl', '487-847-9440', 'fminci6v', 'AMBIY88xoU', 'qGAbcB5qkAT', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (249, 'Claudius', 'Treves', 'https://robohash.org/temporacumminima.png?size=50x50&set=set1', 'ctreves6w@cornell.edu', '856-304-1740', 'ctreves6w', 'n1quqI3x3NQ', 'bIDOPGf6', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (250, 'Ginger', 'Bauser', 'https://robohash.org/remsaepeautem.png?size=50x50&set=set1', 'gbauser6x@usa.gov', '892-248-8634', 'gbauser6x', 'ckEc2VG8hi1', 't0LqDMD', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (251, 'Irv', 'Rizziello', 'https://robohash.org/maioresodioexpedita.png?size=50x50&set=set1', 'irizziello6y@networksolutions.com', '479-280-6019', 'irizziello6y', 'jqYwMYnZ', 'b0L8CvRu5e', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (252, 'Laverna', 'Demkowicz', 'https://robohash.org/autexercitationemmagni.jpg?size=50x50&set=set1', 'ldemkowicz6z@forbes.com', '649-459-9676', 'ldemkowicz6z', 'Qepv98', 'knXyf9Bd', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (253, 'Roderich', 'Jobb', 'https://robohash.org/harumasperioresipsa.jpg?size=50x50&set=set1', 'rjobb70@cisco.com', '285-294-9411', 'rjobb70', 'KJVixdkIP4', '9ukGgnAMM7d', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (254, 'Audry', 'Domm', 'https://robohash.org/etvitaedeserunt.png?size=50x50&set=set1', 'adomm71@reference.com', '817-904-3683', 'adomm71', '5FALn0v1', 'dIUaAr', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (255, 'De', 'Antonowicz', 'https://robohash.org/enimmolestiaedolor.png?size=50x50&set=set1', 'dantonowicz72@springer.com', '751-898-9296', 'dantonowicz72', 'ZRNepXBS', 'J3O9Du', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (256, 'Silvana', 'Kingham', 'https://robohash.org/animiquissoluta.jpg?size=50x50&set=set1', 'skingham73@360.cn', '599-894-1071', 'skingham73', '2jMELqRZ0', 'maGG59', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (257, 'Eadith', 'Anetts', 'https://robohash.org/deleniticonsectetursequi.bmp?size=50x50&set=set1', 'eanetts74@themeforest.net', '819-864-6414', 'eanetts74', 'P2Kc1sy', 'VMd7w1kk', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (258, 'Thacher', 'Bollins', 'https://robohash.org/utnecessitatibusin.png?size=50x50&set=set1', 'tbollins75@dion.ne.jp', '675-439-0660', 'tbollins75', 'CjJrvKR6', 'aimMln', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (259, 'Michail', 'Evison', 'https://robohash.org/suntarchitectovoluptas.jpg?size=50x50&set=set1', 'mevison76@jigsy.com', '842-424-3528', 'mevison76', 'QJNRMt6V2l', '3MT3X6U7MQ4', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (260, 'Garold', 'Kennon', 'https://robohash.org/quoundefacere.png?size=50x50&set=set1', 'gkennon77@indiegogo.com', '494-292-1413', 'gkennon77', 'F0xAoNXL9y', 'ajukBkBGrdv', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (261, 'Sollie', 'Ellis', 'https://robohash.org/aspernaturtotamiusto.bmp?size=50x50&set=set1', 'sellis78@chicagotribune.com', '882-308-0030', 'sellis78', '8a2HXviw', 'SJZw3QX', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (262, 'Joli', 'Beining', 'https://robohash.org/natussitaliquam.jpg?size=50x50&set=set1', 'jbeining79@ebay.co.uk', '456-238-2806', 'jbeining79', 'cufo5pYPUQd', 'O04SFZXs', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (263, 'Enoch', 'Founds', 'https://robohash.org/deseruntrepellatquam.png?size=50x50&set=set1', 'efounds7a@japanpost.jp', '771-463-8528', 'efounds7a', 'Uh0p5I4YI', '8bju3QEgRf1', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (264, 'Briant', 'McCulloch', 'https://robohash.org/minusaccusantiumet.jpg?size=50x50&set=set1', 'bmcculloch7b@huffingtonpost.com', '151-307-4342', 'bmcculloch7b', 'SNTNVBESgE', '96Q03ZD', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (265, 'Cortie', 'Evert', 'https://robohash.org/modinostrumquia.bmp?size=50x50&set=set1', 'cevert7c@icio.us', '549-438-3331', 'cevert7c', '95ZWYVhQR', '8RjO9wFiSFh', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (266, 'Pamella', 'Beautyman', 'https://robohash.org/dolorumsuntmodi.bmp?size=50x50&set=set1', 'pbeautyman7d@homestead.com', '880-260-7201', 'pbeautyman7d', 'msNZmXj', 'filTCOYC7', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (267, 'Lucina', 'Spittal', 'https://robohash.org/adipiscienimquae.jpg?size=50x50&set=set1', 'lspittal7e@elegantthemes.com', '356-163-2106', 'lspittal7e', 'TpLvvi', 'fI0pDNfWVd', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (268, 'Una', 'Gather', 'https://robohash.org/vitaeplaceatconsequatur.bmp?size=50x50&set=set1', 'ugather7f@gnu.org', '679-121-3878', 'ugather7f', 'NVZSkTgJ', 'ZVTxWui', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (269, 'Conni', 'Wellington', 'https://robohash.org/blanditiistotamet.bmp?size=50x50&set=set1', 'cwellington7g@ehow.com', '905-353-6588', 'cwellington7g', 'qM8jKXeXw', 'tPqrJlqeu', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (270, 'Marci', 'Emmatt', 'https://robohash.org/etexcepturirerum.bmp?size=50x50&set=set1', 'memmatt7h@wunderground.com', '309-725-9695', 'memmatt7h', 'y3txK6', '1HKY2HZW9lwC', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (271, 'Bail', 'Humbatch', 'https://robohash.org/quamsuntsuscipit.jpg?size=50x50&set=set1', 'bhumbatch7i@wunderground.com', '567-277-0380', 'bhumbatch7i', 'hzqHoihzde', 'rsXmZA', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (272, 'Sandy', 'Trott', 'https://robohash.org/occaecatialiquamest.jpg?size=50x50&set=set1', 'strott7j@gov.uk', '186-681-6483', 'strott7j', 'Ah1y9cRNDTw', 'e302dbrB', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (273, 'Lacy', 'Mursell', 'https://robohash.org/veniamrecusandaedolorum.png?size=50x50&set=set1', 'lmursell7k@seattletimes.com', '743-573-9575', 'lmursell7k', 'e62pC13kS', 'yd5q6Q', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (274, 'Titos', 'Lincke', 'https://robohash.org/autvoluptasquia.png?size=50x50&set=set1', 'tlincke7l@homestead.com', '533-736-8843', 'tlincke7l', 'CfVmhx1b', 'CiwkoFxWuyI8', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (275, 'Dorey', 'Widdows', 'https://robohash.org/velitinciduntqui.png?size=50x50&set=set1', 'dwiddows7m@dion.ne.jp', '237-253-0441', 'dwiddows7m', 'SmzfVI', 'Wzp6G3AC6a', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (276, 'Cathie', 'Wallbutton', 'https://robohash.org/quodnemovoluptas.bmp?size=50x50&set=set1', 'cwallbutton7n@delicious.com', '384-576-8717', 'cwallbutton7n', 'oGjVxZ', 'Y10JvYPmh9cE', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (277, 'Jo', 'Cayton', 'https://robohash.org/quiaarchitectoqui.bmp?size=50x50&set=set1', 'jcayton7o@globo.com', '306-471-8058', 'jcayton7o', 'OsmJdGg', 'KsJDqLYgfd', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (278, 'Greer', 'Dufaur', 'https://robohash.org/sequiquimodi.jpg?size=50x50&set=set1', 'gdufaur7p@google.com.br', '384-200-6083', 'gdufaur7p', 'jnoB07Og', 'PTlz8IZtSVwc', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (279, 'Caron', 'Robins', 'https://robohash.org/doloribusdistinctioqui.jpg?size=50x50&set=set1', 'crobins7q@t-online.de', '855-772-8502', 'crobins7q', 'ijiakTlZuRY', '19pp4M', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (280, 'Hamilton', 'Zecchi', 'https://robohash.org/idquaeratrepellendus.bmp?size=50x50&set=set1', 'hzecchi7r@prweb.com', '612-449-3130', 'hzecchi7r', 'U7Ecclw', 'Oe5QDfa4R', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (281, 'Kira', 'Ludron', 'https://robohash.org/recusandaequiblanditiis.jpg?size=50x50&set=set1', 'kludron7s@forbes.com', '549-812-0708', 'kludron7s', 'kltfMJN', 'C56h86Y17', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (282, 'Darbie', 'Hazlegrove', 'https://robohash.org/aliasquiodit.jpg?size=50x50&set=set1', 'dhazlegrove7t@kickstarter.com', '886-911-3176', 'dhazlegrove7t', 'TIMgHY7PzE', 'kvRTY23', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (283, 'Gilberta', 'Burry', 'https://robohash.org/placeatfacereut.bmp?size=50x50&set=set1', 'gburry7u@webeden.co.uk', '200-180-1411', 'gburry7u', 'A4qbsQE', 't7rA2sS', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (284, 'Tana', 'Marfe', 'https://robohash.org/quiconsequaturaut.jpg?size=50x50&set=set1', 'tmarfe7v@sciencedaily.com', '476-118-3026', 'tmarfe7v', 'iV33wKN6q', 'oTKz4lXH', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (285, 'Lorne', 'Beachem', 'https://robohash.org/temporibusametet.jpg?size=50x50&set=set1', 'lbeachem7w@wisc.edu', '475-501-6215', 'lbeachem7w', '94N2RozzjTjw', 'eH95Vn7XZiEL', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (286, 'Bay', 'Suart', 'https://robohash.org/hicnihilquia.png?size=50x50&set=set1', 'bsuart7x@businessinsider.com', '234-195-6078', 'bsuart7x', 'Vywd4EtFLBY', 'lgk2R2EyVfi4', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (287, 'Langston', 'Dripps', 'https://robohash.org/corruptivoluptatemqui.bmp?size=50x50&set=set1', 'ldripps7y@redcross.org', '324-210-3942', 'ldripps7y', 'YsMN7pC8k', '0kIyUu', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (288, 'Jennette', 'Schneidar', 'https://robohash.org/veniamvoluptasdolore.png?size=50x50&set=set1', 'jschneidar7z@unicef.org', '548-703-9891', 'jschneidar7z', 'EIlgVzWuGS', 'ERs4BBALGSf', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (289, 'Hermione', 'Maydway', 'https://robohash.org/autemmaximeillum.bmp?size=50x50&set=set1', 'hmaydway80@slashdot.org', '390-634-3396', 'hmaydway80', 'vrpt1vltf', 'SKt4o8OFW', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (290, 'Dionne', 'MacCheyne', 'https://robohash.org/suscipitdebitisaut.bmp?size=50x50&set=set1', 'dmaccheyne81@gravatar.com', '946-925-9504', 'dmaccheyne81', 'TAXmflo6jW', 'zYiZxZY4NJd', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (291, 'Fanchon', 'Marciskewski', 'https://robohash.org/errorutcupiditate.png?size=50x50&set=set1', 'fmarciskewski82@wired.com', '186-908-5550', 'fmarciskewski82', 'Q9AWjtD7SMkU', 'HfGI6HK', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (292, 'Aleksandr', 'Girogetti', 'https://robohash.org/modisitet.jpg?size=50x50&set=set1', 'agirogetti83@amazon.co.jp', '777-910-3003', 'agirogetti83', 'NvHB3v', 'YzQKLFoqd', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (293, 'Thomasa', 'Dreng', 'https://robohash.org/officiamolestiasveniam.png?size=50x50&set=set1', 'tdreng84@washington.edu', '941-737-2658', 'tdreng84', 'K0MWjK8N', '8kgywaO', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (294, 'Helene', 'Alvares', 'https://robohash.org/beataeatsaepe.bmp?size=50x50&set=set1', 'halvares85@foxnews.com', '251-122-7665', 'halvares85', '2qt6wxrgS', 'kwWIBe3L', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (295, 'Alisun', 'Strangwood', 'https://robohash.org/quamdelenitisaepe.png?size=50x50&set=set1', 'astrangwood86@photobucket.com', '428-247-7450', 'astrangwood86', 'hEvn9q7Ay6', 'IutxfliPRpJT', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (296, 'Katherine', 'Maseres', 'https://robohash.org/officiaestimpedit.bmp?size=50x50&set=set1', 'kmaseres87@fda.gov', '509-147-4972', 'kmaseres87', 'fhz5FX', 'l3wZxYla1', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (297, 'Levon', 'Lorden', 'https://robohash.org/placeatdebitisfacere.bmp?size=50x50&set=set1', 'llorden88@multiply.com', '469-743-5509', 'llorden88', 'yr3hQhpFTy', 'HGzSoB1BO', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (298, 'Mikael', 'Poulgreen', 'https://robohash.org/quinostrummolestiae.png?size=50x50&set=set1', 'mpoulgreen89@dailymotion.com', '388-728-3456', 'mpoulgreen89', 'I6v8nr', 'a0F6kBS', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (299, 'Bernelle', 'Menguy', 'https://robohash.org/hicanimiquos.bmp?size=50x50&set=set1', 'bmenguy8a@hexun.com', '435-512-6780', 'bmenguy8a', 'TsNu10qoJd', 'LKmBzv9TqNM8', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (300, 'Fidole', 'Inglesent', 'https://robohash.org/sedvelbeatae.bmp?size=50x50&set=set1', 'finglesent8b@drupal.org', '814-774-1553', 'finglesent8b', 'Kj1osdORWd', 'XIFAXO', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (301, 'Nikaniki', 'Leyre', 'https://robohash.org/placeatlaboreipsum.bmp?size=50x50&set=set1', 'nleyre8c@elpais.com', '603-271-0064', 'nleyre8c', 'bx0PGvdbR', '1we76tvf', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (302, 'Ameline', 'Swoffer', 'https://robohash.org/autinarchitecto.bmp?size=50x50&set=set1', 'aswoffer8d@chicagotribune.com', '280-500-3767', 'aswoffer8d', 'pkaEieWVYCM', 'ENHw3qr7nhg', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (303, 'Florian', 'Gioani', 'https://robohash.org/distinctioeumpossimus.png?size=50x50&set=set1', 'fgioani8e@mit.edu', '329-601-2020', 'fgioani8e', 'obiuUEAHSb', 'UCMAPKdNg', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (304, 'Nobe', 'Thornally', 'https://robohash.org/facerequibusdamdistinctio.png?size=50x50&set=set1', 'nthornally8f@netscape.com', '417-636-8328', 'nthornally8f', 'wf7CqRg6Arf', 'ssBlcjlL', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (305, 'Rory', 'Kirtlan', 'https://robohash.org/quodteneturquidem.png?size=50x50&set=set1', 'rkirtlan8g@mediafire.com', '231-567-6869', 'rkirtlan8g', 'PmkpEwZTHV', 'K0lfnPB1bXHM', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (306, 'Nelson', 'Fronks', 'https://robohash.org/totamquivoluptatem.jpg?size=50x50&set=set1', 'nfronks8h@rakuten.co.jp', '874-626-0320', 'nfronks8h', 'fv6FDq7d', '7GVcHE', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (307, 'Audrye', 'Tenniswood', 'https://robohash.org/quidolorumrepudiandae.bmp?size=50x50&set=set1', 'atenniswood8i@discuz.net', '338-676-5059', 'atenniswood8i', 'BvkJuZW', 'vLzix1Rnuf7N', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (308, 'Etan', 'Rickards', 'https://robohash.org/voluptatemexpeditanihil.png?size=50x50&set=set1', 'erickards8j@state.gov', '841-253-2103', 'erickards8j', 'pWCEfor', '2Zf93PEOqp', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (309, 'Lola', 'Vondra', 'https://robohash.org/sintculpavoluptatibus.bmp?size=50x50&set=set1', 'lvondra8k@acquirethisname.com', '106-630-8065', 'lvondra8k', 'Cp64xLFO', 'c0IV40a', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (310, 'Mallory', 'Kalberer', 'https://robohash.org/utinventoreullam.jpg?size=50x50&set=set1', 'mkalberer8l@craigslist.org', '529-946-1080', 'mkalberer8l', 'SsZ3VoanI', '1mjcKoF7JGa', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (311, 'Kennett', 'Schofield', 'https://robohash.org/veritatisnostrumomnis.bmp?size=50x50&set=set1', 'kschofield8m@macromedia.com', '381-793-1216', 'kschofield8m', 'HlrS5BqTu', 'OdRQDpAPuGZ7', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (312, 'Michelle', 'Kingdon', 'https://robohash.org/estestea.png?size=50x50&set=set1', 'mkingdon8n@ibm.com', '208-354-5405', 'mkingdon8n', 'KvqO8Vkq5Hh', '7GWSwS', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (313, 'Gena', 'Armsden', 'https://robohash.org/omnisnonquaerat.jpg?size=50x50&set=set1', 'garmsden8o@bandcamp.com', '598-143-3551', 'garmsden8o', 'ASQVOLusp1q', 'dQJvYCYzDz', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (314, 'Quincey', 'Hellens', 'https://robohash.org/minusetlibero.png?size=50x50&set=set1', 'qhellens8p@squarespace.com', '857-452-3861', 'qhellens8p', 'euM9jPif5ds', 'l4h6OAC6mY', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (315, 'Orren', 'Carlisle', 'https://robohash.org/seddoloresint.bmp?size=50x50&set=set1', 'ocarlisle8q@umn.edu', '178-364-0074', 'ocarlisle8q', 'loK4gLtxH', 'pPoY66E', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (316, 'Germaine', 'Siene', 'https://robohash.org/sintdoloremreprehenderit.jpg?size=50x50&set=set1', 'gsiene8r@gov.uk', '662-716-9308', 'gsiene8r', 'j3l6sp', '9vbufl', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (317, 'Boy', 'Etheredge', 'https://robohash.org/veniamvoluptatemconsectetur.jpg?size=50x50&set=set1', 'betheredge8s@t-online.de', '173-804-6238', 'betheredge8s', '9yHWIjCFcCb9', 'Hnan3bwj8uv', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (318, 'Rebekah', 'Stit', 'https://robohash.org/exercitationemestdolor.jpg?size=50x50&set=set1', 'rstit8t@123-reg.co.uk', '651-233-1257', 'rstit8t', 'ZS5Xlf', 'cmMkfnENr', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (319, 'Kevyn', 'Leonida', 'https://robohash.org/quidemexpeditaillo.png?size=50x50&set=set1', 'kleonida8u@europa.eu', '659-503-6701', 'kleonida8u', 'jVqlj45Z2', 'bgImHzSfjY', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (320, 'Conrado', 'Montague', 'https://robohash.org/porroquiquia.jpg?size=50x50&set=set1', 'cmontague8v@admin.ch', '460-351-3570', 'cmontague8v', 'WHw5Di6kg', 'eoJp3f7NyMFz', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (321, 'Nola', 'Jolliffe', 'https://robohash.org/aomnistenetur.bmp?size=50x50&set=set1', 'njolliffe8w@apache.org', '283-668-2910', 'njolliffe8w', 'nMtFrG', 'v5pr5rwIo2v', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (322, 'Tremain', 'Sissland', 'https://robohash.org/animiconsequunturmolestiae.jpg?size=50x50&set=set1', 'tsissland8x@biglobe.ne.jp', '414-334-2531', 'tsissland8x', 'keW9xckA', 'cNTHHAyL', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (323, 'Fairlie', 'Minero', 'https://robohash.org/mollitialaboriosameum.jpg?size=50x50&set=set1', 'fminero8y@apache.org', '832-814-1339', 'fminero8y', 'VVMzgg9u6', '6xLGENBTjh', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (324, 'Barthel', 'Penman', 'https://robohash.org/repellendusetvoluptatem.bmp?size=50x50&set=set1', 'bpenman8z@dagondesign.com', '114-582-9525', 'bpenman8z', 'fkNOXr', 'lcK4rTeJ', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (325, 'Corina', 'Simpkiss', 'https://robohash.org/errorquitenetur.jpg?size=50x50&set=set1', 'csimpkiss90@sbwire.com', '456-740-6054', 'csimpkiss90', 'r1ZdALyX', 'fQTp9imS2', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (326, 'Druci', 'Struthers', 'https://robohash.org/verodoloremipsa.jpg?size=50x50&set=set1', 'dstruthers91@samsung.com', '152-440-5348', 'dstruthers91', 's4xygrRg5q', 'UbMnoLM', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (327, 'Mahala', 'Crossingham', 'https://robohash.org/nihilquominima.png?size=50x50&set=set1', 'mcrossingham92@mozilla.org', '432-883-1703', 'mcrossingham92', 'uFZR4ZdM6', 'i4RLzC', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (328, 'Sybilla', 'Cankett', 'https://robohash.org/dictaabcupiditate.png?size=50x50&set=set1', 'scankett93@usa.gov', '323-415-1889', 'scankett93', 'ikdPojkXtw', '8hzYihonhS', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (329, 'Douglass', 'Hessing', 'https://robohash.org/architectoillumsunt.jpg?size=50x50&set=set1', 'dhessing94@unc.edu', '296-215-3056', 'dhessing94', 'mWZHo7SQEw', 'm8D33MOH9O', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (330, 'Florida', 'MacGuffog', 'https://robohash.org/nostrumnesciuntquia.jpg?size=50x50&set=set1', 'fmacguffog95@europa.eu', '652-787-1931', 'fmacguffog95', 'XaVgR7E22wd', 'HD9mkklrnAm', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (331, 'Boone', 'Stonall', 'https://robohash.org/voluptasundequisquam.jpg?size=50x50&set=set1', 'bstonall96@prlog.org', '207-788-8459', 'bstonall96', 'WyEyR9', '0CEeWTq', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (332, 'Herta', 'Hayth', 'https://robohash.org/ducimustemporeodio.jpg?size=50x50&set=set1', 'hhayth97@prnewswire.com', '987-175-0279', 'hhayth97', 'JsRFIb6kmDSo', 'M8EAzE6', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (333, 'Justen', 'Caiger', 'https://robohash.org/aliquiddoloribusaut.png?size=50x50&set=set1', 'jcaiger98@theatlantic.com', '773-682-5236', 'jcaiger98', '7exiSWi', 'izpSi4vQ8a', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (334, 'Hamnet', 'Themann', 'https://robohash.org/quasoptiovelit.bmp?size=50x50&set=set1', 'hthemann99@homestead.com', '687-931-8281', 'hthemann99', 'LcW8aO', '3KmYALEN', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (335, 'Giulio', 'Rhead', 'https://robohash.org/nontemporeplaceat.bmp?size=50x50&set=set1', 'grhead9a@sakura.ne.jp', '562-327-5745', 'grhead9a', 'RZ0Y2iP2N0', 'cysotJ5jQU5', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (336, 'Dorene', 'O''Lahy', 'https://robohash.org/velitetitaque.bmp?size=50x50&set=set1', 'dolahy9b@npr.org', '327-337-3838', 'dolahy9b', 'XYeRA4DfA63', 'xauVm7xL', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (337, 'Austin', 'Brisson', 'https://robohash.org/nequeestvoluptatem.png?size=50x50&set=set1', 'abrisson9c@archive.org', '384-970-6073', 'abrisson9c', 'WmVn5Gu8w8S', '3FNOuvrC', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (338, 'Gabrielle', 'Ping', 'https://robohash.org/corporisreprehenderitiste.png?size=50x50&set=set1', 'gping9d@admin.ch', '644-834-0452', 'gping9d', 'XGJKIVg', 'rwTAKPkmE', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (339, 'Siana', 'de Savery', 'https://robohash.org/etsequiipsam.png?size=50x50&set=set1', 'sdesavery9e@independent.co.uk', '476-561-4713', 'sdesavery9e', 'At404Gw', 'UCMmHoEVlB63', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (340, 'Ruby', 'MacDunleavy', 'https://robohash.org/autestfugit.jpg?size=50x50&set=set1', 'rmacdunleavy9f@google.com.br', '956-356-7484', 'rmacdunleavy9f', 'GW0XoPnguX', 'ZkLsMMJhAR2', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (341, 'Tova', 'Rawkesby', 'https://robohash.org/delenitihicoccaecati.bmp?size=50x50&set=set1', 'trawkesby9g@lulu.com', '459-143-8790', 'trawkesby9g', 'LOmagYGk4ApV', 'c9yOOT', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (342, 'Katie', 'Menchenton', 'https://robohash.org/sedvoluptatumqui.bmp?size=50x50&set=set1', 'kmenchenton9h@ucoz.ru', '798-423-4527', 'kmenchenton9h', 'IB2yUQbWoGGT', 'M18sb3', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (343, 'Ed', 'Tyce', 'https://robohash.org/vellaboriosamtotam.bmp?size=50x50&set=set1', 'etyce9i@admin.ch', '345-621-1304', 'etyce9i', 'XoMVOgG', '2BePXC', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (344, 'Caresa', 'Penrose', 'https://robohash.org/magniveniamest.jpg?size=50x50&set=set1', 'cpenrose9j@alexa.com', '894-792-6228', 'cpenrose9j', 'K8ins0P', 'MQUEs5Z', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (345, 'Westbrooke', 'Blatherwick', 'https://robohash.org/rerumperspiciatisquis.png?size=50x50&set=set1', 'wblatherwick9k@netscape.com', '215-529-8819', 'wblatherwick9k', 'gWW3Zs4tbG', 'xBlo0izCP', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (346, 'Graig', 'Broske', 'https://robohash.org/undeistenecessitatibus.png?size=50x50&set=set1', 'gbroske9l@technorati.com', '445-645-9800', 'gbroske9l', 'qSeTZkm9khi0', 'VXZYLlJOGYLQ', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (347, 'Jilly', 'Maffi', 'https://robohash.org/quiaetut.png?size=50x50&set=set1', 'jmaffi9m@sbwire.com', '937-985-2403', 'jmaffi9m', 'lh1TgwNqb1x', '6QoUEYx7', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (348, 'Bruce', 'Hallstone', 'https://robohash.org/aperiamvoluptaseos.jpg?size=50x50&set=set1', 'bhallstone9n@google.co.uk', '525-209-9759', 'bhallstone9n', 'ocB8zTONYNC', 'zjhJz62s', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (349, 'Renaud', 'Bowdery', 'https://robohash.org/beataeillumet.png?size=50x50&set=set1', 'rbowdery9o@yellowbook.com', '890-763-9160', 'rbowdery9o', '6kQInDnHPsCc', '6KVNMxRLFo', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (350, 'Brandy', 'Reiners', 'https://robohash.org/etvoluptatibusvoluptates.bmp?size=50x50&set=set1', 'breiners9p@smugmug.com', '962-516-1774', 'breiners9p', 'eiC8f3L2NKKv', '34uL9Z4NFLSo', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (351, 'Demetra', 'Murrigan', 'https://robohash.org/natusfugitquo.bmp?size=50x50&set=set1', 'dmurrigan9q@samsung.com', '408-836-1335', 'dmurrigan9q', 'e2dDE1LTQF', 'QTARv7UwW', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (352, 'Felice', 'Bysh', 'https://robohash.org/fugaquosint.bmp?size=50x50&set=set1', 'fbysh9r@ocn.ne.jp', '192-196-7755', 'fbysh9r', 'uemScmMO', '6MFgG4KF', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (353, 'Nickie', 'Hegarty', 'https://robohash.org/natusearumsoluta.jpg?size=50x50&set=set1', 'nhegarty9s@netscape.com', '347-780-6912', 'nhegarty9s', 'W0SLpWI', 'Z3wP5P8NVDd', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (354, 'Clary', 'Tomowicz', 'https://robohash.org/quaslaborumdebitis.png?size=50x50&set=set1', 'ctomowicz9t@myspace.com', '615-362-6823', 'ctomowicz9t', 'zkvCKiT', 'h7pRTZ5ODO', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (355, 'Lay', 'Youster', 'https://robohash.org/autlaborumhic.bmp?size=50x50&set=set1', 'lyouster9u@blog.com', '913-888-5784', 'lyouster9u', 'OsMioviXXUpl', 'F4K7mzXpOB', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (356, 'Konstance', 'Grouen', 'https://robohash.org/dolorestemporeomnis.bmp?size=50x50&set=set1', 'kgrouen9v@e-recht24.de', '554-873-0786', 'kgrouen9v', 'iW3M53zYBvAX', 'FfGO7Z', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (357, 'Charyl', 'Gilli', 'https://robohash.org/excepturinihilvoluptas.jpg?size=50x50&set=set1', 'cgilli9w@rambler.ru', '622-776-8993', 'cgilli9w', 'cllhbao', '9Vq9BI09RB8f', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (358, 'Emili', 'Nappin', 'https://robohash.org/illorationepraesentium.bmp?size=50x50&set=set1', 'enappin9x@merriam-webster.com', '285-579-5057', 'enappin9x', '0NPrtkRA2nt', 'FdP7CCWj2', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (359, 'Tammy', 'Iannelli', 'https://robohash.org/estveniamqui.jpg?size=50x50&set=set1', 'tiannelli9y@jimdo.com', '814-296-0713', 'tiannelli9y', 'Q7cXrXPVJe', 'hTRYv6hdyko6', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (360, 'Leontyne', 'Ayton', 'https://robohash.org/enimautquisquam.bmp?size=50x50&set=set1', 'layton9z@gnu.org', '153-149-6303', 'layton9z', 'PvGGBX3X5X3', 'lj14PPh', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (361, 'Cosmo', 'Tiptaft', 'https://robohash.org/doloresquismolestiae.png?size=50x50&set=set1', 'ctiptafta0@un.org', '993-363-8910', 'ctiptafta0', 'BIc2OWQpiKu', 'S849H98nasg', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (362, 'Esma', 'Origan', 'https://robohash.org/quibusdamvoluptatemeveniet.bmp?size=50x50&set=set1', 'eorigana1@chronoengine.com', '317-533-4716', 'eorigana1', 'Dtk0tBD1', 'G7KvPjvu', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (363, 'Aubrey', 'Gillice', 'https://robohash.org/temporaconsecteturrerum.bmp?size=50x50&set=set1', 'agillicea2@techcrunch.com', '461-760-9819', 'agillicea2', 'niSjKvYNm', 'wsiXAZ9SZ8Z', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (364, 'Buck', 'Sposito', 'https://robohash.org/rerumexcepturinemo.bmp?size=50x50&set=set1', 'bspositoa3@jalbum.net', '786-674-0748', 'bspositoa3', 'Mvuq5y7Kr', '7ySkOn', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (365, 'Dannel', 'Fitton', 'https://robohash.org/similiquequiquidem.png?size=50x50&set=set1', 'dfittona4@mapy.cz', '486-264-7787', 'dfittona4', 'zQG2ZH0RcWS', '9kpd0AXE9EjX', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (366, 'Carter', 'Satteford', 'https://robohash.org/facilissitminus.jpg?size=50x50&set=set1', 'csatteforda5@t-online.de', '586-901-9100', 'csatteforda5', 'gjCRbcUX', '0NqOU1bT', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (367, 'Osbourn', 'Christoffersen', 'https://robohash.org/rerumaiusto.png?size=50x50&set=set1', 'ochristoffersena6@scribd.com', '593-287-8141', 'ochristoffersena6', 'fkcdoHtwAYf', 'XnvsCWstBi', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (368, 'Dunstan', 'Addicote', 'https://robohash.org/dolorumquisquamfacere.png?size=50x50&set=set1', 'daddicotea7@weebly.com', '776-409-8534', 'daddicotea7', '6QNUBGqYsKLj', 'XWdwtY3', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (369, 'Isaiah', 'Knudsen', 'https://robohash.org/animiinciduntdeleniti.png?size=50x50&set=set1', 'iknudsena8@google.de', '459-178-8109', 'iknudsena8', 'pckLb7bf3', 'lWMC9lf6', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (370, 'Claiborn', 'Edbrooke', 'https://robohash.org/estmagnamsed.jpg?size=50x50&set=set1', 'cedbrookea9@usda.gov', '170-757-9765', 'cedbrookea9', 'eya2XbZxIS1e', '3QWBtSLB0', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (371, 'Foss', 'Whalley', 'https://robohash.org/infaciliscum.bmp?size=50x50&set=set1', 'fwhalleyaa@comcast.net', '811-916-0085', 'fwhalleyaa', 'PNyTOjrtA1', 'deKXUMG5O', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (372, 'Paige', 'McGlade', 'https://robohash.org/totamquoqui.jpg?size=50x50&set=set1', 'pmcgladeab@surveymonkey.com', '217-923-4391', 'pmcgladeab', 'rgFyVp7Ryw', 'i7UPHrzo', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (373, 'Alberik', 'Alstead', 'https://robohash.org/suntetoptio.bmp?size=50x50&set=set1', 'aalsteadac@dailymotion.com', '938-493-7082', 'aalsteadac', 'JoialwHQwH', 'sO68hoTsOr', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (374, 'Corey', 'Moizer', 'https://robohash.org/esteumsoluta.png?size=50x50&set=set1', 'cmoizerad@blogger.com', '912-263-0889', 'cmoizerad', 'hfNefoWzH', 'GWfOzzq5Do', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (375, 'Niles', 'Lean', 'https://robohash.org/teneturhicnostrum.png?size=50x50&set=set1', 'nleanae@wikimedia.org', '960-278-4775', 'nleanae', 'v9oM3e', 'AtzLj9n4nE', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (376, 'Imelda', 'Handling', 'https://robohash.org/quiaaccusantiumdolorem.bmp?size=50x50&set=set1', 'ihandlingaf@dropbox.com', '636-878-4334', 'ihandlingaf', 'NiU5Hg3U', 'VKhIvsjWXS', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (377, 'Yettie', 'Skeldon', 'https://robohash.org/recusandaequilaudantium.jpg?size=50x50&set=set1', 'yskeldonag@about.me', '147-481-4572', 'yskeldonag', 'jTWlOkR0Kz4', 'DjPMqRZL', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (378, 'Hetti', 'Rundall', 'https://robohash.org/similiquenostrummolestiae.jpg?size=50x50&set=set1', 'hrundallah@acquirethisname.com', '209-117-3889', 'hrundallah', 'BEAKx6ES0d', 'Nok3J481SaP', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (379, 'Cherry', 'Suttell', 'https://robohash.org/quoidfugiat.jpg?size=50x50&set=set1', 'csuttellai@spiegel.de', '258-256-2167', 'csuttellai', 'LmADbDQ', '34bk9rR1', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (380, 'Bunni', 'Morford', 'https://robohash.org/idofficiamolestiae.jpg?size=50x50&set=set1', 'bmorfordaj@prlog.org', '715-524-8290', 'bmorfordaj', 'uiodYY3dra', 'K1iGd5x2', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (381, 'Jeanine', 'Instock', 'https://robohash.org/officiisdoloremdolores.png?size=50x50&set=set1', 'jinstockak@phoca.cz', '544-672-4473', 'jinstockak', 'B8fNb13DND', 'nh3Cr6', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (382, 'Valaree', 'Gartrell', 'https://robohash.org/etestmagnam.bmp?size=50x50&set=set1', 'vgartrellal@wix.com', '850-932-2105', 'vgartrellal', 'ac6vrSzaaq', 'YVAou2', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (383, 'Catlaina', 'Kincaid', 'https://robohash.org/quiquibusdamquam.jpg?size=50x50&set=set1', 'ckincaidam@a8.net', '486-926-7792', 'ckincaidam', 'SQH1GNKZG', 'lKkP5H', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (384, 'Townie', 'Livesley', 'https://robohash.org/doloresrationeut.png?size=50x50&set=set1', 'tlivesleyan@foxnews.com', '648-171-0465', 'tlivesleyan', 'JTgIr7N', 'q9bagW', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (385, 'Kyrstin', 'Stanger', 'https://robohash.org/istenequevoluptatum.bmp?size=50x50&set=set1', 'kstangerao@bloomberg.com', '392-770-5378', 'kstangerao', 'lkSsTXHpow', 'fi41UtdcDRlB', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (386, 'Chiquita', 'Swindin', 'https://robohash.org/eumofficiacorrupti.jpg?size=50x50&set=set1', 'cswindinap@netlog.com', '448-259-2752', 'cswindinap', 'RZHdg8sskf', 'vEl4L96', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (387, 'Alvis', 'Gulleford', 'https://robohash.org/ipsaminusnon.png?size=50x50&set=set1', 'agullefordaq@last.fm', '680-255-7164', 'agullefordaq', 'zV23lzPByrP', '3ieD0H', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (388, 'Zack', 'Cherry', 'https://robohash.org/velfaciliseos.png?size=50x50&set=set1', 'zcherryar@seattletimes.com', '347-881-1230', 'zcherryar', 'bKOdFHVxCD', 'oU15q5p', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (389, 'Beatriz', 'Laws', 'https://robohash.org/undeametnulla.png?size=50x50&set=set1', 'blawsas@fc2.com', '305-993-0039', 'blawsas', 'EJVEJQBsAx1H', 'V2vojy', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (390, 'Raimondo', 'Greenroad', 'https://robohash.org/eaautperferendis.bmp?size=50x50&set=set1', 'rgreenroadat@netvibes.com', '570-286-6980', 'rgreenroadat', 'SMLgMMLu4XE', 'RZNkEHG', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (391, 'Skye', 'Jullian', 'https://robohash.org/suscipitautcorporis.jpg?size=50x50&set=set1', 'sjullianau@google.com.br', '780-793-5383', 'sjullianau', 'U3tt9EZT', 'K2wctF', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (392, 'Anjanette', 'Barkworth', 'https://robohash.org/etestdolor.png?size=50x50&set=set1', 'abarkworthav@trellian.com', '684-488-6179', 'abarkworthav', 'lZI8mZyqhCd', 'ura3VDSH', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (393, 'Rowan', 'Vandenhoff', 'https://robohash.org/culpaaliquidsequi.bmp?size=50x50&set=set1', 'rvandenhoffaw@apache.org', '506-304-3393', 'rvandenhoffaw', 'HNAHu0', 'lrIKtUCQdN23', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (394, 'Syd', 'Bushen', 'https://robohash.org/autnonet.jpg?size=50x50&set=set1', 'sbushenax@seattletimes.com', '122-963-8179', 'sbushenax', 'cA3mJtEYcE', 'Otck5m24b', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (395, 'Iain', 'Brann', 'https://robohash.org/omnisvelitaut.jpg?size=50x50&set=set1', 'ibrannay@discovery.com', '242-149-6429', 'ibrannay', 'OH8TMdPBbON', '3FsEPS5LRi', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (396, 'Rosie', 'O''Ruane', 'https://robohash.org/laboriosamblanditiisfacilis.jpg?size=50x50&set=set1', 'roruaneaz@youku.com', '913-675-0525', 'roruaneaz', 'tuLLAYvPfVW', '9FtbRK9e7F', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (397, 'Dov', 'Leyden', 'https://robohash.org/eosestqui.bmp?size=50x50&set=set1', 'dleydenb0@un.org', '887-928-6481', 'dleydenb0', 'osVdZnYN', 'Vo8ejG73Of', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (398, 'Gabby', 'Gatecliffe', 'https://robohash.org/innobisreiciendis.bmp?size=50x50&set=set1', 'ggatecliffeb1@netvibes.com', '127-964-6118', 'ggatecliffeb1', 'bSvU7FkB3', 'VScdo9B1', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (399, 'Lottie', 'Bordis', 'https://robohash.org/oditnamet.jpg?size=50x50&set=set1', 'lbordisb2@e-recht24.de', '558-170-5019', 'lbordisb2', 'cJxaCt', 'OMAj1eXi', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (400, 'Mallory', 'Crum', 'https://robohash.org/numquamdoloremrerum.jpg?size=50x50&set=set1', 'mcrumb3@amazon.co.jp', '485-882-8164', 'mcrumb3', 'xJjGCkF', '9GIsBSPg', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (401, 'Diena', 'Cobden', 'https://robohash.org/officiisconsequunturcumque.png?size=50x50&set=set1', 'dcobdenb4@flickr.com', '233-615-8574', 'dcobdenb4', 'TCZhG2rTqweL', 'LU9T9veu', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (402, 'Jenna', 'Blackeby', 'https://robohash.org/aliquamveleos.png?size=50x50&set=set1', 'jblackebyb5@geocities.com', '136-160-4165', 'jblackebyb5', 'JGQAWhrk', '9lvwe4tkg', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (403, 'Marquita', 'Capron', 'https://robohash.org/remlaborevoluptas.png?size=50x50&set=set1', 'mcapronb6@biblegateway.com', '766-322-9942', 'mcapronb6', '5H5nDbpp', 'DC0z5g1d5', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (404, 'Kimball', 'Cordle', 'https://robohash.org/earummodirepudiandae.bmp?size=50x50&set=set1', 'kcordleb7@godaddy.com', '340-511-4882', 'kcordleb7', 'TmGyPbnk', 'TrSYFZCm', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (405, 'Tibold', 'Sharphouse', 'https://robohash.org/uttemporaquidem.jpg?size=50x50&set=set1', 'tsharphouseb8@wordpress.org', '740-803-8409', 'tsharphouseb8', 'TTV2kS', '7wNnISHTlo', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (406, 'Annemarie', 'Balma', 'https://robohash.org/adipisciquodperspiciatis.jpg?size=50x50&set=set1', 'abalmab9@go.com', '491-525-7961', 'abalmab9', 'YFDI3gmT8j', 'rqKGJqiw041', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (407, 'Killian', 'Neilan', 'https://robohash.org/blanditiisautemquaerat.png?size=50x50&set=set1', 'kneilanba@irs.gov', '781-625-0294', 'kneilanba', 'LA2dC4g', '7SG3GR1ec', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (408, 'Silvie', 'Brendeke', 'https://robohash.org/solutaremaut.jpg?size=50x50&set=set1', 'sbrendekebb@hc360.com', '123-249-5831', 'sbrendekebb', 'DOP3ps4S0qF', 'fDP1SCnnQp', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (409, 'Anastasie', 'Cudiff', 'https://robohash.org/nihilaperiamlibero.bmp?size=50x50&set=set1', 'acudiffbc@statcounter.com', '310-918-6927', 'acudiffbc', 'kIeHgL', 'LPBvPrALpas', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (410, 'Dev', 'Barendtsen', 'https://robohash.org/voluptatemvoluptassed.jpg?size=50x50&set=set1', 'dbarendtsenbd@about.com', '760-288-3604', 'dbarendtsenbd', 'jKsYW5F0dD', 'kvSsdoqp5', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (411, 'Amandi', 'Kelloch', 'https://robohash.org/nonautdolorem.png?size=50x50&set=set1', 'akellochbe@apple.com', '242-821-0919', 'akellochbe', 'Rt8U0q8r', 'tkbeaDo', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (412, 'Hamilton', 'Luckham', 'https://robohash.org/laborumutconsequatur.bmp?size=50x50&set=set1', 'hluckhambf@digg.com', '998-771-9915', 'hluckhambf', 'BgbNMBtd', '10PlLYjV', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (413, 'Marilin', 'Fairbourne', 'https://robohash.org/velitearumdignissimos.bmp?size=50x50&set=set1', 'mfairbournebg@canalblog.com', '573-456-7765', 'mfairbournebg', 'Yu6NMHC4CQ', 'gx9nZ43x', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (414, 'Garvy', 'Niess', 'https://robohash.org/quoutquos.bmp?size=50x50&set=set1', 'gniessbh@state.gov', '249-842-4525', 'gniessbh', '7YJFrmxhT47b', '0TCizzoyRK2J', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (415, 'Bobina', 'Ouver', 'https://robohash.org/numquamipsumfugit.jpg?size=50x50&set=set1', 'bouverbi@vkontakte.ru', '953-526-0840', 'bouverbi', 'Vykeg0O', 'xziRce', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (416, 'Any', 'Bleeze', 'https://robohash.org/remnonincidunt.bmp?size=50x50&set=set1', 'ableezebj@vinaora.com', '271-149-9350', 'ableezebj', 'vWVIg586rxW0', 'OdFjeZ', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (417, 'Zach', 'Halsted', 'https://robohash.org/quaeratiddicta.jpg?size=50x50&set=set1', 'zhalstedbk@typepad.com', '554-552-1514', 'zhalstedbk', 'w9mDCbJ2', 'kvLzWMNZksLT', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (418, 'Charleen', 'Aslin', 'https://robohash.org/quiabeataequia.png?size=50x50&set=set1', 'caslinbl@cnbc.com', '651-280-4112', 'caslinbl', '2Umvf20kZ7u', '2TqZm852LG', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (419, 'Kelli', 'Leeming', 'https://robohash.org/utodionihil.png?size=50x50&set=set1', 'kleemingbm@cnet.com', '586-510-7126', 'kleemingbm', 'C3XQttCnWjC', 'U9dyODxy', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (420, 'Ed', 'Gligoraci', 'https://robohash.org/maximelaboreaccusantium.png?size=50x50&set=set1', 'egligoracibn@jalbum.net', '936-353-1026', 'egligoracibn', 'BKhLXFV', 'FPC3or3EuD5', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (421, 'Hogan', 'O'' Gara', 'https://robohash.org/cumquevelitet.png?size=50x50&set=set1', 'hogarabo@cargocollective.com', '295-428-0520', 'hogarabo', 'hwiZ6eQ2', '8wQqg8H', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (422, 'Shari', 'Kimblen', 'https://robohash.org/mollitiaporroeaque.jpg?size=50x50&set=set1', 'skimblenbp@youku.com', '367-667-1571', 'skimblenbp', 'G1KMSyFqxL', 'jEHvDz1MI', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (423, 'Rudie', 'Brittian', 'https://robohash.org/oditetmaiores.png?size=50x50&set=set1', 'rbrittianbq@webnode.com', '463-635-8563', 'rbrittianbq', 'E3jrP6Jj', 'CFq5lCXJlb7X', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (424, 'Rhianon', 'Curreen', 'https://robohash.org/laborumaperiamodit.png?size=50x50&set=set1', 'rcurreenbr@purevolume.com', '202-174-4565', 'rcurreenbr', 'PI5PiLAwT', '22jhTqVkTNk', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (425, 'Vinnie', 'Pairpoint', 'https://robohash.org/atvelnihil.png?size=50x50&set=set1', 'vpairpointbs@wikispaces.com', '344-626-4299', 'vpairpointbs', 'HnzHTDuZMkO', 'Q6RrY79nen', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (426, 'Marissa', 'Hlavac', 'https://robohash.org/porromodiat.png?size=50x50&set=set1', 'mhlavacbt@harvard.edu', '225-902-0317', 'mhlavacbt', 'cyqiqXcZBs', 'PzJOHJ', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (427, 'Theodor', 'Sturrock', 'https://robohash.org/idquibusdamvoluptas.bmp?size=50x50&set=set1', 'tsturrockbu@cpanel.net', '929-871-9325', 'tsturrockbu', 'HHT4mD', 'he2U3FrRt', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (428, 'Belicia', 'Beadman', 'https://robohash.org/namitaqueautem.png?size=50x50&set=set1', 'bbeadmanbv@japanpost.jp', '564-194-4750', 'bbeadmanbv', 'SYgcqmw', '7a1i7A1Iolg', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (429, 'Oneida', 'Zeplin', 'https://robohash.org/quisolutafugiat.bmp?size=50x50&set=set1', 'ozeplinbw@mapquest.com', '164-636-6771', 'ozeplinbw', 'iiYKSzaYlZF', 'OWdMJsqMl', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (430, 'Emilee', 'Tredger', 'https://robohash.org/dolorumaperiamquod.png?size=50x50&set=set1', 'etredgerbx@webeden.co.uk', '591-339-4480', 'etredgerbx', 'oUWCOH8Na', 'Omx8E6PTDoY1', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (431, 'Jonis', 'Tinto', 'https://robohash.org/minimamolestiaeexplicabo.png?size=50x50&set=set1', 'jtintoby@nymag.com', '589-952-3537', 'jtintoby', 'GhRachIL', '8afYXhsYPZN', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (432, 'Tamra', 'Cartlidge', 'https://robohash.org/dolorvoluptatenihil.jpg?size=50x50&set=set1', 'tcartlidgebz@ning.com', '731-833-0013', 'tcartlidgebz', 'tlTRPY2A5BT', '5hCmXzQECzEO', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (433, 'Aubert', 'Rowlin', 'https://robohash.org/utesseullam.png?size=50x50&set=set1', 'arowlinc0@sun.com', '637-953-1738', 'arowlinc0', 'DjRAXrZBm0o', '6zOc2wJv', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (434, 'Hollie', 'Melbourne', 'https://robohash.org/consecteturdoloretempore.bmp?size=50x50&set=set1', 'hmelbournec1@deviantart.com', '513-646-9191', 'hmelbournec1', '09tzq276G', '0Usv1cbz1', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (435, 'Zandra', 'Ebbin', 'https://robohash.org/dolorasperioresdolorem.bmp?size=50x50&set=set1', 'zebbinc2@g.co', '593-639-1063', 'zebbinc2', 'NmoYxnc', 'ZbxOclet', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (436, 'Matthew', 'Skala', 'https://robohash.org/modinumquamaccusamus.jpg?size=50x50&set=set1', 'mskalac3@parallels.com', '328-723-2273', 'mskalac3', 'RltKl2Za', 'N2XsVkG1YW', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (437, 'Jameson', 'Andrews', 'https://robohash.org/modinisicorporis.png?size=50x50&set=set1', 'jandrewsc4@webnode.com', '885-504-3245', 'jandrewsc4', 'XI9HRwWWRjsb', '48Y2Qx', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (438, 'Starlene', 'Kynoch', 'https://robohash.org/necessitatibuscumqueratione.bmp?size=50x50&set=set1', 'skynochc5@etsy.com', '594-566-5918', 'skynochc5', 'sIIV2TXjiBZ', 'zW26FH0R', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (439, 'Gae', 'Silverman', 'https://robohash.org/minimaharumea.png?size=50x50&set=set1', 'gsilvermanc6@geocities.com', '813-887-5947', 'gsilvermanc6', 'dc89oU', 'V3VtzY6j', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (440, 'Vonni', 'Grabert', 'https://robohash.org/estutvoluptate.png?size=50x50&set=set1', 'vgrabertc7@cornell.edu', '419-247-8775', 'vgrabertc7', 'qWdnX8', 'Kii55bn', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (441, 'Darlene', 'Quirk', 'https://robohash.org/eiusautemquia.bmp?size=50x50&set=set1', 'dquirkc8@ed.gov', '983-644-4127', 'dquirkc8', 'DWODg8u', 'Z7osi2c', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (442, 'Devina', 'Farraway', 'https://robohash.org/sedvelquia.png?size=50x50&set=set1', 'dfarrawayc9@360.cn', '778-326-8718', 'dfarrawayc9', '2uMKA9Ap', 'DD7SrH', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (443, 'Veda', 'Bett', 'https://robohash.org/similiqueauteius.png?size=50x50&set=set1', 'vbettca@vistaprint.com', '318-983-7571', 'vbettca', 'o7MmVJTEQ0KA', 'EzmkMZHVPYNC', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (444, 'Meredeth', 'Crielly', 'https://robohash.org/idofficiaaut.bmp?size=50x50&set=set1', 'mcriellycb@live.com', '776-649-8216', 'mcriellycb', 'ZnwI8aUsQfa', '0P2bAD', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (445, 'Susannah', 'Heatlie', 'https://robohash.org/officiamaioresassumenda.png?size=50x50&set=set1', 'sheatliecc@github.io', '559-168-0074', 'sheatliecc', 'BwRQAU', 'ju60hiR29', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (446, 'Sophronia', 'Camacke', 'https://robohash.org/quieteaque.png?size=50x50&set=set1', 'scamackecd@webnode.com', '952-367-7992', 'scamackecd', 'YXiRE6vXuW', 'K0eebZ', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (447, 'Thaddus', 'Coplestone', 'https://robohash.org/corruptialiquamratione.bmp?size=50x50&set=set1', 'tcoplestonece@dell.com', '176-422-4488', 'tcoplestonece', 'JZjXaUejmM', 'TVfanv2FD6Q', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (448, 'Burt', 'Varey', 'https://robohash.org/exidquos.jpg?size=50x50&set=set1', 'bvareycf@about.com', '973-119-1043', 'bvareycf', 'Y3El3CBewOl', 'fG5VJAX8dLJm', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (449, 'Afton', 'Legonidec', 'https://robohash.org/autetdeserunt.png?size=50x50&set=set1', 'alegonideccg@fastcompany.com', '483-925-7701', 'alegonideccg', 'F3m0Zh', 'yiPSqE', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (450, 'Delmore', 'Slite', 'https://robohash.org/quiaetiure.bmp?size=50x50&set=set1', 'dslitech@bravesites.com', '764-289-6863', 'dslitech', 'S33AxnwzZM', 'JpC8lmJ7', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (451, 'Katerina', 'Tottle', 'https://robohash.org/omnisteneturexercitationem.bmp?size=50x50&set=set1', 'ktottleci@booking.com', '912-517-4046', 'ktottleci', 'ZYC8Jhno9', 'gkaMjO81VC', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (452, 'Marty', 'Ferreira', 'https://robohash.org/illumenimipsam.jpg?size=50x50&set=set1', 'mferreiracj@1und1.de', '931-760-7409', 'mferreiracj', 'jvbxw7Zt8oBQ', 'KISE7nXe', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (453, 'Arluene', 'MacAloren', 'https://robohash.org/quisquoquibusdam.bmp?size=50x50&set=set1', 'amacalorenck@ucoz.com', '987-306-3791', 'amacalorenck', 'w0F0JpUEwB', 'Y2wkYKz', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (454, 'Abbe', 'Macknish', 'https://robohash.org/blanditiisinrepellendus.png?size=50x50&set=set1', 'amacknishcl@go.com', '761-639-1542', 'amacknishcl', 'wEAtMnPJPi', 'ttAYYVK0', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (455, 'Darcee', 'O'' Finan', 'https://robohash.org/autquosquis.bmp?size=50x50&set=set1', 'dofinancm@yellowpages.com', '915-952-3282', 'dofinancm', 'Ct6ZK39dfflk', 'Jglqhh980E', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (456, 'Perry', 'Bedow', 'https://robohash.org/deseruntquaeratconsectetur.jpg?size=50x50&set=set1', 'pbedowcn@a8.net', '492-425-1397', 'pbedowcn', 'cKroFExVuoA', '8QMmKt3E2vn', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (457, 'Lee', 'Trimmell', 'https://robohash.org/beataeessevoluptatem.bmp?size=50x50&set=set1', 'ltrimmellco@nature.com', '978-306-5421', 'ltrimmellco', 'bagB8WVjk', 'YLMWxA2DwkXU', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (458, 'Magnum', 'Redmell', 'https://robohash.org/etvelitnumquam.jpg?size=50x50&set=set1', 'mredmellcp@miibeian.gov.cn', '343-587-4441', 'mredmellcp', 'L8wr09F', 'weOqCVCJE6', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (459, 'Brendis', 'McLardie', 'https://robohash.org/ipsametvoluptas.bmp?size=50x50&set=set1', 'bmclardiecq@godaddy.com', '779-957-4834', 'bmclardiecq', 'XeE9I6l', 'MjXnOP1U', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (460, 'Gwendolen', 'Bewly', 'https://robohash.org/omnisprovidentautem.bmp?size=50x50&set=set1', 'gbewlycr@bravesites.com', '526-277-2376', 'gbewlycr', 'hrB5yc3', 'BNeOLfk', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (461, 'Mabelle', 'Casement', 'https://robohash.org/voluptatempraesentiumea.jpg?size=50x50&set=set1', 'mcasementcs@theglobeandmail.com', '917-314-4393', 'mcasementcs', 'iMMB3z', 'dK9plMsR7zas', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (462, 'Alana', 'Worthington', 'https://robohash.org/velitetrepudiandae.bmp?size=50x50&set=set1', 'aworthingtonct@apple.com', '580-759-9419', 'aworthingtonct', '4GfJtFouih', 'WBrdAgpxo7', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (463, 'Tally', 'Danter', 'https://robohash.org/utconsequunturfacilis.bmp?size=50x50&set=set1', 'tdantercu@ow.ly', '714-409-4119', 'tdantercu', 'RuQ3p2Uwha1', '8wEnw31am9', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (464, 'Moritz', 'Buckler', 'https://robohash.org/voluptatumomnisdelectus.jpg?size=50x50&set=set1', 'mbucklercv@dyndns.org', '590-866-7384', 'mbucklercv', 'RsgswFjeG', 'W3hUA2j2N2q', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (465, 'Reine', 'Code', 'https://robohash.org/saepeeamagnam.png?size=50x50&set=set1', 'rcodecw@nba.com', '455-316-3584', 'rcodecw', 'GQYzlmgYBOAX', 'gf30aljfgy', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (466, 'Andrea', 'Dimitrijevic', 'https://robohash.org/facerelaborealiquid.png?size=50x50&set=set1', 'adimitrijeviccx@1und1.de', '935-749-2475', 'adimitrijeviccx', 'MDMqQr', 'xcEqvedDEiwY', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (467, 'Easter', 'Weymouth', 'https://robohash.org/consequaturlaborumet.bmp?size=50x50&set=set1', 'eweymouthcy@123-reg.co.uk', '235-862-0476', 'eweymouthcy', 'YcLtKgrDDi', 'leEBki', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (468, 'Verene', 'Yegorkov', 'https://robohash.org/remipsaet.bmp?size=50x50&set=set1', 'vyegorkovcz@slate.com', '959-838-2640', 'vyegorkovcz', '2xAaHw93nAf', '0eIfF8', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (469, 'Shay', 'Thorington', 'https://robohash.org/istedolorumautem.bmp?size=50x50&set=set1', 'sthoringtond0@slate.com', '867-178-1952', 'sthoringtond0', 'jnep8RQds', 'gCE7BsKONx', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (470, 'Corliss', 'Ruppelin', 'https://robohash.org/minusveritatissed.png?size=50x50&set=set1', 'cruppelind1@soup.io', '344-393-0104', 'cruppelind1', 'w9tBjdNCk', 'i9oMizJ0', 502, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (471, 'Wilfrid', 'Nairy', 'https://robohash.org/eosundeipsum.jpg?size=50x50&set=set1', 'wnairyd2@youtube.com', '768-548-7298', 'wnairyd2', 'YYHHKex', 'XByeiVL', 503, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (472, 'Stephi', 'Luscott', 'https://robohash.org/autemprovidentet.jpg?size=50x50&set=set1', 'sluscottd3@last.fm', '335-856-3280', 'sluscottd3', 'fbzWUENf4l', 'Vpq4RPRy', 504, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (473, 'Darwin', 'Bake', 'https://robohash.org/omnisenima.bmp?size=50x50&set=set1', 'dbaked4@jigsy.com', '353-201-9400', 'dbaked4', 'JFy72DKH0NCC', 'j1Z9K1rG6', 505, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (474, 'Sheri', 'Rackley', 'https://robohash.org/earumdoloreseum.bmp?size=50x50&set=set1', 'srackleyd5@narod.ru', '551-825-9137', 'srackleyd5', 'sGQZU7FJ', 'nM2HZC', 506, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (475, 'Gwenny', 'Eisak', 'https://robohash.org/sintutnostrum.png?size=50x50&set=set1', 'geisakd6@cornell.edu', '637-910-0914', 'geisakd6', 'A1yjbLe', 'ZG1b7VwxK', 501, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (476, 'Flynn', 'Allmen', 'https://robohash.org/sedvoluptasiusto.png?size=50x50&set=set1', 'fallmend7@wiley.com', '989-200-5800', 'fallmend7', 'SIF05AdyJx', 'djYbwBPRrY', 502, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (477, 'Gilly', 'Beevors', 'https://robohash.org/asuntrerum.png?size=50x50&set=set1', 'gbeevorsd8@about.me', '430-378-0345', 'gbeevorsd8', 'Y6P7PdH', 'MI0te1hJPu', 503, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (478, 'Stanwood', 'McChesney', 'https://robohash.org/utliberoaut.jpg?size=50x50&set=set1', 'smcchesneyd9@istockphoto.com', '398-733-5519', 'smcchesneyd9', 'isEqhQwXIUol', 's3s1xWPlXC', 504, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (479, 'Garrick', 'Ronaldson', 'https://robohash.org/remimpeditsit.jpg?size=50x50&set=set1', 'gronaldsonda@mtv.com', '498-291-6425', 'gronaldsonda', 'eVD7ql', 'By9QjsrXmIU', 505, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (480, 'Lauri', 'Firsby', 'https://robohash.org/quaesedveritatis.png?size=50x50&set=set1', 'lfirsbydb@msn.com', '219-328-6514', 'lfirsbydb', 'XPWRPW', 'ZCmSB6prJ3a', 506, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (481, 'Otto', 'Tewnion', 'https://robohash.org/consequunturautvoluptas.png?size=50x50&set=set1', 'otewniondc@xrea.com', '392-748-6234', 'otewniondc', 'BhioWlSaX7', 'NSoO5mgO', 501, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (482, 'Danice', 'Stanes', 'https://robohash.org/nihilutqui.jpg?size=50x50&set=set1', 'dstanesdd@topsy.com', '466-121-0780', 'dstanesdd', '4PCqmMF', 'GJdGpT7AKJz', 502, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (483, 'De', 'McSporon', 'https://robohash.org/illoeligendisit.jpg?size=50x50&set=set1', 'dmcsporonde@cdc.gov', '443-282-3469', 'dmcsporonde', 'z3riczTBWpVT', 'ZfWNR4f2RZo', 503, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (484, 'Meier', 'Waddie', 'https://robohash.org/officiisquiquis.png?size=50x50&set=set1', 'mwaddiedf@hao123.com', '462-605-7275', 'mwaddiedf', 'gXrHknwKg', 'FTOr4LkhHD', 504, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (485, 'Drucy', 'Buckenham', 'https://robohash.org/omnissolutalabore.bmp?size=50x50&set=set1', 'dbuckenhamdg@bizjournals.com', '347-162-0474', 'dbuckenhamdg', 'jver42yDU8u', 'y9Di77', 505, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (486, 'Larine', 'Leathlay', 'https://robohash.org/placeatdolorumitaque.jpg?size=50x50&set=set1', 'lleathlaydh@free.fr', '697-500-1269', 'lleathlaydh', 'xyTRI7FEre', 'Bo8ind0', 506, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (487, 'Tymon', 'Simao', 'https://robohash.org/delectusomnisoccaecati.jpg?size=50x50&set=set1', 'tsimaodi@google.cn', '734-739-9072', 'tsimaodi', 'Qfu6VWUJZl7', 'aM3JuB0', 501, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (488, 'Kevin', 'Cargo', 'https://robohash.org/nobisautemreprehenderit.png?size=50x50&set=set1', 'kcargodj@geocities.com', '445-316-8240', 'kcargodj', '9KkO6Ky1gzII', 'DxXPNAl', 502, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (489, 'Nita', 'Dubble', 'https://robohash.org/doloremsiteligendi.png?size=50x50&set=set1', 'ndubbledk@dropbox.com', '875-278-8314', 'ndubbledk', 'djKXaL51Kxl', 'SC5EvDkt', 503, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (490, 'Karisa', 'Tatchell', 'https://robohash.org/voluptatumeaautem.jpg?size=50x50&set=set1', 'ktatchelldl@1und1.de', '319-684-1698', 'ktatchelldl', 'VnrQ6qcJ', 'ZkHKi9G', 504, 710);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (491, 'Colby', 'Antognazzi', 'https://robohash.org/quidignissimoset.jpg?size=50x50&set=set1', 'cantognazzidm@abc.net.au', '731-476-4043', 'cantognazzidm', 'EAhx1VmVJ', 'x5JBTJ4', 505, 701);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (492, 'Anselm', 'Dormon', 'https://robohash.org/placeatnecessitatibusblanditiis.png?size=50x50&set=set1', 'adormondn@instagram.com', '247-202-2736', 'adormondn', 'YJDgwFzl', 'yMacZm', 506, 702);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (493, 'Gale', 'Alves', 'https://robohash.org/quisvitaeiure.bmp?size=50x50&set=set1', 'galvesdo@people.com.cn', '760-195-1605', 'galvesdo', 'ZrlGtmrsc', 'Rf6LaI1Jm', 501, 703);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (494, 'Margot', 'Roll', 'https://robohash.org/nemodoloremiste.jpg?size=50x50&set=set1', 'mrolldp@bing.com', '464-303-0563', 'mrolldp', '3GtWIENVI', '0oobbUxa', 502, 704);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (495, 'Natasha', 'Jacke', 'https://robohash.org/totamquiacupiditate.png?size=50x50&set=set1', 'njackedq@multiply.com', '787-744-1141', 'njackedq', 'VUTeqQKvtW', 'MNnd9x5IsUv', 503, 705);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (496, 'Delila', 'Flew', 'https://robohash.org/voluptasrerumatque.jpg?size=50x50&set=set1', 'dflewdr@seesaa.net', '836-633-1865', 'dflewdr', 'jSnW5rq675y', 'N5iU6iHTSHg', 504, 706);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (497, 'Waylin', 'Le Leu', 'https://robohash.org/sintsimiliquequis.png?size=50x50&set=set1', 'wleleuds@tripadvisor.com', '758-839-2150', 'wleleuds', 'hiwRg60916', 'uCCcKCddAbX', 505, 707);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (498, 'Jens', 'Spears', 'https://robohash.org/asperiorespossimusdignissimos.png?size=50x50&set=set1', 'jspearsdt@joomla.org', '129-197-6306', 'jspearsdt', 'NhqTgaVat9M', 'h8LGpQkgV', 506, 708);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (499, 'Jasmine', 'Aldren', 'https://robohash.org/doloremqueaniminatus.bmp?size=50x50&set=set1', 'jaldrendu@vistaprint.com', '954-446-1111', 'jaldrendu', 'mKmi2BstPCS9', '31FwiCNNdhk', 501, 709);
insert into CLIENTES (ID, NOMBRES , APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (500, 'Damara', 'Longea', 'https://robohash.org/quibusdamesselabore.bmp?size=50x50&set=set1', 'dlongeadv@alexa.com', '844-713-0468', 'dlongeadv', 'NRUFzM5d', 'Chvux4b', 502, 710);

--IDIOMAS

insert into IDIOMAS (ID, DESCRIPCION, ABREVIATURA) values (501, 'INGLES', 'ING');
insert into IDIOMAS (ID, DESCRIPCION, ABREVIATURA) values (502, 'ESPA?L', 'ESP');
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

insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (711, 'MEDELLIN', 1410, 641, 2400, '76240-000', 701);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (712, 'BOGOTA', 1301, 876, 2400, '48330-000', 702);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (713, 'NEW YORK', 1061, 799, 2400, '50251', 703);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (714, 'MIAMI', 1297, 670, 2400, null, 704);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (715, 'RIO DE JANEIRO', 1007, 895, 2400, '49082', 705);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (716, 'BRASILIA', 1314, 736, 2400, null, 706);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (717, 'PARIS', 1334, 821, 2400, '77381', 707);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (718, 'MONTPELLIER', 1178, 782, 2400, null, 708);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (719, 'BERLIN', 1463, 843, 2400, '87-821', 709);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (720, 'DORTMUND', 1249, 860, 2400, '393479', 710);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (721, 'MONTEVIDEO', 1311, 638, 2400, null, 701);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (722, 'PUNTA DEL ESTE', 1465, 847, 2400, '5610', 702);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (723, 'BUENOS AIRES', 1039, 688, 2400, '9201', 703);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (724, 'MENDOZA', 1090, 680, 2400, null, 704);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (725, 'TOKIO', 1129, 677, 2400, null, 705);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (726, 'OSAKA', 1221, 767, 2400, null, 706);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (727, 'ROMA', 1035, 716, 2400, '77-124', 707);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (728, 'MILAN', 1479, 885, 2400, '731027', 708);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (729, 'LISBOA', 1286, 824, 2400, null, 709);
insert into CIUDADES (ID, NOMBRE, VALOR_KILOMETRO, VALOR_POR_MINUTO, TARIFA_BASE, CODIGO_POSTAL, PAIS_ID) values (730, 'PORTO', 1200, 731, 2400, '722 33', 710);


--CONDUCTORES

SET DEFINE OFF
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (800, '58-267-6099', 'Emmalynne', 'Airdrie', 'https://robohash.org/consequunturdebitisvoluptatum.jpg?size=50x50&set=set1', 'eairdrie0@latimes.com', '510-194-3218', 501, 711);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (801, '81-408-0341', 'Juliet', 'Marples', 'https://robohash.org/aperiamquonobis.bmp?size=50x50&set=set1', 'jmarples1@smh.com.au', '880-494-9978', 502, 712);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (802, '79-765-8827', 'Gabriellia', 'Lindman', 'https://robohash.org/autofficiisid.png?size=50x50&set=set1', 'glindman2@washington.edu', '231-687-8244', 503, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (803, '71-849-7242', 'Jozef', 'Coulthard', 'https://robohash.org/eumautlibero.jpg?size=50x50&set=set1', 'jcoulthard3@twitpic.com', '321-372-8620', 504, 714);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (804, '43-730-9916', 'Nicoline', 'Swancott', 'https://robohash.org/autemestqui.bmp?size=50x50&set=set1', 'nswancott4@geocities.com', '135-115-8953', 505, 715);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (805, '11-554-0915', 'Gisela', 'Overpool', 'https://robohash.org/eumilloeaque.jpg?size=50x50&set=set1', 'goverpool5@oaic.gov.au', '637-724-0204', 506, 716);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (806, '62-538-2705', 'Chickie', 'Tinto', 'https://robohash.org/ipsamnumquamsed.bmp?size=50x50&set=set1', 'ctinto6@youku.com', '191-234-0802', 501, 717);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (807, '21-955-7360', 'Gwenora', 'Goodwyn', 'https://robohash.org/accusantiumquidemasperiores.bmp?size=50x50&set=set1', 'ggoodwyn7@vinaora.com', '763-451-1425', 502, 718);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (808, '81-281-0260', 'Hasty', 'Stapley', 'https://robohash.org/debitisaliquidsimilique.png?size=50x50&set=set1', 'hstapley8@ycombinator.com', '255-476-7356', 503, 719);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (809, '90-686-6310', 'Sophronia', 'Ierland', 'https://robohash.org/quasidoloreslaudantium.png?size=50x50&set=set1', 'sierland9@booking.com', '416-338-1207', 504, 720);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (810, '72-834-9749', 'Vale', 'Jobey', 'https://robohash.org/etomnisminus.jpg?size=50x50&set=set1', 'vjobeya@mozilla.org', '262-231-6391', 505, 721);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (811, '98-434-0179', 'Felipa', 'Lorkins', 'https://robohash.org/estetvoluptates.jpg?size=50x50&set=set1', 'florkinsb@ca.gov', '522-299-6995', 506, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (812, '92-893-7141', 'Obadiah', 'Washington', 'https://robohash.org/ipsamerrorullam.jpg?size=50x50&set=set1', 'owashingtonc@ning.com', '824-993-8287', 501, 723);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (813, '23-753-6750', 'Bettye', 'Kimmings', 'https://robohash.org/placeatsedpraesentium.jpg?size=50x50&set=set1', 'bkimmingsd@hibu.com', '119-153-6093', 502, 724);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (814, '08-037-6750', 'Gregorius', 'Tedorenko', 'https://robohash.org/explicaboeumet.jpg?size=50x50&set=set1', 'gtedorenkoe@google.com.br', '810-866-8970', 503, 725);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (815, '92-680-0971', 'Annamarie', 'Pabst', 'https://robohash.org/temporaquiminima.bmp?size=50x50&set=set1', 'apabstf@walmart.com', '946-274-5122', 504, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (816, '48-970-7880', 'Leonore', 'Hallan', 'https://robohash.org/culpateneturipsum.bmp?size=50x50&set=set1', 'lhallang@usda.gov', '194-997-6392', 505, 727);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (817, '41-444-0404', 'Dana', 'Gosdin', 'https://robohash.org/repellataliquidreiciendis.png?size=50x50&set=set1', 'dgosdinh@reverbnation.com', '833-882-4571', 506, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (818, '85-259-9608', 'Tomi', 'Van Halle', 'https://robohash.org/similiqueomnisprovident.bmp?size=50x50&set=set1', 'tvanhallei@nba.com', '699-875-5346', 501, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (819, '88-366-0508', 'Stan', 'Izacenko', 'https://robohash.org/inciduntmolestiaequia.bmp?size=50x50&set=set1', 'sizacenkoj@cdbaby.com', '278-936-9693', 502, 730);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (820, '52-763-7427', 'Evelina', 'Breese', 'https://robohash.org/utveroet.png?size=50x50&set=set1', 'ebreesek@cocolog-nifty.com', '844-165-1530', 503, 711);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (821, '62-532-9834', 'Leah', 'Schoenfisch', 'https://robohash.org/teneturnonut.png?size=50x50&set=set1', 'lschoenfischl@nhs.uk', '554-556-4030', 504, 712);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (822, '10-413-8969', 'Joyous', 'McFetridge', 'https://robohash.org/exestsimilique.png?size=50x50&set=set1', 'jmcfetridgem@ted.com', '590-365-3644', 505, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (823, '11-012-1556', 'Marlene', 'Sibbet', 'https://robohash.org/earumvitaequam.bmp?size=50x50&set=set1', 'msibbetn@marriott.com', '174-743-4271', 506, 714);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (824, '81-541-6719', 'Holmes', 'Sills', 'https://robohash.org/ullamoditeos.bmp?size=50x50&set=set1', 'hsillso@epa.gov', '891-322-1037', 501, 715);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (825, '95-321-5089', 'Hasheem', 'Schrinel', 'https://robohash.org/excepturinesciuntfugiat.jpg?size=50x50&set=set1', 'hschrinelp@jimdo.com', '166-748-4037', 502, 716);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (826, '64-878-3676', 'Arlette', 'Danieli', 'https://robohash.org/utaliquidcum.bmp?size=50x50&set=set1', 'adanieliq@hubpages.com', '250-609-7411', 503, 717);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (827, '62-443-7074', 'Thatch', 'Yearron', 'https://robohash.org/dolorquiexercitationem.png?size=50x50&set=set1', 'tyearronr@admin.ch', '158-675-2416', 504, 718);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (828, '67-665-3628', 'Gallard', 'Pymm', 'https://robohash.org/atqueveliteos.jpg?size=50x50&set=set1', 'gpymms@hc360.com', '889-926-7875', 505, 719);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (829, '00-228-7204', 'Riane', 'Niezen', 'https://robohash.org/doloremperspiciatishic.bmp?size=50x50&set=set1', 'rniezent@shareasale.com', '737-404-7461', 506, 720);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (830, '03-602-6109', 'Ana', 'Phythean', 'https://robohash.org/namvoluptatemest.bmp?size=50x50&set=set1', 'aphytheanu@creativecommons.org', '982-620-5361', 501, 721);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (831, '46-004-8681', 'Nolana', 'Heighton', 'https://robohash.org/etsitaut.png?size=50x50&set=set1', 'nheightonv@linkedin.com', '551-381-1628', 502, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (832, '50-946-4413', 'Aldo', 'Le Grice', 'https://robohash.org/veniamreprehenderiteum.jpg?size=50x50&set=set1', 'alegricew@skype.com', '598-315-0592', 503, 723);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (833, '60-517-4336', 'Tabbatha', 'Gilbart', 'https://robohash.org/quiautfugiat.png?size=50x50&set=set1', 'tgilbartx@jugem.jp', '362-688-4572', 504, 724);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (834, '06-094-9596', 'Merrielle', 'Bonny', 'https://robohash.org/maximefacerequam.bmp?size=50x50&set=set1', 'mbonnyy@drupal.org', '758-202-2177', 505, 725);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (835, '01-246-5018', 'Haley', 'Cuthill', 'https://robohash.org/voluptasdoloresqui.bmp?size=50x50&set=set1', 'hcuthillz@ibm.com', '614-262-9136', 506, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (836, '99-160-2580', 'Arleta', 'Pyper', 'https://robohash.org/adipiscidebitiseum.png?size=50x50&set=set1', 'apyper10@archive.org', '432-966-1387', 501, 727);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (837, '45-296-5301', 'Cart', 'Perfili', 'https://robohash.org/utpraesentiumab.bmp?size=50x50&set=set1', 'cperfili11@gravatar.com', '669-761-6125', 502, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (838, '83-600-8343', 'Basia', 'Coult', 'https://robohash.org/adipisciquisqui.png?size=50x50&set=set1', 'bcoult12@adobe.com', '424-788-1437', 503, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (839, '05-637-8643', 'Rebe', 'Giacomozzo', 'https://robohash.org/estaccusantiumexcepturi.bmp?size=50x50&set=set1', 'rgiacomozzo13@istockphoto.com', '610-293-2520', 504, 730);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (840, '15-514-8027', 'Luca', 'Heninghem', 'https://robohash.org/dolormolestiaelibero.jpg?size=50x50&set=set1', 'lheninghem14@fda.gov', '644-169-0118', 505, 711);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (841, '03-510-7526', 'Shae', 'Wanless', 'https://robohash.org/voluptasrerumiure.bmp?size=50x50&set=set1', 'swanless15@homestead.com', '113-809-9224', 506, 712);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (842, '53-304-4857', 'Noam', 'Heckle', 'https://robohash.org/architectoquoodit.png?size=50x50&set=set1', 'nheckle16@netscape.com', '580-941-6335', 501, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (843, '37-500-4399', 'Melodee', 'Kimbell', 'https://robohash.org/quodetvoluptatem.jpg?size=50x50&set=set1', 'mkimbell17@shop-pro.jp', '113-461-1836', 502, 714);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (844, '59-808-8421', 'Teddie', 'Stickley', 'https://robohash.org/autperferendisharum.bmp?size=50x50&set=set1', 'tstickley18@tinypic.com', '556-512-2982', 503, 715);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (845, '73-111-4746', 'Way', 'Voce', 'https://robohash.org/nequedolorsunt.jpg?size=50x50&set=set1', 'wvoce19@about.me', '397-632-3903', 504, 716);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (846, '17-436-8695', 'Alessandro', 'Rainy', 'https://robohash.org/nemoquiconsequuntur.bmp?size=50x50&set=set1', 'arainy1a@fc2.com', '828-867-5585', 505, 717);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (847, '43-119-0824', 'Byrle', 'Brood', 'https://robohash.org/etoptionobis.jpg?size=50x50&set=set1', 'bbrood1b@51.la', '108-175-1159', 506, 718);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (848, '16-095-3063', 'Shermy', 'Lelievre', 'https://robohash.org/impeditculpasunt.jpg?size=50x50&set=set1', 'slelievre1c@devhub.com', '695-697-7349', 501, 719);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (849, '19-607-1690', 'Magdaia', 'Millsom', 'https://robohash.org/voluptasdolorquisquam.png?size=50x50&set=set1', 'mmillsom1d@amazon.de', '235-658-4107', 502, 720);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (850, '21-358-8977', 'Joleen', 'Simkovitz', 'https://robohash.org/quiamollitiain.bmp?size=50x50&set=set1', 'jsimkovitz1e@4shared.com', '757-186-6121', 503, 721);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (851, '41-293-8922', 'Anthea', 'Benmore', 'https://robohash.org/magnametsed.bmp?size=50x50&set=set1', 'abenmore1f@shop-pro.jp', '834-579-9225', 504, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (852, '46-065-2453', 'Cyndia', 'Tilbey', 'https://robohash.org/inatnumquam.png?size=50x50&set=set1', 'ctilbey1g@walmart.com', '819-449-4079', 505, 723);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (853, '19-444-8362', 'Margery', 'Picken', 'https://robohash.org/undedoloremqueea.png?size=50x50&set=set1', 'mpicken1h@hatena.ne.jp', '664-712-5393', 506, 724);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (854, '29-969-3654', 'Rosella', 'Lohan', 'https://robohash.org/voluptatesomniset.jpg?size=50x50&set=set1', 'rlohan1i@berkeley.edu', '154-476-5254', 501, 725);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (855, '44-198-1929', 'Delly', 'Plummer', 'https://robohash.org/nesciuntsolutasint.png?size=50x50&set=set1', 'dplummer1j@hubpages.com', '972-694-6746', 502, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (856, '47-658-3493', 'Amy', 'Aldous', 'https://robohash.org/maximeuttempora.png?size=50x50&set=set1', 'aaldous1k@tuttocitta.it', '225-907-3022', 503, 727);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (857, '07-951-2172', 'Milzie', 'Di Frisco', 'https://robohash.org/sintbeataeblanditiis.jpg?size=50x50&set=set1', 'mdifrisco1l@infoseek.co.jp', '475-273-1266', 504, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (858, '62-991-7139', 'Roch', 'Venner', 'https://robohash.org/nihilutsint.bmp?size=50x50&set=set1', 'rvenner1m@admin.ch', '389-766-3771', 505, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (859, '29-313-5376', 'Cyril', 'Maken', 'https://robohash.org/quodsintaut.jpg?size=50x50&set=set1', 'cmaken1n@jiathis.com', '716-250-5727', 506, 730);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (860, '59-379-4886', 'Camille', 'Gramer', 'https://robohash.org/consecteturilloomnis.png?size=50x50&set=set1', 'cgramer1o@seesaa.net', '630-536-7971', 501, 711);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (861, '27-237-9699', 'Rahel', 'Codman', 'https://robohash.org/corporistemporahic.png?size=50x50&set=set1', 'rcodman1p@google.pl', '935-872-5703', 502, 712);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (862, '74-142-7994', 'Correy', 'Worvill', 'https://robohash.org/etquasillum.png?size=50x50&set=set1', 'cworvill1q@toplist.cz', '888-665-8206', 503, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (863, '64-974-9959', 'Gwennie', 'Shaudfurth', 'https://robohash.org/utducimuset.bmp?size=50x50&set=set1', 'gshaudfurth1r@theguardian.com', '456-758-6611', 504, 714);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (864, '44-009-3334', 'Winthrop', 'Goutcher', 'https://robohash.org/velitipsumvoluptatem.jpg?size=50x50&set=set1', 'wgoutcher1s@sphinn.com', '127-212-0219', 505, 715);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (865, '32-961-6128', 'Edita', 'Mac Giolla Pheadair', 'https://robohash.org/quaeratvoluptatemfugit.jpg?size=50x50&set=set1', 'emacgiollapheadair1t@typepad.com', '872-334-8333', 506, 716);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (866, '56-008-1138', 'Anderea', 'Seamer', 'https://robohash.org/omniseoshic.jpg?size=50x50&set=set1', 'aseamer1u@linkedin.com', '667-764-3466', 501, 717);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (867, '53-927-1233', 'Bamby', 'Heister', 'https://robohash.org/autemaspernaturunde.bmp?size=50x50&set=set1', 'bheister1v@ibm.com', '480-968-9047', 502, 718);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (868, '50-183-4486', 'Jody', 'Fotitt', 'https://robohash.org/idipsumdolores.bmp?size=50x50&set=set1', 'jfotitt1w@wunderground.com', '567-421-4767', 503, 719);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (869, '71-370-1146', 'Jobina', 'Paulton', 'https://robohash.org/minusveritatisqui.jpg?size=50x50&set=set1', 'jpaulton1x@taobao.com', '755-266-8431', 504, 720);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (870, '74-081-6192', 'Tripp', 'Hamlington', 'https://robohash.org/eumetvoluptatum.jpg?size=50x50&set=set1', 'thamlington1y@pbs.org', '150-639-3917', 505, 721);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (871, '77-312-3851', 'Cloris', 'Roddie', 'https://robohash.org/dictaarchitectomolestias.jpg?size=50x50&set=set1', 'croddie1z@mapquest.com', '235-828-0146', 506, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (872, '58-717-6596', 'Petey', 'Sparshutt', 'https://robohash.org/blanditiisquoeum.png?size=50x50&set=set1', 'psparshutt20@slideshare.net', '278-380-3146', 501, 723);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (873, '22-790-2183', 'Abbey', 'Cudiff', 'https://robohash.org/involuptatemaliquid.bmp?size=50x50&set=set1', 'acudiff21@over-blog.com', '605-218-5544', 502, 724);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (874, '68-539-2190', 'Pacorro', 'Morican', 'https://robohash.org/rerumitaqueut.png?size=50x50&set=set1', 'pmorican22@globo.com', '953-993-6866', 503, 725);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (875, '53-798-8815', 'Aluin', 'Hugin', 'https://robohash.org/quaeerrorquo.bmp?size=50x50&set=set1', 'ahugin23@comcast.net', '453-606-3486', 504, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (876, '15-406-9774', 'Matthaeus', 'Jarlmann', 'https://robohash.org/exevenietducimus.bmp?size=50x50&set=set1', 'mjarlmann24@hp.com', '787-572-6019', 505, 727);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (877, '60-470-3716', 'Melinde', 'Kleine', 'https://robohash.org/suntnecessitatibusdistinctio.png?size=50x50&set=set1', 'mkleine25@google.fr', '106-553-4797', 506, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (878, '95-130-4406', 'Candra', 'Styles', 'https://robohash.org/eaomnispossimus.png?size=50x50&set=set1', 'cstyles26@chicagotribune.com', '808-816-2758', 501, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (879, '10-311-4439', 'Ella', 'Vidineev', 'https://robohash.org/aspernaturblanditiiset.png?size=50x50&set=set1', 'evidineev27@domainmarket.com', '262-472-5908', 502, 730);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (880, '00-352-8828', 'Tiffie', 'Pexton', 'https://robohash.org/autmagnamsint.png?size=50x50&set=set1', 'tpexton28@dropbox.com', '909-984-5916', 503, 711);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (881, '19-652-7977', 'Emmery', 'Kernell', 'https://robohash.org/delenitiomnismolestiae.bmp?size=50x50&set=set1', 'ekernell29@yandex.ru', '733-276-2149', 504, 712);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (882, '35-190-6404', 'Ely', 'Brundrett', 'https://robohash.org/rerumdeseruntquo.bmp?size=50x50&set=set1', 'ebrundrett2a@uiuc.edu', '232-876-6649', 505, 713);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (883, '97-070-9180', 'Wallas', 'Haywood', 'https://robohash.org/quianatusodio.bmp?size=50x50&set=set1', 'whaywood2b@harvard.edu', '146-934-6761', 506, 714);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (884, '76-158-3518', 'Ernesta', 'Rutland', 'https://robohash.org/harumatatque.bmp?size=50x50&set=set1', 'erutland2c@samsung.com', '536-645-4429', 501, 715);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (885, '01-972-9889', 'Alix', 'Balding', 'https://robohash.org/utarchitectoeum.bmp?size=50x50&set=set1', 'abalding2d@sogou.com', '293-872-1931', 502, 716);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (886, '89-034-7277', 'Elfreda', 'Vallens', 'https://robohash.org/quidemsimiliquesed.png?size=50x50&set=set1', 'evallens2e@google.ru', '982-802-2220', 503, 717);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (887, '97-146-6475', 'Erl', 'Zanetti', 'https://robohash.org/magnamrerumsit.bmp?size=50x50&set=set1', 'ezanetti2f@google.nl', '742-746-1157', 504, 718);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (888, '22-815-2013', 'Timmy', 'Champney', 'https://robohash.org/quibusdamdoloribusoccaecati.png?size=50x50&set=set1', 'tchampney2g@cdbaby.com', '829-562-3995', 505, 719);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (889, '60-787-4452', 'Eliot', 'Lyne', 'https://robohash.org/quisquamprovidentaut.bmp?size=50x50&set=set1', 'elyne2h@china.com.cn', '463-766-8781', 506, 720);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (890, '46-448-9905', 'Jessie', 'Rotter', 'https://robohash.org/atnihilaut.bmp?size=50x50&set=set1', 'jrotter2i@chronoengine.com', '542-735-7747', 501, 721);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (891, '95-538-7758', 'Silvio', 'D''Onise', 'https://robohash.org/quasveritatisdolore.jpg?size=50x50&set=set1', 'sdonise2j@xinhuanet.com', '555-724-5266', 502, 722);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (892, '42-104-0531', 'Cassandre', 'Martinson', 'https://robohash.org/cumquiperferendis.bmp?size=50x50&set=set1', 'cmartinson2k@ifeng.com', '549-257-3761', 503, 723);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (893, '02-791-6574', 'Joanna', 'Clews', 'https://robohash.org/suntutab.png?size=50x50&set=set1', 'jclews2l@accuweather.com', '953-155-0803', 504, 724);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (894, '77-920-9735', 'Marsiella', 'Critchley', 'https://robohash.org/veritatisminusprovident.jpg?size=50x50&set=set1', 'mcritchley2m@symantec.com', '193-494-5244', 505, 725);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (895, '54-804-1818', 'Laverna', 'Blanshard', 'https://robohash.org/inconsequaturet.png?size=50x50&set=set1', 'lblanshard2n@artisteer.com', '754-526-6469', 506, 726);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (896, '81-014-5225', 'Sidonia', 'Duncombe', 'https://robohash.org/inillumvoluptatem.jpg?size=50x50&set=set1', 'sduncombe2o@clickbank.net', '659-107-4838', 501, 727);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (897, '35-480-5460', 'Boony', 'Bennedick', 'https://robohash.org/distinctiominusrecusandae.jpg?size=50x50&set=set1', 'bbennedick2p@list-manage.com', '864-101-3069', 502, 728);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (898, '41-957-8297', 'Peirce', 'Dietmar', 'https://robohash.org/providentreprehenderitvelit.bmp?size=50x50&set=set1', 'pdietmar2q@bloglines.com', '740-487-9128', 503, 729);
insert into CONDUCTORES (ID, CEDULA, NOMBRES, APELIDOS, FOTO, CORREO, CELULAR, IDIOMA_ID, CIUDAD_ID) values (899, '33-185-1845', 'Giacinta', 'Summerrell', 'https://robohash.org/quiaquidemqui.jpg?size=50x50&set=set1', 'gsummerrell2r@phpbb.com', '339-357-9845', 504, 730);


--EMPRESAS

insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (900, '73-989-8340', 'Zoombeat', '53153 Maywood Hill', '311-615-0222', 'jehlerding0@abc.net.au');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (901, '18-563-0623', 'Vidoo', '63 La Follette Plaza', '493-733-7943', 'telacoate1@google.ru');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (902, '50-575-0386', 'Meeveo', '1 Logan Terrace', '826-722-8159', 'mkenny2@discuz.net');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (903, '86-120-4799', 'Zoomzone', '684 Morningstar Drive', '412-428-4406', 'hdudson3@hubpages.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (904, '64-394-5066', 'Vinte', '8539 Kenwood Center', '365-664-8026', 'ukimble4@eepurl.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (905, '67-466-1003', 'Podcat', '99103 Sauthoff Plaza', '160-844-8377', 'cchettle5@yellowbook.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (906, '48-208-5058', 'Buzzshare', '03 High Crossing Trail', '111-674-5477', 'lwanstall6@opera.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (907, '33-157-8474', 'Twitternation', '1097 Harbort Plaza', '982-355-4643', 'cjorioz7@nsw.gov.au');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (908, '05-026-2345', 'Skyndu', '26236 Weeping Birch Street', '637-880-4048', 'ohardson8@state.tx.us');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (909, '65-621-2606', 'Camido', '84332 Meadow Ridge Place', '877-180-9307', 'ldann9@earthlink.net');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (910, '94-691-5687', 'Dabjam', '7644 Main Park', '677-409-0934', 'gheggiea@nhs.uk');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (911, '70-158-5486', 'LiveZ', '53 Manufacturers Parkway', '764-600-7967', 'cstoodleyb@networkadvertising.org');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (912, '33-438-5237', 'Eire', '292 Schlimgen Junction', '882-710-1930', 'oathersmithc@cdc.gov');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (913, '36-510-7350', 'Jatri', '922 Sutherland Point', '553-672-5021', 'ptithacottd@oaic.gov.au');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (914, '40-097-4272', 'Mybuzz', '90887 Eagan Plaza', '996-807-6410', 'djusthame@cloudflare.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (915, '31-753-1174', 'Meezzy', '63 Kinsman Lane', '415-124-7189', 'cdogertyf@xinhuanet.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (916, '20-684-1892', 'Edgeify', '9320 Holy Cross Lane', '935-338-7168', 'avincentg@csmonitor.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (917, '48-400-4431', 'Quamba', '48557 Anhalt Trail', '949-943-8964', 'tendleyh@mysql.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (918, '21-204-9536', 'Centidel', '48433 Anthes Plaza', '110-135-4125', 'bcummungsi@earthlink.net');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (919, '89-357-3807', 'Yakidoo', '988 Dorton Way', '719-924-0693', 'llosbiej@51.la');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (920, '34-800-9563', 'Skinder', '69309 Lotheville Parkway', '978-923-6475', 'tsedenk@ucla.edu');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (921, '43-620-2110', 'Tagtune', '3019 Continental Parkway', '226-922-8678', 'adoyleyl@berkeley.edu');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (922, '10-239-8604', 'Kare', '2 Maryland Road', '161-997-2216', 'battleem@mysql.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (923, '28-370-0554', 'Twitterbridge', '9081 Johnson Court', '808-531-9191', 'sgiovanettin@europa.eu');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (924, '76-341-4851', 'Zazio', '89 Crownhardt Court', '912-921-0930', 'imaciano@mayoclinic.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (925, '96-903-2243', 'Brainsphere', '9 Dapin Lane', '739-172-6190', 'sreinardp@youtu.be');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (926, '52-304-7040', 'Meemm', '30 Oak Street', '476-612-0680', 'tpetriq@google.ca');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (927, '47-938-7468', 'Mycat', '569 Canary Crossing', '692-692-9947', 'kloderr@boston.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (928, '83-425-8753', 'Topicblab', '4767 Sullivan Alley', '502-902-1480', 'charrinsons@squarespace.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (929, '23-886-6405', 'Linkbridge', '5 Talisman Trail', '913-688-0571', 'jcogart@discuz.net');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (930, '63-047-7975', 'Trilia', '2 Corscot Circle', '780-561-0606', 'cdufallu@yelp.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (931, '90-485-8513', 'Miboo', '7 Weeping Birch Park', '385-778-9910', 'gfosherv@netlog.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (932, '94-708-4102', 'Meezzy', '558 Forest Run Center', '812-964-8517', 'djoiscew@altervista.org');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (933, '63-408-5354', 'Eazzy', '3955 Bonner Crossing', '250-861-1478', 'sbiswellx@tiny.cc');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (934, '64-936-6725', 'Tanoodle', '7 Messerschmidt Street', '536-234-3134', 'dsnariey@livejournal.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (935, '30-969-9628', 'Babblestorm', '33498 Graceland Place', '761-657-1581', 'dparadycez@mediafire.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (936, '69-460-9857', 'Realcube', '3000 Tennyson Pass', '210-362-9816', 'codonnell10@hud.gov');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (937, '98-765-9025', 'Skiptube', '104 Utah Junction', '231-627-5110', 'rscoone11@imdb.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (938, '58-785-5013', 'Trunyx', '46319 Warner Point', '406-320-8362', 'afownes12@dmoz.org');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (939, '32-605-3876', 'Feedfish', '2074 Stang Place', '708-668-2226', 'abearn13@dyndns.org');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (940, '56-092-3827', 'Quinu', '4078 Pawling Avenue', '373-147-3133', 'lespinoy14@blog.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (941, '87-844-6971', 'Rooxo', '728 Merry Hill', '901-476-4020', 'gfettiplace15@cloudflare.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (942, '49-899-8400', 'Innojam', '60146 Shopko Plaza', '423-749-0720', 'bkopta16@ning.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (943, '10-400-4371', 'Topicstorm', '52408 Eagle Crest Hill', '561-338-5817', 'kstorrie17@msu.edu');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (944, '32-447-9196', 'Wordware', '5657 Northfield Park', '192-687-2171', 'gmoller18@is.gd');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (945, '98-760-4852', 'Jayo', '0 Oriole Lane', '606-324-0223', 'ovispo19@wordpress.org');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (946, '44-273-9525', 'Zoomzone', '38207 Caliangt Point', '260-670-1585', 'ahammerman1a@fotki.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (947, '96-774-9010', 'Tambee', '339 Thierer Terrace', '901-106-2248', 'bjayne1b@hibu.com');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (948, '55-306-3887', 'Dynava', '65 Hayes Terrace', '250-214-5881', 'mdezamudio1c@loc.gov');
insert into EMPRESAS (ID, NIT, NOMBRE, DIRECCION, TELEFONO, CORREO) values (949, '70-994-7692', 'Oozz', '7 Dryden Avenue', '666-560-7562', 'gfagence1d@salon.com');

--MEDIOS PAGO

insert into MEDIOS_PAGO (ID, DESCRIPCION) values (1, 'PAYPAL');
insert into MEDIOS_PAGO (ID, DESCRIPCION) values (2, 'TARJETA DE CREDITO');
insert into MEDIOS_PAGO (ID, DESCRIPCION) values (3, 'ANDROID');
insert into MEDIOS_PAGO (ID, DESCRIPCION) values (4, 'CUENTA DE AHORROS');
insert into MEDIOS_PAGO (ID, DESCRIPCION) values (5, 'TARJETA DEBITO');


--VEHICULOS

insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (950, 'JH4NA12642T963672', 'Chevrolet', 'TrailBlazer', 2003, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (951, 'JH4CU2F42CC227683', 'Acura', 'Legend', 1992, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (952, 'WBA4B3C51FD470976', 'BMW', 'X6 M', 2011, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (953, 'WAUSG94F59N992141', 'Isuzu', 'i-280', 2006, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (954, 'WAUSH78E07A315280', 'Mercury', 'Cougar', 1968, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (955, '1G4HP54K114157744', 'Jeep', 'Liberty', 2012, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (956, '2T1KE4EE5DC208036', 'Volkswagen', 'Passat', 1988, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (957, '19UUA9E58CA564566', 'Pontiac', 'Sunbird', 1983, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (958, '1GD12ZCG8CF352848', 'Hyundai', 'Azera', 2011, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (959, '1N6AD0CU8EN975036', 'Dodge', 'Caravan', 2006, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (960, 'SAJWA4DC0FM714989', 'Cadillac', 'Catera', 1997, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (961, 'WA1DGAFP8FA684221', 'Ford', 'Econoline E250', 1998, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (962, 'WAUHF78P37A046287', 'Nissan', 'Altima', 2009, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (963, '1FBNE3BL9ED158516', 'Chevrolet', 'Suburban 2500', 2010, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (964, 'SCFEDCAD8CG570323', 'Toyota', 'Prius', 2008, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (965, 'WVGAV7AX7BW497036', 'Ford', 'Mustang', 2005, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (966, '3FAHP0DC6AR562785', 'Saturn', 'L-Series', 2004, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (967, '3C3CFFER9DT738687', 'Buick', 'Park Avenue', 1996, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (968, 'WVWAN7AN7EE714971', 'Lincoln', 'Town Car', 1998, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (969, '3N1BC1APXAL552100', 'Dodge', 'Dakota', 2001, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (970, '4T1BD1EB3EU090298', 'Mercedes-Benz', 'S-Class', 2002, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (971, '1G6DK8ED7B0137464', 'Volvo', 'S80', 2003, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (972, '1G4HP52KX3U869739', 'Acura', 'RL', 1998, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (973, '2HNYD18993H043164', 'Mazda', '626', 1983, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (974, '1G6KD57926U924281', 'BMW', '1 Series', 2012, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (975, '3GYFNDEY6BS551122', 'Honda', 'CR-X', 1988, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (976, 'WAUAF78E78A620424', 'Ford', 'F350', 1996, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (977, 'JN8AZ1MU2EW828962', 'Subaru', 'Alcyone SVX', 1993, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (978, 'JN1CV6EK3FM685322', 'Lexus', 'LX', 2007, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (979, '1GYFK23269R405618', 'Volvo', 'C70', 2007, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (980, 'WAUA2AFD9DN642589', 'Infiniti', 'G', 1999, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (981, '1G6AC5S38D0286754', 'Mitsubishi', 'Expo LRV', 1996, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (982, '5N1AA0NC7EN770271', 'Lexus', 'LFA', 2012, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (983, 'WAU3VAFR9BA008084', 'Lexus', 'LS', 1999, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (984, 'WAUWMAFC2EN130536', 'Geo', 'Tracker', 1993, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (985, 'WBA1F5C56FV961699', 'Bentley', 'Continental GTC', 2012, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (986, '3VW467AT6DM515313', 'Hummer', 'H1', 2000, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (987, 'JTDKDTB31C1475516', 'Pontiac', 'Sunbird', 1988, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (988, '5N1AN0NU4DN677641', 'Lotus', 'Elise', 2008, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (989, 'WAUAT48H75K664155', 'GMC', 'Rally Wagon 2500', 1994, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (990, 'WBAAX13493P658638', 'Lexus', 'SC', 2004, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (991, 'WA1VMBFP3EA411172', 'Pontiac', 'GTO', 1969, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (992, '3D7JB1EK5AG636379', 'Subaru', 'Alcyone SVX', 1996, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (993, '2C3CCAPT4CH964583', 'Aston Martin', 'V12 Vantage', 2012, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (994, '1N6AA0CJ8DN734154', 'Chevrolet', '1500', 1997, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (995, '4T1BB3EKXAU040588', 'Ford', 'Crown Victoria', 2003, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (996, 'JTHBL5EF5F5319544', 'Dodge', 'Ram Van 3500', 1997, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (997, 'JTDKDTB30D1998415', 'Dodge', 'Ram 2500', 1996, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (998, '3N1AB7AP0FL116963', 'Toyota', 'Sienna', 2012, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (999, 'JHMZF1C61DS039250', 'Chrysler', 'Cirrus', 1997, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (1000, '4T1BK3DB1AU121707', 'Mitsubishi', 'Eclipse', 2011, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (972, '3D4PG4FB8BT502595', 'Chrysler', 'Sebring', 1999, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (973, '1N6AA0EK3FN811845', 'Mazda', 'Protege', 2002, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (974, 'WBA4B1C51FG396610', 'Subaru', 'Impreza', 1995, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (975, 'JTDZN3EU0FJ346719', 'GMC', 'Yukon XL 1500', 2013, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (976, 'YV1940AS5B1236632', 'Volkswagen', 'Passat', 1995, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (977, '3D73M3CL3AG439723', 'Ford', 'Explorer', 1996, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (978, 'WAUEF48H18K313285', 'BMW', '3 Series', 2012, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (979, 'WAUFFAFM3CA796828', 'Kia', 'Optima', 2012, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (980, '1G6DK8EV1A0879060', 'Ford', 'Excursion', 2004, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (981, '1N6AA0EC2DN862808', 'Ford', 'Focus', 2013, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (982, '1GYS3AKJ1FR503143', 'Mercedes-Benz', 'M-Class', 2001, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (983, '3C63DPJL9CG396892', 'Chevrolet', 'G-Series 1500', 1997, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (984, 'SCFBB03BX7G329565', 'Dodge', 'Ram Wagon B150', 1992, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (985, 'WAUDL74F55N511436', 'Pontiac', 'Grand Prix', 1999, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (986, 'JH4CW2H51BC429798', 'Mazda', 'MX-5', 1998, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (987, 'WAUEF98E86A369861', 'Land Rover', 'Range Rover', 1988, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (988, 'WAUSG94F09N659183', 'Mitsubishi', 'Outlander Sport', 2011, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (989, 'WAUEF78E58A952315', 'Ford', 'Expedition EL', 2012, 'UberX');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (990, 'WA1VMBFE2BD089875', 'Honda', 'Element', 2010, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (991, 'WAUEF98EX8A783453', 'BMW', '7 Series', 2006, 'Uber Black');
insert into VEHICULOS (ID, PLACA, MARCA, LINEA, MODELO, TIPO_SERVICIO) values (992, 'WBALW3C58DC993253', 'Infiniti', 'Q', 2000, 'Uber Black');

--CONDUCTORES VEHICULOS


insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1000, 800, 950);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1001, 801, 951);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1002, 802, 952);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1003, 803, 953);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1004, 804, 954);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1005, 805, 955);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1006, 806, 956);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1007, 807, 957);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1008, 808, 958);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1009, 809, 959);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1010, 810, 960);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1011, 811, 961);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1012, 812, 962);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1013, 813, 963);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1014, 814, 964);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1015, 815, 965);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1016, 816, 966);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1017, 817, 967);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1018, 818, 968);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1019, 819, 969);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1020, 820, 970);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1021, 821, 971);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1022, 822, 972);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1023, 823, 973);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1024, 824, 974);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1025, 825, 975);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1026, 826, 976);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1027, 827, 977);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1028, 828, 978);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1029, 829, 979);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1030, 830, 980);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1031, 831, 981);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1032, 832, 982);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1033, 833, 983);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1034, 834, 984);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1035, 835, 985);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1036, 836, 986);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1037, 837, 987);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1038, 838, 988);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1039, 839, 989);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1040, 840, 990);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1041, 841, 991);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1042, 842, 992);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1043, 843, 993);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1044, 844, 994);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1045, 845, 995);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1046, 846, 996);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1047, 847, 997);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1048, 848, 998);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1049, 849, 999);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1050, 850, 950);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1051, 851, 951);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1052, 852, 952);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1053, 853, 953);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1054, 854, 954);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1055, 855, 955);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1056, 856, 956);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1057, 857, 957);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1058, 858, 958);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1059, 859, 959);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1060, 860, 960);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1061, 861, 961);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1062, 862, 962);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1063, 863, 963);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1064, 864, 964);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1065, 865, 965);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1066, 866, 966);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1067, 867, 967);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1068, 868, 968);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1069, 869, 969);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1070, 870, 970);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1071, 871, 971);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1072, 872, 972);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1073, 873, 973);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1074, 874, 974);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1075, 875, 975);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1076, 876, 976);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1077, 877, 977);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1078, 878, 978);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1079, 879, 979);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1080, 880, 980);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1081, 881, 981);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1082, 882, 982);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1083, 883, 983);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1084, 884, 984);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1085, 885, 985);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1086, 886, 986);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1087, 887, 987);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1088, 888, 988);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1089, 889, 989);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1090, 890, 990);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1091, 891, 991);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1092, 892, 992);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1093, 893, 993);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1094, 894, 994);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1095, 895, 995);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1096, 896, 996);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1097, 897, 997);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1098, 898, 998);
insert into CONDUCTORES_VEHICULOS (ID, CONDUCTOR_ID, VEHICULO_ID) values (1099, 899, 999);

--CODIGOS PROMOCIONALES
SELECT * FROM CODIGOS_PROMOCIONALES;

insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (1, '67544-191', 2855.57, 81);
Insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (2, '59494-1001', 2410.36, 247);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (3, '55319-612', 2764.49, 279);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (4, '50302-340', 4750.06, 93);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (5, '66336-871', 4775.92, 5);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (6, '0904-6084', 4025.01, 266);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (7, '62011-0072', 2639.38, 24);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (8, '68382-079', 2204.25, 181);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (9, '49738-140', 4533.94, 240);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (10, '58930-060', 4426.81, 188);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (11, '65862-121', 4108.35, 125);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (12, '55045-3841', 2930.02, 168);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (13, '55319-203', 4305.62, 78);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (14, '49349-358', 4795.21, 198);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (15, '16590-778', 4160.77, 308);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (16, '50436-5505', 3723.49, 313);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (17, '36987-3402', 3799.07, 170);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (18, '75990-5008', 2585.38, 102);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (19, '36987-2298', 4149.07, 383);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (20, '0615-3549', 4135.18, 337);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (21, '0378-3360', 2987.78, 202);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (22, '65044-2295', 4991.99, 316);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (23, '68001-004', 3990.67, 236);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (24, '68428-045', 4034.59, 264);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (25, '52959-516', 2735.48, 380);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (26, '75835-268', 4325.6, 482);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (27, '49035-365', 3174.22, 286);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (28, '76439-208', 3322.17, 7);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (29, '68345-721', 2994.32, 480);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (30, '68210-1510', 2948.5, 30);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (31, '21130-214', 2031.48, 216);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (32, '68196-175', 3793.27, 405);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (33, '51655-535', 2871.83, 472);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (34, '0310-0131', 3055.99, 265);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (35, '39822-4050', 3610.38, 479);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (36, '62011-0227', 2693.23, 176);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (37, '0268-6138', 3354.29, 71);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (38, '21130-619', 4384.32, 414);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (39, '55346-0408', 2551.81, 7);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (40, '48951-7004', 4322.5, 100);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (41, '0054-0255', 2028.52, 61);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (42, '0093-0264', 4055.78, 408);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (43, '0245-0536', 3213.09, 391);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (44, '55154-1678', 4028.12, 203);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (45, '0009-0306', 3774.11, 175);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (46, '60232-2500', 2511.71, 281);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (47, '10019-016', 4429.96, 158);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (48, '47335-603', 2195.22, 147);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (49, '68682-369', 2168.77, 247);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (50, '0781-1375', 3579.4, 214);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (1, '10544-586', 2651.79, 115);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (2, '62712-575', 4108.27, 421);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (3, '0093-5150', 4339.85, 397);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (4, '0378-4003', 3984.64, 311);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (5, '61727-335', 3004.66, 3);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (6, '36987-2219', 2169.22, 204);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (7, '0904-5930', 2263.75, 299);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (8, '63739-800', 3124.39, 116);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (9, '30142-345', 3708.7, 185);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (10, '53808-0632', 2777.93, 315);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (11, '57520-0123', 4222.01, 368);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (12, '76369-3001', 2359.55, 135);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (13, '43269-825', 3503.77, 432);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (14, '50730-8717', 3975.11, 131);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (15, '52915-100', 4529.77, 238);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (16, '54748-401', 3872.08, 52);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (17, '63187-166', 3896.56, 109);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (18, '60681-6302', 3858.52, 9);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (19, '35617-395', 2156.44, 296);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (20, '48769-113', 3499.73, 340);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (21, '0093-0782', 3333.32, 466);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (22, '24909-140', 3450.04, 460);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (23, '59762-3140', 4807.7, 329);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (24, '36987-2400', 2530.32, 247);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (25, '21749-704', 4401.99, 462);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (26, '10685-520', 4765.76, 210);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (27, '64616-108', 4611.79, 98);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (28, '16590-177', 3174.21, 441);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (29, '76204-003', 2914.32, 451);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (30, '51460-4943', 2424.51, 300);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (31, '48951-3029', 3919.85, 36);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (32, '49348-813', 2965.16, 147);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (33, '62756-183', 3573.72, 165);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (34, '0283-0569', 2633.17, 157);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (35, '63941-036', 4845.05, 43);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (36, '0268-0621', 3623.15, 4);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (37, '54123-914', 4220.33, 9);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (38, '30142-897', 3355.19, 325);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (39, '40032-140', 3676.47, 142);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (40, '31722-206', 3834.2, 140);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (41, '68712-015', 4918.07, 96);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (42, '55154-5609', 4744.42, 481);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (43, '49884-535', 4523.47, 314);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (44, '53329-080', 3473.5, 471);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (45, '0781-3040', 2642.71, 233);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (46, '65044-3695', 2239.44, 16);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (47, '11084-231', 3204.74, 22);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (48, '0615-4529', 2625.0, 256);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (49, '0904-6080', 4238.22, 208);
insert into CODIGOS_PROMOCIONALES (ID, CODIGO, VALOR, CLIENTE_ID) values (50, '0378-5486', 4823.93, 175);


	
    
--CARDINALIDAD
    --TABLA CLIENTES
    ALTER TABLE CLIENTES
        ADD CONSTRAINT FK_CLIENTE_IDIOMA FOREIGN KEY (IDIOMA_ID) REFERENCES IDIOMAS (ID);
    ALTER TABLE CLIENTES
        ADD CONSTRAINT FK_CLIENTE_CIUDAD FOREIGN KEY (CIUDAD_ID) REFERENCES CIUDADES (ID);
        
    --TABLA SERVICIOS
    ALTER TABLE SERVICIOS    
        ADD CONSTRAINT FK_SERVICIO_CONDUCTOR_VEHICULO FOREIGN KEY (CONDUCTORES_VEHICULOS_ID) REFERENCES CONDUCTORES_VEHICULOS (ID);
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
        
     ALTER TABLE FACTURAS
        ADD CONSTRAINT FK_FACTURAS_MEDIO_PAGO FOREIGN KEY (MEDIO_PAGO_ID) REFERENCES MEDIOS_PAGO (ID);
        
    -- TABLA CIUDADES
    ALTER TABLE CIUDADES
        ADD CONSTRAINT FK_CIUDAD_PAIS FOREIGN KEY (PAIS_ID) REFERENCES PAISES (ID);    
        
    --TABLA ENVIO_RECIBOS 
    ALTER TABLE ENVIO_RECIBOS
        ADD CONSTRAINT FK_EMAILS FOREIGN KEY (EMAIL_ID) REFERENCES EMAILS (ID);
    ALTER TABLE ENVIO_RECIBOS    
        ADD CONSTRAINT FK_CLI_MEDIO_PAGO_ENVIO_RECIBO FOREIGN KEY (MEDIO_PAGO_ID) REFERENCES MEDIOS_PAGO (ID);
        
    --TABLA EMAILS
        ALTER TABLE EMAILS
        ADD CONSTRAINT FK_EMAILS_CLIENTES FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTES (ID);
            
    --TABLA CODIGOS_PROMOCIONALES 
    ALTER TABLE CODIGOS_PROMOCIONALES
        ADD CONSTRAINT FK_COD_PROMOCIONALES_CLIENTE FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTES (ID); 
        
    --TABLA CONDUCTORES
    ALTER TABLE CONDUCTORES
        ADD CONSTRAINT FK_CONDUCTOR_IDIOMA FOREIGN KEY (IDIOMA_ID) REFERENCES IDIOMAS (ID); 
    ALTER TABLE CONDUCTORES
        ADD CONSTRAINT FK_CONDUCTORES_CIUDAD FOREIGN KEY (CIUDAD_ID) REFERENCES CIUDADES (ID);  
        
    --TABLA PAGOS_CONDUCTORES
    ALTER TABLE PAGOS_CONDUCTORES
        ADD CONSTRAINT FK_PAGOS_MEDIOS_PAGOS FOREIGN KEY (MEDIO_PAGO_ID) REFERENCES MEDIOS_PAGO (ID);
        
    ALTER TABLE PAGOS_CONDUCTORES
        ADD CONSTRAINT FK_PAGOS_CONDUCTORES FOREIGN KEY (CONDUCTOR_ID) REFERENCES CONDUCTORES (ID);
    
    --TABLA EMPRESAS_MEDIOS_PAGO
    ALTER TABLE EMPRESAS_MEDIOS_PAGO
        ADD CONSTRAINT FK_MEDIOS_PAGO_EMPRESAS FOREIGN KEY (EMPRESA_ID) REFERENCES EMPRESAS (ID); 
    ALTER TABLE EMPRESAS_MEDIOS_PAGO
        ADD CONSTRAINT FK_MEDIOS_PAGO_MEDIOPAGO FOREIGN KEY (MEDIO_PAGO_ID) REFERENCES MEDIOS_PAGO (ID);  
        
    --TABLA MEDIOS_PAGO    
    ALTER TABLE MEDIOS_PAGO
        ADD CONSTRAINT FK_MEDIO_PAGO_CLIENTE FOREIGN KEY (CLIENTE_ID) REFERENCES CLIENTES (ID); 
        
    --TABLA DETALLES_FACTURAS   
    ALTER TABLE DETALLES_FACTURAS
        ADD CONSTRAINT FK_DETALLES_FACTURA FOREIGN KEY (FACTURA_ID) REFERENCES FACTURAS (ID); 


		--DROPS
		
drop table CLIENTES cascade constraints;
drop table MEDIOS_PAGO cascade constraints;
drop table SERVICIOS cascade constraints;
drop table VEHICULOS cascade constraints;
drop table CONDUCTORES_VEHICULOS cascade constraints;
drop table DETALLES_UBICACION_SERVICIOS cascade constraints;
drop table CLIENTES_EMPRESAS cascade constraints;
drop table FACTURAS cascade constraints;
drop table IDIOMAS  cascade constraints;
drop table PAISES  cascade constraints;
drop table CIUDADES cascade constraints;
drop table EMAILS cascade constraints;
drop table ENVIO_RECIBOS cascade constraints;
drop table CODIGOS_PROMOCIONALES  cascade constraints;
drop table CONDUCTORES  cascade constraints;
drop table EMPRESAS  cascade constraints;
drop table EMPRESAS_MEDIOS_PAGO  cascade constraints;
drop table DETALLES_FACTURAS   cascade constraints; 
drop table PAGOS_CONDUCTORES  cascade constraints;
