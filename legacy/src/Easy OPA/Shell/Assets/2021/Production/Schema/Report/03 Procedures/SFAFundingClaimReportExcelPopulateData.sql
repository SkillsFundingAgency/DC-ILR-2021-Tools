IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[SFAFundingClaimReportExcelPopulateData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[SFAFundingClaimReportExcelPopulateData]
GO

CREATE PROCEDURE [Report].[SFAFundingClaimReportExcelPopulateData]
AS
BEGIN
	DECLARE @UKPRN BIGINT

	SET @UKPRN = (SELECT [UKPRN] FROM [Valid].[LearningProvider])

	--Truncate report data (if any)
	TRUNCATE TABLE [Report].[SFAFundingClaimReportData]

	-- Populate [Report].[SFAFundingClaimReportData] - 'Adult Apprenticeships' and 'Adult Education Budget' sections
	INSERT INTO [Report].[SFAFundingClaimReportData] (
		[FundLine],
        [Total6Months],
        [TotalYear],
        [SortOrder],
        [SubGroupDescription],
		[UKPRN])
	SELECT 
		tab.*,
		@UKPRN
	FROM (
		SELECT * FROM [Report].[GetSFAProgrammeFunding]()
		UNION
		SELECT * FROM [Report].[GetSFASupportFunding]()
		UNION
		--SELECT '19+ Apprenticeships' as FundLine, 
		--	(SELECT [Report].[GetSFAEASForType]('Learner Support: 19-23 Apprenticeships,Learner Support: 24+ Apprenticeships', 0)) as Total6Months,
		--	(SELECT [Report].[GetSFAEASForType]('Learner Support: 19-23 Apprenticeships,Learner Support: 24+ Apprenticeships', 1)) as TotalYear,
		--	5 as SortOrder,
		--	'19+ Apprenticeship Frameworks - Learner Support' as SubGroupHeader
		--UNION
		SELECT '19-24 Traineeships' as FundLine, 
			(SELECT [Report].[GetSFAEASForType]('Learner Support: 19-24 Traineeships', 0)) as Total6Months,
			(SELECT [Report].[GetSFAEASForType]('Learner Support: 19-24 Traineeships', 1)) as TotalYear,
			15 as SortOrder,
			'19-24 Traineeships - Learner Support' as SubGroupHeader
	) tab

	-- Populate [Report].[SFAFundingClaimReportData] - totals for 'Adult Apprenticeships' and 'Adult Education Budget'
	INSERT INTO [Report].[SFAFundingClaimReportData] (
		[FundLine],
		[Total6Months],
		[TotalYear],
		[SortOrder],
		[SubGroupDescription],
		[UKPRN]
	)
	--SELECT
	--	'Adult Apprenticeships' AS [FundLine],
	--	SUM(Total6Months) AS [Total6Months],
	--	SUM(TotalYear) AS [TotalYear],
	--	10 AS [SortOrder],
	--	'Total Adult Apprenticeships Delivery for starts before 1 May 2017' AS [SubGroupDescription],
	--	@UKPRN AS [UKPRN]
	--FROM [Report].[SFAFundingClaimReportData]
	--WHERE [SortOrder] BETWEEN 1 AND 9
	--UNION ALL
	SELECT
		'Adult Education' AS [FundLine],
		SUM(Total6Months) AS [Total6Months],
		SUM(TotalYear) AS [TotalYear],
		16 AS [SortOrder],
		'Total Adult Education Budget Delivery - non-procured' AS [SubGroupDescription],
		@UKPRN AS [UKPRN]
	FROM [Report].[SFAFundingClaimReportData]
	WHERE [SortOrder] BETWEEN 11 AND 15

	-- Populate [Report].[SFAFundingClaimReportData] - 'Advanced Learner Loans Bursary' section
	;WITH CTE_Allb AS (
		SELECT * FROM [Report].GetSFAClaimBursaryFunding()
	)
	INSERT INTO [Report].[SFAFundingClaimReportData] (
		[FundLine],
		[Total6Months],
		[TotalYear],
		[SortOrder],
		[SubGroupDescription],
		[UKPRN]
	)
	SELECT
		'ALLB' AS [FundLine],
		[AlbTotalSupp6Months] AS [Total6Months],
		[AlbTotalSuppYear] AS [TotalYear],
		17 AS [SortOrder],
		'Loans - Bursary Funding' AS [SubGroupDescription],
		@UKPRN AS [UKPRN]
	FROM CTE_Allb
	UNION ALL
	SELECT
		'ALLB' AS [FundLine],
		[AlbTotal6Months] AS [Total6Months],
		[AlbTotalYear] AS [TotalYear],
		18 AS [SortOrder],
		'Loans - Area Costs' AS [SubGroupDescription],
		@UKPRN AS [UKPRN]
	FROM CTE_Allb
	UNION ALL
	SELECT
		'ALLB' AS [FundLine],
		[AlbExcessSupport6Months] AS [Total6Months],
		[AlbExcessSupportYear] AS [TotalYear],
		19 AS [SortOrder],
		'Loans - Excess Support' AS [SubGroupDescription],
		@UKPRN AS [UKPRN]
	FROM CTE_Allb
	UNION ALL
	SELECT
		'ALLB' AS [FundLine],
		[AlbTotalSupp6Months] + [AlbTotal6Months] + [AlbExcessSupport6Months] AS [Total6Months],
		[AlbTotalSuppYear] + [AlbTotalYear] + [AlbExcessSupportYear] AS [TotalYear],
		20 AS [SortOrder],
		'Total Loans Bursary Delivery' AS [SubGroupDescription],
		@UKPRN AS [UKPRN]
	FROM CTE_Allb
END

GO