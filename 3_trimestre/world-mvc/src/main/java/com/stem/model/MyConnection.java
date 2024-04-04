package com.stem.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyConnection {
    private String host;
    private int port;
    private String database;
    private String user;
    private String pass;

    private Connection MyConnection;

    public MyConnection(){
        this.host = "localhost";
        this.port = 3306;
        this.database = "world";
        this.user = "root";
        this.pass = "1234";
    }

    public MyConnection(String host, int port, String database, String user, String pass) {
        this.host = host;
        this.port = port;
        this.database = database;
        this.user = user;
        this.pass = pass;
    }

    public Connection connect() throws SQLException{
        String url = "jdbc:mysql://"+this.host+":"+this.port+"/"+this.database;
        this.MyConnection = DriverManager.getConnection(url, this.user, this.pass);
        return this.MyConnection;
    }

    public void disconnect() throws SQLException{
        this.MyConnection.close();
    }

}
