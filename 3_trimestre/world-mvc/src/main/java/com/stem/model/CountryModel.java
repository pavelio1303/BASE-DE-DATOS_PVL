package com.stem.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class CountryModel {
    private MyConnection myConnection = new MyConnection();

    public Country getCountryByCode(String countryCode) throws SQLException {

        Country country = new Country();

        String query = "SELECT * FROM COUNTRY WHERE CODE = ?";
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        statement.setString(1, countryCode);
        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            String code = resultSet.getString("CODE");
            String name = resultSet.getString("NAME");
            float population = resultSet.getFloat("POPULATION");

            country = new Country(code, name, population);
        }

        statement.close();
        myConnection.disconnect();

        return country;

    }

    public ArrayList<Country> getCountryList() throws SQLException {

        ArrayList<Country> countryList = new ArrayList<Country>();

        Statement statement = myConnection.connect().createStatement();

        String consulta = "SELECT * FROM COUNTRY";
        ResultSet resultSet = statement.executeQuery(consulta);

        while (resultSet.next()) {
            String code = resultSet.getString("CODE");
            String name = resultSet.getString("NAME");
            float population = resultSet.getFloat("POPULATION");

            Country country = new Country(code, name, population);

            countryList.add(country);
        }

        statement.close();
        myConnection.disconnect();

        return countryList;
    }

    public boolean deleteCountryByCode(String codigo) throws SQLException {
    
        PreparedStatement sentencia = myConnection.connect().prepareStatement("DELETE FROM COUNTRY WHERE CODE = ?");
        sentencia.setString(1,codigo);

        int filasAfectadas = sentencia.executeUpdate();

        sentencia.close();
        myConnection.disconnect();

        return filasAfectadas > 0;
    }

}
