package com.stem.WorldAPI.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import com.stem.WorldAPI.model.*;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@RestController
@RequestMapping("/country")
public class CountryController {

    private CountryModel MyCountryModel = new CountryModel();

    @GetMapping("/{countryCode}")
    @ResponseBody
    public Country getCountryByCode(@PathVariable String countryCode) throws SQLException {
        return MyCountryModel.getCountryByCode(countryCode);
    }

    @GetMapping("/")
    @ResponseBody
    public ArrayList<Country> getCountryList() throws SQLException {
        return MyCountryModel.getCountryList();
    }

    public boolean deleteCountry(Country deletedCountry) throws SQLException {
        return MyCountryModel.deleteCountry(deletedCountry);
    }

    public boolean updateCountry(Country updatedCountry) throws SQLException {
        return MyCountryModel.updateCountry(updatedCountry);
    }

    @GetMapping("/countryPagination/{pageNumber}/{pageSize}")
    @ResponseBody
    public ArrayList<Country> getCountryListWithPagination(@PathVariable int pageNumber, @PathVariable int pageSize) throws SQLException{

        return MyCountryModel.getCountryListWithPagination(pageNumber*pageSize, pageSize);
    }
    
}
