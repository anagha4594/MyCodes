-- 1.	Show complete details of an employee: Full name, dept name, job title, city and country name.
select concat(e.first_name," ",e.last_name) as Full_name,j.job_title,d.department_name,l.city, l.country_id 
from employees e,jobs j, locations l,departments d
 where e.job_id=j.job_id 
 and e.department_id=d.department_id
 and d.location_id=l.location_id ;
 
 select concat(e.first_name," ",e.last_name) as Full_name,j.job_title,d.department_name,l.city, l.country_id  
 from jobs j natural join employees e natural join departments d natural join locations l limit 1; 

-- 2.	Display names of cities where there are more than 2 departments. (1 row)
select l.city ,count(d.department_id) from locations l natural join departments d group by l.city having count(d.department_id)>1;

select  l.city ,count(d.department_id) from locations l, departments d 
where l.location_id=d.location_id
group by l.city;

-- 3.	Show city, state province and dept. name for ALL locations. Show 'No Dept.' if a city doesn't have any dept. in it. (43 rows)
select l.city,l.state_province,
	case 
		when d.department_name is null then "No Dept."
        else d.department_name
	end as Department_name
   from locations l left outer join departments d on l.location_id =d.location_id limit 43; 
   
   select * from locations;
   select * from departments;
   
   select * from departments d right outer join locations l on l.location_id =d.location_id;
        
        
-- 4.	Display employees who do the same job as 'Kevin' but earn more salary than 'Kevin'. (15 rows)
select * from employees where job_id = any (select job_id from employees where first_name like 'Kevin') 
and salary >any(select salary from employees where first_name like 'Kevin');

select * from employees a natural join employees b ;


select job_id,salary from employees where first_name like'Kevin';

-- 5.	Show the employees working in the same dept and job id of 'Shelli' (4 rows)
select * from employees where (department_id,job_id) in (select department_id,job_id from employees where first_name like 'Shelli') limit 4;

select department_id,job_id from employees where first_name like 'Shelli';



-- 6.	Show count of departments located in each and every city (show 0 if there are no dept. in a city) 
-- in the order of most no. of departments to least no. of departments (8 with dept + 15 with no dept.)
select l.city,count(d.department_id)
from locations l left outer join departments d on l.location_id =d.location_id group by l.city order by count(d.department_id) desc ;
   
  
   
-- .	List cities where there are no departments. (16 rows)
select l.city,count(d.department_id)
from locations l left outer join departments d on l.location_id =d.location_id
group by l.city having count(d.department_id)=0;


-- 8.	In which countries there are maximum & minimum no. of employees working? (USA(68), Germany(1))

with cnty as (
select c.country_name,count(e.employee_id) as cnt 
from employees e 
inner join departments d  on d.department_id=e.department_id 
inner join locations l on d.location_id = l.location_id 
inner join  countries c on c.country_id=l.country_id
group by c.country_name)
select * from cnty where cnty.cnt= (select max(cnt) from cnty) or cnty.cnt=(select min(cnt) from cnty) ;

/*union 
--select * from cnty where cnty.cnt= (select min(cnt) from cnty)*/
select distinct(country_name) from countries;
#select distinct(region_id) from regions;

-- 9.	List employees with SIMILAR job as 'Ismael Sciarra' but different dept. and who draw more salary than him. (1 row)

select * from employees 
where job_id=(select job_id from employees where concat(first_name," ",last_name) like 'Ismael Sciarra') 
and department_id not in(select department_id from  employees where concat(first_name," ",last_name) like 'Ismael Sciarra')
and salary>(select salary from  employees where concat(first_name," ",last_name) like 'Ismael Sciarra') ;

select distinct(department_id) from employees where job_id like'FI_ACCOUNT';


-- 10.	How many employees' salary is higher than the average salary in each of their respective departments? 
-- Show this employee count against each department name in the reverse order of count.
select e.department_id,count(*) from employees e 
inner join
(select department_id,avg(salary) as sal from employees group by department_id ) a 
on e.department_id =a.department_id where e.salary>a.sal
group by e.department_id
order by count(*) desc;


-- 11.	List all employees belonging to job ids that have the highest no. of employees. (30 rows)

select * from employees e
where e.job_id =
(select a.job_id from (
select job_id,count(job_id) as cnt from employees group by job_id order by 2 desc limit 1) a );
  
 

-- 12.	List employees who draw more salary than their managers. (2 rows)
select b.employee_id as mgr_id,b.first_name as manager,b.salary as mgr_sal,a.employee_id as emp_id, a.first_name as employee ,a.salary as emp_sal 
from employees a inner join employees b on a.manager_id=b.employee_id where b.salary<a.salary order by manager;
