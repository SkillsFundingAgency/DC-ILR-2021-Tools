IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[GetRuleViolationReportData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Report].[GetRuleViolationReportData]
GO


CREATE procedure [Report].[GetRuleViolationReportData]
@Page int,
@PageSize int

AS
BEGIN
--DECLARE @Page int = 1;
--DECLARE @PageSize int = 1000;

SELECT
 [Error\Warning],
[Learner Ref],
[Rule Name],
[Field Values],
[Error Message],
[Aim Sequence Number],
[Aim Reference Number],
[Software Supplier Aim ID],
[Funding Model],
[Subcontracted UKPRN],
[Provider Specified Learner Monitoring A],
[Provider Specified Learner Monitoring B],
[Provider Specified Learning Delivery Monitoring A],
[Provider Specified Learning Delivery Monitoring B],
[Provider Specified Learning Delivery Monitoring C],
[Provider Specified Learning Delivery Monitoring D],
'' AS 'OFFICIAL-SENSITIVE'
FROM(
SELECT 
	ROW_NUMBER() OVER (ORDER BY Severity,ISNULL(LearnRefNumber,''), RuleName, AimSeqNum) AS [RowNumber],
	Severity AS [Error\Warning],
	LearnRefNumber [Learner Ref],
	RuleName AS [Rule Name],
	FieldValues AS [Field Values],
	ErrorMessage AS [Error Message],
	AimSeqNum As [Aim Sequence Number],
	LearnAimRef AS [Aim Reference Number],
	SWSupAimID  AS [Software Supplier Aim ID],
	FundModel AS [Funding Model],
	PartnerUKPRN AS [Subcontracted UKPRN],
	ProviderSpecLearnOccurA AS [Provider Specified Learner Monitoring A],
	ProviderSpecLearnOccurB AS [Provider Specified Learner Monitoring B],
	ProviderSpecDelOccurA AS [Provider Specified Learning Delivery Monitoring A],
	ProviderSpecDelOccurB AS [Provider Specified Learning Delivery Monitoring B],
	ProviderSpecDelOccurC AS [Provider Specified Learning Delivery Monitoring C],
	ProviderSpecDelOccurD AS [Provider Specified Learning Delivery Monitoring D]
	--'OFFICIAL-SENSITIVE' as 'Security classification'
FROM Report.ViolationReport	
)OUTER_SELECT
 WHERE RowNumber BETWEEN ((@Page - 1) * @PageSize) AND (@Page * @PageSize - 1)
 Order by rownumber

END

GO