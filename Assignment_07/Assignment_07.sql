-- 7. Triggers:
-- Consider an Employee database and write row-level triggers for the same. 
-- Implement both before & after triggers for the relevant database tables 
-- at the time of insertion, update and deletion. Implement triggers using following schema:
-- EMPLOYEE(Emp_Id, First_Name, Last_Name, Email, Phone_No, Hire_Date, Job_Profile, Salary, HRA)
-- COMPANY_INFO(Emp_Count, Salary_Expenses)
-- EMP_LOG(Emp_Id, Old_Salary, New_Salary, Edit_Time, Job_Status)

CREATE DATABASE IF NOT EXISTS assn7_triggers;
USE assn7_triggers;

CREATE TABLE Employee(
    emp_id INT PRIMARY KEY AUTO_INCREMENT, 
    first_name VARCHAR(50), 
    last_name VARCHAR(50),
    email VARCHAR(50) UNIQUE NOT NULL, 
    phone_no VARCHAR(10) UNIQUE, 
    hire_date DATE, 
    job_profile VARCHAR(50), 
    salary FLOAT, 
    HRA FLOAT
);

CREATE TABLE Company_Info(
    Emp_Count INT,
    Salary_Expenses INT
);

CREATE TABLE Emp_log(
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    old_salary FLOAT, 
    new_salary FLOAT,
    edit_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    job_status VARCHAR(50),

    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id) ON DELETE CASCADE
);

-- Before insert:
-- Check the column value of FIRST_NAME, LAST_NAME, JOB_ PROFILE for following criteria:
-- If there are any spaces before or after the FIRST_NAME, LAST_NAME, use TRIM() function to remove them.
-- The value of the JOB_PROFILE will be converted to upper cases by UPPER() function.

DELIMITER //

CREATE TRIGGER before_emp_insert
BEFORE INSERT ON Employee
FOR EACH row
BEGIN
    SET NEW.first_name = TRIM(NEW.first_name);
    SET NEW.last_name = TRIM(NEW.last_name);
    SET NEW.job_profile = UPPER(NEW.job_profile);
END //

DELIMITER ;

-- After insert: 
-- Every time an INSERT happens into EMPLOYEE table, 
-- insert relevant information into the EMP_LOG table. Also update the COMPANY_INFO table.

DELIMITER //

CREATE TRIGGER after_emp_insert
AFTER INSERT ON EMPLOYEE
FOR EACH ROW 
BEGIN
    INSERT INTO Emp_log (emp_id, old_salary, new_salary, job_status)
    VALUES (NEW.emp_id, NULL, NEW.salary, NEW.job_profile);

    DELETE FROM Company_Info;

    INSERT INTO Company_Info (Emp_Count, Salary_Expenses)  -- Ensure to specify columns
    SELECT COUNT(emp_id), SUM(salary)
    FROM Employee;

END //

DELIMITER ;


INSERT INTO Employee (first_name, last_name, email, phone_no, hire_date, job_profile, salary, HRA) VALUES 
('Amey', 'Kulkarni', 'amey.kulkarni@example.com', '9876543210', '2023-01-15', 'Software Engineer', 60000, 12000),
('Advait', 'Joshi', 'advait.joshi@example.com', '8765432109', '2023-02-20', 'Project Manager', 80000, 16000),
('Priya', 'Verma', 'priya.verma@example.com', '7654321098', '2023-03-05', 'Data Analyst', 50000, 10000),
('Rohan', 'Mehta', 'rohan.mehta@example.com', '6543210987', '2023-04-10', 'System Administrator', 55000, 11000),
('Neha', 'Desai', 'neha.desai@example.com', '5432109876', '2023-05-25', 'UX Designer', 65000, 13000);

-- After Update: 
-- Each time the HRA is updated, accordingly update the salary in EMPLOYEE table & keep track 
-- of updated salary in EMP_LOG table. Keep the COMPANY_INFO table updated.

DELIMITER //

CREATE TRIGGER before_update_emp_hra
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
    -- Update the salary based on the new HRA value
    SET NEW.salary = OLD.salary + (NEW.HRA * OLD.salary / 100);
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER after_emp_salary_update
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    UPDATE Emp_log
    SET old_salary = OLD.salary,
        new_salary = NEW.salary,
        job_status = NEW.job_profile
    WHERE emp_id = NEW.emp_id;

    DELETE FROM Company_Info;
    



END //

DELIMITER ;



-- Before Delete: Every time a DELETE happens on EMPLOYEE table, accordingly change the JOB_STATUS in EMP_LOG table from ACTIVEto DELETED & keep track of EDIT_TIME
-- After Delete: Keep the COMPANY_INFO table updated.

