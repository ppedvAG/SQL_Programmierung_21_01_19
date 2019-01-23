create table t3 (id int identity, sp1 char(4100))

--gestern: GO 20000 --Dauer: 26 Sekunden --20000 Batches
--select * into t5 from t2 .. dauert 1 bis 2 Sekunden


declare @i as int = 0

while @i < 20000
	begin
		insert into t3 values('##')
		set @i+=1
	end
--1 Batch , aber immer noch 20000 Anweisung

---Wo geht die Zeit hin..: Select into in 2 Sekunden.. wo iust dann der Aufwand dafür?
--Aufwand: zb HDD  (kaum 9 ms) falls das in höheren Bereichn von ms stattfindet hast du eine Spindel
--SQL DB < SQL 2016: Default: 1 MB .. pro 64MB 84* 4 ms
--160MB: 160*5= 800ms-- weniger als eine Sekunde

--SSD muss doch 160MB in knapp 2 sek schreiben.. Selct into zeigt das auch..
--massenimporte sind schneller, vor allem , wenn man die DB dazu optimiert:
--RecoveryModel:
--Einfach: INS, UP ,DEL ins Log, BULK rudimentär 
--danach nach commited verschinden die TX aus dem Log
--es gibt keine Sicherung des Logfiles

--BULK
--prokolliert alles wie Einfach, aber es leert das Log nicht. Log wächst immer weiter an
--Admin muss Sicherung von Log machen


--FULL:
--zeichnet sehr exakt auf. jede TX auch Bulk wir ´d exakt protokolliert..
--jederzeit auf die Sek restoren

USE [master]
GO
ALTER DATABASE [Northwind] SET RECOVERY BULK_LOGGED 
GO


--wir haben hier 20000 TX in der Schleife...
--20000 commit.. 20000 Sperrverhalten.. und und
--weniger TX!
create table t4 (id int identity, sp1 char(4100))

declare @i as int = 0

begin tran
while @i < 20000
	begin
		insert into t4 values('##')
		set @i+=1
end
commit



--1 Sekunde statt 9