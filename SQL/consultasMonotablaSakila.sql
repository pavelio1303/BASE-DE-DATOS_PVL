USE SAKILA;

SELECT * FROM FILM;

SELECT * FROM ACTOR;

SELECT * FROM FILM_ACTOR;

# EJ.1- MUESTRA LA PELICULA MAS LARGA
SELECT TITLE,LENGTH FROM FILM WHERE LENGTH = (SELECT MAX(LENGTH) FROM FILM);

# EJ.2- MUESTRA LA PELICULA CON MENOR DURACION
SELECT TITLE,LENGTH FROM FILM WHERE LENGTH = (SELECT MIN(LENGTH) FROM FILM);

# EJ.3- MUESTRA LOS DISTINTOS RATING DE EDAD USADOS
SELECT DISTINCT RATING FROM FILM;

# EJ.4- CUANTAS PELICULAS DURAN MAS DE 2 HORAS
SELECT COUNT(*) AS PELICULAS_DURACION_MAS_2_HORAS FROM FILM WHERE LENGTH > 120;

# EJ.5- MUESTRA EL NOMBRE DE LA PELICULAS Y SU DURACION EN HORAS
SELECT TITLE,LENGTH/60 AS DURACION_HORAS FROM FILM;

# EJ.6- CUANTAS PELICULAS CONTIENEN ESCENAS ELIMINADAS?
SELECT COUNT(*) FROM FILM WHERE SPECIAL_FEATURES LIKE "%DELETED SCENES%";

# EJ.7- QUE PELICULAS TIENEN "ALIEN" EN SU NOMBRE?
SELECT TITLE FROM FILM WHERE TITLE LIKE "%ALIEN%" ORDER BY TITLE;

# EJ.8- CUAL ES LA PELICULA MÁS LARGA QUE PODEMOS VER POR MENOS DE 1$ (RENTAL_RATE)
SELECT * FROM FILM WHERE RENTAL_RATE < 1 AND LENGTH = (SELECT MAX(LENGTH) FROM FILM WHERE RENTAL_RATE < 1);

# ***EJ.9- CUANTAS PELICULAS SON DOCUMENTALES? (COLUMNA DESCRIPTION)
SELECT COUNT(*) FROM FILM WHERE DESCRIPTION LIKE "%DOCUMENTARY%";

# EJ.10- CUAL ES EL PRECIO DE REEMPLAZO MEDIO DE LAS PELICULAS CON RATING "R"
SELECT AVG(REPLACEMENT_COST) FROM FILM WHERE RATING = "R";

# EJ.11- CUANTOS DIAS TARDARÍAMOS EN VER TODAS LAS PELICULAS? Y AÑOS?
SELECT SUM(LENGTH)/60/24 FROM FILM;

SELECT SUM(LENGTH)/60/24/365 FROM FILM;

# EJ.12 MUESTRA LOS PRECIOS DE ALQUILER (RENTAL_RATE) Y CUANTAS PELICULAS SE ALQUILAN DE CADA PRECIO
SELECT RENTAL_RATE, COUNT(*) FROM FILM GROUP BY RENTAL_RATE;

# EJ.13 MUESTRA LA DURACION MEDIA DE LAS PELICULAS AGRUPADAS POR RATING
SELECT ROUND(AVG(LENGTH)) AS DURACION_MEDIA, RATING FROM FILM GROUP BY RATING;

# EJ.14 MUESTRA LA DURACION MEDIA DE LAS PELICULAS SIN ESCENAS ELIMINADAS AGRUPADAS POR RATING
SELECT ROUND(AVG(LENGTH)) AS DURACION_MEDIA, RATING FROM FILM WHERE SPECIAL_FEATURES NOT LIKE "%DELETED SCENES%" GROUP BY RATING;

# EJ.15 ¿CUANTO COSTARÍA REEMPLAZAR (REPLACEMENT_COST) LAS PELICULAS DE JENNIFER DAVIS (TABLA ACTOR Y FILM_ACTOR) SI VAMOS AL VIDEOCLUB Y LAS DESTRUIMOS?
SELECT SUM(REPLACEMENT_COST) AS COSTE_REEMPLAZO_JD FROM FILM WHERE FILM_ID IN (SELECT FILM_ID FROM FILM_ACTOR WHERE ACTOR_ID = (SELECT ACTOR_ID FROM ACTOR WHERE FIRST_NAME = "JENNIFER" AND LAST_NAME = "DAVIS"));

# EJ.16 MUESTRA EL NOMBRE DE LAS PELÍCULAS EN MINÚSCULAS
SELECT LOWER(TITLE) AS NOMBRE_MINÚSCULA FROM FILM;

# EJ.17 CREA UN CODIGO CONCATENADO LAS 4 PRIMERAS LETRAS DE CADA PELICULA Y LOS ULTIMOS 2 DIGITOS DE LA FECHA DE LANZAMIENTO
SELECT 
	TITLE,
	RELEASE_YEAR,
	CONCAT(LEFT(TITLE, 4), "-", RIGHT(RELEASE_YEAR, 2)) AS CODIGO 
FROM FILM;

# EJ.18 IGUAL QUE EJ.17 PERO EN MINÚSCULA
SELECT 
	TITLE,
    RELEASE_YEAR,
    LOWER(CONCAT(LEFT(TITLE, 4), "-", RIGHT(RELEASE_YEAR, 2))) AS CODIGO
FROM FILM;

# EJ.19 CREA UN CODIGO DE ACTOR CONCATENANDO LAS 3 PRIMERAS LETRAS DEL NOMBRE Y LAS 3 PRIMERAS LETRAS DE LOS APELLIDOS DE CADA ACTOR Y DANDOLE LA VUELTA A LA CADENA. EN MINUSCULA.
SELECT 
	FIRST_NAME AS NOMBRE,
    LAST_NAME AS PRIMER_APELLIDO,
	REVERSE(LOWER(CONCAT(LEFT(FIRST_NAME, 3), "-", LEFT(LAST_NAME, 3)))) AS CODIGO_ACTOR 
FROM ACTOR;

# EJ.20 MUESTRA LA DURACION MEDIA DE LAS PELICULAS AGRUPADAS POR RATING (REDONDEA 2 DECIMALES)
SELECT 
	RATING, 
    ROUND(AVG(LENGTH), 2) AS DURACION_MEDIA 
FROM FILM GROUP BY RATING;

# EJ.21 SUPONIENDO QUE RENTAL_DURATION ES LA DURACION EN DIAS DEL ALQUILER, Y QUE RENTAL_RATE ES EL PRECIO DIARIO DE CADA PELICULA, MUESTRA:
#	- EL NOMBRE DE LA PELICULA
#	- LOS DIAS DE ALQUILER
#	- EL PRECIO DIARIO
#	- EL PRECIO TOTAL
#	- UNA COLUMNA QUE ME DIGA CUANTOS BILLETES DE 10 DOLARES NECESITARIA PARA ALQUILAR LA PELICULA
SELECT 
	TITLE AS TITULO, 
    RENTAL_DURATION AS DIAS_EN_ALQUILER, 
    RENTAL_RATE AS PRECIO_DIARIO, 
    RENTAL_DURATION*RENTAL_RATE AS PRECIO_TOTAL, 
    CEIL((RENTAL_DURATION*RENTAL_RATE)/10) AS BILLETES_10_NECESARIOS	# 'CEIL' REDONDEA HACIA ARRIBA
FROM FILM;

# EJ22 SELECCIONA EL TÍTULO DE LAS PELÍCULAS, UNA COLUMNA QUE MUESTRE SI DURA MÁS O MENOS DE 2H, OTRA COLUMNA QUE MUESTRE SI TIENE O NO ESCENAS ELIMINADAS Y OTRA QUE MUESTRE SI TIENE O NO TRAILERS (COLUMNAS BOOLEANAS).

# EJ23 SELECCIONA EL TÍTULO DE LAS PELÍCULAS Y UNA QUE MUESTRE SI LA PELÍCULA ES APTA PARA TODOS LOS PÚBLICOS (G, PG O PG-13)
SELECT
	TITLE AS TITULO,
    RATING IN ("G","PG","PG-13") AS PARA_TODOS_PUBLICOS
FROM FILM;

# EJ24 SELECCIONA LA DURACIÓN MÁXIMA DE LAS PELÍCULAS AGRUPADAS POR RENTAL_DURATION

# EJ25 SELECCIONA EL COSTE DE REEMPLAZO MEDIO DE LAS PELÍCULAS AGRUPADAS POR DURACIÓN>120

# EJ26 ¿CUÁL ES EL ACTOR QUE MÁS PELÍCULAS HA HECHO? TABLAS ACTOR Y ACTOR_FILM (USA LIMIT 1). MUESTRA EL NOMBRE DEL ACTOR Y SU APELLIDO CONCATENADO.
SELECT
	CONCAT(FIRST_NAME, " ", LAST_NAME) AS ACTOR
FROM ACTOR
WHERE ACTOR_ID =
	(SELECT
		ACTOR_ID
	FROM FILM_ACTOR
	GROUP BY ACTOR_ID
	ORDER BY COUNT(FILM_ID) DESC
	LIMIT 1);
# EJ27 MUESTRA LAS CATEGORÍAS DE PELÍCULA (CÓDIGO DE CATEGORÍA) QUE HAY Y CUÁNTAS PELÍCULAS HAY DE CADA CATEGORÍA. TABLA FILM_CATEGORY.

# EJ28 MUESTRA LOS DISTINTOS AÑOS DE LANZAMIENTO PARA LOS QUE TENEMOS PELÍCULAS.
SELECT DISTINCT RELEASE_YEAR FROM FILM;

# EJ.29 MUESTRA (EN MINUSCULA) EL NOMBRE Y LOS APELLIDOS DE LOS ACTORES QUE HAN HECHO MAS DE 15 PELICULAS (CUENTA SOLO PELICULAS DE MAS DE 100 MINUTOS)
SELECT 
	LOWER(FIRST_NAME), 
	LOWER(LAST_NAME)
FROM ACTOR 
WHERE ACTOR_ID IN
	(SELECT 
		ACTOR_ID
	FROM FILM_ACTOR 
	WHERE FILM_ID IN (SELECT FILM_ID FROM FILM WHERE LENGTH > 100) 
	GROUP BY ACTOR_ID 
	HAVING COUNT(FILM_ID) > 15);

# EJ30 MUESTRA (EN MINÚSUCLA) EL NOMBRE Y LOS APELLIDOS DE LOS ACTORES QUE HAN HECHO MÁS DE 3 PELÍCULAS (CUENTA SOLO PELÍCULAS DE MÁS DE 100 MINUTOS)

# EJ31 ¿CUÁL ES EL RENTAL_RATE MEDIO DE LAS PELÍCULAS EN LAS QUE APARECE UN FRESBEE?

# EJ32 ¿QUÉ ACTOR A PARTICIPADO EN MÁS PELÍCULAS CON FRESBEE? (USA LIMIT 1)

#===========================================================

# EJ33 ¿CUAL ES LA PELICULA DE LA QUE TENEMOS MAS COPIAS?
SELECT
	FILM.TITLE AS TITULO,
	COUNT(INVENTORY.FILM_ID) AS COPIAS
FROM FILM
JOIN INVENTORY ON INVENTORY.FILM_ID = FILM.FILM_ID
GROUP BY TITULO 
ORDER BY COPIAS DESC
LIMIT 1;
 
# EJ34 MUESTRA LA DIRECCION DE LAS TIENDAS Y CUANTO EN TOTAL HA FACTURADO CADA UNA.
SELECT
	ADDRESS AS DIRECCION_TIENDA,
    SUM(AMOUNT) AS FACTURACION_TOTAL
FROM STORE
JOIN ADDRESS ON ADDRESS.ADDRESS_ID = STORE.ADDRESS_ID
JOIN PAYMENT ON PAYMENT.STAFF_ID = STORE.MANAGER_STAFF_ID
GROUP BY ADDRESS;

# EJ35 MUESTRA UNA LISTA DE LAS PELICULAS Y CUANTO HAN PAGADO DE MEDIA POR ALQUILARLAS.
SELECT
	FILM.TITLE,
    ROUND(AVG(PAYMENT.AMOUNT), 2) AS MEDIA_ALQUILER
FROM PAYMENT 
JOIN RENTAL ON PAYMENT.RENTAL_ID = RENTAL.RENTAL_ID
JOIN INVENTORY ON RENTAL.INVENTORY_ID = INVENTORY.INVENTORY_ID
JOIN FILM ON FILM.FILM_ID = INVENTORY.FILM_ID
GROUP BY FILM.FILM_ID;

# EJ36 ¿CUAL HA SIDO LA PELICULA MAS RENTABLE?
SELECT
	FILM.TITLE,
    SUM(PAYMENT.AMOUNT) AS INGRESOS_GENERADOS
FROM PAYMENT 
JOIN RENTAL ON PAYMENT.RENTAL_ID = RENTAL.RENTAL_ID
JOIN INVENTORY ON RENTAL.INVENTORY_ID = INVENTORY.INVENTORY_ID
JOIN FILM ON FILM.FILM_ID = INVENTORY.FILM_ID
GROUP BY FILM.FILM_ID
ORDER BY INGRESOS_GENERADOS DESC
LIMIT 1;

# EJ37 MUESTRA UNA LISTA DE LOS CLIENTES Y CUANTO DINERO HA GASTADO CADA UNO.
SELECT
	CONCAT(CUSTOMER.FIRST_NAME,"  ",CUSTOMER.LAST_NAME) AS CLIENTE,
	SUM(PAYMENT.AMOUNT) AS TOTAL_GASTADO
FROM CUSTOMER
JOIN PAYMENT ON CUSTOMER.CUSTOMER_ID = PAYMENT.CUSTOMER_ID
GROUP BY CUSTOMER.CUSTOMER_ID;

# EJ38 ¿QUIEN HA SIDO EL CLIENTE MAS RENTABLE?
SELECT
	CONCAT(CUSTOMER.FIRST_NAME,"  ",CUSTOMER.LAST_NAME) AS CLIENTE,
	SUM(PAYMENT.AMOUNT) AS TOTAL_GASTADO
FROM CUSTOMER
JOIN PAYMENT ON CUSTOMER.CUSTOMER_ID = PAYMENT.CUSTOMER_ID
GROUP BY CUSTOMER.CUSTOMER_ID
ORDER BY TOTAL_GASTADO DESC
LIMIT 1;


