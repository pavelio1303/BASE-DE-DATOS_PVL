package com.stem.WorldAPI.controller;
import java.sql.SQLException;
import java.util.ArrayList;
import com.stem.WorldAPI.model.*;

public class CityController {
    private CityModel MyCityModel = new CityModel();

    public City getCityByName(String CityName) throws SQLException {
        return MyCityModel.getCityByName(CityName);
    }

    public boolean deleteCity(City deletedCity) throws SQLException {
        return MyCityModel.deleteCity(deletedCity);
    }

    public boolean updateCity(City updatedCity) throws SQLException {
        return MyCityModel.updateCity(updatedCity);
    }

    public ArrayList<City> getCityListWithPagination(int pageNumber, int pageSize) throws SQLException{

        return MyCityModel.getCityListWithPagination(pageNumber*pageSize, pageSize);
    }

    public boolean insertCity(City newCity) throws SQLException{
        return MyCityModel.insertCity(newCity);
    }
}
