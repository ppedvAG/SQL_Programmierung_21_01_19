use northwind

--CTE: Unterabfragen, rekursive Auflösung)

WITH CTENAME (Sp1, Sp2, Sp3...)
AS
(Select * from tabelle / Sicht..)
select * from CTENAME;
GO


With CTEKDFrachtkosten (Firma, fracht)
as
(select companyname 
	   , freight 
	   from customers c 
			inner join orders o on c.customerid = o.customerid)
Select Firma, fracht from CTEKDFrachtkosten


--Hierarch
WITH CTE (Spalten)
as
(
select * from .... Chefliga
UNION ALL
select  from tabelle where vorgid = ID aus der Basis)
select * from CTE


select * from employees --empID

with CTE (AngID, FamName, vorname, Chef, Ebene, Boss)
as
	(
		select employeeid , Lastname, firstname, reportsto, 1 as Ebene, 'nix'  from employees
		where  reportsto is null
	UNION ALL
		select employeeid , Lastname, firstname, e.reportsto, CTE.ebene+1, FamName from  employees e
		 inner join CTE ON CTE.Angid=e.reportsto
	)
	select * from cte order by chef;
GO



