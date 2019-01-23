--Sichten
--einfachere Abfragen
--Security
--Besitzverkettung
--hat keine Daten

create table test1 (id int, Stadt int, Land int)

insert into test1
select 1,10,100
UNION 
select 2,20,200
UNION 
select 3,30,300


select * from test1

create view vtest 
as
select * from test1
GO


select * from vtest

alter table test1 add Fluss int

update test1 set fluss = id *1000

alter table test1 drop column land

--in Spalte Land taucht der wert von Fluss auf!!!!!!

--Sicherheit, dass das nie passiert!

drop view vtest
drop table test1



create view vtest with schemabinding
as
select id, Stadt, land from dbo.test1
GO


select * from vtest

--das löschen der Spalten geht nicht, da die Sicht sie explizit verwendet
--auch Tabelle ist nicht löschbar

--mit schemabinding alles genau und exakt



--2 ter  Fall, was man nicht tun sollte

create view vKundeUmsatz
as
SELECT        Customers.CustomerID, Customers.CompanyName, Customers.City, Customers.Country, Customers.ContactName, Customers.ContactTitle, Orders.OrderDate, Orders.Freight, Orders.ShipCountry, Orders.ShipCity, 
                         [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName, Products.UnitsInStock, Employees.LastName, Employees.FirstName
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID


select distinct customerid from vKundeumsatz where country = 'UK' --0,15 SQL Dollar

--man sollte nie Sichten zeweckentfremden

select customerid from customers where country = 'UK' --0,004 SQL Dollar







