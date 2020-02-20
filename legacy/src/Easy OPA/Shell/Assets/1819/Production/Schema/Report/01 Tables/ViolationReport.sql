IF OBJECT_ID('Report.ViolationReport') IS NOT NULL
BEGIN
    DROP TABLE  [Report].[ViolationReport]
END;

  CREATE TABLE [Report].[ViolationReport]
  (
	RuleName			NVARCHAR(50)
	,[Source]			NVARCHAR(40)
	,Severity			NVARCHAR(20)
	,LearnRefNumber		NVARCHAR(100)
	,FieldValues		NVARCHAR(2000)
	,ErrorMessage		NVARCHAR(2000)
	,FileLevelError		INT
	,AimSeqNum			INT
	,LearnAimRef		NVARCHAR(1000)
	,FundModel			INT
	,PartnerUKPRN		BIGINT
	,SWSupAimID			NVARCHAR(1000)
	,ProviderSpecLearnOccurA NVARCHAR(1000)
	,ProviderSpecLearnOccurB NVARCHAR(1000)
	,ProviderSpecDelOccurA	NVARCHAR(1000)
	,ProviderSpecDelOccurB	NVARCHAR(1000)
	,ProviderSpecDelOccurC	NVARCHAR(1000)
	,ProviderSpecDelOccurD  NVARCHAR(1000)
  )