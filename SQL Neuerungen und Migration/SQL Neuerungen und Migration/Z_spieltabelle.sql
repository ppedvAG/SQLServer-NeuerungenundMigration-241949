SELECT        Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.Freight, Orders.ShipCity, 
                         Orders.ShipCountry, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, [Order Details].OrderID, Employees.LastName, Employees.FirstName, Products.ProductName, Products.UnitsInStock
INTO KU
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID
GO


insert into ku
select * from ku
go 9



alter table ku add id int identity

set statistics io, time on

select * from ku where id = 10

dbcc showcontig('ku') --41000  56000  

select 15000*8

select * from sys.dm_db_index_physical_stats(db_id(), object_id('ku'), NULL, NULL, 'detailed')



--IO reduzieren!!!!!


select * into ku2 from ku


set statistics io, time on

select companyname, sum(freight)
from ku2
where country = 'UK'
group by companyname



