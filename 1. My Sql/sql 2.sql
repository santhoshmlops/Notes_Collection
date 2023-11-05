# Procedure without parameter #
delimiter $$
create procedure select_employe()
begin 
select * from employees limit 1000;
end$$ 
delimiter ;

call employees.select_employe();
call select_employe();

# Procedure with in parameter #

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_salary ( IN p_emp_no INTEGER )
BEGIN
SELECT
    e.first_name , e.last_name , s.salary , s . from_date , s.to_date
  FROM  employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no

WHERE e.emp_no = p_emp_no; 
END $$
DELIMITER ;

call emp_salary(11300);

# Procedure with in and out parameter #

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_avg_salary ( IN p_emp_no INTEGER , out p_avg_salary decimal (10,2) )
BEGIN
SELECT
  avg( s.salary)
  into p_avg_salary
  FROM  employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no

WHERE e.emp_no = p_emp_no; 
END $$
DELIMITER ;

# function #

DELIMITER $$
CREATE function F_emp_avg_salary ( p_emp_no INTEGER ) returns decimal (10,2) 
deterministic no sql reads sql data
BEGIN
declare v_avg_salary decimal(10,2);
SELECT
  avg( s.salary)
  into v_avg_salary
  FROM  employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no

WHERE e.emp_no = p_emp_no; 
return v_avg_salary;
END $$
DELIMITER ;

select F_emp_avg_salary(11300);
