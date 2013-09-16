--Zack Meath's HW1 from Database Management
--1
select * from customers
--2
select name, city from agents where name = 'Smith'
--3
select pid, name, quantity from products where (priceusd > 1.25)
--4
select ordno, aid from orders
--5
select name, city from customers where city <> 'Dallas'
--6
select name from agents where city = 'New York' or city = 'Newark'
--7
select * from products where (city <> 'New York' or city <> 'Newark') and priceusd < 1.00
--8
select * from orders where mon = 'jan' or mon = 'mar'
--9
select * from orders where mon = 'feb' and dollars < 100.00
--10
select * from orders where cid = 'C005'