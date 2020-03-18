IF OBJECT_ID('SQLValidationError') IS NOT NULL
BEGIN
    DROP TABLE  SQLValidationError
END;

CREATE TABLE [dbo].[SQLValidationError](
	[ValidationError_Id]		INT IDENTITY(0,1) NOT NULL,
	[Source]					VARCHAR(50) NULL,
	[FieldValues]				NVARCHAR(2000) NULL,
	[LearnRefNumber]			VARCHAR(100) NULL,
	[AimSeqNum]                 BIGINT, 
	[RuleName]					VARCHAR(50) NULL,
	[FileLevelError]			INT DEFAULT 0,	
	[CreatedOn]					DATETIME DEFAULT GETDATE()
)

--CREATE NONCLUSTERED INDEX [Index_ValidationError_Severity]
--ON [dbo].[SQLValidationError] ([LearnRefNumber],[Severity])

