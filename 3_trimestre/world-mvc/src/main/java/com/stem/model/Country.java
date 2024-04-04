package com.stem.model;

public class Country {
    private String code;
    private String name;
    private float population;

    public Country() {

    }

    public Country(String code, String name, float population) {
        this.code = code;
        this.name = name;
        this.population = population;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getPopulation() {
        return population;
    }

    public void setPopulation(float population) {
        this.population = population;
    }

    @Override
    public String toString() {
        return "Country [code=" + code + ", name=" + name + ", population=" + population + "]";
    }
    
}
