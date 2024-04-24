package com.stem.WorldAPI.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

// El controlador RestController es una anotación compuesta que combina la funcionalidad de @Controller y @ResponseBody.
// Esto indica que esta clase es un controlador Spring MVC que maneja las solicitudes HTTP y devuelve los resultados como JSON.
@RestController
// @RequestMapping se utiliza para mapear solicitudes web a métodos de controlador específicos o clases de controlador.
@RequestMapping("/HelloWorld")
public class HelloWorldController {
    
    // Este método maneja las solicitudes GET para la URL "/HelloWorld/".
    @GetMapping("/")
    public String helloWorld(){
        return "Hello World!";
    }

    // Este método maneja las solicitudes GET para la URL "/HelloWorld/{name}".
    @GetMapping("/{name}")
    // @PathVariable se utiliza para vincular el valor de una variable de ruta en la URL a un parámetro de método en el controlador.
    public String helloWorldName(@PathVariable String name){
        return "Hello "+name+"!";
    }

    // Este método maneja las solicitudes GET para la URL "/HelloWorld/sum/{number1}/{number2}".
    @GetMapping("/sum/{number1}/{number2}")
    // @PathVariable se utiliza para vincular el valor de las variables de ruta en la URL a parámetros de método en el controlador.
    public int sum (@PathVariable int number1, @PathVariable int number2){
        return number1+number2;
    }
}
