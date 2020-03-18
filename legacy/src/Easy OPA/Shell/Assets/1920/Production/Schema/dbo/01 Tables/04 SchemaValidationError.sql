IF OBJECT_ID('SchemaValidationError') IS NOT NULL
BEGIN
    DROP TABLE  SchemaValidationError
END;

CREATE TABLE [dbo].[SchemaValidationError](
	[SchemaValidationError_Id]	INT IDENTITY(0,1) NOT NULL,
	[ErrorMessage]				NVARCHAR(2000) NULL,
	[FieldValues]				NVARCHAR(2000) NULL,
	[LearnRefNumber]			VARCHAR(100) NULL,
	[RuleName]					VARCHAR(50) NULL,
	[Severity]					CHAR(1) NULL
)
