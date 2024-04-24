package com.stem.WorldAPI.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class CountryModel {
    private MyConnection myConnection = new MyConnection();

    private ArrayList<Country> resultSetToArrayList(ResultSet inputResultSet) throws SQLException{
        ArrayList<Country> countryList = new ArrayList<Country>();
        
        while (inputResultSet.next()) {
            String code = inputResultSet.getString("CODE");
            String name = inputResultSet.getString("NAME");
            int population = inputResultSet.getInt("POPULATION");

            Country country = new Country(code, name, population);

            countryList.add(country);
        }

        return countryList;
    }

    public Country getCountryByCode(String countryCode) throws SQLException {

        Country country = new Country();

        String query = "SELECT * FROM COUNTRY WHERE CODE = ?";
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        statement.setString(1, countryCode);
        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            String code = resultSet.getString("CODE");
            String name = resultSet.getString("NAME");
            int population = resultSet.getInt("POPULATION");

            country = new Country(code, name, population);
        }

        statement.close();
        myConnection.disconnect();

        return country;

    }

    public ArrayList<Country> getCountryList() throws SQLException {

        Statement statement = myConnection.connect().createStatement();

        String query = "SELECT * FROM COUNTRY";
        ResultSet resultSet = statement.executeQuery(query);

        ArrayList<Country> resultCountryList = resultSetToArrayList(resultSet);

        statement.close();
        myConnection.disconnect();

        return resultCountryList;
    }

    public ArrayList<Country> getCountryListWithPagination(int initialRow, int numberOfRows) throws SQLException {

        String query = "SELECT * FROM COUNTRY LIMIT ?, ?";
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        statement.setInt(1, initialRow);
        statement.setInt(2, numberOfRows);
        
        ResultSet resultSet = statement.executeQuery();

        ArrayList<Country> resultCountryList = resultSetToArrayList(resultSet);

        statement.close();
        myConnection.disconnect();

        return resultCountryList;
    }

    private boolean deleteCountryByCode(String countryCode) throws SQLException {

        CityModel MyCityModel = new CityModel();
        MyCityModel.deleteCitiesFromCountry(countryCode);

        LanguageModel MyLanguageModel = new LanguageModel();
        MyLanguageModel.deleteLanguagesFromCountry(countryCode);
        
        String query = "DELETE FROM COUNTRY WHERE CODE = ?";
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        statement.setString(1, countryCode);

        int affectedrRows = statement.executeUpdate();

        statement.close();
        myConnection.disconnect();

        return affectedrRows > 0;
    }

    public boolean updateCountry(Country updatedCountry) throws SQLException{

        String query = "UPDATE COUNTRY "
                      +"SET NAME = ?, POPULATION = ? "
                      +"WHERE CODE = ? ";
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        statement.setString(1, updatedCountry.getName());
        statement.setFloat(2, updatedCountry.getPopulation());
        statement.setString(3, updatedCountry.getCode());

        int affectedrRows = statement.executeUpdate();

        statement.close();
        myConnection.disconnect();

        return affectedrRows > 0;
    }

    public boolean deleteCountry(Country deletedCountry) throws SQLException{
        return deleteCountryByCode(deletedCountry.getCode());
    }

}
