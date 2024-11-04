-- Assignment No 2- Part A Create following tables in MYSQL

-- Customer(cust_no,cust_fname,cust_lname,cust_company,cust_addr,city,cust_pho ne) 
-- order(order_no,cust_no,ISBN,qty,odate); book(ISBN,title,unit_price,author_no,publisher_no,pub_year); 
-- author(author_no,author_name,country) 
-- publisher(publisher_no,publisher_name,publisher_addr,year);

-- Note:Use referential integrity constraints while creating tables with on delete cascade options.
-- Create view, index, sequence and synonym based on above tables.

-- CREATE DDL STATEMENTS

-- Customer table
CREATE TABLE Customer (
    cust_no INT PRIMARY KEY AUTO_INCREMENT,
    cust_fname VARCHAR(50),
    cust_lname VARCHAR(50),
    cust_company VARCHAR(50),
    cust_addr VARCHAR(150),
    city VARCHAR(50),
    cust_phone VARCHAR(50)
);

-- Publisher table
CREATE TABLE Publisher (
    publisher_no INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(50),
    publisher_addr VARCHAR(150),
    year YEAR
);

-- Author table
CREATE TABLE Author (
    author_no INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(50),
    country VARCHAR(50)
);

-- Book table with foreign keys referencing Publisher and Author tables
CREATE TABLE Book (
    ISBN INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    unit_price INT,
    author_no INT,
    publisher_no INT NOT NULL,
    pub_year YEAR,
    FOREIGN KEY (author_no) REFERENCES Author(author_no) ON DELETE CASCADE,
    FOREIGN KEY (publisher_no) REFERENCES Publisher(publisher_no) ON DELETE CASCADE
);

-- Order table with foreign keys referencing Customer and Book tables
CREATE TABLE OrderTable (
    order_no INT PRIMARY KEY AUTO_INCREMENT,
    cust_no INT,
    ISBN INT NOT NULL,
    qty INT,
    odate DATE,
    FOREIGN KEY (cust_no) REFERENCES Customer(cust_no) ON DELETE CASCADE,
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN) ON DELETE CASCADE
);

-- 2. Display all customer details with city pune and mumbai and customer first name starting with
-- 'p' or 'h'.

SELECT * FROM
Customer
WHERE city IN ("Pune", "Mumbai")
AND
cust_fname LIKE 'P%' OR cust_fname LIKE 'H%';

-- 3. lists the number of different customer cities.

SELECT distinct city FROM
Customer;

-- 4. Give 5% increase in price of the books with publishing year 2015.

UPDATE Book
SET unit_price = 1.05* unit_price
WHERE pub_year = 2015;

-- 5. Delete customer details living in pune.

DELETE FROM 
Customer
WHERE city = "Pune";

-- 6. Find the names of authors living in India or Australia .

SELECT author_name
FROM Author
WHERE country IN ("India", "Australia");

-- 7. Find the publishers who are established in year 2015 as well as in 2016

SELECT * FROM
Publisher
WHERE year = 2015;


-- 8. Find the book having maximum price and find titles of book having price between 300 and 400.

SELECT * FROM 
Book
WHERE unit_price = (SELECT MAX(unit_price) FROM Book);

SELECT title, unit_price FROM 
Book
WHERE unit_price >= 300 AND unit_price <=400;

-- 9. Display all titles of books with price and published year in decreasing order of publishing year.

SELECT title, unit_price, pub_year 
FROM Book 
ORDER BY pub_year;


-- 10. Display title,author_no and publisher_no of all books published in 2000,2004,2006.

SELECT title, author_no, publisher_no, pub_year
FROM book
WHERE pub_year IN (2000, 2004, 2006);

