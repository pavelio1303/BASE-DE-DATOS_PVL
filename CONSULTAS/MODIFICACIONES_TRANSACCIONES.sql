# ===================   BORRADO DE DATOS   =================== #

# BORRA TODO EL CONTENIDO DE LA TABLA
TRUNCATE TABLE CITY; # BORRADO PERMANENETE EN DISCO
DELETE FROM CITY; # NO ES PERMANENTE HASTA REALIZAR COMMIT

# BORRA LA ESTRUCTURA DE LA TABLA (INCLUIDO EL CONTENIDO)
DROP TABLE COUNTRYLANGUAGE;
DROP TABLE IF EXISTS COUNTRYLANGUAGE;

# BORRAR FILAS DETERMINADAS
DELETE FROM COUNTRYLANGUAGE WHERE COUNTRYCODE="ESP";

# ================   ACTUALIZACIÓN DE DATOS   ================ #

SELECT * FROM COUNTRY WHERE CODE="ESP";

UPDATE COUNTRY SET POPULATION=POPULATION*1.1 WHERE CODE="ESP";

# ===================   TRANSACCIONES   ====================== #

SET SQL_SAFE_UPDATES=FALSE; # DESACTIVAR MODO SEGURO (SOLO PUEDO MODIFICAR USANDO PKs EN EL WHERE)
DELETE FROM CITY;
DELETE FROM COUNTRYLANGUAGE WHERE COUNTRYCODE="ESP";

ROLLBACK; # DESHACE LA TRANSACCIÓN COMPLETA (VUELVO AL ÚLIMO ESTADO)

COMMIT; # LOS CAMBIOS SON PERMANENTES

# ====================   EJERCICIOS   ======================= #

# EJ1 - ELIMINA FRANCIA DEL PLANETA.

DELETE FROM COUNTRYLANGUAGE WHERE COUNTRYCODE="FRA";
DELETE FROM CITY WHERE COUNTRYCODE="FRA";
DELETE FROM COUNTRY WHERE CODE="FRA";

# EJ2 - AUMENTA UN 10% LA POBLACIÓN DE LOS PAÍSES AFRICANOS.

UPDATE COUNTRY SET POPULATION=POPULATION*1.1 WHERE CONTINENT="AFRICA";

# EJ3 - FUSIONA ESPAÑA CON PORTUGAL Y LOS PAÍSES AMERICANOS. 
#       FUSIONA LA SUPERFICIE, POBLACIÓN, GNP Y ESPERANZA DE VIDA MEDIA
#       EL NUEVO PAÍS DEBE SER LLAMADO "IMPERIO ESPAÑOL".

SET @SUPERFICIE_IMPERIO=(SELECT SUM(SURFACEAREA) FROM COUNTRY WHERE NAME="PORTUGAL" OR NAME="SPAIN" OR CONTINENT LIKE "%AMERICA%");
SET @POBLACION_IMPERIO=(SELECT SUM(POPULATION) FROM COUNTRY WHERE NAME="PORTUGAL" OR NAME="SPAIN" OR CONTINENT LIKE "%AMERICA%");
SET @GNP_IMPERIO=(SELECT SUM(GNP) FROM COUNTRY WHERE NAME="PORTUGAL" OR NAME="SPAIN" OR CONTINENT LIKE "%AMERICA%");
SET @ESPERANZA_VIDA_IMPERIO=(SELECT AVG(LIFEEXPECTANCY) FROM COUNTRY WHERE NAME="PORTUGAL" OR NAME="SPAIN" OR CONTINENT LIKE "%AMERICA%");

UPDATE COUNTRY SET
	NAME="IMPERIO ESPAÑOL",
	SURFACEAREA=@SUPERFICIE_IMPERIO,
	POPULATION=@POBLACION_IMPERIO,
	GNP=@GNP_IMPERIO,
	LIFEEXPECTANCY=@ESPERANZA_VIDA_IMPERIO
WHERE CODE="ESP";

SELECT * FROM COUNTRY WHERE CODE="ESP";

DELETE FROM COUNTRY WHERE NAME="PORTUGAL" OR CONTINENT LIKE "%AMERICA%";

# EJ4 - CAMBIA LA CIUDAD DE GIBRALTAR PARA QUE PASE A SER ESPAÑOLA.

UPDATE CITY SET COUNTRYCODE="ESP" WHERE NAME="GIBRALTAR";
SELECT * FROM CITY WHERE NAME="GIBRALTAR";

# EJ5 - TODAS LAS CIUDADES DE MURCIA SON INCORPORADAS POR LA COMUNIDAD VALENCIANA.

SET SQL_SAFE_UPDATES=FALSE; # DESACTIVAR MODO SEGURO (SOLO PUEDO MODIFICAR USANDO PKs EN EL WHERE)
UPDATE CITY SET DISTRICT="VALENCIA" WHERE DISTRICT="MURCIA";

# EJ6 - CREA UNA COLUMNA NUEVA EN LA TABLA FILM QUE MUESTRE LA DURACIÓN DE LAS PELÍCULAS EN FORMATO "TIME"

USE SAKILA;

ALTER TABLE FILM ADD COLUMN (DURACION TIME);
UPDATE FILM SET DURACION=SEC_TO_TIME(LENGTH*60);

SELECT * FROM FILM;

# EJ7 - CREA UNA COLUMNA EDAD_MÍNIMA EN FILM QUE MUESTRE LA FECHA DE NACIMIENTO MÍNIMA PARA ALQUILAR LA PELÍCULA:
# G -> TODOS LOS PÚBLICOS
# PG -> MAYORES DE 7 AÑOS
# PG-13 -> MÁS DE 13 AÑOS
# R Y NC-17 -> MÁS DE 17 AÑOS

ALTER TABLE FILM ADD COLUMN (EDAD_MINIMA DATE);

UPDATE FILM SET EDAD_MINIMA=DATE_ADD(NOW(), INTERVAL -7 YEAR) WHERE RATING="PG";
UPDATE FILM SET EDAD_MINIMA=DATE_ADD(NOW(), INTERVAL -13 YEAR) WHERE RATING="PG-13";
UPDATE FILM SET EDAD_MINIMA=DATE_ADD(NOW(), INTERVAL -17 YEAR) WHERE RATING IN ("R", "NC-17");

SELECT * FROM FILM;

# EJ8 - BORRA LAS PELÍCULAS QUE DUREN MENOS DE DOS HORAS.

DELETE FROM FILM WHERE LENGTH<120; 
# NO PUEDO EJECUTARLO PORQUE HAY OTRAS TABLAS CON FILAS QUE "APUNTAN" (FOREIGN KEY) A ESTAS PELÍCULAS

# EJ9 - BORRA LAS PELÍCULAS QUE NO DISPONGAN DE NINGUNA COPIA EN EL INVENTARIO.
SET SQL_SAFE_UPDATES=FALSE;

DELETE FROM FILM WHERE FILM_ID IN
(SELECT * FROM 
	(SELECT F.FILM_ID
	FROM FILM F
	LEFT JOIN INVENTORY INV ON F.FILM_ID=INV.FILM_ID
	WHERE INV.INVENTORY_ID IS NULL) A 
); 
# NO PUEDO EJECUTARLO PORQUE ESAS PELÍCULAS APARECEN EN OTRAS TABLAS 
# (AUNQUE NO ESTÉN EN EL INVENTARIO)

# EJ10 - BORRA LOS PAÍSES QUE NO TENGAN NINGUNA CIUDAD

# EJ11 - BORRA LOS PAÍSES CON MÁS DE 10 CIUDADES

# EJ12 - CREA UNA FUNCIÓN QUE RECIBA EL CÓDIGO DE UN PAÍS Y DEVUELVA 
#        LA CANTIDAD DE IDIOMAS OFICIALES QUE SE HABLAN EN DICHO PAÍS.
#        AÑADE UNA COLUMNA NUEVA A LA TABLA COUNTRY QUE INDIQUE LA CANTIDAD
#        DE IDIOMAS OFICIALES DE DICHO PAÍS

# EJ13 - CREA UNA NUEVA COLUMNA EN COUNTRYLANGUAGE QUE MUESTRE LA CANTIDAD 
#        PERSONAS QUE HABLAN CADA IDIOMA EN CADA PAÍS




# =============================   ON DELETE CASCADE   ============================= #

# CUANDO SE ESPECIFICA ON DELETE CASCADE EN UNA CLAVE EXTERNA EN MYSQL, INDICA QUE SI SE ELIMINA UNA FILA DE LA TABLA PRINCIPAL (REFERENCIADA POR LA CLAVE EXTERNA), TODAS LAS FILAS RELACIONADAS EN LA TABLA SECUNDARIA (QUE CONTIENE LA CLAVE EXTERNA) TAMBIÉN SE ELIMINARÁN AUTOMÁTICAMENTE.

# EJEMPLO:
# SUPONGAMOS QUE TENEMOS LAS TABLAS COUNTRY Y CITY, DONDE COUNTRY ES LA TABLA PRINCIPAL Y CITY ES LA SECUNDARIA, Y LA RELACIÓN ENTRE ELLAS ESTÁ DEFINIDA POR LA COLUMNA COUNTRYCODE EN LA TABLA CITY.

CREATE TABLE COUNTRY (
    CODE CHAR(3) PRIMARY KEY,
    NAME CHAR(52),
    POPULATION INT
);

CREATE TABLE CITY (
    ID INT PRIMARY KEY,
    NAME CHAR(35),
    COUNTRYCODE CHAR(3),
    POPULATION INT,
    FOREIGN KEY (COUNTRYCODE) REFERENCES COUNTRY(CODE) ON DELETE CASCADE
);

# EN ESTE EJEMPLO, SI ELIMINAMOS UNA FILA DE LA TABLA COUNTRY, TODAS LAS FILAS CORRESPONDIENTES EN LA TABLA CITY QUE TENGAN EL MISMO COUNTRYCODE SE ELIMINARÁN AUTOMÁTICAMENTE.


# =============================   ON UPDATE CASCADE   ============================= #

# CUANDO SE ESPECIFICA ON UPDATE CASCADE EN UNA CLAVE EXTERNA EN MYSQL, INDICA QUE SI SE
# ACTUALIZA EL VALOR DE LA COLUMNA REFERENCIADA EN LA TABLA PRINCIPAL, TODOS LOS VALORES
# CORRESPONDIENTES EN LA TABLA SECUNDARIA (QUE CONTIENE LA CLAVE EXTERNA) SE ACTUALIZARÁN
# AUTOMÁTICAMENTE PARA QUE COINCIDAN CON EL NUEVO VALOR.

# EJEMPLO:
# SUPONGAMOS QUE TENEMOS LAS TABLAS COUNTRY Y CITY, DONDE COUNTRY ES LA TABLA PRINCIPAL Y 
# CITY ES LA SECUNDARIA, Y LA RELACIÓN ENTRE ELLAS ESTÁ DEFINIDA POR LA COLUMNA COUNTRYCODE 
# EN LA TABLA CITY.

CREATE TABLE COUNTRY (
    CODE CHAR(3) PRIMARY KEY,
    NAME CHAR(52),
    POPULATION INT
);

CREATE TABLE CITY (
    ID INT PRIMARY KEY,
    NAME CHAR(35),
    COUNTRYCODE CHAR(3),
    POPULATION INT,
    FOREIGN KEY (COUNTRYCODE) REFERENCES COUNTRY(CODE) ON UPDATE CASCADE
);

# EN ESTE EJEMPLO, SI ACTUALIZAMOS EL VALOR DE LA COLUMNA CODE EN LA TABLA COUNTRY, 
# TODOS LOS VALORES CORRESPONDIENTES EN LA COLUMNA COUNTRYCODE DE LA TABLA CITY SE 
# ACTUALIZARÁN AUTOMÁTICAMENTE PARA REFLEJAR EL NUEVO VALOR.


# =============================   ON UPDATE SET NULL   ============================= #

# POR OTRO LADO, CUANDO SE ESPECIFICA ON UPDATE SET NULL, SIGNIFICA QUE SI SE ACTUALIZA 
# EL VALOR DE LA COLUMNA REFERENCIADA EN LA TABLA PRINCIPAL, EL VALOR DE LA COLUMNA FORÁNEA 
# EN LA TABLA SECUNDARIA SE ESTABLECERÁ EN NULL.

# EJEMPLO:
# SUPONGAMOS QUE TENEMOS LAS TABLAS COUNTRY Y COUNTRYLANGUAGE, DONDE COUNTRY ES LA TABLA
# PRINCIPAL Y COUNTRYLANGUAGE ES LA SECUNDARIA, Y LA RELACIÓN ENTRE ELLAS ESTÁ DEFINIDA 
# POR LA COLUMNA COUNTRYCODE EN LA TABLA COUNTRYLANGUAGE.

CREATE TABLE COUNTRY (
    CODE CHAR(3) PRIMARY KEY,
    NAME CHAR(52),
    POPULATION INT
);

CREATE TABLE COUNTRYLANGUAGE (
    COUNTRYCODE CHAR(3),
    LANGUAGE CHAR(30),
    ISOFFICIAL BOOLEAN,
    PERCENTAGE FLOAT,
    PRIMARY KEY (COUNTRYCODE, LANGUAGE),
    FOREIGN KEY (COUNTRYCODE) REFERENCES COUNTRY(CODE) ON UPDATE SET NULL
);

# EN ESTE EJEMPLO, SI ACTUALIZAMOS EL VALOR DE LA COLUMNA CODE EN LA TABLA 
# COUNTRY, EL COUNTRYCODE CORRESPONDIENTE EN LA TABLA COUNTRYLANGUAGE SE ESTABLECERÁ 
# EN NULL




