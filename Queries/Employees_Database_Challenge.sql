--Determine the number of retiring employees per title, 
--and identify employees who are eligible to participate
--in a mentorship program.


--Step 1: Query to get the Number of Retiring Employees by Title with duplicate titles

SELECT employees.emp_no,
employees.first_name,employees.last_name,
titles.title ,titles.from_date, titles.to_date
INTO retirement_titles
FROM employees
INNER JOIN titles
ON titles.emp_no = employees.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY titles.emp_no;





SELECT * 
FROM  retirement_titles;


--Step 2:Query to get the Number of Retiring Employees by Title with Distinct on emp no
SELECT DISTINCT ON (E.emp_no) E.emp_no,
E.first_name,E.last_name,
T.title ,T.from_date, T.to_date
INTO unique_titles
FROM employees as E
INNER JOIN titles as T 
ON T.emp_no = E.emp_no
WHERE (E.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND
		(T.to_date = '9999-01-01' )
ORDER BY E.emp_no;

SELECT *
FROM unique_titles;


--Step3: Get the count of retiring employees for each title.
SELECT title ,COUNT(title) AS TitleCount
INTO retiring_titles
FROM unique_titles
GROUP BY title 
ORDER BY COUNT(title) DESC;




--Get the count of retiring employees for each title.
SELECT * FROM retiring_titles;








--Determine the eligilibility of Mentorship program
--It can be determined by filtering the employees that are borned in 1965
--and currently working.
DROP TABLE mentorship_eligibilty CASCADE;

SELECT DISTINCT ON (E.emp_no) E.emp_no,
E.first_name,E.last_name,
D.from_date, D.to_date,
T.title 
INTO mentorship_eligibilty
FROM 
	employees as E
INNER JOIN titles as T
	 ON T.emp_no = E.emp_no

INNER JOIN dept_emp as D
	ON D.emp_no = E.emp_no

WHERE (E.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (D.to_date = '9999-01-01')
ORDER BY E.emp_no;

SELECT * 
FROM mentorship_eligibilty;



--Get the titles that are eligible for mentorship program
SELECT title ,COUNT(title) AS TitleCount
FROM mentorship_eligibilty
GROUP BY title 
ORDER BY COUNT(title) DESC;



