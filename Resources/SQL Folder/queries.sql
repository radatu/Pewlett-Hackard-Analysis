--  Data is from https://github.com/vrajmohan/pgsql-sample-data/tree/master/employee
-- Creating queries for PH-EmployeeDB


-- Retirement eligibility
SELECT COUNT(first_name, last_name)
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create a new table derived from this previous data for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the derived table
SELECT * FROM retirement_info;

--To export retirement_info into a CSV follow these steps:

-- Keep the Import/Export button toggled to "Export."
-- Click on the ... in the Filename field to automatically select the same directory from which you imported the other CSVs. Select a directory, but be sure to rename it to retirement_info.csv.
-- Make sure the absolute path is in the filename: e.g. /Users/radatus/Desktop/GitHub/Pewlett-Hackard-Analysis_Ch7/Starter_Code/Resources/Data/retirement_info.csv
-- Be sure the format is still CSV.
-- Toggle the Header section to "Yes" to include column names in the new CSV files.
-- Select the comma as the delimiter to maintain the same format with all CSV files.
-- Click OK to start the export. After the file has been created, pgAdmin will confirm our file is ready to be viewed.

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
    FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Joining retirement_info and dept_emp tables with ALIASES
SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Create table containing only the current employees who are eligible for retirement
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Employee count ordered by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no

-- CREATE table of current employees ordered by department
SELECT COUNT(ce.emp_no), de.dept_no
INTO current_empl_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- CREATE a list of employees containing their unique employee number, 
-- their last name, first name, gender, and salary filtered by to_date = <current>
SELECT e.emp_no,
    e.first_name,
e.last_name,
    e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- CREATE a list of managers for each department including the department number, deptment name,
-- manager's employee number, last name, first name, and starting and ending employment dates
-- List of managers per department
SELECT dm.dept_no,
    d.dept_name,
    dm.emp_no,
    ce.last_name
    ce.first_name
    dm.from_date
	dm.to_date
-- INTO manager_info
FROM department_manager as dm
    INNER JOIN departments as dm
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp as ce
        ON (dm.emp_no = ce.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- CREATE a list of current employees by department eligible to retire, including the emp_no,
-- first_name,last_name,to_date (as a <current> filter), and department name
-- List of current employee retiree candidates by department
SELECT ce.emp_no,
    ce.first_name,
    ce.last_name,
    d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);
    
-- After executing the code and checking the results, a few folks are are appearing twice. Maybe they moved departments? It's interesting how each list has given Bobby a question to ask his manager. So far, Bobby would like to know the following:

-- What's going on with the salaries?
-- Why are there only five active managers for nine departments?
-- Why are some employees appearing twice?

-- Create "tailored" lists filtering for one category or two
SELECT ce.emp_no,
    ce.first_name,
    ce.last_name,
    d.dept_name
INTO mentoring_eligible_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
-- to filter for only one category, e.g. the Sales department data:
-- WHERE d.dept_name = 'Sales';
-- to filter for two or more categories, e.g. the Sales AND Development department data
WHERE d.dept_name IN ('Sales', 'Development'); 