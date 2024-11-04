Assignment No 2B (Student Schema)
-- Consider the following relational Schema.
-- ● Student( s_id,Drive_id,T_id,s_name,CGPA,s_branch,S_dob)
-- ● PlacementDrive( Drive_id,Pcompany_name,package,location)
-- ● Training ( T_id,Tcompany_name,T_Fee,T_year)

-- Use the tables created in assignment no 2 and execute the following queries:
-- 1. Insert at least 10 records in the Student table and insert other tables accordingly.
-- 2. Display all students details with branch ‘Computer ‘and ‘It’ and student name
-- starting with 'a' or 'd'.
-- 3. list the number of different companies.(use of distinct)
-- 4. Give 15% increase in fee of the Training whose joining year is 2019.
-- 5. Delete Student details having CGPA score less than 7.
-- 6. Find the names of companies belonging to pune or Mumbai
-- 7. Find the student name who joined training in 1-1-2019 as well as in 1-1-2021
-- 8. Find the student name having maximum CGPA score and names of students
-- having CGPA score between 7 to 9 .
-- 9. Display all Student name with T_id with decreasing order of Fees
-- 10. Display PCompany name, S_name ,location and Package with Package 30K,
-- 40K and 50k

CREATE TABLE PlacementDrive(
    p_id INT PRIMARY KEY AUTO_INCREMENT,
    p_company_name VARCHAR(50),
    package INT,
    location VARCHAR(50)
);

CREATE TABLE Training ( 
    t_id INT PRIMARY KEY AUTO_INCREMENT,
    t_company_name VARCHAR(50),
    t_fee INT,
    t_year YEAR
);

CREATE TABLE Student(
    s_id INT PRIMARY KEY,
    p_id INT,
    t_id INT,
    s_name VARCHAR(50),
    CGPA FLOAT,
    s_branch VARCHAR(50),
    s_dob DATE,

    FOREIGN KEY (p_id) REFERENCES PlacementDrive(p_id),
    FOREIGN KEY (t_id) REFERENCES Training(t_id)
);

-- QUERY 1

INSERT INTO PlacementDrive (p_company_name, package, location) 
VALUES 
    ("MaterCard", 40000, "Viman Nagar"),
    ("Barclays", 65000, "Yerawda"),
    ("BNY Mellon", 78000, "Shivaji Nagar"),
    ("Deutsche Bank", 45000, "Hinjewadi"),
    ("Zensar", 60000, "Kharadi"),
    ("Dell", 80000, "Banglore"),
    ("Adobe", 100000, "Banglore");

INSERT INTO Training (t_company_name, t_fee, t_year) 
VALUES 
    ("MaterCard", 45000, 2020),
    ("Barclays", 70000, 2021),
    ("BNY Mellon", 75000, 2022),
    ("Deutsche Bank", 50000, 2020),
    ("Zensar", 65000, 2021),
    ("Dell", 85000, 2022),
    ("Adobe", 110000, 2023),
    ("MaterCard", 55000, 2021),
    ("Barclays", 72000, 2022);

INSERT INTO Student (p_id, t_id, s_name, CGPA, s_branch, s_dob) 
VALUES 
    (1,2, "Amey Kulkarni", 9.7, "CSE", '2004-01-30');
       
SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE 
    table_name = "Student" AND
    table_schema = "assn2_db";

ALTER TABLE Student
DROP FOREIGN KEY student_ibfk_1;

INSERT INTO Student (s_id, p_id, t_id, s_name, CGPA, s_branch, s_dob) 
VALUES 
    (1, 1, 3, "Amey Kulkarni", 9.7, "CSE", '2004-01-30'),
    (2, 2, 5, "Advait Joshi", 9.5, "CSE", '2004-02-15'),
    (3, 3, 1, "Suvrat Ketkar", 8.8, "IT", '2004-03-05'),
    (4, 4, 7, "Tirthraj Mahajan", 9.2, "ENTC", '2004-04-10'),
    (5, 5, 4, "Vardhan Dongre", 8.6, "CSE", '2004-05-20'),
    (6, 6, 9, "Anshul Kalbande", 9.1, "IT", '2004-06-25'),
    (7, 7, 2, "Rinit Jain", 8.9, "ENTC", '2004-07-30'),
    (8, 1, 6, "Hariom Gilda", 9.3, "CSE", '2004-08-18');


-- QUERY 2
-- 2. Display all students details with branch ‘Computer ‘and ‘It’ and student name
-- starting with 'a' or 'd'.

SELECT * 
FROM Student
WHERE 
    (s_branch = "CSE" 
    OR s_branch = "IT")
    AND (s_name LIKE 'A%' OR s_name LIKE 'D%');

-- QUERY 3
-- 3. list the number of different companies.(use of distinct)

SELECT distinct t_company_name
FROM Training
UNION
SELECT distinct p_company_name
FROM PlacementDrive;

-- QUERY 4
-- 4. Give 15% increase in fee of the Training whose joining year is 2020.

SELECT *
FROM Training
WHERE
    t_year = 2020;

UPDATE Training
SET t_fee = 1.15 * t_fee
WHERE t_year = 2020;

SELECT *
FROM Training
WHERE
    t_year = 2020;

-- QUERY 5
-- 5. Delete Student details having CGPA score less than 7.

DELETE 
FROM Student
WHERE CGPA < 7;

-- QUERY 6
-- 6. Find the names of companies belonging to pune or Mumbai
SELECT p_company_name 
FROM PlacementDrive 
WHERE 
    location = "Pune" 
    OR location = "Mumbai";

-- QUERY 7
-- 7. Find the student name who joined training in 1-1-2019 as well as in 1-1-2021


SELECT s.s_name
FROM Student s
JOIN Training t ON s.t_id = t.t_id
WHERE t.t_year IN (2019, 2021);

-- QUERY 8
-- 8. Find the student name having maximum CGPA score and names of students having CGPA score between 7 to 9 .

SELECT s_name, CGPA FROM Student
where CGPA = (SELECT MAX(CGPA) FROM Student)
UNION
SELECT s_name, CGPA FROM Student
WHERE CGPA >= 7 AND CGPA <=9;


-- QUERY 9
-- 9. Display all Student name with T_id with decreasing order of Fees

SELECT s.s_name, t.t_fee 
FROM Student as s
Join Training as t
ON t.t_id = s.t_id
order by t.t_fee DESC;


-- QUERY 10
-- 10. Display PCompany name, S_name ,location and Package with Package 30K, 40K and 50k


