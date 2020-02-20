IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[SFAFundingModel35SummaryReportCount]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[SFAFundingModel35SummaryReportCount]
GO

CREATE PROCEDURE [Report].[SFAFundingModel35SummaryReportCount]
	
AS
BEGIN

	SELECT COUNT(*) FROM  [Report].[SFAFundingModel35SummaryReport] 

END

GO