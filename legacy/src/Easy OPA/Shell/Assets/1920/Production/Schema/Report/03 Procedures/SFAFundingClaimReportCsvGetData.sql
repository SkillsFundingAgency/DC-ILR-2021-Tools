IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[SFAFundingClaimReportCsvGetData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[SFAFundingClaimReportCsvGetData]
GO

CREATE PROCEDURE [Report].[SFAFundingClaimReportCsvGetData]
	@Page INT,
	@PageSize INT
AS
BEGIN
	IF '${dcft.runmode}' = 'DPS'
	BEGIN
		SELECT
			[UKPRN],
			[Description],
			[Actual Earnings (6 months)],
			[Actual Earnings (12 months)],
			'' AS 'OFFICIAL-SENSITIVE'
		FROM (
			SELECT
				ROW_NUMBER() OVER (ORDER BY [SortOrder]) AS [RowNumber],
				[UKPRN] AS [UKPRN],
				[SubGroupDescription] AS [Description],
				[Total6Months] AS [Actual Earnings (6 months)],
				[TotalYear] AS [Actual Earnings (12 months)]
				--[SecurityClassification] AS [Security Classfication]
			FROM [Report].[SFAFundingClaimReportData]
		) Report
		WHERE [RowNumber] BETWEEN ((@Page - 1) * @PageSize) AND (@Page * @PageSize - 1)
		ORDER BY [RowNumber]
	END
	ELSE
	BEGIN
		SELECT
			[Warning],
			[UKPRN],
			[Description],
			[Actual Earnings (6 months)],
			[Actual Earnings (12 months)],
			'' AS 'OFFICIAL-SENSITIVE'
		FROM (
			SELECT
				ROW_NUMBER() OVER (ORDER BY [SortOrder]) AS [RowNumber],
				[Warning],
				[UKPRN] AS [UKPRN],
				[SubGroupDescription] AS [Description],
				[Total6Months] AS [Actual Earnings (6 months)],
				[TotalYear] AS [Actual Earnings (12 months)]
				--[SecurityClassification] AS [Security Classfication]
			FROM [Report].[SFAFundingClaimReportData]
		) Report
		WHERE [RowNumber] BETWEEN ((@Page - 1) * @PageSize) AND (@Page * @PageSize - 1)
		ORDER BY [RowNumber]
	END
END
GO
