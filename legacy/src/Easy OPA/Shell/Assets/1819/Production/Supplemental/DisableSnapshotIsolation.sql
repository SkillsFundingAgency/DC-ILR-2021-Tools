--The assumption is that the current database is the intrajob db
DECLARE @dbname varchar(100)
SET @dbname=quotename(db_name())
EXEC('ALTER DATABASE '+@dbname+'  SET ALLOW_SNAPSHOT_ISOLATION OFF');
EXEC('ALTER DATABASE '+@dbname+'  SET READ_COMMITTED_SNAPSHOT OFF');