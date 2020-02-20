IF NOT EXISTS (
SELECT  schema_name
FROM    information_schema.schemata
WHERE   schema_name = 'Report' ) 

BEGIN
EXEC sp_executesql N'CREATE SCHEMA Report'
END









