--Normalform 1.2 3. ... 

--Redundanz vermeiden:
--1 NF jede Zelle hat nur einen Wert
--2 NF jeder DS hat einen PK
--3 NF ausserhalb des PK keine Abhängigkeiten



--PK soll Beziehungen herstellen (muss aber eindeutigkeit besitzten)

--aber das was niemend sagt: physikalisch!

--1 DS wird in SQL Server in sog Seiten gespeichert


create table t1xy (id int, sp1 char(4100), sp2 char(4100)) --> 8060
--

create table t1xy (id int identity, sp1 char(4100))

insert into t1xy --26Sekunden
select '##'
GO 20000


--
select * into t2xy from t1xy --2 Sekunden

--physikalischer Verschleiss

dbcc showcontig('t1xy')
-- Gescannte Seiten.............................: 20000
-- Mittlere Seitendichte (voll).....................: 50.79%

---user Ziel: umso weniger Seiten, umso weniger IO, umso weniger RAM, umso weniger CPU

--Seiten der ABfragen

set statistics io, time on --Anzahl der Seiten und CPU Dauer und gesamte DAuer in ms!!





