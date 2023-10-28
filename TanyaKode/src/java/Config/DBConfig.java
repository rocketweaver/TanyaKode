/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Config;

import com.mysql.jdbc.Driver;
import java.sql.DriverManager;
import java.sql.Connection;

/**
 *
 * @author Arbhy Adityabrahma
 */
public class DBConfig {
    public static Connection open() {
        Connection con;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost/tanyakode";
            con = DriverManager.getConnection(url, "root", "");
            System.out.println("Connected");
            
            return con;
        } catch (Exception e) {
            System.err.println(e);
            
            return null;
        }
    }
}
