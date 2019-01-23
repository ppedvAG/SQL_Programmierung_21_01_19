--Schleifen


--Kopfgesteuert

while Bedingung
	Begin
		--Code
	end


declare @i as int = 0

while @i < 10
	begin
		select @i
		set @i+=1
		continue
		break --Schleife wird sofort beeendet
	end	

While (select count(*) from customers) > 100
	begin
	select 'A'
	end

while (select count(*) from customers ) > 100 AND (select count(*)...) < 10


select * from orders

--Erhöhung der Frachtkosten um 10 %
select sum(freight), avg(freight) from orders
--64000, 78 

--bis: der Schnitt max 100 erreichte oder Summe 100000



While
	IF avg > 100 break




declare @schnitt as money, @summe as money
select @schnitt= avg(freight) , @summe=sum(freight) from orders



while	(select  avg(freight) from orders ) < 100/1.1 
		AND
		(select sum(freight) from orders )< 100000/1.1
		begin
				update orders set freight = freight * 1.1
		end



--CASE


Select * from customers
--Ausgabe der Kunden mit Land(EU oder NICHT EU)

--UNION 

select 'A'
UNION --verknüpft Eregbisse zu einem 
select 'B'
UNION
select 'C'

select 'A'
UNION --irgendwie distinct
select 'A'

select 'A'
UNION ALL --keine Suche nach Distinct Werten
select 'A'


--rel umständlich
select customerid, country, 'EU' as EUnotEU from customers where country in ('Germany', 'Italy')
union ALL
select customerid, country, 'NOT EU' as EUnotEU from customers where country not in ('Germany', 'Italy')


--CASE
select customerid,
	  country,
	  CASE
		when country in ('Germany', 'Italy') then 'EU'
		when country like 'U%' then 'keine Angabe'
		else 'NOT EU'
	  END as EUnotEU
from customers


--ABC Analyse
Select * from orders

--Kunden, die mehr als 500 Frachtkosten sind C Kunden
--Kunde mit unter 100 sind A Kunden
--dazwischen sind B Kunden

select * from (
select top 3 orderid, customerid, freight, 'A' as Typ from orders where freight < 100
order by freight desc
 ) t
UNION ALL
select orderid, customerid, freight, 'C' from orders where freight > 500
UNION ALL
select orderid, customerid, freight, 'B' from orders where freight between 100 and 500
order by freight desc




















IF (Select count(*) from customers) > 100 
	Begin
		select 'A'
		select 1+2
	End
ELSE
	Begin
		select 'B'
    End


