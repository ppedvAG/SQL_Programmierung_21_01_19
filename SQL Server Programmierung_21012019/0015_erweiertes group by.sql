----Group by


select country, city, count(*) as Anzahl  from customers
group by
	  country, city 
order by 
	1,2



--was wäre wenn: Analyse: Wieviel in UK, Wieviel in Berlin, weltweit
--wie bekomme ich das einfach raus...?

--OLAP: 3 Sekunden-- Würfel oder Cube

--max 1000MB
--soll ca 2 mal schneller
--zu 30% 

--dann in temp Tabelle und diese -mehrfach - abfragen
select country, city, count(*) as Anzahl
into #t1  from customers
group by
	  country, city with rollup
order by 
	1,2


select country, city, count(*) as Anzahl  from customers
group by
	  country, city with Cube
order by 
	1,2