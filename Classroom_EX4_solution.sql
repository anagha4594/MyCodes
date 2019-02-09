-- 1.	How many employees salary is higher than the average salary in each of their respective departments? 
-- Show this employee count against each department name in the reverse order of count.

select e.department_id,count(*) from employees e 
inner join
(select department_id,avg(salary) as sal from employees group by department_id ) a 
on e.department_id =a.department_id where e.salary>a.sal
group by e.department_id
order by count(*) desc;

-- 2.	List all employees belonging to job ids that have the highest no. of employees.

select * from employees e where e.job_id=(select a.job_id from(select job_id ,count(*) from employees group by job_id order by 2 desc limit 1)a);

-- 3.	List employees with duplicate first names along with duplicate count.
select first_name,count(*) from employees group by first_name having count(*) >1;

-- 4.	Assume a whole employee record is duplicated (except the employee id). 
-- Write a query to delete the duplicate record (with the higher employee no.)
delete from employees  where first_name like 'Peter' and job_id like 'SA_REP';

#e.job_id=(select a.job_id from(select job_id ,count(*) from employees group by job_id order by 2  imit 1)a);

-- 5.	Create a PROJECTS table as (project id - NUMBER(10) PK, project name - VARCHAR(50) NN, 
--   proj_locn NUMBER(4) FK to Locations table, proj_leader - NUMBER(6) FK to employees)

Create table Projects (
project_id  INT(10) not null,
project_name  VARCHAR(50) not null, 
proj_locn int(4) ,
proj_leader  INT(6),
PRIMARY KEY(project_id)
);

-- 6.  Create PROJECT_ALLOCN table as (project id - FK to Projects table, employee_id - FK to Employees table, Start_dt - DATE, End_dt - Date, with employee_id & start_dt as primary key)
Create table PROJECT_ALLOCN (
employee_id INT (11) UNSIGNED NOT NULL,
project_id  INT(10) not null,
 Start_dt DATE, End_dt Date, 
 primary key(employee_id ,start_dt));
 
alter table Projects modify column proj_locn INT (11) UNSIGNED ;
alter table Projects modify column proj_leader INT (11) UNSIGNED ;

ALTER TABLE Projects ADD FOREIGN KEY fk_prd(proj_locn) REFERENCES locations(location_id);
alter table Projects add FOREIGN KEY fk_prd1(proj_leader) REFERENCES employees(employee_id);
ALTER TABLE PROJECT_ALLOCN ADD FOREIGN KEY fk_prda(project_id) REFERENCES Projects(project_id);
alter table PROJECT_ALLOCN add FOREIGN KEY fk_prda1(employee_id) REFERENCES employees(employee_id);

select l.location_id from employees e 
inner join departments d on e.department_id=d.department_id 
inner join locations l on d.location_id=l.location_id
where concat(first_name," ",last_name) like 'Adam Fripp';
	
-- 7.	Insert few rows into these tables. Create a project by name DBCONVERSION project. Make 'Adam Fripp' as its leader and location same as the location of the project leader.
-- Allocate employees who report to 'Adam Fripp' to this project starting from today. 

Insert into projects values( 111,'DBCONVERSION',
(select l.location_id from employees e 
inner join departments d on e.department_id=d.department_id 
inner join locations l on d.location_id=l.location_id
where concat(first_name," ",last_name) like 'Adam Fripp'),
(select employee_id from employees where concat(first_name," ",last_name) like 'Adam Fripp'));

select * from projects;

select employee_id from employees where manager_id=121;

insert into PROJECT_ALLOCN values(129,111,curdate(),curdate()+15);
insert into PROJECT_ALLOCN values(130,111,curdate(),curdate()+15);
insert into PROJECT_ALLOCN values(131,111,curdate(),curdate()+15);
insert into PROJECT_ALLOCN values(132,111,curdate(),curdate()+15);
insert into PROJECT_ALLOCN values(184,111,curdate(),curdate()+15);
insert into PROJECT_ALLOCN values(185,111,curdate(),curdate()+15);
insert into PROJECT_ALLOCN values(186,111,curdate(),curdate()+15);
insert into PROJECT_ALLOCN values(187,111,curdate(),curdate()+15);

select * from PROJECT_ALLOCN;



-- 8.	Update End date of emp. no. 186 & 187 to last date of this year.
update PROJECT_ALLOCN  set End_dt=DATE(CONCAT(YEAR(CURDATE()),"-12-31")) where employee_id in (186,187);

-- 9.	Try deleting this new project inserted into Projects table. What should be done prior to deleting it?

delete from projects where project_id=111;

 


10.	Insert your name & other details into Employees table. Department: Training. Location: Bengaluru. (Insert rows into appropriate tables if these values do not exist in them).
11.	Delete this new row inserted in the Employees table.
12.	Delete the employee records in PROJECT_ALLOCN table who report to a given manager name.


