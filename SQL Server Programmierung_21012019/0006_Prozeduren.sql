--Prozeduren

/*
Proz sind schneller
Beim ersten Aufruf wird der Ausführungsplan erstellt (kompiliert)

Proc können komplette BI enthalten (I UP DEL SEL)

Proc liegen auf dem Server (praktisch für Anwendungen)




*/


create proc gpname @par1 int, @par2 int
as
select * from tab where sp = @par1 and sp2 = @par2
GO



--default Werte

create proc gpTest @par1 int= 1, @par2 int
as
select @par1 * @par2
GO

exec gpTest 10,20

exec gpTest @par1=10, @par2=20

exec gpTest @par2=30, @par1= 5


Alter procedure gptest2 @par1 int, @par2 int, @par3 int output
as
select @par3=@par1*@par2
select @par3

exec gptest2 10,20 --solange man nichts anderes sagt ist auch @par3 output zugleich ein INPUT!!

exec gptest2 10,20, NULL

--aber der Ausgabewert soll weiterverwendet werden können

declare @myvar int

exec gpTest2 @par1=10,@par2=20, @par3 = @myvar output--warum nicht @myvar = @par3  geht nicht
select @myvar




create proc gpFrachtSchnitt @schnitt money output
as
select @schnitt=avg(freight) from orders
GO



declare @frachtschnitt as money
exec gpFrachtschnitt @schnitt=@frachtschnitt output
GO --Batch zu Ende

select * from orders where freight < @frachtschnitt order by freight desc


--Select * from orders
--Proc soll Schnitt der Frachtkosten errechnen
--das Ergebnis der Proc verwenden für
---alle Bestellungen die unter dem Schnitt liegen

--Variablen

-- beginnen mit @
@var
@@var

--mit @ lokale Variable
-- mit @@ globale Variable

--Gültigkeitsdauer: nur während eines batches
--Gültigkeitsort: @ gilt nur in der Ersteller Verbinung
--@@var glt auch in anderen Verbindung
---Einsatz von glob. fast unmgöglich

select @@connections --Systeminfos

--als DEV nur lokale Variablen


declare @i as int, @var2 int
set @i = 1

declare @i2 as int = 10

declare @var1 as varchar(50)

select @var1=companyname from customers where customerid = 'ALFKI'
select @var1

--Variablen können alle Datentypen haben , aber auch Tabellen

--@tabelle (id int..)

--wann temp Tabellen vs @tab
--@tab bei unter 1000 Zeilen
--@tab keine Indizes
--@tab nicht in der tempdb
--@tab nur während des Batches vorhanden








exec gpTest @par2=60 --weil 1 Default Wert von 1 besitzt

--das Ergebnis der Prozedur soll weiterverwendet werden




