package Assignment_08;

import java.sql.*;
import java.util.ArrayList;
import java.util.Scanner;

public class Main {

    public static void createUsersTable(Connection conn) {
        try {
            Statement st = conn.createStatement();
            String query = "CREATE TABLE IF NOT EXISTS User("
                           + "id INT PRIMARY KEY AUTO_INCREMENT, "
                           + "name VARCHAR(50), "
                           + "salary INT)";
            st.executeUpdate(query);
            System.out.println("Table created successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void addUsers(Connection conn, ArrayList<User> users) {
        try {
            PreparedStatement st = conn.prepareStatement("INSERT INTO User (name, salary) VALUES (?, ?);");
            for (User user : users) {
                st.setString(1, user.name);
                st.setInt(2, user.salary);
                st.executeUpdate();
                System.out.println("User: " + user.name + " added successfully.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void displayUsers(Connection conn) {
        try {
            Statement st = conn.createStatement();
            String query = "SELECT * FROM User";
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                int salary = rs.getInt("salary");
                System.out.println("\n-----------------------------");
                System.out.println("ID: " + id);
                System.out.println("Name: " + name);
                System.out.println("Salary: " + salary);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String args[]) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Assignment 08");
        System.out.println("MySQL Database Connectivity using JDBC");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("\nDriver Loaded Successfully");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        String url = "jdbc:mysql://localhost:3306/jdbc_connectivity";

        try (Connection conn = DriverManager.getConnection(url, "root", "Amey1234")) {
            System.out.println("\nConnected to Database Successfully");

            while (true) {
                System.out.println("\n--- Menu ---");
                System.out.println("1. Create Users Table");
                System.out.println("2. Add Users");
                System.out.println("3. Display Users");
                System.out.println("4. Exit");
                System.out.print("Enter your choice: ");
                int choice = scanner.nextInt();
                scanner.nextLine(); // Consume newline

                switch (choice) {
                    case 1:
                        createUsersTable(conn);
                        break;

                    case 2:
                        ArrayList<User> users = new ArrayList<>();
                        System.out.print("Enter number of users to add: ");
                        int numUsers = scanner.nextInt();
                        scanner.nextLine();
                        for (int i = 0; i < numUsers; i++) {
                            System.out.print("Enter name for user " + (i + 1) + ": ");
                            String name = scanner.nextLine();
                            System.out.print("Enter salary for user " + (i + 1) + ": ");
                            int salary = scanner.nextInt();
                            scanner.nextLine();
                            users.add(new User(name, salary));
                        }
                        addUsers(conn, users);
                        break;

                    case 3:
                        displayUsers(conn);
                        break;

                    case 4:
                        System.out.println("Exiting...");
                        scanner.close();
                        return;

                    default:
                        System.out.println("Invalid choice. Please try again.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

		scanner.close();
    }
}
