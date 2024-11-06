
CREATE TABLE Customer(
    acc_no INT PRIMARY KEY,
    cust_name VARCHAR(50),
    balance FLOAT,
    city VARCHAR(50)
);

CREATE TABLE Loan(
    loan_no INT PRIMARY KEY,
    branch_name VARCHAR(50),
    loan_amount FLOAT
);

CREATE TABLE Borrower(
    acc_no INT PRIMARY KEY, 
    loan_no INT,

    FOREIGN KEY (acc_no) REFERENCES Customer(acc_no) ON DELETE CASCADE,
    FOREIGN KEY (loan_no) REFERENCES Loan(loan_no) ON DELETE CASCADE
);


SELECT * FROM Customer;
SELECT * FROM Loan;
SELECT * FROM Borrower;


DELIMITER //

CREATE PROCEDURE categorize_borrowers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE cust_acc_no INT;
    DECLARE customer_name VARCHAR(50);
    DECLARE cust_loan_amount FLOAT;
    DECLARE cust_balance FLOAT;
    DECLARE category VARCHAR(50);

    DECLARE category_cursor CURSOR FOR
        SELECT c.acc_no, c.cust_name, l.loan_amount, c.balance
        FROM Borrower as b
        NATURAL JOIN Customer as c
        NATURAL JOIN Loan as l;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    CREATE TABLE IF NOT EXISTS borrower_category(
        acc_no INT PRIMARY KEY,
        cust_name VARCHAR(50),
        loan_amount FLOAT,
        balance FLOAT,
        category VARCHAR(50),

        FOREIGN KEY (acc_no) REFERENCES Customer(acc_no) ON DELETE CASCADE
    );

    OPEN category_cursor;

    cust_loop: 
    LOOP

        FETCH category_cursor INTO cust_acc_no, customer_name, cust_loan_amount, cust_balance;

        IF done 
            THEN 
            LEAVE cust_loop;
        END IF;

        IF (cust_loan_amount < 30000) THEN
            SET category = "NOMINAL";
        ELSEIF ((cust_loan_amount >= 30000) AND (cust_loan_amount < 50000)) THEN
            SET category = "MODERATE";
        ELSEIF (cust_loan_amount >= 50000) THEN
            SET category = "CRITICAL";
        END IF;

        INSERT INTO borrower_category (acc_no, cust_name, loan_amount, balance, category)
        VALUES (cust_acc_no, customer_name, cust_loan_amount, cust_balance, category);
        
        
    END LOOP;

    CLOSE category_cursor;

END //

DELIMITER ;

DELETE FROM borrower_category;
CALL categorize_borrowers();
SELECT * FROM borrower_category;