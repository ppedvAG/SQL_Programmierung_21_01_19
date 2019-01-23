--DB Design

--Normalisierung
--Redundanz.. schnell
--Generalisierung.. Daten validieren


--physische Design

--Datensätze sind in Seiten
--8 Seiten am Stück --> Block
--Seiten werden 1 :1 in Ram gelesen

--wir lesen nie von Datenträger


--I UP DEL.. paral. in RAM(Log) und ldf Datei.. dann erst ist die TX --fertig
--nach CHeckpoint auf mdf

--DB ldf (log), mdf Daten + weiter  ndf Dateien


--seiten haben 8192 bytes (8060 für DAten)
--1 DS muss i.d.R reinpassen


--1 DS ist rel groß (4100)

--Auslastung: 
dbcc showcontig('t1xy')

--Gescannte Seiten.............................: 20000
--- Mittlere Seitendichte (voll).....................: 50.79%

--Wie kann man dieses Problem beheben:
--Datentypen überlegen (muss es char sein, nvarchar.. n= Unicode brauchen doppelte Menge)
---> Anwendung geht vermutlich nicht mehr

--weiter Möglichkeit?


--Kompression (40 bis 60% Rate)
--weniger Seiten, weniger RAM, mehr CPU

--typischer Vetrfeter für optimale Ausnutzung der Kompression: Columnstore IX

--dekompression kostet eigtl immer mehr CPU...
--komp sind auch im RAM komprimiert

--früher Entreprise heute SP1 2016 Standard

--kein Änderung der APP notwendig

--Kopie der Kundeumsatz
select * into ku4 from kundeumsatz

set statistics io, time on


select top 3 * from ku4 --HEAP--schneller
select top 3 * from ku4 --CL IX --geht vom Wurzelknoten aus..

--kein eindeutige ID

select * from ku4 where orderid = 10249 --39921..- Mittlere Seitendichte (voll).....................: 98.16%

dbcc showcontig ('ku4')

alter table ku4 add kuid int identity


dbcc showcontig('ku4') --40489
select * from ku4 where kuid = 100 --55296

--heap = 0,, CL IX = 1, NCL > 1
--Systemsichten
select * from sys.dm_db_index_physical_Stats(db_id(), object_id('ku4'), NULL, NULL, 'detailed')

---Forward_record_Counts zusätzliche Seiten : 14807

--diese frc müssen weg...

--Tabellen neu physikalisch neu sortiert ablegen...
--ah...Idee   CL IX

select * from ku4

--jetzt keine Frc mehr, dafür 41300 Seiten -- besser als 55000

--Warum sollte es also HEAP Tabellen geben. CL IX Tabellen haben nie frc..
--zB: weil man einfach nur schreiben möchte
--

--IX 

select * from ku4

--CL IX: vermutlich auf Orderdate wg Bereichsabfragen

--NIX_CYFrLN_INCL_Pname_unitpr_Qu
select productname, sum(unitprice*quantity) as Umsatz from ku4
where 
	country = 'Brazil' or (Freight < 10 and lastname = 'Davolio')
group by
	productname

--im Plan sollte immer ein Seek zu finden sein: IX ovn oben führt zu  einem Seek und einem Scan
--2 IX: NIX_CY_incl_up_qu_pn    NIX_FR_LN_incl_up_qu_pn


--where city = 'London' and Country = 'UK'

--NIX_CI_CY--

-- Selektive Spalte immer zuerst


select * into ku5 from ku4

--noch nie abgefragt.. kein IX
--
select * from ku5 where kuid = 1000 --1---NCL IX!!!
select * from ku5 where customerid = 'ALFKI'  ---320 --9358--6144   ---NCL IX !!!!
select * from ku5 where country = 'UK' --50000--71304 --69120 ----NCL IX !!

--Statistiken braucht man zur Wahl des 

select * from ku5 where companyname = 'Around the Horn' and freight = 72.97 --294--150000

--Daten ändern sich: Statistiken werden nach  20% + 500 + Abfrage auf die Spalte im where    aktualisiert

--!! IX Wartung, Stats aktualiserung


















































