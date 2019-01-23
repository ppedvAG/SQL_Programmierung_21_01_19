--Logischer fluss


--Wie hoch waren die Frachtkosten in Summe der Kunden aus U%?
--sortiert nach Stadt



select 
			country as Land
		  , city as Stadt
		  , sum(freight) as SummeFracht 
from customers c
				inner join orders o on c.customerid = o.customerid
where 
		C.country like 'U%'
		--land like 'U%'
group by 
		Country, city having country = 'USA'
order by 
		Land,city


--LOGISCHER FLUSS

/*
From --> JOIN --> WHERE --> GROUP BY --> HAVING  ---AUSWAND!!!!
--> SELECT --> ORDER BY --> TOP |DISTINCT --> AUSGABE


Tu nie in das Having etwas anderes als AGG
immer das was eine where lösen kann muss im where bleiben


**/


--PLAN-- im tats. plan steht ein @1
select * from orders where orderid = 10249


--Variable: um den Plan zu autoparametrisieren

--Sobald eine Statment etwas komplexer wird , kann SQL nicht mehr param...
select * from customers c 
inner join orders o
 on c.customerid = o.customerid
where o.orderid = 10248

--Lösung: Prozeduren
--Proz haben immer genau einen Plan, der immer wieder verwendet wird!



create proc gp_name @par1 int
as
--code
Select
insert
update 
delete
GO

exec Gp_name 10

--wie ein Batchdatei unter Windows

exec gp_KundeunSuche 'ALFKI' --- Customerid in Tab Customerid
exec gp_kundensuche 'A' --nur die mit A beginnen
exec gp_kundenSuche --jeder Kunde 


ALTER proc gp_KundenSuche @KdId varchar(5) = '%'
as
select * from customers where customerid like @Kdid +'%';
GO


exec gp_kundensuche 'ALFKI'

exec gp_kundensuche 'A' --geht nicht

exec gp_kundensuche 

--Aber : nett aber schlecht!!



--char(5) . 5 lang!!!!

exec gp_kundensuche ''


--Suche alle Bestellungen aus dem Jahr 1997
select * from orders
--orderdate


--bei 31.12.1997 falsch, dann Verkäufe auch nach 0 Uhr möglich
--bei 31.12.1997 23:59:59.999 auch falsch..
--datetime als int gespeicgert
--schnell aber evtl falsch
select * from 
		orders 
		where 
		orderdate between '1.1.1997' and '31.12.1997 23:59:59.999'

--richtig aber langsam
select * from orders
where year(orderdate) = 1997


--SCAN: A bis Z  besser : SEEK herauspicken!!







