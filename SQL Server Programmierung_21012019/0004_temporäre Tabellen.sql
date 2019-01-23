--Temp Tabellen

/*
#tabelle
lokale temp Tabelle
Lebensdauer: solange die Verbindung besteht oder drop table
existiert nur in der akteullen Verbindung

##tabellen
globale temp Tabelle
Lebensdauer: solange die Ersteller Verbindung geöffnet ist bzw kein Drop Table
existiert auch in anderen Verbindung
sobald ##tr gelöscht wurde : bestehnde Abfrage werden nicht unterbrochen


Einsatz von temp: zu 99,9% lokale temp Tabellen


sind einfach schnell
zb Join über 5 Tabellen: alle sind sehr groß..
die 2 größten zu joinen in temp Tabelle. 

*/


create table #t1 (id int)

select * from #t1


---Konkurrenz Sichten


create table ##t1 (id int)

select * from ##t1

drop table ##t1



--Alternative zu temp Tabellen.
--für zwischenergebnisse --eigtl auch per Sicht machbar

--großer Unterschied einer Sicht vs Sicht: Sicht ist imer aktuell


--Temp Tabelle können Abfragen deutlich beschleunigen, aber evt veraltete Daten enthalten

begin tran
update customers set city = 'BGH'
select * from customers
commit
rollback
