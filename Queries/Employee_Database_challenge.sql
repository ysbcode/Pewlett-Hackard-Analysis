-- Employee Database Challenge Deliverable 1: The Number of Retiring Employees by Title
-- Retrieve the emp_no, first_name, and last_name from the Employees table
-- Retrieve the title, from_date, and to_date from the Titles table
-- Join the two tables using the primary key, filter data by birth_date range given and order by emp_no
-- Enter the data into a new table using the INTO function

SELECT
e.emp_no,
e.first_name,
e.last_name,
t.title,
t.from_date,
t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC
;

--Retrieve the employee number, first and last name, and title columns from the Retirement Titles table
-- Use Dictinct ON employee number with Orderby on most recent title to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) 
rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO ritirement_titles_unique
FROM retirement_titles AS rt
ORDER BY emp_no ASC, from_date DESC
;

-- Retrieve the number of employees by their most recent job title who are about to retire
-- Enter the data into a new table which has title the count of employees (descending order

SELECT
COUNT (rtu.emp_no),
rtu.title
INTO retiring_titles
FROM ritirement_titles_unique as rtu
GROUP BY rtu.title
ORDER BY rtu.count DESC
;

-- Deliverable 2: The Employees Eligible for the Mentorship Program
-- Create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program

SELECT DISTINCT ON (e.emp_no)
e.emp_no,
e.first_name,
e.last_name,
dt.from_date,
dt.to_date,
t.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as dt
ON e.emp_no = dt.emp_no
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (dt.to_date = '9999-01-01')
ORDER BY e.emp_no
;
