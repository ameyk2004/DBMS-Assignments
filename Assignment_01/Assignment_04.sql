-- 4. PLSQL stored procedure:

-- Consider the following schema and write a stored procedure 
-- to find those customers who have taken a loan. 
-- Categorize these loan borrowers as critical, moderate and nominal based on their loan amount.

-- Insert all the details of borrowers along with the category in borrower_category table. 
-- Customer(Cust_name, AccNo, Balance, city)
-- Loan(Loan_no, branch_name, Amount)
-- Borrower(Cust_name, Loan_no)
-- borrowr_category(Cust_name,AccNo,Loan_no,branch_name,amount,category)

USE assn3_procedures;

CREATE TABLE IF NOT EXISTS Customer(
    cust_name VARCHAR(100),
    acc_no INT PRIMARY KEY, 
    balance FLOAT, 
    city VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Loan(
    loan_no INT PRIMARY KEY,
    branch_name VARCHAR(50),
    amount FLOAT
);

CREATE TABLE IF NOT EXISTS Borrower(
    acc_no INT PRIMARY KEY , 
    loan_no INT NOT NULL, 
    cust_name VARCHAR(50),

    FOREIGN KEY (acc_no) REFERENCES Customer(acc_no) ON DELETE CASCADE,
    FOREIGN KEY (loan_no) REFERENCES Loan(loan_no) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS borrower_category(
    cust_name VARCHAR(50),
    acc_no INT PRIMARY KEY,
    loan_no INT,
    branch_name VARCHAR(50),
    amount FLOAT,
    category VARCHAR(50),

    FOREIGN KEY (acc_no) REFERENCES Customer(acc_no) ON DELETE CASCADE,
    FOREIGN KEY (loan_no) REFERENCES Loan(loan_no) ON DELETE CASCADE
);

SELECT * FROM Loan;
SELECT * FROM Customer;
SELECT * FROM Borrower;


DROP PROCEDURE IF EXISTS categorize_borrowers;

DELIMITER //

CREATE PROCEDURE categorize_borrowers()
BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE cust_name VARCHAR(50);
    DECLARE acc_no INT;
    DECLARE loan_no INT;
    DECLARE branch_name VARCHAR(50);
    DECLARE loan_amount FLOAT;
    DECLARE category_borrower VARCHAR(50);

    DECLARE borrower_cursor CURSOR FOR
        SELECT c.cust_name, b.acc_no, b.loan_no, l.branch_name, l.amount
        FROM Customer as c
        NATURAL JOIN Borrower as b
        NATURAL JOIN Loan as l;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN borrower_cursor;

    category_loop: LOOP
        FETCH borrower_cursor INTO cust_name, acc_no, loan_no, branch_name, loan_amount;

        IF done THEN
            LEAVE category_loop;
        END IF;

        IF loan_amount < 60000 THEN SET category_borrower = "Low";
        ELSEIF loan_amount >= 60000 AND loan_amount <= 80000 THEN SET category_borrower = "Moderate";
        ELSE SET category_borrower = "Critical";
        END IF;


       INSERT INTO borrower_category (cust_name, acc_no, loan_no, branch_name, amount, category) 
        VALUES (cust_name, acc_no, loan_no, branch_name, loan_amount, category_borrower);
    END LOOP;

    -- Close the cursor
    CLOSE borrower_cursor;  

END //

DELIMITER ;

select * from borrower_category;