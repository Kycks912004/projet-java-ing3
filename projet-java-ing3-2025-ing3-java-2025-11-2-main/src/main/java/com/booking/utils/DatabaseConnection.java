package com.booking.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class DatabaseConnection {

    private static final String SQLITE_DB_FILE = "booking.db";
    private static String DB_URL;
    private static String DB_USER;
    private static String DB_PASSWORD;
    private static boolean usingSQLite = false;

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
        // 2. Try environment variables (Railway / any cloud host)
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
        // 3. Try local MySQL (localhost) with short timeout
        if (DB_URL == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection test = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/booking_db?createDatabaseIfNotExist=true"
                    + "&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
                    + "&connectTimeout=3000", "root", "");
                test.close();
                DB_URL      = "jdbc:mysql://localhost:3306/booking_db?createDatabaseIfNotExist=true"
                            + "&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                DB_USER     = "root";
                DB_PASSWORD = "";
            } catch (Exception ignored) {
                // MySQL not available — fall through to SQLite
            }
        }
        // 4. Embedded SQLite — always works, no setup required
        if (DB_URL == null) {
            usingSQLite = true;
            DB_URL      = "jdbc:sqlite:" + SQLITE_DB_FILE;
            DB_USER     = null;
            DB_PASSWORD = null;
            System.out.println("[DB] Using embedded SQLite database: " + SQLITE_DB_FILE);
            initSQLiteSchema();
        }
    }

    private static void initSQLiteSchema() {
        try {
            Class.forName("org.sqlite.JDBC");
            try (Connection conn = DriverManager.getConnection(DB_URL);
                 Statement stmt = conn.createStatement()) {

                stmt.execute("PRAGMA foreign_keys = ON");

                // Skip if already initialized
                boolean exists = conn.getMetaData()
                        .getTables(null, null, "users", null).next();
                if (exists) return;

                InputStream is = DatabaseConnection.class
                        .getResourceAsStream("/db/booking_sqlite.sql");
                if (is == null) {
                    System.err.println("[DB] booking_sqlite.sql not found in resources");
                    return;
                }
                StringBuilder sb = new StringBuilder();
                try (BufferedReader reader = new BufferedReader(
                        new InputStreamReader(is, StandardCharsets.UTF_8))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        String trimmed = line.trim();
                        if (trimmed.startsWith("--") || trimmed.isEmpty()) continue;
                        sb.append(line).append("\n");
                    }
                }
                for (String sql : sb.toString().split(";")) {
                    String s = sql.trim();
                    if (!s.isEmpty()) {
                        try { stmt.execute(s); }
                        catch (SQLException e) {
                            System.err.println("[DB] SQL warning: " + e.getMessage());
                        }
                    }
                }
                System.out.println("[DB] SQLite database initialized with sample data.");
            }
        } catch (Exception e) {
            System.err.println("[DB] Failed to initialize SQLite: " + e.getMessage());
        }
    }

    public static Connection getConnection() {
        try {
            if (usingSQLite) {
                Class.forName("org.sqlite.JDBC");
                Connection conn = DriverManager.getConnection(DB_URL);
                conn.createStatement().execute("PRAGMA foreign_keys = ON");
                return conn;
            } else {
                Class.forName("com.mysql.cj.jdbc.Driver");
                return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            }
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

    public static boolean isUsingSQLite() {
        return usingSQLite;
    }
}
