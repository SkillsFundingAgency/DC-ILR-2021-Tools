IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[SFAFundingClaimReportCsvGetDataCount]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[SFAFundingClaimReportCsvGetDataCount]
GO

CREATE PROCEDURE [Report].[SFAFundingClaimReportCsvGetDataCount]
AS
BEGIN
	SELECT COUNT(*) FROM [Report].[SFAFundingClaimReportData]
END
GO
