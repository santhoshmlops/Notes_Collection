use employees;

# Windows Function #
select emp_no, salary, row_number () over ( partition by emp_no) as row_num from salaries;
select emp_no, salary, row_number () over ( order by emp_no) as row_num from salaries;
select emp_no, salary, row_number () over ( order by emp_no desc) as row_num from salaries;

# Several Windows Function #

select emp_no, salary, 
row_number () over () as row_num1 ,
row_number () over ( partition by emp_no) as row_num2 ,
row_number () over ( partition by emp_no order by salary desc) as row_num3 ,
row_number () over ( order by salary desc) as row_num 
from salaries 
order by emp_no;

# window w in function #

select emp_no, salary, 
row_number () over w as row_num from salaries 
window w as ( partition by emp_no) ;


select distinct emp_no, salary, 
row_number () over w as row_num from salaries 
window w as ( partition by emp_no) ;

# rank method #

select emp_no, salary, 
rank () over w as rank_num from salaries 
where emp_no = 11839
window w as ( partition by emp_no order by salary desc) ;

# dense rank method #
select emp_no, salary, 
dense_rank () over w as rank_num from salaries 
where emp_no = 11839
window w as ( partition by emp_no order by salary desc) ;


# rank method with join #

SELECT e.emp_no,
RANK() OVER w as employee_salary_ranking, s.salary
FROM employees e
JOIN salaries s ON s.emp_no = e.emp_no
WHERE e.emp_no BETWEEN 10500 AND 10600
WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);

# dense rank method with join #

SELECT e.emp_no,
DENSE_RANK() OVER w as employee_salary_ranking,s.salary,e.hire_date,s.from_date,
(YEAR(s.from_date) - YEAR(e.hire_date)) AS years_from_start
FROM employees e
JOIN salaries s ON s.emp_no = e.emp_no
AND YEAR(s.from_date) - YEAR(e.hire_date) >= 5
WHERE e.emp_no BETWEEN 10500 AND 10600
WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);

# LAG and LEAD Valve window function - model 1 #

SELECT emp_no,salary,
LAG(salary) OVER w AS previous_salary,
LEAD(salary) OVER w AS next_salary,
salary - LAG(salary) OVER w AS diff_salary_current_previous,
LEAD(salary) OVER w - salary AS diff_salary_next_current
FROM salaries
WHERE salary > 80000 AND emp_no BETWEEN 10500 AND 10600
WINDOW w AS (PARTITION BY emp_no ORDER BY salary);

# LAG and LEAD Valve window function - model 2 #

SELECT emp_no,salary,
LAG(salary) OVER w AS previous_salary,
LAG(salary, 2) OVER w AS 1_before_previous_salary,
LEAD(salary) OVER w AS next_salary,
LEAD(salary, 2) OVER w AS 1_after_next_salary
FROM salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary)
LIMIT 1000;

# Aggregate Functions in the Context of Window Functions -1  #

SELECT s1.emp_no, s.salary, s.from_date, s.to_date
FROM salaries s
JOIN
(SELECT emp_no, MIN(from_date) AS from_date
FROM salaries
GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
s.from_date = s1.from_date;

# Aggregate Functions in the Context of Window Functions - 2 #
SELECT 
de2.emp_no, d.dept_name, s2.salary, AVG(s2.salary) OVER w AS average_salary_per_department
FROM
(SELECT de.emp_no, de.dept_no, de.from_date, de.to_date
FROM dept_emp de
JOIN
(SELECT emp_no, MAX(from_date) AS from_date
FROM dept_emp
GROUP BY emp_no) de1 ON de1.emp_no = de.emp_no
WHERE de.to_date < '2002-01-01'
AND de.from_date > '2000-01-01'
AND de.from_date = de1.from_date) de2
JOIN
(SELECT s1.emp_no, s.salary, s.from_date, s.to_date
FROM salaries s
JOIN
(SELECT emp_no, MAX(from_date) AS from_date
FROM salaries
GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
s.to_date < '2002-01-01'
AND s.from_date > '2000-01-01'
AND s.from_date = s1.from_date) s2 ON s2.emp_no = de2.emp_no
JOIN
departments d ON d.dept_no = de2.dept_no
GROUP BY de2.emp_no, d.dept_name
WINDOW w AS (PARTITION BY de2.dept_no)
ORDER BY de2.emp_no, salary;


