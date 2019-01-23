select * into c1 from customers where country in ('UK', 'USA', 'Brazil')


select * from c1

update c1 set companyname = Companyname + 'XY' where customerid like 'H%'


--welche Datensätze sind in beiden Tabellen identisch und welche sind unterschiedlich?
select * from customers
intersect
select * from c1


select Customerid from customers --orientiert sich immer an der Ergebnismenge der Abfragen
intersect
select Customerid from c1


--unterschiedliche..


select * from customers --62 DS aus Customers
except
select * from c1

select * from c1
except 
select * from customers

--Spalte mit uniquidentitfier

select newid() --> PK (CL IX)


---GUI als pk CL IX..


BestTab: ID wert Identity
--Seiten: alles neue kommt in eine letzte Seite
--eine Seite kann nur durch eine Thread angesprochen werden

--newid:  AB .. 12E.. DA   O7
--Last wir  mehr vereilt

--Replkation : GUID



