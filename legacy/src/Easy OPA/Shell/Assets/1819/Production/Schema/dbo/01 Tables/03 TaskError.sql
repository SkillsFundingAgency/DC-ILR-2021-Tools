IF OBJECT_ID('TaskError') IS NOT NULL
BEGIN
    DROP TABLE  TaskError
END;

  CREATE TABLE [TaskError]
  (
    [TaskError_Id] INT IDENTITY(0,1) PRIMARY KEY,
    [LineNumber]	INT,
	[LinePosition]	Int,
    [ErrorDescription]	NVARCHAR(MAX),
	[FileName] VARCHAR(255)
  )

