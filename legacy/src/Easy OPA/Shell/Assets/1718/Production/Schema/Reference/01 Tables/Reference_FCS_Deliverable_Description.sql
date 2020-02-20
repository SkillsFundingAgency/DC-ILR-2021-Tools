
 IF OBJECT_ID('Reference.FCS_Deliverable_Description') IS NOT NULL
BEGIN
    DROP TABLE  [Reference].[FCS_Deliverable_Description]
END;

Create table [Reference].[FCS_Deliverable_Description]
	(
		[ContractAllocationNumber]    NVARCHAR(20) NOT NULL,
		[DeliverableCode]	          VARCHAR ( 10 ) NOT NULL,
		[DeliverableDescription]      NVARCHAR(255) NOT NULL,
	
	)
	 
  GO

