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
