package com.stem.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.stem.model.Country;
import com.stem.model.CountryModel;


public class CountryController {

    private CountryModel MyCountryModel = new CountryModel();

    public Country getCountryByCode(String countryCode) throws SQLException {
        return MyCountryModel.getCountryByCode(countryCode);
    }

    public ArrayList<Country> getCountryList() throws SQLException {
        return MyCountryModel.getCountryList();
    }

    public boolean deleteCountryByCode(String countryCode) throws SQLException {
        return MyCountryModel.deleteCountryByCode(countryCode);
    }
    
}
