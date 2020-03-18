
 IF OBJECT_ID('Reference.ESF_SupplementaryData') IS NOT NULL
BEGIN
    DROP TABLE  [Reference].[ESF_SupplementaryData]
END;

create table [Reference].[ESF_SupplementaryData]
	(
		[ConRefNumber]	    VARCHAR ( 20 ) NOT NULL,
		[DeliverableCode]	VARCHAR ( 10 ) NOT NULL,
		[CalendarYear]		INT            NOT NULL,
	    [CalendarMonth]		INT            NOT NULL,
	    [CostType]			VARCHAR ( 20 ) NOT NULL,
		[ReferenceType]		VARCHAR ( 20 ) NOT NULL,
	    [Reference]			VARCHAR ( 100 )NOT NULL,	
	    [Value]				DECIMAL ( 8, 2 )   NULL ,
	)
	 
  GO

