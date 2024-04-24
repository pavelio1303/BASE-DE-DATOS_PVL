package com.stem.WorldAPI.model;

public class City {
    
    private int ID;
    private String name;
    private String district;
    private int population;
    private Country country;
    
    public City() {
    }

    public City(int ID, String name, String district, int population, Country country) {
        this.ID = ID;
        this.name = name;
        this.district = district;
        this.population = population;
        this.country = country;
    }

    public int getID() {
        return ID;
    }

    public void setID(int iD) {
        ID = iD;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public int getPopulation() {
        return population;
    }

    public void setPopulation(int population) {
        this.population = population;
    }

    public Country getCountry() {
        return country;
    }

    public void setCountry(Country country) {
        this.country = country;
    }

    @Override
    public String toString() {
        return "City [ID=" + ID + ", name=" + name + ", district=" + district + ", population=" + population
                + ", country=" + country + "]";
    }

}
