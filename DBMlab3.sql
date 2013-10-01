--FY table
drop table if exists fy;
create table fy (
year int primary key,
startdate date not null,
enddate date not null
);

--department table
drop table if exists departments;
create table departments (
did text primary key,
name text not null,
datefound date not null
);

--people table
drop table if exists people;
create table people (
pid serial primary key,
fname text not null,
lname text not null,
hiredate date not null,
did text not null references departments(did)
);


--Insert values into FY
INSERT INTO fy( year, startdate, enddate )
  VALUES(2012, '2011-07-01', '2012-06-30'),(2013, '2012-07-01', '2013-06-30'),(2014, '2013-07-01', '2014-06-30'),(2015, '2014-07-01', '2015-06-30');
--Insert values into departments  
insert into departments ( did, name, datefound )
  values('a','CS','2010-06-30'), ('b','IT','2013-01-01'),('c','IS','2014-07-04');
  --Insert values into people
insert into people (fname, lname, hiredate, did)
values ('Zack','Meath','2008-01-23','a'),('Aaron','Kippins','2006-09-28','a'),('Rob','Rizzacasa','2012-04-04','b'),('Brian','Valzovano','2013-11-11','b'),('Alex','Treiber','2014-11-11','b');


--Queries

--1
select *
from people p, departments d
where p.did = d.did

--2
select *
from people p left outer join fy f on (p.hiredate >= f.startdate and p.hiredate <= f.enddate) left outer join departments d on (p.did = d.did)

--3
select count(*), d.name
from people p left outer join departments d
where p.did = d.did
group by d.name

--4
select count(*), f.year
from people p, fy f
where p.hiredate >= f.startdate and p.hiredate <= f.enddate
group by f.year

--5
select count(*), f.year
from departments d, fy f
where d.datefound >= f.startdate and d.datefound <= f.enddate
group by f.year

--6
select name
from departments
where did not in (
	select did
	from people
	)
	
--7
select *
from people
where did not in (
	select did
	from departments
	)
	
--8
select p.fname, p.lname, p.hiredate, d.datefound
from people p, departments d
where p.did = d.did and p.hiredate < d.datefound