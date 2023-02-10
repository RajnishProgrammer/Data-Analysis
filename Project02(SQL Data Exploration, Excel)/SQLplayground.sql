/*
This is SSMS SQL play field. Here I play with basics , intermediate and advanced topic
of SQL SSMS for the better understanding of SQL queries.
*/
------------------------------------------------------------- SQL BASICS -----------------------------------------------------------------------------

-- Table for EmployeeDemographics

create table EmployeeDemographics
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

-- Table for EmployeeSalary

create table EmployeeSalary
(EmployeeID int,
JobTitle varchar(50),
Salary int
)

-- Inserting values in Tables

INSERT INTO EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male')

INSERT INTO EmployeeDemographics VALUES
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

insert into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

-- Viewing Everything From Tables

select * from EmployeeDemographics
select * from EmployeeSalary

-- select statement *, TOP, DISTINCT, COUNT, AS, MAX, MIN, AVG

SELECT  Top(3) *
from EmployeeDemographics

select Distinct(EmployeeDemographics.Age)
from EmployeeDemographics

select COUNT(EmployeeID) as FirstNameCount
from EmployeeDemographics

select Max(Salary) as MaxSalary
From EmployeeSalary

select AVG(Salary) as AvgSalary
From EmployeeSalary

select MIN(Salary) as MinSalary
From EmployeeSalary

-- where statement =, <, >, And, Or, Like, Null, Not Null, In

select * 
from EmployeeDemographics

select *
from EmployeeDemographics
where FirstName <> 'Jim'    -- "<>" means except that give me what i ask.

select *
from EmployeeDemographics
where Age <= 32 or Gender='Male'

/* 
In this piece of query I trying to get the list of employees 
for those who have age <= 30 and their salary is >= to avg_Salary
for that I have to write the subquery first so that I can get a avg_salary_table and 
with that I can get avg_salary column for comparing with Salary column.
*/
-------------------------------------------------------------------------------------
select ed.*, es.*
from(
select  Avg(salary) as avg_salary
from EmployeeSalary
) avg_salary_table, EmployeeDemographics ed, EmployeeSalary es
where Age <= 30 and Salary>=avg_salary
---------------------------------------------------------------------------------------

select *
from EmployeeDemographics
where LastName Like 'm%N%'

select *
from EmployeeDemographics
where FirstName is Not NULL

select *
from EmployeeDemographics
where FirstName is NULL


select *
from EmployeeDemographics
where FirstName In ('Jim', 'pam', 'Angela')

-- Group By, Order By

select *
from EmployeeDemographics
order by Age Desc, Gender Desc

select *
from EmployeeDemographics
order by Gender Desc, Age Desc

-- By column number
select *
from EmployeeDemographics
order by 4 desc, 5 desc
select *
from EmployeeDemographics
order by 5 desc, 4 desc

select Gender, COUNT(Gender) as CountGender
from EmployeeDemographics
where Age>31
Group by Gender
Order by CountGender Desc

---------------------------------------------------------- SQL INTERMEDIATE --------------------------------------------------------

-- Add some extra values

INSERT INTO EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013,'Darryl', 'Philbin',NULL, 'Male')

INSERT INTO EmployeeSalary VALUES
(1010, NULL,47000),
(NULL, 'Salesman', 43000)

-- Joining two tables (INNER JOIN, LEFT OUTER JOIN, RIGHT OUTER JOIN, FULL OUTER JOIN)

SELECT * 
from EmployeeDemographics
Inner JOIN EmployeeSalary
on EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID

SELECT * 
from EmployeeDemographics
Full OUTER JOIN EmployeeSalary
on EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID

SELECT * 
from EmployeeDemographics
Left OUTER JOIN EmployeeSalary
on EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID

SELECT * 
from EmployeeDemographics
RIGHT OUTER JOIN EmployeeSalary
on EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID

SELECT EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary
from EmployeeDemographics
Inner JOIN EmployeeSalary
on EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID
where FirstName<>'Michael'
order by Salary desc

SELECT JobTitle, Avg(Salary) AS avg_salary
from EmployeeDemographics
Inner JOIN EmployeeSalary
on EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID
where JobTitle='Salesman'
group by JobTitle

-- Creating another table

Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')

-- Combining both table's elements(ALL)
select *
from WareHouseEmployeeDemographics
UNION ALL
select *
from EmployeeDemographics
ORDER BY EmployeeID

-- Joins help in join on some id and dont repeat the same entity
select *
from EmployeeDemographics
full outer Join WareHouseEmployeeDemographics
On EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID

select EmployeeID, FirstName, Age
from EmployeeDemographics
UNION ALL
select EmployeeID, JobTitle, Salary
from EmployeeSalary
order by EmployeeID

--> implementing CASE clause for when the condition satisfied then what we have to do........
--> clauses used are CASE, WHEN, THEN, ELSE, END(ending the case or conditional statement)

SELECT FirstName, LastName, Age,
case 
when Age>30 then 'Old'
when Age between 27 and 30 then 'young'
else 'baby'
end
from EmployeeDemographics
where Age is not Null
order by Age

select FirstName, LastName, JobTitle, Salary,
CASE 
WHEN JobTitle = 'Salesman' then Salary + (Salary * .10)
WHEN JobTitle = 'Accountant' then Salary + (Salary*.05)
WHEN JobTitle = 'HR' then Salary+(Salary*.000001)
ELSE Salary+(Salary*.03)
END AS SalaryAfterRaise
from EmployeeDemographics
join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

select JobTitle, avg(Salary)
from EmployeeDemographics
join EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
group by JobTitle
having avg(Salary)>45000 --> Here I don't have to write a subquery for avg(salary) and then compare instead i have used 'having' clause and define condition with avg salary
order by Avg(Salary) desc

select * 
from EmployeeDemographics
 update EmployeeDemographics
 set Age = 31, Gender= 'Female'
 where FirstName = 'Holly' and LastName = 'Flax'

 -- Delete clause by specifying what we want to delete with where clause
 delete From EmployeeDemographics
 where EmployeeID = 1013

 -- Joining multiple table 
 select Demo.EmployeeID, Demo.FirstName, Sal.JobTitle, Ware.Age
from EmployeeDemographics as Demo
left join EmployeeSalary as Sal
on Demo.EmployeeID = Sal.EmployeeID
left join WareHouseEmployeeDemographics as Ware
on Demo.EmployeeID = Ware.EmployeeID

--> In this query we are calculating total gender and then grouped with 'over' clause followed by subclause 'partition by' and showed it in every row with other column.

select FirstName, LastName, Gender, Salary, Count(Gender) over (partition by Gender) as TotalGender
from EmployeeDemographics as Demo
join EmployeeSalary as Sal
on Demo.EmployeeID = Sal.EmployeeID

select Gender, Count(Gender) as TotalGender
from EmployeeDemographics as demo
join EmployeeSalary as sal
on demo.EmployeeID = sal.EmployeeID
group by Gender

----------------------------------------------- ADVANCED SQL -------------------------------------------------------------------------
---------------- CTEs (Common Table Expression)  Manipulates subqueries data only exists in the scope the statment----------------------------

WITH CTE_Employee
as 
(
select FirstName, LastName, Gender, Salary, 
count(Gender) over (partition by Gender) as TotalGender,
avg(Salary) over (partition by Gender) as AvgSalary
from EmployeeDemographics as demo
join EmployeeSalary as sal
on demo.EmployeeID = sal.EmployeeID
where Salary>45000
)
select FirstName, AvgSalary, TotalGender
from CTE_Employee

-- Temp Table (actuall extract the main info and store it as temp table so we can use it further)
create table #temp_employee(
EmpId int,
JobTitle varchar(50),
salary int
)

select * from #temp_employee

Insert into #temp_employee values (
'1001', 'HR', '45000'
)

-- inserting every row of EmployeeSalary into #temp_employee
Insert into #temp_employee
SELECT * From EmployeeSalary

DROP TABLE IF EXISTS #temp_employee2
Create table #temp_employee2 (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)

Insert into #temp_employee2
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

Select * 
From #temp_employee2

SELECT AvgAge * AvgSalary as AvgMultiple
from #temp_employee2

/*
Today's Topic: String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower
*/

--Drop Table EmployeeErrors;

DROP TABLE IF EXISTS EmployeeErrors
CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

-- Using Trim, LTRIM, RTRIM for correcting type spaces issues.

Select EmployeeID, TRIM(employeeID) AS IDTRIM
FROM EmployeeErrors 

Select EmployeeID, RTRIM(employeeID) as IDRTRIM
FROM EmployeeErrors 

Select EmployeeID, LTRIM(employeeID) as IDLTRIM
FROM EmployeeErrors 

-- Using Replace for replacement of the text

Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors

-- Using Substring / string slicing

Select err.FirstName,Substring(err.FirstName,1,3) as SFname1,dem.FirstName, Substring(dem.FirstName,1,3) as SFname2, Substring(err.LastName,1,3) as SLname1, Substring(dem.LastName,1,3) as SLname2
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)

-- Using UPPER and lower

Select FirstName, LOWER(firstname)
from EmployeeErrors


Select FirstName, UPPER(FirstName)
from EmployeeErrors

/*
Today's Topic: Stored Procedures
*/
---------------------------------------------------------------------
DROP Procedure if exists Temp_Employee
go
CREATE PROCEDURE Temp_Employee
AS
DROP TABLE IF EXISTS #temp_employee
Create table #temp_employee (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)

Insert into #temp_employee
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(Salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

Select * 
From #temp_employee
-----------------------------------------------------------------------------------
exec Temp_Employee
-----------------------------------------------------------------------------------
------------------------------------------------------------------------------------
Drop Procedure if exists Temp_Employee2
GO
CREATE PROCEDURE Temp_Employee2 
@JobTitle nvarchar(100)
AS
DROP TABLE IF EXISTS #temp_employee3
Create table #temp_employee3 (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)


Insert into #temp_employee3
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
where JobTitle = @JobTitle --- make sure to change this in this script from original above
group by JobTitle

Select * 
From #temp_employee3
GO
---------------------------------------------------------------------------------------------

exec Temp_Employee2 @jobtitle = 'Salesman'
exec Temp_Employee2 @jobtitle = 'Accountant'

/*
Today's Topic: Subqueries (in the Select, From, and Where Statement)
*/

Select EmployeeID, JobTitle, Salary, avg(Salary) over(partition by JobTitle)
From EmployeeSalary

-- Subquery in Select

Select EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) as AllAvgSalary
From EmployeeSalary

-- How to do it with Partition By
Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
From EmployeeSalary

-- Why Group By doesn't works
Select EmployeeID, Salary, Avg(Salary) as AllAvgSalary
From EmployeeSalary
Group By Salary, EmployeeID
order by EmployeeID
------------------------------------->>>>>>>>>>NOTE : group by doesn't work in the above case...................

-- Subquery in From

Select a.EmployeeID, AllAvgSalary
From 
	(Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
	 From EmployeeSalary) a
Order by a.EmployeeID

-- Subquery in Where
-- Selects those employee who has age > 30
Select EmployeeID, JobTitle, Salary
From EmployeeSalary
where EmployeeID in (
	Select EmployeeID 
	From EmployeeDemographics
	where Age > 30)


-------------------------------------------------> The End <---------------------------------------------------------------------------------------------