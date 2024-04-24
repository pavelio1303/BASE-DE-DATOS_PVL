package com.stem.WorldAPI.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import org.springframework.web.bind.annotation.*;
import com.stem.WorldAPI.model.*;

// El controlador RestController es una anotación compuesta que combina la funcionalidad de @Controller y @ResponseBody.
// Esto indica que esta clase es un controlador Spring MVC que maneja las solicitudes HTTP y devuelve los resultados como JSON.
@RestController
@RequestMapping("/country")
public class CountryController {

    // Se crea una instancia de CountryModel para acceder a los métodos relacionados con la lógica del país.
    private CountryModel MyCountryModel = new CountryModel();

    // Este método maneja las solicitudes GET para obtener un país por su código de país.
    @GetMapping("/{countryCode}")
    // @GetMapping indica que este método maneja solicitudes HTTP GET a la URL "/country/{countryCode}".
    // @PathVariable se utiliza para vincular el valor de una variable de ruta en la URL a un parámetro de método en el controlador.
    public Country getCountryByCode(@PathVariable String countryCode) throws SQLException {
        // Llama al método getCountryByCode() de MyCountryModel para obtener el país por su código.
        return MyCountryModel.getCountryByCode(countryCode);
    }

    // Este método maneja las solicitudes GET para obtener una lista de países.
    @GetMapping
    // @GetMapping indica que este método maneja solicitudes HTTP GET a la URL "/country/".
    public ArrayList<Country> getCountryList() throws SQLException {
        // Llama al método getCountryList() de MyCountryModel para obtener la lista de países.
        return MyCountryModel.getCountryList();
    }

    // Método para eliminar un país.
    @DeleteMapping
    public boolean deleteCountry(@RequestBody Country deletedCountry) throws SQLException {
        // Llama al método deleteCountry() de MyCountryModel para eliminar el país especificado.
        return MyCountryModel.deleteCountry(deletedCountry);
    }

    // Método para actualizar un país.
    @PutMapping
    public boolean updateCountry(@RequestBody Country updatedCountry) throws SQLException {
        // Llama al método updateCountry() de MyCountryModel para actualizar el país especificado.
        return MyCountryModel.updateCountry(updatedCountry);
    }

    // Método para obtener una lista paginada de países.
    @GetMapping("/{pageNumber}/{pageSize}")
    // @GetMapping indica que este método maneja solicitudes HTTP GET a la URL "/country/{pageNumber}/{pageSize}".
    // @PathVariable se utiliza para vincular el valor de las variables de ruta en la URL a parámetros de método en el controlador.
    public ArrayList<Country> getCountryListWithPagination(@PathVariable int pageNumber, @PathVariable int pageSize) throws SQLException{
        // Llama al método getCountryListWithPagination() de MyCountryModel para obtener una lista paginada de países.
        return MyCountryModel.getCountryListWithPagination(pageNumber*pageSize, pageSize);
    }

    @GetMapping
    public 
}
