use northwind;


select * from sys.indexes ---235 IX auff 316

--dmv_IX Verwendung seit dem Neustart des SQL Serv ers
select * from sys.dm_db_index_usage_Stats where database_id =db_id()

---IX: SEEK oder SCAN..? SEEK