# JDBC Connection and SQL Execution in Java

## Prerequisites

Ensure you have:
1. **MySQL Database** installed and running.
2. **JDBC Driver** for MySQL. You can download it from [MySQL Connector/J](https://dev.mysql.com/downloads/connector/j/).
3. **Eclipse IDE** (or any other Java IDE).

## Steps to Connect Eclipse IDE with MySQL using JDBC

### 1. Setting up the JDBC Driver in Eclipse
1. Download the MySQL JDBC driver (`mysql-connector-java-x.x.x.jar`).
2. In Eclipse:
   - Right-click on your project.
   - Go to **Build Path** > **Configure Build Path**.
   - Click on **Add External JARs**.
   - Select the downloaded MySQL JDBC driver `.jar` file.
   - Click **Apply and Close**.

### 2. Writing Code to Connect Java and MySQL

### Key Components and Concepts in JDBC

1. **Loading the JDBC Driver with `Class.forName`**: 
   ```java
   Class.forName("com.mysql.cj.jdbc.Driver");
   ```
   - **Purpose**: This line loads the MySQL JDBC driver into memory so that Java can use it to connect to the MySQL database.
   - **Why Driver is Needed**: JDBC drivers act as an intermediary that translates Java calls into database-specific commands.
   - **Why `com.mysql.cj.jdbc.Driver`**: This driver is specific to MySQL databases and provides the necessary implementation to communicate with MySQL.

2. **Exception Handling**:
   - It is essential to handle exceptions to manage runtime errors that might occur during database operations, such as connection failures or SQL syntax errors.

3. **JDBC Connection URL**:
   ```java
   String connection_url = "jdbc:mysql://localhost:3306/07_jdbc_connectivity";
   ```
   - **Structure**: The URL format is `jdbc:mysql://<host>:<port>/<database>`.
   - **Components**:
     - **jdbc:mysql**: Specifies the JDBC protocol and MySQL as the database.
     - **host**: The hostname of the database server, here `localhost`.
     - **port**: The port number MySQL listens to (default is `3306`).
     - **database name**: The name of the database you want to connect to (`07_jdbc_connectivity`).
   - **Username and Password**: Required for authentication to connect to the database.
     ```java
     String username = "your_username";
     String password = "your_password";
     ```

4. **Establishing a Connection**:
   ```java
   Connection conn = DriverManager.getConnection(connection_url, username, password);
   ```
   - **DriverManager.getConnection**: This method establishes a connection to the database using the URL, username, and password.
   - **Connection Object**: Represents a session with the database and is used to execute queries.

## Executing SQL Queries

### 1. Creating a Statement vs. Prepared Statement

- **Statement**:
  ```java
  Statement stmt = conn.createStatement();
  ```
  - Used for executing simple SQL statements without parameters.
  - Vulnerable to **SQL Injection** attacks, as SQL queries can be manipulated if user input is directly appended to the query.

- **PreparedStatement**:
  ```java
  PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
  ```
  - Used for SQL queries with parameters.
  - **SQL Injection Protection**: SQL Injection is a security vulnerability where attackers inject malicious SQL code into a query, potentially causing unintended behavior or data breaches. Prepared statements prevent SQL Injection by treating inputs as separate parameters, which are safely escaped by the driver.

### 2. Types of SQL Execution Methods

- **executeQuery**:
  ```java
  ResultSet rs = stmt.executeQuery();
  ```
  - Used for executing `SELECT` statements.
  - Returns a **ResultSet** containing the data retrieved from the database.

- **executeUpdate**:
  ```java
  int rowsAffected = stmt.executeUpdate();
  ```
  - Used for `INSERT`, `UPDATE`, and `DELETE` statements.
  - Returns an integer indicating the number of rows affected.

## Code Breakdown

### Creating the Users Table
```java
public static void createUsersTable(Connection conn) {
    String createTableQuery = "CREATE TABLE users (id INT PRIMARY KEY AUTO_INCREMENT, user VARCHAR(50) NOT NULL)";
    Statement stmt = conn.createStatement();
    stmt.executeUpdate(createTableQuery);
    System.out.println("Table 'users' created successfully.");
}
```
- **Purpose**: Defines a table structure with columns `id` and `user`.
- **Auto-incremented Primary Key**: `id` is automatically generated for each new entry.

### Inserting Data into Users Table
```java
public static void insertIntoUsersTable(Connection conn) {
    String insertQuery = "INSERT INTO users (user) VALUES (?)";
    PreparedStatement stmt = conn.prepareStatement(insertQuery);
    stmt.setString(1, "SampleUser");
    stmt.executeUpdate();
}
```
- **Parameterized Insertion**: Ensures safe insertion by using placeholders and setting values with `setString`.

### Displaying Users from the Table
```java
public static void displayUsers(Connection conn) {
    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users");
    ResultSet rs = stmt.executeQuery();
    while(rs.next()) {
        int id = rs.getInt(1);
        String user = rs.getString(2);
        System.out.println("id: " + id + ", user: " + user);
    }
}
```
- **ResultSet**: Used to store and retrieve data from a `SELECT` query. Accessed through `rs.getInt` and `rs.getString`.

### Updating User Information
```java
public static void updateUserInfo(Connection conn) {
    String updateQuery = "UPDATE users SET user = ? WHERE id = ?";
    PreparedStatement stmt = conn.prepareStatement(updateQuery);
    stmt.setString(1, "UpdatedUser");
    stmt.setInt(2, 1);
    stmt.executeUpdate();
}
```
- **executeUpdate**: Modifies data within the database (e.g., updating a specific user’s name).

## Full Code Example

```java
public class Main {
    public static void main(String[] args) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String connection_url = "jdbc:mysql://localhost:3306/07_jdbc_connectivity";
        String username = "root";
        String password = "Amey1234";
        Connection conn = DriverManager.getConnection(connection_url, username, password);

        createUsersTable(conn);
        insertIntoUsersTable(conn);
        displayUsers(conn);
        updateUserInfo(conn);
        displayUsers(conn);

        conn.close();
    }
}
```
