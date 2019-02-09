select * from employees;

-- 1.	Select all job titles whose maximum salary is > 10000 (9 rows)

select job_title, max_salary from jobs where max_salary>10000 limit 9;

-- 2.	Select all job titles whose minimum salary is > 8000 and max salary < 20000 (3 rows)

select job_title from jobs where max_salary<20000 and min_salary >8000 limit 3;

-- 3.	Select all locations (id, city) which do not have any state province mentioned (6 rows)

select  location_id ,city,state_province from locations where state_province is null limit 6;

-- 4.	List all IT related departments where there are no managers (2 rows)

select  department_name,manager_id from departments where manager_id is null limit 2;

-- 5.	List all departments with managers for location id 1700 (5 rows)

select department_name,location_id from departments where location_id=1700 limit 5;

-- 6.	For how many years did employee 101 work as Account Manager? (1 row, 3.38... yrs)

select datediff(end_date,start_date)/365 as "Experience" 
from job_history a 
where employee_id=101 and job_id like'AC_MGR' ;

-- 7.	List employee id, first name and their GROSS salaries whose monthly GROSS salary > 15000. 
--    Show least to highest gross salaries in the output (6 rows)

select employee_id,first_name,salary*12 
from employees 
where salary>10000
order by salary 
limit 6;

-- 8.	Show location id and cities of US or UK
-- whose city name starts from 'S' but not from 'South'. (2 rows)
select * from locations;
select location_id, city from locations
where country_id in('US','UK') and city like ('S%') and city not like'South%'
limit 2;

-- 9.  Print a bonafide certificate for an employee (say for emp. id 123) as below:
#"This is to certify that <full name> with employee id <emp. id> is working as <job id> in dept. <dept. no.> since <join date>. 
#His/her annual gross salary is $<gross_sal>.00". (1 row - 1 column)


select concat("This is to certify that ",concat(first_name,' ',last_name),
" with employee id ",employee_id,
" is working as ",job_id," in dept ",department_id,
" since ",hire_date," .His/her annual gross salary is $",salary*12) "Bonafied Certificate"
 from employees limit 1;
 
 -- 10.	Write a query for the current income tax rate (input in terms of %) 
 -- and for an employee_id as input, show the employee_id, first_name, annual salary, 
 -- tax rate, the tax amount and the net annual salary (1 row)
 
 
 select * from employees limit 5;
 
delimiter //
create procedure get_details(
 tax_rate float(20), emp_id varchar(50))
	begin  
	select employee_id,first_name,salary*12 AS annual_salary,tax_rate,(salary*12*tax_rate) as tax_amount,((salary*12)-(salary*12*tax_rate)) as net_annual_salary
	from employees where employee_id=emp_id and tax_rate=tax_rate;	
	end //


 call get_details(0.05,'101');
#delimiter;