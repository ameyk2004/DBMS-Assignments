package Assignment_08;

import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Main {
	
	public static void main(String args[]) {
		System.out.println("Welcome to Java to MySql Connectivity using JDBC");
		
		String URL = "jdbc:mysql://localhost:3306/jdbc_connectivity";
		String USERNAME = "root";
		String PASSWORD = "Amey1234";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("JDBC Driver Loaded");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		try {
			Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			System.out.println("Connected to MySQL Succesfully");
			
			
			Statement statement = conn.createStatement();
			ResultSet resultSet = statement.executeQuery("SELECT * FROM Students");
			
			while (resultSet.next()) {
                // Retrieve data from result set using the column names
                System.out.println("ID: " + resultSet.getInt("id"));
                System.out.println("Name: " + resultSet.getString("name"));
                System.out.println("Age: " + resultSet.getInt("age"));
                System.out.println("CGPA: " + resultSet.getFloat("CGPA"));
                System.out.println("Date of Birth: " + resultSet.getDate("dob"));
                System.out.println("Date of Joining: " + resultSet.getDate("date_of_joining"));
                System.out.println("Semester: " + resultSet.getInt("semester"));
                System.out.println("-------------------------------");
            }
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
			
	}

}
