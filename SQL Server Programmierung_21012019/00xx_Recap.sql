--Prozeduren: gp_kundeunsuche 'A'

create proc gpKundensuche @kdid varchar(5)
as
select * from customers where customerid like @kdid + '%'



--KU5
--jede Abfrage wird ein Table Scan haben

exec gp_Kusuche 2   /300  /5000


select * from ku5 where kuid < @par



drop proc gpkdsearch

create procedure gpKdSearch @kdid int
as
select * from ku5 where kuid < @kdid


set statistics io , time on

dbcc freeproccache

exec gpKdSearch 5 --40461 --forward record count = 0

select * from sys.dm_db_index_physical_Stats(db_id(), object_id('ku5'), NULL, NULL, 'detailed')

--nach IX : 4 Seiten-- zwar mit Lookup aber ok



--dynamisches SQL 
--das ist überhaupt nicht einschätzbar.. mieses SQL!!
@var='Select * from ' 
@var2

@var1+@var2

exec (@..)

exec gpKdSearch 1000000 --und hier?---1.002.241

--Suchmasken:  where Ststement muss dynamisch zusammengebaut werden

--Volltext


----Suchmaske für Kunden, Fragen zu Bestellungen

--where kdid = 12129 ...and orderdate> getdate()-30  CL IX

--Tab Best: 50 MIO   IX auf das Kaufdatum

--jede Tabelle wurde so abgefragt
--where 1=0

--es gab 500 Tabellen.. CL 200


--mit *
--Maske waren von ca 20 Spalten nur 5 zu sehen

--wie wurde das festgestellt...--> Profiler



select * from ku5 where kuid < 500000--40461


--Proc sind  i.d.R schneller..aber
--Proc dürfen nie benutzerfreundlich sein 

--hmm wenn das so schief läuft, welche Möglichekiten hätten
--anderer Plan?

--der erste Aufruf mit jeweiligen Parameter legt den Plan fest

--beste Kompromiß .. eher SCAN..
--gehts besser?


--IDEE

create proc gpidee @par
as
If @par > 20000
exec gpsucheviele --scan
else
exec gpsuche wenige --seek


--kann man so etwas finden



