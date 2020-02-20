IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[GetRuleViolationReportCount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Report].[GetRuleViolationReportCount]
GO


CREATE procedure [Report].[GetRuleViolationReportCount]

AS
BEGIN
 
SELECT COUNT(*) FROM Report.ViolationReport

END

GO