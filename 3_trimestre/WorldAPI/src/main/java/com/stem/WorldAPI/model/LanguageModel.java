package com.stem.WorldAPI.model;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class LanguageModel {
    private MyConnection myConnection = new MyConnection();

    public boolean deleteLanguagesFromCountry(String countryCode) throws SQLException {
        
        String query = "DELETE FROM COUNTRYLANGUAGE WHERE COUNTRYCODE = ?";
        PreparedStatement statement = myConnection.connect().prepareStatement(query);

        statement.setString(1, countryCode);

        int affectedrRows = statement.executeUpdate();

        statement.close();
        myConnection.disconnect();

        return affectedrRows > 0;
    }
}
