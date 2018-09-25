 -- Punto 2
     -- 2a
     CREATE TABLESPACE uber DATAFILE 'uber.dbf' SIZE 2G ONLINE;

    -- 2b
    CREATE UNDO TABLESPACE undouber
        DATAFILE 'undouber_1a.dbf'
        SIZE 25M AUTOEXTEND ON
        RETENTION GUARANTEE;
    
    --2c
        CREATE BIGFILE TABLESPACE bigfileuber
        DATAFILE 'bigfileuber_1a.dbf'
        SIZE 5G;
        
    --2d

    ALTER SYSTEM SET UNDO_TABLESPACE = undouber;
    



-- Punto 3
CREATE USER usrUber
IDENTIFIED BY usrUber
DEFAULT TABLESPACE uber
QUOTA UNLIMITED ON uber;


GRANT CREATE SESSION, DBA TO usrUber

-- Punto 4

CREATE PROFILE CLERK LIMIT 
  PASSWORD_LIFE_TIME               40   -- dias
  SESSIONS_PER_USER                 1   -- Una por usuario
  IDLE_TIME                        10   -- minutos
  FAILED_LOGIN_ATTEMPTS             4;  -- Logins fallidos

CREATE PROFILE DEVELOPMENT LIMIT 
  PASSWORD_LIFE_TIME              100   -- dias
  SESSIONS_PER_USER                 2   -- Dos por usuario
  IDLE_TIME                        30   -- minutos
  FAILED_LOGIN_ATTEMPTS     UNLIMITED;  -- Logins ilimitados


-- Punto 5

    --5a
    CREATE USER user1
    IDENTIFIED BY user1
    DEFAULT TABLESPACE uber;
    GRANT CREATE SESSION TO user1;
    ALTER USER user1 PROFILE CLERK;
    
    CREATE USER user2
    IDENTIFIED BY user2
    DEFAULT TABLESPACE uber;
    GRANT CREATE SESSION TO user2;
    ALTER USER user2 PROFILE CLERK;
    
    CREATE USER user3
    IDENTIFIED BY user3
    DEFAULT TABLESPACE uber;
    GRANT CREATE SESSION TO user3;
    ALTER USER user3 PROFILE DEVELOPMENT;
    
    CREATE USER user4
    IDENTIFIED BY user4
    DEFAULT TABLESPACE uber;
    GRANT CREATE SESSION TO user4;
    ALTER USER user4 PROFILE DEVELOPMENT;

    --5b
    ALTER USER user2 ACCOUNT LOCK;
	
 -- CREACION DE TABLAS
 
 
 
 
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
    
--CARDINALIDAD
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
		
		
	


                                                            ----INSERTS-----


--CLIENTES

insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (1, 'Addia', 'Masson', 'https://robohash.org/consequaturhicvoluptatem.bmp?size=50x50&set=set1', 'amasson0@over-blog.com', '425-890-4501', 'amasson0', 'Sl5DJI', '8GWi9FyTD', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (2, 'Rance', 'Izaks', 'https://robohash.org/autexplicaboiste.jpg?size=50x50&set=set1', 'rizaks1@miibeian.gov.cn', '991-440-5495', 'rizaks1', 'BpK2j5xUF', 'CfiBmQj', 504, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (3, 'Welbie', 'Cuthill', 'https://robohash.org/oditautsaepe.bmp?size=50x50&set=set1', 'wcuthill2@naver.com', '995-243-0454', 'wcuthill2', 'fFb54e9QNM', 'UT3QbqDUi', 504, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (4, 'Conny', 'Cowley', 'https://robohash.org/distinctioatconsequatur.jpg?size=50x50&set=set1', 'ccowley3@businesswire.com', '214-143-1619', 'ccowley3', '43ySSAHw', 'LpdgUEB22VA8', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (5, 'Byrom', 'Tenniswood', 'https://robohash.org/consecteturipsaquas.png?size=50x50&set=set1', 'btenniswood4@smh.com.au', '301-749-3166', 'btenniswood4', 'sabp8DO', 'Cqacmce', 506, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (6, 'Karlene', 'Keattch', 'https://robohash.org/ethicofficiis.png?size=50x50&set=set1', 'kkeattch5@nba.com', '248-998-6166', 'kkeattch5', 'TQ7oWjpPXbTF', 'uKFmoW', 505, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (7, 'Philis', 'Whiting', 'https://robohash.org/aliasnobisvoluptatum.png?size=50x50&set=set1', 'pwhiting6@dropbox.com', '188-284-3826', 'pwhiting6', 'un1CZ9PoM', 'xP5ms3pjqUlW', 505, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (8, 'Lacey', 'Atling', 'https://robohash.org/quisquamsuntitaque.jpg?size=50x50&set=set1', 'latling7@shutterfly.com', '992-923-6150', 'latling7', '1Z1J3f', '0Hu7sVJ', 506, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (9, 'Wynn', 'Mongin', 'https://robohash.org/aperiamdolorumfugiat.jpg?size=50x50&set=set1', 'wmongin8@elegantthemes.com', '775-644-5312', 'wmongin8', '42pzSPag', 'vMopebU6P', 502, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (10, 'Min', 'Phelipeaux', 'https://robohash.org/autenimin.jpg?size=50x50&set=set1', 'mphelipeaux9@constantcontact.com', '643-530-8431', 'mphelipeaux9', '7DGHtKvye8', 'A9HUoaYQ7', 503, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (11, 'Boniface', 'Birdsey', 'https://robohash.org/fugaimpeditvel.jpg?size=50x50&set=set1', 'bbirdseya@umn.edu', '766-959-7053', 'bbirdseya', 'DDdvs943', 'CLhkEv', 506, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (12, 'Gardiner', 'Van Castele', 'https://robohash.org/beataemolestiaedoloremque.png?size=50x50&set=set1', 'gvancasteleb@zimbio.com', '994-458-9660', 'gvancasteleb', '08SCSC713SV', 'Uon97GfLtnH', 504, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (13, 'Simonette', 'Terry', 'https://robohash.org/maioresvoluptatesquasi.png?size=50x50&set=set1', 'sterryc@fastcompany.com', '980-783-8601', 'sterryc', 'ZJ1UbVcqJ7Vl', 'QwwgW665x16i', 506, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (14, 'Lia', 'Paffot', 'https://robohash.org/errorexsimilique.png?size=50x50&set=set1', 'lpaffotd@gizmodo.com', '554-130-6442', 'lpaffotd', 'WWSsizK', 'wh9BlL46q', 501, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (15, 'Ortensia', 'Broderick', 'https://robohash.org/autaliquidexpedita.bmp?size=50x50&set=set1', 'obrodericke@example.com', '963-435-2736', 'obrodericke', 'Kplq78s', 'Bf2irPaIb', 503, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (16, 'Allen', 'Lettson', 'https://robohash.org/fugaipsaquis.png?size=50x50&set=set1', 'alettsonf@last.fm', '809-100-3056', 'alettsonf', 'CD46z3FfdQ5', 'xjNd5VFJAkS', 501, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (17, 'Konstanze', 'Gilardone', 'https://robohash.org/solutatemporaquis.png?size=50x50&set=set1', 'kgilardoneg@4shared.com', '896-275-4123', 'kgilardoneg', 'Bd0y9GGH', 'GRME1m', 502, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (18, 'Frannie', 'Burnel', 'https://robohash.org/suntnonculpa.png?size=50x50&set=set1', 'fburnelh@gmpg.org', '150-319-8536', 'fburnelh', 'UYGarz', 'zHPJN3Wqkdc1', 505, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (19, 'Ramonda', 'Harbord', 'https://robohash.org/sitveliure.png?size=50x50&set=set1', 'rharbordi@webnode.com', '878-396-2936', 'rharbordi', 'ZlnucWy5IYw', 'bQgwzxO00', 501, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (20, 'Sharl', 'Beat', 'https://robohash.org/quoomnisdelectus.png?size=50x50&set=set1', 'sbeatj@home.pl', '232-556-0538', 'sbeatj', 'XHIpjgEb', 'weq2TsewKHal', 503, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (21, 'Margalo', 'Bramsom', 'https://robohash.org/temporaetnemo.png?size=50x50&set=set1', 'mbramsomk@vk.com', '405-421-4069', 'mbramsomk', 'Y0iZFn9A', '16L04JoU', 506, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (22, 'Charity', 'Lindsell', 'https://robohash.org/quasivoluptatemin.jpg?size=50x50&set=set1', 'clindselll@wsj.com', '113-869-1706', 'clindselll', 'D923jHv', 'oQ8pXgY', 501, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (23, 'Leshia', 'Heskins', 'https://robohash.org/sitvoluptatesmolestias.jpg?size=50x50&set=set1', 'lheskinsm@google.ru', '627-459-4375', 'lheskinsm', 'FQ5dK4', '3EvOxPhw', 501, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (24, 'Zacharia', 'Mugglestone', 'https://robohash.org/fugaquiamagni.bmp?size=50x50&set=set1', 'zmugglestonen@va.gov', '296-481-5231', 'zmugglestonen', '7Tatub21R', 'cmVPo5wO', 501, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (25, 'Abey', 'Braikenridge', 'https://robohash.org/nonconsequunturoptio.jpg?size=50x50&set=set1', 'abraikenridgeo@simplemachines.org', '218-706-8654', 'abraikenridgeo', 'V6oykdkuyV0', 'lDy1vdT0', 504, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (26, 'Nora', 'Pudner', 'https://robohash.org/etpraesentiumconsequuntur.bmp?size=50x50&set=set1', 'npudnerp@skype.com', '336-446-5762', 'npudnerp', 'KGP5SF', '9pB4TlfIY', 504, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (27, 'Janel', 'Ranyell', 'https://robohash.org/perferendisdelenitiatque.bmp?size=50x50&set=set1', 'jranyellq@behance.net', '446-305-5166', 'jranyellq', 'D3YDDJd9dx4o', '4NzcfrMPQW', 503, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (28, 'Nadia', 'Lerohan', 'https://robohash.org/modivoluptatemharum.jpg?size=50x50&set=set1', 'nlerohanr@un.org', '352-772-8988', 'nlerohanr', 'Seaq2yXE', 'GKHDvt0', 501, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (29, 'Eleonore', 'Filson', 'https://robohash.org/expeditaoditexcepturi.jpg?size=50x50&set=set1', 'efilsons@csmonitor.com', '630-999-8891', 'efilsons', 'Pdpr9UnNRh9', 'lmL2bPpW7k', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (30, 'Roberta', 'Killgus', 'https://robohash.org/earummolestiasquia.bmp?size=50x50&set=set1', 'rkillgust@jugem.jp', '463-960-7101', 'rkillgust', 'P5FBhSR', 'V53O6mrhR', 502, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (31, 'Brand', 'Ply', 'https://robohash.org/liberoetmagni.png?size=50x50&set=set1', 'bplyu@cam.ac.uk', '922-869-9009', 'bplyu', 'KaOuqKC', 'XJ0drNWF8S', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (32, 'Stacy', 'Horsewood', 'https://robohash.org/excepturiitaquesed.jpg?size=50x50&set=set1', 'shorsewoodv@prweb.com', '798-671-7333', 'shorsewoodv', 'SOubaBL4SU3', 'xuggNamb', 501, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (33, 'Alley', 'Scottesmoor', 'https://robohash.org/uteaquia.jpg?size=50x50&set=set1', 'ascottesmoorw@about.me', '924-208-6024', 'ascottesmoorw', 'a8oA4p7Dp54y', 'U5RI9cSrZ6r', 503, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (34, 'Cheslie', 'Fattori', 'https://robohash.org/sitsaepedeleniti.png?size=50x50&set=set1', 'cfattorix@1und1.de', '279-462-7340', 'cfattorix', '43C9C7', 'W79JrGH', 501, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (35, 'Mortimer', 'Allerton', 'https://robohash.org/cumrepellendusamet.png?size=50x50&set=set1', 'mallertony@printfriendly.com', '385-732-2448', 'mallertony', '4nrE6yV', 'eo27Ecb', 506, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (36, 'Silvia', 'Rasmus', 'https://robohash.org/porroeoslaudantium.png?size=50x50&set=set1', 'srasmusz@barnesandnoble.com', '150-936-9106', 'srasmusz', 'i9AJtsI9W', '5S6WfGcli', 504, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (37, 'Aurora', 'Kemet', 'https://robohash.org/sintnihilquas.png?size=50x50&set=set1', 'akemet10@ftc.gov', '193-831-6332', 'akemet10', '8vNTIrWk', 'rFmkuKcN', 502, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (38, 'Fredek', 'Pursey', 'https://robohash.org/molestiaeetlabore.jpg?size=50x50&set=set1', 'fpursey11@bizjournals.com', '859-942-3136', 'fpursey11', '1aYQJLk', 'uPZLdvRzUs', 505, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (39, 'Minnaminnie', 'Matczak', 'https://robohash.org/etquiaipsa.jpg?size=50x50&set=set1', 'mmatczak12@goo.ne.jp', '672-594-8958', 'mmatczak12', 'oktxvkesz4vv', 'g7Fmv7HKJYt', 504, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (40, 'Lynett', 'Emanuelov', 'https://robohash.org/recusandaelaboreipsa.png?size=50x50&set=set1', 'lemanuelov13@nature.com', '538-490-9484', 'lemanuelov13', 'gi2wxmO6JLXp', 'Zn2DoOl', 501, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (41, 'Falito', 'Ogley', 'https://robohash.org/providentconsecteturaut.jpg?size=50x50&set=set1', 'fogley14@shutterfly.com', '504-283-6770', 'fogley14', 'FU4jn5w5zzJ', 'd0KMCfVv', 506, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (42, 'Emmalynn', 'Bothams', 'https://robohash.org/nonsitcorrupti.bmp?size=50x50&set=set1', 'ebothams15@wikipedia.org', '253-699-9250', 'ebothams15', 'Cj23UJLs', 'uwxFjzZKWmG', 506, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (43, 'Sinclare', 'O''Driscole', 'https://robohash.org/nonaccusantiumrecusandae.png?size=50x50&set=set1', 'sodriscole16@squarespace.com', '839-520-5356', 'sodriscole16', 'seJa4beE4', 'PnfHTk2t', 505, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (44, 'Fiorenze', 'Schiesterl', 'https://robohash.org/accusantiumsedomnis.jpg?size=50x50&set=set1', 'fschiesterl17@state.tx.us', '434-378-8214', 'fschiesterl17', 'Jd8H36', 'CEtZ4b', 502, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (45, 'Rosalia', 'Breakspear', 'https://robohash.org/aliasestdolor.jpg?size=50x50&set=set1', 'rbreakspear18@istockphoto.com', '714-572-1419', 'rbreakspear18', 'ykq1jXQW', 'aC6P6QcB', 501, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (46, 'Cathie', 'Curgenven', 'https://robohash.org/atquemolestiaeet.jpg?size=50x50&set=set1', 'ccurgenven19@abc.net.au', '507-145-4579', 'ccurgenven19', '4cCWs26A', 'ohAUOrN', 503, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (47, 'Ezequiel', 'Wreford', 'https://robohash.org/iustoabsint.jpg?size=50x50&set=set1', 'ewreford1a@constantcontact.com', '809-173-5468', 'ewreford1a', 'YebrtHs', 'ijdWChb', 506, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (48, 'Inger', 'Cawthra', 'https://robohash.org/numquamfugiatnecessitatibus.bmp?size=50x50&set=set1', 'icawthra1b@hhs.gov', '567-167-4639', 'icawthra1b', 'vcmI0Jenb', 'HkyKLJjZrQ', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (49, 'Jena', 'Cheek', 'https://robohash.org/deserunttenetursed.jpg?size=50x50&set=set1', 'jcheek1c@indiatimes.com', '231-918-2837', 'jcheek1c', 'RGy4W2v8MN', 'DuEgFw6QYlDx', 502, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (50, 'Tomlin', 'McQuie', 'https://robohash.org/quasatut.jpg?size=50x50&set=set1', 'tmcquie1d@goodreads.com', '934-192-2208', 'tmcquie1d', 'xmXnNmfC5', 'hinFAiT7gM', 506, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (51, 'Inglebert', 'Fragino', 'https://robohash.org/eoseumaperiam.bmp?size=50x50&set=set1', 'ifragino1e@msu.edu', '158-137-1129', 'ifragino1e', '4g5PMOs', 'bfMiIqE', 502, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (52, 'Falkner', 'Slater', 'https://robohash.org/autfugitautem.png?size=50x50&set=set1', 'fslater1f@dropbox.com', '294-153-6048', 'fslater1f', 'mxKUURbXAe7', 'Kpk6ZqJ', 505, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (53, 'Sergent', 'Sunshine', 'https://robohash.org/explicaboducimusvoluptas.jpg?size=50x50&set=set1', 'ssunshine1g@blog.com', '775-469-1013', 'ssunshine1g', 'OQA0LAwES', 'zPJRAbhRsGt', 502, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (54, 'Arny', 'Pharro', 'https://robohash.org/quodoloremvoluptatem.jpg?size=50x50&set=set1', 'apharro1h@patch.com', '205-345-3904', 'apharro1h', 'CN9pZK1m', '6b52vjNOohUl', 503, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (55, 'Duff', 'D''Oyly', 'https://robohash.org/quamcumquevoluptate.bmp?size=50x50&set=set1', 'ddoyly1i@google.com', '973-808-5390', 'ddoyly1i', 'd7s9zDS6b', 'LbBUMQ', 506, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (56, 'Marjie', 'Griss', 'https://robohash.org/suntisteanimi.bmp?size=50x50&set=set1', 'mgriss1j@booking.com', '184-636-0434', 'mgriss1j', 'pa7GiF7', 'CeiWbgGHIR3s', 505, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (57, 'Antonina', 'Fahrenbach', 'https://robohash.org/sintpariaturquos.png?size=50x50&set=set1', 'afahrenbach1k@businessweek.com', '708-781-3081', 'afahrenbach1k', 'mgr9oQGDeHF', '7fxQ7iD', 506, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (58, 'Mitchael', 'Abson', 'https://robohash.org/magnamdoloremqueconsequatur.bmp?size=50x50&set=set1', 'mabson1l@seesaa.net', '780-138-8371', 'mabson1l', 'A1IOPFKdiyE', '7AhAiVkw', 502, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (59, 'Starlene', 'Smiz', 'https://robohash.org/doloremsuscipitimpedit.jpg?size=50x50&set=set1', 'ssmiz1m@xinhuanet.com', '556-471-9353', 'ssmiz1m', '9wxBjYJNX', 'OZlg95P1p', 504, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (60, 'Domenic', 'Trollope', 'https://robohash.org/dignissimosetdebitis.bmp?size=50x50&set=set1', 'dtrollope1n@gravatar.com', '953-523-7489', 'dtrollope1n', 'gUsJhVJY', 'EnO45CrLzo7', 504, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (61, 'Stacy', 'Shrigley', 'https://robohash.org/laboriosameiuscum.bmp?size=50x50&set=set1', 'sshrigley1o@ca.gov', '323-616-6048', 'sshrigley1o', 'FOrhc7LHFVES', 'Msuq235y', 506, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (62, 'Fredrick', 'Castanie', 'https://robohash.org/necessitatibusessesit.jpg?size=50x50&set=set1', 'fcastanie1p@globo.com', '859-726-6841', 'fcastanie1p', 'ricYxrGVEF', 'ep1XU6ECyb', 502, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (63, 'Foster', 'Tippings', 'https://robohash.org/eaaliquidea.jpg?size=50x50&set=set1', 'ftippings1q@loc.gov', '812-138-7715', 'ftippings1q', '7SGBdq54P0', '7aMfHvM9e3d', 502, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (64, 'Elias', 'Linfield', 'https://robohash.org/nostrumvitaedelectus.jpg?size=50x50&set=set1', 'elinfield1r@earthlink.net', '778-943-3590', 'elinfield1r', 'rDCJwPdy', 'dEl9n8WFoHuG', 502, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (65, 'Cathee', 'Leddie', 'https://robohash.org/utetminima.bmp?size=50x50&set=set1', 'cleddie1s@fda.gov', '584-547-6100', 'cleddie1s', 'aR4EpZC04u9', 'B0nOd2byrFqU', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (66, 'Alisander', 'Jancy', 'https://robohash.org/magnamquosquo.bmp?size=50x50&set=set1', 'ajancy1t@vkontakte.ru', '261-482-8433', 'ajancy1t', 'F40N9y8geRd', 'mVLomZ05CnLP', 501, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (67, 'Pryce', 'Denisyuk', 'https://robohash.org/laborumpraesentiumconsequuntur.jpg?size=50x50&set=set1', 'pdenisyuk1u@tuttocitta.it', '873-121-9728', 'pdenisyuk1u', 'Ua1KZMGr65D', 'XXN1LHlEypYj', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (68, 'Neville', 'Wishkar', 'https://robohash.org/mollitiavoluptatibussaepe.png?size=50x50&set=set1', 'nwishkar1v@hhs.gov', '962-465-8475', 'nwishkar1v', 'KaVfutZ2QRDq', 'wWFdExQK', 504, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (69, 'Darrin', 'Folshom', 'https://robohash.org/dolorearumarchitecto.bmp?size=50x50&set=set1', 'dfolshom1w@creativecommons.org', '449-128-7503', 'dfolshom1w', 'ibKD9FOHuu', 'O0duiUH75hYw', 504, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (70, 'Gordan', 'Guerreiro', 'https://robohash.org/ipsameaet.bmp?size=50x50&set=set1', 'gguerreiro1x@blogspot.com', '663-976-2672', 'gguerreiro1x', 'Hiw46XegApp', 'bL0IdqTDFsHy', 506, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (71, 'Blythe', 'Flewett', 'https://robohash.org/aliasnumquamsed.png?size=50x50&set=set1', 'bflewett1y@who.int', '757-760-5025', 'bflewett1y', 'QpHkhRiqDJ', 'jk8sqJ0', 505, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (72, 'Lorna', 'Claye', 'https://robohash.org/debitiscorruptimagnam.bmp?size=50x50&set=set1', 'lclaye1z@printfriendly.com', '773-683-0226', 'lclaye1z', 'JSXQUIwQCWE', 'K2mA01esO', 503, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (73, 'Adrienne', 'Coultar', 'https://robohash.org/asperioresvoluptatemsoluta.png?size=50x50&set=set1', 'acoultar20@sogou.com', '216-712-3428', 'acoultar20', '9sqiQ8CgqZG', 'MqFX2E9kGJj', 504, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (74, 'Rebe', 'Knellen', 'https://robohash.org/nonaccusantiumet.jpg?size=50x50&set=set1', 'rknellen21@ifeng.com', '242-355-7091', 'rknellen21', 'ehNU496a4', 'MbIAoDXxA', 503, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (75, 'Raina', 'Adelberg', 'https://robohash.org/erroripsamaliquid.bmp?size=50x50&set=set1', 'radelberg22@oaic.gov.au', '851-470-3438', 'radelberg22', 'CHGouCvaik', '50eItqKE4cz', 506, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (76, 'Adams', 'Mora', 'https://robohash.org/architectoexcepturinam.png?size=50x50&set=set1', 'amora23@oracle.com', '748-838-8448', 'amora23', '6off9EI1QUQ', 'uT7tjB9zx', 502, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (77, 'Wendi', 'Ick', 'https://robohash.org/accusantiumveritatisearum.jpg?size=50x50&set=set1', 'wick24@canalblog.com', '813-202-4765', 'wick24', 'mMx38D33AE', 'ByaSYa3sDy6', 503, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (78, 'Constanta', 'Ianittello', 'https://robohash.org/suntinlabore.bmp?size=50x50&set=set1', 'cianittello25@zdnet.com', '164-634-0745', 'cianittello25', 'rYD8TDx', 'INyK44f6x', 505, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (79, 'Alexia', 'Gammage', 'https://robohash.org/dictavoluptatibusofficiis.png?size=50x50&set=set1', 'agammage26@nature.com', '511-783-6683', 'agammage26', 'TnkeD6G9owTm', 'v77JTlw', 505, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (80, 'Zed', 'Simonaitis', 'https://robohash.org/cupiditateeligendinihil.png?size=50x50&set=set1', 'zsimonaitis27@privacy.gov.au', '298-632-3484', 'zsimonaitis27', 'Wn2EcTZ4D', 'qY1ksM', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (81, 'Bronny', 'Heliot', 'https://robohash.org/ipsamnisiaut.png?size=50x50&set=set1', 'bheliot28@admin.ch', '877-419-4644', 'bheliot28', 'KlBEKA4oND', 'cAqeIEDxp2', 501, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (82, 'Hailey', 'Kinig', 'https://robohash.org/voluptaterepudiandaeomnis.bmp?size=50x50&set=set1', 'hkinig29@dion.ne.jp', '821-900-5808', 'hkinig29', 'ZbuUJs', 'H07nyyLwzApF', 502, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (83, 'Andromache', 'Makinson', 'https://robohash.org/quiquosin.bmp?size=50x50&set=set1', 'amakinson2a@soundcloud.com', '958-877-1650', 'amakinson2a', 'BP7rBz', 'ubshdie4OCA', 504, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (84, 'Orelie', 'Merrick', 'https://robohash.org/liberorerumminima.png?size=50x50&set=set1', 'omerrick2b@phoca.cz', '826-843-6716', 'omerrick2b', 'g7kwbV40rF', 'q8KyCDEcXt', 504, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (85, 'Spenser', 'Stiven', 'https://robohash.org/aliquampariaturaspernatur.jpg?size=50x50&set=set1', 'sstiven2c@discuz.net', '702-996-3191', 'sstiven2c', 'jF5exV6rc', '4pYCeD68Ie', 505, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (86, 'Mellisa', 'Brader', 'https://robohash.org/officiiscommodiet.bmp?size=50x50&set=set1', 'mbrader2d@timesonline.co.uk', '667-711-7450', 'mbrader2d', 'KGEGkPhfVOt', 'nmaRFzo', 506, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (87, 'Sebastiano', 'Bosdet', 'https://robohash.org/utrecusandaeassumenda.png?size=50x50&set=set1', 'sbosdet2e@lulu.com', '154-349-9326', 'sbosdet2e', 'zAydwgb7BYs4', 'gzwd4Ovghjr', 506, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (88, 'Felipa', 'Aylward', 'https://robohash.org/molestiaeetoptio.bmp?size=50x50&set=set1', 'faylward2f@ehow.com', '507-314-7065', 'faylward2f', 'S5AgqapVe', '4fEGYAAxDr', 502, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (89, 'Sandor', 'Yakovliv', 'https://robohash.org/sitaspernaturquia.png?size=50x50&set=set1', 'syakovliv2g@scribd.com', '914-916-2419', 'syakovliv2g', 'Kdbah4', 'WT19HYa', 505, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (90, 'Quent', 'Pedrol', 'https://robohash.org/dolorumvoluptasreprehenderit.bmp?size=50x50&set=set1', 'qpedrol2h@wikia.com', '285-841-5521', 'qpedrol2h', '3LYL8cLze', 'CXIpVxF6bdWI', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (91, 'Marge', 'Carslaw', 'https://robohash.org/utsuscipitdebitis.png?size=50x50&set=set1', 'mcarslaw2i@uiuc.edu', '767-226-4181', 'mcarslaw2i', 'FVFNouWemN8', 'Ndug1M1', 502, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (92, 'Beatrix', 'Carville', 'https://robohash.org/assumendadoloribusdistinctio.png?size=50x50&set=set1', 'bcarville2j@moonfruit.com', '185-293-5332', 'bcarville2j', '4k2nMgDO', '10k6jTA4eEe', 501, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (93, 'Holmes', 'Bellenie', 'https://robohash.org/aliaseta.jpg?size=50x50&set=set1', 'hbellenie2k@discuz.net', '665-901-1282', 'hbellenie2k', 'fMuJvFvl1NK', 'tcfMDdNI8', 504, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (94, 'Franciska', 'Pughe', 'https://robohash.org/quisuteveniet.jpg?size=50x50&set=set1', 'fpughe2l@bing.com', '446-392-1869', 'fpughe2l', 'Mmo67yJr', '8miPQtLMwMCc', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (95, 'Maxwell', 'Pagram', 'https://robohash.org/laudantiumsedet.jpg?size=50x50&set=set1', 'mpagram2m@loc.gov', '333-637-1765', 'mpagram2m', 'qvcUXmi', '5dH1z8ame', 503, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (96, 'Dayle', 'Hukin', 'https://robohash.org/voluptateserroraccusantium.bmp?size=50x50&set=set1', 'dhukin2n@indiegogo.com', '318-226-5725', 'dhukin2n', '8M2JoAdv', '1vCsiPy', 505, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (97, 'Rhetta', 'Frowde', 'https://robohash.org/remrepellendusfugit.bmp?size=50x50&set=set1', 'rfrowde2o@storify.com', '454-256-2329', 'rfrowde2o', 'O67qpL', 'RjqCBW1zO', 506, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (98, 'Kerrie', 'Aronsohn', 'https://robohash.org/quisuscipitipsa.jpg?size=50x50&set=set1', 'karonsohn2p@dell.com', '250-472-1415', 'karonsohn2p', 'nGiB5U', 'ekZaW5O3R5', 504, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (99, 'Minnnie', 'Herkess', 'https://robohash.org/velitvelprovident.bmp?size=50x50&set=set1', 'mherkess2q@drupal.org', '204-455-2424', 'mherkess2q', 'ru53Zxsu34f', 'c9qtsxh1dQi', 506, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (100, 'Marlene', 'Canning', 'https://robohash.org/magnamesseatque.png?size=50x50&set=set1', 'mcanning2r@topsy.com', '542-987-4951', 'mcanning2r', 'iAYtiav', 'IeUQa8V', 504, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (101, 'Scotty', 'Godfrey', 'https://robohash.org/recusandaeharumvelit.jpg?size=50x50&set=set1', 'sgodfrey2s@thetimes.co.uk', '111-811-3616', 'sgodfrey2s', 'CnIEJT4ZOhC', 'Aue08kxR0', 504, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (102, 'Ninetta', 'Isselee', 'https://robohash.org/sitblanditiisunde.bmp?size=50x50&set=set1', 'nisselee2t@fotki.com', '575-946-6683', 'nisselee2t', '3ZpRSDE', 'uODeqe', 506, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (103, 'Timmie', 'Berringer', 'https://robohash.org/dolorinventorevoluptatum.png?size=50x50&set=set1', 'tberringer2u@ucla.edu', '463-634-6981', 'tberringer2u', 'T1MKGiTL7r', 'KdXH1db', 506, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (104, 'Audre', 'Jereatt', 'https://robohash.org/laborumnisiodio.jpg?size=50x50&set=set1', 'ajereatt2v@about.me', '990-570-7560', 'ajereatt2v', 'nwv6dYv3TxpM', 'bC80IQ', 505, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (105, 'Ernestine', 'Hawsby', 'https://robohash.org/nisidoloribusomnis.png?size=50x50&set=set1', 'ehawsby2w@live.com', '197-594-7615', 'ehawsby2w', 'QzWXfHbdFGs', '1KdOtbEf', 502, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (106, 'Gradey', 'Miettinen', 'https://robohash.org/eligendiautquidem.jpg?size=50x50&set=set1', 'gmiettinen2x@joomla.org', '944-414-7635', 'gmiettinen2x', 'KaPgikx', 'tVFC0T', 505, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (107, 'Mab', 'Cree', 'https://robohash.org/distinctioinciduntrepudiandae.jpg?size=50x50&set=set1', 'mcree2y@spotify.com', '462-925-8107', 'mcree2y', 'CdZNnBzDw', 'Mo77QXZ3Gu', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (108, 'Beilul', 'Tearney', 'https://robohash.org/voluptateeaest.jpg?size=50x50&set=set1', 'btearney2z@slate.com', '892-300-5362', 'btearney2z', 'BdAmTPwn5If', 'aDH7ql8y', 505, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (109, 'Dougie', 'Allerton', 'https://robohash.org/velamollitia.jpg?size=50x50&set=set1', 'dallerton30@histats.com', '687-845-9325', 'dallerton30', 'YuDDggxH', 'eR6yHtgv', 501, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (110, 'Lorrie', 'Scrine', 'https://robohash.org/quorecusandaeenim.png?size=50x50&set=set1', 'lscrine31@infoseek.co.jp', '323-222-8850', 'lscrine31', 'BZyEMGe5gn', 'jMTf0PUn8', 501, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (111, 'Riva', 'Van', 'https://robohash.org/perspiciatisvoluptasnesciunt.bmp?size=50x50&set=set1', 'rvan32@accuweather.com', '980-639-0301', 'rvan32', 'BpkYthrlwPv1', 'aiwg0dBXzSWn', 504, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (112, 'Skipton', 'Grinstead', 'https://robohash.org/occaecativoluptatumvero.png?size=50x50&set=set1', 'sgrinstead33@topsy.com', '904-945-0226', 'sgrinstead33', '1FaCly', 'GO18au9aEI', 503, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (113, 'Sallyanne', 'Melsome', 'https://robohash.org/officiaassumendaipsa.png?size=50x50&set=set1', 'smelsome34@4shared.com', '270-770-6740', 'smelsome34', '4vmIfGDW', '8ZZjiXD65', 504, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (114, 'Gianna', 'Esp', 'https://robohash.org/quamveniamut.bmp?size=50x50&set=set1', 'gesp35@nih.gov', '765-190-7960', 'gesp35', '3iXPXDlt5DDd', 'EhjSpvL', 502, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (115, 'Agnola', 'Gidden', 'https://robohash.org/natusnullaaccusamus.png?size=50x50&set=set1', 'agidden36@chron.com', '395-942-9290', 'agidden36', 'SId4FXfR4l', 'W5cXxznr2', 502, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (116, 'Flin', 'Branton', 'https://robohash.org/namquiased.png?size=50x50&set=set1', 'fbranton37@scribd.com', '586-450-5702', 'fbranton37', '9rlOrX', 'HMH05nPUzGcH', 506, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (117, 'Denny', 'Welfair', 'https://robohash.org/etutdoloremque.jpg?size=50x50&set=set1', 'dwelfair38@fda.gov', '486-290-7513', 'dwelfair38', 'AxjEf4cExWwK', 'xhWFAtdqnd', 505, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (118, 'Billie', 'Ownsworth', 'https://robohash.org/cumqueetdebitis.png?size=50x50&set=set1', 'bownsworth39@businesswire.com', '105-224-2454', 'bownsworth39', '8VpSGbJgz5', 'ilNMPrRM4', 506, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (119, 'Willie', 'Francescozzi', 'https://robohash.org/estnequeenim.bmp?size=50x50&set=set1', 'wfrancescozzi3a@about.com', '292-450-3355', 'wfrancescozzi3a', 'AnBohFT', 'eSwoT8sGu', 501, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (120, 'Becki', 'Farress', 'https://robohash.org/estvelitaut.jpg?size=50x50&set=set1', 'bfarress3b@ifeng.com', '721-270-6347', 'bfarress3b', 'F3c6KodTE4ny', 'KD1TJAsQKB', 504, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (121, 'Izak', 'Newby', 'https://robohash.org/illomaximead.png?size=50x50&set=set1', 'inewby3c@hexun.com', '942-956-6346', 'inewby3c', 'ZDp4HOtU', 'xsjiQYXud', 506, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (122, 'Valentine', 'Southby', 'https://robohash.org/nullarerummollitia.jpg?size=50x50&set=set1', 'vsouthby3d@icio.us', '746-940-2047', 'vsouthby3d', 'S1FFKGlq', 'Bp3PvbdZy', 506, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (123, 'Enrica', 'Heynel', 'https://robohash.org/rerumuteveniet.png?size=50x50&set=set1', 'eheynel3e@nature.com', '508-462-8799', 'eheynel3e', 'SwrQakb', 'vzBe6BFzq', 504, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (124, 'Homer', 'Giraudo', 'https://robohash.org/nonquodenim.png?size=50x50&set=set1', 'hgiraudo3f@mapy.cz', '958-118-5223', 'hgiraudo3f', 'iNM1ULO1T', '1QiTGrNGJ', 502, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (125, 'Vassili', 'Boutwell', 'https://robohash.org/hicdoloremqueiure.bmp?size=50x50&set=set1', 'vboutwell3g@last.fm', '999-891-0756', 'vboutwell3g', 'eUdrArO', 'YeKQdlL7w', 505, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (126, 'Karoline', 'Klagge', 'https://robohash.org/excepturiaeos.bmp?size=50x50&set=set1', 'kklagge3h@howstuffworks.com', '814-943-6268', 'kklagge3h', '35dCUSL', 'Hoo6jqe', 503, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (127, 'Carlin', 'Freed', 'https://robohash.org/iureipsanesciunt.bmp?size=50x50&set=set1', 'cfreed3i@disqus.com', '502-389-4438', 'cfreed3i', 'OHwlFBDT', 'sulODcjimh0y', 501, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (128, 'Janaya', 'Bedward', 'https://robohash.org/distinctioametculpa.jpg?size=50x50&set=set1', 'jbedward3j@chronoengine.com', '450-664-7016', 'jbedward3j', 'VrSU0RoKu0N', 'GvdVmPkP', 506, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (129, 'Sasha', 'Slaney', 'https://robohash.org/omnisvelodio.png?size=50x50&set=set1', 'sslaney3k@instagram.com', '325-482-6230', 'sslaney3k', 'SJumoze', 'X3HjHgxB', 504, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (130, 'Juliane', 'Natte', 'https://robohash.org/estcumqueut.png?size=50x50&set=set1', 'jnatte3l@lulu.com', '183-764-7745', 'jnatte3l', '06idrQijzbzq', 'DFekEKn', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (131, 'Joelly', 'Mashro', 'https://robohash.org/delenitietcumque.jpg?size=50x50&set=set1', 'jmashro3m@theglobeandmail.com', '238-453-0768', 'jmashro3m', 'vxpqyN1iOW', '669qpXuR', 505, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (132, 'Della', 'Deesly', 'https://robohash.org/sitetratione.png?size=50x50&set=set1', 'ddeesly3n@fastcompany.com', '447-700-4171', 'ddeesly3n', 'dNtA2Pge4Y', 'w3y2xb', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (133, 'Winslow', 'Chasteau', 'https://robohash.org/laudantiumetdolor.jpg?size=50x50&set=set1', 'wchasteau3o@shutterfly.com', '123-701-0723', 'wchasteau3o', 'zjNV73CFC', 'tZb7NP', 504, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (134, 'Magdalena', 'Greeno', 'https://robohash.org/iureautdolorem.bmp?size=50x50&set=set1', 'mgreeno3p@soundcloud.com', '501-905-9543', 'mgreeno3p', '8e7fBPrSlg4', 'Mna4rEgUiB', 505, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (135, 'Pavia', 'Trodler', 'https://robohash.org/laudantiumquiaullam.png?size=50x50&set=set1', 'ptrodler3q@omniture.com', '512-364-3340', 'ptrodler3q', 'kizNP6', 'UJOArusOB', 506, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (136, 'Melony', 'Spreag', 'https://robohash.org/sinttenetursunt.png?size=50x50&set=set1', 'mspreag3r@tinypic.com', '657-772-3038', 'mspreag3r', '3llJFPxIln', 'DbtujIQ5Au', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (137, 'Mannie', 'Goble', 'https://robohash.org/pariaturvoluptasfugit.bmp?size=50x50&set=set1', 'mgoble3s@va.gov', '336-813-9891', 'mgoble3s', '1mzLdl', 'nM8XiWsNV', 505, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (138, 'Maud', 'Zmitrovich', 'https://robohash.org/auteosrepellat.bmp?size=50x50&set=set1', 'mzmitrovich3t@thetimes.co.uk', '715-250-5481', 'mzmitrovich3t', 'pD1oJU', 'HpoRt3Lvs', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (139, 'Pierce', 'Ivanisov', 'https://robohash.org/sitvoluptatemcumque.png?size=50x50&set=set1', 'pivanisov3u@studiopress.com', '140-801-3356', 'pivanisov3u', 'eGuOOod', 'u8kAEV', 501, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (140, 'Taber', 'Galer', 'https://robohash.org/suntquivoluptas.jpg?size=50x50&set=set1', 'tgaler3v@so-net.ne.jp', '142-228-7656', 'tgaler3v', '3BoIFAlI6oc', 'UyLTnwon9pr', 506, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (141, 'Massimo', 'Fensome', 'https://robohash.org/idexpeditavoluptatem.bmp?size=50x50&set=set1', 'mfensome3w@live.com', '718-615-8011', 'mfensome3w', 'r7XX72tnv8N', 'qwjgjWvY', 501, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (142, 'Faina', 'Dallman', 'https://robohash.org/veniamdoloresneque.bmp?size=50x50&set=set1', 'fdallman3x@quantcast.com', '597-777-1553', 'fdallman3x', 'Y78Fz2', 'yAepwFhS4T', 504, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (143, 'Nikolai', 'Vesty', 'https://robohash.org/sintdelectusquae.bmp?size=50x50&set=set1', 'nvesty3y@house.gov', '541-899-6345', 'nvesty3y', '8SuJaT3SnYN', 'b8Ogb4P', 504, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (144, 'Patin', 'Northill', 'https://robohash.org/temporibussuntconsequatur.png?size=50x50&set=set1', 'pnorthill3z@nih.gov', '731-955-6569', 'pnorthill3z', 'nahPNXv', 'Eo2mRAE', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (145, 'Selestina', 'Marlor', 'https://robohash.org/laudantiumdolornihil.png?size=50x50&set=set1', 'smarlor40@fotki.com', '216-472-1781', 'smarlor40', 'OoiGMe', 'PqDjIVLqo', 504, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (146, 'Jeramie', 'Abramcik', 'https://robohash.org/corruptiveroasperiores.jpg?size=50x50&set=set1', 'jabramcik41@blogspot.com', '919-341-5471', 'jabramcik41', 'mpoFaeT58', 'SRVSFxbEx', 506, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (147, 'Olivier', 'Bunker', 'https://robohash.org/accusamusquiapariatur.png?size=50x50&set=set1', 'obunker42@a8.net', '607-515-7915', 'obunker42', 'OcaYNDoH0oV', 'GYPCvE0VT', 505, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (148, 'Wyndham', 'Dunnet', 'https://robohash.org/corruptinesciuntquae.bmp?size=50x50&set=set1', 'wdunnet43@163.com', '364-728-1144', 'wdunnet43', 'SXZk4cqll2b', 'HkzUMUVCPq2L', 506, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (149, 'Joseito', 'Barkley', 'https://robohash.org/essenumquamut.png?size=50x50&set=set1', 'jbarkley44@over-blog.com', '163-573-8698', 'jbarkley44', 'n2eTXO', 'NBum3b', 505, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (150, 'Malvina', 'Gobel', 'https://robohash.org/doloraccusamusofficiis.png?size=50x50&set=set1', 'mgobel45@usa.gov', '333-416-9223', 'mgobel45', '3vy4gBs', 'Vmukug46sJXN', 504, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (151, 'Bruce', 'Wedon', 'https://robohash.org/cumquodelectus.png?size=50x50&set=set1', 'bwedon46@behance.net', '762-304-1957', 'bwedon46', 'JrrWqOPXN6', '9lLLqd07AE', 502, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (152, 'Kassandra', 'Roberti', 'https://robohash.org/sedsunteveniet.jpg?size=50x50&set=set1', 'kroberti47@themeforest.net', '864-104-3364', 'kroberti47', 'qZWbsMeA', 'SjEv8hvc7', 503, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (153, 'Zebadiah', 'Tryhorn', 'https://robohash.org/perspiciatisfacilisrepellat.jpg?size=50x50&set=set1', 'ztryhorn48@tripadvisor.com', '247-483-0139', 'ztryhorn48', 'dY7Eth', '0zUOMH7', 505, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (154, 'Stacee', 'Paddle', 'https://robohash.org/atqueundenobis.bmp?size=50x50&set=set1', 'spaddle49@aboutads.info', '262-252-7577', 'spaddle49', 'PXh8hJ', 'XbFkp79c', 501, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (155, 'Gradeigh', 'Rampton', 'https://robohash.org/estmolestiasquia.png?size=50x50&set=set1', 'grampton4a@aboutads.info', '614-940-4814', 'grampton4a', '3QO3ym', 'gf2giT', 502, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (156, 'Land', 'Wolfinger', 'https://robohash.org/auteaimpedit.png?size=50x50&set=set1', 'lwolfinger4b@cpanel.net', '776-236-5755', 'lwolfinger4b', 'IjFVymjvBf', 'BitYyuukeQZV', 502, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (157, 'Cyndy', 'Dufoure', 'https://robohash.org/nihilfugadolores.jpg?size=50x50&set=set1', 'cdufoure4c@yelp.com', '608-174-3830', 'cdufoure4c', '0apcYy4SI3', 'Hd6S3CyIWO0', 505, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (158, 'Reamonn', 'Garvey', 'https://robohash.org/solutaisteofficia.bmp?size=50x50&set=set1', 'rgarvey4d@dedecms.com', '684-728-4953', 'rgarvey4d', 'ei37ZJD', 'dqCp86iC', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (159, 'Thaine', 'Haliburn', 'https://robohash.org/solutaofficiislaboriosam.png?size=50x50&set=set1', 'thaliburn4e@nytimes.com', '304-194-8486', 'thaliburn4e', 'U5jNsp', 'DA5ZqLS5AIy', 505, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (160, 'Magdalen', 'Sailor', 'https://robohash.org/ametveliteos.jpg?size=50x50&set=set1', 'msailor4f@reference.com', '195-566-1765', 'msailor4f', 'kaDZeJuOT20Q', 'LtepxQ78B4', 506, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (161, 'Clarisse', 'Doswell', 'https://robohash.org/quasiautdicta.bmp?size=50x50&set=set1', 'cdoswell4g@hugedomains.com', '194-292-5320', 'cdoswell4g', 'oT5TBra7eh5B', 'bBZTsBNiJWN', 501, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (162, 'Eden', 'Hulbert', 'https://robohash.org/quasaccusamusmagni.bmp?size=50x50&set=set1', 'ehulbert4h@tinyurl.com', '652-507-3157', 'ehulbert4h', 'OXwv72', 'dtp5jek687R', 504, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (163, 'Nikaniki', 'Heinicke', 'https://robohash.org/dignissimosoditdicta.jpg?size=50x50&set=set1', 'nheinicke4i@sun.com', '290-949-2505', 'nheinicke4i', 'OuBYHasC', '2AtaDJhmT', 505, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (164, 'Rustin', 'Folli', 'https://robohash.org/sapientevoluptatibusaut.jpg?size=50x50&set=set1', 'rfolli4j@webnode.com', '353-513-0423', 'rfolli4j', 'lSVlW2n27iSC', 'cBkpujW0aave', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (165, 'Gard', 'Petrusch', 'https://robohash.org/nisiipsamsunt.png?size=50x50&set=set1', 'gpetrusch4k@cbslocal.com', '549-171-6493', 'gpetrusch4k', 'o1Zy0L', 'fodm4PO', 501, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (166, 'Seymour', 'Folds', 'https://robohash.org/uteapraesentium.bmp?size=50x50&set=set1', 'sfolds4l@merriam-webster.com', '230-464-1409', 'sfolds4l', 'BmrfPWykI', 've7uaoj4O7', 505, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (167, 'Gaspar', 'Mattea', 'https://robohash.org/molestiasvelmagni.bmp?size=50x50&set=set1', 'gmattea4m@go.com', '815-361-7594', 'gmattea4m', 'vU1c2L0J', 'qY6OUi', 503, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (168, 'Dill', 'De''Vere - Hunt', 'https://robohash.org/nequedolorumoptio.jpg?size=50x50&set=set1', 'ddeverehunt4n@merriam-webster.com', '246-539-7400', 'ddeverehunt4n', 'uz9zNflE1fX', '74OmtCp6vGZ0', 502, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (169, 'Annis', 'Stirley', 'https://robohash.org/sapienteutsoluta.bmp?size=50x50&set=set1', 'astirley4o@mapy.cz', '865-867-8897', 'astirley4o', 'HINOplH', 'hmU6Mqc8x', 505, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (170, 'Bridgette', 'Puleston', 'https://robohash.org/etconsequatursuscipit.bmp?size=50x50&set=set1', 'bpuleston4p@sohu.com', '135-937-4444', 'bpuleston4p', 'pHf7c6zU', '3oCLsgiq', 505, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (171, 'Crosby', 'McGenn', 'https://robohash.org/molestiaeevenietsint.jpg?size=50x50&set=set1', 'cmcgenn4q@answers.com', '978-420-7209', 'cmcgenn4q', 'iI3YP5jjWfg', '7lEs6VYi', 501, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (172, 'Violetta', 'Stuck', 'https://robohash.org/distinctioremerror.bmp?size=50x50&set=set1', 'vstuck4r@shutterfly.com', '812-587-5407', 'vstuck4r', '0cD1jD4', '6KJVFlxyEuG', 504, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (173, 'Irita', 'Videneev', 'https://robohash.org/etullamrerum.bmp?size=50x50&set=set1', 'ivideneev4s@un.org', '548-634-5260', 'ivideneev4s', 'nOrRnENrb', 'cNgIrmpJGM', 501, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (174, 'Hally', 'Jaegar', 'https://robohash.org/quinequefacilis.bmp?size=50x50&set=set1', 'hjaegar4t@stumbleupon.com', '635-225-8935', 'hjaegar4t', 'LB7onh6i3s', 'QOZBzOoUR', 501, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (175, 'Danika', 'Shadwick', 'https://robohash.org/adipiscisimiliqueratione.bmp?size=50x50&set=set1', 'dshadwick4u@jugem.jp', '680-357-5402', 'dshadwick4u', 'fT4jtOd5y', 'yJnQaKc3', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (176, 'Gabby', 'Townsley', 'https://robohash.org/dolorumharumet.bmp?size=50x50&set=set1', 'gtownsley4v@patch.com', '386-272-1344', 'gtownsley4v', 'TbCuhLCgD3u', '3YPM3OV', 506, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (177, 'Bendick', 'Keyser', 'https://robohash.org/auttotamimpedit.bmp?size=50x50&set=set1', 'bkeyser4w@opera.com', '750-189-7196', 'bkeyser4w', 'bpVJcVg', 'abbtrJBubw', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (178, 'Bekki', 'Kareman', 'https://robohash.org/utistesed.jpg?size=50x50&set=set1', 'bkareman4x@clickbank.net', '653-369-0341', 'bkareman4x', 'jOyU2GFhq', 'tKXGf7cIwHb', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (179, 'Netty', 'Bonnick', 'https://robohash.org/explicaboperspiciatissuscipit.jpg?size=50x50&set=set1', 'nbonnick4y@geocities.com', '635-364-6467', 'nbonnick4y', 'iCKR5m', 'WTcwtKSNH', 504, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (180, 'Klement', 'Roswarne', 'https://robohash.org/laboreremquia.bmp?size=50x50&set=set1', 'kroswarne4z@tinyurl.com', '712-385-1658', 'kroswarne4z', 'SAtLwd0M3UU', 'sUJFh7Xjbs', 506, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (181, 'Luciana', 'Annell', 'https://robohash.org/nonautvitae.jpg?size=50x50&set=set1', 'lannell50@wp.com', '710-971-1163', 'lannell50', 'UuwtID2xPy', 'EJl4yrGb1Ug', 506, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (182, 'Frederich', 'Shearer', 'https://robohash.org/rerumsuscipitdolor.bmp?size=50x50&set=set1', 'fshearer51@google.pl', '307-740-2407', 'fshearer51', 'Z9au390C', '1I6zyuD', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (183, 'Janka', 'Antosik', 'https://robohash.org/quosquiaodit.jpg?size=50x50&set=set1', 'jantosik52@sbwire.com', '348-181-8163', 'jantosik52', 'fQeQhZNGCf', 'SG4qpVil', 503, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (184, 'Julienne', 'Bockin', 'https://robohash.org/ipsameaqueaut.jpg?size=50x50&set=set1', 'jbockin53@dropbox.com', '277-980-3448', 'jbockin53', 'gydZIvx0Nst', 'ul4P3hd4J7i', 504, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (185, 'Brander', 'Gabriely', 'https://robohash.org/verodoloremculpa.bmp?size=50x50&set=set1', 'bgabriely54@ca.gov', '287-484-0047', 'bgabriely54', 'a1ntEgvJ2Mw', 'G3DbEbw61x8v', 505, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (186, 'Ursala', 'Woodbridge', 'https://robohash.org/doloreessevoluptates.png?size=50x50&set=set1', 'uwoodbridge55@gov.uk', '217-207-3829', 'uwoodbridge55', '2ijBiuiPMG45', 'K9k6ZDm8C', 503, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (187, 'Shermy', 'Arnfield', 'https://robohash.org/corruptiquaenon.png?size=50x50&set=set1', 'sarnfield56@yelp.com', '900-516-8680', 'sarnfield56', 'r4smil', 'hoERrBdG', 501, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (188, 'Lotty', 'Harrell', 'https://robohash.org/reprehenderitharumodit.bmp?size=50x50&set=set1', 'lharrell57@networkadvertising.org', '877-504-0858', 'lharrell57', '9nfCXI98O', 'RL54WeHvuj', 506, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (189, 'Maia', 'Burry', 'https://robohash.org/reprehenderitetdeserunt.bmp?size=50x50&set=set1', 'mburry58@omniture.com', '295-909-6522', 'mburry58', 'pVgkd5e', 'tZXsnbF1', 502, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (190, 'Denys', 'McIlwraith', 'https://robohash.org/utfaceresuscipit.bmp?size=50x50&set=set1', 'dmcilwraith59@devhub.com', '442-928-3759', 'dmcilwraith59', 'QJsu4KAo3d', 'cvXuoqAlhW', 504, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (191, 'Christen', 'Borsnall', 'https://robohash.org/evenietnullanihil.jpg?size=50x50&set=set1', 'cborsnall5a@360.cn', '590-998-6848', 'cborsnall5a', 'EKeaioATHgHV', '76sQPqFeG', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (192, 'Tammy', 'Netti', 'https://robohash.org/etquisest.jpg?size=50x50&set=set1', 'tnetti5b@vimeo.com', '344-414-8390', 'tnetti5b', 'b87My3fav', 'eQ38uv', 501, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (193, 'Giulio', 'McIlvoray', 'https://robohash.org/ipsamillosint.png?size=50x50&set=set1', 'gmcilvoray5c@netscape.com', '940-621-4032', 'gmcilvoray5c', '5hN7lxv', 'iBTKgSsfrU', 506, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (194, 'Shalna', 'Pendlebury', 'https://robohash.org/totamsimiliqueexercitationem.png?size=50x50&set=set1', 'spendlebury5d@timesonline.co.uk', '210-163-8577', 'spendlebury5d', 'hASEaw', '9AwdoQ', 506, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (195, 'Aurie', 'Doswell', 'https://robohash.org/enimvoluptatemsuscipit.bmp?size=50x50&set=set1', 'adoswell5e@chronoengine.com', '378-187-4981', 'adoswell5e', 'TUFrV0IryW', 'xlthymtpn', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (196, 'Isabelita', 'Kleinzweig', 'https://robohash.org/quaerathicdeserunt.png?size=50x50&set=set1', 'ikleinzweig5f@washingtonpost.com', '190-711-3865', 'ikleinzweig5f', 'pzXTHe', '7Qrfrw2F', 505, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (197, 'Farand', 'Pirdue', 'https://robohash.org/cumducimusipsum.bmp?size=50x50&set=set1', 'fpirdue5g@stanford.edu', '801-337-6917', 'fpirdue5g', '7VPoC9', 'ftHR3qvOoAED', 504, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (198, 'Maressa', 'Bugler', 'https://robohash.org/eumvoluptatemcommodi.bmp?size=50x50&set=set1', 'mbugler5h@cloudflare.com', '678-632-5681', 'mbugler5h', 'r9PN3J7SH', 'EFaCk5Ddb', 506, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (199, 'Kris', 'Ridwood', 'https://robohash.org/hicextempora.jpg?size=50x50&set=set1', 'kridwood5i@pcworld.com', '530-646-3258', 'kridwood5i', 'neA2zpK', 'AfPliVFSF', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (200, 'Rubie', 'Pashler', 'https://robohash.org/doloremquefugitpariatur.jpg?size=50x50&set=set1', 'rpashler5j@infoseek.co.jp', '233-366-1112', 'rpashler5j', 'xSWdhLA8n', 'HtMFHwk', 501, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (201, 'Annadiane', 'Leythley', 'https://robohash.org/doloremquiconsequatur.png?size=50x50&set=set1', 'aleythley5k@addtoany.com', '188-880-1070', 'aleythley5k', '2e2P3p', 'gsibhtd', 506, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (202, 'Nicholas', 'Houseman', 'https://robohash.org/cupiditatequodrepellat.bmp?size=50x50&set=set1', 'nhouseman5l@biblegateway.com', '878-654-9910', 'nhouseman5l', 'QHefqpZ0', '7JGio1rqRuxx', 506, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (203, 'Herbie', 'Epsley', 'https://robohash.org/reprehenderitaspernatureius.bmp?size=50x50&set=set1', 'hepsley5m@diigo.com', '247-883-8860', 'hepsley5m', 'ZvE83O7seQd6', 'w5BpyUVkbMok', 503, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (204, 'Phaidra', 'Gait', 'https://robohash.org/estipsumdoloremque.bmp?size=50x50&set=set1', 'pgait5n@tuttocitta.it', '497-118-0416', 'pgait5n', 'ZPC1VMbWxeXb', 'LcJ1uQGgIQm', 503, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (205, 'Sallyann', 'Sappy', 'https://robohash.org/ipsummolestiaevoluptatum.jpg?size=50x50&set=set1', 'ssappy5o@mashable.com', '578-322-8638', 'ssappy5o', 'YM7mmK8fb', 'G0HhRfe3Js', 506, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (206, 'Georgia', 'Antrack', 'https://robohash.org/inetimpedit.bmp?size=50x50&set=set1', 'gantrack5p@typepad.com', '992-927-4302', 'gantrack5p', 'dsYMUDZr', 'FZ4QTJ8k', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (207, 'Essa', 'Riddle', 'https://robohash.org/nonsuntquis.jpg?size=50x50&set=set1', 'eriddle5q@linkedin.com', '891-798-1434', 'eriddle5q', '4i49BDoG', 'ZOhkUOX08', 506, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (208, 'Madison', 'Ickovitz', 'https://robohash.org/placeatmolestiaenostrum.png?size=50x50&set=set1', 'mickovitz5r@odnoklassniki.ru', '313-855-2879', 'mickovitz5r', 'zKtOwrenVGV7', 'QFrUYNfV', 505, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (209, 'Jedediah', 'Matten', 'https://robohash.org/ettemporibusaccusantium.bmp?size=50x50&set=set1', 'jmatten5s@epa.gov', '114-630-3382', 'jmatten5s', 'o1G1q0DnN4z', '797SigZVf25', 505, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (210, 'Cherri', 'Lownsbrough', 'https://robohash.org/perferendisnequesed.png?size=50x50&set=set1', 'clownsbrough5t@cnet.com', '259-337-0638', 'clownsbrough5t', 'yrYC3sFDmp', 'jynrcMJJk', 501, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (211, 'Dael', 'Salvin', 'https://robohash.org/etnihilesse.png?size=50x50&set=set1', 'dsalvin5u@cpanel.net', '542-985-0261', 'dsalvin5u', 'nLiUWzcnJ2w', 'mzalCo', 505, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (212, 'Florida', 'Widdison', 'https://robohash.org/veleligendisaepe.jpg?size=50x50&set=set1', 'fwiddison5v@google.co.uk', '604-756-5902', 'fwiddison5v', 'Z6elDdsBNmj', 'vYzacHt5UuK', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (213, 'Waverly', 'Deam', 'https://robohash.org/nonatqueaut.bmp?size=50x50&set=set1', 'wdeam5w@elegantthemes.com', '562-928-7227', 'wdeam5w', 'KlscyH7Cv', 'IqNgVP', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (214, 'Leigh', 'Fetteplace', 'https://robohash.org/voluptatemrecusandaefugiat.bmp?size=50x50&set=set1', 'lfetteplace5x@quantcast.com', '407-334-0894', 'lfetteplace5x', 'V5hJov1OV', 'QkT3VrZwa4E', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (215, 'Lyndel', 'Gawith', 'https://robohash.org/solutaquiset.bmp?size=50x50&set=set1', 'lgawith5y@wp.com', '859-304-6282', 'lgawith5y', 'G8t8KLcXn', 'Mt0UDc0l5S', 506, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (216, 'Winston', 'Nagle', 'https://robohash.org/laborumfugitassumenda.bmp?size=50x50&set=set1', 'wnagle5z@howstuffworks.com', '599-990-0411', 'wnagle5z', 'jLs7fN', 'VCZLJXEQy', 502, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (217, 'Karalynn', 'Edgeon', 'https://robohash.org/idquodsunt.png?size=50x50&set=set1', 'kedgeon60@cnn.com', '596-490-1390', 'kedgeon60', 'C93Nprjg', 'nsbeIcTwSYA0', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (218, 'Wenda', 'Anwell', 'https://robohash.org/molestiasautemea.png?size=50x50&set=set1', 'wanwell61@parallels.com', '902-218-7131', 'wanwell61', 'zwF2fzraes', '2udoazo', 504, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (219, 'Kelsey', 'Orwin', 'https://robohash.org/aspernaturquaeratcorporis.bmp?size=50x50&set=set1', 'korwin62@sogou.com', '167-265-0408', 'korwin62', 'yfiXaNTV', 'oLxzTAE', 501, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (220, 'Evyn', 'Arp', 'https://robohash.org/temporibusilloconsequatur.png?size=50x50&set=set1', 'earp63@last.fm', '747-606-7781', 'earp63', 'dlitCfZmgQTy', 'QEAokxRmVx', 506, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (221, 'Nataline', 'Rocco', 'https://robohash.org/quidoloreseveniet.png?size=50x50&set=set1', 'nrocco64@bbb.org', '742-245-7675', 'nrocco64', 'ySsN4R3e', 'cN3lgUR73xT8', 506, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (222, 'Daisey', 'Lynnett', 'https://robohash.org/omnisquibusdamfuga.bmp?size=50x50&set=set1', 'dlynnett65@i2i.jp', '313-309-3698', 'dlynnett65', '13gRyD40ZKdo', 'yy8vjlrE', 502, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (223, 'Therine', 'Kelbie', 'https://robohash.org/officiisimpeditperspiciatis.png?size=50x50&set=set1', 'tkelbie66@sciencedaily.com', '771-852-3983', 'tkelbie66', 'DpFSpsP4q7AF', 'lVJqrNP8', 506, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (224, 'Ellette', 'Rippingale', 'https://robohash.org/essesimiliquedistinctio.png?size=50x50&set=set1', 'erippingale67@ehow.com', '437-149-4124', 'erippingale67', 'oq4lXI', 'DJtpB7mllOmQ', 505, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (225, 'Cherrita', 'Jeckell', 'https://robohash.org/laborevelitvoluptatum.bmp?size=50x50&set=set1', 'cjeckell68@ustream.tv', '288-668-2352', 'cjeckell68', 'eawPFMuan', 'Iw3GGxm3Dr', 502, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (226, 'Ashbey', 'Zanitti', 'https://robohash.org/velatquesoluta.bmp?size=50x50&set=set1', 'azanitti69@samsung.com', '884-456-1153', 'azanitti69', 'yVyPe6pMWstR', 'fG6aoqVAT48b', 504, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (227, 'Carol-jean', 'Crasford', 'https://robohash.org/utnullaquod.png?size=50x50&set=set1', 'ccrasford6a@google.cn', '302-144-9896', 'ccrasford6a', 'XSmmRhhUzBW', 'xXrL1XQTd', 505, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (228, 'Blair', 'Bengall', 'https://robohash.org/voluptasnatusquaerat.jpg?size=50x50&set=set1', 'bbengall6b@godaddy.com', '187-782-3377', 'bbengall6b', 'Ck6yUAHugBw8', 'Ukx2i5', 504, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (229, 'Galvan', 'Perigoe', 'https://robohash.org/illovelpossimus.bmp?size=50x50&set=set1', 'gperigoe6c@deviantart.com', '231-746-8950', 'gperigoe6c', 'jTArOxaN', 'AlBuicbPOjH', 505, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (230, 'Kameko', 'McGrale', 'https://robohash.org/quimagnisapiente.png?size=50x50&set=set1', 'kmcgrale6d@bravesites.com', '883-813-5310', 'kmcgrale6d', 'OtheUI0KTY', 'Un5HI2ooXSLv', 501, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (231, 'Brion', 'Esson', 'https://robohash.org/sedvoluptatererum.bmp?size=50x50&set=set1', 'besson6e@cdbaby.com', '889-815-7668', 'besson6e', 'bEGnEVN', 'WlHMlToBu', 506, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (232, 'Hedi', 'De Roberto', 'https://robohash.org/voluptatumutdistinctio.png?size=50x50&set=set1', 'hderoberto6f@telegraph.co.uk', '305-313-8284', 'hderoberto6f', '5rFfYzPttXJp', '0bGOTCYeRtb', 504, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (233, 'Arlyne', 'MacCostigan', 'https://robohash.org/vitaeveloptio.png?size=50x50&set=set1', 'amaccostigan6g@upenn.edu', '254-528-1637', 'amaccostigan6g', 'Y9EOK3MH', 'rnwbB4i22Y', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (234, 'Hussein', 'Ison', 'https://robohash.org/reprehenderitvoluptatemsequi.png?size=50x50&set=set1', 'hison6h@abc.net.au', '670-155-1488', 'hison6h', 'xzQVBgrz', '8sSnCYX6', 504, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (235, 'Walther', 'Lewsam', 'https://robohash.org/temporenecessitatibusad.jpg?size=50x50&set=set1', 'wlewsam6i@webs.com', '974-779-6583', 'wlewsam6i', 'xonf7X2', 'HU37Xl', 501, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (236, 'Hillie', 'Eliassen', 'https://robohash.org/necessitatibusadvoluptates.bmp?size=50x50&set=set1', 'heliassen6j@yellowbook.com', '790-177-4431', 'heliassen6j', '9oS5cHI', '41zTDS', 506, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (237, 'Ellsworth', 'Shaves', 'https://robohash.org/infugiatdolorum.png?size=50x50&set=set1', 'eshaves6k@cocolog-nifty.com', '340-592-3201', 'eshaves6k', 'FPkm1rvW', 'RAZSXxkN', 506, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (238, 'Lilian', 'Beckley', 'https://robohash.org/autsuscipitquia.bmp?size=50x50&set=set1', 'lbeckley6l@etsy.com', '741-681-9393', 'lbeckley6l', 'QVJ2vKvM', 'TgIDLIuL7kuM', 502, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (239, 'Kellyann', 'Youings', 'https://robohash.org/etrerumest.bmp?size=50x50&set=set1', 'kyouings6m@woothemes.com', '362-766-4397', 'kyouings6m', '3nUiwZwZ', '1KNxM6CgIR2', 506, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (240, 'Otha', 'Dumphy', 'https://robohash.org/culpaoptioillum.bmp?size=50x50&set=set1', 'odumphy6n@php.net', '246-608-8474', 'odumphy6n', 'u3bc3eh3NQK', 'QjWlaqECCWP', 505, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (241, 'Che', 'Brimming', 'https://robohash.org/temporibusperspiciatisaccusamus.jpg?size=50x50&set=set1', 'cbrimming6o@alexa.com', '183-368-9058', 'cbrimming6o', 'M1clCT', 'hIoJk6okX3U', 502, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (242, 'Chrystel', 'Diter', 'https://robohash.org/consequaturquiipsa.jpg?size=50x50&set=set1', 'cditer6p@wsj.com', '454-538-7572', 'cditer6p', 'cceoK7D0YbNn', 'omf7VWA1oW', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (243, 'Joannes', 'Bowra', 'https://robohash.org/dictaadipiscicorporis.bmp?size=50x50&set=set1', 'jbowra6q@creativecommons.org', '496-936-2054', 'jbowra6q', '0TLptEY', 'ChI0i1BlQM', 501, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (244, 'Helenka', 'Keele', 'https://robohash.org/quidemipsumet.png?size=50x50&set=set1', 'hkeele6r@tuttocitta.it', '536-848-3439', 'hkeele6r', 'IV0F4cLjg', 'fwZ37HS', 506, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (245, 'Joseph', 'Hailston', 'https://robohash.org/fugaharumsit.bmp?size=50x50&set=set1', 'jhailston6s@youtube.com', '779-349-1886', 'jhailston6s', 'Aoeq3S', 'FoMjEDnO', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (246, 'Giusto', 'Dixcee', 'https://robohash.org/perspiciatisplaceatnostrum.jpg?size=50x50&set=set1', 'gdixcee6t@example.com', '437-534-8228', 'gdixcee6t', 'lsBhX4', '3msL0Leq9h', 504, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (247, 'Saidee', 'Beevor', 'https://robohash.org/voluptasutporro.png?size=50x50&set=set1', 'sbeevor6u@lycos.com', '324-864-1723', 'sbeevor6u', 'rxecjFYb', 'wdc7hYOzugq', 502, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (248, 'Emmalynn', 'Cosby', 'https://robohash.org/doloremqueillumexplicabo.bmp?size=50x50&set=set1', 'ecosby6v@shop-pro.jp', '737-506-2122', 'ecosby6v', 'ZW9zXkNS3JN', 'ki3iOIp', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (249, 'Ronda', 'Harriott', 'https://robohash.org/doloribusdelectusrerum.jpg?size=50x50&set=set1', 'rharriott6w@cdc.gov', '961-416-0363', 'rharriott6w', 'MsXWd6', 'Jo075emsY', 505, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (250, 'Merell', 'Cristofalo', 'https://robohash.org/maximeisteeveniet.png?size=50x50&set=set1', 'mcristofalo6x@cdbaby.com', '103-890-9505', 'mcristofalo6x', 'pKLN0msB6vG', '0rnWaUE', 504, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (251, 'Ester', 'Adolphine', 'https://robohash.org/abquibusdamoptio.jpg?size=50x50&set=set1', 'eadolphine6y@eepurl.com', '343-238-9875', 'eadolphine6y', 'wMH7MIebhnqR', 'z6hGLvkl7', 506, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (252, 'Upton', 'Quantrell', 'https://robohash.org/voluptatibusutpossimus.png?size=50x50&set=set1', 'uquantrell6z@cdbaby.com', '579-860-1790', 'uquantrell6z', '8q74QbF0tC', 'EHn7TR', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (253, 'Abramo', 'Saxby', 'https://robohash.org/etsaepeodio.bmp?size=50x50&set=set1', 'asaxby70@pen.io', '401-899-5249', 'asaxby70', '3CAgiV', 'YwX4RAQB', 505, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (254, 'Effie', 'MacTrustam', 'https://robohash.org/quissuntplaceat.jpg?size=50x50&set=set1', 'emactrustam71@flavors.me', '465-559-8110', 'emactrustam71', 'tIHhbT', '9kUIi908Bli', 501, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (255, 'Germaine', 'Southernwood', 'https://robohash.org/laudantiumetrerum.jpg?size=50x50&set=set1', 'gsouthernwood72@wordpress.org', '598-720-1398', 'gsouthernwood72', 'A42m6f', '4nFUg5Kl', 506, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (256, 'Axel', 'Lamble', 'https://robohash.org/consequaturquiquisquam.bmp?size=50x50&set=set1', 'alamble73@tripadvisor.com', '520-924-7557', 'alamble73', 'EEzcEXOf', '7Dxoylz6So4', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (257, 'Steward', 'Casetti', 'https://robohash.org/iureassumendaab.png?size=50x50&set=set1', 'scasetti74@cbsnews.com', '182-777-3609', 'scasetti74', 'hnYLIp', 'UmpOeLsuqd', 504, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (258, 'Leonidas', 'Harcase', 'https://robohash.org/molestiaenisifugiat.png?size=50x50&set=set1', 'lharcase75@mapy.cz', '703-997-7794', 'lharcase75', 'aXBEsdqO', 'bvYksJXiBY', 504, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (259, 'Timmie', 'Bradbury', 'https://robohash.org/temporarepellatvoluptatem.bmp?size=50x50&set=set1', 'tbradbury76@about.me', '425-359-7452', 'tbradbury76', 'ofnxK4a4SU', 'hnlCGKz', 506, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (260, 'Paul', 'Brunn', 'https://robohash.org/porroatdolorem.png?size=50x50&set=set1', 'pbrunn77@techcrunch.com', '121-706-8788', 'pbrunn77', 'wXxYxsIfDG7J', 'PWqNEw', 503, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (261, 'Alfred', 'Dunphy', 'https://robohash.org/sequierrorsed.png?size=50x50&set=set1', 'adunphy78@ucsd.edu', '731-787-1516', 'adunphy78', '7q6ZyxQf2', 'aaYTsF1', 502, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (262, 'Christina', 'Poad', 'https://robohash.org/aliquidsintofficiis.png?size=50x50&set=set1', 'cpoad79@feedburner.com', '998-494-1992', 'cpoad79', 'uYc0uTwlw71', 'DckPtAY7k4s9', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (263, 'Dacie', 'Gentery', 'https://robohash.org/consequaturbeataeaut.png?size=50x50&set=set1', 'dgentery7a@github.com', '920-634-4005', 'dgentery7a', 'YsqkXluL', '8O6A9Ek', 503, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (264, 'Debby', 'Ferrick', 'https://robohash.org/liberoquisquamveniam.bmp?size=50x50&set=set1', 'dferrick7b@geocities.jp', '820-680-8101', 'dferrick7b', '3evSTuhIJqY', 'WsKEjiI', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (265, 'Regine', 'Avieson', 'https://robohash.org/recusandaehicsapiente.jpg?size=50x50&set=set1', 'ravieson7c@example.com', '140-934-3958', 'ravieson7c', 'gRTI8AGujh', 'FzWLCBotnetm', 501, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (266, 'Emmaline', 'Pharo', 'https://robohash.org/etetlabore.jpg?size=50x50&set=set1', 'epharo7d@icq.com', '917-177-2178', 'epharo7d', 'jckxFF5GBkis', '9pHgvk', 503, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (267, 'Rudyard', 'Derkes', 'https://robohash.org/ipsumaliasaut.jpg?size=50x50&set=set1', 'rderkes7e@jigsy.com', '936-181-0274', 'rderkes7e', 'HoXTm67jk8D', 'T3KOxrscnbD', 503, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (268, 'Berkly', 'Hilldrop', 'https://robohash.org/dolordoloribusquis.png?size=50x50&set=set1', 'bhilldrop7f@weibo.com', '386-773-1897', 'bhilldrop7f', 'z7xGn69VSfj', 'nEf0ep7Fw2o', 506, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (269, 'Carly', 'Martinello', 'https://robohash.org/itaquererumut.png?size=50x50&set=set1', 'cmartinello7g@accuweather.com', '908-697-6818', 'cmartinello7g', 'EYoEVF', 'SbbcmKV', 502, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (270, 'Sauveur', 'Sulter', 'https://robohash.org/aspernaturquamnobis.jpg?size=50x50&set=set1', 'ssulter7h@pbs.org', '215-889-7581', 'ssulter7h', 'hr31OLLp', 'bDj5PWK', 506, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (271, 'Zorine', 'Bansal', 'https://robohash.org/sequiiureautem.png?size=50x50&set=set1', 'zbansal7i@creativecommons.org', '843-978-0334', 'zbansal7i', 'Tgyaj1', 'e4sywSEXYM', 502, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (272, 'Lindi', 'Ching', 'https://robohash.org/itaqueetlaudantium.png?size=50x50&set=set1', 'lching7j@elegantthemes.com', '117-998-8378', 'lching7j', 'mNAo8Dk0Snvf', 'VUP1aRi', 506, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (273, 'Mitzi', 'Gotecliffe', 'https://robohash.org/enimdoloresut.bmp?size=50x50&set=set1', 'mgotecliffe7k@mozilla.com', '651-432-7149', 'mgotecliffe7k', 'qB3UDsmX', 'djb2Gi06', 506, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (274, 'Jordanna', 'Dreossi', 'https://robohash.org/veritatisabasperiores.bmp?size=50x50&set=set1', 'jdreossi7l@163.com', '626-981-2894', 'jdreossi7l', 'xmlOfl', 'FnGEqRePJ9wC', 502, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (275, 'Dael', 'Ambrosch', 'https://robohash.org/aliasesteaque.jpg?size=50x50&set=set1', 'dambrosch7m@smugmug.com', '774-887-6307', 'dambrosch7m', '4VvqaV', 'RVeWsW', 501, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (276, 'Liuka', 'Bellord', 'https://robohash.org/voluptasvitaeenim.png?size=50x50&set=set1', 'lbellord7n@alexa.com', '834-403-2021', 'lbellord7n', 'fg0Nnr', 'qkpWdiS8I', 505, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (277, 'Kristopher', 'Stihl', 'https://robohash.org/quamrerumautem.png?size=50x50&set=set1', 'kstihl7o@timesonline.co.uk', '568-327-9552', 'kstihl7o', 'cEKeir59PI', '8F8iSp', 501, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (278, 'Caritta', 'Yanov', 'https://robohash.org/magniiustoomnis.jpg?size=50x50&set=set1', 'cyanov7p@feedburner.com', '243-252-9445', 'cyanov7p', 'Af2mhk4R4', 'eJvfc4pqpX0M', 505, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (279, 'Devin', 'Longson', 'https://robohash.org/accusantiumdoloremquaerat.jpg?size=50x50&set=set1', 'dlongson7q@samsung.com', '747-321-8262', 'dlongson7q', 'AVnwxCEIc3', 'S41hTHFPRKPx', 501, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (280, 'Dedie', 'Bohea', 'https://robohash.org/etipsumaut.bmp?size=50x50&set=set1', 'dbohea7r@jimdo.com', '653-686-8690', 'dbohea7r', 'DmMj1x25k', 'B6RABon', 504, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (281, 'Gisele', 'Anthonsen', 'https://robohash.org/idetassumenda.png?size=50x50&set=set1', 'ganthonsen7s@newsvine.com', '391-128-7435', 'ganthonsen7s', 'U8lCsr', 'vzFaE9WNK', 502, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (282, 'Lauretta', 'Stanmer', 'https://robohash.org/nullaimpeditreiciendis.jpg?size=50x50&set=set1', 'lstanmer7t@plala.or.jp', '489-778-5988', 'lstanmer7t', 'QcajKW7pR', '1AVOXOC22', 501, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (283, 'Sukey', 'Le Leu', 'https://robohash.org/nostrumconsecteturut.png?size=50x50&set=set1', 'sleleu7u@globo.com', '659-124-4977', 'sleleu7u', 'wYlDwv', 'SmI7G1h', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (284, 'Elsie', 'Philippart', 'https://robohash.org/etrerumminus.jpg?size=50x50&set=set1', 'ephilippart7v@jalbum.net', '327-131-0515', 'ephilippart7v', 'mVIqiOEwnomf', 'CUJoB5EP', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (285, 'Nanete', 'Jeffray', 'https://robohash.org/essedolorenon.jpg?size=50x50&set=set1', 'njeffray7w@wufoo.com', '426-810-0206', 'njeffray7w', 'tMs0vFq1J', 'ukwZhGisq', 502, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (286, 'Genni', 'Golding', 'https://robohash.org/quisaepedeleniti.png?size=50x50&set=set1', 'ggolding7x@buzzfeed.com', '559-404-5613', 'ggolding7x', 'nXKdBdP0', 'g2T4RQ5XzE', 502, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (287, 'Lilyan', 'Kulver', 'https://robohash.org/quossitmaiores.bmp?size=50x50&set=set1', 'lkulver7y@chron.com', '600-467-4241', 'lkulver7y', 'WbreibxN6n', '5oIogDRJ0', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (288, 'Haywood', 'Ditzel', 'https://robohash.org/suntesseiure.bmp?size=50x50&set=set1', 'hditzel7z@cbsnews.com', '541-546-1530', 'hditzel7z', 'CkAD2PC5t', 'LO25zC8tOp', 501, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (289, 'Cleo', 'Drioli', 'https://robohash.org/voluptasomniset.bmp?size=50x50&set=set1', 'cdrioli80@usatoday.com', '919-266-9434', 'cdrioli80', '4Cgr9vneHJ', 'sLh8s8Dzv', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (290, 'Sloan', 'Avramov', 'https://robohash.org/earumutalias.jpg?size=50x50&set=set1', 'savramov81@nifty.com', '216-126-8902', 'savramov81', 'gIUWQH4zc', 'XDK6gD4eTho', 506, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (291, 'Carina', 'Docket', 'https://robohash.org/ipsaeaminima.jpg?size=50x50&set=set1', 'cdocket82@geocities.jp', '286-638-9845', 'cdocket82', 'iXVtkwq', 'tTly6tQuTdI', 506, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (292, 'Sabine', 'Disbrow', 'https://robohash.org/voluptatemvoluptatibusrerum.jpg?size=50x50&set=set1', 'sdisbrow83@wunderground.com', '118-307-2758', 'sdisbrow83', 'zq5UAtH9zzU', 'imBoX0uZm6', 502, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (293, 'Laverna', 'Muddicliffe', 'https://robohash.org/placeatsequirerum.bmp?size=50x50&set=set1', 'lmuddicliffe84@rakuten.co.jp', '147-644-4204', 'lmuddicliffe84', 'uIXL2Uu', '2irCDpqhDNQ', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (294, 'Tonya', 'Stanluck', 'https://robohash.org/assumendaetquidem.jpg?size=50x50&set=set1', 'tstanluck85@google.it', '706-381-5081', 'tstanluck85', 'voAW2g5Jv264', '1IFPxd', 504, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (295, 'Kale', 'Daine', 'https://robohash.org/doloremquerepellenduseaque.bmp?size=50x50&set=set1', 'kdaine86@so-net.ne.jp', '230-436-0350', 'kdaine86', 'QVId39', 'vZAXqWKXsxJ', 502, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (296, 'Madella', 'Kynan', 'https://robohash.org/adaliquamratione.jpg?size=50x50&set=set1', 'mkynan87@google.com.br', '490-400-5102', 'mkynan87', 'i9ePEVBTvQ', 'oalcf8AkKos3', 501, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (297, 'Carroll', 'Le Quesne', 'https://robohash.org/etliberotenetur.bmp?size=50x50&set=set1', 'clequesne88@nba.com', '966-714-4164', 'clequesne88', '6QkHeT0iTK', 'eZLGVqJtqS9', 501, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (298, 'Paige', 'Bangiard', 'https://robohash.org/culpaestquas.jpg?size=50x50&set=set1', 'pbangiard89@npr.org', '343-374-2706', 'pbangiard89', 'cz0q7nyT7', '2ldbGT', 506, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (299, 'Rudolf', 'Chinn', 'https://robohash.org/laborequosquis.png?size=50x50&set=set1', 'rchinn8a@vinaora.com', '396-949-4605', 'rchinn8a', 'YXFv6SrU', 'fSa498i0BFD', 503, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (300, 'Irena', 'Blagdon', 'https://robohash.org/reprehenderitblanditiisvoluptatem.bmp?size=50x50&set=set1', 'iblagdon8b@cyberchimps.com', '973-848-6784', 'iblagdon8b', 'ZBQj3Oiox', 'iBypyazltyPL', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (301, 'Damaris', 'Carette', 'https://robohash.org/quaeratcorporiset.bmp?size=50x50&set=set1', 'dcarette8c@jigsy.com', '577-921-1910', 'dcarette8c', 'FKrSyg', 'HNQcR0AX', 504, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (302, 'Lorrie', 'Steeples', 'https://robohash.org/quasutporro.png?size=50x50&set=set1', 'lsteeples8d@netscape.com', '959-921-7994', 'lsteeples8d', 'UaDfaXU83', 'jQXU8RgLI', 506, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (303, 'Kerianne', 'Gustus', 'https://robohash.org/autexsoluta.jpg?size=50x50&set=set1', 'kgustus8e@arstechnica.com', '431-901-3939', 'kgustus8e', '5gZLUpsoFzOW', 'TpbP1rf', 506, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (304, 'Myrtia', 'Brisard', 'https://robohash.org/velfugiataspernatur.png?size=50x50&set=set1', 'mbrisard8f@newsvine.com', '565-394-2488', 'mbrisard8f', 'kMuBfpAR5bAH', 'zZqEIG', 505, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (305, 'Ebba', 'Pitson', 'https://robohash.org/estauttempore.jpg?size=50x50&set=set1', 'epitson8g@rambler.ru', '662-586-3064', 'epitson8g', '4oxvyq7', 'TjNh3tusoo', 506, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (306, 'Christina', 'Downton', 'https://robohash.org/doloribusrepudiandaequas.bmp?size=50x50&set=set1', 'cdownton8h@yale.edu', '297-711-7855', 'cdownton8h', 'n766vhrBDvY', 'lvMS85I87P9h', 503, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (307, 'Jarib', 'Gaspard', 'https://robohash.org/adipisciautpossimus.png?size=50x50&set=set1', 'jgaspard8i@plala.or.jp', '236-278-3587', 'jgaspard8i', '1il8Gch90Gg', '2HvoIQbSk2F', 501, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (308, 'Maribeth', 'Bigrigg', 'https://robohash.org/aliquamquibusdamdoloribus.jpg?size=50x50&set=set1', 'mbigrigg8j@cyberchimps.com', '982-889-5787', 'mbigrigg8j', 'ubZSr27o4lO', 'L60ZrQ', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (309, 'Trueman', 'Lahy', 'https://robohash.org/aliquidsimiliquenam.jpg?size=50x50&set=set1', 'tlahy8k@over-blog.com', '163-888-6964', 'tlahy8k', '092o6oQYvUvY', 'Hxzf3NS', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (310, 'Kristo', 'Huff', 'https://robohash.org/molestiaeestratione.jpg?size=50x50&set=set1', 'khuff8l@jugem.jp', '226-224-4802', 'khuff8l', 'H2ydXscC', 'yLP1yLo7wAB5', 505, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (311, 'Margo', 'Arthars', 'https://robohash.org/quiaetdolor.png?size=50x50&set=set1', 'marthars8m@smh.com.au', '525-258-1339', 'marthars8m', 'QPb3htfT', '2aVIhFwUXxc', 501, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (312, 'Lavina', 'Belcham', 'https://robohash.org/eiusexercitationemrecusandae.png?size=50x50&set=set1', 'lbelcham8n@dot.gov', '712-446-3234', 'lbelcham8n', 'uv8aEja2tZ', 'SPvjgUW', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (313, 'Ferdinande', 'Cocke', 'https://robohash.org/quiasimiliquecorrupti.png?size=50x50&set=set1', 'fcocke8o@posterous.com', '269-707-4445', 'fcocke8o', 'Qixrgfvf', '249bOLs', 502, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (314, 'Constancy', 'Scholte', 'https://robohash.org/noncumquedolore.bmp?size=50x50&set=set1', 'cscholte8p@w3.org', '646-647-6128', 'cscholte8p', 'JH9XjJFN', 'HJ60jSfRLKr', 503, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (315, 'Talyah', 'Flello', 'https://robohash.org/consequaturbeataeenim.jpg?size=50x50&set=set1', 'tflello8q@yellowpages.com', '220-661-7612', 'tflello8q', 'qUqo2b5DgJ', 'y1VJzWOdWZDT', 501, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (316, 'Reginauld', 'Elfleet', 'https://robohash.org/impediterroraut.bmp?size=50x50&set=set1', 'relfleet8r@gmpg.org', '278-522-2063', 'relfleet8r', 'Nn5Ihj6H7Gq', 'xOK9ANTG7JW0', 504, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (317, 'Maggy', 'Bacup', 'https://robohash.org/aliquamutea.png?size=50x50&set=set1', 'mbacup8s@spotify.com', '469-936-3055', 'mbacup8s', 'aToVHOG1tk', 'VRxCA8rJe', 506, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (318, 'Tomas', 'Ayliff', 'https://robohash.org/noncommodiet.bmp?size=50x50&set=set1', 'tayliff8t@bravesites.com', '938-244-7446', 'tayliff8t', '03bMGC3', 'n7ybK0OMnXv', 502, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (319, 'Neile', 'Counihan', 'https://robohash.org/quinecessitatibussuscipit.bmp?size=50x50&set=set1', 'ncounihan8u@nationalgeographic.com', '619-672-9780', 'ncounihan8u', 's4YpRqjQxh', 'okdpBZqKv', 505, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (320, 'Rutledge', 'Faichney', 'https://robohash.org/utmagniut.jpg?size=50x50&set=set1', 'rfaichney8v@cnet.com', '761-571-6742', 'rfaichney8v', 'aoos2XtL', '6nUh4vjRGws', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (321, 'Bryant', 'Connell', 'https://robohash.org/animivoluptatemea.bmp?size=50x50&set=set1', 'bconnell8w@php.net', '948-683-4733', 'bconnell8w', 'NZqHtguC', 'duAwF69dQq', 505, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (322, 'Shay', 'Cockroft', 'https://robohash.org/architectonumquamquasi.png?size=50x50&set=set1', 'scockroft8x@msn.com', '120-398-7197', 'scockroft8x', '3kBZmB', 'I0a5IBw7f6', 505, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (323, 'Tremayne', 'Dunning', 'https://robohash.org/aperiamoptiotempore.jpg?size=50x50&set=set1', 'tdunning8y@irs.gov', '954-814-7732', 'tdunning8y', 'bTXwvbDH5Zb', 'Qb3SdcJdiIJ', 505, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (324, 'Bartholomeus', 'Lackham', 'https://robohash.org/aspernaturcupiditateprovident.bmp?size=50x50&set=set1', 'blackham8z@privacy.gov.au', '926-435-5257', 'blackham8z', 'ZmjhDh8m', 'WmW52412G', 504, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (325, 'Von', 'Rumens', 'https://robohash.org/fugaidcommodi.jpg?size=50x50&set=set1', 'vrumens90@amazon.de', '556-185-8270', 'vrumens90', '6ZVIfDiC9QnZ', 'U21iFXEcm03', 501, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (326, 'Ransell', 'Pidon', 'https://robohash.org/officiainventorefacilis.bmp?size=50x50&set=set1', 'rpidon91@nifty.com', '604-732-5432', 'rpidon91', 'qv8bG90', '5PfzvyWlC4H7', 505, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (327, 'Merilyn', 'Utting', 'https://robohash.org/etperspiciatisillo.jpg?size=50x50&set=set1', 'mutting92@forbes.com', '183-417-5991', 'mutting92', 'rqJRzKW', 'W5Ux3QRMxIHE', 504, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (328, 'Angeli', 'Petche', 'https://robohash.org/iustosintdolor.png?size=50x50&set=set1', 'apetche93@wikispaces.com', '491-296-5286', 'apetche93', 'liTVgm0', 'E1BW3C5', 504, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (329, 'Krishna', 'Cardo', 'https://robohash.org/aspernaturrationemodi.jpg?size=50x50&set=set1', 'kcardo94@hud.gov', '581-980-8542', 'kcardo94', '9JxlChzH', 'PwMcfdo', 503, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (330, 'Marcile', 'Brikner', 'https://robohash.org/facereanimiqui.png?size=50x50&set=set1', 'mbrikner95@biglobe.ne.jp', '909-214-1472', 'mbrikner95', 'DkPjEs2BJv', 'KA2nBe54a', 504, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (331, 'Crosby', 'Cannings', 'https://robohash.org/ametsintut.png?size=50x50&set=set1', 'ccannings96@free.fr', '193-177-9823', 'ccannings96', '28NUOrN4FUI', 'FOy0cgg0', 505, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (332, 'Heidie', 'Fidock', 'https://robohash.org/voluptasnihilqui.bmp?size=50x50&set=set1', 'hfidock97@blogger.com', '674-228-3528', 'hfidock97', '5I2ZVRwNKI', 'd5Q15tvlHgO', 502, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (333, 'Estelle', 'Kairns', 'https://robohash.org/veniaminciduntat.jpg?size=50x50&set=set1', 'ekairns98@soup.io', '832-539-7498', 'ekairns98', 'ZHExHaDj0OYk', 'aAqVZ7idX', 504, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (334, 'Stillmann', 'Fibbings', 'https://robohash.org/quismolestiaeest.png?size=50x50&set=set1', 'sfibbings99@prweb.com', '877-978-4715', 'sfibbings99', 'qiazzA2Ty', 'FBFwJo', 506, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (335, 'Ernestus', 'Hunnicot', 'https://robohash.org/adipiscisintullam.bmp?size=50x50&set=set1', 'ehunnicot9a@google.com', '477-115-1506', 'ehunnicot9a', 'ziWLGi0IaoOp', 'xlLJF8nfTQM', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (336, 'Rosco', 'Brothwell', 'https://robohash.org/molestiaetotamexercitationem.bmp?size=50x50&set=set1', 'rbrothwell9b@163.com', '668-625-0798', 'rbrothwell9b', 'ATe20RBvw7A', 'pNUDjhtlkKiu', 505, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (337, 'Thomasa', 'Warn', 'https://robohash.org/etlaudantiumperferendis.bmp?size=50x50&set=set1', 'twarn9c@whitehouse.gov', '589-997-6764', 'twarn9c', 'R12ZUSVqO9cX', 'RrBMoTM8nHj', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (338, 'Kirsti', 'Piddlehinton', 'https://robohash.org/facilisquiquisquam.jpg?size=50x50&set=set1', 'kpiddlehinton9d@example.com', '826-618-8695', 'kpiddlehinton9d', 'lcIrggrH1', 'zLWN5YM8Mr', 501, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (339, 'Aili', 'Grassett', 'https://robohash.org/ipsamiustocorrupti.bmp?size=50x50&set=set1', 'agrassett9e@arizona.edu', '261-467-3150', 'agrassett9e', 'mjpzdoBQI7', 'vjX1ITayIv', 503, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (340, 'Brittni', 'Rheaume', 'https://robohash.org/voluptatemrepudiandaequos.jpg?size=50x50&set=set1', 'brheaume9f@sun.com', '912-710-7926', 'brheaume9f', 'e2jKZKSF', 'LrQPTe', 502, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (341, 'Stephani', 'Landsberg', 'https://robohash.org/autquismolestiae.png?size=50x50&set=set1', 'slandsberg9g@seesaa.net', '353-317-5780', 'slandsberg9g', 'XZWbafoZ0jZW', 'nYNaI9Sta', 506, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (342, 'Florian', 'Hambly', 'https://robohash.org/istequaequasi.bmp?size=50x50&set=set1', 'fhambly9h@weather.com', '452-919-2913', 'fhambly9h', 'HgaO0lLBU78', 'fbPCHkGCZRu0', 501, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (343, 'Darlleen', 'Bere', 'https://robohash.org/quirepellendusqui.png?size=50x50&set=set1', 'dbere9i@scientificamerican.com', '413-471-7700', 'dbere9i', 'lrTWWA4qFF1n', 'hdIDpmSH', 501, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (344, 'Ramon', 'Bullimore', 'https://robohash.org/asperioressitvoluptatem.bmp?size=50x50&set=set1', 'rbullimore9j@cisco.com', '461-533-9442', 'rbullimore9j', '2pUHV1G4K', 'qNMt2A', 502, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (345, 'Douglass', 'Cosans', 'https://robohash.org/utfugitiste.jpg?size=50x50&set=set1', 'dcosans9k@list-manage.com', '952-150-4314', 'dcosans9k', '4gBsW4zLQ2ce', '2LisvQK4QI', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (346, 'Elden', 'Thurborn', 'https://robohash.org/atquianemo.bmp?size=50x50&set=set1', 'ethurborn9l@ft.com', '451-314-4992', 'ethurborn9l', '9GnJklx73', 'FptOwqoB', 503, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (347, 'Raff', 'Russe', 'https://robohash.org/accusamusasperioresomnis.bmp?size=50x50&set=set1', 'rrusse9m@scribd.com', '761-494-0824', 'rrusse9m', 'Q164k1lCZtzJ', 'JRodeT', 503, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (348, 'Sampson', 'Stannard', 'https://robohash.org/omnisoptioab.jpg?size=50x50&set=set1', 'sstannard9n@ox.ac.uk', '295-613-8870', 'sstannard9n', 'qn7NrmEx', 'TPvjShH', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (349, 'Rodolphe', 'Sirmon', 'https://robohash.org/officiaporrofugiat.bmp?size=50x50&set=set1', 'rsirmon9o@reuters.com', '597-611-4951', 'rsirmon9o', '48ftPfb', 'FiKH9x', 505, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (350, 'Alikee', 'Petre', 'https://robohash.org/faceredoloribusadipisci.jpg?size=50x50&set=set1', 'apetre9p@huffingtonpost.com', '463-559-5772', 'apetre9p', 'PBu4UQztkAkt', 'pfyFw8', 501, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (351, 'Berkley', 'Giraldo', 'https://robohash.org/distinctiooccaecatiquo.bmp?size=50x50&set=set1', 'bgiraldo9q@gizmodo.com', '550-999-8010', 'bgiraldo9q', '0dnhbGFjT8Wj', 'Dr4D5EbiT9R0', 502, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (352, 'Armand', 'Froom', 'https://robohash.org/quideseruntlibero.jpg?size=50x50&set=set1', 'afroom9r@tamu.edu', '418-322-1554', 'afroom9r', 'HalzxA4s', 'TmpyIX8OxA', 505, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (353, 'Kennie', 'Raff', 'https://robohash.org/doloresainventore.jpg?size=50x50&set=set1', 'kraff9s@narod.ru', '576-726-1887', 'kraff9s', 'cvwmv9W', '2UJjVQ', 502, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (354, 'Bernice', 'Astall', 'https://robohash.org/solutaquiaea.bmp?size=50x50&set=set1', 'bastall9t@cloudflare.com', '703-203-9905', 'bastall9t', 'pAITDoQhN', 'e5PlYcEgQXfC', 505, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (355, 'Selina', 'Price', 'https://robohash.org/autpossimusadipisci.bmp?size=50x50&set=set1', 'sprice9u@gravatar.com', '975-468-3636', 'sprice9u', 'pHeTP0', '8cBpY4R5', 503, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (356, 'Kelsy', 'Haddleton', 'https://robohash.org/natusrecusandaeerror.jpg?size=50x50&set=set1', 'khaddleton9v@e-recht24.de', '377-494-6821', 'khaddleton9v', 'zaUlScRQA', 'nOoFWuuno61', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (357, 'Johnathan', 'Chestnut', 'https://robohash.org/doloribusillumbeatae.png?size=50x50&set=set1', 'jchestnut9w@typepad.com', '473-633-6271', 'jchestnut9w', 'QgnFpkD', '8wRPxmX8', 501, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (358, 'Trescha', 'Pinnegar', 'https://robohash.org/suscipitautemest.png?size=50x50&set=set1', 'tpinnegar9x@booking.com', '827-350-5343', 'tpinnegar9x', 'PSQFpLgfKd', 'GQV3HdMnT', 501, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (359, 'Shayla', 'Gasker', 'https://robohash.org/dolorquiaet.bmp?size=50x50&set=set1', 'sgasker9y@rediff.com', '255-865-8289', 'sgasker9y', 's6XYCl5', 'UXPZJnJ6', 502, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (360, 'Ambrosius', 'Haddleston', 'https://robohash.org/nontemporaharum.bmp?size=50x50&set=set1', 'ahaddleston9z@dailymotion.com', '510-997-7472', 'ahaddleston9z', 'Q876Kn', 'TOq0gHV2', 501, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (361, 'Fons', 'Dawton', 'https://robohash.org/commodiullamsimilique.jpg?size=50x50&set=set1', 'fdawtona0@dailymail.co.uk', '184-927-5590', 'fdawtona0', 'tucSNH2vaY', '2frDLEJ7h', 503, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (362, 'Mikey', 'Palke', 'https://robohash.org/ipsumquaeratoccaecati.jpg?size=50x50&set=set1', 'mpalkea1@reddit.com', '219-349-2613', 'mpalkea1', 'p1Kc8bU8', 'tYzvU9aH', 502, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (363, 'Jesse', 'Cordall', 'https://robohash.org/rationeeostemporibus.jpg?size=50x50&set=set1', 'jcordalla2@china.com.cn', '394-110-2353', 'jcordalla2', 'LUvui8I', 'qOGful8tE', 502, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (364, 'Alysia', 'Dunguy', 'https://robohash.org/praesentiumdoloressit.png?size=50x50&set=set1', 'adunguya3@statcounter.com', '806-326-3093', 'adunguya3', 'hDsbftvY78', 'Z6cPA8tmKDb', 506, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (365, 'Belia', 'Wix', 'https://robohash.org/namveniammagni.bmp?size=50x50&set=set1', 'bwixa4@wordpress.org', '551-997-4252', 'bwixa4', 'deNi6W', 'liycCN', 503, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (366, 'Quintina', 'Kaubisch', 'https://robohash.org/magnamiurealias.jpg?size=50x50&set=set1', 'qkaubischa5@storify.com', '870-180-4036', 'qkaubischa5', 'ltkncHw1C', 'xR8tKxndVwDz', 504, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (367, 'Kathryn', 'Lade', 'https://robohash.org/velquamdolores.png?size=50x50&set=set1', 'kladea6@oakley.com', '310-151-3056', 'kladea6', 'TcNJde8uXvbv', '0DvMZGexR', 504, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (368, 'Halie', 'Switzer', 'https://robohash.org/providentvoluptaset.png?size=50x50&set=set1', 'hswitzera7@google.ru', '149-846-0791', 'hswitzera7', 'b0P7NtNfUXrm', 'ZhFdsH', 506, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (369, 'Norina', 'Lonnon', 'https://robohash.org/nonquamconsequatur.jpg?size=50x50&set=set1', 'nlonnona8@telegraph.co.uk', '141-976-8530', 'nlonnona8', 'ksGZoKDaFg', '1E61DIzS', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (370, 'Belicia', 'Bolduc', 'https://robohash.org/ullampossimusdolorum.png?size=50x50&set=set1', 'bbolduca9@chicagotribune.com', '312-322-0278', 'bbolduca9', 'UUSV8sZy', 'EmMOyiP5FKXN', 505, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (371, 'Laverna', 'McCuthais', 'https://robohash.org/consequaturvoluptateexplicabo.jpg?size=50x50&set=set1', 'lmccuthaisaa@so-net.ne.jp', '522-244-2441', 'lmccuthaisaa', 'hmgAnAa19T', 'T8tc0Jy7LvS', 502, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (372, 'Kristy', 'Clarkson', 'https://robohash.org/eumperferendisea.jpg?size=50x50&set=set1', 'kclarksonab@disqus.com', '781-320-3736', 'kclarksonab', 'tx2Uwn', 'na5ryuv1T', 505, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (373, 'Marcelo', 'Bauduccio', 'https://robohash.org/doloribusminusnesciunt.png?size=50x50&set=set1', 'mbauduccioac@reverbnation.com', '143-340-0054', 'mbauduccioac', 'ZiKhkYBYppXO', 'V3irUu', 501, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (374, 'Roana', 'Broek', 'https://robohash.org/adrecusandaetemporibus.bmp?size=50x50&set=set1', 'rbroekad@acquirethisname.com', '732-215-6522', 'rbroekad', 'TsGyoCEkUd', '61Q2g4cIirck', 501, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (375, 'Davine', 'Danniel', 'https://robohash.org/expeditaaperiamdelectus.png?size=50x50&set=set1', 'ddannielae@telegraph.co.uk', '929-684-4676', 'ddannielae', 'Vh9TGkD', 'Zws2IFw1aDhK', 504, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (376, 'Natasha', 'Quarrington', 'https://robohash.org/etvoluptaterepudiandae.bmp?size=50x50&set=set1', 'nquarringtonaf@wikipedia.org', '502-925-3574', 'nquarringtonaf', 'lJ103tAm', 'n4uXBrb5v7J3', 503, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (377, 'Sherwood', 'Adamek', 'https://robohash.org/doloremavitae.png?size=50x50&set=set1', 'sadamekag@sohu.com', '939-501-9709', 'sadamekag', 'RFUz4Asbt0', '3lHb4l', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (378, 'Pietrek', 'Kelloch', 'https://robohash.org/voluptatemsequiquod.png?size=50x50&set=set1', 'pkellochah@rambler.ru', '615-975-1606', 'pkellochah', 'E3NUlg7g93rC', 'T6qDEoyq', 506, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (379, 'Lynea', 'Heimann', 'https://robohash.org/animiquodolor.jpg?size=50x50&set=set1', 'lheimannai@surveymonkey.com', '250-523-4076', 'lheimannai', 'FOQODQjKcbP', 'nDTexIROb', 506, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (380, 'Gale', 'Pettisall', 'https://robohash.org/impeditomnisvoluptatem.png?size=50x50&set=set1', 'gpettisallaj@ifeng.com', '556-372-1670', 'gpettisallaj', 'd6EzQPdf9', 'gxXE9au', 505, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (381, 'Sondra', 'Shackel', 'https://robohash.org/dolornecessitatibusautem.jpg?size=50x50&set=set1', 'sshackelak@vimeo.com', '411-340-6130', 'sshackelak', 'FkJzqvs', 'alVrQn3h', 506, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (382, 'Bevan', 'Ennals', 'https://robohash.org/minustemporeomnis.bmp?size=50x50&set=set1', 'bennalsal@bandcamp.com', '719-373-5402', 'bennalsal', 'LSzTm94', 'bPNvFBVqy', 501, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (383, 'Yankee', 'Jealous', 'https://robohash.org/quiveritatisdicta.jpg?size=50x50&set=set1', 'yjealousam@salon.com', '950-692-7305', 'yjealousam', 'XWRmNNZOG72', 'i2Hsvz2Q', 505, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (384, 'Hadlee', 'MacSkeaghan', 'https://robohash.org/enimnemosunt.bmp?size=50x50&set=set1', 'hmacskeaghanan@discuz.net', '399-741-1373', 'hmacskeaghanan', 'TO1lcBs0', 'qYBNjB', 502, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (385, 'Reggi', 'Strathe', 'https://robohash.org/sapienteitaqueporro.jpg?size=50x50&set=set1', 'rstratheao@comcast.net', '471-810-7217', 'rstratheao', 'teRgoAjwc0c', 'ie5WHd9', 502, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (386, 'Chase', 'Imore', 'https://robohash.org/assumendanesciuntquae.png?size=50x50&set=set1', 'cimoreap@issuu.com', '668-510-4977', 'cimoreap', 'pumZlc', 'Dq5wIiqIaT', 505, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (387, 'Henrieta', 'Botfield', 'https://robohash.org/errornemosit.jpg?size=50x50&set=set1', 'hbotfieldaq@tripadvisor.com', '228-262-5925', 'hbotfieldaq', 'O2577jfQ', 'y6opDo6', 502, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (388, 'Jeffy', 'Stanley', 'https://robohash.org/essealiquamculpa.png?size=50x50&set=set1', 'jstanleyar@omniture.com', '424-190-8713', 'jstanleyar', 'iBlwxg5CfP', 'sxkHLnsodD', 502, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (389, 'Moll', 'Dureden', 'https://robohash.org/autoccaecatialiquam.png?size=50x50&set=set1', 'mduredenas@accuweather.com', '333-529-6682', 'mduredenas', 'jMqpgmofPtiY', 'EdVdFBfirjeC', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (390, 'Laural', 'Noteyoung', 'https://robohash.org/natusquaeratqui.jpg?size=50x50&set=set1', 'lnoteyoungat@networksolutions.com', '589-536-8041', 'lnoteyoungat', 'sdPB9mM5Q', 'kDMfREuXda', 505, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (391, 'Wright', 'Sandaver', 'https://robohash.org/nostrumautquas.bmp?size=50x50&set=set1', 'wsandaverau@livejournal.com', '485-860-2754', 'wsandaverau', 'XAhW4QS', 'b4sjhS0DW', 505, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (392, 'Noell', 'Murtimer', 'https://robohash.org/aliquamsuscipitdolor.jpg?size=50x50&set=set1', 'nmurtimerav@studiopress.com', '800-494-7634', 'nmurtimerav', 'ghgfKD6nGLe', 'rfK9TCy', 505, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (393, 'Donna', 'Cowper', 'https://robohash.org/possimusestautem.png?size=50x50&set=set1', 'dcowperaw@geocities.jp', '381-703-4106', 'dcowperaw', 'KfObuSe', '2TSqQQ3qky', 503, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (394, 'Cati', 'Varey', 'https://robohash.org/enimsiteaque.bmp?size=50x50&set=set1', 'cvareyax@angelfire.com', '889-842-3782', 'cvareyax', 'hUBZdXF', '1nwJFiThQJ', 506, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (395, 'Tara', 'Frankham', 'https://robohash.org/molestiaesaepeaccusantium.png?size=50x50&set=set1', 'tfrankhamay@auda.org.au', '364-433-4560', 'tfrankhamay', 'CMhinD7E', 'w1pL1KeMvVF', 504, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (396, 'Andres', 'Tewkesberry', 'https://robohash.org/oditnostrumipsam.png?size=50x50&set=set1', 'atewkesberryaz@ihg.com', '144-567-3342', 'atewkesberryaz', '7wh9TgPqK9', 'NWFvcW', 503, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (397, 'Louie', 'Durtnall', 'https://robohash.org/velatet.jpg?size=50x50&set=set1', 'ldurtnallb0@bluehost.com', '639-651-3978', 'ldurtnallb0', 'KOXdUHuZK', 'et0nYcVyJD', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (398, 'Friederike', 'Martygin', 'https://robohash.org/aliquamvoluptatibusrerum.jpg?size=50x50&set=set1', 'fmartyginb1@comcast.net', '496-139-5806', 'fmartyginb1', 'nllzNl1Vuhsk', '0OEBUcY', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (399, 'Erik', 'Danjoie', 'https://robohash.org/temporibusoccaecatimaiores.bmp?size=50x50&set=set1', 'edanjoieb2@redcross.org', '130-339-8572', 'edanjoieb2', 'mf9ChrR8B', 'ZmSN4og7z', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (400, 'Aleen', 'Thorrold', 'https://robohash.org/facerevoluptaseos.jpg?size=50x50&set=set1', 'athorroldb3@wunderground.com', '928-861-6137', 'athorroldb3', 'A7ZuCmLM', 'LvjGchl9uesM', 506, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (401, 'Hertha', 'O''Hone', 'https://robohash.org/velitliberolabore.jpg?size=50x50&set=set1', 'hohoneb4@gmpg.org', '246-940-7213', 'hohoneb4', 'hzgLlo', 'B6zG4Za', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (402, 'Quint', 'Rother', 'https://robohash.org/doloremexplicaboneque.bmp?size=50x50&set=set1', 'qrotherb5@japanpost.jp', '217-696-1439', 'qrotherb5', 'LJJfKkA', 'uReeZUTjZrm', 504, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (403, 'Gilberta', 'Wyllt', 'https://robohash.org/laboriosamrationenam.jpg?size=50x50&set=set1', 'gwylltb6@1688.com', '748-384-2602', 'gwylltb6', '2cryrMemzx', 'y2pvg0T', 501, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (404, 'Aubrey', 'Braunle', 'https://robohash.org/velitvelquibusdam.bmp?size=50x50&set=set1', 'abraunleb7@eventbrite.com', '315-278-0732', 'abraunleb7', 'uzrfrvT', 'a5H315w', 502, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (405, 'Sarajane', 'Elverston', 'https://robohash.org/accusantiumfacilisdolore.bmp?size=50x50&set=set1', 'selverstonb8@mail.ru', '188-615-5012', 'selverstonb8', '5pyuMoLAxBS', 'L2s3D17', 505, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (406, 'Jana', 'Tithecott', 'https://robohash.org/dolorumvoluptatesfacilis.png?size=50x50&set=set1', 'jtithecottb9@rambler.ru', '313-173-2138', 'jtithecottb9', 'nwcoB6bwUNFn', 'eWq17KjUCZ', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (407, 'Corabel', 'Segge', 'https://robohash.org/repellendusdolorvel.jpg?size=50x50&set=set1', 'cseggeba@xing.com', '488-506-5949', 'cseggeba', 'yV9mrBX0acd3', 'JXe1HoLPRq', 502, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (408, 'Conrad', 'Carse', 'https://robohash.org/itaquedictaculpa.jpg?size=50x50&set=set1', 'ccarsebb@i2i.jp', '400-484-7183', 'ccarsebb', 'DNLYjbi', 'qXtF8DxgVbxY', 502, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (409, 'Laney', 'Mousley', 'https://robohash.org/cumqueetvoluptatibus.jpg?size=50x50&set=set1', 'lmousleybc@liveinternet.ru', '787-872-3319', 'lmousleybc', '1vL37hh', 'gKecWS3Qm', 502, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (410, 'Page', 'Chastney', 'https://robohash.org/corruptietdebitis.jpg?size=50x50&set=set1', 'pchastneybd@zimbio.com', '591-834-2896', 'pchastneybd', 'ikhhM2Ii', 'wYpf37saDb', 506, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (411, 'Mandy', 'Kaindl', 'https://robohash.org/molestiaenequesapiente.bmp?size=50x50&set=set1', 'mkaindlbe@bloglovin.com', '136-713-9156', 'mkaindlbe', 'fcKtFAfGTfh', 'IVRnIdH6FEI', 502, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (412, 'Lanni', 'Guild', 'https://robohash.org/utvoluptatibusreiciendis.png?size=50x50&set=set1', 'lguildbf@newsvine.com', '951-756-9668', 'lguildbf', 'Cd0IHYCt', 'mtRnwbu9ZZd', 501, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (413, 'Den', 'Wason', 'https://robohash.org/quasodioamet.png?size=50x50&set=set1', 'dwasonbg@blogger.com', '166-914-7740', 'dwasonbg', 'eEhcrx', 'lb0lBYMv6DE', 503, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (414, 'Fee', 'Allan', 'https://robohash.org/nemotemporeincidunt.bmp?size=50x50&set=set1', 'fallanbh@eventbrite.com', '842-878-2572', 'fallanbh', 'HONYs5pGc', 'TzDnsSFN', 502, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (415, 'Molli', 'Branni', 'https://robohash.org/autconsecteturet.png?size=50x50&set=set1', 'mbrannibi@pagesperso-orange.fr', '320-875-4215', 'mbrannibi', 'eGh9TltTWoYe', 'vzRGze6', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (416, 'Dione', 'Bister', 'https://robohash.org/autemtemporaitaque.jpg?size=50x50&set=set1', 'dbisterbj@taobao.com', '812-197-9994', 'dbisterbj', 'gDLERu1', 'pmnlGzZfwn', 501, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (417, 'Burton', 'Merriday', 'https://robohash.org/fugiatminusconsequatur.jpg?size=50x50&set=set1', 'bmerridaybk@berkeley.edu', '739-531-3639', 'bmerridaybk', 'hyrJEO6xNac', '2c9uWGEn5Kkx', 505, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (418, 'Sibbie', 'McGarrie', 'https://robohash.org/culpaquasiducimus.png?size=50x50&set=set1', 'smcgarriebl@simplemachines.org', '984-773-9104', 'smcgarriebl', 'wcRF4y', 'x8OwQMgkHNch', 502, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (419, 'Roxanne', 'MacFadzan', 'https://robohash.org/etlaboriosamautem.png?size=50x50&set=set1', 'rmacfadzanbm@123-reg.co.uk', '172-500-4126', 'rmacfadzanbm', 'e060iilblaa', 'gKHx6VUk9d', 503, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (420, 'Stanislas', 'Braisby', 'https://robohash.org/corruptiarchitectonumquam.png?size=50x50&set=set1', 'sbraisbybn@over-blog.com', '969-258-4559', 'sbraisbybn', '2YA7wQHimC', 'BXhAnRS2K', 506, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (421, 'Cordi', 'Ambage', 'https://robohash.org/nostrumexercitationemin.jpg?size=50x50&set=set1', 'cambagebo@home.pl', '432-758-7444', 'cambagebo', 'o2yLYyrI5l', 'HkRgkuTdp9BX', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (422, 'Xerxes', 'Hayth', 'https://robohash.org/officiaetvoluptatem.png?size=50x50&set=set1', 'xhaythbp@dion.ne.jp', '927-599-5251', 'xhaythbp', '5PyUNADvy', 'iMnCA7g', 501, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (423, 'Odell', 'Dainter', 'https://robohash.org/estlaudantiumet.bmp?size=50x50&set=set1', 'odainterbq@soup.io', '934-591-3520', 'odainterbq', 'ZqtD0Qn', 'TGG1eV3aS9aO', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (424, 'Beverly', 'Damant', 'https://robohash.org/utsitbeatae.bmp?size=50x50&set=set1', 'bdamantbr@dell.com', '536-535-0375', 'bdamantbr', '5tJaLa', 'VT2wmU1A', 503, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (425, 'Rani', 'Jados', 'https://robohash.org/numquamasperioresinventore.bmp?size=50x50&set=set1', 'rjadosbs@google.fr', '658-682-9904', 'rjadosbs', 'Rca3xSIhoK', 'uqGIOd', 504, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (426, 'Daile', 'Dudgeon', 'https://robohash.org/repellatidut.png?size=50x50&set=set1', 'ddudgeonbt@java.com', '272-530-2868', 'ddudgeonbt', 'OPUvBDu', '698spXJ', 505, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (427, 'Lorri', 'Cherry Holme', 'https://robohash.org/etsitpariatur.png?size=50x50&set=set1', 'lcherryholmebu@wp.com', '604-562-1555', 'lcherryholmebu', 'XjdhzgJ', 'Ab3soXnF5', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (428, 'Nert', 'Skentelbery', 'https://robohash.org/explicaboexpeditaquae.jpg?size=50x50&set=set1', 'nskentelberybv@hhs.gov', '790-531-2965', 'nskentelberybv', '3eQMhPh', 'k3H6sdAohypW', 504, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (429, 'Jania', 'Clingoe', 'https://robohash.org/quasdignissimosab.jpg?size=50x50&set=set1', 'jclingoebw@ox.ac.uk', '801-120-2012', 'jclingoebw', 'r8V15w3Aclh', 'ZdFVen', 501, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (430, 'Burt', 'Langlands', 'https://robohash.org/laborumquooptio.bmp?size=50x50&set=set1', 'blanglandsbx@indiatimes.com', '889-416-4648', 'blanglandsbx', 'SjgCZYhNf4Kl', 'm7CSIJpLzlgQ', 506, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (431, 'Krissie', 'Fredson', 'https://robohash.org/fugitetnostrum.png?size=50x50&set=set1', 'kfredsonby@trellian.com', '461-593-8736', 'kfredsonby', '8usAPn1BYW', 'YvzoFG', 503, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (432, 'Orion', 'Asplin', 'https://robohash.org/magnieumvitae.jpg?size=50x50&set=set1', 'oasplinbz@blogspot.com', '771-570-2294', 'oasplinbz', 'k4Vejduv3', '6aQPxEKqBu7', 502, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (433, 'Ringo', 'Phalp', 'https://robohash.org/autquiaaccusantium.bmp?size=50x50&set=set1', 'rphalpc0@nbcnews.com', '337-675-7489', 'rphalpc0', 'iAjMexxj9', 'rOf3axpVpkOj', 504, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (434, 'Abbot', 'Siggens', 'https://robohash.org/rerumtemporaoptio.jpg?size=50x50&set=set1', 'asiggensc1@senate.gov', '438-479-8268', 'asiggensc1', 'surwOD02vm', 'd7cYLt8VLau', 501, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (435, 'Angil', 'Hassard', 'https://robohash.org/commodimaioresprovident.bmp?size=50x50&set=set1', 'ahassardc2@nasa.gov', '128-206-3858', 'ahassardc2', 'tk0Yp5Oj8', 'neuh1ktZ', 504, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (436, 'Sonja', 'Burchett', 'https://robohash.org/expeditaiustoquo.jpg?size=50x50&set=set1', 'sburchettc3@trellian.com', '846-254-1489', 'sburchettc3', 'CzCJ8eMxjH', 'UmEE0wROr5I8', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (437, 'Marietta', 'Henriques', 'https://robohash.org/eaquevitaevelit.bmp?size=50x50&set=set1', 'mhenriquesc4@biblegateway.com', '832-425-9102', 'mhenriquesc4', 'U9L8oU', '9tbMthccKjn', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (438, 'Claiborn', 'Skepper', 'https://robohash.org/suntcumdeleniti.jpg?size=50x50&set=set1', 'cskepperc5@last.fm', '514-976-9272', 'cskepperc5', 'zT4WQ8u', 'LYjexh', 501, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (439, 'Malva', 'Enders', 'https://robohash.org/mollitianihilvoluptatibus.jpg?size=50x50&set=set1', 'mendersc6@vk.com', '295-185-8123', 'mendersc6', 'iE2E2d1zbN', 'zm6SrX7k9KnK', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (440, 'Danny', 'Kimbell', 'https://robohash.org/etquodvoluptas.bmp?size=50x50&set=set1', 'dkimbellc7@ebay.com', '803-909-4318', 'dkimbellc7', '2zk2FcaonkUJ', '5zdSwZ52t', 502, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (441, 'Mirabella', 'Odgaard', 'https://robohash.org/sintarchitectoomnis.png?size=50x50&set=set1', 'modgaardc8@sogou.com', '603-880-4987', 'modgaardc8', 'MvlL1Aq', 'EHFm6fTnm', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (442, 'Bennie', 'Bras', 'https://robohash.org/consequunturadipiscireprehenderit.png?size=50x50&set=set1', 'bbrasc9@domainmarket.com', '846-479-6396', 'bbrasc9', '4fhj4L7n', 'f54FgeOP78', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (443, 'Lorna', 'Champkins', 'https://robohash.org/fugiatnihilearum.bmp?size=50x50&set=set1', 'lchampkinsca@flickr.com', '482-587-2064', 'lchampkinsca', 'vRdLYxqs', 'ePJ9GxbeS', 501, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (444, 'Vail', 'Bowser', 'https://robohash.org/inciduntomnisdolorem.bmp?size=50x50&set=set1', 'vbowsercb@hhs.gov', '680-494-4626', 'vbowsercb', 'ZeWeIdeBXy', 'QCaeLwP', 505, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (445, 'Lettie', 'Littledyke', 'https://robohash.org/doloremquequiqui.png?size=50x50&set=set1', 'llittledykecc@hhs.gov', '500-300-3964', 'llittledykecc', 'prw0qcSPRG', 'DPRWBTKzSwO', 502, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (446, 'Amber', 'Huortic', 'https://robohash.org/etdolorumqui.png?size=50x50&set=set1', 'ahuorticcd@yahoo.co.jp', '749-964-2864', 'ahuorticcd', 'gHKrnLzgTA', 'atU45wdy', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (447, 'Ophelia', 'Brimm', 'https://robohash.org/optiomaximeomnis.bmp?size=50x50&set=set1', 'obrimmce@uiuc.edu', '121-495-7199', 'obrimmce', 'KSQVRbp3', 'nOkZTOFj', 504, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (448, 'Jaymee', 'Stairs', 'https://robohash.org/istevoluptatibuslaborum.bmp?size=50x50&set=set1', 'jstairscf@paypal.com', '178-545-4543', 'jstairscf', 'FGxiPsU', 'VKTdJ7', 501, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (449, 'Garrett', 'Tripett', 'https://robohash.org/teneturdoloressuscipit.bmp?size=50x50&set=set1', 'gtripettcg@va.gov', '131-604-1847', 'gtripettcg', 'OTZTzoHF', '6C1Q0Brt3Gl', 501, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (450, 'Sawyere', 'Craighead', 'https://robohash.org/consequunturdoloremdebitis.png?size=50x50&set=set1', 'scraigheadch@ow.ly', '735-627-8291', 'scraigheadch', 'upyWKZEFigp', 'lptFnlaVNo', 504, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (451, 'Leon', 'Shildrake', 'https://robohash.org/rerumsintcommodi.png?size=50x50&set=set1', 'lshildrakeci@exblog.jp', '798-989-8095', 'lshildrakeci', 'NocgTZANzb', 'j8l8UPr', 504, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (452, 'Hamlen', 'Holsey', 'https://robohash.org/rerumsuscipitsunt.jpg?size=50x50&set=set1', 'hholseycj@indiatimes.com', '329-276-3898', 'hholseycj', 'drl2DUaKEC', 'FjC4Krca3V', 502, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (453, 'Horacio', 'Vurley', 'https://robohash.org/saepesintautem.bmp?size=50x50&set=set1', 'hvurleyck@facebook.com', '493-449-0659', 'hvurleyck', 'GWgGVKPz0ewk', 'bkGwxCvqNws', 503, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (454, 'Claire', 'Colgan', 'https://robohash.org/quiveleum.jpg?size=50x50&set=set1', 'ccolgancl@ftc.gov', '330-111-9729', 'ccolgancl', 'qDGvoYhI', '7SBgaq', 502, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (455, 'Rory', 'Sawle', 'https://robohash.org/culpasolutaquo.bmp?size=50x50&set=set1', 'rsawlecm@wix.com', '539-727-5770', 'rsawlecm', 'jCKtb0T8IWmu', 'VhRp60q4kT', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (456, 'Letty', 'Lillow', 'https://robohash.org/velutdolor.jpg?size=50x50&set=set1', 'llillowcn@cafepress.com', '288-709-4595', 'llillowcn', 'wfaxMvKoGZ', 'DF760O', 505, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (457, 'Andrea', 'Bourdice', 'https://robohash.org/sintsitperferendis.bmp?size=50x50&set=set1', 'abourdiceco@jimdo.com', '285-650-0883', 'abourdiceco', 'hrsnM4O5N3jo', 'K0E4ieiGkj', 504, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (458, 'Linoel', 'Brophy', 'https://robohash.org/essesitab.png?size=50x50&set=set1', 'lbrophycp@disqus.com', '355-402-7688', 'lbrophycp', '9gJPZc6d', 'Qv8cv1x80k', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (459, 'Damaris', 'Maes', 'https://robohash.org/maximecumquedolores.png?size=50x50&set=set1', 'dmaescq@usnews.com', '545-957-8114', 'dmaescq', 'IF8Fu1l6h', 'h3DWx6jtc', 506, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (460, 'Mariam', 'Revans', 'https://robohash.org/etmaximenihil.png?size=50x50&set=set1', 'mrevanscr@guardian.co.uk', '759-553-7784', 'mrevanscr', 'b3Un23gKvEc', 'rzjmSZo', 506, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (461, 'Mellisa', 'Muttock', 'https://robohash.org/assumendadolorsapiente.bmp?size=50x50&set=set1', 'mmuttockcs@nature.com', '279-114-4477', 'mmuttockcs', 'vD6bUdQF', 'YgyUqdm', 501, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (462, 'Teresina', 'Whitehorn', 'https://robohash.org/utnonfugit.png?size=50x50&set=set1', 'twhitehornct@elegantthemes.com', '163-252-7329', 'twhitehornct', 'LESauo0Yvva', 'pKRznRvl', 505, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (463, 'Alta', 'Fewlass', 'https://robohash.org/dolorumlaborumatque.bmp?size=50x50&set=set1', 'afewlasscu@facebook.com', '208-358-2462', 'afewlasscu', 'iV2ketofu', 'xZvQyErq', 503, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (464, 'Quentin', 'Entissle', 'https://robohash.org/idaex.bmp?size=50x50&set=set1', 'qentisslecv@newyorker.com', '286-512-0310', 'qentisslecv', 'fAGRl8krI', 'wpnQLFu', 504, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (465, 'Gerhardine', 'Devall', 'https://robohash.org/voluptatumvoluptassed.bmp?size=50x50&set=set1', 'gdevallcw@mayoclinic.com', '472-839-2738', 'gdevallcw', 'I2S1EX', 'iKPJhuX9Rl', 504, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (466, 'Vanya', 'Silber', 'https://robohash.org/quiaullamexpedita.bmp?size=50x50&set=set1', 'vsilbercx@qq.com', '764-893-3987', 'vsilbercx', 'IgS55maNd3Pk', '8Dt4bFHRTZ', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (467, 'Norry', 'Batecok', 'https://robohash.org/doloresestaliquam.bmp?size=50x50&set=set1', 'nbatecokcy@reddit.com', '479-135-0758', 'nbatecokcy', '001iAU', 'iH1Dw5', 501, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (468, 'Kakalina', 'Brunnen', 'https://robohash.org/abmollitiaeos.png?size=50x50&set=set1', 'kbrunnencz@geocities.com', '881-390-6631', 'kbrunnencz', 'oVK1bDM7U', 'K74RSQ8kW', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (469, 'Nancie', 'Marrow', 'https://robohash.org/omnisquitotam.bmp?size=50x50&set=set1', 'nmarrowd0@mayoclinic.com', '504-276-9908', 'nmarrowd0', 'kIgZ6KaocR', 'vEIHF6Z', 505, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (470, 'Freemon', 'Dondon', 'https://robohash.org/quimagnamut.bmp?size=50x50&set=set1', 'fdondond1@blinklist.com', '425-964-4217', 'fdondond1', '79r1CX', 'WjZewWy5', 501, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (471, 'Regina', 'Ladel', 'https://robohash.org/laudantiumsitqui.png?size=50x50&set=set1', 'rladeld2@pcworld.com', '797-132-0764', 'rladeld2', 'nGGDWQcKafDp', 'XDx24lNuBTu', 505, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (472, 'Blythe', 'Hadland', 'https://robohash.org/esttemporacum.png?size=50x50&set=set1', 'bhadlandd3@toplist.cz', '754-625-8594', 'bhadlandd3', '6puoQfK1U', 'qols4xcPU1d', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (473, 'Leigha', 'Reddecliffe', 'https://robohash.org/placeatnobissit.bmp?size=50x50&set=set1', 'lreddecliffed4@ca.gov', '776-277-6682', 'lreddecliffed4', 'rz0uLTzLN', 'WCyruaBNFzzl', 502, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (474, 'Forester', 'Horche', 'https://robohash.org/perspiciatisarchitectocumque.bmp?size=50x50&set=set1', 'fhorched5@uol.com.br', '126-253-9719', 'fhorched5', 'Z1zQRfV9ll', 'qF9oWSEqiS', 503, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (475, 'Alyson', 'Tabrett', 'https://robohash.org/velitutsuscipit.jpg?size=50x50&set=set1', 'atabrettd6@admin.ch', '302-780-2170', 'atabrettd6', 'lB3tnG', 'fHGMuvwq', 502, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (476, 'Gabey', 'Imort', 'https://robohash.org/inabconsequuntur.bmp?size=50x50&set=set1', 'gimortd7@sciencedirect.com', '342-431-4244', 'gimortd7', 'BCfLOlmFfaM', 'goVyWpu7', 504, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (477, 'Maybelle', 'Tigwell', 'https://robohash.org/impeditminimaaperiam.png?size=50x50&set=set1', 'mtigwelld8@cdbaby.com', '764-701-4787', 'mtigwelld8', '0L9uhpkHMR', 'BCQFD7ow5yTQ', 506, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (478, 'Genevieve', 'Gurdon', 'https://robohash.org/earumcupiditatevoluptates.png?size=50x50&set=set1', 'ggurdond9@addthis.com', '533-805-8187', 'ggurdond9', 'i1GVwW2Kl', 'zATVsGwh', 506, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (479, 'Lory', 'Smorthwaite', 'https://robohash.org/rerumnamnihil.jpg?size=50x50&set=set1', 'lsmorthwaiteda@walmart.com', '852-635-1165', 'lsmorthwaiteda', '7Rcj3D', '3snBSP', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (480, 'Luella', 'Mattson', 'https://robohash.org/odioquiaest.bmp?size=50x50&set=set1', 'lmattsondb@ucoz.ru', '361-299-7669', 'lmattsondb', 'u85JL1V', 'YEW9aeHlZyR', 506, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (481, 'Teodorico', 'Klemz', 'https://robohash.org/odioeligendineque.bmp?size=50x50&set=set1', 'tklemzdc@mlb.com', '276-998-5712', 'tklemzdc', 'qBwoVh2Gw', '69KTePdhYrx', 502, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (482, 'Mendie', 'Tesimon', 'https://robohash.org/mollitiaestrem.bmp?size=50x50&set=set1', 'mtesimondd@shinystat.com', '782-790-7300', 'mtesimondd', 'mxrtJZis98', 'BmBYslkJ', 502, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (483, 'Maxy', 'Aldin', 'https://robohash.org/etoditincidunt.jpg?size=50x50&set=set1', 'maldinde@cargocollective.com', '839-489-7275', 'maldinde', 'FcBNghPxYuQJ', 'prVJ4TEoKnpz', 505, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (484, 'Thacher', 'Gregoletti', 'https://robohash.org/quiadoloresaliquam.bmp?size=50x50&set=set1', 'tgregolettidf@who.int', '420-323-1877', 'tgregolettidf', 'mO4EY4JbE8TE', 'MNUl8MUwb2h', 505, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (485, 'Robena', 'Trorey', 'https://robohash.org/rationeautquasi.png?size=50x50&set=set1', 'rtroreydg@issuu.com', '312-265-9017', 'rtroreydg', 'vf2cQ4J', 'bSP1A8zJCXs', 501, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (486, 'Yancey', 'Cuniffe', 'https://robohash.org/estquibusdamqui.png?size=50x50&set=set1', 'ycuniffedh@qq.com', '801-373-3257', 'ycuniffedh', 'l3ZzPJ1', 'qtMGURL5Qr', 506, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (487, 'Lisabeth', 'Barnwell', 'https://robohash.org/undearchitectoquia.bmp?size=50x50&set=set1', 'lbarnwelldi@examiner.com', '115-722-6383', 'lbarnwelldi', 'YnEEty', 'ctaOEbMaDIrs', 501, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (488, 'Cindi', 'Simchenko', 'https://robohash.org/etquamaut.png?size=50x50&set=set1', 'csimchenkodj@xrea.com', '940-877-0855', 'csimchenkodj', 'HpwLTd', 'jXmlG1J2x', 502, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (489, 'Lorrayne', 'Nind', 'https://robohash.org/sunteoseaque.png?size=50x50&set=set1', 'lninddk@issuu.com', '583-487-6978', 'lninddk', 'iVEF9aOC', 'rP7HdW', 504, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (490, 'Willie', 'Markwell', 'https://robohash.org/atrepudiandaeaut.bmp?size=50x50&set=set1', 'wmarkwelldl@harvard.edu', '842-564-8577', 'wmarkwelldl', 'p8U44ovoSJa', 'aFV2sv8dDh6', 501, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (491, 'Tomkin', 'Aitkin', 'https://robohash.org/fugitlaboreexpedita.bmp?size=50x50&set=set1', 'taitkindm@blogspot.com', '135-411-9372', 'taitkindm', '5PDFWgjd0', '1FJnD9', 506, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (492, 'Hillery', 'Wickham', 'https://robohash.org/etquamfacilis.png?size=50x50&set=set1', 'hwickhamdn@ucoz.com', '971-289-1398', 'hwickhamdn', 'lXiJ1e603znr', 'yVyUO6aGzeS', 505, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (493, 'Lindsy', 'Kleuer', 'https://robohash.org/culpaverodebitis.bmp?size=50x50&set=set1', 'lkleuerdo@facebook.com', '842-140-4520', 'lkleuerdo', 'jxzGA0bxmZv', 'NDSsaHl6', 505, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (494, 'Dory', 'Feye', 'https://robohash.org/harumquiexplicabo.bmp?size=50x50&set=set1', 'dfeyedp@japanpost.jp', '328-966-1197', 'dfeyedp', 'ypAoOfnfPAx', 'xUQOgdjrxY', 505, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (495, 'Clovis', 'Devine', 'https://robohash.org/sintsitsunt.png?size=50x50&set=set1', 'cdevinedq@hubpages.com', '909-900-8482', 'cdevinedq', 'lAiCWS52', 'SbpnG0CJKFd', 506, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (496, 'Sauncho', 'Drew-Clifton', 'https://robohash.org/molestiaearchitectosed.png?size=50x50&set=set1', 'sdrewcliftondr@dmoz.org', '322-331-1955', 'sdrewcliftondr', 'Pc2s4J', '9iGKYjGU2', 501, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (497, 'Sophey', 'Glasper', 'https://robohash.org/enimeumfacere.bmp?size=50x50&set=set1', 'sglasperds@loc.gov', '512-233-3544', 'sglasperds', '06d8uB8', '5M4JdNpl', 501, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (498, 'Happy', 'Prew', 'https://robohash.org/estinlaudantium.png?size=50x50&set=set1', 'hprewdt@examiner.com', '987-850-1973', 'hprewdt', '5otlXBxU4DzZ', 'dvtb62', 505, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (499, 'Daffi', 'Schimpke', 'https://robohash.org/nihilnostrumbeatae.bmp?size=50x50&set=set1', 'dschimpkedu@wisc.edu', '504-253-1813', 'dschimpkedu', 'DEqa5uuxlG', 'Ok8U3Y98O', 504, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (500, 'Lauryn', 'Hallgarth', 'https://robohash.org/totammolestiaeet.bmp?size=50x50&set=set1', 'lhallgarthdv@zdnet.com', '912-133-4889', 'lhallgarthdv', '3OLFNOgc', 'uSFZVlw3uLtW', 505, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (501, 'Tiphany', 'Wattam', 'https://robohash.org/istedolorcommodi.png?size=50x50&set=set1', 'twattamdw@homestead.com', '836-124-4689', 'twattamdw', 'tORnLkma', 'ApURx6u', 501, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (502, 'Othella', 'Kisbey', 'https://robohash.org/totamquiest.jpg?size=50x50&set=set1', 'okisbeydx@qq.com', '143-642-8226', 'okisbeydx', '0WV3YtT89T', '7EnQyjI', 501, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (503, 'Paule', 'Dedenham', 'https://robohash.org/inventoreexplicabocorporis.bmp?size=50x50&set=set1', 'pdedenhamdy@google.pl', '243-694-4958', 'pdedenhamdy', 'BZwuSha', 'Xhvf9C', 506, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (504, 'Merrilee', 'Seabright', 'https://robohash.org/voluptatemassumendaquis.bmp?size=50x50&set=set1', 'mseabrightdz@geocities.jp', '520-701-6197', 'mseabrightdz', 'rTbpiL5A', 'pJR67KlM', 501, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (505, 'Jedd', 'Searsby', 'https://robohash.org/undenumquamaut.jpg?size=50x50&set=set1', 'jsearsbye0@telegraph.co.uk', '565-849-2847', 'jsearsbye0', 'xP1KsHs', 'ir2YmstXL', 502, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (506, 'Tandy', 'Spriggen', 'https://robohash.org/quositqui.png?size=50x50&set=set1', 'tspriggene1@blog.com', '842-345-5792', 'tspriggene1', '53ySG5go7Os7', 'Qq3hPlgeq', 505, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (507, 'Viola', 'Ottey', 'https://robohash.org/voluptasquidemculpa.bmp?size=50x50&set=set1', 'votteye2@nba.com', '503-969-6581', 'votteye2', 'SKlPoi', 'aN6fnLZjlf', 504, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (508, 'Kary', 'Coxen', 'https://robohash.org/enimaliquamnulla.bmp?size=50x50&set=set1', 'kcoxene3@geocities.com', '457-954-4763', 'kcoxene3', 'yaWXsChI0T', 'mcaWUcB1omKU', 504, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (509, 'Pierson', 'Le Blanc', 'https://robohash.org/ipsumatqueaut.jpg?size=50x50&set=set1', 'pleblance4@yahoo.co.jp', '588-814-7432', 'pleblance4', '16J9wgRiNqO', '9E8GtRRI', 503, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (510, 'Caroljean', 'Inker', 'https://robohash.org/sitrerumnatus.png?size=50x50&set=set1', 'cinkere5@thetimes.co.uk', '895-906-5485', 'cinkere5', 'I09XDf', 'JO7Lpz', 505, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (511, 'Bird', 'Leggat', 'https://robohash.org/quiaullamvoluptas.jpg?size=50x50&set=set1', 'bleggate6@simplemachines.org', '192-613-4278', 'bleggate6', 'aK301y', 'xLLDXIFGUqqS', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (512, 'Monte', 'Towns', 'https://robohash.org/sitperferendisenim.png?size=50x50&set=set1', 'mtownse7@dyndns.org', '781-367-1363', 'mtownse7', 'RYrgNRfj', 'H5UhSM6WF', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (513, 'Linoel', 'Schorah', 'https://robohash.org/officiaomnissunt.png?size=50x50&set=set1', 'lschorahe8@smugmug.com', '531-158-6976', 'lschorahe8', 'rdv40SQmA', 'tvbgRcnx', 501, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (514, 'Jade', 'Poundford', 'https://robohash.org/repellendusrecusandaereprehenderit.jpg?size=50x50&set=set1', 'jpoundforde9@jimdo.com', '151-641-4179', 'jpoundforde9', 'h5d8tqnx', 'vaz9Bbsn', 504, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (515, 'Orelee', 'Malshinger', 'https://robohash.org/quiconsequunturcommodi.jpg?size=50x50&set=set1', 'omalshingerea@google.cn', '516-217-7794', 'omalshingerea', 'NBg1AI', 'FHH0lFW', 502, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (516, 'Adria', 'Howsam', 'https://robohash.org/etetratione.jpg?size=50x50&set=set1', 'ahowsameb@google.com.br', '189-259-9026', 'ahowsameb', 'iEjM3wBo5', 'l3PEI9', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (517, 'Alphonso', 'Yorke', 'https://robohash.org/consequaturetest.jpg?size=50x50&set=set1', 'ayorkeec@businessinsider.com', '363-875-6065', 'ayorkeec', 'CZs1Eqrk', 'so4bztd', 501, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (518, 'Cart', 'Gerssam', 'https://robohash.org/dictaverovoluptates.png?size=50x50&set=set1', 'cgerssamed@hhs.gov', '170-752-3704', 'cgerssamed', 'EslDRpdS', 'g5Drqy6y', 505, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (519, 'Tad', 'Venour', 'https://robohash.org/autadipiscimollitia.jpg?size=50x50&set=set1', 'tvenouree@sourceforge.net', '173-204-3708', 'tvenouree', 'FKDao49EgDR', 'cVFLii0Z', 505, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (520, 'Cece', 'Wight', 'https://robohash.org/temporedoloreexcepturi.jpg?size=50x50&set=set1', 'cwightef@icio.us', '666-357-5754', 'cwightef', 'c86IRFxlD', 'ybuwLO', 502, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (521, 'Violet', 'McCorkell', 'https://robohash.org/quiaomnisenim.jpg?size=50x50&set=set1', 'vmccorkelleg@g.co', '160-894-4868', 'vmccorkelleg', 'WBUBmLnK', 's5xY3Fg41', 504, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (522, 'Antonie', 'McMurthy', 'https://robohash.org/quiaquassoluta.png?size=50x50&set=set1', 'amcmurthyeh@uol.com.br', '727-880-0491', 'amcmurthyeh', 'zmkGOq', 'Vhwhs9iGI', 505, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (523, 'Cammy', 'Asgodby', 'https://robohash.org/occaecatiquiqui.bmp?size=50x50&set=set1', 'casgodbyei@europa.eu', '893-111-0961', 'casgodbyei', 'aDSlDNvJWhL', 'HPb5JmM0t', 505, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (524, 'Stephenie', 'Hymans', 'https://robohash.org/maioreseiusdolor.png?size=50x50&set=set1', 'shymansej@digg.com', '573-419-3755', 'shymansej', 'MSdApdgwS', 'Y3yokAW', 503, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (525, 'Babbie', 'Aimable', 'https://robohash.org/autconsecteturab.bmp?size=50x50&set=set1', 'baimableek@digg.com', '318-422-5821', 'baimableek', 'WgqG0nUEkQ', 'rfpL4E', 503, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (526, 'Johnathon', 'Blencoe', 'https://robohash.org/rerumvelsimilique.bmp?size=50x50&set=set1', 'jblencoeel@yale.edu', '373-986-0687', 'jblencoeel', 'FpI5P1S', 'OAmC59', 506, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (527, 'Melantha', 'Maddie', 'https://robohash.org/etnumquamdistinctio.png?size=50x50&set=set1', 'mmaddieem@marketwatch.com', '960-580-2840', 'mmaddieem', 'sbFgBVwj', 'Di5mP1P2F', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (528, 'Borden', 'Jacques', 'https://robohash.org/quodconsequatura.png?size=50x50&set=set1', 'bjacquesen@clickbank.net', '741-599-7244', 'bjacquesen', 'qLSwDKvpNYG', 'EOxHAYgoUSWY', 502, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (529, 'Moina', 'Diehn', 'https://robohash.org/etpariaturinventore.png?size=50x50&set=set1', 'mdiehneo@craigslist.org', '747-707-9592', 'mdiehneo', 'NEbzglz', '8UYZVif4', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (530, 'Kora', 'Ashbee', 'https://robohash.org/dolorquiaeos.bmp?size=50x50&set=set1', 'kashbeeep@histats.com', '606-748-7254', 'kashbeeep', 'UTp2oIMjLd', 'XACbkOEkQGgE', 503, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (531, 'Moises', 'Blevin', 'https://robohash.org/illoitaquead.bmp?size=50x50&set=set1', 'mblevineq@acquirethisname.com', '460-176-2336', 'mblevineq', 'nAKnab2LG16Q', 'f55FB2', 501, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (532, 'Edvard', 'Lindemann', 'https://robohash.org/consequaturconsecteturdolore.bmp?size=50x50&set=set1', 'elindemanner@de.vu', '737-726-0238', 'elindemanner', 'UUNkSxViZU', 'oMctex', 506, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (533, 'Ange', 'Heskey', 'https://robohash.org/voluptatemporroamet.png?size=50x50&set=set1', 'aheskeyes@unblog.fr', '666-553-2146', 'aheskeyes', 'MrQbkkga', 'eHf0a0fOY9', 503, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (534, 'Anatola', 'Squibbs', 'https://robohash.org/enimatsint.jpg?size=50x50&set=set1', 'asquibbset@blogtalkradio.com', '959-446-2726', 'asquibbset', 'g2b1kjMY', 'ob9NHOwv5bY', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (535, 'Rosemary', 'Ughetti', 'https://robohash.org/consequaturnesciuntreprehenderit.jpg?size=50x50&set=set1', 'rughettieu@scribd.com', '954-922-4625', 'rughettieu', 'CbGWUd', 'LAim9MzKLFC', 502, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (536, 'Kendall', 'Brendel', 'https://robohash.org/avelcorporis.jpg?size=50x50&set=set1', 'kbrendelev@japanpost.jp', '371-500-5982', 'kbrendelev', 'WfcAUx', 'sVHWqS72h', 503, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (537, 'Yardley', 'Vedishchev', 'https://robohash.org/quiharumsit.png?size=50x50&set=set1', 'yvedishchevew@jigsy.com', '253-402-5972', 'yvedishchevew', '44MWPZ94R', 'nkSo8f', 503, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (538, 'Kennie', 'Ruppeli', 'https://robohash.org/nemoabet.jpg?size=50x50&set=set1', 'kruppeliex@sphinn.com', '463-465-1644', 'kruppeliex', '2EMsiT7', 'lpHITb', 504, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (539, 'Sheilakathryn', 'Groocock', 'https://robohash.org/quisquamrerumdicta.jpg?size=50x50&set=set1', 'sgroocockey@pen.io', '837-136-0543', 'sgroocockey', 'HTriEZsHgfE', 'e4VHkrfR', 503, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (540, 'Byrann', 'Summerbell', 'https://robohash.org/autvoluptatibusvoluptatem.jpg?size=50x50&set=set1', 'bsummerbellez@jigsy.com', '944-775-6892', 'bsummerbellez', 'm7hLWzIdI', 'QCU2vjJxivE', 502, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (541, 'Yvette', 'Garric', 'https://robohash.org/cumqueiustodistinctio.jpg?size=50x50&set=set1', 'ygarricf0@e-recht24.de', '582-757-6775', 'ygarricf0', '1VneVH1jPNU', 'MbnUhNepYz', 502, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (542, 'Denice', 'Lever', 'https://robohash.org/suscipitnonnumquam.png?size=50x50&set=set1', 'dleverf1@quantcast.com', '441-836-5959', 'dleverf1', 'vaq87w8M', 'cMvHupMec', 502, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (543, 'Shae', 'Quinlan', 'https://robohash.org/quoessevelit.jpg?size=50x50&set=set1', 'squinlanf2@naver.com', '883-189-9457', 'squinlanf2', 'r2CIOZ5GZCqC', '0f48DV', 503, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (544, 'Ki', 'Balme', 'https://robohash.org/sitmolestiasvero.bmp?size=50x50&set=set1', 'kbalmef3@goo.ne.jp', '312-576-4857', 'kbalmef3', 'FHsrCQGTx', 'aNVAdnlX', 505, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (545, 'Sari', 'Karlmann', 'https://robohash.org/eaautnobis.jpg?size=50x50&set=set1', 'skarlmannf4@vk.com', '517-392-5844', 'skarlmannf4', 'V4YVxR', 'W9wiMFTTmjHQ', 505, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (546, 'Florrie', 'Utterson', 'https://robohash.org/facereveroporro.jpg?size=50x50&set=set1', 'futtersonf5@meetup.com', '832-665-2044', 'futtersonf5', 'Njo0erOu', 'vdwS13gVT', 506, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (547, 'Charmine', 'Brightie', 'https://robohash.org/cupiditateadipisciqui.bmp?size=50x50&set=set1', 'cbrightief6@studiopress.com', '565-315-6717', 'cbrightief6', 'VfJeY0Igb', 'DYsZ4C', 502, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (548, 'Vittorio', 'Bhar', 'https://robohash.org/nequequodab.jpg?size=50x50&set=set1', 'vbharf7@oakley.com', '156-938-1872', 'vbharf7', '0IYh9HiyQ3tx', 'quspaos25', 506, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (549, 'Baird', 'McClaughlin', 'https://robohash.org/evenietetnecessitatibus.bmp?size=50x50&set=set1', 'bmcclaughlinf8@wisc.edu', '398-552-0610', 'bmcclaughlinf8', 'Ufhem5JW', 'P92k75', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (550, 'Remy', 'Colleran', 'https://robohash.org/occaecatiprovidenttotam.jpg?size=50x50&set=set1', 'rcolleranf9@ftc.gov', '759-117-2573', 'rcolleranf9', 'EbfPxw', 'TYSXWQDrjaSX', 504, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (551, 'Alvan', 'Dodshun', 'https://robohash.org/occaecatioditamet.jpg?size=50x50&set=set1', 'adodshunfa@mashable.com', '657-308-6281', 'adodshunfa', 'WyUgSyJ', '9Y5UerL', 504, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (552, 'Ashley', 'Rugge', 'https://robohash.org/enimvoluptatevoluptates.bmp?size=50x50&set=set1', 'aruggefb@sakura.ne.jp', '510-620-3174', 'aruggefb', 'oAbagNtnkY', 'DrGrToI', 502, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (553, 'Barth', 'Phant', 'https://robohash.org/utquivoluptas.bmp?size=50x50&set=set1', 'bphantfc@engadget.com', '515-644-0972', 'bphantfc', 'DLNtGeH79BL', 'JHFO0gR', 503, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (554, 'Hetty', 'O''Kennavain', 'https://robohash.org/eteiussit.png?size=50x50&set=set1', 'hokennavainfd@facebook.com', '103-398-5898', 'hokennavainfd', '4e0JtYaNEO', 'Wlkkk70wcUw', 504, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (555, 'Devinne', 'Briance', 'https://robohash.org/quiconsequaturquo.bmp?size=50x50&set=set1', 'dbriancefe@rediff.com', '217-515-1404', 'dbriancefe', 'NZRQSBp4QD5', 'H61u44VQRC1c', 506, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (556, 'Vivian', 'Toogood', 'https://robohash.org/commodinecessitatibusvelit.jpg?size=50x50&set=set1', 'vtoogoodff@ftc.gov', '234-568-6182', 'vtoogoodff', 'GCNRhMwiji0E', 'R1WfTG', 504, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (557, 'Lianna', 'Lally', 'https://robohash.org/nonestquod.png?size=50x50&set=set1', 'llallyfg@ted.com', '172-430-7351', 'llallyfg', 'JUBylvwr', 'jtOK54aXt', 504, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (558, 'Betteanne', 'Desorts', 'https://robohash.org/aliasconsequaturquae.bmp?size=50x50&set=set1', 'bdesortsfh@hhs.gov', '249-118-6959', 'bdesortsfh', 'FIKjABal', 'VcxvkVE', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (559, 'Worth', 'Mohammed', 'https://robohash.org/quirationeeveniet.png?size=50x50&set=set1', 'wmohammedfi@nymag.com', '628-461-8709', 'wmohammedfi', '4MpvGTlC', 'PXOqD20UahTr', 504, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (560, 'Temp', 'Lysons', 'https://robohash.org/doloremeligendiquae.bmp?size=50x50&set=set1', 'tlysonsfj@wired.com', '451-294-9641', 'tlysonsfj', 'RoicFV69K5', 'HRvdXWw', 501, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (561, 'Timmy', 'Stiven', 'https://robohash.org/velitexercitationemaperiam.jpg?size=50x50&set=set1', 'tstivenfk@biglobe.ne.jp', '322-186-8126', 'tstivenfk', 'cNlNZKrbG', '75mQRJvpm8z', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (562, 'Emmie', 'Drinkel', 'https://robohash.org/illumvoluptatesvelit.bmp?size=50x50&set=set1', 'edrinkelfl@elpais.com', '239-507-5872', 'edrinkelfl', 'LXtdSjgGsT', 'GCRmQhXL', 505, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (563, 'Yanaton', 'Brunetti', 'https://robohash.org/undevoluptatemdolore.bmp?size=50x50&set=set1', 'ybrunettifm@discovery.com', '807-170-4248', 'ybrunettifm', 'cE9hme', 'avJvNzfK8', 505, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (564, 'Pippo', 'Bowcock', 'https://robohash.org/officianonsunt.bmp?size=50x50&set=set1', 'pbowcockfn@cnet.com', '396-596-5023', 'pbowcockfn', 'S0rbn5tZ', '6wYAGOIwmk', 506, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (565, 'Janie', 'McCombe', 'https://robohash.org/atquisunt.bmp?size=50x50&set=set1', 'jmccombefo@house.gov', '471-685-3803', 'jmccombefo', 'xaSbGi', 'NpT33eu4n', 502, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (566, 'Arlee', 'McVie', 'https://robohash.org/mollitiavoluptatibusdolores.png?size=50x50&set=set1', 'amcviefp@archive.org', '303-176-3995', 'amcviefp', 'JunAuk', 'rapBz02SAl', 501, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (567, 'Constantin', 'Ballantine', 'https://robohash.org/quiaetest.jpg?size=50x50&set=set1', 'cballantinefq@arizona.edu', '552-362-9386', 'cballantinefq', 'Kzjzrx1lYEz', 'za2T7Y', 502, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (568, 'Jerry', 'Coie', 'https://robohash.org/nisifacereipsam.jpg?size=50x50&set=set1', 'jcoiefr@dailymail.co.uk', '265-663-8458', 'jcoiefr', 'XFlisvc6', 'LbPTuNJ', 504, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (569, 'Leoine', 'Brandin', 'https://robohash.org/quaeratculpaest.jpg?size=50x50&set=set1', 'lbrandinfs@smh.com.au', '394-885-3944', 'lbrandinfs', '4gr3ilWFX3l', 'M3xBekC', 506, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (570, 'Bourke', 'Cranna', 'https://robohash.org/quaesedplaceat.bmp?size=50x50&set=set1', 'bcrannaft@creativecommons.org', '326-399-9724', 'bcrannaft', 'yjaTY4t', '8OndyED4cJE', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (571, 'Brittne', 'Olyet', 'https://robohash.org/veritatisitaquerepudiandae.jpg?size=50x50&set=set1', 'bolyetfu@irs.gov', '961-461-7257', 'bolyetfu', 'XLQMeiQrE', 'i4UGnlmYOpX', 502, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (572, 'Eveleen', 'Pauly', 'https://robohash.org/temporibusdoloraspernatur.bmp?size=50x50&set=set1', 'epaulyfv@google.ru', '435-376-4334', 'epaulyfv', 'YSm9sQztQa', '8yMAVNA88', 505, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (573, 'Miltie', 'Bowman', 'https://robohash.org/quiaexsuscipit.bmp?size=50x50&set=set1', 'mbowmanfw@bandcamp.com', '199-676-6902', 'mbowmanfw', 'GTM6rt', 'rrOXeLHBHPt', 503, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (574, 'Jeremy', 'Burress', 'https://robohash.org/quaeestreprehenderit.png?size=50x50&set=set1', 'jburressfx@cocolog-nifty.com', '462-267-3899', 'jburressfx', 'JVYGun2H', '3CrWTs0b', 501, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (575, 'Gardner', 'Goodbourn', 'https://robohash.org/consequaturiustoconsequatur.jpg?size=50x50&set=set1', 'ggoodbournfy@i2i.jp', '798-952-8198', 'ggoodbournfy', 'kqOEfosDDp8', 'KOSxVtoDwcpv', 504, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (576, 'Tatum', 'Santhouse', 'https://robohash.org/atquisut.bmp?size=50x50&set=set1', 'tsanthousefz@marketwatch.com', '846-641-2935', 'tsanthousefz', 'CFYo7zAB3Y', '7fDGiFH4xb', 506, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (577, 'Elsinore', 'Noquet', 'https://robohash.org/eiussitporro.jpg?size=50x50&set=set1', 'enoquetg0@istockphoto.com', '490-884-6707', 'enoquetg0', 'FYxAziJ', 'qywbAKy', 505, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (578, 'Heath', 'Selvey', 'https://robohash.org/quiafugiatconsequuntur.bmp?size=50x50&set=set1', 'hselveyg1@phoca.cz', '592-875-4020', 'hselveyg1', 'rCOOXoG', '2lkoeMAiZXEA', 504, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (579, 'Nikos', 'Jepp', 'https://robohash.org/undevoluptatessint.png?size=50x50&set=set1', 'njeppg2@nydailynews.com', '463-744-9133', 'njeppg2', 'g9ZjGFIAjY', 'DuDCATs', 505, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (580, 'Jackquelin', 'Peealess', 'https://robohash.org/laudantiumeiuslaborum.png?size=50x50&set=set1', 'jpeealessg3@example.com', '505-946-2394', 'jpeealessg3', 'jKBRT41oTA', 'mXhvsrzbXJH', 503, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (581, 'Mellie', 'Prendergrast', 'https://robohash.org/ducimusoccaecatiratione.jpg?size=50x50&set=set1', 'mprendergrastg4@storify.com', '864-730-3258', 'mprendergrastg4', 'VHlWSaeSt', 'YRA0ocb', 503, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (582, 'Jannel', 'Camp', 'https://robohash.org/providentdoloremnemo.bmp?size=50x50&set=set1', 'jcampg5@cdc.gov', '874-670-0740', 'jcampg5', 'caBQAt6', 'LPtXItiUGAo', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (583, 'Bern', 'Wittier', 'https://robohash.org/cumhicvoluptate.bmp?size=50x50&set=set1', 'bwittierg6@whitehouse.gov', '280-315-8276', 'bwittierg6', 'ezomF5Mp', '2j9rAq', 506, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (584, 'Karil', 'Rubinowitsch', 'https://robohash.org/istevoluptasassumenda.png?size=50x50&set=set1', 'krubinowitschg7@aboutads.info', '363-689-2161', 'krubinowitschg7', 'AGw6w25S1HIa', 'Lpuy9kpCV5r2', 501, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (585, 'Adela', 'Cullington', 'https://robohash.org/etquasut.bmp?size=50x50&set=set1', 'acullingtong8@google.ru', '628-745-5456', 'acullingtong8', 'tvzaqExi', 'MjDxdMtq', 503, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (586, 'Charyl', 'Chisholme', 'https://robohash.org/nequeearumexcepturi.jpg?size=50x50&set=set1', 'cchisholmeg9@netlog.com', '826-272-6387', 'cchisholmeg9', 'JzXN8NsjIc', 'PjrD3paUXML', 504, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (587, 'Kary', 'Matyashev', 'https://robohash.org/illovoluptasdolor.bmp?size=50x50&set=set1', 'kmatyashevga@amazonaws.com', '396-666-1888', 'kmatyashevga', 'KwLCaVZIj', 'JSUxezuRkqD5', 506, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (588, 'Renate', 'Leftwich', 'https://robohash.org/facilismolestiaevoluptate.png?size=50x50&set=set1', 'rleftwichgb@accuweather.com', '698-518-0171', 'rleftwichgb', 'BMbJx4Df5ou', 'Y7RxGPws', 503, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (589, 'Nikolaos', 'Blower', 'https://robohash.org/totamimpeditdolore.png?size=50x50&set=set1', 'nblowergc@amazon.com', '402-543-2027', 'nblowergc', 'BDeMOon83', 'tZI5piSne2GJ', 502, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (590, 'Odille', 'Larsen', 'https://robohash.org/nemoveroiusto.jpg?size=50x50&set=set1', 'olarsengd@washington.edu', '106-377-6239', 'olarsengd', 'oljkXPesm', '5BnFzu7', 506, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (591, 'Maegan', 'Steffan', 'https://robohash.org/iddoloremsit.png?size=50x50&set=set1', 'msteffange@dropbox.com', '636-638-3474', 'msteffange', 'fBWpLP', 'Zsvv4oZhbF8v', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (592, 'Noemi', 'More', 'https://robohash.org/modiautrerum.png?size=50x50&set=set1', 'nmoregf@utexas.edu', '867-318-5103', 'nmoregf', 'Wj25sn1K', 'xyXEyK3GDdXT', 506, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (593, 'Morley', 'Creaney', 'https://robohash.org/insolutadolorum.bmp?size=50x50&set=set1', 'mcreaneygg@wufoo.com', '724-196-0092', 'mcreaneygg', 't1HBzTGCN', 'xuV3x3', 501, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (594, 'Reiko', 'Milland', 'https://robohash.org/quicommodiquo.png?size=50x50&set=set1', 'rmillandgh@creativecommons.org', '283-386-1539', 'rmillandgh', 'AnYjajNmbk', '618iod3RK', 502, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (595, 'Korey', 'Featherstonhalgh', 'https://robohash.org/pariaturnatusfugit.jpg?size=50x50&set=set1', 'kfeatherstonhalghgi@biblegateway.com', '743-317-6381', 'kfeatherstonhalghgi', '3RnWmdYz28NP', 'EOZik9xlG8T', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (596, 'Ernie', 'Seson', 'https://robohash.org/laborumsuntest.png?size=50x50&set=set1', 'esesongj@blogspot.com', '288-613-2301', 'esesongj', 'CFglfZS', 'A7rdNgk', 502, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (597, 'Tyler', 'Redington', 'https://robohash.org/eteoscum.jpg?size=50x50&set=set1', 'tredingtongk@nytimes.com', '245-553-6785', 'tredingtongk', 'yZKoM9J2Mr', 'CEpzkQA4X', 502, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (598, 'Eran', 'Dufour', 'https://robohash.org/velnihilalias.bmp?size=50x50&set=set1', 'edufourgl@mediafire.com', '737-659-8499', 'edufourgl', 'KL3boDrhawui', 'EYU0Aha', 503, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (599, 'Rosalinde', 'Platfoot', 'https://robohash.org/estiurenemo.jpg?size=50x50&set=set1', 'rplatfootgm@quantcast.com', '400-927-9722', 'rplatfootgm', 'SapqHvNy', 'Qk5xhvKWtG5', 504, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (600, 'Teriann', 'Yellep', 'https://robohash.org/quasnihilpraesentium.png?size=50x50&set=set1', 'tyellepgn@wikispaces.com', '735-933-1243', 'tyellepgn', 'TsqV1GJps', 'bduy1jDx0xKp', 502, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (601, 'Mariquilla', 'Graine', 'https://robohash.org/eavitaepraesentium.jpg?size=50x50&set=set1', 'mgrainego@yahoo.co.jp', '189-598-1008', 'mgrainego', 'PKYOAd', '15iPXd', 503, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (602, 'Bonita', 'Karpenko', 'https://robohash.org/nonlaborumsint.jpg?size=50x50&set=set1', 'bkarpenkogp@deliciousdays.com', '595-728-7038', 'bkarpenkogp', 'jg271ZyLfIL', 'yyOmmMuZ0', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (603, 'Tobiah', 'Vigar', 'https://robohash.org/laborequorerum.png?size=50x50&set=set1', 'tvigargq@hhs.gov', '280-988-6530', 'tvigargq', '24i6nG', 'fgA41b14e', 506, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (604, 'Willy', 'Swinburne', 'https://robohash.org/doloresinquis.jpg?size=50x50&set=set1', 'wswinburnegr@deliciousdays.com', '152-438-4837', 'wswinburnegr', '83b7NhHv', 'JnNTHuF7g', 502, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (605, 'Cissiee', 'Skeemer', 'https://robohash.org/explicabodolorquis.png?size=50x50&set=set1', 'cskeemergs@latimes.com', '167-204-6721', 'cskeemergs', '2fnuvNK53Qwr', 'VM7oNaZqrMEu', 504, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (606, 'Kayla', 'Demelt', 'https://robohash.org/perferendisnatusminima.bmp?size=50x50&set=set1', 'kdemeltgt@infoseek.co.jp', '458-637-2877', 'kdemeltgt', 'OoC7hecj1K0M', '4PG6qX1jU9N', 501, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (607, 'Giulio', 'Matteini', 'https://robohash.org/nisiadvelit.jpg?size=50x50&set=set1', 'gmatteinigu@mediafire.com', '841-863-1147', 'gmatteinigu', 'mC8m2M', 'J1tZ3YADD', 505, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (608, 'Jennette', 'Timothy', 'https://robohash.org/quaemolestiasnatus.png?size=50x50&set=set1', 'jtimothygv@drupal.org', '843-818-9359', 'jtimothygv', 'RMmwIps', 'P8Tc3TF', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (609, 'Aurore', 'Fellos', 'https://robohash.org/corporisharumsapiente.jpg?size=50x50&set=set1', 'afellosgw@dion.ne.jp', '614-842-6649', 'afellosgw', '3AcmtvWKU', 'Ss35TypCIM', 504, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (610, 'Julita', 'Gooddy', 'https://robohash.org/dictaveritatisamet.bmp?size=50x50&set=set1', 'jgooddygx@tripadvisor.com', '596-878-9483', 'jgooddygx', '4EJUuxPUHTf', 'NgnH9L', 502, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (611, 'Suzann', 'Beggin', 'https://robohash.org/quomodinobis.bmp?size=50x50&set=set1', 'sbeggingy@opensource.org', '949-284-5282', 'sbeggingy', 'yorfzziz4mql', 'HeoWB9Jd', 505, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (612, 'Royal', 'Celloni', 'https://robohash.org/cumquesuscipitvoluptatem.jpg?size=50x50&set=set1', 'rcellonigz@canalblog.com', '497-308-6039', 'rcellonigz', 'B6AVIqMlrVS', 'K2Z7jpDF', 501, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (613, 'Othelia', 'Wiz', 'https://robohash.org/repellatutrerum.jpg?size=50x50&set=set1', 'owizh0@xing.com', '955-343-0210', 'owizh0', 'MbUlIJWUL', 'tbBkdC4qyoz', 503, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (614, 'Bastian', 'Rickardsson', 'https://robohash.org/nemoetlaborum.bmp?size=50x50&set=set1', 'brickardssonh1@answers.com', '378-782-3162', 'brickardssonh1', 'YZYamh5', 'fCShv8hP2', 501, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (615, 'Alethea', 'Darcey', 'https://robohash.org/autfugiatipsum.jpg?size=50x50&set=set1', 'adarceyh2@sfgate.com', '500-787-6619', 'adarceyh2', 'OWKErE5w0brm', '4sn4TrXFfd', 503, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (616, 'Neddy', 'Geany', 'https://robohash.org/commodietprovident.png?size=50x50&set=set1', 'ngeanyh3@tripadvisor.com', '814-562-1865', 'ngeanyh3', 'gOyJYhdcZOG1', 'U0BnJh', 505, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (617, 'Krissie', 'Olphert', 'https://robohash.org/sequiminusrem.bmp?size=50x50&set=set1', 'kolpherth4@wufoo.com', '760-207-1197', 'kolpherth4', 'SpScXk', '9wnvORwjUxgP', 503, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (618, 'Les', 'Woodsford', 'https://robohash.org/etexcepturitenetur.jpg?size=50x50&set=set1', 'lwoodsfordh5@purevolume.com', '692-190-8687', 'lwoodsfordh5', 'mPQck2fr', 'LhwjM7fU1', 505, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (619, 'Robert', 'Berrey', 'https://robohash.org/minimaveritatisomnis.jpg?size=50x50&set=set1', 'rberreyh6@newsvine.com', '114-990-4314', 'rberreyh6', 'A0Q9EPtogu', 'UafAMXMPVtEI', 503, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (620, 'Kelsy', 'Blaze', 'https://robohash.org/idoptioet.png?size=50x50&set=set1', 'kblazeh7@walmart.com', '925-976-1024', 'kblazeh7', 'aSifRVaC', 'mPfZ34', 502, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (621, 'Walt', 'Leetham', 'https://robohash.org/esseofficiiset.bmp?size=50x50&set=set1', 'wleethamh8@about.me', '833-515-2866', 'wleethamh8', 'tzxmNM61', '6BsvPZ', 503, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (622, 'Garik', 'Harriss', 'https://robohash.org/culpaadvoluptatum.bmp?size=50x50&set=set1', 'gharrissh9@boston.com', '657-687-7570', 'gharrissh9', 'gj0TMTvDCAV', '3L8al4YgmQEu', 503, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (623, 'Riccardo', 'Smurfitt', 'https://robohash.org/recusandaeautconsequatur.jpg?size=50x50&set=set1', 'rsmurfittha@sphinn.com', '779-751-9522', 'rsmurfittha', '2lros5hHRp', 'qARmdeip7', 504, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (624, 'Madison', 'Gabel', 'https://robohash.org/accusantiumquamest.bmp?size=50x50&set=set1', 'mgabelhb@prlog.org', '925-379-2751', 'mgabelhb', 'yYQGdR', 'XGfSPRu', 501, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (625, 'Diarmid', 'Lief', 'https://robohash.org/molestiaeomnisquibusdam.bmp?size=50x50&set=set1', 'dliefhc@exblog.jp', '385-849-0048', 'dliefhc', 'fV1BfU7oirPW', 'E1GtXu', 502, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (626, 'Yvon', 'Pavic', 'https://robohash.org/omnismaioresquo.jpg?size=50x50&set=set1', 'ypavichd@java.com', '248-746-5203', 'ypavichd', 'VxIQIHAGFk9', 'MtbuACRX7', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (627, 'Nesta', 'Feaks', 'https://robohash.org/estvoluptasincidunt.bmp?size=50x50&set=set1', 'nfeakshe@netscape.com', '495-852-8196', 'nfeakshe', 'WPazWr', '9nbfsq5YWV', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (628, 'Melly', 'Pollicatt', 'https://robohash.org/sintutvoluptatibus.jpg?size=50x50&set=set1', 'mpollicatthf@ucoz.ru', '778-914-8043', 'mpollicatthf', 'XiisQY', 'FiSzRttZaCqJ', 501, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (629, 'Joana', 'Dod', 'https://robohash.org/voluptatesducimusincidunt.bmp?size=50x50&set=set1', 'jdodhg@goodreads.com', '870-617-6968', 'jdodhg', 'C9WEwJmVANE', 'jr5QlJR4a', 502, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (630, 'Kessia', 'Althrop', 'https://robohash.org/nihilestnon.jpg?size=50x50&set=set1', 'kalthrophh@vimeo.com', '482-718-1199', 'kalthrophh', 'yZUPMXxe', 'QEheW8FNishw', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (631, 'Mellicent', 'Pepye', 'https://robohash.org/inrerumnulla.png?size=50x50&set=set1', 'mpepyehi@altervista.org', '718-468-4931', 'mpepyehi', 'ULTz4e', 'Vi7PsVLWt', 504, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (632, 'Ive', 'Gheeorghie', 'https://robohash.org/doloremestamet.jpg?size=50x50&set=set1', 'igheeorghiehj@army.mil', '690-492-9410', 'igheeorghiehj', 'Cs3079gbq53N', 'Yo3bM24h', 505, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (633, 'Idalia', 'Hatherleigh', 'https://robohash.org/utplaceataccusamus.png?size=50x50&set=set1', 'ihatherleighhk@webeden.co.uk', '279-450-3606', 'ihatherleighhk', 'GTpsiQ5w9', 'tdIhFcnpi', 502, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (634, 'Lucille', 'Fane', 'https://robohash.org/nemosaepeid.png?size=50x50&set=set1', 'lfanehl@addtoany.com', '959-210-7258', 'lfanehl', 'PFpTAsg712', 'OkxML7p', 504, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (635, 'Annmarie', 'Creboe', 'https://robohash.org/illumhiclabore.png?size=50x50&set=set1', 'acreboehm@whitehouse.gov', '843-153-6208', 'acreboehm', 'WRIo9ydLZj0K', 'RdQ16dnAYU4X', 506, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (636, 'Lotty', 'Eayres', 'https://robohash.org/namsaepeoptio.bmp?size=50x50&set=set1', 'leayreshn@vinaora.com', '115-358-5374', 'leayreshn', 'ppfd9Zp0', 'Ixy4SJigxSrd', 504, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (637, 'Eldin', 'Franken', 'https://robohash.org/sitexcepturilaborum.png?size=50x50&set=set1', 'efrankenho@is.gd', '228-946-9350', 'efrankenho', 'TwUxmuKARh', 'nb68N1od3QI', 504, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (638, 'Jeannie', 'Vasnev', 'https://robohash.org/dictadoloremqueerror.bmp?size=50x50&set=set1', 'jvasnevhp@china.com.cn', '936-227-3665', 'jvasnevhp', 'd2FxHQhC', '7TiK7mOc', 503, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (639, 'Vaclav', 'Foakes', 'https://robohash.org/autemetrerum.bmp?size=50x50&set=set1', 'vfoakeshq@sakura.ne.jp', '710-321-8420', 'vfoakeshq', 'qUg2X0', '3CrAYj5GiF9k', 501, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (640, 'Kelsey', 'Ollington', 'https://robohash.org/etexcepturiearum.bmp?size=50x50&set=set1', 'kollingtonhr@epa.gov', '639-246-1348', 'kollingtonhr', 'gAxZQWg', 'y70E40x0KN', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (641, 'Errick', 'Greeno', 'https://robohash.org/nihilmagnieveniet.png?size=50x50&set=set1', 'egreenohs@soundcloud.com', '847-884-7263', 'egreenohs', 'IG5aZm4tyOKb', 'Iuw2Bncn6Je', 503, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (642, 'Trix', 'Ethridge', 'https://robohash.org/utquieos.bmp?size=50x50&set=set1', 'tethridgeht@multiply.com', '666-903-0381', 'tethridgeht', 'xCDHEvI', 'uBgentpM', 501, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (643, 'Sylvan', 'Lago', 'https://robohash.org/nullatotamiure.jpg?size=50x50&set=set1', 'slagohu@google.com.hk', '630-650-7785', 'slagohu', 'iEGoxcqr54i', 'GNDaK3A2e', 505, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (644, 'Genevieve', 'Wallsam', 'https://robohash.org/totamautaliquam.bmp?size=50x50&set=set1', 'gwallsamhv@hubpages.com', '813-322-1507', 'gwallsamhv', 'f3R5p5Izj', 'Uh9CP84', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (645, 'Maris', 'Cornhill', 'https://robohash.org/veritatisquaeplaceat.png?size=50x50&set=set1', 'mcornhillhw@is.gd', '351-576-1865', 'mcornhillhw', 'B0vKkEVQ', 'KuGD35', 504, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (646, 'Amabel', 'Kingh', 'https://robohash.org/voluptatemlaudantiumearum.bmp?size=50x50&set=set1', 'akinghhx@vinaora.com', '908-843-9960', 'akinghhx', 'D7teib2U0YAf', 'ySvQe9pv', 501, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (647, 'Shem', 'Bloom', 'https://robohash.org/doloremquisuscipit.jpg?size=50x50&set=set1', 'sbloomhy@shinystat.com', '781-565-2512', 'sbloomhy', 'rt9xLa5', '2HiSkr', 505, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (648, 'Malissia', 'Wickwarth', 'https://robohash.org/eiusipsumrerum.bmp?size=50x50&set=set1', 'mwickwarthhz@hostgator.com', '813-973-6276', 'mwickwarthhz', 'O7682Coxr', 'e78B7ZF5sfo', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (649, 'Gamaliel', 'Jerzak', 'https://robohash.org/etvoluptatemconsequatur.bmp?size=50x50&set=set1', 'gjerzaki0@angelfire.com', '416-150-1099', 'gjerzaki0', 'jLOjSQzILZ', 'Lftt9He7D', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (650, 'Ash', 'Lunck', 'https://robohash.org/autdolorumrecusandae.jpg?size=50x50&set=set1', 'aluncki1@infoseek.co.jp', '455-332-2865', 'aluncki1', 'EcNWxsLfUzZz', 'zm7tpd6OpFI', 501, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (651, 'Elsworth', 'Bennen', 'https://robohash.org/enimquaeratquos.png?size=50x50&set=set1', 'ebenneni2@msn.com', '233-684-5879', 'ebenneni2', 'hwCo2rDXguRa', 'dtd5aD2', 501, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (652, 'Erastus', 'Claesens', 'https://robohash.org/commodiautharum.png?size=50x50&set=set1', 'eclaesensi3@sitemeter.com', '726-802-3568', 'eclaesensi3', 'pwlNb3nOKdP', 'hUU3tcm', 502, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (653, 'Brier', 'Griswaite', 'https://robohash.org/molestiasaliquidvero.bmp?size=50x50&set=set1', 'bgriswaitei4@cmu.edu', '531-936-7316', 'bgriswaitei4', 'tP8OUL', '2exnAShAvxB', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (654, 'Jordan', 'Dabels', 'https://robohash.org/quiplaceatdolor.bmp?size=50x50&set=set1', 'jdabelsi5@themeforest.net', '456-170-0944', 'jdabelsi5', 'sgGO3Ok', '0Ev6vlm5GE9', 505, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (655, 'Kalil', 'Snowdon', 'https://robohash.org/officiaassumendadistinctio.png?size=50x50&set=set1', 'ksnowdoni6@addthis.com', '741-990-9168', 'ksnowdoni6', 'tU2sEMzGsTY', 's5vyu31S9c', 505, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (656, 'Bianka', 'Bettridge', 'https://robohash.org/exercitationemveniamaut.jpg?size=50x50&set=set1', 'bbettridgei7@dagondesign.com', '537-528-8708', 'bbettridgei7', '8gvEZlDgO', '3ECxxvXuk', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (657, 'Suzette', 'Eubank', 'https://robohash.org/ipsamaliasvelit.jpg?size=50x50&set=set1', 'seubanki8@seattletimes.com', '379-308-8717', 'seubanki8', '8YDb9rYRQ3V', 'kyZefv6KOmqV', 502, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (658, 'Mead', 'Gerardi', 'https://robohash.org/beataeveritatisaut.png?size=50x50&set=set1', 'mgerardii9@amazon.com', '548-229-4129', 'mgerardii9', 'Hl84qVGglF', 'UQyXhoOxc7J', 501, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (659, 'Christopher', 'Duffin', 'https://robohash.org/animiquidemdistinctio.jpg?size=50x50&set=set1', 'cduffinia@narod.ru', '719-267-3602', 'cduffinia', 'nwo6ry', '1uBw4AXhRA', 503, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (660, 'Bertie', 'Andrzejowski', 'https://robohash.org/sintquilabore.png?size=50x50&set=set1', 'bandrzejowskiib@icio.us', '366-469-6074', 'bandrzejowskiib', '70YbXSpNI', 'CcXinEB9ID9d', 505, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (661, 'Robina', 'Brickner', 'https://robohash.org/suntrerumsint.bmp?size=50x50&set=set1', 'rbrickneric@over-blog.com', '700-716-6566', 'rbrickneric', 'rZUg0dH14Z', 'Q17ro1soHZW8', 502, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (662, 'Piotr', 'Bedin', 'https://robohash.org/minimaperferendisest.bmp?size=50x50&set=set1', 'pbedinid@fastcompany.com', '565-871-5657', 'pbedinid', 'JTtNaYF', 'gImLgiMMPD', 505, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (663, 'Valentino', 'Godehard.sf', 'https://robohash.org/velitadipisciexpedita.bmp?size=50x50&set=set1', 'vgodehardsfie@who.int', '664-936-4430', 'vgodehardsfie', 'c88nW5y', 'yW238d4b8Hg9', 503, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (664, 'Nissy', 'Vallis', 'https://robohash.org/quisexercitationemnulla.png?size=50x50&set=set1', 'nvallisif@cargocollective.com', '642-649-2280', 'nvallisif', '1m62CH', 'RGQE7ZKEA', 503, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (665, 'Pierson', 'Kernocke', 'https://robohash.org/quossedrepudiandae.png?size=50x50&set=set1', 'pkernockeig@economist.com', '232-767-0345', 'pkernockeig', 'aLomR9i6qoR', 'KbGM4IzuI5gF', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (666, 'Rupert', 'Davidescu', 'https://robohash.org/etautfugiat.jpg?size=50x50&set=set1', 'rdavidescuih@wufoo.com', '236-772-2858', 'rdavidescuih', 'NVYXfb', 'SkqHsZSOYB', 502, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (667, 'Tiffie', 'Jaher', 'https://robohash.org/perspiciatiseaquetenetur.png?size=50x50&set=set1', 'tjaherii@tmall.com', '220-939-7404', 'tjaherii', 'Mnqp88', 'JcAnOCJCGpah', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (668, 'Daryle', 'Creak', 'https://robohash.org/animietvel.png?size=50x50&set=set1', 'dcreakij@toplist.cz', '319-696-5327', 'dcreakij', '7psU4b5yvYX', 'KEY7Mtx8pnc', 506, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (669, 'Koo', 'Ainsby', 'https://robohash.org/facereetaspernatur.jpg?size=50x50&set=set1', 'kainsbyik@xinhuanet.com', '681-584-0263', 'kainsbyik', 'T8NhIbYxh', 'HnkZcWhPyOB', 504, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (670, 'Mischa', 'Scogin', 'https://robohash.org/undedoloremquead.jpg?size=50x50&set=set1', 'mscoginil@about.com', '425-727-6700', 'mscoginil', 'HTiaNW8qiz8B', 'xLhi8i0', 501, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (671, 'Ammamaria', 'Drains', 'https://robohash.org/atqueideaque.bmp?size=50x50&set=set1', 'adrainsim@alexa.com', '265-842-1728', 'adrainsim', 'vsW2lfZvH', 'nOBj7gW5P6XV', 504, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (672, 'Ira', 'Demer', 'https://robohash.org/sitnihildolor.png?size=50x50&set=set1', 'idemerin@sina.com.cn', '828-964-4901', 'idemerin', 'TkUxZkVQz', 'w6F1TiUV', 505, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (673, 'Durant', 'Sushams', 'https://robohash.org/doloribustemporaexercitationem.jpg?size=50x50&set=set1', 'dsushamsio@loc.gov', '577-716-3007', 'dsushamsio', 'ROSrrDs0', 'pysVmjJv', 503, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (674, 'Kristal', 'Skegg', 'https://robohash.org/doloribusquia.jpg?size=50x50&set=set1', 'kskeggip@goodreads.com', '321-380-9329', 'kskeggip', '0frFcTo', 'vCC6bmKmAg', 506, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (675, 'Antin', 'Arniz', 'https://robohash.org/autquasvoluptatem.bmp?size=50x50&set=set1', 'aarniziq@census.gov', '725-788-0571', 'aarniziq', '3EWtnkbaddF', 'rTajShJNU8gI', 504, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (676, 'Sally', 'Rubke', 'https://robohash.org/quiaspernaturdolores.jpg?size=50x50&set=set1', 'srubkeir@auda.org.au', '990-923-2195', 'srubkeir', 'oPg16OB', 'CXCRNlS', 505, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (677, 'Abrahan', 'Giacomuzzo', 'https://robohash.org/oditvoluptatibusaccusantium.jpg?size=50x50&set=set1', 'agiacomuzzois@163.com', '897-146-6783', 'agiacomuzzois', 'HtMunsLXW', 'yfe5wa944k', 503, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (678, 'Albertine', 'Waud', 'https://robohash.org/voluptatemtemporavoluptas.jpg?size=50x50&set=set1', 'awaudit@vistaprint.com', '690-631-4333', 'awaudit', 'm4mTXq', 'ZRQFChn', 503, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (679, 'Merrie', 'Asipenko', 'https://robohash.org/estaeos.bmp?size=50x50&set=set1', 'masipenkoiu@imageshack.us', '487-585-3695', 'masipenkoiu', 'NqJRNMyGD', 'vFFpfi', 502, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (680, 'Cull', 'Edgcumbe', 'https://robohash.org/asperioresodioesse.png?size=50x50&set=set1', 'cedgcumbeiv@berkeley.edu', '191-789-4083', 'cedgcumbeiv', 'G7UKhqY5GW5', 'M28Bmfty', 505, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (681, 'Anet', 'Margaret', 'https://robohash.org/etconsequaturest.bmp?size=50x50&set=set1', 'amargaretiw@yahoo.co.jp', '186-183-9031', 'amargaretiw', 'BLGghz3R', 'Yj1lCcz1', 505, 1009);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (682, 'Devlen', 'Duffell', 'https://robohash.org/blanditiisdeseruntrerum.png?size=50x50&set=set1', 'dduffellix@wsj.com', '943-540-1261', 'dduffellix', 'Gv5ZY81ZfapG', 'E0jCKZMhW', 506, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (683, 'Garnet', 'Hayles', 'https://robohash.org/blanditiisvoluptatemet.jpg?size=50x50&set=set1', 'ghaylesiy@ehow.com', '518-924-6333', 'ghaylesiy', 'DKdwPFH', 'rIkVPRvmg', 503, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (684, 'Percy', 'Lancaster', 'https://robohash.org/iustopariaturipsum.jpg?size=50x50&set=set1', 'plancasteriz@ted.com', '944-972-3881', 'plancasteriz', 'wpebLlqHVyA', 'wkQrY8Y4m5zk', 501, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (685, 'Luise', 'Trigwell', 'https://robohash.org/suscipitipsamrerum.jpg?size=50x50&set=set1', 'ltrigwellj0@ox.ac.uk', '194-916-4755', 'ltrigwellj0', 'QVJq5pJNXUZ', '4L02PG', 505, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (686, 'Babette', 'Ifill', 'https://robohash.org/quiafaceresaepe.bmp?size=50x50&set=set1', 'bifillj1@kickstarter.com', '459-576-7365', 'bifillj1', '2lRaJeybex', 'CgKsMuH9z', 501, 1001);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (687, 'Carmelia', 'Hillitt', 'https://robohash.org/ipsaautvoluptatem.png?size=50x50&set=set1', 'chillittj2@istockphoto.com', '521-739-2181', 'chillittj2', 'dqzoxPWjn', 'Sv1KDC', 501, 1004);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (688, 'Sutherland', 'Mate', 'https://robohash.org/quiaiuresimilique.jpg?size=50x50&set=set1', 'smatej3@paginegialle.it', '526-676-9459', 'smatej3', 'k3MV6BwoyV', 'ucysaszrE', 506, 1005);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (689, 'Jodie', 'Blance', 'https://robohash.org/suntporroquisquam.jpg?size=50x50&set=set1', 'jblancej4@angelfire.com', '489-745-7460', 'jblancej4', '9f9pJbo', 'EsQmCVFsRFb', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (690, 'Ruprecht', 'Pearse', 'https://robohash.org/sunttemporibusab.png?size=50x50&set=set1', 'rpearsej5@ucsd.edu', '298-266-9916', 'rpearsej5', '1Lb7gw', 'EVef47PhEk', 501, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (691, 'Brigham', 'Labbett', 'https://robohash.org/nemoquamnulla.bmp?size=50x50&set=set1', 'blabbettj6@hc360.com', '744-625-2679', 'blabbettj6', 'oIn0FUs2h', 'Rzx0uB6vmT', 506, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (692, 'Saloma', 'Bilt', 'https://robohash.org/providentautaut.jpg?size=50x50&set=set1', 'sbiltj7@sogou.com', '158-980-9977', 'sbiltj7', 'G1eYMZAAE', 'HRENxUl', 505, 1000);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (693, 'Ivett', 'Wanjek', 'https://robohash.org/dolorharumodit.png?size=50x50&set=set1', 'iwanjekj8@friendfeed.com', '829-817-3536', 'iwanjekj8', 'FtCw4Inq3P', 'wzLyWotVmxQu', 505, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (694, 'Sadella', 'Gwillyam', 'https://robohash.org/dolorsitoccaecati.jpg?size=50x50&set=set1', 'sgwillyamj9@moonfruit.com', '704-545-4103', 'sgwillyamj9', 'PkzQPTtvT', 'Vsze0GwyWv', 503, 1002);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (695, 'Kippar', 'Accum', 'https://robohash.org/veniamdolorumtotam.png?size=50x50&set=set1', 'kaccumja@marriott.com', '393-155-0130', 'kaccumja', '8v5dkef4qHm', 'WrXrDfh', 504, 1008);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (696, 'Mata', 'Millichip', 'https://robohash.org/autemrationeconsequatur.jpg?size=50x50&set=set1', 'mmillichipjb@npr.org', '322-487-5164', 'mmillichipjb', '1EynUoPUX', 'bmlFrJFj', 504, 1007);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (697, 'Raye', 'Perago', 'https://robohash.org/asperioressintaperiam.jpg?size=50x50&set=set1', 'rperagojc@jiathis.com', '109-635-4082', 'rperagojc', 'EOnUW3in', 'f094d9z', 505, 1003);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (698, 'Alexandr', 'Lapree', 'https://robohash.org/facilisaspernaturrecusandae.bmp?size=50x50&set=set1', 'alapreejd@spiegel.de', '859-663-8464', 'alapreejd', 'o4KJiQsG5kID', 'EadYM8LZqhV', 505, 1006);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (699, 'Redford', 'Fitter', 'https://robohash.org/doloreminautem.png?size=50x50&set=set1', 'rfitterje@sfgate.com', '222-669-5538', 'rfitterje', '4dtTKX', 'pFCiNQ', 501, 1010);
insert into CLIENTES (ID, NOMBRES, APELLIDOS, FOTO, CORREO, CELULAR, USUARIO, CONTRASENA, CODIGO_INVITADO, IDIOMA_ID, CIUDAD_ID) values (700, 'Jennine', 'Barlthrop', 'https://robohash.org/debitisreiciendisautem.png?size=50x50&set=set1', 'jbarlthropjf@springer.com', '568-420-2644', 'jbarlthropjf', 'Z9XdXi', 'YHeCIbiwT', 501, 1005);


--MEDIOS PAGO

insert into MEDIOS_PAGO (ID, DESCRIPCION) values (1, 'EFECTIVO');
insert into MEDIOS_PAGO (ID, DESCRIPCION) values (2, 'CREDITO');
insert into MEDIOS_PAGO (ID, DESCRIPCION) values (3, 'DEBITO');
insert into MEDIOS_PAGO (ID, DESCRIPCION) values (4, 'PAYPAL');


--IDIOMAS

insert into IDIOMAS (ID, DESCRIPCION, ABREVIATURA) values (501, 'INGLES', 'ING');
insert into IDIOMAS (ID, DESCRIPCION, ABREVIATURA) values (502, 'ESPAÑOL', 'ESP');
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

insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (1, 0.1, 0.34, null, null, null, null, 33698.6, 92376, 2522);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (2, 0.14, 0.34, 3262.41, 279.24, 15120.33, 14194, 37499.52, 116720, 2515);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (3, 0.17, 0.34, 3946.99, 348.42, 24032.73, 10700, 23544.94, 66119, 2502);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (4, 0.11, 0.34, 3408.56, 3549.55, 21540.7, 13096, 40921.28, 117136, 2544);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (5, 0.1, 0.34, 4219.32, 4268.83, 33001.83, 7143, 31295.89, 117692, 2533);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (6, 0.13, 0.34, null, null, null, null, 8564.86, 107818, 2543);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (7, 0.14, 0.34, 2380.65, 600.31, 19008.6, 6974, 56722.52, 63304, 2526);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (8, 0.19, 0.34, 2181.57, 2234.28, 29144.31, 19948, 21239.4, 83130, 2521);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (9, 0.09, 0.34, 3823.49, 4974.57, 28577.64, 17798, 35648.93, 80383, 2522);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (10, 0.09, 0.34, 100.29, 1416.93, 18701.03, 12886, 21481.7, 89315, 2538);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (11, 0.18, 0.34, 4476.5, 4280.16, 30607.53, 19965, 33739.87, 86546, 2544);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (12, 0.14, 0.34, 3477.22, 4375.49, 23913.06, 9606, 43690.42, 80078, 2531);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (13, 0.14, 0.34, 2002.05, 1020.79, 33818.47, 14177, 16993.08, 96626, 2525);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (14, 0.17, 0.34, 1196.65, 4199.3, 16802.57, 13544, 14532.69, 65353, 2534);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (15, 0.13, 0.34, 2344.65, 1048.64, 32620.94, 19035, 56776.77, 71289, 2513);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (16, 0.11, 0.34, 4913.83, 4650.34, 28480.38, 14280, 35334.31, 61130, 2540);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (17, 0.12, 0.34, 2030.68, 1638.4, 22236.86, 16025, 33904.73, 76480, 2516);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (18, 0.16, 0.34, 2816.66, 1082.06, 20922.43, 9929, 19668.72, 84182, 2542);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (19, 0.11, 0.34, 4771.84, 4818.31, 28058.83, 20630, 38961.05, 74883, 2530);
insert into DETALLES_FACTURAS (ID , IVA , COMISION_UBER , PROPINAS , HONORARIOS , REGARGOS , PEAJES, SUB_TOTAL , TOTAL , FACTURA_ID ) values (20, 0.18, 0.34, 4664.42, 2157.44, 16164.28, 12551, 26378.38, 60777, 2512);



---DROPS

drop table DETALLES_FACTURAS cascade constraints;
drop table DETALLES_MEDIOS_PAGO cascade constraints;
drop table EMPRESAS_MEDIOS_PAGO cascade constraints;
drop table EMPRESAS cascade constraints;
drop table CONDUCTORES cascade constraints;
drop table CODIGOS_PROMOCIONALES cascade constraints;
drop table CLIENTES_MEDIOS_PAGO cascade constraints;
drop table CIUDADES cascade constraints;
drop table PAISES cascade constraints;
drop table IDIOMAS cascade constraints;
drop table FACTURAS cascade constraints;
drop table CLIENTES_EMPRESAS cascade constraints;
drop table DETALLES_UBICACION_SERVICIOS cascade constraints;
drop table CONDUCTORES_VEHICULOS cascade constraints;
drop table VEHICULOS cascade constraints;
drop table SERVICIOS cascade constraints;
drop table MEDIOS_PAGO cascade constraints;
drop table CLIENTES cascade constraints;



--SELECTS--

SELECT * FROM CLIENTES ORDER BY ID;
SELECT * FROM MEDIOS_PAGO ORDER BY ID;
SELECT * FROM SERVICIOS ORDER BY ID;
SELECT * FROM VEHICULOS ORDER BY ID;
SELECT * FROM CONDUCTORES_VEHICULOS ORDER BY ID;
SELECT * FROM DETALLES_UBICACION_SERVICIOS ORDER BY ID;
SELECT * FROM CLIENTES_EMPRESAS ORDER BY ID;
SELECT * FROM FACTURAS  ORDER BY ID ;
SELECT * FROM IDIOMAS ORDER BY ID;
SELECT * FROM PAISES ORDER BY ID;
SELECT * FROM CIUDADES ORDER BY ID;
SELECT * FROM CLIENTES_MEDIOS_PAGO ORDER BY ID;
SELECT * FROM CODIGOS_PROMOCIONALES ORDER BY ID;
SELECT * FROM CONDUCTORES ORDER BY ID;
SELECT * FROM EMPRESAS ORDER BY ID;
SELECT * FROM EMPRESAS_MEDIOS_PAGO ORDER BY ID;
SELECT * FROM DETALLES_FACTURAS ORDER BY ID;
SELECT * FROM DETALLES_MEDIOS_PAGO ORDER BY ID;
