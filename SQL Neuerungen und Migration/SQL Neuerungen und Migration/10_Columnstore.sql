Columnstore

set statistics io, time on


select country, city, sum(unitprice*quantity)
from ku
where freight < 5 
group by country, city

--idealer IX


select * into ku2 from ku --ku2 hat keinen IX 



select country, city, sum(unitprice*quantity)
from ku2
where freight < 5 
group by country, city

