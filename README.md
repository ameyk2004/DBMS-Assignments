# SQL-NOTES

## Introduction


### What is Database

A database is an organized collection of data, so that it can be easily accessed and managed.

Database handlers create a database in such a way that only one set of software program provides access of data to all the users.

There are many databases available like MySQL, Sybase, Oracle, MongoDB, Informix, PostgreSQL, SQL Server, etc.

Modern databases are managed by the database management system (DBMS).


### Cloud database
Cloud database facilitates you to store, manage, and retrieve their structured, unstructured data via a cloud platform. This data is accessible over the Internet. Cloud databases are also called a database as service (DBaaS) because they are offered as a managed service.

Some best cloud options are:

AWS (Amazon Web Services)
Snowflake Computing
Oracle Database Cloud Services

### NoSQL Database
A NoSQL database is an approach to design such databases that can accommodate a wide variety of data models. NoSQL stands for "not only SQL." It is an alternative to traditional relational databases in which data is placed in tables, and data schema is perfectly designed before the database is built.


### What is DBMS?
- Database Management System (DBMS) is software for storing and retrieving users’ data while considering appropriate security measures. It consists of a group of programs that manipulate the database. 

- The DBMS accepts the request for data from an application and instructs the operating system to provide the specific data. In large systems, a DBMS helps users and other third-party software store and retrieve data.


### Database Languages

<img src="https://media.geeksforgeeks.org/wp-content/uploads/20210920153429/new.png">


#### DDL (Data Definition Language)
DDL or Data Definition Language actually consists of the SQL commands that can be used to define the database schema. It simply deals with descriptions of the database schema and is used to create and `modify the structure of database` objects in the database.

#### DQL (Data Query Language)
DQL statements are used for performing queries on the data within schema objects. The purpose of the DQL Command is to get some schema relation based on the query passed to it.

#### DML (Data Manipulation Language)
The SQL commands that deal with the manipulation of data present in the database belong to DML or Data Manipulation Language and this includes most of the SQL statements. 

#### DCL (Data Control Language)
DCL includes commands such as GRANT and REVOKE which mainly deal with the rights, permissions, and other controls of the database system. 

#### TCL (Transaction Control Language)
Transactions group a set of tasks into a single execution unit. Each transaction begins with a specific task and ends when all the tasks in the group are successfully completed. If any of the tasks fail, the transaction fails.

## RDBMS

### Keys in Database Structure

Keys are one of the basic requirements of a relational database model. It is widely used to identify the tuples(rows) uniquely in the table. We also use keys to set up relations amongst various columns and tables of a relational database.

#### Candidate Key

- The minimal set of attributes that can uniquely identify a tuple is known as a candidate key. For Example, STUD_NO in STUDENT relation.

- Multiple ways can be there to uniquely identify a Row in Table. For eg. Stud id , email, phone number can exist either individually or as a combination to uniquely identify a Row in Database Table.

- So many Candidate Keys can be Present in an Database.

#### Primary Key

- There can be more than one candidate key in relation out of which one can be chosen as the primary key. For Example, STUD_NO, as well as STUD_PHONE, are candidate keys for relation STUDENT but STUD_NO can be chosen as the primary key (only one out of many candidate keys)

- It is a unique key.

- It can identify only one tuple (a record) at a time.

#### Alternate Key

- The candidate key other than the primary key is called an alternate key .

- All the keys which are not primary keys are called alternate keys.


#### Foreign Key

- If an attribute can only take the values which are present as values of some other attribute, it will be a foreign key to the attribute to which it refers. 

- The relation which is being referenced is called referenced relation and the corresponding attribute is called referenced attribute.

- It is a key it acts as a primary key in one table and it acts as 
secondary key in another table.

- t combines two or more relations (tables) at a time.

- They act as a cross-reference between the tables.

<img src = "https://media.geeksforgeeks.org/wp-content/uploads/20230314174012/Different-types-of-keys.png">

## **SQL Queries**

SQL queries are the core of interacting with relational databases. The most common query is `SELECT`, but you can also use other commands to insert, update, or delete data.

### **Basic Query Example**:

```sql
SELECT * FROM employees;
```

### **SQL Clauses**

SQL clauses are the building blocks of SQL statements. These allow you to filter, sort, group, and organize data.

Important SQL Clauses:

- `WHERE`: Filters records.
- `ORDER BY`: Sorts records.
- `GROUP BY`: Groups records.
- `HAVING`: Filters groups.
- `LIMIT`: Limits the number of rows returned.
- `DISTINCT`: Returns only unique values.

Example:

```sql
SELECT name, salary FROM employees
WHERE department = 'HR'
ORDER BY salary DESC
LIMIT 5;
```
### **SQL Operators**

SQL operators allow you to perform operations on columns and values in the database.

Types of SQL Operators:

- `Arithmetic Operators`: Used for mathematical operations like +, -, *, /.
- `Comparison Operators`: Used to compare values like =, !=, <, >, <=, >=.
- `Logical Operators`: Used to combine multiple conditions like AND, OR, NOT.
- `BETWEEN`: Used to filter the result within a certain range.
- `IN`: Used to match a value in a list.
- `LIKE`: Used for pattern matching.

Example:

```sql
SELECT name, salary FROM employees
WHERE salary BETWEEN 40000 AND 70000;
```

## **SQL JOINS**

SQL JOINs allow you to combine data from multiple tables.

Types of SQL JOINs:
- INNER JOIN: Returns records that have matching values in both tables.
- LEFT JOIN: Returns all records from the left table and the matching records from the right table.
- RIGHT JOIN: Returns all records from the right table and the matching records from the left table.
- FULL JOIN: Returns all records when there is a match in one of the tables.
- CROSS JOIN: Returns the Cartesian product of both tables.

Example:

```sql
SELECT employees.name, departments.name
FROM employees
INNER JOIN departments
ON employees.department_id = departments.id;
```
### **Views in SQL**

A view is a virtual table in SQL, created by a query joining one or more tables. It does not store data physically but presents data from the underlying tables.

Creating a View:
```sql
CREATE VIEW employee_view AS
SELECT name, salary, department
FROM employees
WHERE department = 'HR';
Using a View:
SELECT * FROM employee_view;
```

### MySQL Procedures

A stored procedure is a collection of SQL statements that can be executed together. They allow for code reuse, better performance, and encapsulation of logic.

Creating a Stored Procedure:
```sql
DELIMITER //

CREATE PROCEDURE GetEmployeeDetails(IN emp_id INT)
BEGIN
    SELECT * FROM employees WHERE id = emp_id;
END //

DELIMITER ;
Calling a Stored Procedure:
CALL GetEmployeeDetails(101);
```

### **MySQL Functions**

MySQL functions are pre-built routines that return a value, which can be used in SQL statements.

Common MySQL Functions:
- `COUNT()`: Returns the number of rows.
- `AVG()`: Returns the average value.
- `SUM()`: Returns the sum of values.
- `NOW()`: Returns the current date and time.

Example:

```sql
SELECT COUNT(*) FROM employees WHERE salary > 50000;
```

Triggers in SQL

A trigger is a set of SQL statements that automatically execute when certain events (such as INSERT, UPDATE, or DELETE) occur on a table.

Creating a Trigger:

```sql
CREATE TRIGGER before_employee_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 30000 THEN
        SET NEW.salary = 30000;
    END IF;
END;```

### Database Connectivity using JDBC

JDBC (Java Database Connectivity) is an API that allows Java applications to connect to databases.

Steps to Connect to MySQL Using JDBC:
Install MySQL JDBC Driver: Download and include the JDBC driver (e.g., mysql-connector-java).
Write JDBC Code:

```java
import java.sql.*;

public class DatabaseConnection {
    public static void main(String[] args) {
        try {
            // Load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to the database
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/mydatabase", "username", "password");

            // Create a statement
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM employees");

            // Process the results
            while (rs.next()) {
                System.out.println(rs.getString("name"));
            }

            // Close the connection
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

## Conclusion

SQL is a powerful language for managing relational databases, allowing you to query, update, and manipulate data effectively. Mastery of SQL involves understanding its syntax, operators, joins, and various functions, as well as its advanced concepts like stored procedures, triggers, and database connectivity.

For deeper learning, always practice on real databases and explore complex queries and performance optimization techniques.
