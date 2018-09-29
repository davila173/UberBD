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


GRANT CREATE SESSION, DBA TO usrUber;

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
  