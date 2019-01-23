select country , sum(unitprice*quantity)  from ku5
group by country
--eines komm tim Plan immer wieder vor:  Paral.. wir verwenden mehr Prozessoren

--bringt der paral. etwas ?

set statistics io , time on

--, CPU-Zeit = 843 ms  > verstrichene Zeit = 113 ms.

--er verwendet mehr CPUS.. wieviel sollte er nehmen? vermutlich 8 CPUs..entsch. nach SQL Dollar

--Datensätze werden auf die CPUs ungleichmäßig verteilt
--wir müssen auf den letzten warten..
--wieviele CPUs sollten wir nehmen
--oauschal: ab 5 SQL Dollar ..alle CPUs  , sonst 1 CPU

select country , sum(unitprice*quantity)  from ku5 
group by country option (maxdop 1)

--406 ms, verstrichene Zeit = 419 ms.


select country , sum(unitprice*quantity)  from ku5 
group by country option (maxdop 2)

--, CPU-Zeit = 655 ms, verstrichene Zeit = 114 ms.


--, CPU-Zeit = 626 ms, verstrichene Zeit = 151 ms.

--es macht keinen Sinn alle CPUs zuzulassen... max 8 CPUs
--bzw die 50%

--ab 6 Uhr so
EXEC sys.sp_configure N'cost threshold for parallelism', N'30'
GO
EXEC sys.sp_configure N'max degree of parallelism', N'6'
GO
RECONFIGURE WITH OVERRIDE
GO


--taucht im Plan ein Repartition Stream auf (mit % KOsten) dan ist das reduzieren der CPUs zu 99% voreilhaft