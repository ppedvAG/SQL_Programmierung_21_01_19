--Functions

--Skalarwertfunktionen

--Fwert) --Wert zurück


create function fbrutto(@netto money, @MwSt decimal(3,2))
returns money
as
	Begin
		return (select @netto*@Mwst)		
	end	


select dbo.fbrutto(100,1.19)


--F() sind echt extrem cool und flexibel

select dbo.fRngsumme(10248) --> 440 Euro

--[order details]





create function fRngSum (@oid int) returns money
as
begin
 return (select sum(unitprice*quantity) from [order details] where orderid = @oid)
end


select dbo.fRngSum(10248)

select dbo.fRngSum(orderid),* from orders where dbo.fRngSum(orderid) < 500


alter table orders add Rechnungssumme as dbo.fRngSum(orderid)

select * from orders where Rechnungssumme < 500

--echt cool und praktisch , aber sau schlecht seitens performance


select * from customers where customerid like 'A%'

select * from customers where left(customerid,1) ='A' --immer SCAN .. lieber SEEK



--die ist gut...
create function ftab (@id int)
returns @ausgabetab table (bestnr int, kdnr varchar(50), freight money)
as
	begin
	insert into @ausgabetab
	select orderid, customerid, freight from orders where orderid = @id
	return
	end


	select * from dbo.ftab(10248)


	--Partitionierung
	.--CTE, PIVOT, GROUP , QUeryStore, crossapply, Window Functions