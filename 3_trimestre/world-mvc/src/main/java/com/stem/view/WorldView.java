package com.stem.view;

import java.sql.SQLException;
import java.util.Scanner;

import com.stem.controller.CountryController;
import com.stem.model.Country;

public class WorldView {

    private CountryController MyCountryController = new CountryController();

    public String input(){
        Scanner sc = new Scanner(System.in);
        return sc.nextLine();
    }

    public void start() throws SQLException{
        System.out.println("¿Que desea hacer? ¿Visualizar o eliminar un país?");
        String respuesta = input();

        if (respuesta.equals("visualizar")){
            System.out.println("Inserte el código de un país que quieras visualizar:");
            String countryCode = input();

            Country searchedCountry = MyCountryController.getCountryByCode(countryCode);

            System.out.println(searchedCountry);

        }else if(respuesta.equals("eliminar")){
            System.out.println("Inserte el código de un país que quieras eliminar:");
            String countryCode = input(); 

            boolean obliteratedCountry = MyCountryController.deleteCountryByCode(countryCode);

            System.out.println(obliteratedCountry);
        }       
    } 
}
