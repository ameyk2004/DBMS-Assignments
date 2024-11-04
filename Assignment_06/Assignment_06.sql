-- 6. PLSQL Cursors
-- Consider the following schema and write a stored procedure to find details of customers who have not taken a loan.
-- Use cursor to find which of these customers have balance more than 10,000 and insert their details in loan_eligibility table.
-- Account (Acc_no, branch_name, balance) 
-- Customer (Cust_name, Acc_no) 
-- Borrower(Cust_name, Loan_no)

INSERT INTO Customer 
VALUES 
    ('Nikita', 7, 120000, 'Nashik'),
    ('Aniket', 8, 120000, 'Mumbai')

SELECT c.cust_name, c.balance
FROM
Customer as c
LEFT JOIN Borrower as b
ON c.acc_no = b.acc_no
WHERE b.loan_no IS NULL;
;

