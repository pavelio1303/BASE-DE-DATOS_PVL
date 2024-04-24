package com.stem.WorldAPI.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
@RequestMapping("/helloworld")
public class HelloWorldController {

    @GetMapping("/")
    public String helloWorld(){
        return "Hello world!";
    }

    @GetMapping("/{name}")
    public String helloWorldName(@PathVariable String name){
        return "Hello "+name+"!";
    }

    @GetMapping("/suma/{num1}/{num2}")
    public String helloWorldSuma(@PathVariable int num1, @PathVariable int num2){
        return "La suma de "+num1+" y "+num2+" es: "+(num1+num2);
    }
}

