
 IF OBJECT_ID('Reference.DeliverableCodeMappings') IS NOT NULL
BEGIN
    DROP TABLE  [Reference].[DeliverableCodeMappings]
END;

Create table [Reference].[DeliverableCodeMappings]
	(
		[ExternalDeliverableCode]    NVARCHAR(5) NULL,
		[FundingStreamPeriodCode]	          NVARCHAR ( 20 ) NULL,
		[DeliverableName]      NVARCHAR(120) NULL,
		[FCSDeliverableCode] bigint null
	
	)
	 
  GO

