CREATE EVENT SESSION [WAITSONQUERYNORTH] ON SERVER 
ADD EVENT sqlos.wait_info(
    ACTION(sqlserver.query_hash,sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'%north%')))
ADD TARGET package0.event_file(SET filename=N'C:\_BACKUP\NwindWaits.xel'),
ADD TARGET package0.histogram(SET source=N'sqlserver.sql_text')
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO


