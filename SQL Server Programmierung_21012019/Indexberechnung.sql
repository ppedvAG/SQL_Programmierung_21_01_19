select * into indrechnung from sys.messages

select top 1 * from indrechnung
create nonclustered index ix1 on indrechnung(message_id)

set statistics io on
select * from indrechnung where language_id=1 --9102 Seiten

select 9201/671 --13

select top 1 * from indrechnung
select avg(datalength(message_id))
	+ avg(datalength(language_id))
	+ avg(datalength(severity))
	+ avg(datalength(is_event_logged))
	+avg(datalength(text))
from indrechnung


--im schnitt 235
exec sp_help 'indrechnung'

select count(*) from indrechnung

select 8060/235--34 DS pro Seite

select 291610/34 --8600 Seiten

select 8600/12 --720
select 720/12 --60
select 60/12 -- 5
---1

--Also 3 Ebenen für den Index






select * from sys.dm_db_index_physical_stats(db_id(),object_id('indrechnung'), null, null, 'detailed')

--INdexverweis berechnen: 8 + 4 = 12



--neue Rechnung


select 1000000/34 --29500 Seiten

select 29500/12 --2458
select 2458/12 --204
select 204/12 -- 17
---1


