package com.stem;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Clase principal que contiene métodos para interactuar con una base de datos
 * MySQL que contiene información sobre países.
 */
public class Main {

    // ================== Datos de conexión a la base de datos ================== //

    // URL de conexión a la base de datos. En este caso, utiliza el protocolo
    // JDBC para conectarse a un servidor MySQL en el localhost (la misma máquina
    // donde se ejecuta el código) en el puerto 3306, y accede a la base de datos
    // llamada "world". La URL de conexión sigue un formato estándar:
    // jdbc:mysql://[host]:[port]/[database].
    static String url = "jdbc:mysql://localhost:3306/world";
    static String usuario = "root";
    static String contrasenia = "1234";

    /**
     * Método para leer todos los registros de la tabla COUNTRY en la base de
     * datos.
     * 
     * @throws SQLException Si ocurre un error al ejecutar la consulta SQL.
     */
    static void leerRegistros() throws SQLException {
        // Establezco una conexión con la base de datos utilizando los datos de conexión.
        Connection conexion = DriverManager.getConnection(url, usuario, contrasenia);
        // Creo una sentencia para enviar consultas SQL a la base de datos.
        Statement sentencia = conexion.createStatement();

        // Defino la consulta SQL para seleccionar todos los registros de la tabla
        // COUNTRY.
        String consulta = "SELECT * FROM COUNTRY";
        // Ejecuto la consulta SQL y obtengo un conjunto de resultados.
        ResultSet resultado = sentencia.executeQuery(consulta);


        // Itero a través de cada fila en el conjunto de resultados.
        // El método next() de un objeto ResultSet en Java se utiliza para avanzar al
        // siguiente registro en el conjunto de resultados. Cuando se llama a next(), el
        // cursor se mueve a la siguiente fila y devuelve true si hay más filas
        // disponibles; de lo contrario, devuelve false.
        while (resultado.next()) {
            // Extraigo los valores de las columnas de la fila actual.
            String codigo = resultado.getString("CODE");
            String nombre = resultado.getString("NAME");
            float superficie = resultado.getFloat("SURFACEAREA");
            int anioIndependencia = resultado.getInt("INDEPYEAR");

            // Imprimo la información de cada país.
            System.out.println("El país " + nombre + " con código " + codigo
                    + " tiene una superficie de " + superficie
                    + " kilómetros y se independizó en "
                    + anioIndependencia);
        }

        // Cierro la sentencia y la conexión para liberar recursos.
        sentencia.close();
        conexion.close();
    }

    /**
     * Método para crear un nuevo registro en la tabla COUNTRY en la base de
     * datos.
     * 
     * @param codigo El código del país a insertar.
     * @param nombre El nombre del país a insertar.
     * @return true si se crea correctamente, false de lo contrario.
     * @throws SQLException Si ocurre un error al ejecutar la consulta SQL.
     */
    static boolean crearRegistro(String codigo, String nombre) throws SQLException {
        // Establezco una conexión con la base de datos utilizando los datos de conexión.
        Connection conexion = DriverManager.getConnection(url, usuario, contrasenia);
        // Creo una sentencia parametrizada para enviar consultas SQL a la base de datos.
        PreparedStatement sentencia = conexion.prepareStatement("INSERT INTO COUNTRY (CODE, NAME) VALUES (?, ?)");
        sentencia.setString(1,codigo);
        sentencia.setString(2,nombre);

        // Ejecuto la consulta SQL y obtiene el número de filas afectadas.
        int filasAfectadas = sentencia.executeUpdate();

        // Cierro la sentencia y la conexión para liberar recursos.
        sentencia.close();
        conexion.close();

        // Devuelvo true si al menos una fila fue afectada (indicando que se creó el
        // registro), de lo contrario, devuelvo false.
        return filasAfectadas > 0;
    }

    /**
     * Método para actualizar un registro en la tabla COUNTRY en la base de datos.
     * 
     * @param codigo El código del país a actualizar.
     * @param nombre El nuevo nombre del país.
     * @return true si se actualiza correctamente, false de lo contrario.
     * @throws SQLException Si ocurre un error al ejecutar la consulta SQL.
     */
    static boolean actualizarRegistro(String codigo, String nombre) throws SQLException {
        Connection conexion = DriverManager.getConnection(url, usuario, contrasenia);
       
        PreparedStatement sentencia = conexion.prepareStatement("UPDATE COUNTRY SET NAME = ? WHERE CODE = ?");
        sentencia.setString(1,nombre);
        sentencia.setString(2,codigo);

        int filasAfectadas = sentencia.executeUpdate();

        sentencia.close();
        conexion.close();

        return filasAfectadas > 0;
    }

    /**
     * Método para eliminar un registro de la tabla COUNTRY en la base de datos.
     * 
     * @param codigo El código del país a eliminar.
     * @return true si se elimina correctamente, false de lo contrario.
     * @throws SQLException Si ocurre un error al ejecutar la consulta SQL.
     */
    static boolean eliminarRegistro(String codigo) throws SQLException {
        Connection conexion = DriverManager.getConnection(url, usuario, contrasenia);

        PreparedStatement sentencia = conexion.prepareStatement("DELETE FROM COUNTRY WHERE CODE = ?");
        sentencia.setString(1,codigo);

        int filasAfectadas = sentencia.executeUpdate();

        sentencia.close();
        conexion.close();

        return filasAfectadas > 0;
    }

    /**
     * Método principal que realiza operaciones CRUD en la tabla COUNTRY.
     * 
     * @param args Los argumentos de la línea de comandos.
     * @throws SQLException Si ocurre un error al interactuar con la base de datos.
     */
    public static void main(String[] args) throws SQLException {
        // Crear
        boolean creado = crearRegistro("PIR", "Piruleta");
        System.out.println(creado);

        // Actualizar
        boolean actualizado = actualizarRegistro("PIR", "Pirómano");
        System.out.println(actualizado);

        // Eliminar
        boolean borrado = eliminarRegistro("PIR"); // EJEMPLO DE INYECCIÓN DE CÓDIGO SQL
        System.out.println(borrado);

        // Leer
        leerRegistros();
    }
}
