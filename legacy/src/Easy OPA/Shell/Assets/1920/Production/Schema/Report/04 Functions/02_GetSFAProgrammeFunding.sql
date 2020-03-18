IF OBJECT_ID('Report.GetSFAProgrammeFunding') IS NOT NULL
BEGIN
    DROP FUNCTION  [Report].[GetSFAProgrammeFunding]
END
GO

CREATE FUNCTION [Report].[GetSFAProgrammeFunding] ()
RETURNS TABLE
AS 
RETURN
(
	SELECT FundLine, SUM(Total6Months) as Total6Months, SUM(TotalYear) as TotalYear,
			(CASE FundLine
					WHEN '19-23 Apprenticeship' THEN 1
					WHEN '24+ Apprenticeship' THEN 3
					WHEN 'AEB - Other Learning' THEN 11
					WHEN '19-24 Traineeship' THEN 13
					WHEN '19-23 Trailblazer Apprenticeship' THEN 6 
					WHEN '24+ Trailblazer Apprenticeship' THEN 8 END) as SortOrder,
			(CASE FundLine
					WHEN '19-23 Apprenticeship' THEN '19-23 Apprenticeship Frameworks - Programme Funding'
					WHEN '24+ Apprenticeship' THEN '24+ Apprenticeship Frameworks - Programme Funding'
					WHEN 'AEB - Other Learning' THEN 'Other Learning - Programme Funding'
					WHEN '19-24 Traineeship' THEN '19-24 Traineeships - Programme Funding' 
					WHEN '19-23 Trailblazer Apprenticeship' THEN '19-23 Trailblazer Apprenticeships - Programme Funding' 
					WHEN '24+ Trailblazer Apprenticeship' THEN '24+ Trailblazer Apprenticeships - Programme Funding' END) as SubGroupDescription FROM (
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
				--WHEN '19-23 Apprenticeship' THEN (ISNULL((SELECT [Report].[GetSFAOnProgPayment]('19-23 Apprenticeship',0)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Audit Adjustments: 19-23 Apprenticeships,Authorised Claims: 19-23 Apprenticeships', 0)),0))
			
				--WHEN '24+ Apprenticeship' THEN (ISNULL((SELECT [Report].[GetSFAOnProgPayment]('24+ Apprenticeship',0)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Audit Adjustments: 24+ Apprenticeships,Authorised Claims: 24+ Apprenticeships', 0)),0))

				WHEN 'AEB - Other Learning' THEN (ISNULL((SELECT [Report].[GetSFAOnProgPayment]('AEB - Other Learning,AEB - Other Learning (non-procured)',0)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Audit Adjustments: AEB-Other Learning,Authorised Claims: AEB-Other Learning', 0)),0))
					 + ISNULL((SELECT [Report].[GetSFAEmpPayment]('AEB - Other Learning,AEB - Other Learning (non-procured)', 0)) ,0) 
					 + ISNULL((SELECT [Report].[GetSFAEFAFundingClaimForType]('25+ Students with an EHCP', 0)) ,0)

				WHEN '19-24 Traineeship' THEN (ISNULL((SELECT [Report].[GetSFAOnProgPayment]('19-24 Traineeship,19-24 Traineeship (non-procured)',0)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Audit Adjustments: 19-24 Traineeships,Authorised Claims: 19-24 Traineeships', 0)),0))
					+ ISNULL((SELECT [Report].[GetSFAEmpPayment]('19-24 Traineeship,19-24 Traineeship (non-procured)', 0)) ,0) + ISNULL((SELECT [Report].[GetSFAEFAFundingClaimForType]('19+ Traineeships (Adult Funded)', 0)),0)
					
				--WHEN '19-23 Trailblazer Apprenticeship' THEN (ISNULL((SELECT [Report].[GetSFATrailblazerProgPayment]('19-23 Trailblazer Apprenticeship',0)),0) + ISNULL((SELECT [Report].GetSFAEASForType('Audit Adjustments: 19-23 Trailblazer Apprenticeships,Authorised Claims: 19-23 Trailblazer Apprenticeships', 0)),0)) --Trailblazer code

				--WHEN '24+ Trailblazer Apprenticeship' THEN (ISNULL((SELECT [Report].[GetSFATrailblazerProgPayment]('24+ Trailblazer Apprenticeship',0)),0) + ISNULL((SELECT [Report].GetSFAEASForType('Audit Adjustments: 24+ Trailblazer Apprenticeships,Authorised Claims: 24+ Trailblazer Apprenticeships', 0)),0)) --Trailblazer code
					
					 END) as Total6Months,

			(CASE FundLine
				--WHEN '19-23 Apprenticeship'  THEN (ISNULL((SELECT [Report].[GetSFAOnProgPayment]('19-23 Apprenticeship',1)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Audit Adjustments: 19-23 Apprenticeships,Authorised Claims: 19-23 Apprenticeships', 1)),0))
				
				--WHEN '24+ Apprenticeship' THEN (ISNULL((SELECT [Report].[GetSFAOnProgPayment]('24+ Apprenticeship',1)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Audit Adjustments: 24+ Apprenticeships,Authorised Claims: 24+ Apprenticeships', 1)),0))

				WHEN 'AEB - Other Learning' THEN (ISNULL((SELECT [Report].[GetSFAOnProgPayment]('AEB - Other Learning,AEB - Other Learning (non-procured)',1)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Audit Adjustments: AEB-Other Learning,Authorised Claims: AEB-Other Learning', 1)),0))
					  + ISNULL((SELECT [Report].[GetSFAEmpPayment]('AEB - Other Learning,AEB - Other Learning (non-procured)', 1)) ,0)
					  + ISNULL((SELECT [Report].[GetSFAEFAFundingClaimForType]('25+ Students with an EHCP', 1)) ,0)

				WHEN '19-24 Traineeship' THEN (ISNULL((SELECT [Report].[GetSFAOnProgPayment]('19-24 Traineeship,19-24 Traineeship (non-procured)',1)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Audit Adjustments: 19-24 Traineeships,Authorised Claims: 19-24 Traineeships', 1)),0))
					+ ISNULL((SELECT [Report].[GetSFAEmpPayment]('19-24 Traineeship,19-24 Traineeship (non-procured)', 1)) ,0)+ ISNULL((SELECT [Report].[GetSFAEFAFundingClaimForType]('19+ Traineeships (Adult Funded)', 1)),0) 
					
				--WHEN '19-23 Trailblazer Apprenticeship' THEN (ISNULL((SELECT [Report].[GetSFATrailblazerProgPayment]('19-23 Trailblazer Apprenticeship',1)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Audit Adjustments: 19-23 Trailblazer Apprenticeships,Authorised Claims: 19-23 Trailblazer Apprenticeships', 1)),0)) --Trailblazer code

				--WHEN '24+ Trailblazer Apprenticeship' THEN (ISNULL((SELECT [Report].[GetSFATrailblazerProgPayment]('24+ Trailblazer Apprenticeship',1)),0) + ISNULL((SELECT [Report].[GetSFAEASForType]('Audit Adjustments: 24+ Trailblazer Apprenticeships,Authorised Claims: 24+ Trailblazer Apprenticeships', 1)),0)) --Trailblazer code

					END) as TotalYear
				FROM (SELECT stringVal AS FundLine FROM ConvertCSVToTable('AEB - Other Learning,19-24 Traineeship')) FUNDLINES
				) AS ReturnTable GROUP BY FundLine
)
GO
