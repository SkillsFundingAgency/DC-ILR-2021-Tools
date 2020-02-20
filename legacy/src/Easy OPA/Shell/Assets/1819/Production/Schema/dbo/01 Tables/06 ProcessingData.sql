IF OBJECT_ID('ProcessingData') IS NOT NULL
BEGIN
    DROP TABLE [dbo].[ProcessingData]
END;

CREATE TABLE [dbo].[ProcessingData](
	[Id] [int] IDENTITY(1,1),
	[UKPRN] [int] NULL,
	[FileDetailsID] int NULL,
	[ProcessingStep] [nvarchar](100) NULL,
	[ExecutionTime] [nvarchar](20) NULL
)
