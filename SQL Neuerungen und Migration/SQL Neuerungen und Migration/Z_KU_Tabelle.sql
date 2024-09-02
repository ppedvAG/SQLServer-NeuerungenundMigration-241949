SELECT        Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.EmployeeID, Orders.OrderDate, Orders.ShipVia, Orders.Freight, 
                         Orders.ShipName, Orders.ShipCity, Orders.ShipCountry, [Order Details].Quantity, [Order Details].UnitPrice, [Order Details].ProductID, [Order Details].OrderID, Employees.LastName, Employees.FirstName, Employees.BirthDate, 
                         Products.ProductName, Products.UnitsInStock
INTO KU
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID


insert into KU
select * from ku
GO 9

--Spalte ID
alter table ku add id int identity
