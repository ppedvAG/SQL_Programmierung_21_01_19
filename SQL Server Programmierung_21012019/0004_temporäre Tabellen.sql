--Temp Tabellen

/*
#tabelle
lokale temp Tabelle
Lebensdauer: solange die Verbindung besteht oder drop table
existiert nur in der akteullen Verbindung

##tabellen
globale temp Tabelle
Lebensdauer: solange die Ersteller Verbindung ge�ffnet ist bzw kein Drop Table
existiert auch in anderen Verbindung
sobald ##tr gel�scht wurde : bestehnde Abfrage werden nicht unterbrochen


Einsatz von temp: zu 99,9% lokale temp Tabellen


sind einfach schnell
zb Join �ber 5 Tabellen: alle sind sehr gro�..
die 2 gr��ten zu joinen in temp Tabelle. 

*/


create table #t1 (id int)

select * from #t1


---Konkurrenz Sichten


create table ##t1 (id int)

select * from ##t1

drop table ##t1



--Alternative zu temp Tabellen.
--f�r zwischenergebnisse --eigtl auch per Sicht machbar

--gro�er Unterschied einer Sicht vs Sicht: Sicht ist imer aktuell


--Temp Tabelle k�nnen Abfragen deutlich beschleunigen, aber evt veraltete Daten enthalten

begin tran
update customers set city = 'BGH'
select * from customers
commit
rollback
