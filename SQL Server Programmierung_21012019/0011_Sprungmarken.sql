sprungmarke:


Goto Sprungmarke


erster:
print 'huhu'


hell:
goto erster

--Variablen: @var Lebensdauer: nur solange der Batch läuft

declare @i as int = 0
select @i 
go

select @i--hier ist Variable weg


--Variablen beliebn bestehen
declare @i as int = 0

erster:
set @i= @i+1

Goto dritter

hell:
set @i= @i+1

dritter:
select @i
goto hell


