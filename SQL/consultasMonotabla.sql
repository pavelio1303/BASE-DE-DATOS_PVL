USE WORLD;

SELECT * FROM CITY;

SELECT * FROM COUNTRY;

SELECT * FROM COUNTRYLANGUAGE;

# SELECIONAR COLUMNAS CONCRETAS PERO TODAS LAS FILAS:
SELECT NAME, CONTINENT FROM COUNTRY;

# SELECCIONAR COLUMNAS CON ALIAS:
SELECT NAME AS NOMBRE, CONTINENT AS CONTINENTE FROM COUNTRY;

SELECT NAME AS PAIS, SURFACEAREA FROM COUNTRY;

# CLÁUSULA WHERE, poner condiciones que queremos que se cumplan detrás del where.
SELECT * FROM COUNTRY WHERE NAME = "SPAIN";

# EJ.1 - MUESTRA LOS PAÍSES DE EUROPA CON MÁS DE 5 M DE HABITANTES.
SELECT * FROM COUNTRY WHERE CONTINENT = "EUROPE" AND POPULATION > 5000000 ;

# EJ.2 - MUESTRA EL NOMBRE DE LOS PAÍSES CON MÁS DE 80 M DE HABITANTES.
SELECT NAME FROM COUNTRY WHERE POPULATION > 80000000 ;

# EJ.3 - MUESTRA LOS PAÍSES CUYA JEFA DE ESTADO SEA ISABEL II.
SELECT * FROM COUNTRY WHERE HEADOFSTATE = "ELISABETH II" ;

# CLÁSULUA DISTINCT, muestra solo los valores sin repetir de dicha columna, en lugar de todos aun estando repetidos.
SELECT DISTINCT CONTINENT FROM COUNTRY;

# EJ.4 - SELECCIONA LAS DISTINTAS REGIONES DE EUROPA
SELECT DISTINCT REGION FROM COUNTRY WHERE CONTINENT = "EUROPE";

# EJ.5 - SELECCIONA LOS DISTRITOS EN LOS QUE SE DIVIDE ESPAÑA (TABLA CITY)
SELECT DISTINCT DISTRICT FROM CITY WHERE COUNTRYCODE = "ESP";

# FUNCIÓN COUNT, contar cuantos elementos hay en las tablas.
SELECT COUNT(*) FROM COUNTRY WHERE CONTINENT = "EUROPE";

# EJ.6 - CUANTOS PAISES DE EUROPA ESTÁN EN EL SUR.
SELECT COUNT(*) FROM COUNTRY WHERE REGION = "SOUTHERN EUROPE";

# EJ.7 - CUANTOS PAISES AFRICANOS TIENEN MÁS DE 50 M DE HABITANTES.
SELECT COUNT(*) FROM COUNTRY WHERE CONTINENT = "AFRICA" AND POPULATION > 50000000;

# EJ.8 - CUANTAS CIUDADES DE ALEMANIA QUE HAY EN LA BBDD.
SELECT COUNT(*) FROM CITY WHERE COUNTRYCODE = "DEU";

# EJ.9 - IDIOMAS QUE SE HABLEN EN ESPAÑA DE FORMA OFICIAL.
SELECT * FROM COUNTRYLANGUAGE WHERE COUNTRYCODE = "ESP" AND ISOFFICIAL = "T";

# EJ.10 - EN QUE PAISES EL ESPAÑOL ES LENGUA OFICIAL.
SELECT * FROM COUNTRYLANGUAGE WHERE LANGUAGE = "SPANISH" AND ISOFFICIAL = "T";

# EJ.11 - CUANTAS CIUDADES DE ESPAÑA TIENEN MÁS DE 1M DE HABITANTES.
SELECT COUNT(*) FROM CITY WHERE COUNTRYCODE = "ESP" AND POPULATION > 1000000;

# ORDENAR UN RESULTADO

SELECT * FROM COUNTRY ORDER BY SURFACEAREA DESC;	# 'DESC' ES DESCENDENTE Y 'ASC' ES ASCENDENTE

# EJ.12 - ¿CUÁL ES EL PAÍS MÁS POBLADO DEL MUNDO?
SELECT * FROM COUNTRY ORDER BY POPULATION DESC LIMIT 1;

# EJ.13 - ¿CUÁL ES EL PAÍS MÁS POBLADO DE EUROPA?
SELECT * FROM COUNTRY WHERE CONTINENT = "EUROPE" ORDER BY POPULATION DESC;

# EJ.14 - MUESTRA LAS REGIONES DE EUROPA ORDENADAS ALFABÉTICAMENTE
SELECT DISTINCT REGION FROM COUNTRY WHERE CONTINENT = "EUROPE" ORDER BY REGION;

# ESTO ES CURIOSIDAD MIA
SELECT * FROM COUNTRY ORDER BY LIFEEXPECTANCY DESC;

# EJ.15 - 5 CIUDADES MÁS POBLADAS DE ESPAÑA 
SELECT * FROM CITY WHERE COUNTRYCODE = "ESP" ORDER BY POPULATION DESC LIMIT 5;

# EJ.16 - PAISES DEL MUNDO CON NUM DE HABITANTES ENTRE 1M Y 5M
SELECT NAME FROM COUNTRY WHERE POPULATION BETWEEN 1000000 AND 5000000 ORDER BY POPULATION DESC;

# EJ.17 - PAÍS DE AMÉRICA CON MAYOR SUPERFICIE
SELECT NAME FROM COUNTRY WHERE CONTINENT IN ("NORTH AMERICA","SOUTH AMERICA") ORDER BY SURFACEAREA DESC LIMIT 1;

SELECT NAME FROM COUNTRY WHERE CONTINENT LIKE "%AMERICA%" ORDER BY SURFACEAREA DESC LIMIT 1; # % DENTRO DE "..." SIGNIFICA LO QUE SEA EN LA CANTIDAD QUE SEA, PARA BUSCAR UNA PALABRA CLAVE.

# EJ.18 - PAIS DEL CARIBE CON MAYOR ESPERANZA DE VIDA
SELECT NAME FROM COUNTRY WHERE REGION = "CARIBBEAN" ORDER BY LIFEEXPECTANCY DESC LIMIT 1;

# EJ.19 - PAISES CON MENOS DE 60 AÑOS DE ESPERANZA DE VIDA
SELECT * FROM COUNTRY WHERE LIFEEXPECTANCY < 60 ORDER BY LIFEEXPECTANCY DESC;

# EJ.20 - MUESTRA UNA LISTA DE LAS FORMAS DE GOBIERNO ORDENADA DE FORMA ALFABÉTICA
SELECT DISTINCT GOVERNMENTFORM FROM COUNTRY ORDER BY GOVERNMENTFORM;

# EJ.21 - MUESTRA LOS PAÍSES QUE SON ALGÚN TIPO DE MONARQUÍA
SELECT NAME FROM COUNTRY WHERE GOVERNMENTFORM LIKE "%MONARCHY%";

# EJ.22 - CUANTOS PAÍSES COMIENZAN POR LA LETRA A
SELECT COUNT(*) FROM COUNTRY WHERE NAME LIKE "A%";

# EJ.23 - MUESTRA UNA LISTA DE LOS TIPOS DE REPÚBLICAS QUE HAY, ORDENADA DE FORMA ALFABÉTICA
SELECT DISTINCT GOVERNMENTFORM FROM COUNTRY WHERE GOVERNMENTFORM LIKE "%REPUBLIC%" ORDER BY GOVERNMENTFORM;

# EJ.24 - MUESTRA LOS 5 PAÍSES CON MENOS ESPERANZA DE VIDA
SELECT * FROM COUNTRY WHERE LIFEEXPECTANCY IS NOT NULL ORDER BY LIFEEXPECTANCY LIMIT 5;

# EJ.25 - ¿CUÁNTOS PAÍSES TIENEN FECHA DE INDEPENDENCIA?
SELECT COUNT(*) FROM COUNTRY WHERE INDEPYEAR IS NOT NULL;

SELECT COUNT(INDEPYEAR) FROM COUNTRY;	# ESTO ES LO MISMO QUE ARRIBA

# EJ.26 - ¿PARA CUÁNTOS PAÍSES NO DISPONEMOS DEL DATO DE ESPERANZA DE VIDA?
SELECT COUNT(*) FROM COUNTRY WHERE LIFEEXPECTANCY IS NULL;

# EJ.27 - ¿CUÁNTAS REGIONES HAY?
SELECT COUNT(DISTINCT REGION) AS REGIONES FROM COUNTRY;

# OPERACIONES
SELECT "DATO" AS COLUMNA;

SELECT 2*2 AS PRODUCTO;

SELECT 2/2 AS DIVISIÓN;

SELECT 2%2 AS MÓDULO;

# EJ.28 - MUESTRA UNA LISTA DE PAÍSES Y SE DENSIDAD DE POBLACIÓN
SELECT NAME, POPULATION/SURFACEAREA AS DENSIDAD_POBLACION FROM COUNTRY ORDER BY DENSIDAD_POBLACION DESC;

# EJ.29 - MUESTRA EL PRODUCTO NACIONAL BRUTO (GNP) PER CÁPITA DE ARGENTINA

# ...

# EJ.35 ¿CUAL ES LA ESPERANZA DE VIDA DE AFRICA?
SELECT AVG(LIFEEXPECTANCY) FROM COUNTRY WHERE CONTINENT = "AFRICA";

# EJ.36 ¿CUAL ES LA SUPERFICIE TOTAL DE TODO EL MUNDO?
SELECT SUM(SURFACEAREA) FROM COUNTRY ;

# EJ.37 ¿CUANTAS CIUDADES DE ANDALUCIA HAY EN LA BBDD?
SELECT COUNT(NAME) FROM CITY WHERE DISTRICT = "ANDALUSIA";

# EJ.38 ¿CUAL ES EL VALOR MAXIMO DEL GNP?¿A QUE PAIS CORRESPONDE?
SELECT NAME, GNP FROM COUNTRY WHERE GNP = (SELECT MAX(GNP) FROM COUNTRY);

# EJ.39 ¿CUAL ES EL VALOR MINIMO DEL GNP?¿A QUE PAIS CORRESPONDE?
SELECT NAME, GNP FROM COUNTRY WHERE GNP = (SELECT MIN(GNP) FROM COUNTRY);

# EJ.40 ¿EN QUE AÑO, DE MEDIA, SE INDEPENDIZARON LOS PAISES DE SUDAMERICA?
SELECT AVG(INDEPYEAR) FROM COUNTRY WHERE CONTINENT = "SOUTH AMERICA";

# EJ.41 ¿CUAL ES EL PAIS CON FECHA DE INDEPENDENCIA MAS CERCANA A HOY?

SELECT NAME, INDEPYEAR FROM COUNTRY WHERE INDEPYEAR = (SELECT MAX(INDEPYEAR) FROM COUNTRY);

# EJ.42 ¿QUE PAISES AMERICANOS TIENEN MAS POBLACION QUE ESPAÑA?
SELECT NAME FROM COUNTRY WHERE POPULATION > (SELECT POPULATION FROM COUNTRY WHERE NAME = "SPAIN") AND CONTINENT LIKE "%AMERICA%";

# EJ.43 ¿CUAL ES LA CIUDAD CON MAYOR POBLACION?
SELECT NAME, POPULATION FROM CITY WHERE POPULATION = (SELECT MAX(POPULATION) FROM CITY);

# EJ.44 ¿QUE PAISES TIENEN MENOS POBLACION QUE MADRID?
SELECT NAME FROM COUNTRY WHERE POPULATION < (SELECT POPULATION FROM CITY WHERE NAME = "MADRID");

# EJ.45 ¿HAY ALGUNA CIUDAD QUE SE LLAME IGUAL QUE ALGUN PAIS?
SELECT NAME FROM CITY WHERE NAME IN (SELECT NAME FROM COUNTRY);

# EJ.46 ¿QUE PAISES DE EUROPA Y ASIA TIENEN UNA POBLACION POR ENCIMA DE LA MEDIA DE ESOS CONTINENTES?
SELECT NAME FROM COUNTRY WHERE POPULATION > (SELECT AVG(POPULATION) FROM COUNTRY WHERE CONTINENT IN ("EUROPA","ASIA")) AND CONTINENT IN ("EUROPA","ASIA");

# EJ.47 ¿HAY ALGUN PAIS SIN CIUDADES EN LA BBDD?
SELECT NAME FROM COUNTRY WHERE CODE NOT IN (SELECT COUNTRYCODE FROM CITY);

# EJ.48 ¿CUANTAS CIUDADES NO SON CAPITALES?
SELECT COUNT(*) FROM CITY WHERE ID NOT IN (SELECT CAPITAL FROM COUNTRY WHERE CAPITAL IS NOT NULL);

# EJ.49 ¿CUAL ES LA POBLACION MEDIA DE LAS CIUDADES EUROPEAS?
SELECT AVG(POPULATION) AS MEDIA_POBLACION FROM CITY WHERE COUNTRYCODE IN (SELECT CODE FROM COUNTRY WHERE CONTINENT = "EUROPE");

# EJ.50 ¿CUAL ES LA POBLACION MEDIA DE LAS CAPITALES AMERICANAS?
SELECT AVG(POPULATION) AS MEDIA_POBLACION_CAPITALES_AMERICANAS FROM CITY WHERE ID IN (SELECT CAPITAL FROM COUNTRY WHERE CONTINENT LIKE "%AMERICA%");

# EJ.51 MUESTRA EL NOMBRE, LA SUPERFICIE, LA POBLACION Y LA DENSIDAD DE POBLACION DE JAPON Y ESPAÑA
SELECT NAME, SURFACEAREA, POPULATION, POPULATION/SURFACEAREA AS DENSIDAD_POBLACION FROM COUNTRY WHERE NAME IN ("JAPAN","SPAIN");

# EJ.52 MUESTRA EL NOMBRE DE LOS PAISES QUE HABLAN FRANCES DE FORMA OFICIAL
SELECT NAME FROM COUNTRY WHERE CODE IN (SELECT COUNTRYCODE FROM COUNTRYLANGUAGE WHERE LANGUAGE = "FRENCH" AND ISOFFICIAL = "T");

# EJ.53 MUESTRA LA POBLACION TOTAL DE LOS PAISES QUE HABLAN ESPAÑOL DE FORMA OFICIAL
SELECT SUM(POPULATION) AS POBLACION_TOTAL_ESPAÑOL FROM COUNTRY WHERE CODE IN (SELECT COUNTRYCODE FROM COUNTRYLANGUAGE WHERE LANGUAGE = "SPANISH" AND ISOFFICIAL = "T");

# EJ.54 ¿EN QUE REGIONES SE HABLA ESPAÑOL? (OFICIAL Y NO OFICIAL)
SELECT DISTINCT REGION FROM COUNTRY WHERE CODE IN (SELECT COUNTRYCODE FROM COUNTRYLANGUAGE WHERE LANGUAGE = "SPANISH");


# [!] HACER AGRUPACIONES:
SELECT CONTINENT, SUM(POPULATION) AS SUMA_POBLACION FROM COUNTRY GROUP BY CONTINENT ORDER BY SUMA_POBLACION DESC;

# EJ.55 MUESTRA LA ESPERANZA DE VIDA MEDIA POR CONTINENTE
SELECT CONTINENT, AVG(LIFEEXPECTANCY) AS ESPERANZA_VIDA_MEDIA FROM COUNTRY WHERE INDEPYEAR IS NOT NULL GROUP BY CONTINENT ORDER BY ESPERANZA_VIDA_MEDIA DESC;

# EJ.56 MUESTRA LAS REGIONES Y LA SUPERFICIE TOTAL DE CADA REGIÓN
SELECT REGION, SUM(SURFACEAREA) FROM COUNTRY GROUP BY REGION;

# EJ.57 MUESTRA EL AÑO DE INDEPENDENCIA PROMEDIO DE CADA CONTINENTE (SIN TENER EN CUENTA NULOS)
SELECT CONTINENT , AVG(INDEPYEAR) FROM COUNTRY WHERE INDEPYEAR IS NOT NULL GROUP BY CONTINENT;

# EJ.58 MUESTRA LOS DISTRITOS DE ESPAÑA (TABLA CITY) Y LA POBLACION TOTAL DE CADA UNO
SELECT DISTRICT, SUM(POPULATION) AS SUMA_POBLACION FROM CITY WHERE COUNTRYCODE = "ESP" GROUP BY DISTRICT ORDER BY SUMA_POBLACION DESC;

# EJ.59 SUMA EL PORCENTAJE TOTAL DE TODOS LOS IDIOMAS AGRUPANDO POR PAIS
SELECT COUNTRYCODE, SUM(PERCENTAGE) FROM COUNTRYLANGUAGE GROUP BY COUNTRYCODE;

# EJ.60 MUESTRA EL NOMBRE DE LAS REGIONES CON MAS DE 10M DE HABITANTES
SELECT REGION, SUM(POPULATION) AS REGIONES_MAS_1000M_HABITANTES FROM COUNTRY GROUP BY REGION HAVING SUM(POPULATION) > 1000000000;

# EJ.61 MUESTRA EL NOMBRE DE LAS REGIONES CON MAS DE 100M DE HABITANTES DE ASIA Y AMERICA
SELECT REGION, SUM(POPULATION) AS REGIONES_MAS_100M_HABITANTES FROM COUNTRY WHERE CONTINENT LIKE "%ASIA%" OR CONTINENT LIKE "%AMERICA%" GROUP BY REGION HAVING SUM(POPULATION) > 100000000;

# EJ.62 MUESTRA LOS DISTRITOS DE EUROPA CON MAS DE 3M DE HABITANTES
SELECT DISTRICT, SUM(POPULATION) FROM CITY WHERE COUNTRYCODE IN (SELECT CODE FROM COUNTRY WHERE CONTINENT = "EUROPE") GROUP BY DISTRICT HAVING SUM(POPULATION) > 3000000;

# EJ.63 MUESTRA UNA LISTA DE LOS CONTINENTES Y CUANTOS PAISES HAY EN CADA CONTINENTE
SELECT CONTINENT, COUNT(NAME) AS TOTAL_PAISES FROM COUNTRY GROUP BY CONTINENT ORDER BY TOTAL_PAISES DESC;

# EJ.64 MUESTRA UNA LISTA DE LAS REGIONES Y CUANTOS PAISES HAY EN CADA REGION
SELECT REGION, COUNT(NAME) AS TOTAL_PAISES FROM COUNTRY GROUP BY REGION ORDER BY TOTAL_PAISES DESC;

# EJ.65 MUESTRA EL NOMBRE DE LOS PAISES CON MAS DE 1 IDIOMA OFICIAL
SELECT NAME FROM COUNTRY WHERE CODE IN (SELECT COUNTRYCODE FROM COUNTRYLANGUAGE WHERE ISOFFICIAL = "T" GROUP BY COUNTRYCODE HAVING COUNT(*) > 1);

# EJ.66 MUESTRA EL NOMBRE DE LOS PAISES EUROPEOS CON MAS DE 1 IDIOMA OFICIAL
SELECT NAME FROM COUNTRY WHERE CONTINENT = "EUROPE" AND CODE IN (SELECT COUNTRYCODE FROM COUNTRYLANGUAGE WHERE ISOFFICIAL = "T" GROUP BY COUNTRYCODE HAVING COUNT(*) > 1);

# EJ.67 SELECCIONA LAS 3 PRIMERAS LETRAS DE LAS 3 COLUMNAS (CODIGO DE LOS PAISES, 3 PRIMERAS LETRAS DE SU NOMBRE EN MAYÚSCULAS Y UNA COLUMNE QUE INDIQUE SI LOS 2 ANTERIORES COINCIDEN)
SELECT UPPER(LEFT(NAME, 3)) AS TRES_PRIMERAS, CODE, CODE = UPPER(LEFT(NAME, 3)) AS SON_IGUALES FROM COUNTRY;

# EJ.68 PARA CUANTOS PAISES COINCIDE EL CODIGO CON SUS 3 PRIMERAS LETRAS
SELECT COUNT(*) FROM COUNTRY WHERE CODE = UPPER(LEFT(NAME, 3));

# [!] REPEAT(cadena, n) -> REPITE UNA CADENA N VECES
SELECT REPEAT("*",8);

SELECT REPEAT(NAME, 2) FROM COUNTRY;

# [!] REPLACE(cadena, subcadena_anterior, subcadena_nueva)
SELECT REPLACE("ESTO ES UNA CADENA DE TEXTO", "CADENA", "OTRA COSA");

SELECT REPLACE(HEADOFSTATE, "Elisabeth", "ISABEL") FROM COUNTRY;

# [!] REVERSE(cadena) DA LA VUELTA A LA CADENA
SELECT REVERSE("123456789");

# ========================== FUNCIONES NUMÉRICAS ============================
# [!] SQRT(n) -> RAÍZ CUADRADA

SELECT SQRT(9);

# EJ.69 SI ESPAÑA FUERA CUADRADA, CUANTOS KM DE LADO TENDRÍA?ALTER
SELECT SQRT(SURFACEAREA) AS KM_LADO FROM COUNTRY WHERE NAME = "Spain";

# [!] ROUND(numero, decimales) -> REDONDEAR
SELECT ROUND(7.446956144778993264, 3);

# [!] TRUNCATE(NUMERO, DECIMALES) -> TRUNCA, OSEA CORTA
SELECT TRUNCATE(7.486956144778993264, 1);

# [!] FLOOR(NUMERO) -> REDONDEA HACIA ABAJO CON ENTEROS
SELECT FLOOR(7.486956144778993264);

# [!] CEIL(NUMERO) -> REDONDEA HACIA ARRIBA CON ENTEROS
SELECT CEIL(7.486956144778993264);

# EJ.70 GENERA UN NÚMERO ALEATORIO ENTRE 1 Y 10
SELECT TRUNCATE(RAND()*10+1, 0);
SELECT CEIL(RAND()*10);


# ================================= JOIN ===============================

SELECT * FROM COUNTRY;

SELECT * FROM CITY
JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE;

# EJ.71 MUESTRA UNA LISTA DE LAS CIUDADES DE ESPAÑA, SU POBLACIÓN, LA POBLACIÓN DEL PAÍS Y EL % DE POBLACIÓN DEL PAÍS QUE VIVE EN ESA CIUDAD (2 DECIMALES)
SELECT 
	CITY.NAME, 
    CITY.POPULATION AS POBLACION_CIUDAD, 
    COUNTRY.POPULATION AS POBLACION_PAIS, 
    ROUND(CITY.POPULATION/COUNTRY.POPULATION*100, 2) AS PORCENTAJE_POBLACION 
FROM CITY 
JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE COUNTRY.NAME = "SPAIN";

# EJ.72 MUESTRA UNA LISTA DE LOS DISTRITOS DE ESPAÑA, SU POBLACION, LA POBLACION DEL PAIS Y EL PORCENTAJE DE POBLACION DEL PAIS QUE VIVE EN SE DISTRITO (2 DECIMALES)
SELECT 
	CITY.DISTRICT, 
    SUM(CITY.POPULATION) AS POBLACION_DISTRITO, 
    MAX(COUNTRY.POPULATION) AS POBLACION_PAIS,
    ROUND(SUM(CITY.POPULATION)/MAX(COUNTRY.POPULATION)*100, 2) AS PORCENTAJE_POBLACION 
FROM CITY 
JOIN COUNTRY ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE COUNTRY.NAME = "SPAIN"
GROUP BY CITY.DISTRICT;

# EJ.73 MUESTRA UNA LISTA DE LAS CAPITALES EUROPEAS USANDO JOIN
SELECT
	CITY.NAME
FROM COUNTRY
JOIN CITY ON COUNTRY.CAPITAL = CITY.ID
WHERE CONTINENT = "EUROPE";

# EJ.74 ¿CUAL ES LA CAPITAL DEL MUNDO MÁS POBLADA?

SELECT
	CITY.NAME
FROM COUNTRY 
JOIN CITY ON COUNTRY.CAPITAL = CITY.ID
ORDER BY CITY.POPULATION DESC 
LIMIT 1;

# EJ.75 MUESTRA UNA LISTA CON EL NOMBRE DE LOS PAISES Y LA CANTIDAD DE IDIOMAS QUE SE HABLAN EN DICHO PAIS
SELECT
	COUNTRY.NAME,
    COUNT(COUNTRYLANGUAGE.LANGUAGE) AS IDIOMAS
FROM COUNTRY
JOIN COUNTRYLANGUAGE ON COUNTRY.CODE = COUNTRYLANGUAGE.COUNTRYCODE
GROUP BY COUNTRY.NAME;

# EJ.76 MUESTRA UNA LISTA CON EL NOMBRE DE LOS PAISES Y LA CANTIDAD DE IDIOMAS OFICIALES QUE SE HABLAN EN DICHO PAIS
SELECT
	COUNTRY.NAME,
    COUNT(COUNTRYLANGUAGE.LANGUAGE) AS IDIOMAS_OFICIALES
FROM COUNTRY
JOIN COUNTRYLANGUAGE ON COUNTRY.CODE = COUNTRYLANGUAGE.COUNTRYCODE
WHERE COUNTRYLANGUAGE.ISOFFICIAL = "T"
GROUP BY COUNTRY.NAME;

# EJ.77 MUESTRA UNA LISTA CON EL NOMBRE DE TODOS LOS PAISES Y LA CANTIDAD DE CIUDADES DE CADA PAIS DISPONIBLES EN LA BASE DE DATOS
SELECT
	COUNTRY.NAME,
    COUNT(*) AS CANTIDAD_CIUDADES
FROM COUNTRY 
JOIN CITY ON COUNTRY.CODE = CITY.COUNTRYCODE
GROUP BY COUNTRY.NAME;

# EJ.78 MUESTRA EL NOMBRE DE LOS PAISES SIN CIUDADES REGISTRADAS
SELECT 
	NAME
FROM COUNTRY 
WHERE CODE NOT IN (SELECT COUNTRYCODE FROM CITY);

SELECT * FROM CITY;
SELECT 
	COUNTRY.NAME
FROM COUNTRY
LEFT JOIN CITY ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE CITY.NAME IS NULL;

# EJ79 - MUESTRA UNA LISTA CON EL NOMBRE DE LOS PAÍSES, LOS IDIOMAS HABLADOS Y LA CANTIDAD DE PERSONAS QUE HABLAN CADA IDIOMA EN CADA PAÍS.
SELECT * FROM COUNTRY;

SELECT
	CO.NAME,
    CL.LANGUAGE,
    CEIL(CO.POPULATION*CL.PERCENTAGE/100) AS HABLANTES
FROM COUNTRY AS CO
JOIN COUNTRYLANGUAGE AS CL ON CO.CODE = CL.COUNTRYCODE;

# EJ80 - MUESTRA UNA LISTA CON EL NOMBRE DE LA CAPITAL DE LOS PAÍSES CON ESPAÑOL COMO IDIOMA OFICIAL.
SELECT
	CI.NAME
FROM COUNTRY AS CO
JOIN COUNTRYLANGUAGE AS CL ON CO.CODE = CL.COUNTRYCODE
JOIN CITY AS CI ON CI.ID = CO.CAPITAL
WHERE CL.LANGUAGE = "SPANISH" AND CL.ISOFFICIAL = "T";

# EJ81 - MUESTRA EL PORCENTAJE DE LA POBLACIÓN MUNDIAL QUE HABLA ESPAÑOL.
SELECT
	CL.LANGUAGE,
	SUM(CO.POPULATION*CL.PERCENTAGE/100)/(SELECT SUM(POPULATION) FROM COUNTRY)*100 AS PORCENTAJE_MUNDIAL_HISPANOHABLANTES
FROM COUNTRY AS CO
JOIN COUNTRYLANGUAGE AS CL ON CO.CODE = CL.COUNTRYCODE
WHERE CL.LANGUAGE = "SPANISH"; 
	

# EJ82 - MUESTRA UNA LISTA CON LOS IDIOMAS Y EL PORCENTAJE DE LA POBLACIÓN MUNDIAL QUE HABLA CADA IDIOMA (ORDENA DE MAYOR A MENOR).

SELECT
	CL.LANGUAGE AS IDIOMA,
	ROUND(SUM(CO.POPULATION*CL.PERCENTAGE/100) / (SELECT SUM(POPULATION) FROM COUNTRY)*100, 2) AS PORCENTAJE_HABLANTES
FROM COUNTRY AS CO
JOIN COUNTRYLANGUAGE AS CL ON CO.CODE = CL.COUNTRYCODE
GROUP BY CL.LANGUAGE
ORDER BY PORCENTAJE_HABLANTES DESC;  

# EJ83 - MUESTRA TODAS LAS CIUDADES QUE NO SON CAPITALES.
SELECT 
	CI.NAME
FROM CITY AS CI
LEFT JOIN COUNTRY AS CO ON CI.ID = CO.CAPITAL
WHERE CO.CODE IS NULL;


