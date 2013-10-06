--Zack Meath's Home work #3 for Database Management

--1. Get the cities of agents booking an order for customer c002. Use a subquery.
select city
from agents
where aid in (
	select aid
	from orders
	where cid = 'c002'
	)

--2. Get the cities of agents booking an order for customer c002. This time, no subqueries.
select a.city
from agents a, orders o
where a.aid = o.aid and o.cid = 'c002'

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
order by pid

--4. Get the pids of products ordered through any agent who makes at least one order for a customer in Kyoto. Use joins this time; no subqueries.
--select p.pid
--from products p,
--	 orders o,
--	 customers c,
--	 agents a
--where p.pid = o.pid and c.cid = o.cid and a.aid = o.aid

--5. Get the names of customers who have never placed an order. Use a subquery.
select name
from customers
where cid not in (
	select distinct cid
	from orders
	)
	

--6. Get the names of customers who have never placed an order. Use an outer join.
select *
from customers c left outer join orders o
ON o.cid=c.cid
where ordno is null


--7. Get the names of customers who placed at least one order through an agent in their city, along with those agent(s) names.
--get c.name, a.name
--from agents a, customers c, orders o
--where c.cid = o.cid and a.aid = o.aid

--8. Get the names of customers and agents in the same city, along with the name of the city, 
--regardless of whether or not the customer has ever placed an order with that agent.
select distinct c.name, a.name, c.city
from customers c, agents a
where  c.city = a.city
order by city

--9. Get the name and city of customers who live in the city where the least number of products are made.


--10. Get the name and city of customers who live in a city where the most number of products are made.


--11. Get the name and city of customers who live in any city where the most number of products are made.


--12. List the products whose priceUSD is above the average priceUSD.


--13. Show the customer name, pid ordered, and the dollars for all customer orders, sorted by dollars from high to low.


--14. Show all customer names (in order) and their total ordered, and nothing more. Use coalesce to avoid showing NULLs.


--15. Show the names of all customers who bought products from agents based in New York along with the names of the products they ordered, 
--and the names of the agents who sold it to them.



--16. Write a query to check the accuracy of the dollars column in the Orders table. This means calculating Orders.dollars from other data in 
--other tables and then comparing those values to the values in Orders.dollars.


--17. Create an error in the dollars column of the Orders table so that you can verify your accuracy checking query