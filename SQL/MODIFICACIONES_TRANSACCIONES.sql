# ===================   BORRADO DE DATOS   =================== #
USE WORLD;
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
SELECT * FROM COUNTRY;
SELECT * FROM CITY;

DELETE FROM COUNTRYLANGUAGE WHERE COUNTRYCODE="FRA";
DELETE FROM CITY WHERE COUNTRYCODE="FRA";
DELETE FROM COUNTRY WHERE CODE="FRA";

# EJ2 - AUMENTA UN 10% LA POBLACIÓN DE LOS PAÍSES AFRICANOS.

# EJ3 - FUSIONA ESPAÑA CON PORTUGAL Y LOS PAÍSES AMERICANOS. 
#       FUSIONA LA SUPERFICIE, POBLACIÓN, GNP Y ESPERANZA DE VIDA MEDIA
#       EL NUEVO PAÍS DEBE SER LLAMADO "IMPERIO ESPAÑOL".

# EJ4 - CAMBIA LA CIUDAD DE GIBRALTAR PARA QUE PASE A SER ESPAÑOLA.

# EJ5 - TODAS LAS CIUDADES DE MURCIA SON INCORPORADAS POR LA COMUNIDAD VALENCIANA.





