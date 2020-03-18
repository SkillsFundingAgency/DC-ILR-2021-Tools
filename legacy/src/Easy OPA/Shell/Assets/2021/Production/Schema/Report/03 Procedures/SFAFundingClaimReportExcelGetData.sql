IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[SFAFundingClaimReportExcelGetData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[SFAFundingClaimReportExcelGetData]
GO

CREATE PROCEDURE [Report].[SFAFundingClaimReportExcelGetData]
AS
BEGIN
	SELECT (
		SELECT *
		FROM [Report].[SFAFundingClaimReportData]
		ORDER BY [SortOrder] FOR XML RAW('SFAFundingClaimData'), TYPE
	)
	FOR XML RAW('ILRCommonReportsReport_Object_GraphsSFA_Funding_Claim')
END
GO