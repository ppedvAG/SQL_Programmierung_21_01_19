use northwind;
GO

--historisierung...--> Trigger.. CDT CDC



create table contacts
(
Cid int identity primary key,
Lastname varchar(50), Firstname varchar(50), Birthdate date, email varchar(50),
StartDatum datetime2 GENERATED always as row start not null,
EndDatum datetime2 GENERATED always as row end not null,
Period for system_time (StartDatum, EndDatum)
)
with (system_versioning = ON (History_table=dbo.ContactsHistory))



Create table demo2
(sp1 int identity primary key
, sp2 int, 
startfrom datetime2 not null, 
Endto datetime2 not null)

alter table demo2
add Period for system_time (startfrom, Endto)

Alter table demo2
set (system_versioning = on (History_table = dbo.demohist, Data_consistency_Check=ON))


--select * from contacts

insert into contacts (lastname, firstname,  email,Birthdate) values 
('Rauch', 'andreas', 'testmail','2.2.2012')
,
('Maier', 'Hans','testmail', '3.3.2013')

select * from contacts
select * from contactshistory ..1424-1428

update contacts set Firstname = 'PeterXY' where cid= 2
update contacts set Lastname = 'HUber' where cid= 3


update contacts set Lastname = 'HUberZZ' where cid= 3

update contacts set Birthdate= '1.1.2011' where cid= 2



select * from contacts where cid = 2 --wie qar das gleich wieder um 14:25:00


--OrgTabelle kann mna direkt abfragen
select * from contacts for system_time as Of '23.01.2019 14:25:00.000'







