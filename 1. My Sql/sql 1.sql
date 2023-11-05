use employees;
select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;
show index from employees;

# SQL select Statement#

select * from employees;
select * from employees where first_name = 'Denis' and gender = 'M';
select * from employees where first_name = 'Denis' or gender = 'M';
select * from employees where first_name = 'Denis' and ( gender = 'M' or gender = 'M'); 
select * from employees where first_name = 'Denis' or first_name = 'Mark' or first_name = 'Nathan';
select * from employees where first_name in ('Denis' ,'Mark' ,'Nathan');
select * from employees where first_name not in ('Denis' ,'Mark' ,'Nathan');
select * from employees where first_name like ( 'Den%');
select * from employees where first_name like ( '%en');
select * from employees where first_name like ( '%en%');
select * from employees where first_name not like ( 'Den%');
select * from employees where first_name not like ( '%en');
select * from employees where first_name not like ( '%en%');
select * from employees where hire_date between '1990-01-01' and '2000-01-01';
select * from employees where hire_date not between '1990-01-01' and '2000-01-01';
select * from employees where first_name is null;
select * from employees where first_name is not null;
select * from employees where first_name <> 'mark';
select * from employees where first_name != 'mark';
select * from employees where hire_date > '2000-01-01';
select distinct * from employees;

# SQL Aggregate Function #
select count(salary) from salaries;
select count(*) from salaries;
select count(distinct (salary))from salaries;
select sum(salary) from salaries;
select min(salary) from salaries;
select max(salary) from salaries;
select avg(salary) from salaries;
select round( avg(salary),2 )from salaries;

select * from employees order by first_name ;
select * from employees order by first_name desc;
select * from employees group by first_name ;
select emp_no,count(salary) from salaries group by emp_no;
select First_name , count(first_name) from employees group by emp_no;
select First_name , count(first_name) as total from employees group by emp_no;
select * from employees having hire_date > '2000-01-01';
select * from employees group by first_name having count(first_name) > 250 order by first_name ;
select First_name , count(first_name) as total from employees where hire_date >'1999-01-01'group by first_name having count(first_name) < 200 order by first_name ;
select * from employees limit 500;

# SQL Joins #

select e.emp_no,e.first_name,e.last_name,e.hire_date,s.salary from employees e inner join salaries s on e.emp_no = s.emp_no order by e.emp_no;
select e.emp_no,e.first_name,e.last_name,e.hire_date,s.salary from employees e left join salaries s on e.emp_no = s.emp_no order by e.emp_no;
select e.emp_no,e.first_name,e.last_name,e.hire_date,s.salary from employees e right join salaries s on e.emp_no = s.emp_no order by e.emp_no;
select e.emp_no,e.first_name,e.last_name,e.hire_date,s.salary from employees e cross join salaries s on e.emp_no = s.emp_no order by e.emp_no;
select e.emp_no,e.first_name,e.last_name,e.hire_date,s.salary from employees e  join salaries s on e.emp_no = s.emp_no where e.first_name = 'George';

# SQL Joins Aggregate Function #

select e.emp_no,e.gender,avg(s.salary) as Avg_Sal from employees e inner join salaries s on e.emp_no = s.emp_no group by gender;

# join with join #
select e.emp_no,e.first_name,e.last_name,e.hire_date, t.title,s.salary from employees e  join titles t on e.emp_no = t.emp_no join salaries s on t.emp_no = s.emp_no;

# Union #
select first_name from employees union select salary from salaries;

# Sub Query #
select e.first_name ,e.last_name from employees e where e.emp_no in (select s.salary from salaries s);
select e.first_name ,e.last_name from employees e where exists (select s.salary from salaries s);

