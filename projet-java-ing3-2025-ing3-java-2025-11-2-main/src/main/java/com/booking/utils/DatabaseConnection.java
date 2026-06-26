package com.booking.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseConnection {

    private static String DB_URL;
    private static String DB_USER;
    private static String DB_PASSWORD;

    static {
        // 1. Try db.properties file next to the JAR
        File configFile = new File("db.properties");
        if (configFile.exists()) {
            Properties props = new Properties();
            try (FileInputStream fis = new FileInputStream(configFile)) {
                props.load(fis);
                DB_URL      = props.getProperty("db.url");
                DB_USER     = props.getProperty("db.user");
                DB_PASSWORD = props.getProperty("db.password");
            } catch (IOException e) {
                System.err.println("Could not read db.properties: " + e.getMessage());
            }
        }
        // 2. Fallback to environment variables (Railway sets MYSQLHOST etc.)
        if (DB_URL == null) {
            String host     = System.getenv("MYSQLHOST");
            String port     = System.getenv("MYSQLPORT");
            String database = System.getenv("MYSQLDATABASE");
            if (host != null && database != null) {
                DB_URL      = "jdbc:mysql://" + host + ":" + (port != null ? port : "3306") + "/" + database
                              + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                DB_USER     = System.getenv("MYSQLUSER");
                DB_PASSWORD = System.getenv("MYSQLPASSWORD");
            }
        }
        // 3. Default local fallback
        if (DB_URL == null) {
            DB_URL      = "jdbc:mysql://localhost:3306/booking_db?createDatabaseIfNotExist=true"
                        + "&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
                        + "&connectTimeout=30000&socketTimeout=30000";
            DB_USER     = "root";
            DB_PASSWORD = "";
        }
    }

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Database connection error: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public static void closeConnection() {
        // connections are closed per-use via try-with-resources in DAOs
    }

    public static boolean testConnection() {
        try (Connection c = getConnection()) {
            return c != null;
        } catch (Exception e) {
            System.err.println("Database connection test failed: " + e.getMessage());
            return false;
        }
    }
}
