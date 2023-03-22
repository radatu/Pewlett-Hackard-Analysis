-- Challenge 7 
-- Deliverable 1 queries

--Create Retirement Titles table
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
-- AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31') --not part of Deliverable 1
AND (ti.to_date = '9999-01-01')
ORDER BY e.emp_no;

-- Unique Titles
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
-- Use subquery to avoid needing to repeat column "to_date" from SELECT DISTINCT ON
FROM (
    SELECT *
    FROM retirement_titles
    WHERE to_date = '9999-01-01'
    ORDER BY emp_no, to_date DESC
) AS rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- Create retiring_titles count by title
DROP TABLE retiring_titles; --necessary to avoid duplicate rows
CREATE TABLE retiring_titles (
    title_count INTEGER,
    title VARCHAR(255)
);

INSERT INTO retiring_titles (title_count, title)
SELECT COUNT(ut.title) AS title_count,
       ut.title
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY title_count DESC;

SELECT * FROM retiring_titles


-- Deliverable 2
-- Mentorship Eligibility
-- create a mentorship-eligibility table 
-- that holds the current employees who were 
-- born between January 1, 1965 and December 31, 1965.
-- Create a new table derived from this previous data for retiring employees
-- Create "mentoring_eligible_info" list filtering for one category or two
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentoring_eligible_info
FROM employees as e
LEFT JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE de.to_date = '9999-01-01'
AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no, de.to_date DESC;

-- ***************************
-- Additional queries examples:
-- delete an entire table—
-- DROP TABLE unique_titles;
-- query an entire table 
-- SELECT * FROM retirement_titles

-- Extra Query 1
-- Count of Senior and Leader "Mentorship Eligible" Employees
SELECT COUNT(mei.title)
FROM mentoring_eligible_info AS mei
WHERE mei.title LIKE '%Senior%' OR mei.title LIKE '%Leader%';

-- Extra Query 2
-- Roster of "Mentorship Eligible" senior and leader employees retiring
CREATE TABLE senior_leaders_retiring AS
SELECT *
FROM mentoring_eligible_info AS mei
WHERE mei.title LIKE '%Senior%' OR mei.title LIKE '%Leader%';