package com.stem;

import java.sql.*;

public class Main {

    // Datos de conexión a la base de datos
    static String url = "jdbc:mysql://localhost:3306/world";
    static String usuario = "root";
    static String contrasenia = "1234";

    // Método para leer todos los registros de la BBDD
    static void leerRegistros() throws SQLException{
        Connection conexion = DriverManager.getConnection(url, usuario, contrasenia);
        Statement sentencia = conexion.createStatement();

        String consulta = "SELECT * FROM country";

        ResultSet resultado = sentencia.executeQuery(consulta);

        while (resultado.next()){
            String codigo = resultado.getString("CODE");
            String nombre = resultado.getString("NAME");
            Float superficie = resultado.getFloat("SURFACEAREA");
            int anioIndependecia = resultado.getInt("INDEPYEAR");

            System.out.println("El país " + nombre + " con código " 
                                + codigo + " tiene una superficie de " 
                                + superficie + " kilómetros y se independizó en " + anioIndependecia);
        }

        sentencia.close();
        conexion.close();
    }

    static boolean crearRegistro(String codigo, String nombre) throws SQLException{
        Connection conexion = DriverManager.getConnection(url, usuario, contrasenia);
        Statement sentencia = conexion.createStatement();

        String consulta = "INSERT INTO COUNTRY (CODE, NAME) VALUES ('" + codigo + "', '" + nombre + "')";
        System.out.println(consulta);

        int filasAfectadas = sentencia.executeUpdate(consulta);

        sentencia.close();
        conexion.close();

        return filasAfectadas > 0;
    }

    static boolean actualizarRegistro(String codigo, String nombre) throws SQLException{
        Connection conexion = DriverManager.getConnection(url, usuario, contrasenia);
        Statement sentencia = conexion.createStatement();

        String consulta = "UPDATE COUNTRY SET NAME = '" + nombre + "' WHERE CODE = '"+ codigo + "'";
        System.out.println(consulta);

        int filasAfectadas = sentencia.executeUpdate(consulta);

        sentencia.close();
        conexion.close();

        return filasAfectadas > 0;
    }

    static boolean eliminarRegistro(String codigo) throws SQLException{
        Connection conexion = DriverManager.getConnection(url, usuario, contrasenia);
        Statement sentencia = conexion.createStatement();

        String consulta = "DELETE FROM COUNTRY WHERE CODE = '" + codigo + "'";
        System.out.println(consulta);

        int filasAfectadas = sentencia.executeUpdate(consulta);

        sentencia.close();
        conexion.close();

        return filasAfectadas > 0;
    }

    public static void main(String[] args) throws SQLException{
        //crearRegistro("PIL", "Piruleta");

        leerRegistros();

        boolean actualizado = actualizarRegistro("PIL", "Pilinga");
        System.out.println(actualizado);

        boolean borrado = eliminarRegistro("PIL");
        System.out.println(borrado);
    }
}