create database HR_Project;
use hr_project;
delete from hr;

select count(*) from hr;
select * from hr;

## Renaming id column to proper name
alter table hr change column ï»¿id emp_id varchar(20) null;

describe hr;

select birthdate from hr;

## The following output shows that the safe update mode is disabled now.
set sql_safe_updates = 0;

## updating and cleaning birthdate column into one format
update hr
set birthdate = case
	when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    when birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    else null
end;	

select birthdate from hr;

## changing datatype of birthdate column from text to date format
alter table hr modify column birthdate date;

## updating and cleaning hire_date column into one format
select hire_date from hr;

update hr
set hire_date = case
	when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    else null
end;
## changing datatype of hiredate column from text to date format
alter table hr modify column hire_date date;


select termdate from hr;
## updating and cleaning termdate column into one format
update hr
set termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate !=' ';

## whereever there is empty we are filling with '0000-00-0'
UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from hr;
SET sql_mode = 'ALLOW_INVALID_DATES';

## changing datatype of termdate column from text to date format
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

describe hr;

## Add AGE column to the table, so that we can easily acess age column instead of birtdate
alter table hr add column age int;
select * from hr;

update hr
set age = timestampdiff(Year, birthdate, curdate());

select birthdate, age from hr;	

select
	min(age) as youngest,
    max(age) as oldest
from hr;

select count(*) from hr
where age <= 20;

select * from hr;
