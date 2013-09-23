--Zack Meath's HW2 from Database Management
--1
select city
from agents
where aid in (
	select aid
	from orders
	where cid = 'c002'
	)
	
--2
select distinct pid
from orders
where aid in (
	select aid
	from orders
	where cid in (
		select cid
		from customers
		where city = 'Kyoto'
		)
	)
	
--3
select cid, name
from customers
where cid not in (
	select cid
	from orders
	where aid = 'a03'
	)
	
--4
select cid, name
from customers
where cid in (
	select cid 
	from orders
	where pid = 'p01' and cid in (
		select cid 
		from orders
		where pid = 'p07'
		)
	)
	
	
--5
select distinct pid
from orders
where cid in (
	select cid 
	from orders
	where aid = 'a03'
	)
	
--6
select name, discount
from customers
where cid in (
	select cid 
	from orders
	where aid in (
		select aid
		from agents 
		where city = 'Dallas' or city = 'Duluth'
		)
	)
--7
--It just says 'Find all customers who have... '
--and im not sure what data to select so I just did cid
select cid
from customers
where discount in (
	select discount
	from customers
	where city = 'Dallas' or city = 'Kyoto'
	)
