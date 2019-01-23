--XML   

--Datentyp XML: XML Queries



--DDL --Trigger


create trigger ddlxml on database
for create_view
as
begin
		--select * from logging
		select eventdata()
		declare @ausgabe as nvarchar(1000)
		declare @xml as xml

		set @xml = eventdata()


		set @ausgabe= convert(nvarchar(1000), @xml.value('(/EVENT_INSTANCE/SPID)[1]', 'float'))
		select @ausgabe

		select convert(nvarchar(1000), @xml.query('EVENT_INSTANCE/SPID'))
		select convert(nvarchar(1000), @xml.query('data(//CommandText)'))
end

		

select companyname, customerid, country from customers FOR XML AUTO, ROOT('ROOT'), Elements


select customerid,  shipcountry ,freight into o1 from orders

alter table o1 add oid int identity


select * from o1


select * , row_number() over (order by freight) from o1

--dense_rank()

--ntile

select * , ntile(3) over (order by freight) from o1 --gleich verteilt


--Welcher Kunde ist in welchem Land der beste...

select distinct shipcountry, customerid,
 sum(freight) over ( partition by customerid order by Shipcountry) as Summe
  into #t1
 from o1

 select row_number() over (partition by shipcountry order by summe desc),* from #t1

 --Cursor--langsam










