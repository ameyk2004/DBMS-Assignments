-- 6. PLSQL Cursors
-- Consider the following schema and write a stored procedure to find details of customers who have not taken a loan.
-- Use cursor to find which of these customers have balance more than 10,000 and insert their details in loan_eligibility table.
-- Account (Acc_no, branch_name, balance) 
-- Customer (Cust_name, Acc_no) 
-- Borrower(Cust_name, Loan_no)

INSERT INTO Customer 
VALUES 
    ('Mayank', 9, 340000, 'Nashik'),
    ('Purva', 10, 70000, 'Mumbai'),
    ('Kshitij', 11, 82000, 'Mumbai'),
    ('Gaurav', 12, 97000, 'Mumbai');

DELIMITER //

CREATE PROCEDURE find_loan_eligibility()
BEGIN
    -- Variable declarations
    DECLARE done INT DEFAULT FALSE;
    DECLARE customer_name VARCHAR(50);
    DECLARE acc_balance FLOAT;
    DECLARE cust_acc_num INT;
    DECLARE cust_city VARCHAR(50);

    -- Declare cursor for eligible customers
    DECLARE loan_cursor CURSOR FOR
        SELECT c.cust_name, c.acc_no, c.balance, c.city
        FROM Customer AS c
        LEFT JOIN Borrower AS b ON c.acc_no = b.acc_no
        WHERE b.loan_no IS NULL;

    -- Continue handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Create loan_eligibility table if it doesn't exist
    CREATE TABLE IF NOT EXISTS loan_eligibility(
        cust_name VARCHAR(50),
        acc_no INT,
        balance FLOAT,
        city VARCHAR(50),
        UNIQUE KEY unique_customer (cust_name, acc_no) -- Ensuring unique entries
    );

    OPEN loan_cursor;

    eligiblity_loop:
    LOOP
        -- Fetch data into variables
        FETCH loan_cursor INTO customer_name, cust_acc_num, acc_balance, cust_city;

        -- Check if done before proceeding to the next iteration
        IF done THEN
            LEAVE eligiblity_loop;
        END IF;

        IF acc_balance > 100000 THEN 
            INSERT IGNORE INTO loan_eligibility (cust_name, acc_no, balance, city)
            VALUES (customer_name, cust_acc_num, acc_balance, cust_city);
        END IF;

    END LOOP;

    CLOSE loan_cursor;
END //

DELIMITER ;

