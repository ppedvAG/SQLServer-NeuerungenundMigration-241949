select greatest(requireddate, orderdate),requireddate, orderdate  from orders

select max(freight) from orders where shipcountry = 'UK'
select greatest(freight) from orders where shipcountry = 'UK'

select greatest(requireddate, orderdate),requireddate, orderdate  from orders

select * from orders 
where greatest(shippeddate, RequiredDate) = '1.1.1998'

--Vorsicht-----------------
select * from orders 
where greatest (freight) > 10

select * from orders 
where (freight) > 10


select greatest(1,5,9)			--9
select greatest('A','B','C')	--C
select greatest('AA','AB','AC')	--AC
select greatest('A','AA','A')	--AA

----------------------------




