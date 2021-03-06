--Zack Meath's Homework #3 for Database Management

--1. Get the cities of agents booking an order for customer c002. Use a subquery.
select city
from agents
where aid in (
	select aid
	from orders
	where cid = 'c002'
	);

--2. Get the cities of agents booking an order for customer c002. This time, no subqueries.
select a.city
from agents a, orders o
where a.aid = o.aid and o.cid = 'c002';

--3. Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto. Use subqueries.
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
order by pid;

--4. Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto. Use joins this time; no subqueries.
select distinct p.pid
from orders o
inner join customers c on c.cid = o.cid and c.city = 'Kyoto'
inner join orders o2 on o.aid = o2.aid
inner join products p on o2.pid = p.pid
order by p.pid

--5. Get the names of customers who have never placed an order. Use a subquery.
select name
from customers
where cid not in (
	select distinct cid
	from orders
	);
	

--6. Get the names of customers who have never placed an order. Use an outer join.
select c.name
from customers c 
left outer join orders o
ON o.cid=c.cid
where ordno is null;


--7. Get the names of customers who placed at least one order through an agent in their city, along with those agent(s) names.
select distinct c.name, a.name
from customers c 
inner join orders o on c.cid = o.cid
inner join agents a on a.city = c.city

--8. Get the names of customers and agents in the same city, along with the name of the city, 
--regardless of whether or not the customer has ever placed an order with that agent.
select distinct c.name, a.name, c.city
from customers c, agents a
where  c.city = a.city
order by city;

--9. Get the name and city of customers who live in the city where the least number of products are made.
select c.name, c.city
from customers c
where c.city in (
	select p.city
	from products p
	group by p.city
	order by count(p.city) asc
	limit 1
);

--10. Get the name and city of customers who live in a city where the most number of products are made.
select c.name, c.city
from customers c
where c.city in (
	select p.city
	from products p
	group by p.city
	order by count(p.city) desc
	limit 1
);


--11. Get the name and city of customers who live in any city where the most number of products are made.
select c.name, c.city
from customers c
where c.city in (
	select p.city
	from products p
	group by p.city
	order by count(p.city) desc
	limit 2
)

--12. List the products whose priceUSD is above the average priceUSD.
select *
from products
where priceUSD > (
	select avg(priceUSD)
	from products
	);

--13. Show the customer name, pid ordered, and the dollars for all customer orders, sorted by dollars from high to low.
select c.name, o.pid, o.dollars
from customers c, orders o
where c.cid = o.cid
order by dollars desc;

--14. Show all customer names (in order) and their total ordered, and nothing more. Use coalesce to avoid showing NULLs.
select c.name, coalesce( sum(o.dollars), 0.00)
from customers c left outer join orders o
on c.cid = o.cid
group by c.cid
order by c.name;

--15. Show the names of all customers who bought products from agents based in New York along with the names of the products they ordered, 
--and the names of the agents who sold it to them.
select c.name, p.name, a.name
from customers c full outer join orders o on o.cid = c.cid 
full outer join agents a on a.aid = o.aid 
full outer join products p on p.pid = o.pid
where a.city='New York';

--16. Write a query to check the accuracy of the dollars column in the Orders table. 
select (o.qty *  p.priceUSD) * (1 - c.discount/100), o.dollars
from products p right outer join orders o on p.pid=o.pid
left outer join customers c on c.cid = o.cid
where (o.qty * p.priceUSD) * (1 - c.discount/100) = o.dollars;

--17. Create an error in the dollars column of the Orders table so that you can verify your accuracy checking query
insert into orders( ordno, mon, cid, aid, pid, qty, dollars )
  values(1027, 'dec', 'c006', 'a01', 'p01', 1000, 7.00);