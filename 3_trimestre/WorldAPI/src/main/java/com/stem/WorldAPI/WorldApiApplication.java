package com.stem.WorldAPI;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;



// La anotación @SpringBootApplication combina tres anotaciones comunes de Spring Boot:
// 1. @Configuration: Indica que esta clase proporciona configuración de beans para el contexto de la aplicación.
// 2. @EnableAutoConfiguration: Permite la configuración automática de Spring Boot basada en las dependencias presentes en el proyecto.
// 3. @ComponentScan: Escanea el paquete actual y sus subpaquetes en busca de componentes de Spring, como controladores y servicios.
@SpringBootApplication
public class WorldApiApplication {

    public static void main(String[] args) {
        // El método estático SpringApplication.run() inicia la aplicación Spring Boot.
        // Toma dos argumentos: la clase principal de la aplicación y los argumentos de la línea de comandos (args).
        SpringApplication.run(WorldApiApplication.class, args);
    }

}

