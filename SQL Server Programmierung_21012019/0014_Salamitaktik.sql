--nichts für VEganer ;-)

--sehr große Tabellen werden nie kleiner..

--Bsp: Umsatztabelle seit 10 Jahren.. App --> Umsatz


--Garantie dafür, dass ein best Jahr nur in einer best Tabelle  zu finden ist


--Ausflug: SP mit not null (2 Mio Zeilen).. where sp is null
--statt einer UMsatz -- u2019..u2018...



create table u2019 (id int identity, jahr int, spx int)
create table u2018 (id int identity, jahr int, spx int)
create table u2017 (id int identity, jahr int, spx int)
create table u2016 (id int identity, jahr int, spx int)

--aber APP braucht UMSATZ!!


--select * from umsatz muss klappen!!

--MIt UNION ALL: keine Suche nach doppelten

create view UMsatz
as
select * from u2019
union all
select * from u2018
union all
select * from u2017
union all
select * from u2016


select * from umsatz --klappt..

--aber gut oder schlecht oder egal--bis dato kein Vorteil
select * from umsatz where jahr = 2017
ALTER TABLE dbo.u2016 ADD CONSTRAINT CK_u2016 CHECK (jahr=2016)

select * from umsatz where jahr = 2018

ALTER TABLE dbo.u2019 ADD CONSTRAINT CK_u2019 CHECK (jahr=2019)

ALTER TABLE dbo.u2018 ADD CONSTRAINT CK_u2018 CHECK (jahr=2018)

ALTER TABLE dbo.u2017 ADD CONSTRAINT CK_u2017 CHECK (jahr=2017)

--Super.. gerade zu Beginn des Jahres.. usw..
--manche machten das mit KW
--Aufwand in der Form rel groß
--Fixen Konstrukt: Umsatz_Jan... Umsatz_Feb


-- nett aber altes Zeug!

--Nachteile
--Sichten können INS UP DEL

insert into umsatz (jahr, spx) values (2017,100)

--PK  muss eindeutig sein über die Sicht
--PK auf ID und JAHR

--geht immer noch nicht..!

--Idenity muss weg!


--jetzt auch noch ID selber füllen!

--ziemlich unsinnig
--vorher max(id) ?
--1 2 3      6 7 8 
insert into umsatz (id,jahr, spx) values (1,2017,100)

--Idee Sequenzen : Ids ausserhalb von Tabelle


CREATE SEQUENCE [dbo].[seq_uid] 
 AS [int]
 START WITH 1
 INCREMENT BY 1


 select next value for seq_uid

 --folglich muss anwendung geändert werrden
 insert into umsatz (id,jahr, spx) values (next value for seq_uid,2017,100)
  insert into umsatz (id,jahr, spx) values (next value for seq_uid,2017,100)
   insert into umsatz (id,jahr, spx) values (next value for seq_uid,2018,100)
    insert into umsatz (id,jahr, spx) values (next value for seq_uid,2018,100)
	 insert into umsatz (id,jahr, spx) values (next value for seq_uid,2019,100)
 insert into umsatz (id,jahr, spx) values (next value for seq_uid,2017,100)
  insert into umsatz (id,jahr, spx) values (next value for seq_uid,2017,100)
   insert into umsatz (id,jahr, spx) values (next value for seq_uid,2016,100)
    insert into umsatz (id,jahr, spx) values (next value for seq_uid,2016,100)
	 insert into umsatz (id,jahr, spx) values (next value for seq_uid,2019,100)





	 select * from umsatz  where jahr = 2017


--Partitionieren nur besser.


--physisch...

--DB  besteht aus einer ldf...(eig HDD) .. auch eine oder mehrere DAtendateien (mdf .. weiter ndf)

--aber wie kann man als DEV Daten auf HDDs legen

create table t1 (id int) --vermutlich auf mdf (Dateigruppe: Primary)

create table t1 (id int) on [PRIMARY]

--neue Datei mit Dgruppe: STAMM
create table mystammdatendingens( id int) on STAMM

---Partitionierung verwendet Dateigruppen


--es bleibt bei einer Tabelle


----------------------100]------------------------200]-----------------------
--      1                       2                         3


-- fzahl(117) --> 2 --> 15000 Bereiche möglich


-- Tab liegt auf einem Part Schema  (scheme)

--Schema kennt f und die Dateigruppen

--- 1       2       3
--  DG1    DG2     DG3


--zuerst die F()
create partition function fZahl(int)
as
RANGE LEFT FOR VALUES (100,200)
GO

select $partition.fzahl(117) --> 2


--bis100, bis200, bis5000, rest

create partition scheme schZahl
as
partition fzahl to (bis100, bis200, rest)
------------         1         2      3

create table ptab (id int identity, spx char(4100), nummer int) on schZahl(nummer)


declare @i as int = 0

while @i < 20000
	begin
		insert into ptab values('xx', @i)
		set @i+=1
	end


--Messen ob besser

set statistics io, time on


select * from ptab where id = 50 --koompletter Table Scan --20000 Seite

select * from ptab where nummer = 50--HEAP (SEEK) SCAN -- 101 Seite

select * from ptab where nummer = 500--HEAP (SEEK) SCAN --19800 Seite

--------------100--------200----------!5000--------------------
--    1             2             3              4


--Was müssen wir ändern....: scheme, f(), aber nie die Tabelle
--Reihenfolge?   scheme dann f()

alter partition scheme schZahl next used bis5000
--wenn es soweit ist, nehm ich das...


--vorher
select $partition.fzahl(nummer), min(nummer), max(nummer), count(*) from ptab group by $partition.fzahl(nummer)
--nachher

--jetzt f()--Daten werden nun pyhsikalisch umsortiert
alter partition function fzahl() split range(5000)

select * from ptab where nummer = 500 --jetzt nur noch 4800



--------100------200--------5000------------
--Grenze 100 raus
--Was müssen wir ändern: scheme, f()
--nur f() ändern-- scheme nicht notwenig

alter partition function fzahl() merge range (100)

--Wo ist eigtl jetzt was... 


/****** Object:  PartitionFunction [fZahl]    Script Date: 23.01.2019 11:33:48 ******/
CREATE PARTITION FUNCTION [fZahl](int) AS RANGE LEFT FOR VALUES (200, 5000)
GO

/****** Object:  PartitionScheme [schZahl]    Script Date: 23.01.2019 11:34:04 ******/
CREATE PARTITION SCHEME [schZahl] AS PARTITION [fZahl] TO ([bis200], [bis5000], [Rest])
GO

select * from ptab where nummer = 10000

create table archiv(id int not null, spx char(4100), nummer int) on Rest

--Befehl für Verschieben von Datensätzen??
alter table ptab switch partition 3 to archiv-- wie lange dauert das?  100MB/Sek... 10000MB---> vermutlich ca 2 ms

--MDF:  1 bis 300   A: auf Seite 506.. Daten von Seite 200 bis 300 

--Verschieben geht nur weil Archiv dort liegt wo auch Part 3 ist


--DAtentyp: datetie, varchar(50)

--was wäre wenn Orders mit Orderdate datetime

---Jahresweise

präfix| Maildomäne

--wie müsste f() aussehen

create partition function fDatum(datetime)--datetime aufpassen = ungenau 
as
range left for values('31.12.1996 23:59:59.999','31.12.1997','')


--AbisM   NbisR SbisZ
create partition function fKunden(varchar(50))--datetime aufpassen = ungenau 
as
range left for values('N','S')--sollte 


--ist Primary erlaubt.. wieso nicht
--und ist folgendes erlaubt, aber unsinnig?
create partition scheme schZahl
as
partition fzahl to ([Primary], [Primary], [Primary])

--                       1            2           3


select *  FROM sys.dm_db_index_physical_Stats(db_id(), object_id('ptab'), null, null, 'detailed')

--echt cool, weil einfach, simpel, flexibel... aber erst wenn wirklich viele DAten da sind
--VLDB  
--wg 1mio never








--

















