package com.stem.WorldAPI.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 * Clase que maneja las operaciones relacionadas con el modelo de país en la
 * base de datos.
 */
public class CountryModel {
    private MyConnection myConnection = new MyConnection();

    /**
     * Convierte un objeto ResultSet a una lista de objetos Country.
     * 
     * @param inputResultSet El ResultSet a convertir.
     * @return Una lista de objetos Country.
     * @throws SQLException Si ocurre un error al acceder al ResultSet.
     */
    private ArrayList<Country> resultSetToArrayList(ResultSet inputResultSet) throws SQLException {
        // ResultSet es un objeto proporcionado por JDBC que representa un conjunto de
        // resultados de una consulta SQL. Contiene los datos recuperados de la base de
        // datos después de ejecutar una consulta.

        // Se crea una nueva lista para almacenar los objetos Country.
        ArrayList<Country> countryList = new ArrayList<Country>();

        // Itera sobre cada fila del ResultSet.
        // El método next() de ResultSet es utilizado para avanzar al siguiente registro
        // en el conjunto de resultados. Devuelve true si hay más filas disponibles para
        // procesar y false si no hay más filas.
        while (inputResultSet.next()) {
            // Obtiene el valor de la columna "CODE" de la fila actual y lo guarda en la
            // variable code.
            String code = inputResultSet.getString("CODE");
            // Obtiene el valor de la columna "NAME" de la fila actual y lo guarda en la
            // variable name.
            String name = inputResultSet.getString("NAME");
            // Obtiene el valor de la columna "POPULATION" de la fila actual y lo guarda en
            // la variable population.
            int population = inputResultSet.getInt("POPULATION");

            // Crea un nuevo objeto Country con los valores obtenidos de la fila actual del
            // ResultSet.
            Country country = new Country(code, name, population);

            // Agrega el objeto Country recién creado a la lista countryList.
            countryList.add(country);
        }

        // Retorna la lista que contiene todos los objetos Country creados.
        return countryList;
    }

    /**
     * Obtiene un país por su código.
     * 
     * @param countryCode El código del país a buscar.
     * @return El objeto Country correspondiente al código proporcionado.
     * @throws SQLException Si ocurre un error al ejecutar la consulta SQL.
     */
    public Country getCountryByCode(String countryCode) throws SQLException {
        // Se crea un objeto Country para almacenar el país.
        Country country = new Country();

        // Se prepara la consulta SQL para obtener el país por su código.
        String query = "SELECT * FROM COUNTRY WHERE CODE = ?";
        // Se prepara una declaración PreparedStatement para ejecutar la consulta.

        // PreparedStatement es una interfaz en Java que representa una declaración SQL
        // precompilada. Se utiliza para ejecutar consultas SQL parametrizadas en bases
        // de datos relacionales. La principal ventaja de utilizar PreparedStatement
        // sobre Statement es que permite la reutilización de consultas SQL con
        // parámetros variables, lo que mejora el rendimiento y la seguridad al evitar
        // la inyección de SQL.
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        // Se establece el parámetro del código del país en la consulta.
        statement.setString(1, countryCode);
        // Se ejecuta la consulta y se obtiene un ResultSet que contiene los resultados.
        ResultSet resultSet = statement.executeQuery();

        // Se verifica si hay al menos una fila en el ResultSet.
        if (resultSet.next()) {
            // Se obtienen los valores de las columnas "CODE", "NAME" y "POPULATION" de la
            // fila actual del ResultSet.
            String code = resultSet.getString("CODE");
            String name = resultSet.getString("NAME");
            int population = resultSet.getInt("POPULATION");

            // Se crea un nuevo objeto Country con los valores obtenidos.
            country = new Country(code, name, population);
        }

        // Se cierra la declaración y se desconecta de la base de datos.
        statement.close();
        myConnection.disconnect();

        // Se devuelve el objeto Country, que puede estar vacío si no se encontraron
        // resultados.
        return country;
    }

    /**
     * Obtiene una lista de todos los países.
     * 
     * @return Una lista de objetos Country que representan todos los países en la
     *         base de datos.
     * @throws SQLException Si ocurre un error al ejecutar la consulta SQL.
     */
    public ArrayList<Country> getCountryList() throws SQLException {
        // Se crea un objeto Statement para ejecutar la consulta SQL.
        Statement statement = myConnection.connect().createStatement();

        // Se define la consulta SQL para obtener todos los países de la tabla COUNTRY.
        String query = "SELECT * FROM COUNTRY";

        // Se ejecuta la consulta SQL y se obtiene un objeto ResultSet que contiene los
        // resultados.
        ResultSet resultSet = statement.executeQuery(query);

        // Se llama al método resultSetToArrayList para convertir el ResultSet en una
        // lista de objetos Country.
        ArrayList<Country> resultCountryList = resultSetToArrayList(resultSet);

        // Se cierra el objeto Statement para liberar recursos.
        statement.close();

        // Se desconecta de la base de datos para liberar la conexión.
        myConnection.disconnect();

        // Se devuelve la lista que contiene todos los objetos Country creados.
        return resultCountryList;
    }

    /**
     * Obtiene una lista paginada de países.
     * 
     * @param initialRow   El índice inicial de la fila.
     * @param numberOfRows El número de filas para recuperar.
     * @return Una lista paginada de objetos Country.
     * @throws SQLException Si ocurre un error al ejecutar la consulta SQL.
     */
    public ArrayList<Country> getCountryListWithPagination(int initialRow, int numberOfRows) throws SQLException {
        // Se define la consulta SQL para obtener una lista paginada de países.
        String query = "SELECT * FROM COUNTRY LIMIT ?, ?";

        // Se prepara una declaración PreparedStatement para ejecutar la consulta SQL.
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        // Se establecen los parámetros de la consulta SQL utilizando los valores
        // proporcionados.
        statement.setInt(1, initialRow); // El índice inicial de la fila.
        statement.setInt(2, numberOfRows); // El número de filas a recuperar.

        // Se ejecuta la consulta SQL y se obtiene un objeto ResultSet que contiene los
        // resultados.
        ResultSet resultSet = statement.executeQuery();

        // Se llama al método resultSetToArrayList para convertir el ResultSet en una
        // lista de objetos Country.
        ArrayList<Country> resultCountryList = resultSetToArrayList(resultSet);

        // Se cierra el objeto PreparedStatement para liberar recursos.
        statement.close();

        // Se desconecta de la base de datos para liberar la conexión.
        myConnection.disconnect();

        // Se devuelve la lista que contiene todos los objetos Country creados.
        return resultCountryList;
    }

    /**
     * Elimina un país por su código, junto con sus ciudades y lenguajes asociados.
     * 
     * @param countryCode El código del país a eliminar.
     * @return true si se eliminó correctamente, false de lo contrario.
     * @throws SQLException Si ocurre un error al ejecutar la consulta SQL.
     */
    private boolean deleteCountryByCode(String countryCode) throws SQLException {
        // Se instancia un objeto CityModel para eliminar ciudades asociadas al país.
        CityModel MyCityModel = new CityModel();
        MyCityModel.deleteCitiesFromCountry(countryCode);

        // Se instancia un objeto LanguageModel para eliminar idiomas asociados al país.
        LanguageModel MyLanguageModel = new LanguageModel();
        MyLanguageModel.deleteLanguagesFromCountry(countryCode);

        // Se define la consulta SQL para eliminar el país por su código.
        String query = "DELETE FROM COUNTRY WHERE CODE = ?";
        // Se prepara una declaración PreparedStatement para ejecutar la consulta SQL.
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        // Se establece el parámetro del código del país en la consulta.
        statement.setString(1, countryCode);

        // Se ejecuta la consulta SQL y se obtiene el número de filas afectadas.
        int affectedRows = statement.executeUpdate();

        // Se cierra la declaración para liberar recursos.
        statement.close();

        // Se desconecta de la base de datos para liberar la conexión.
        myConnection.disconnect();

        // Se devuelve true si al menos una fila fue eliminada, false de lo contrario.
        return affectedRows > 0;
    }

    /**
     * Actualiza la información de un país en la base de datos.
     * 
     * @param updatedCountry El objeto Country actualizado.
     * @return true si se actualizó correctamente, false de lo contrario.
     * @throws SQLException Si ocurre un error al ejecutar la consulta SQL.
     */
    public boolean updateCountry(Country updatedCountry) throws SQLException {
        // Se define la consulta SQL para actualizar el país con los nuevos datos.
        String query = "UPDATE COUNTRY "
                + "SET NAME = ?, POPULATION = ? "
                + "WHERE CODE = ? ";
        // Se prepara una declaración PreparedStatement para ejecutar la consulta SQL.
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        // Se establecen los parámetros de la consulta SQL con los nuevos datos del
        // país.
        statement.setString(1, updatedCountry.getName()); // Nuevo nombre del país.
        statement.setInt(2, updatedCountry.getPopulation()); // Nueva población del país.
        statement.setString(3, updatedCountry.getCode()); // Código del país que se va a actualizar.

        // Se ejecuta la consulta SQL y se obtiene el número de filas afectadas.
        int affectedRows = statement.executeUpdate();

        // Se cierra la declaración para liberar recursos.
        statement.close();

        // Se desconecta de la base de datos para liberar la conexión.
        myConnection.disconnect();

        // Se devuelve true si al menos una fila fue actualizada, false de lo contrario.
        return affectedRows > 0;
    }

    /**
     * Elimina un país de la base de datos.
     * 
     * @param deletedCountry El objeto Country a eliminar.
     * @return true si se eliminó correctamente, false de lo contrario.
     * @throws SQLException Si ocurre un error al ejecutar la consulta SQL.
     */
    public boolean deleteCountry(Country deletedCountry) throws SQLException {
        // Se llama al método deleteCountryByCode pasando el código del país que se va a
        // eliminar.
        return deleteCountryByCode(deletedCountry.getCode());
    }

}