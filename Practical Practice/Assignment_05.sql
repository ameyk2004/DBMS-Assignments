
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


-- credit score = (balance - loan_amount) / balance * 5;

DELIMITER //

CREATE PROCEDURE compute_credit_score(IN loan_amount FLOAT, IN account_balance FLOAT, OUT credit_score FLOAT)
BEGIN
    SET credit_score = (account_balance - loan_amount) / account_balance * 5;
END //

DELIMITER ;

CREATE FUNCTION get_credit_score(customer_name VARCHAR(50))
RETURNS FLOAT
DETERMINISTIC
BEGIN

    DECLARE cust_loan_amount FLOAT;
    DECLARE cust_acc_balance FLOAT;
    DECLARE credit_score FLOAT;
    
    SELECT l.loan_amount, c.balance INTO cust_loan_amount, cust_acc_balance
    FROM Customer as c
    NATURAL JOIN Loan as l
    NATURAL JOIN Borrower as b
    WHERE c.cust_name = customer_name;

    CALL compute_credit_score(cust_loan_amount, cust_acc_balance, credit_score);

    RETURN credit_score;

END //

DELIMITER ;

call compute_credit_score(122560,230000, @credit_score);