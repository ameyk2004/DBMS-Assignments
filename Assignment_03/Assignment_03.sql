-- Assignment No 3 (based on Book schema)

-- Use the tables created in assignment no 2 and execute the following queries:

-- 1. Find Customer details and order details using NATURAL JOIN.

SELECT c.cust_fname, c.cust_lname, o.ISBN
FROM Customer as c
NATURAL JOIN 
OrderTable as o;

-- 2. Find the book_ title, author_name, country.

SELECT b.title, a.author_name, a.country
FROM Book as b
JOIN Author as a
ON a.author_no = b.author_no;

-- 3. Find the customer ID, name and order_no of customers who have never placed an order.

SELECT c.cust_no, CONCAT(c.cust_fname, ' ', c.cust_lname) AS customer_name
FROM Customer AS c
LEFT JOIN OrderTable AS o ON c.cust_no = o.cust_no
WHERE o.order_no IS NULL;

-- 4. Find the Title, ISBN, order_no of the books for which order is not placed.

SELECT b.title, b.ISBN 
FROM Book as b
LEFT JOIN
OrderTable as o
ON b.ISBN = o.ISBN
WHERE o.order_no IS NULL;

-- 5. Display cust_fname, title,author_no,publisher_year where ISBN=1234.

SELECT CONCAT(c.cust_fname, ' ', c.cust_lname) as cust_name, b.title, a.author_name, b.pub_year FROM 
Customer as c
JOIN
OrderTable as o
ON o.cust_no = c.cust_no
JOIN Book as b
ON o.ISBN = b.ISBN
JOIN Author as a
ON a.author_no = b.author_no
WHERE b.ISBN = 1;


-- 6. Display the total number of books and customer name.

SELECT CONCAT(c.cust_fname, ' ', c.cust_lname) as cust_name, COUNT(*)
FROM Customer as c
NATURAL JOIN OrderTable as o
GROUP BY cust_name;

-- 7. List the cust_id, order_no and ISBN with books having title 'mysql'.

SELECT 
    o.cust_no AS cust_id, 
    o.order_no, 
    o.ISBN
FROM 
    OrderTable AS o
JOIN 
    Book AS b ON o.ISBN = b.ISBN
WHERE 
    b.title = 'mysql';

-- 8. Find the names of all the companies that ordered books in the year 2015.

SELECT DISTINCT 
    c.cust_company
FROM 
    Customer AS c
JOIN 
    OrderTable AS o ON c.cust_no = o.cust_no
WHERE 
    YEAR(o.odate) = 2015;

-- 9. Create view showing the author and book details.

CREATE VIEW AuthorBookView AS
SELECT 
    b.title, 
    b.ISBN, 
    a.author_name, 
    b.pub_year
FROM 
    Book AS b
JOIN 
    Author AS a ON b.author_no = a.author_no;

-- 10. Perform Manipulation on simple view-Insert, update, delete, drop view.

