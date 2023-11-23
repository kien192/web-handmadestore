package model.db;

import java.io.IOException;
import java.util.Properties;

public class DBProperties {
    private static Properties prop = new Properties();

    static {
        try {
            prop.load(DBProperties.class.getClassLoader().getResourceAsStream("DB.properties"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String host = prop.getProperty("db.host");
    public static String port = prop.getProperty("db.port");
    public static String username = prop.getProperty("db.username");
    public static String password = prop.getProperty("db.pass");
    public static String dbname = prop.getProperty("db.name");

}
