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
    FECHA DATE NOT NULL,
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
    FECHA DATE,
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

------ INSERCION DE INFORMACION ------