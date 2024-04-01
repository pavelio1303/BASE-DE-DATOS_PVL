# Índices simples (o normales): Estos son los índices más comunes en MySQL y se crean utilizando la sentencia CREATE INDEX. Pueden ser creados en una o varias columnas y son eficaces para consultas que filtran o buscan registros basados en una columna o una combinación de columnas. 

# Por ejemplo:
CREATE INDEX index_name ON table_name(column_name);

# Índices únicos: Estos índices garantizan que los valores en la columna (o columnas) especificada sean únicos en la tabla. Son útiles cuando necesitas asegurarte de que no haya duplicados en una columna específica. Pueden crearse con la sentencia CREATE UNIQUE INDEX.

# Por ejemplo:
CREATE UNIQUE INDEX index_name ON table_name(column_name);

# Claves primarias (Primary Keys): La clave primaria es un tipo especial de índice único que se utiliza para identificar de manera única cada fila en una tabla. Se utiliza la sentencia ALTER TABLE para agregar una clave primaria a una tabla. 

# Por ejemplo:
ALTER TABLE table_name ADD PRIMARY KEY (column_name);

# Claves externas (Foreign Keys): Aunque no son índices en sí mismos, las claves externas son importantes para mantener la integridad referencial entre tablas. Se crean utilizando la sentencia ALTER TABLE y estableciendo una restricción de clave externa. 

# Por ejemplo:
ALTER TABLE table_name ADD FOREIGN KEY (column_name) REFERENCES other_t;


 # =========================== EJEMPLOS (BBDD SEGUROS) =========================== #
 
 USE SEGUROS;
 
# EJ1 - CREA UN ÍNIDCE DE TIPO HASH Y ÚNICO PARA LA MATRÍCULA DE LOS VEHÍCULOS

DROP INDEX MATRICULAS_IX ON VEHICULO;
CREATE UNIQUE INDEX MATRICULAS_IX USING HASH ON VEHICULO(MATRICULA);

# EJ2 - CREA UN ÍNDICE PARA LA FECHA DE PERMISO Y OTRO PARA LA FECHA DE NACIMIENTO DE LOS CLIENTES

CREATE INDEX FECHA_PERMISO_IX ON CLIENTE(FECHA_PERMISO);
CREATE INDEX FECHA_NACIMIENTO_IX ON CLIENTE(FECHA_NACIMIENTO);

CREATE INDEX FECHA_NACIMIENTO_PERMISO_IX ON CLIENTE(FECHA_PERMISO, FECHA_NACIMIENTO);



USE WORLD;

# EJ3 - INDICA QUE LA COLUMNA CAPITAL ES UNA CLAVE EXTERNA

ALTER TABLE COUNTRY ADD FOREIGN KEY (CAPITAL) REFERENCES CITY(ID);

# EJ4 - AÑADE UN ÍNIDCE A LAS COLUMNAS DE REGIÓN Y CONTINENTE (DOS ÍNDICES).

CREATE INDEX COUNTRY_REGION_IX ON COUNTRY(REGION);
CREATE INDEX COUNTRY_CONTINENT_IX ON COUNTRY(CONTINENT);

# EJ5 - AÑADE UN ÍNDICE ÚNICO AL NOMBRE DE LOS PAÍSES.

CREATE UNIQUE INDEX COUNTRY_NAME_UQ_IX ON COUNTRY(NAME);













