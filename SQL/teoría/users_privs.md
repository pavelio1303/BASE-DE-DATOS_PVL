# GESTION DE PERMISOS MSQL

Hasta ahora, todos los ejercicios se han hecho con el usuario root (superusuario). En un entorno real, el superusuario 'root' sólo será usado por el administrador de la base de datos. Los desarrolladores tendrán usuarios con permisos para acceder a los elementos del Sistema de Gestión de Base de datos MyQsl (tablas, bases de datos, vistas , procedimientos, ect).


Documentación  [oficial de MySQL](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html "Title").

## CREACION DE USUARIOS

### Definción:

El comando `CREATE USER` permitirá crear usuarios en MySQL.

### Sintaxis:

```sql
-- Crea un usuario que sólo se puede conectar si lo hace desde la misma máquina donde está el servidor de  MySQL.
CREATE USER {'user_name'}@{'localhost'} IDENTIFIED BY {'password'}; 
```

```sql
-- Crea un usuario que se pueda conectar desde cualquier máquina a la maquina donde está el servidor de MySQL.  
Si no se pone la @, por defecto, se crea de esta manera.    
CREATE USER {'user_name'}@'%' IDENTIFIED BY {'password'}; 
CREATE USER {'user_name'} IDENTIFIED BY {'password'}; 
```

```sql
-- Crea un usuario que se pueda conectar sólo desde una máquina ('host_ip') a la maquina donde está el servidor de MySQL.
CREATE USER {'user_name'}@{'host_ip'} IDENTIFIED BY {'password'}; 
```

### Ejemplos:

```sql
-- Se crea el usuario mczurera que se podrá conectar al servidor desde cualquier máquina. 
CREATE USER 'alejandro' IDENTIFIED BY '1234'; 
```

```sql
-- Se crea el usuario mczurera que sólo odrá conectar al servidor desde la máquina con IP 10.239.217.31
CREATE USER 'pablo'@'172.16.0.7' IDENTIFIED BY '1234'; 
```

## CONSULTAR USUARIOS DE UNA BASE DE DATOS

Consultaremos esta información en la base de datos **`mysql`**, que es el lugar donde se almacena información relacionada con los parámetros de MySQL,los usuarios así como de los permisos asociados a dichos usuarios.

```sql
-- Consultar el nombre de usuario y desde donde puede acceder al servidor de MySQL 
SELECT user,host FROM mysql.user;
```

## CONSULTAR LOS PERMISOS DE UN USUARIO DETERMINADO

### Definción:

Un usuario recien creado en la base de datos solo tendrá permisos para conectarse al MySQL (USAGE).El comando `SHOW GRANTS` permitira consultar estos permisos. 

### Sintaxis

```sql
-- Consultar los permisos que tiene un usuario sobre los objetos de las bases de datos 
SHOW GRANTS FOR {'user_name'};
```

## CONCEDER Y REVOCAR (ELIMINAR) PERMISOS A USUARIOS

### Definción:

Se pueden conceder desde permisos a todo el sistema (como si fuera el usuario root) hasta limitarlos para que sólo se puedan consultar una columna de una tabla.

El comando `GRANT` se usará para conceder permisos y el comando `REVOKE` para eliminarlos.
Estos permisos se podrán conceder de forma individual o agrupada. Nos centraremos en los permisos mas comunes en MYSQL : 

1.- `ALL PRIVILEGES`: Todos los privilegios.  
2.- `SELECT`,`INSERT`,`UPDATE`y  `DELETE`: Permite consultar vistas y tablas e insertar, modificar y borrar filas de tablas.  
3.- `CREATE ROUTINE`, `ALTER ROUTINE`,  y `EXECUTE`: Permite crear, modificar y ejecutar procedimientos y funciones.  
4.- `CREATE` y `ALTER`: Permite crear  o modificar nuevas tablas o vistas  o bases de datos.  
5.- `DROP`: Permite eliminar tablas o vistas o bases de datos.  
6.- `GRANT OPTION`: Permite otorgar o eliminar privilegios a otros.  


### Sintaxis

De forma general: 
```sql
-- Concede privilegios a un usuario
GRANT {permission_type} ON {privilege_level} TO {'user_name'}; 
```

```sql
-- Revoca o elimina privilegios a un usuario 
REVOKE {permission_type} ON {privilege_level} FROM {'user_name'}; 
```

De forma particular, para cada unos de los permisos más comunes: 

### 1.- `ALL PRIVILEGES`:

```sql
-- Concede a un usuario  todos los privilegios
GRANT ALL PRIVILEGES ON {privilege_level} TO {'user_name'}; 
```

```sql
-- Quita al usuario todos los privilegios 
REVOKE ALL PRIVILEGES ON {privilege_level} FROM {'user_name'}; 
```


### Ejemplos

* PERMISOS SOBRE TODO EL SISTEMA:
```sql
-- Concede al usuario  mczurera todos los privilegios sobre todo el sistema (*.*). Este usuario tendrá los mismos  
permisos que el usuario root 
GRANT ALL PRIVILEGES ON *.* TO 'mczurera'; 
```

```sql
-- Quita  al usuario mczurera todos los privilegios sobre todo el sistema (*.*). Este usuario sólo tendrá privilegios  
de conexión (USAGE)
REVOKE ALL PRIVILEGES ON *.* FROM 'mczurera'; 
```

* PERMISOS SOBRE TODAS LAS TABLAS DE UNA BASE DE DATOS : 

```sql
-- Concede al usuario mczurera todos los privilegios sobre todas las tablas de la base de datos world. Se permite crear,  
borrar y modificar tablas.También leer, insertar, modificar y borrar datos de cualquier tabla.
GRANT ALL PRIVILEGES ON world.* TO 'mczurera'; 
```

```sql
-- Quita  a un usuario  todos los privilegios sobre la base de datos world.
REVOKE ALL PRIVILEGES ON world.* FROM 'mczurera'; 
```

* PERMISOS SOBRE UNA TABLA DE UNA BASE DE DATOS : 

```sql
-- Concede al usuario mczurera permisos de  modificación y borrado de la tabla.También permisos de lectura, inserción , modificación y borrado de sus datos.
GRANT ALL PRIVILEGES ON world.city TO 'mczurera'; 
```

```sql
-- Quita al usuario mczurera todos los privilegios la tabla city de la base de datos world.
REVOKE ALL PRIVILEGES ON world.city FROM 'mczurera'; 
```


### 2´.-`SELECT`, `INSERT`,`UPDATE` Y `DELETE`:

Se pueden conceder y revocar de forma individual o combinada.

```sql
-- Concede a un usuario  permisos para consultar, insertar, modificar o borrar las filas de una tabla
GRANT SELECT ON {privilege_level} TO {'user_name'}; 
GRANT INSERT ON {privilege_level} TO {'user_name'};
GRANT UPDATE ON {privilege_level} TO {'user_name'}; 
GRANT DELETE ON {privilege_level} TO {'user_name'};  
```

```sql
--Quita a un usuario  permisos para consultar, insertar, modificar o borrar las filas de una tabla 
REVOKE SELECT ON {privilege_level} FROM {'user_name'}; 
REVOKE INSERT ON {privilege_level} FROM {'user_name'};
REVOKE UPDATE ON {privilege_level} FROM {'user_name'}; 
REVOKE DELETE ON {privilege_level} FROM {'user_name'};  

```

### Ejemplos

* PERMISOS DE CONSULTA Y MODIFICACION DE DATOS PARA TODAS TABLAS DENTRO UNA BASE DE DATOS
```sql
-- Concede al usuario mczurera permisos para consultar todas las tablas de la base de datos world
GRANT SELECT ON world.* TO 'mczurera'; 
-- Concede al usuario mczurera permisos para modificar los datos de todas las tablas de la base de datos world
GRANT INSERT, UPDATE, DELETE ON world.* TO 'mczurera';
```

```sql
-- Quita al usuario mczurera permisos para modificar todas las tablas de la base de datos world
REVOKE SELECT ON world.* FROM 'mczurera'; 
-- Quita al usuario mczurera permisos para modificar  los datos de todas las tablas de la base de datos world
REVOKE INSERT, UPDATE, DELETE ON world.* TO 'mczurera';
```

* PERMISOS DE CONSULTA Y MODIFICACION DE DATOS SOBRE UNA TABLA DE  UNA BASE DE DATOS

```sql
-- Concede al usuario mczurera permisos para consultar e insertar datos en la table city de la base de datos world
GRANT SELECT, INSERT ON world.city TO 'mczurera'; 
-- Concede al usuario mczurera permisos para consultar y borrar filas de la tabla city de la base de datos world 
GRANT SELECT, DELETE ON world.city TO 'mczurera';
-- Concede al usuario mczurera permisos para consultar la tabla city  y modificar la columna NAME de la base de datos world 
GRANT SELECT, UPDATE(NAME) ON world.city TO 'mczurera'; 
```

```sql
--Quita al usuario mczurera permisos para consultar e insertar datos en la tabla city de la base de datos world 
REVOKE SELECT, INSERT ON world.city FROM 'mczurera'; 
-- Quita al usuario mczurera permisos para consultar y borrar datos de la tabla city de la base de datos world
REVOKE SELECT, DELETE ON world.city FROM 'mczurera'; 
-- Quita al usuario mczurera permisos para consultar y modificar la columna NAME  de la tabla city de la base de datos world
REVOKE SELECT, UPDATE(NAME) ON world.city  FROM 'mczurera';
```

### 3.- `CREATE ROUTINE`, `ALTER ROUTINE`,  y `EXECUTE`

```sql
-- Concede a un usuario  permisos para crear modificar y ejecutar procedimientos y funciones de mysql 
GRANT CREATE ROUTINE ON {privilege_level} TO {'user_name'}; 
GRANT ALTER ROUTINE ON {privilege_level} TO {'user_name'}; 
GRANT EXECUTE ON {privilege_level} TO {'user_name'};  
```

### Ejemplos

* PERMISOS PARA CREAR, MODIFICAR Y EXECUTAR PROCEDIMIENTOS Y FUNCIONES EN TODAS LAS BASES DE DATOS  

```sql
-- Concede al ususario mczurera permisos para crear, modificar y ejecutar cualquier funcion o procedimiento
GRANT CREATE ROUTINE, ALTER ROUTINE, EXECUTE ON *.* TO 'mczurera'; 
```

```sql
-- Quita al usuario mczurera permisos para crear, modificar y ejecutar cualquier funcion o procedimiento
REVOKE CREATE ROUTINE, ALTER ROUTINE, EXECUTE ON *.* FROM 'mczurera'; 
```

* PERMISOS PARA CREAR MODIFICAR Y EXECUTAR PROCEDIMIENTOS Y FUNCIONES EN UNA BASE DE DATOS 
```sql
-- Concede al ususario mczurera permisos para permisos para crear, modificar y ejecutar cualquier funcion o procedimiento en la  
base de datos world 
GRANT CREATE ROUTINE, ALTER ROUTINE, EXECUTE ON world.* TO 'mczurera'; 
```

```sql
-- Quita al usuario mczurera permisos para crear, modificar y ejecutar cualquier funcion o procedimiento en la  
base de datos world
REVOKE CREATE ROUTINE, ALTER ROUTINE, EXECUTE ON world.* FROM 'mczurera'; 
```

### 4.- `CREATE` y `ALTER` :

```sql
-- Concede a un usuario  permisos para crear una base de datos o tablas de una base de datos
GRANT CREATE ON {privilege_level} TO {'user_name'}; 
-- Concede a un usuario  permisos para modificar una base de datos o cualquiera de sus objetos
GRANT ALTER ON {privilege_level} TO {'user_name'}; 
```

```sql
-- Quita a un usuario permisos para crear bases de datos o tablas de  de una base de datos 
REVOKE CREATE ON {privilege_level} FROM {'user_name'}; 
-- Quita a un usuario permisos para modificar bases de datos o tablas de de una base de datos 
REVOKE ALTER ON {privilege_level} FROM {'user_name'}; 

```

### Ejemplos

* PERMISOS PARA CREAR UNA BASE DE DATOS 

```sql
-- Concede al ususario mczurera permisos para crear una base de datos
GRANT CREATE ON *.* TO 'mczurera'; 
```

```sql
-- Quita al usuario mczurera permisos para crear bases de datos 
REVOKE CREATE ON *.* FROM 'mczurera'; 
```

* PERMISOS PARA CREAR TABLAS DENTRO UNA BASE DE DATOS 

```sql
-- Concede al ususario mczurera permisos para crear tablas en la base de datos world 
GRANT CREATE ON world.* TO 'mczurera'; 
```

```sql
-- Quita al usuario mczurera permisos para crear tablas en la base de datos world 
REVOKE CREATE ON world.* FROM 'mczurera'; 
```
* PERMISOS PARA MODIFICAR UNA BASE DE DATOS

```sql
-- Concede al ususario mczurera permisos para crear tablas en la base de datos world 
GRANT ALTER ON world.* TO 'mczurera'; 
-- El usurio podria modificar cualquier objeto de la base de datos world e incluso la propria base de datos,
-- p.ej: haciendo que ésta sea sólo de lectura 
ALTER DATABASE DB1 READ ONLY=1; 
```
```sql
-- Quita al usuario mczurera permisos para crear tablas en la base de datos world 
REVOKE ALTER ON world.* FROM 'mczurera'; 
```

* PERMISOS PARA MODIFICAR UN OBJETO DE UNA BASE DE DATOS

```sql
-- Concede al ususario mczurera permisos para modificar la tabla country de la base de datos world 
GRANT ALTER ON world.country TO 'mczurera'; 
```
```sql
-- Quita al usuario mczurera permisos para crear tablas en la base de datos world 
REVOKE ALTER ON world.country FROM 'mczurera'; 
```


### 5.- `DROP`:

```sql
-- Concede a un usuario  permisos para eliminar una base de datos o tablas sobre una base de datos
GRANT DROP ON {privilege_level} TO {'user_name'}; 
```

```sql
-- Quita a un usuario permisos para eliminar bases de datos o tablas dentro de una base de datos 
REVOKE DROP ON {privilege_level} FROM {'user_name'}; 
```

### Ejemplos

* PERMISOS PARA BORRAR UNA BASE DE DATOS 

```sql
-- Concede al ususario mczurera permisos para borrar una base de datos
GRANT DROP ON *.* TO 'mczurera'; 
```

```sql
-- Quita al usuario mczurera permisos para borrar bases de datos 
REVOKE DROP ON *.* FROM 'mczurera'; 
```

* PERMISOS PARA BORRAR TABLAS DENTRO UNA BASE DE DATOS 

```sql
-- Concede al ususario mczurera permisos para borrar tablas en la base de datos world 
GRANT DROP ON world.* TO 'mczurera'; 
```

```sql
-- Quita al usuario mczurera permisos para crear tablas en la base de datos world 
REVOKE DROP ON world.* FROM 'mczurera'; 
```

### 5.- `GRANT OPTION`

Cuando se otorga un permiso a un usuario `WITH GRANT OPTION`, este puede otorgar a otros  usuarios ese mismo permiso. De forma general: 


```sql
-- Concede privilegios a un usuario
GRANT {permission_type} ON {privilege_level} TO {'user_name'} WITH GRANT OPTION; 
```

### Ejemplos:

```sql
-- Concede al usuario alejandro privilegios de consulta, inserción y modificación de los datos de todas las tablas de la base de datos world. Además este usuario puede dar estos privilegios a otros usuarios.  
GRANT SELECT, INSERT, UPDATE ON world.* TO 'alejandro' WITH GRANT OPTION;
```
Si nos **conectamos con el usuario alejandro**, este podrá conceder cualquiera de estos permisos a otro usuario.** 

```sql
-- Concede privilegios de consulta sobre todas las tablas de la base de datos world al usuario pablo
GRANT SELECT ON world.* TO 'pablo';
```
```sql
-- Como mczurera tiene permisos de consulta y modificacion sobre  los datos de todas las tablas de world, puede dar a otro usuario permisos de consulta y insercion sobre la tabla city
GRANT SELECT, INSERT ON world.city  TO 'ruben';

Probar desde pperez la insercion: 
INSERT INTO  world.city VALUES (1000000,'Nuevo', 'PHL', 'Distrito nuevo' , '1');
```
```sql
-- Como alejandro tiene permisos de consulta y modificacion sobre los datos de todas las tablas de world, puede dar a otro usuario permisos de consulta y modificación sobre la tabla country 
GRANT SELECT, UPDATE(POPULATION) ON world.country TO 'ruben';

Probar desde el usuario ruben la modificación del campo POPULATION: 
UPDATE world.country SET POPULATION=100 WHERE CODE='ABW';

```

## ROLES

### Definición:

Un rol es una coleccion de privilegios que se pueden asignar a usuarios. Si tenemos varios usuarios con el mismo conjunto de permisos, estos se asocian una única vez al rol y luego este se asignan a cada uno de los usuarios. 

### Sintaxis:

```sql
-- Crear un rol
CREATE ROLE {'role_name'};
```
```sql
-- Asignar y revocar  privilegios a un rol (Se hace igual que la asignación a usuarios )
GRANT  {permission_type} ON {privilege_level} TO {'role_name'};
REVOKE  {permission_type} ON {privilege_level} FROM {'role_name'};
```
```sql
-- Asignar y revocar un rol a un usuario
GRANT  {'role_name'}  TO {'user_name'} {WITH ADMIN OPTION};
REVOKE {'role_name'}  FROM {'user_name'};
```

### Ejemplos:

```sql
-- Crear un rol 
CREATE ROLE 'consulta';
```
```sql
-- Asignar permisos de lectura sobre las bases de datos world y sakila
GRANT  SELECT ON world.* TO 'consulta';
GRANT  SELECT ON sakila.* ON 'consulta';
```
```sql
-- Asignar  el role al usuario mczurera
GRANT  'consulta'  TO 'ruben' {WITH ADMIN OPTION};
GRANT  'consulta'  TO 'pablo' {WITH ADMIN OPTION};
```
```sql
-- Activar los roles a los usuarios mczurera y fgarcia
SET DEFAULT ROLE ALL TO 'ruben';
SET DEFAULT ROLE ALL TO 'pablo';
```
```sql
-- Entrando con cada uno de los usuarios comprobar que el rol ha sido concedido
SELECT current_role();
```

```sql
-- Revocar el role al usuario mczurera
REVOKE 'consulta'  FROM 'ruben' ;
REVOKE 'consulta'  FROM 'pablo' ;
```






