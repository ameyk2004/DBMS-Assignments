CREATE DATABASE practice_01;

USE practice_01;


CREATE TABLE Department(
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50)
);

CREATE TABLE Professor(
    prof_id INT PRIMARY KEY AUTO_INCREMENT, 
    prof_fname VARCHAR(50),
    prof_lname VARCHAR(50),
    dept_id INT,
    designation VARCHAR(50),
    salary INT,
    doj DATE,
    email VARCHAR(50),
    phone VARCHAR(50),
    city VARCHAR(50),

    FOREIGN KEY (dept_id) REFERENCES Department(dept_id) ON DELETE CASCADE
);

CREATE TABLE Work(
    prof_id INT,
    dept_id INT,
    duration INT,

    FOREIGN KEY (prof_id) REFERENCES Professor(prof_id) ON DELETE CASCADE,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id) ON DELETE CASCADE
);

CREATE TABLE Shift (
    prof_id INT,
    shift VARCHAR(20),
    working_hours INT,
    PRIMARY KEY (prof_id, shift),
    FOREIGN KEY (prof_id) REFERENCES Professor(prof_id) ON DELETE CASCADE
);

SELECT * 
FROM Professor
WHERE 
    (prof_fname LIKE 'A%' 
    OR 
    prof_fname LIKE 'D%')
    and
    (city = "Pune"
    OR 
    city = "Mumbai");


SELECT DISTINCT city from Professor;

UPDATE Professor
SET salary = 1.05 * salary
WHERE
doj = '2015-01-01';

DELETE FROM Professor WHERE city = "Pune";


SELECT CONCAT(prof_fname, ' ', prof_lname) as prof_name from Professor where city = "Mumbai" or city = "Pune";

SELECT * from Professor WHERE doj = '2015-01-01' OR doj = '2016-01-01';

SELECT * FROM Professor 
WHERE salary = (SELECT MAX(salary) FROM Professor)
UNION
SELECT * FROM Professor 
WHERE salary BETWEEN 10000 AND 20000
ORDER By salary
DESC;

SELECT 
    CONCAT(p.prof_fname, ' ', p.prof_lname) as prof_name, 
    p.doj as Date_of_Joining, 
    p.salary as Salary,
    d.dept_name as Department
FROM 
    Professor as p
NATURAL JOIN 
    Department as d
WHERE Salary IN [30000, 40000, 50000];
