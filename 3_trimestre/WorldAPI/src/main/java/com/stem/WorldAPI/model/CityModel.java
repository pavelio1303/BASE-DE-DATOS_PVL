package com.stem.WorldAPI.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CityModel {
    private CountryModel myCountryModel = new CountryModel();
    private MyConnection myConnection = new MyConnection();

    private ArrayList<City> resultSetToArrayList(ResultSet inputResultSet) throws SQLException{
        ArrayList<City> cityList = new ArrayList<City>();
        
        while (inputResultSet.next()) {
            int ID = inputResultSet.getInt("ID");
            String name = inputResultSet.getString("NAME");
            String district = inputResultSet.getString("DISTRICT");
            int population = inputResultSet.getInt("POPULATION");

            String countryCode = inputResultSet.getString("COUNTRYCODE");
            Country country = myCountryModel.getCountryByCode(countryCode);

            City city = new City(ID, name, district, population, country);

            cityList.add(city);
        }

        return cityList;
    }

    public City getCityByName(String cityName) throws SQLException {

        City city = new City();

        String query = "SELECT * FROM CITY WHERE NAME = ?";
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        statement.setString(1, cityName);
        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            int ID = resultSet.getInt("ID");
            String name = resultSet.getString("NAME");
            String district = resultSet.getString("DISTRICT");
            int population = resultSet.getInt("POPULATION");

            String countryCode = resultSet.getString("COUNTRYCODE");
            Country country = myCountryModel.getCountryByCode(countryCode);

            city = new City(ID, name, district, population, country);
        }

        statement.close();
        myConnection.disconnect();

        return city;

    }

    public ArrayList<City> getCityListWithPagination(int initialRow, int numberOfRows) throws SQLException {

        String query = "SELECT * FROM CITY LIMIT ?, ?";
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        statement.setInt(1, initialRow);
        statement.setInt(2, numberOfRows);
        
        ResultSet resultSet = statement.executeQuery();

        ArrayList<City> resultCityList = resultSetToArrayList(resultSet);

        statement.close();
        myConnection.disconnect();

        return resultCityList;
    }

    public boolean deleteCitiesFromCountry(String countryCode) throws SQLException {
        
        String query = "DELETE FROM CITY WHERE COUNTRYCODE = ?";
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        statement.setString(1, countryCode);

        int affectedrRows = statement.executeUpdate();

        statement.close();
        myConnection.disconnect();

        return affectedrRows > 0;
    }

    public boolean deleteCity(City deletedCity) throws SQLException {
      
        String query = "DELETE FROM CITY WHERE NAME = ?";
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        statement.setString(1, deletedCity.getName());

        int affectedrRows = statement.executeUpdate();

        statement.close();
        myConnection.disconnect();

        return affectedrRows > 0;
    }

    public boolean updateCity(City updatedCity) throws SQLException{

        String query = "UPDATE CITY "
                      +"SET NAME = ?," 
                      +"POPULATION = ?,"
                      +"DISTRICT = ?,"
                      +"COUNTRYCODE = ?"
                      +" WHERE NAME = ?";
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        statement.setString(1, updatedCity.getName());
        statement.setInt(2, updatedCity.getPopulation());
        statement.setString(3, updatedCity.getDistrict());
        statement.setString(4, updatedCity.getCountry().getCode());
        statement.setString(5, updatedCity.getName());

        int affectedrRows = statement.executeUpdate();

        statement.close();
        myConnection.disconnect();

        return affectedrRows > 0;
    }

    public boolean insertCity(City newCity) throws SQLException{
        String query = "INSERT INTO CITY (NAME, DISTRICT, POPULATION, COUNTRYCODE) "
                      +"VALUES (?, ?, ?, ?)";
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        statement.setString(1, newCity.getName());
        statement.setString(2, newCity.getDistrict());
        statement.setInt(3, newCity.getPopulation());
        statement.setString(4, newCity.getCountry().getCode());

        int affectedrRows = statement.executeUpdate();

        statement.close();
        myConnection.disconnect();

        return affectedrRows > 0;
    }

    
}
