IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[SFAFundingModel35SummaryReportCSVGetData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[SFAFundingModel35SummaryReportCSVGetData]
GO

CREATE PROCEDURE [Report].[SFAFundingModel35SummaryReportCSVGetData]
	@Page INT,
	@PageSize INT
AS
BEGIN

	SELECT  UKPRN,	[Funding Line Type],	 [Period],	[On-programme (£)],	[Balancing (£)],
		[Job Outcome Achievement (£)],	[Aim Achievement (£)],	[Total Achievement (£)],	[Learning Support (£)],
		[Total (£)], '' AS	'OFFICIAL - SENSITIVE' 
	FROM(
			SELECT	[UKPRN]
					,[FundingLine] AS [Funding Line Type]
					,[Period]
					,[OnProgPayment] AS 'On-programme (£)'
					,[Balancing]  AS 'Balancing (£)'
					,[JobOutcomeAchievement] AS 'Job Outcome Achievement (£)'
					,[AimAchievement]  AS 'Aim Achievement (£)'
					,[TotalAchievement] AS 'Total Achievement (£)'
					,[LearningSupport] AS 'Learning Support (£)'
					,[Total] AS 'Total (£)'					
					,ROW_NUMBER() OVER (ORDER BY SortOrder ASC, Period ASC) AS [RowNumber]
			FROM [Report].[SFAFundingModel35SummaryReport] 
		)AS A
	WHERE RowNumber BETWEEN ((@Page - 1) * @PageSize) AND (@Page * @PageSize - 1)
	ORDER BY [RowNumber] ASC

END

GO