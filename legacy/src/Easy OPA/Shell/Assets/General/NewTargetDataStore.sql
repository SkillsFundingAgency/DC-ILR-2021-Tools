if exists (select * from sys.Schemas where name = '${TargetDataStore}') 
begin 
	DECLARE @Sql VARCHAR(MAX),
	@Schema VARCHAR(30)

SET @Schema = '${TargetDataStore}'

SELECT @Sql = COALESCE(@Sql,'') + 'DROP TABLE %SCHEMA%.' + QUOTENAME(TABLE_NAME) + ';' + CHAR(13)
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = @Schema
    AND TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME

SELECT @Sql = COALESCE(@Sql, '') + 'DROP SCHEMA %SCHEMA%;'

SELECT @Sql = COALESCE(REPLACE(@Sql,'%SCHEMA%',@Schema), '')


EXEC(@Sql)
end
go

create schema [${TargetDataStore}]
go