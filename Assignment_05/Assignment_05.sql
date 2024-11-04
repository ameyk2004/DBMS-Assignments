-- 5. PLSQL stored procedure & functions

-- Consider the following schema
-- write a PLSQL function that accepts customer name and returns the credit score for that customer. 
-- Let the credit score be computed on a scale of 0 to 5 by a stored procedure based on the account balance and loan amount of the customers. (hint: if loan_amount is 50% of account balance then, credit_score: 3)
-- Customer(Cust_name, AccNo, Balance, city) 
-- Loan(Loan_no, branch_name, Amount) 
-- Borrower(Cust_name, Loan_no)

USE assn3_procedures;

DROP FUNCTION IF EXISTS get_credit_score;
DROP PROCEDURE IF EXISTS compute_credit_score;

DELIMITER //

CREATE FUNCTION get_credit_score(customer_name VARCHAR(50)) 
RETURNS FLOAT 
DETERMINISTIC
BEGIN

    DECLARE credit_score FLOAT;
    DECLARE account_balance FLOAT;
    DECLARE loan_amount FLOAT;

        SELECT c.balance, l.amount INTO account_balance, loan_amount
        FROM Customer as c
        NATURAL JOIN Borrower as b
        NATURAL JOIN Loan as l
        WHERE cust_name = customer_name
        LIMIT 1;

    CALL compute_credit_score(account_balance, loan_amount, credit_score);

    RETURN credit_score;
    
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE compute_credit_score(IN account_balance FLOAT, IN loan_amount FLOAT, OUT credit_score FLOAT)
BEGIN
    SET credit_score = 5 - ((loan_amount / account_balance) * 5);

    IF credit_score < 0 THEN
        SET credit_score = 0;
    ELSEIF credit_score > 5 THEN
        SET credit_score = 5;
    END IF;

END //


SELECT get_credit_score('Amey') as credit_score;
