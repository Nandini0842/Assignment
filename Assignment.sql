create database mydb;
use mydb;
create table Employee
( Id int,
  Employee_Name varchar(255),
  Gender varchar(255),
  Basic int,
  HR int,
  DA int,
  Tax int,
  Dept_ID int
);
use mydb;
create table Department
( DeptID int,
  DeptName varchar(255),
  DeptHeadID int
);
use mydb;
create table EmployeeAttendance
( EmpId int,
  Attendance_Date date,
  WorkingDays int,
  PresentDays int
); 
  
insert into Employee values(1 ,'Anil',' Male', 10000 ,5000 ,1000 ,400,1);
insert into Employee values(2 ,'Sanjana',' Female', 12000 ,6000 ,1000 ,500,2);
insert into Employee values(3 ,'Johnny',' Male', 5000 ,2000 ,500 ,200,3);
insert into Employee values(4 ,'Suresh',' Male', 6000 ,3000 ,500 ,250,1);
insert into Employee values(5 ,'Anglia',' Female', 11000 ,5000 ,1000 ,500,4);
insert into Employee values(6 ,'Saurabh',' Male', 12000 ,6000 ,1000 ,600,1);
insert into Employee values(7 ,'Manish',' Male', 4000 ,2000 ,500 ,150,2);
insert into Employee values(8 ,'Neeraj',' Male', 5000 ,2000 ,500 ,200,3);
insert into Employee values(9 ,'Suman',' Female', 5000 ,2000 ,500 ,200,4);
insert into Employee values(10 ,'Tina',' Female', 6000 ,3000 ,500 ,220,1);


insert into Department values(1,'HR',1);
insert into Department values(2,'Admin',2);
insert into Department values(3,'Sales',9);
insert into Department values(4,'Engineering',5);

insert into EmployeeAttendance values(1,'2010-01-01',22,21);
insert into EmployeeAttendance values(1,'2010-02-01',20,20);
insert into EmployeeAttendance values(1,'2010-03-01',22,20);

insert into EmployeeAttendance values(2,'2010-01-01',22,22);
insert into EmployeeAttendance values(2,'2010-02-01',20,20);
insert into EmployeeAttendance values(2,'2010-03-01',22,22);

insert into EmployeeAttendance values(3,'2010-01-01',22,21);
insert into EmployeeAttendance values(3,'2010-02-01',20,20);
insert into EmployeeAttendance values(3,'2010-03-01',22,21);

insert into EmployeeAttendance values(4,'2010-01-01',22,21);
insert into EmployeeAttendance values(4,'2010-02-01',20,19);
insert into EmployeeAttendance values(4,'2010-03-01',22,22);

insert into EmployeeAttendance values(5,'2010-01-01',22,22);
insert into EmployeeAttendance values(5,'2010-02-01',20,20);
insert into EmployeeAttendance values(5,'2010-03-01',22,22);

insert into EmployeeAttendance values(6,'2010-01-01',22,21);
insert into EmployeeAttendance values(6,'2010-02-01',20,20);
insert into EmployeeAttendance values(6,'2010-03-01',22,20);

insert into EmployeeAttendance values(7,'2010-01-01',22,21);
insert into EmployeeAttendance values(7,'2010-02-01',20,20);
insert into EmployeeAttendance values(7,'2010-03-01',22,21);

insert into EmployeeAttendance values(8,'2010-01-01',22,21);
insert into EmployeeAttendance values(8,'2010-02-01',20,20);
insert into EmployeeAttendance values(8,'2010-03-01',22,21);

insert into EmployeeAttendance values(9,'2010-01-01',22,22);
insert into EmployeeAttendance values(9,'2010-02-01',20,20);
insert into EmployeeAttendance values(9,'2010-03-01',22,21);

insert into EmployeeAttendance values(10,'2010-01-01',22,22);
insert into EmployeeAttendance values(10,'2010-02-01',20,20);
insert into EmployeeAttendance values(10,'2010-03-01',22,22);


use mydb;
 select count(*) as No_of_Employees,Gender,DeptName
from Employee inner join Department
on Employee.Dept_ID=Department.DeptID
group by DeptName,Gender;

CREATE FUNCTION calculates(id int)
returns table
as
return(select Basic+HR+DA-Tax from Employee where Employee.Id=id);


DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_gross`(id int) RETURNS int(11)
BEGIN
return(select Basic+HR+DA from Employee
where Employee.Id=id);
END$$
DELIMITER ;




select count(*) as No_of_Employees,
DeptName,
sum(calculate(Employee.Id)) as 'Total Salary',
max(calculate_gross(Employee.Id)) as 'Highest Gross Salary'
from Employee inner join Department
on Employee.Dept_ID=Department.DeptID
group by DeptName;




 select DeptName,
Employee_Name as 'Name_of_Employee',
max(calculate_gross(Employee.Id)) as 'Highest Gross Salary'
from Employee inner join Department
on Employee.Dept_ID=Department.DeptID
group by DeptName;

 select Id,Employee_Name
from Employee
where calculate_gross(Id)>15000;

 
select max(Basic) 
from Employee
where Basic<(select max(Basic) from Employee);

select DeptName,
count(*) as No_of_Employees
from Employee inner join Department
on Employee.Dept_ID=Department.DeptID
group by DeptName
having count(*)>3;
 
select DeptName,
Employee_Name as 'Dept Head Name'
from Department,Employee
where Department.DeptHeadID=Employee.Id;

select Employee_Name
from Employee inner join EmployeeAttendance
on Employee.Id=EmployeeAttendance.EmpID
group by Employee_Name
having (sum(WorkingDays)-sum(PresentDays))=0
;

select t2.Employee_Name
from
 (select t1.wd-t1.pd as atten,t1.Employee_Name
from
 (
select sum(WorkingDays) as wd,sum(PresentDays) as pd,Employee_Name
from Employee inner join EmployeeAttendance
on Employee.Id=EmployeeAttendance.EmpID
group by Employee_Name
) as t1
) as t2
having max(atten);

select Employee_Name
from Employee inner join EmployeeAttendance
on Employee.Id=EmployeeAttendance.EmpID
group by Employee_Name
having (sum(WorkingDays)-sum(PresentDays))>3;

