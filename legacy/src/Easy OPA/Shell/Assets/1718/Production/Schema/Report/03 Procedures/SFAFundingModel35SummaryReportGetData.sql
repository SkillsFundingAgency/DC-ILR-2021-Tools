IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[SFAFundingModel35SummaryReportGetData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[SFAFundingModel35SummaryReportGetData]
GO

CREATE PROCEDURE [Report].[SFAFundingModel35SummaryReportGetData]
	
AS
BEGIN

	SELECT [FundingLine], 
						(SELECT [UKPRN]
						  ,[FundingLine]
						  ,[Period]
						  ,SUM([OnProgPayment]) AS 'OnProgPayment'
						  ,SUM([Balancing]) AS 'Balancing'
						  ,SUM([JobOutcomeAchievement]) AS 'JobOutcomeAchievement'
						  ,SUM([AimAchievement]) AS 'AimAchievement'
						  ,SUM([TotalAchievement]) AS 'TotalAchievement'
						  ,SUM([LearningSupport]) AS 'LearningSupport'
						  ,SUM([Total]) AS 'Total'
					  FROM [Report].[SFAFundingModel35SummaryReport] 
					  WHERE FundingLine = SFAFM35SP.FundingLine
					  GROUP BY UKPRN, FundingLine, Period
					  ORDER BY [Period] ASC FOR XML RAW ('FundLineValues'), ELEMENTS, TYPE)
FROM [Report].[SFAFundingModel35SummaryReport] SFAFM35SP 
	GROUP BY [FundingLine],[SortOrder] 	--SortOrder is by Funding Line
	ORDER BY [SortOrder]	
	FOR XML RAW ('FundLine'), ROOT ('ReportModelData')

END

GO