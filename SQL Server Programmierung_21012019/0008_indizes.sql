use northwind


SELECT        Customers.CustomerID, Customers.CompanyName, Customers.City, Customers.Country, Customers.ContactName, Customers.ContactTitle, Orders.OrderDate, Orders.Freight, Orders.ShipCountry, Orders.ShipCity, 
                         [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName, Products.UnitsInStock, Employees.LastName, Employees.FirstName
INTO KundeUmsatz
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID


insert into kundeumsatz
select * from kundeumsatz --1,1 Mio


set statistics io, time on-- SCAN (abisZ) Seek optimales Suchen


--HEAP-- Table SCAN
select orderid from kundeumsatz where orderid = 10248 --39920

select * into ku1 from kundeumsatz

--Table Scan.. 39900 Seiten
select orderid from ku1 where orderid = 10248

--deutlich günstiger: 0 ms.. 7 Lesevorgänge

select orderid, city, country, freight from ku1 where orderid = 10248 --1543 Seiten..wg Lookup


--nun mit NIX_Orderid_City.. 10 Seiten statt 1543


--tja ..wir haben ca 20 Spalten.. 

select * führt so gut wie immer zu einem 'Lookup'

---Nicht gruppierten zusammengesetzen IX
--naja, dann halt alle SPalten in den IX rein!
--leider nein...so nicht
--leider darf man nur max 16 Spalten mit max 900 byte pro Schlüsselwert aufnehmen


select * from ku1
--NIX_Pid_incl_Scy_Fr
select shipcountry, sum(freight)
from ku1
where productid = 1
group by shipcountry

--Gr vs N Gr

--nach GR IX auf Orderdate erscheinen die Daten plötzlich sortiert

select * from orders

select * from customers

--Gr IX ist gut bei Berecihsabfragen auch bei =
--N GR IX ist gut bei = Abfragen mit rel wenigen Ergebniszeilen!!

--nur 1mal GR IX pro Tabellen












--der zusamm brigt nur was wenn die SPalten auch im where gesucht werden

--daher gibt es einen IX der für Wefrtsuche aus dem Select besser geeignet ist










--IX auf orderid
--Nicht gr ix auf orderid








--Indizes
/*
grupp. ix  (Clustered IX) --1 mal pro Tab
nicht gr IX (non cl ix) ..ca 1000 mal pro Tabelle
----------------------------
eindeutiger IX --
zusammengestzter IX --- (max 16 Spalten)
IX mit eingeschl Spalten--  der Baum bleibt unbelastet aber am Ende findet man viele Infos (bis zu 1000 Spalten)

gefilterter IX --
abdeckender IX --- ideale IX Abfrage und IX ergänzen optimal

ind Sicht


partionierter IX
real hypoth IX
-----------------------------
Columnstore



*/

select orderid, orderdate, city, country, lastname from ku1
where freight = 1 and  city = 'Berlin'



--indizierte Sicht
set statistics io, time on

select country , counT(*) as Anzahl from ku1
group by country

create view vINdex
as
select country , counT(*) as Anzahl from ku1
group by country

select * from Vindex

Alter view vIndex with schemabinding
as
select country , count_big(*) as Anzahl from dbo.ku1
group by country


--Bendigungen: Sicht muss schemabinding es muss count_big(*), Spalte nach der AGG wird darf nicht NULL enthalten
--isnull

select isnull(null, 0)


--20 Jahren umsatz, weltweit, 100 Mrd Zeilen
--ind Sicht.. in welchem Land wieviel Umsatz
--Anzahl Seiten:
--Ca 200 Länder--> Ind Sicht hat nur 200 Zeilen.. 2 bis max 3 Seiten

--Das Ergbnis der Abfrage = Index der Sicht
--mit IX 0 sec.. 2 Seiten statt

select * into ku2 from ku1

select * into ku3 from ku1




select top 5 * from ku2


--AGG , where 

--Summe Frachtkosten pro Companyname
--where : Country = 'USA'

--NIX__CY_inkl_CName_FR
select companyname, sum(freight) from ku2
where country = 'USA'
group by companyname
--Top gelaufen!





select companyname, sum(freight) from ku3
where country = 'USA'
group by companyname

--wie kann das sein, dass der CS IX soviel besser ist??
--Falls ABfrage auf KU2 sich ändern sollte, dann muss auch der IX neu überlegt werden
--bei Ku3 mit CS IX nicht

--ku3 angeblich 0,24 MB
--stimmt , weil die Daten Komprimiert sind

--nach 2ter KOmpression: nurn nich 117 kb

--sehr wenig CPU .. sehr wenig IO.. sehr wenig RAM (117kb)


-------------->IO 
------> CPU


->
->
---->

--was passiert bei INS UP DEL



select * from sys.dm_db_column_store_row_group_physical_stats

insert into ku3 
select top 10000 * from ku3

--delta store = heap --SCAN
--ab ca 1 MIO DS wird automat komprimiert (Tuple Mover)

--Seg: Otto  O, Oswald  Ottifant
--

--was passiert bei update oder delete
--delete:
--00001 Bitmapfilter
--update= ins + del


--das ! Feature seit SQL 2012
--2012 waren Tab nicht updatebar
--seit 2014 gr CSIX.. updatebar
--seit 2016 SP1: hat viel Enter Funkt verschenkt (sogar Express)



--TAB A ohne IX

--UP auf eine best Zeile
--wieviel wird gesperrt:gesamte Tabelle--> kein andere kann irgendwelche DS lesen

--TAB A mit IX auf best Spalte
--update auf eine best Zeile... IX seek.. zeilensperre
--andere können select auf andere Zeilen machen




--hmm wie bei jeden IX also auch hier: I UP DEL tut mir weh!!

--IX müssen gepfegt werden


