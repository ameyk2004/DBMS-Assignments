CREATE DATABASE cursor_assn;

USE cursor_assn;

CREATE TABLE IF NOT EXISTS Account(
    acc_no INT PRIMARY KEY,
    branch_name VARCHAR(50),
    balance FLOAT
);

CREATE TABLE IF NOT EXISTS Customer(
    acc_no INT PRIMARY KEY,
    cust_name VARCHAR(50),

    FOREIGN KEY (acc_no) REFERENCES Account(acc_no) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Borrower(
    acc_no INT PRIMARY KEY,
    loan_no INT,
    FOREIGN KEY (acc_no) REFERENCES Account(acc_no) ON DELETE CASCADE
);

INSERT INTO Account (acc_no, branch_name, balance)
VALUES
    (103, "Pune", 7000),
    (104, "Mumbai", 18000);

INSERT INTO Customer (acc_no, cust_name)
VALUES
    (103, "Advait Joshi"),
    (104, "Suvrat Ketkar");

INSERT INTO Borrower (acc_no, loan_no)
VALUES
    (103, 1);


-- Customers who are borrowers

SELECT c.acc_no, c.cust_name, a.balance
FROM Customer as c
NATURAL JOIN Borrower as b
NATURAL JOIN Account as a;


-- Customers who are NOT borrowers

SELECT c.acc_no, c.cust_name, a.balance
FROM Customer as c
NATURAL JOIN Account as a
LEFT JOIN Borrower as b
ON c.acc_no = b.acc_no
WHERE b.loan_no IS NULL;

DELIMITER //

CREATE PROCEDURE check_loan_eligibility()
BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE cust_acc_no INT;
    DECLARE customer_name VARCHAR(50);
    DECLARE cust_balance FLOAT;
    DECLARE eligibility VARCHAR(50);

    DECLARE loan_cursor CURSOR FOR
        SELECT c.acc_no, c.cust_name, a.balance
        FROM Customer as c
        NATURAL JOIN Account as a
        LEFT JOIN Borrower as b
        ON c.acc_no = b.acc_no
        WHERE b.loan_no IS NULL;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    CREATE TABLE IF NOT EXISTS loan_eligibility(
        acc_no INT PRIMARY KEY,
        cust_name VARCHAR(50),
        balance FLOAT,
        loan_eligibility VARCHAR(50),

        FOREIGN KEY (acc_no) REFERENCES Account(acc_no) ON DELETE CASCADE
    );

    OPEN loan_cursor;

    loan_loop:
    LOOP
        FETCH loan_cursor INTO cust_acc_no, customer_name, cust_balance;

        IF done THEN 
            LEAVE loan_loop;
        END IF;

        IF cust_balance >= 10000
            THEN SET eligibility = "ELIGIBLE";
        ELSEIF cust_balance < 10000
            THEN SET eligibility = "NOT ELIGIBLE";
        END IF;

        INSERT INTO loan_eligibility
        VALUES (cust_acc_no, customer_name, cust_balance, eligibility);

    END LOOP;

    CLOSE loan_cursor;
END //

DELIMITER ;



