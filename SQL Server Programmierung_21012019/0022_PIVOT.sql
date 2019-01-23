select * from Tabelle
PIVOT (AGG(Quellespalte)
for pivot-spalte in Spaltenliste as alias


create table sales (Status char(2), SalesUmsatz decimal (18,2))

select * from sales

insert into sales values ('HR', 10000), ('IT', 20000), ('FE', 5500), ('HR', 1000),
						 ('FP', 100000), ('IT', 3000)



select * from sales

select [HR], [IT], [FE], [FP]
from (select status, SalesUmsatz from sales) pivottabelle
PIVOT
(
sum(SalesUmsatz) for status in ( [HR], [IT], [FE], [FP])) as ovt


--select * from customers

--Gib für folgende Länder die Anzahl der Kunden aus..UK USA Germany


select country, count(*) from customers group by country


select [UK], [USA], [GERMANY] from 
	(select country from customers) c
	pivot (count(country) for country in ([UK], [USA], [GERMANY] ) ) as pvt



