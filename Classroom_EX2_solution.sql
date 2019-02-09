-- 1.	How many currency notes of 500, 200, 100 & 50 denominations each would be required 
-- to disburse salary for every employee in department 30?

select salary,floor(salary/500) as deno_500,floor((salary%500)/200) as deno_200,
floor((salary%500)%200/100) as deno_100,floor((salary%100)/50) as deno_50
from employees where department_id=30;

-- 2.	How many cartons would be required to store 12345 gift boxes 
-- (that need to be disbursed to employees) if each carton capacity is 144 gift boxes? 
-- If only FULL cartons are to be shipped to another location, 
-- how many cartons are shippable? Write one single query to show these two values.

select ceil(12345/144) as total_cartons,floor(12345/144) as full_cartons,12345%144 as remaining_gift_boxes;

select (12345%144);

-- 3.	Show names of employees whose first name as well as last name ends with vowels. (5 rows)
select first_name,last_name from employees 
where substr(first_name,-1) in('a','e','i','o','u') and 
 substr(last_name,-1) in('a','e','i','o','u');

-- 4.	Show emp id, salary & salary range of employees as 'Tier1', 'Tier2' or 'Tier3' 
-- as per the range <5000, 5000-10000, >10000 respectively, ordering the output by those tiers.
select employee_id ,salary,
case  
	when salary<5000 then "Tier1"
	when salary between 5000 and 10000 then "Tier2"
	when salary >10000 then "Tier3"
end as Tier
from employees order by Tier ;   

-- 5.	Get the job id-wise count of employees in the reverse order of the count (19 rows)
select job_id,count(*) as emp_count from employees group by(job_id) order by count(*) desc limit 19  ;

-- 6.	Display count, average (rounded to 2 decimals) & 
-- total salaries of all employees where the avg salary > 5000, 
-- under their respective manager ids, in the reverse order of total salaries. (11 + 1 rows)
select  manager_id,count(*), avg(salary) as Avg_salary,sum(salary) as Total_salary 
from employees group by (manager_id) having avg(salary)>5000 order by Total_salary desc limit 12 ;

-- 7.	Show no. of employees present in each department (exclude NULL dept.s, if any) (11 rows)
select department_id,count(*) 
from employees group by department_id having department_id is not NULL limit 11;

-- 8.	Show department-wise and job-id-wise total gross salaries of employees 
-- whose gross salary is more than 25000 (8 rows)
select department_id,job_id,(salary*12) as Gross_sal from employees where (salary*12)>25000
 group by department_id,job_id
limit 8;

-- 9.	Show count of cities in all countries other than US & UK, with more than 1 city, in the reverse order of country id. (4 rows)

select country_id, count(*)
from locations group by country_id having country_id not in('US','UK')
order by count(*) desc limit 4;

select country_id, count(*)
from locations group by country_id ;

select avg(min_salary) from jobs ;
-- 10.--	What is the average salary range
--  (diff. between min & max salary) of all types 'Manager's and 'Clerk's? (2 rows)
select * from jobs;

select job_title,(max_salary-min_salary) as Avg_sal_range from jobs 
group by job_title having job_title like '%Clerk' or job_title like '%Manager';

select avg(max_salary-min_salary),
case	
	when job_title like '%Manager%' then "Manager"
	when job_title like '%Clerk' then "Clerk"
    else "Others"
end as Job_type   
from jobs
group by job_type having job_type like '%Clerk' or job_type like '%Manager'
;  
