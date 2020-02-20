IF OBJECT_ID('Report.GetSFASupportFunding') IS NOT NULL
BEGIN
    DROP FUNCTION [Report].[GetSFASupportFunding]
END
GO

CREATE FUNCTION [Report].[GetSFASupportFunding] ()
RETURNS TABLE
AS 
RETURN
(
	 SELECT
		FundLine,
		SUM(Total6Months) as Total6Months,
		SUM(TotalYear) as TotalYear,
		(CASE FundLine
			WHEN '19-23 Apprenticeship' THEN 2
			WHEN '24+ Apprenticeship' THEN 4
			WHEN 'AEB - Other Learning' THEN 12
			WHEN '19-24 Traineeship' THEN 14
			WHEN '19-23 Trailblazer Apprenticeship' THEN 7 
			WHEN '24+ Trailblazer Apprenticeship' THEN 9
		END) as SortOrder,
		(CASE FundLine
			WHEN '19-23 Apprenticeship' THEN '19-23 Apprenticeship Frameworks - Learning Support'
			WHEN '24+ Apprenticeship' THEN '24+ Apprenticeship Frameworks - Learning Support'
			WHEN 'AEB - Other Learning' THEN 'Other Learning - Learning Support'
			WHEN '19-24 Traineeship' THEN '19-24 Traineeships - Learning Support'
			WHEN '19-23 Trailblazer Apprenticeship' THEN '19-23 Trailblazer Apprenticeships - Learning Support' 
			WHEN '24+ Trailblazer Apprenticeship' THEN '24+ Trailblazer Apprenticeships - Learning Support'
		END) as SubGroupDescription
	FROM (
		--SELECT '19-23 Apprenticeship' as FundLine, 0 as Total6Months, 0 as TotalYear
		--UNION ALL
		--SELECT '24+ Apprenticeship' as FundLine, 0 as Total6Months, 0 as TotalYear
		--UNION ALL
		SELECT 'AEB - Other Learning' as FundLine, 0 as Total6Months, 0 as TotalYear
		UNION ALL
		SELECT '19-24 Traineeship' as FundLine, 0 as Total6Months, 0 as TotalYear
		UNION ALL
		--SELECT '19-23 Trailblazer Apprenticeship' as FundLine, 0 as Total6Months, 0 as TotalYear
		--UNION ALL
		--SELECT '24+ Trailblazer Apprenticeship' as FundLine, 0 as Total6Months, 0 as TotalYear
		--UNION ALL
		SELECT FundLine, 
			(CASE FundLine
				--WHEN '19-23 Apprenticeship' THEN (ISNULL((SELECT [Report].[GetSFALearnSuppFundCash]('19-23 Apprenticeship',0)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Excess Learning Support: 19-23 Apprenticeships', 0)),0))
				
				--WHEN '24+ Apprenticeship' THEN (ISNULL((SELECT [Report].[GetSFALearnSuppFundCash]('24+ Apprenticeship',0)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Excess Learning Support: 24+ Apprenticeships', 0)),0))
				
				WHEN 'AEB - Other Learning' THEN (ISNULL((SELECT [Report].[GetSFALearnSuppFundCash]('AEB - Other Learning,AEB - Other Learning (non-procured)',0)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Excess Learning Support: AEB-Other Learning', 0)),0))

				WHEN '19-24 Traineeship' THEN (ISNULL((SELECT [Report].[GetSFALearnSuppFundCash]('19-24 Traineeship,19-24 Traineeship (non-procured)',0)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Excess Learning Support: 19-24 Traineeships', 0)),0))

				--WHEN '19-23 Trailblazer Apprenticeship' THEN (ISNULL((SELECT [Report].[GetTrailblazerLearnSuppFundCash]('19-23 Trailblazer Apprenticeship',0)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Excess Learning Support: 19-23 Trailblazer Apprenticeships', 0)),0))
				
				--WHEN '24+ Trailblazer Apprenticeship' THEN (ISNULL((SELECT [Report].[GetTrailblazerLearnSuppFundCash]('24+ Trailblazer Apprenticeship',0)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Excess Learning Support: 24+ Trailblazer Apprenticeships', 0)),0))
            END ) as Total6Months,

			(CASE FundLine
				--WHEN '19-23 Apprenticeship' THEN (ISNULL((SELECT [Report].[GetSFALearnSuppFundCash]('19-23 Apprenticeship',1)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Excess Learning Support: 19-23 Apprenticeships', 1)),0))
				
				--WHEN '24+ Apprenticeship' THEN  (ISNULL((SELECT [Report].[GetSFALearnSuppFundCash]('24+ Apprenticeship',1)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Excess Learning Support: 24+ Apprenticeships', 1)),0))

				WHEN 'AEB - Other Learning' THEN (ISNULL((SELECT [Report].[GetSFALearnSuppFundCash]('AEB - Other Learning,AEB - Other Learning (non-procured)',1)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Excess Learning Support: AEB-Other Learning', 1)),0))

				WHEN '19-24 Traineeship' THEN (ISNULL((SELECT [Report].[GetSFALearnSuppFundCash]('19-24 Traineeship,19-24 Traineeship (non-procured)',1)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Excess Learning Support: 19-24 Traineeships', 1)),0))

				--WHEN '19-23 Trailblazer Apprenticeship' THEN (ISNULL((SELECT [Report].[GetTrailblazerLearnSuppFundCash]('19-23 Trailblazer Apprenticeship',1)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Excess Learning Support: 19-23 Trailblazer Apprenticeships', 1)),0))
				
				--WHEN '24+ Trailblazer Apprenticeship' THEN (ISNULL((SELECT [Report].[GetTrailblazerLearnSuppFundCash]('24+ Trailblazer Apprenticeship',1)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Excess Learning Support: 24+ Trailblazer Apprenticeships', 1)),0))
                 END) as TotalYear
				FROM (SELECT stringVal AS FundLine FROM ConvertCSVToTable('AEB - Other Learning,19-24 Traineeship')) FUNDLINES
				) AS ReturnTable GROUP BY FundLine
)
GO
