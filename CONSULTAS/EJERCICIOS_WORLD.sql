USE WORLD;

# SELECCIONAR TODAS LAS COLUMNAS Y TODAS LAS FILAS

SELECT * FROM CITY;
SELECT * FROM COUNTRY;
SELECT * FROM COUNTRYLANGUAGE;

# SELECCIONAR COLUMNAS CONCRETAS PERO TODAS LAS FILAS

SELECT NAME, CONTINENT FROM COUNTRY;

# SELECCIONAR COLUMNAS CON ALIAS;

SELECT 
	NAME AS NOMBRE, 
    CONTINENT AS CONTINENTE
FROM COUNTRY;

SELECT 
	NAME AS PAIS,
    SURFACEAREA
FROM COUNTRY;

# CLÁUSULA WHERE

SELECT * FROM COUNTRY WHERE NAME = "SPAIN";

# CÁUSULA DISTINCT

SELECT DISTINCT CONTINENT FROM COUNTRY;

# EJ1 - MUESTRA LOS PAÍSES DE EUROPA CON MÁS DE 5M DE HABITANTES.

SELECT * FROM COUNTRY 
WHERE 
	POPULATION > 5000000 AND
	CONTINENT = "EUROPE";

# EJ2 - MUESTRA EL NOMBRE DE LOS PAÍSES CON MÁS DE 80M DE HABITANTES.

SELECT NAME FROM COUNTRY WHERE POPULATION > 80000000;

# EJ3 - MUESTRA LOS PAÍSES CUYA JEFA DE ESTADO ERA ISABEL II.

SELECT * FROM COUNTRY WHERE HEADOFSTATE = "ELISABETH II";

# EJ4 - SELECCIONA LAS DISTINTAS REGIONES DE EUROPA;

SELECT DISTINCT REGION FROM COUNTRY WHERE CONTINENT = "EUROPE";

# EJ5 - SELECCIONA LOS DISTRITOS EN QUE SE DIVIDE ESPAÑA (TABLA CITY)

SELECT DISTINCT DISTRICT FROM CITY WHERE COUNTRYCODE = "ESP";

# FUNCIÓN COUNT

SELECT COUNT(*) FROM COUNTRY WHERE CONTINENT = "EUROPE";

# EJ6 - ¿CUÁNTOS PAÍSES DE EUROPA ESTÁN EN EL SUR?

SELECT COUNT(*) FROM COUNTRY WHERE REGION = "SOUTHERN EUROPE";

# EJ7 - ¿CUÁNTOS PAÍSES AFRICANOS TIENEN MÁS DE 50M HABITANTES?

SELECT COUNT(*) FROM COUNTRY 
WHERE CONTINENT = "AFRICA" AND POPULATION > 50000000;

# EJ8 - ¿CUÁNTAS CIUDADES DE ALEMANIA HAY EN LA BBDD?

SELECT COUNT(*) FROM CITY WHERE COUNTRYCODE = "DEU";

# EJ9 - ¿QUÉ IDIOMAS SE HABLAN EN ESPAÑA DE FORMA OFICIAL?

SELECT LANGUAGE FROM COUNTRYLANGUAGE WHERE COUNTRYCODE = "ESP" AND ISOFFICIAL="T";

# EJ10 - ¿EN QUÉ PAISES EL ESPAÑOL ES LENGUA OFICIAL?

SELECT * FROM COUNTRYLANGUAGE WHERE LANGUAGE = "SPANISH" AND ISOFFICIAL="T";

# EJ11 - ¿CUÁNTAS CIUDADES DE ESPAÑA TIENEN MÁS DE 1M DE HABITANTES?

SELECT COUNT(*) FROM CITY WHERE COUNTRYCODE="ESP" AND POPULATION > 1000000;


# ORDENAR UN RESULTADO

# ORDER BY {COLUMNA A ORDENAR}
# DESC -> DESCENDENTE
# ASC -> ASCENDENTE

SELECT * FROM COUNTRY ORDER BY SURFACEAREA DESC; -- ASC

# EJ12 - ¿CUÁL ES EL PAÍS MÁS POBLADO DEL MUNDO?

SELECT NAME FROM COUNTRY ORDER BY POPULATION DESC; -- ASC

# EJ13 - ¿CUÁL ES EL PAÍS MÁS POBLADO DE EUROPA?

SELECT NAME FROM COUNTRY WHERE CONTINENT = "EUROPE" ORDER BY POPULATION DESC; -- ASC

# EJ14 - MUESTRA LAS REGIONES DE NORTEAMÉRICA ORDENADAS ALFABÉTICAMENTE

SELECT DISTINCT REGION FROM COUNTRY WHERE CONTINENT = "NORTH AMERICA" ORDER BY REGION;

# EJ15 - MUESTRA LAS 5 CIUDADES MÁS POBLADAS DE ESPAÑA.

SELECT NAME FROM CITY WHERE COUNTRYCODE="ESP" ORDER BY POPULATION DESC LIMIT 5;

# EJ16 - ¿CUÁLES SON LOS PAÍSES DEL MUNDO CON NÚMERO DE HABITANTES ENTRE 1M Y 5M?

SELECT NAME FROM COUNTRY WHERE POPULATION BETWEEN 1000000 AND 5000000;

# EJ17 - ¿CUÁL ES EL PAÍS DEL CARIBE CON MAYOR ESPERANZA DE VIDA?

SELECT NAME FROM COUNTRY WHERE REGION = "CARIBBEAN" ORDER BY LIFEEXPECTANCY DESC LIMIT 1;

# EJ18 - ¿QUÉ PAÍSES TIENEN MENOS DE 60 AÑOS DE ESPERANZA DE VIDA?

SELECT NAME FROM COUNTRY WHERE LIFEEXPECTANCY < 60;

# EJ19 - MUESTRA UNA LISTA DE LAS FORMAS DE GOBIERNO ORDENADA DE FORMA ALFABÉTICA

SELECT DISTINCT GovernmentForm FROM COUNTRY ORDER BY GovernmentForm;

# EJ20 - ¿CUÁL ES EL PAÍS DE AMÉRICA CON MAYOR SUPERFICIE?

SELECT NAME FROM COUNTRY WHERE CONTINENT="NORTH AMERICA" OR CONTINENT="SOUTH AMERICA" ORDER BY SURFACEAREA DESC LIMIT 1;

SELECT NAME FROM COUNTRY WHERE CONTINENT IN ("NORTH AMERICA", "SOUTH AMERICA") ORDER BY SURFACEAREA DESC LIMIT 1;

SELECT NAME FROM COUNTRY WHERE CONTINENT LIKE "%AMERICA%" ORDER BY SURFACEAREA DESC LIMIT 1;

# EJ21 - MUESTRA LOS PAÍSES QUE SON ALGÚN TIPO DE MONARQUÍA

SELECT NAME FROM COUNTRY WHERE GovernmentForm LIKE "%MONARCHY%";

# EJ22 - CUÁNTOS PAÍSES COMIENZAN POR LA LETRA 'A'

SELECT COUNT(*) FROM COUNTRY WHERE NAME LIKE "A%";

# EJ23 - MUESTRA UNA LISTA DE LOS TIPOS DE REPÚBLICAS QUE HAY, ORDENADA DE FORMA ALFABÉTICA

SELECT DISTINCT GovernmentForm 
FROM COUNTRY 
WHERE GovernmentForm LIKE "%REPUBLIC%" 
ORDER BY GovernmentForm;

# EJ24 MUESTRA LOS 5 PAÍSES CON MENOR ESPERANZA DE VIDA

SELECT NAME FROM COUNTRY 
WHERE LIFEEXPECTANCY IS NOT NULL 
ORDER BY LIFEEXPECTANCY
LIMIT 5;

# EJ25 ¿CUÁNTOS PAÍSES TIENEN FECHA DE INDEPENDENCIA?

SELECT COUNT(*) FROM COUNTRY WHERE INDEPYEAR IS NOT NULL;
SELECT COUNT(INDEPYEAR) FROM COUNTRY;

# EJ26 ¿PARA CUÁNTOS PAÍSES NO DISPONEMOS DEL DATO DE ESPERANZA DE VIDA?

SELECT COUNT(*) FROM COUNTRY WHERE LIFEEXPECTANCY IS NULL;

# EJ27 ¿CUÁNTAS REGIONES HAY?

SELECT COUNT(DISTINCT REGION) AS REGIONES FROM COUNTRY;

# OPERACIONES

SELECT "DATO" AS COLUMNA;

SELECT 2*2 AS PRODUCTO;

SELECT 2/2 AS DIVISIÓN;

SELECT 2%2 AS "MÓDULO O RESTO";

SELECT NAME, POPULATION*POPULATION AS POPULATION_2 FROM COUNTRY;

# EJ28 MUESTRA UNA LISTA DE PAÍSES Y SU DENSIDAD DE POBLACIÓN

SELECT NAME, POPULATION/SURFACEAREA AS "DENSIDAD DE POBLACIÓN" FROM COUNTRY;

# EJ29 MUESTRA EL PRODUCTO NACIONAL BRUTO (GNP) PER CÁPITA DE ARGENTINA

SELECT GNP*1000000/POPULATION AS GNP_PER_CAPITA FROM COUNTRY WHERE NAME = "ARGENTINA";

# EJ30 MUESTRA EL PAÍS MÁS DENSAMENTE POBLADO DEL MUNDO

SELECT 
	NAME, 
    POPULATION/SURFACEAREA AS DENSIDAD
FROM COUNTRY
ORDER BY DENSIDAD DESC
LIMIT 1;

# EJ31 MUESTRA LOS 5 PAÍSES MÁS GRANDES (POR SUPERFICIE) DE EUROPA

SELECT NAME FROM COUNTRY WHERE CONTINENT = "EUROPE" ORDER BY SURFACEAREA DESC LIMIT 5;

# EJ32 MUESTRA LOS 5 PAÍSES MÁS DENSAMENTE POBLADOS DE EUROPA

SELECT
	NAME, 
    POPULATION/SURFACEAREA AS DENSIDAD 
FROM COUNTRY
WHERE CONTINENT = "EUROPE"
ORDER BY DENSIDAD DESC 
LIMIT 5;

# EJ33 MUESTRA LOS 5 PAÍSES MENOS DENSAMENTE POBLADOS DE EUROPA

SELECT
	NAME, 
    POPULATION/SURFACEAREA AS DENSIDAD 
FROM COUNTRY
WHERE CONTINENT = "EUROPE"
ORDER BY DENSIDAD ASC 
LIMIT 5;

# OPERACIONES DE AGREGACIÓN
# - COUNT -> CUENTA FILAS NO NULAS
# - SUM -> SUMA EL VALOR DE LOS DATOS DE LA COLUMNA INDICADA
# - AVG -> CALCULA EL VALOR MEDIO DE LOS DATOS DE LA COLUMNA INDICADA
# - MIN -> MUESTRA EL VALOR MÍNIMO DE LA COLUMNA INDICADA
# - MAX -> MUESTRA EL VALOR MÁXIMO DE LA COLUMNA INDICADA

# EJ34 ¿CUÁL ES LA POBLACIÓN MUNDIAL?

SELECT SUM(POPULATION) FROM COUNTRY;

# EJ35 ¿CUÁL ES LA ESPERANZA DE VIDA MEDIA DE ÁFRICA?

SELECT AVG(LIFEEXPECTANCY) FROM COUNTRY WHERE CONTINENT="AFRICA";

# EJ36 ¿CUÁL ES LA SUPERFICIE TOTAL DEL MUNDO?

SELECT SUM(SURFACEAREA) FROM COUNTRY;

# EJ37 ¿CUÁNTAS CIUDADES DE ANDALUCÍA HAY EN LA BBDD?

SELECT COUNT(*) FROM CITY WHERE DISTRICT = "ANDALUSIA";

# EJ38 ¿CUÁL ES EL VALOR MÁXIMO DEL GNP? ¿A QUÉ PAÍS CORRESPONDE?

SELECT NAME, GNP FROM COUNTRY WHERE GNP = (SELECT MAX(GNP) FROM COUNTRY);

# EJ39 ¿CUÁL ES EL VALOR MÍNIMO DEL GNP? ¿A QUÉ PAÍS CORRESPONDE?

SELECT NAME, GNP FROM COUNTRY WHERE GNP = (SELECT MIN(GNP) FROM COUNTRY);

# EJ40 ¿EN QUÉ AÑO, DE MEDIA, SE INDEPENDIZARON LOS PAÍSES DE SUDAMÉRICA?

SELECT AVG(INDEPYEAR) FROM COUNTRY WHERE CONTINENT="SOUTH AMERICA";

# EJ41 ¿CUÁL ES EL PAÍS CON FECHA DE INDEPENDENCIA MÁS CERCANA A HOY?

SELECT 
	NAME, 
    INDEPYEAR 
FROM COUNTRY 
WHERE INDEPYEAR = (SELECT MAX(INDEPYEAR) FROM COUNTRY);

# EJ42 ¿QUÉ PAÍSES AMERICANOS TIENEN MÁS POBLACIÓN QUE ESPAÑA?

SELECT 
	NAME
FROM COUNTRY
WHERE CONTINENT LIKE "%AMERICA%"
AND POPULATION > (SELECT POPULATION FROM COUNTRY WHERE NAME = "SPAIN");

# EJ43 ¿CUÁL ES LA CIUDAD CON MAYOR POBLACIÓN?

SELECT 
	NAME, 
    POPULATION 
FROM CITY 
WHERE POPULATION = (SELECT MAX(POPULATION) FROM CITY);

# EJ44 ¿QUÉ PAÍSES TIENEN MENOS POBLACIÓN QUE MADRID?

SELECT 
	NAME, 
    POPULATION 
FROM COUNTRY 
WHERE POPULATION < (SELECT POPULATION FROM CITY WHERE NAME = "MADRID");

# EJ45 ¿QUÉ CIUDADES SE LLAMAN IGUAL QUE ALGÚN PAÍS?

SELECT 
	NAME
FROM CITY 
WHERE NAME IN (SELECT NAME FROM COUNTRY);

# EJ46 ¿QUÉ PAÍSES DE EUROPA Y ASIA TIENEN UNA POBLACIÓN POR ENCIMA 
#       DE LA MEDIA DE ESOS CONTINENTES?

SELECT
	NAME
FROM COUNTRY 
WHERE 
	CONTINENT IN ("EUROPE", "ASIA")
	AND POPULATION >
		(SELECT 
			AVG(POPULATION) 
		FROM COUNTRY 
		WHERE CONTINENT IN ("EUROPE", "ASIA"));

# EJ47 ¿HAY ALGÚN PAÍS SIN CIUDADES EN LA BBDD?

SELECT NAME FROM COUNTRY 
WHERE CODE NOT IN (SELECT COUNTRYCODE FROM CITY);

# EJ48 ¿CUÁNTAS CIUDADES NO SON CAPITALES?

SELECT COUNT(NAME) FROM CITY 
WHERE ID NOT IN (SELECT CAPITAL FROM COUNTRY WHERE CAPITAL IS NOT NULL);

# EJ49 ¿CUÁL ES LA POBLACIÓN MEDIA DE LAS CIUDADES EUROPEAS?

SELECT AVG(POPULATION) AS POBLACION_MEDIA FROM CITY
WHERE COUNTRYCODE IN (SELECT CODE FROM COUNTRY WHERE CONTINENT = "EUROPE");

# EJ50 ¿CUÁL ES LA POBLACIÓN MEDIA DE LAS CAPITALES AMERICANAS?

SELECT AVG(POPULATION) AS POBLACION_MEDIA FROM CITY 
WHERE ID IN (SELECT CAPITAL FROM COUNTRY WHERE CONTINENT LIKE "%AMERICA%");

# EJ51 MUESTRA EL NOMBRE, LA SUPERFICIE, LA POBLACIÓN 
# Y LA DENSIDAD DE POBLACIÓN DE JAPÓN Y ESPAÑA

SELECT 
	NAME, 
    SURFACEAREA, 
    POPULATION,
    POPULATION/SURFACEAREA AS DENSIDAD_POBLACION
FROM COUNTRY WHERE NAME = "SPAIN" OR NAME = "JAPAN";
# FROM COUNTRY WHERE NAME IN ("SPAIN", "JAPAN");

# EJ52 MUESTRA EL NOMBRE DE LOS PAÍSES QUE HABLAN FRANCÉS DE FROMA OFICIAL

SELECT 
	NAME 
FROM COUNTRY
WHERE CODE IN 
	(SELECT COUNTRYCODE FROM COUNTRYLANGUAGE 
     WHERE LANGUAGE = "FRENCH" AND ISOFFICIAL="T");

# EJ53 MUESTRA LA POBLACIÓN TOTAL DE LOS PAÍSES QUE HABLAN ESPAÑOL DE FORMA OFICIAL

SELECT 
	SUM(POPULATION) AS POBLACION_HISPANOS 
FROM COUNTRY
WHERE CODE IN 
	(SELECT COUNTRYCODE FROM COUNTRYLANGUAGE 
     WHERE LANGUAGE = "SPANISH" AND ISOFFICIAL="T");

# EJ54 ¿EN QUÉ REGIONES SE HABLA ESPAÑOL (OFICIAL Y NO OFICIAL)?

SELECT 
	DISTINCT REGION 
FROM COUNTRY
WHERE CODE IN 
	(SELECT COUNTRYCODE FROM COUNTRYLANGUAGE 
     WHERE LANGUAGE = "SPANISH");

# GROUP BY	

SELECT 
	CONTINENT, 
    SUM(POPULATION) 
FROM COUNTRY
GROUP BY CONTINENT;

# EJ55 MUESTRA LA ESPERANZA DE VIDA MEDIA POR CONTINENTE

SELECT 
	CONTINENT, 
    AVG(LIFEEXPECTANCY) 
FROM COUNTRY
GROUP BY CONTINENT;

# EJ56 MUESTRA LAS REGIONES Y LA SUPERFICIE TOTAL DE CADA REGIÓN

SELECT 
	REGION, 
    SUM(SURFACEAREA) 
FROM COUNTRY
GROUP BY REGION;

# EJ57 MUESTRA EL AÑO DE INDEPENDENCIA PROMEDIO DE CADA CONTINENTE (SIN TENER EN CUENTA NULOS)

SELECT 
	CONTINENT, 
    AVG(INDEPYEAR) 
FROM COUNTRY
WHERE INDEPYEAR IS NOT NULL
GROUP BY CONTINENT;

# EJ58 MUESTRA LOS DISTRITOS DE ESPAÑA (TABLA CITY) Y LA POBLACIÓN TOTAL DE CADA UNO.

SELECT 
	DISTRICT, 
    SUM(POPULATION) 
FROM CITY
WHERE COUNTRYCODE="ESP"
GROUP BY DISTRICT;

# EJ59 SUMA EL PORCENTAJE TOTAL DE TODOS LOS IDIOMAS AGRUPANDO POR PAÍS.

SELECT 
	COUNTRYCODE, 
    SUM(PERCENTAGE) 
FROM COUNTRYLANGUAGE
GROUP BY COUNTRYCODE;

# EJ60 MUESTRA EL NOMBRE DE LAS REGIONES CON MÁS DE 10M DE HABITANTES.

SELECT 
	REGION
FROM COUNTRY
GROUP BY REGION
HAVING SUM(POPULATION)>10000000;

# EJ61 MUESTRA EL NOMBRE DE LAS REGIONES DE ASIA Y AMÉRICA CON MÁS DE 100M DE HABITANTES.

SELECT 
	REGION,
    SUM(POPULATION)
FROM COUNTRY
WHERE CONTINENT LIKE "%ASIA%" OR CONTINENT LIKE "%AMERICA%"
GROUP BY REGION
HAVING SUM(POPULATION)>100000000;

# EJ62 MUESTRA LOS DISTRITOS DE EUROPA CON MÁS DE 3M DE HABITANTES (CITY)

SELECT 
	DISTRICT,
    SUM(POPULATION) AS POBLACION_DISTRITO
FROM CITY
WHERE COUNTRYCODE IN (SELECT CODE FROM COUNTRY WHERE CONTINENT = "EUROPE")
GROUP BY DISTRICT
HAVING POBLACION_DISTRITO>3000000;

# EJ63 MUESTRA UNA LISTA DE LOS CONTINENTES Y CUÁNTOS PAÍSES HAY EN CADA CONTINENTE

SELECT
	CONTINENT,
    COUNT(*) AS PAISES
FROM COUNTRY
GROUP BY CONTINENT;

# EJ64 MUESTRA UNA LISTA DE LAS REGIONES Y CUÁNTOS PAÍSES HAY EN CADA REGIÓN

SELECT
	REGION,
    COUNT(*) AS PAISES
FROM COUNTRY
GROUP BY REGION;

# EJ65 MUESTRA EL NOMBRE DE LOS PAÍSES CON MÁS DE 1 IDIOMA OFICIAL.

SELECT 
	NAME 
FROM COUNTRY 
WHERE CODE IN
	(SELECT 
		COUNTRYCODE
		#COUNT(*) AS IDIOMAS_OFICIALES
	FROM COUNTRYLANGUAGE 
	WHERE ISOFFICIAL="T"
	GROUP BY COUNTRYCODE
	HAVING COUNT(*)>1);

# EJ66 MUESTRA EL NOMBRE DE LOS PAÍSES EUROPEOS CON MÁS DE 1 IDIOMA OFICIAL.

SELECT 
	NAME 
FROM COUNTRY 
WHERE 
	CONTINENT = "EUROPE" 
	AND CODE IN
		(SELECT 
			COUNTRYCODE
			#COUNT(*) AS IDIOMAS_OFICIALES
		FROM COUNTRYLANGUAGE 
		WHERE ISOFFICIAL="T"
		GROUP BY COUNTRYCODE
		HAVING COUNT(*)>1);


# ========================== FUNCIONES ========================== #

# CONCAT() -> CONCATENA CADENAS DE CARACTERES

SELECT 
	NAME,
    CONCAT(CONTINENT, "-", REGION) AS CONTREGION
FROM COUNTRY;

# LOWER() -> PONE EN MINÚSCULA
# UPPER() -> PONE EN MAYÚSCUA

SELECT UPPER(NAME) FROM COUNTRY;

# LEFT(cadena, n) -> n PRIMEROS CARÁCTERES
# RIGHT(cadena, n) -> n ÚLTIMOS CARÁCTERES
# MID(cadena, p, n) O SUBSTR() -> n CARÁCTERES DESDE LA POSICIÓN p

SELECT LEFT("CADENA DE TEXTO", 5);
SELECT RIGHT("CADENA DE TEXTO", 5);
SELECT MID("CADENA DE TEXTO", 8, 2);

SELECT 
	UPPER(LEFT(NAME, 3)) FROM COUNTRY;
    
# EJ67 SELECCIONA EL CÓDIGO DE LOS PAÍSES, LAS 3 PRIMERAS LETRAS DE SU NOMBRE EN MAYÚSCULA Y UNA COLUMNA QUE INDIQUE SI LAS DOS ANTERIORES COINCIDEN

SELECT 
	CODE,
	UPPER(LEFT(NAME, 3)) AS TRES_PRIMERAS,
    CODE=LEFT(NAME, 3) AS IGUALES
FROM COUNTRY;

# EJ68 ¿PARA CUÁNTOS PAÍSES COINCIDE EL CÓDIGO CON LAS 3 PRIMERAS LETRAS DE SU NOMBRE?

SELECT 
	COUNT(*)
FROM COUNTRY
WHERE
	CODE=LEFT(NAME, 3);

SELECT "ABC"="abc";

# REPEAT(cadena, n) -> REPITE UNA cadena n VECES

SELECT REPEAT("*", 8);

SELECT REPEAT(NAME, 80) FROM COUNTRY;

# REPLACE(cadena, subcadena_anterior, subcadena_nueva)
# REEMPLAZA LA SUBCADENA BUSCADA POR UNA NUEVA

SELECT REPLACE("ESTO ES UNA CADENA DE TEXTO CADENA", "CADENA", "OTRA COSA");

SELECT REPLACE(HEADOFSTATE, "Elisabeth", "Isabel") FROM COUNTRY;

# REVERSE() -> INVIERTE UNA CADENA DE TEXTO

SELECT REVERSE(GovernmentForm) FROM COUNTRY;

SELECT * FROM COUNTRY;

# ================= FUNCIONES NUMÉRICAS ================= #

# SQRT() -> RAÍZ CUADRADA

SELECT SQRT(9);

# EJ69 ¿SI ESPAÑA FUESE UN CUADRADO, CUÁNTOS KILÓMETROS DE LADO TENDRÍA?

SELECT 
	SQRT(SURFACEAREA) AS LADO_ESPAÑITA
FROM COUNTRY
WHERE NAME = "SPAIN";

# POW() -> ELEVAR

SELECT POW(2,10); # ELEVAR -> 2^10

# RAND() -> NÚMERO ALEATORIO ENTRE 0 Y 1

SELECT RAND();

# EJ70 GENERA UN NÚMERO ALEATORIO ENTRE 1 Y 10

SELECT TRUNCATE(RAND()*10+1, 0);
SELECT CEIL(RAND()*10);

# ROUND(numero, decimales) -> REDONDEAR
# TRUNCATE(numero, decimales) -> TRUNCA
# FLOOR(numero) -> ENTERO INFERIOR
# CEIL(numero) -> ENTERO SUPERIOR

SELECT ROUND(7.896599568, 3);
SELECT TRUNCATE(7.896599568, 3);
SELECT FLOOR(7.896599568);
SELECT CEIL(7.1);

# PT8.1 - MUESTRA EL NOMBRE DE LOS PAÍSES Y CREA UN CÓDIGO DE PAÍS CONCATENANDO LAS DOS (2) PRIMERAS LETRAS DEL CONTINENTE, EL CODE2 REPETIDO TRES (3) VECES Y LAS TRES (3) PRIMERAS LETRAS DEL PAÍS (TODO EN MAYÚSCULA).

SELECT 
	NAME,
    UPPER(CONCAT(LEFT(CONTINENT, 2), REPEAT(CODE2,3), LEFT(NAME, 3))) AS CODIGO
FROM COUNTRY;

# PT8.2 - MUESTRA UNA LISTA DE LAS REGIONES EN MAYÚSUCLA, Y LA SUPERFICIE TOTAL DE CADA REGIÓN SIN DECIMALES (REDONDEA HACIA ARRIBA).

SELECT
	UPPER(REGION) AS REGION,
    CEIL(SUM(SURFACEAREA)) AS SUPERFICIE_TOTAL
FROM COUNTRY
GROUP BY REGION;

# PT8.3 - MUESTRA EL CÓDIGO DE LOS PAÍESES DE EUROPA O ASIA CON MÁS DE 10M DE HABITANTES Y EL NOMBRE DEL PAÍS CONCATENADO CON SU NOMBRE LOCAL (LocalName).

SELECT
	CODE,
    CONCAT(NAME, "-", LOCALNAME)
FROM COUNTRY
WHERE
	POPULATION > 10000000
    AND CONTINENT IN ("EUROPE", "ASIA");

# PT8.4 - MUESTRA UNA LISTA DE LOS NOMBRES DE LOS PAISES, SU NOMBRE LOCAL Y UNA COLUMNA BOOLEANA QUE INDICA SI COINCIDEN LOS NOMBRES ANTERIORES.

SELECT
	NAME,
    LOCALNAME,
    NAME=LOCALNAME AS COINCIDEN
FROM COUNTRY;

# PT8.5 - MUESTRA UNA LISTA DE LOS PAÍSES QUE HABLAN MÁS DE DOS (2) IDIOMAS DE FORMA OFICIAL Y SU ESPERANZA DE VIDA REDONDEADA HACIA ABAJO.

SELECT 
	NAME, 
    FLOOR (LIFEEXPECTANCY)
FROM COUNTRY 
WHERE CODE IN
	(SELECT 
		COUNTRYCODE
	FROM COUNTRYLANGUAGE
	WHERE ISOFFICIAL="T"
	GROUP BY COUNTRYCODE
	HAVING COUNT(*)>2);

# ================= JOIN ===================== #

SELECT * FROM CITY
JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE;

# EJ71 - MUESTRA UNA LISTA DE LAS CIUDADES DE ESPAÑA, SU POBLACIÓN, LA POBLACIÓN DEL PAÍS Y EL PORCENTAJE DE POBLACIÓN DEL PAÍS QUE VIVE EN ESA CIUDAD (2 DECIMALES)

SELECT 
	CITY.NAME, 
    CITY.POPULATION, 
    COUNTRY.POPULATION,
    ROUND(CITY.POPULATION/COUNTRY.POPULATION*100, 2) AS POBLACIÓN_EN_CIUDAD
FROM CITY
JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE COUNTRY.NAME="SPAIN";

# EJ72 - MUESTRA UNA LISTA DE LOS DISTRITOS DE ESPAÑA, SU POBLACIÓN, LA POBLACIÓN DEL PAÍS Y EL PORCENTAJE DE POBLACIÓN DEL PAÍS QUE VIVE EN ESE DISTRITO (2 DECIMALES).

SELECT 
	CITY.DISTRICT,
    SUM(CITY.POPULATION) AS POBLACION_DISTRITO,
    MAX(COUNTRY.POPULATION),
    ROUND(SUM(CITY.POPULATION)/MAX(COUNTRY.POPULATION)*100, 2) AS PORCENTAJE_DISTRITO
FROM CITY
JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE COUNTRY.NAME="SPAIN"
GROUP BY DISTRICT;

SELECT 
	CITY.DISTRICT,
    SUM(CITY.POPULATION) AS POBLACION_DISTRITO,
    COUNTRY.POPULATION,
    ROUND(SUM(CITY.POPULATION)/COUNTRY.POPULATION*100, 2) AS PORCENTAJE_DISTRITO
FROM CITY
JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE CODE="ESP"
GROUP BY DISTRICT;

# EJ73 - MUESTRA UNA LISTA DE LOS NOMBRES DE LAS CAPITALES EUROPEAS.

SELECT 
	CITY.NAME
FROM COUNTRY
JOIN CITY ON COUNTRY.CAPITAL = CITY.ID
WHERE COUNTRY.CONTINENT = "EUROPE";

# EJ74 - ¿CUÁL ES LA CAPITAL DEL MUNDO MÁS POBLADA?

SELECT 
	CITY.NAME
FROM COUNTRY
JOIN CITY ON COUNTRY.CAPITAL = CITY.ID
ORDER BY CITY.POPULATION DESC
LIMIT 1;

# EJ75 - MUESTRA UNA LISTA CON EL NOMBRE DE LOS PAÍSES Y LA CANTIDAD DE IDIOMAS QUE SE HABLAN EN DICHO PAÍS.

SELECT 
	CO.NAME,
    COUNT(CL.LANGUAGE) AS IDIOMAS
FROM COUNTRY AS CO
JOIN COUNTRYLANGUAGE AS CL ON CO.CODE=CL.COUNTRYCODE
GROUP BY CO.NAME;

# EJ76 - MUESTRA UNA LISTA CON EL NOMBRE DE LOS PAÍSES Y LA CANTIDAD DE IDIOMAS OFICIALES QUE SE HABLAN EN DICHO PAÍS.

SELECT 
	CO.NAME,
    COUNT(CL.LANGUAGE) AS IDIOMAS
FROM COUNTRY AS CO
JOIN COUNTRYLANGUAGE AS CL ON CO.CODE=CL.COUNTRYCODE
WHERE CL.ISOFFICIAL = "T"
GROUP BY CO.NAME;

# EJ77 - MUESTRA UNA LISTA CON EL NOMBRE DE TODOS LOS PAÍSES Y LA CANTIDAD DE CIUDADES DE CADA PAÍS DISPONIBLES EN LA BASE DE DATOS.

SELECT
	CO.NAME,
    COUNT(*) AS CIUDADES
FROM CITY AS CI
JOIN COUNTRY AS CO ON CI.COUNTRYCODE=CO.CODE
GROUP BY CO.NAME;

# EJ78 - MUESTRA EL NOMBRE DE LOS PAÍSES SIN CIUDADES REGISTRADAS.

SELECT NAME FROM COUNTRY
WHERE CODE NOT IN (SELECT COUNTRYCODE FROM CITY);

SELECT
	CO.NAME
FROM COUNTRY AS CO
LEFT JOIN CITY AS CI ON CI.COUNTRYCODE=CO.CODE
WHERE CI.NAME IS NULL;

# EJ79 - MUESTRA UNA LISTA CON EL NOMBRE DE LOS PAÍSES, LOS IDIOMAS HABLADOS Y LA CANTIDAD DE PERSONAS QUE HABLAN CADA IDIOMA EN CADA PAÍS.

SELECT 
	CO.NAME,
    CL.LANGUAGE,
    CO.POPULATION*CL.PERCENTAGE/100 AS HABLANTES
FROM COUNTRY AS CO
JOIN COUNTRYLANGUAGE AS CL ON CO.CODE=CL.COUNTRYCODE;

# EJ80 - MUESTRA UNA LISTA CON EL NOMBRE DE LA CAPITAL DE LOS PAÍSES CON ESPAÑOL COMO IDIOMA OFICIAL.

SELECT 
	CI.NAME
FROM COUNTRY AS CO
JOIN COUNTRYLANGUAGE AS CL ON CO.CODE=CL.COUNTRYCODE
JOIN CITY CI ON CO.CAPITAL=CI.ID
WHERE CL.LANGUAGE="SPANISH" AND CL.ISOFFICIAL="T";

# EJ81 - MUESTRA EL PORCENTAJE DE LA POBLACIÓN MUNDIAL QUE HABLA ESPAÑOL.

SELECT 
    CL.LANGUAGE,
    SUM(CO.POPULATION*CL.PERCENTAGE/100)
    /
    (SELECT SUM(POPULATION) FROM COUNTRY)*100 AS HISPANOHABLANTES
FROM COUNTRY AS CO
JOIN COUNTRYLANGUAGE AS CL ON CO.CODE=CL.COUNTRYCODE
WHERE CL.LANGUAGE="SPANISH";

# EJ82 - MUESTRA UNA LISTA CON LOS IDIOMAS Y EL PORCENTAJE DE LA POBLACIÓN MUNDIAL QUE HABLA CADA IDIOMA (ORDENA DE MAYOR A MENOR).

SELECT 
    CL.LANGUAGE,
    SUM(CO.POPULATION*CL.PERCENTAGE/100)
    /
    (SELECT SUM(POPULATION) FROM COUNTRY)*100 AS HABLANTES
FROM COUNTRY AS CO
JOIN COUNTRYLANGUAGE AS CL ON CO.CODE=CL.COUNTRYCODE
GROUP BY CL.LANGUAGE
ORDER BY HABLANTES DESC;

# EJ83 - MUESTRA TODAS LAS CIUDADES QUE NO SON CAPITALES.

SELECT 
	CITY.NAME
FROM CITY
LEFT JOIN COUNTRY ON COUNTRY.CAPITAL = CITY.ID
WHERE COUNTRY.CODE IS NULL;
