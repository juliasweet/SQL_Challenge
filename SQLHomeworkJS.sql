--- Queries
--1. List the following details of each employee: 
--employee number, last name, first name, gender, and salary.
SELECT emp.emp_no, emp.last_name, emp.first_name, emp.gender, sal.salary
FROM employees AS emp
INNER JOIN  salaries AS sal ON
emp.emp_no = sal.emp_no
--Returns 300,024 rows

--2. List employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1986-01-01' AND
hire_date <= '1986-12-31'
--Returns 36,150 rows. 
--These are weird names, even for the 80s. 

--3. List the manager of each department with the following information: 
--department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates.
SELECT dept.dept_no, dept.dept_name, emp.emp_no, emp.first_name, emp.last_name, dept_man.from_date, dept_man.to_date 
FROM departments AS dept
JOIN dept_manager AS dept_man
ON dept.dept_no = dept_man.dept_no
	JOIN employees AS emp
	ON emp.emp_no = dept_man.emp_no
--Returns 24 rows. 
-- Just 24 managers? For this many employees?  

--4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees AS emp
JOIN dept_emp 
ON dept_emp.emp_no= emp.emp_no
	JOIN departments AS dept
	ON dept.dept_no = dept_emp.dept_no
GROUP BY emp.emp_no, dept.dept_name
--Returns 331,603 rows

--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules' AND
last_name LIKE 'B%'
--Returns 20 rows. That's a lot of Hercules Bs. 

--6. List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees AS emp
JOIN dept_emp 
ON dept_emp.emp_no= emp.emp_no
	JOIN departments AS dept
	ON dept.dept_no = dept_emp.dept_no
	WHERE dept.dept_name = 'Sales'
GROUP BY dept.dept_name, emp.emp_no;
--Returns 52,245 rows. That's an awful lot of employees for the number of managers. 


--7. List all employees in the Sales and Development departments, including their 
--employee number, last name, first name, and department name.
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees AS emp
JOIN dept_emp 
ON dept_emp.emp_no= emp.emp_no
	JOIN departments AS dept
	ON dept.dept_no = dept_emp.dept_no
	WHERE dept.dept_name = 'Sales' OR dept.dept_name = 'Development'
GROUP BY emp.emp_no, dept.dept_name;
-- Returns 137,952 rows. 

--Extra query to determine overlap
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees AS emp
JOIN dept_emp 
ON dept_emp.emp_no= emp.emp_no
	JOIN departments AS dept
	ON dept.dept_no = dept_emp.dept_no
	WHERE dept.dept_name = 'Sales' AND dept.dept_name = 'Development'
GROUP BY emp.emp_no, dept.dept_name;
--None?
-- Note to self: don't go for management at this company unless you want to burn out.

--8. In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS last_name_frequency
FROM employees
GROUP BY last_name
ORDER BY last_name_frequency DESC;
-- These unique names are suspiciously common. 