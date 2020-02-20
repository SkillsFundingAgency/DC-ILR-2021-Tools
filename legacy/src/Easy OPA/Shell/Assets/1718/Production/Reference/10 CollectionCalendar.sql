DECLARE @CollectionType NVARCHAR(20) = 'ILR1718'

INSERT INTO [Reference].[CollectionCalendar]
EXEC [${Collections_Calendar.servername}].[${Collections_Calendar.databasename}].[dbo].[GetCalendar]  @CollectionType
