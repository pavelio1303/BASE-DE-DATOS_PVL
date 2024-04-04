package com.stem;

import java.sql.SQLException;

import com.stem.view.WorldView;

public class Main {
    public static void main(String[] args) throws SQLException {
       
        WorldView MyWorldView = new WorldView();

        MyWorldView.start();
    }
}