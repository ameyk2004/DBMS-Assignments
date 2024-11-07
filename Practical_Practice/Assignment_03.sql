USE practice_01;

SELECT p.prof_fname, d.dept_name
from Professor as p
NATURAL JOIN
Department as d;

SELECT prof_id, CONCAT(p.prof_fname, ' ', p.prof_lname) as prof_name, d.dept_name, p.city, s.shift, s.working_hours
FROM Professor as p
NATURAL JOIN Department as d
NATURAL JOIN Shift as s;

SELECT prof_id, CONCAT(p.prof_fname, ' ', p.prof_lname) as prof_name, d.dept_name, p.salary, s.shift, s.working_hours
FROM Professor as p
NATURAL JOIN Department as d
NATURAL JOIN Shift as s
WHERE p.prof_id = 2;

SELECT d.dept_name
from Department as d
NATURAL JOIN Professor as p;


