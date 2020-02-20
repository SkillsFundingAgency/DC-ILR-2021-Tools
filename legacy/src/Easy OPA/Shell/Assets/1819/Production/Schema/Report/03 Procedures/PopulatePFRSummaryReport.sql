IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[PopulatePFRSummaryReport]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[PopulatePFRSummaryReport]
GO

CREATE PROCEDURE [Report].[PopulatePFRSummaryReport]
AS
BEGIN
	DECLARE @CollectionPeriod DATE =	(
											SELECT
												CASE '${dcft.runmode}'
													WHEN 'DS' THEN
														(SELECT TOP 1 ISNULL([FilePreparationDate], CONVERT(DATE, GETDATE())) FROM [Valid].[CollectionDetails])
													ELSE CONVERT(DATE, GETDATE()) END
										);
	
	DECLARE @CollectionPeriodInt INT =	(
											SELECT	ISNULL((SELECT CAST(RIGHT(CollectionReturnCode, LEN(CollectionReturnCode)-1) AS INT) 
											FROM	[Reference].[CollectionCalendar] 
											WHERE	@CollectionPeriod BETWEEN [ProposedOpenDate] AND [ProposedClosedDate]),12)
										);

	-- Clear previous report data - needed by FIS
	TRUNCATE TABLE [Report].[FundingSummary_1618]
	TRUNCATE TABLE [Report].[FundingSummary_Total1618]
	TRUNCATE TABLE [Report].[FundingSummary_1618Traineeships]
	TRUNCATE TABLE [Report].[FundingSummary_Total1618Traineeships]
	TRUNCATE TABLE [Report].[FundingSummary_1923]
	TRUNCATE TABLE [Report].[FundingSummary_Total1923]
	TRUNCATE TABLE [Report].[FundingSummary_24Plus]
	TRUNCATE TABLE [Report].[FundingSummary_Total24Plus]
	TRUNCATE TABLE [Report].[FundingSummary_1924Traineeships]
	TRUNCATE TABLE [Report].[FundingSummary_Total1924Traineeships]
	TRUNCATE TABLE [Report].[FundingSummary_AebOther]
	TRUNCATE TABLE [Report].[FundingSummary_TotalAebOther]
	TRUNCATE TABLE [Report].[FundingSummary_24PlusAdvLoansBursary]
	TRUNCATE TABLE [Report].[FundingSummary_Total24PlusAdvLoansBursary]
	TRUNCATE TABLE [Report].[FundingSummary_AdultOLASS]
	TRUNCATE TABLE [Report].[FundingSummary_TotalAdultOLASS]
	TRUNCATE TABLE [Report].[FundingSummary_1618Trailblazers]
	TRUNCATE TABLE [Report].[FundingSummary_Total1618Trailblazers]
	TRUNCATE TABLE [Report].[FundingSummary_1923Trailblazers]
	TRUNCATE TABLE [Report].[FundingSummary_Total1923Trailblazers]
	TRUNCATE TABLE [Report].[FundingSummary_24PlusTrailblazers]
	TRUNCATE TABLE [Report].[FundingSummary_Total24PlusTrailblazers]
	TRUNCATE TABLE [Report].[FundingSummary_Total1618Budget]
	TRUNCATE TABLE [Report].[FundingSummary_TotalAdultAppBudget]
	TRUNCATE TABLE [Report].[FundingSummary_TotalNonAppBudget]
	TRUNCATE TABLE [Report].[FundingSummary_TotalAdultBudget]
	TRUNCATE TABLE [Report].[FundingSummary_ExceptionalLearningSupport]
	TRUNCATE TABLE [Report].[FundingSummary_LineTotalsOLASSEASCancellationCosts]

	TRUNCATE TABLE [REPORT].[FundingSummary_1618LevyContractedApprenticeships]
	TRUNCATE TABLE [REPORT].[FundingSummary_AdultLevyContractedApprenticeships]
	TRUNCATE TABLE [REPORT].[FundingSummary_Total1618LevyContractedApprenticeships]
	TRUNCATE TABLE [REPORT].[FundingSummary_TotalAdultLevyContractedApprenticeships]
	TRUNCATE TABLE [Report].[FundingSummary_TotalLevyBudget]

	TRUNCATE TABLE [REPORT].[FundingSummary_1618NonLevyContractedApprenticeships]	
	TRUNCATE TABLE [REPORT].[FundingSummary_AdultNonLevyContractedApprenticeships]	
	TRUNCATE TABLE [REPORT].[FundingSummary_Total1618NonLevyContractedApprenticeships]	
	TRUNCATE TABLE [REPORT].[FundingSummary_TotalAdultNonLevyContractedApprenticeships]	
	TRUNCATE TABLE [Report].[FundingSummary_TotalNonLevyBudget]

	-- Populate [Report] schema tables
	INSERT INTO [Report].[FundingSummary_1618]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb]
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	*
	FROM
	(
			SELECT 'ILR 16-18 Apprenticeship Frameworks Programme Funding'		 AS SubGroupHeader,1 AS SortOrder,'LineTotals1618Apprenticeship' AS DataSetName, * FROM dbo.GetSFAFundingForType('16-18 Apprenticeship',					@CollectionPeriodInt) UNION
			SELECT 'ILR 16-18 Apprenticeship Frameworks Learning Support'		 AS SubGroupHeader,2 AS SortOrder,'LineTotals1618Apprenticeship' AS DataSetName, * FROM dbo.GetLSFFundingForType('16-18 Apprenticeship',					@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Apprenticeship Frameworks Audit Adjustments'		 AS SubGroupHeader,4 AS SortOrder,'LineTotals1618Apprenticeship' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: 16-18 Apprenticeships',		@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Apprenticeship Frameworks Authorised Claims'		 AS SubGroupHeader,5 AS SortOrder,'LineTotals1618Apprenticeship' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: 16-18 Apprenticeships',		@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Apprenticeship Frameworks Excess Learning Support' AS SubGroupHeader,6 AS SortOrder,'LineTotals1618Apprenticeship' AS DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: 16-18 Apprenticeships', @CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Apprenticeship Frameworks Learner Support'		 AS SubGroupHeader,7 AS SortOrder,'LineTotals1618Apprenticeship' AS DataSetName, * FROM dbo.GetEASFunding('Learner Support: 16-18 Apprenticeships',			@CollectionPeriodInt)
	) AS a

	INSERT INTO [Report].[FundingSummary_Total1618]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	* 
	FROM 
	(
			SELECT	'Total 16-18 Apprenticeship Frameworks for starts before 1 May 2017'	AS SubGroupHeader
					,9																		AS SortOrder
					,'LineTotals1618Apprenticeship'											AS DataSetName
					,SUM(YTDCalc)															AS YTDCalc
					,SUM(TotalCalc)															AS TotalCalc
					,SUM(AugToMar)															AS AugToMar
					,SUM(AprToJul)															AS AprToJul
					,SUM(FundCalcAug)														AS FundCalcAug
					,SUM(FundCalcSep)														AS FundCalcSep
					,SUM(FundCalcOct)														AS FundCalcOct
					,SUM(FundCalcNov)														AS FundCalcNov
					,SUM(FundCalcDec)														AS FundCalcDec
					,SUM(FundCalcJan)														AS FundCalcJan
					,SUM(FundCalcFeb)														AS FundCalcFeb
					,SUM(FundCalcMar)														AS FundCalcMar
					,SUM(FundCalcApr)														AS FundCalcApr
					,SUM(FundCalcMay)														AS FundCalcMay
					,SUM(FundCalcJun)														AS FundCalcJun
					,SUM(FundCalcJul)														AS FundCalcJul
			FROM	Report.FundingSummary_1618
	) AS TOTAL

	INSERT INTO [Report].[FundingSummary_1618Traineeships]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	*
	FROM 
	(
			SELECT 'ILR 16-18 Traineeships Programme Funding'					AS SubGroupHeader,1 AS SortOrder,'LineTotals1618Traineeships' AS DataSetName, * FROM dbo.GetEFAFundingForType('16-18 Traineeships (Adult Funded)',			@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Traineeships Audit Adjustments'					AS SubGroupHeader,3 AS SortOrder,'LineTotals1618Traineeships' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: 16-18 Traineeships',				@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Traineeships Authorised Claims'					AS SubGroupHeader,4 AS SortOrder,'LineTotals1618Traineeships' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: 16-18 Traineeships',				@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Traineeships Excess Learning Support'				AS SubGroupHeader,5 AS SortOrder,'LineTotals1618Traineeships' AS DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: 16-18 Traineeships',		@CollectionPeriodInt) UNION
			SELECT 'EAS 16-19 Traineeships Bursary Vulnerable Student Bursary'	AS SubGroupHeader,6 AS SortOrder,'LineTotals1618Traineeships' AS DataSetName, * FROM dbo.GetEASFunding('Vulnerable Bursary: 16-19 Traineeships Bursary',	@CollectionPeriodInt) UNION
			SELECT 'EAS 16-19 Traineeships Bursary Free Meals'					AS SubGroupHeader,7 AS SortOrder,'LineTotals1618Traineeships' AS DataSetName, * FROM dbo.GetEASFunding('Free Meals: 16-19 Traineeships Bursary',			@CollectionPeriodInt) UNION
			SELECT 'EAS 16-19 Traineeships Bursary Discretionary Bursary'		AS SubGroupHeader,8 AS SortOrder,'LineTotals1618Traineeships' AS DataSetName, * FROM dbo.GetEASFunding('Discretionary Bursary: 16-19 Traineeships Bursary', @CollectionPeriodInt)
		) AS A

	INSERT INTO [Report].[FundingSummary_Total1618Traineeships]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT * 
	FROM 
	(
			SELECT	'Total 16-18 Traineeships'		AS SubGroupHeader
					,10								AS SortOrder
					,'LineTotals1618Traineeships'	AS DataSetName
					,SUM(YTDCalc)					AS YTDCalc
					,SUM (TotalCalc)				AS TotalCalc
					,SUM(AugToMar)					AS AugToMar
					,SUM(AprToJul)					AS AprToJul
					,SUM(FundCalcAug)				AS FundCalcAug
					,SUM(FundCalcSep)				AS FundCalcSep
					,SUM(FundCalcOct)				AS FundCalcOct
					,SUM(FundCalcNov)				AS FundCalcNov
					,SUM(FundCalcDec)				AS FundCalcDec
					,SUM(FundCalcJan)				AS FundCalcJan
					,SUM(FundCalcFeb)				AS FundCalcFeb
					,SUM(FundCalcMar)				AS FundCalcMar
					,SUM(FundCalcApr)				AS FundCalcApr
					,SUM(FundCalcMay)				AS FundCalcMay
					,SUM(FundCalcJun)				AS FundCalcJun
					,SUM(FundCalcJul)				AS FundCalcJul
			FROM	Report.FundingSummary_1618Traineeships
	) AS TOTAL

	INSERT INTO [Report].[FundingSummary_1923]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	*
	FROM
	(
			SELECT 'ILR 19-23 Apprenticeship Frameworks Programme Funding'		 AS SubGroupHeader,1 AS SortOrder,'LineTotals1923Apprenticeship' AS DataSetName, * FROM dbo.GetSFAFundingForType('19-23 Apprenticeship',					@CollectionPeriodInt) UNION
			SELECT 'ILR 19-23 Apprenticeship Frameworks Learning Support'		 AS SubGroupHeader,2 AS SortOrder,'LineTotals1923Apprenticeship' AS DataSetName, * FROM dbo.GetLSFFundingForType('19-23 Apprenticeship',					@CollectionPeriodInt) UNION
			SELECT 'EAS 19-23 Apprenticeship Frameworks Audit Adjustments'		 AS SubGroupHeader,4 AS SortOrder,'LineTotals1923Apprenticeship' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: 19-23 Apprenticeships',		@CollectionPeriodInt) UNION
			SELECT 'EAS 19-23 Apprenticeship Frameworks Authorised Claims'		 AS SubGroupHeader,5 AS SortOrder,'LineTotals1923Apprenticeship' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: 19-23 Apprenticeships',		@CollectionPeriodInt) UNION
			SELECT 'EAS 19-23 Apprenticeship Frameworks Excess Learning Support' AS SubGroupHeader,6 AS SortOrder,'LineTotals1923Apprenticeship' AS DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: 19-23 Apprenticeships', @CollectionPeriodInt) UNION
			SELECT 'EAS 19-23 Apprenticeship Frameworks Learner Support'		 AS SubGroupHeader,7 AS SortOrder,'LineTotals1923Apprenticeship' AS DataSetName, * FROM dbo.GetEASFunding('Learner Support: 19-23 Apprenticeships',			@CollectionPeriodInt)
	) AS a

	INSERT INTO [Report].[FundingSummary_Total1923]
	(
			[SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	* 
	FROM 
	(
			SELECT	'Total 19-23 Apprenticeship Frameworks' AS SubGroupHeader
					,9										AS SortOrder
					,'LineTotals1923Apprenticeship'			AS DataSetName
					,SUM(YTDCalc)							AS YTDCalc
					,SUM (TotalCalc)						AS TotalCalc
					,sum(AugToMar)							AS AugToMar
					,sum(AprToJul)							AS AprToJul
					,sum(FundCalcAug)						AS FundCalcAug
					,sum(FundCalcSep)						AS FundCalcSep
					,sum(FundCalcOct)						AS FundCalcOct
					,sum(FundCalcNov)						AS FundCalcNov
					,sum(FundCalcDec)						AS FundCalcDec
					,sum(FundCalcJan)						AS FundCalcJan
					,sum(FundCalcFeb)						AS FundCalcFeb
					,sum(FundCalcMar)						AS FundCalcMar
					,sum(FundCalcApr)						AS FundCalcApr
					,sum(FundCalcMay)						AS FundCalcMay
					,sum(FundCalcJun)						AS FundCalcJun
					,sum(FundCalcJul)						AS FundCalcJul
			FROM	Report.FundingSummary_1923
	) AS TOTAL

	INSERT INTO [Report].[FundingSummary_24Plus]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	 *
	FROM
	(
			SELECT 'ILR 24+ Apprenticeship Frameworks Programme Funding'		AS SubGroupHeader,1 AS SortOrder,'LineTotals24PlusApprenticeship' AS DataSetName, * FROM dbo.GetSFAFundingForType('24+ Apprenticeship',						@CollectionPeriodInt) UNION
			SELECT 'ILR 24+ Apprenticeship Frameworks Learning Support'			AS SubGroupHeader,2 AS SortOrder,'LineTotals24PlusApprenticeship' AS DataSetName, * FROM dbo.GetLSFFundingForType('24+ Apprenticeship',						@CollectionPeriodInt) UNION
			SELECT 'EAS 24+ Apprenticeship Frameworks Audit Adjustments'		AS SubGroupHeader,4 AS SortOrder,'LineTotals24PlusApprenticeship' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: 24+ Apprenticeships',		@CollectionPeriodInt) UNION
			SELECT 'EAS 24+ Apprenticeship Frameworks Authorised Claims'		AS SubGroupHeader,5 AS SortOrder,'LineTotals24PlusApprenticeship' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: 24+ Apprenticeships',		@CollectionPeriodInt) UNION
			SELECT 'EAS 24+ Apprenticeship Frameworks Excess Learning Support'	AS SubGroupHeader,6 AS SortOrder,'LineTotals24PlusApprenticeship' AS DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: 24+ Apprenticeships',	@CollectionPeriodInt) UNION
			SELECT 'EAS 24+ Apprenticeship Frameworks Learner Support'			AS SubGroupHeader,7 AS SortOrder,'LineTotals24PlusApprenticeship' AS DataSetName, * FROM dbo.GetEASFunding('Learner Support: 24+ Apprenticeships',			@CollectionPeriodInt)
	) AS a

	INSERT INTO [Report].[FundingSummary_Total24Plus]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	* 
	FROM 
	(
			SELECT	'Total 24+ Apprenticeship Frameworks'	AS SubGroupHeader
					,9										AS SortOrder
					,'LineTotals24PlusApprenticeship'		AS DataSetName
					,SUM(YTDCalc)							AS YTDCalc
					,SUM (TotalCalc)						AS TotalCalc
					,SUM(AugToMar)							AS AugToMar
					,SUM(AprToJul)							AS AprToJul
					,SUM(FundCalcAug)						AS FundCalcAug
					,SUM(FundCalcSep)						AS FundCalcSep
					,SUM(FundCalcOct)						AS FundCalcOct
					,SUM(FundCalcNov)						AS FundCalcNov
					,SUM(FundCalcDec)						AS FundCalcDec
					,SUM(FundCalcJan)						AS FundCalcJan
					,SUM(FundCalcFeb)						AS FundCalcFeb
					,SUM(FundCalcMar)						AS FundCalcMar
					,SUM(FundCalcApr)						AS FundCalcApr
					,SUM(FundCalcMay)						AS FundCalcMay
					,SUM(FundCalcJun)						AS FundCalcJun
					,SUM(FundCalcJul)						AS FundCalcJul
			FROM		Report.FundingSummary_24Plus
	) AS TOTAL

	INSERT INTO [Report].[FundingSummary_1924Traineeships]
   (
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	*
	FROM
	(
			SELECT 'ILR 19-24 Traineeships Programme Funding'				AS SubGroupHeader,1 AS SortOrder,'LineTotals1924Traineeships' AS DataSetName, * FROM dbo.GetSFAFundingForType('19-24 Traineeship (non-procured),19-24 Traineeship', @CollectionPeriodInt) UNION
			SELECT 'ILR 19-24 Traineeships (16-19 Model) Programme Funding'	AS SubGroupHeader,2 AS SortOrder,'LineTotals1924Traineeships' AS DataSetName, * FROM dbo.GetEFAFundingForType('19+ Traineeships (Adult Funded)',					@CollectionPeriodInt) UNION
			SELECT 'ILR 19-24 Traineeships Learning Support'				AS SubGroupHeader,3	AS SortOrder,'LineTotals1924Traineeships' AS DataSetName, * FROM dbo.GetLSFFundingForType('19-24 Traineeship (non-procured),19-24 Traineeship', @CollectionPeriodInt) UNION
			SELECT 'EAS 19-24 Traineeships Audit Adjustments'				AS SubGroupHeader,5 AS SortOrder,'LineTotals1924Traineeships' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: 19-24 Traineeships',						@CollectionPeriodInt) UNION
			SELECT 'EAS 19-24 Traineeships Authorised Claims'				AS SubGroupHeader,6 AS SortOrder,'LineTotals1924Traineeships' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: 19-24 Traineeships',						@CollectionPeriodInt) UNION
			SELECT 'EAS 19-24 Traineeships Excess Learning Support'			AS SubGroupHeader,7 AS SortOrder,'LineTotals1924Traineeships' AS DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: 19-24 Traineeships',				@CollectionPeriodInt)UNION
			SELECT 'EAS 19-24 Traineeships Learner Support'					AS SubGroupHeader,8 AS SortOrder,'LineTotals1924Traineeships' AS DataSetName, * FROM dbo.GetEASFunding('Learner Support: 19-24 Traineeships',						@CollectionPeriodInt) 
	) AS a

	INSERT INTO [Report].[FundingSummary_Total1924Traineeships]
   (
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	* 
	FROM 
	(
			SELECT  'Total 19-24 Traineeships'		AS SubGroupHeader
					,10								AS SortOrder
					,'LineTotals1924Traineeships'	AS DataSetName
					,SUM(YTDCalc)					AS YTDCalc
					, SUM (TotalCalc)				AS TotalCalc
					,sum(AugToMar)					AS AugToMar
					,sum(AprToJul)					AS AprToJul
					,sum(FundCalcAug)				AS FundCalcAug
					,sum(FundCalcSep)				AS FundCalcSep
					,sum(FundCalcOct)				AS FundCalcOct
					,sum(FundCalcNov)				AS FundCalcNov
					,sum(FundCalcDec)				AS FundCalcDec
					,sum(FundCalcJan)				AS FundCalcJan
					,sum(FundCalcFeb)				AS FundCalcFeb
					,sum(FundCalcMar)				AS FundCalcMar
					,sum(FundCalcApr)				AS FundCalcApr
					,sum(FundCalcMay)				AS FundCalcMay
					,sum(FundCalcJun)				AS FundCalcJun
					,sum(FundCalcJul)				AS FundCalcJul
			FROM	Report.FundingSummary_1924Traineeships 
			WHERE	DataSetName = 'LineTotals1924Traineeships'
	) AS TOTAL

   /******** Adult Education Budget – Non-procured delivery */

   	INSERT INTO [Report].[FundingSummary_1924Traineeships]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	*
	FROM
	(
			SELECT 'ILR 19-24 Traineeships Programme Funding'		AS SubGroupHeader,1 AS SortOrder,'LineTotals1924TraineeshipsFrmNov2017' AS DataSetName, * FROM dbo.GetSFAFundingForType('19-24 Traineeship (procured from Nov 2017)',			@CollectionPeriodInt) UNION			
			SELECT 'ILR 19-24 Traineeships Learning Support'		AS SubGroupHeader,2 AS SortOrder,'LineTotals1924TraineeshipsFrmNov2017' AS DataSetName, * FROM dbo.GetLSFFundingForType('19-24 Traineeship (procured from Nov 2017)',			@CollectionPeriodInt) UNION
			SELECT 'EAS 19-24 Traineeships Audit Adjustments'		AS SubGroupHeader,4 AS SortOrder,'LineTotals1924TraineeshipsFrmNov2017' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: 19-24 Traineeships (From Nov 2017)',		@CollectionPeriodInt) UNION
			SELECT 'EAS 19-24 Traineeships Authorised Claims'		AS SubGroupHeader,5 AS SortOrder,'LineTotals1924TraineeshipsFrmNov2017' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: 19-24 Traineeships (From Nov 2017)',		@CollectionPeriodInt) UNION
			SELECT 'EAS 19-24 Traineeships Excess Learning Support' AS SubGroupHeader,6 AS SortOrder,'LineTotals1924TraineeshipsFrmNov2017' AS DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: 19-24 Traineeships (From Nov 2017)', @CollectionPeriodInt) UNION
			SELECT 'EAS 19-24 Traineeships Learner Support'			AS SubGroupHeader,7 AS SortOrder,'LineTotals1924TraineeshipsFrmNov2017' AS DataSetName, * FROM dbo.GetEASFunding('Learner Support: 19-24 Traineeships (From Nov 2017)',			@CollectionPeriodInt) 
	) AS a

	INSERT INTO [Report].[FundingSummary_Total1924Traineeships]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	* 
	FROM 
	(
			SELECT	'Total 19-24 Traineeships'				AS SubGroupHeader
					,9										AS SortOrder
					,'LineTotals1924TraineeshipsFrmNov2017' AS DataSetName
					,SUM(YTDCalc)							AS YTDCalc
					,SUM (TotalCalc)						AS TotalCalc
					,SUM(AugToMar)							AS AugToMar
					,SUM(AprToJul)							AS AprToJul
					,SUM(FundCalcAug)						AS FundCalcAug
					,SUM(FundCalcSep)						AS FundCalcSep
					,SUM(FundCalcOct)						AS FundCalcOct
					,SUM(FundCalcNov)						AS FundCalcNov
					,SUM(FundCalcDec)						AS FundCalcDec
					,SUM(FundCalcJan)						AS FundCalcJan
					,SUM(FundCalcFeb)						AS FundCalcFeb
					,SUM(FundCalcMar)						AS FundCalcMar
					,SUM(FundCalcApr)						AS FundCalcApr
					,SUM(FundCalcMay)						AS FundCalcMay
					,SUM(FundCalcJun)						AS FundCalcJun
					,SUM(FundCalcJul)						AS FundCalcJul
			FROM	Report.FundingSummary_1924Traineeships 
			WHERE	DataSetName = 'LineTotals1924TraineeshipsFrmNov2017'
	) AS TOTAL

	/********************************************************************************************************************************************************************/
			--Levy Contracted Apprenticeships Budget for starts on or after 1 May 2017
	/********************************************************************************************************************************************************************/
	
	--16-18 Levy Contracted Apprenticeships
	INSERT INTO [Report].[FundingSummary_1618LevyContractedApprenticeships]
	(
			 SubGroupHeader
			,SortOrder
			,DataSetName
			,YTDCalc
			,TotalCalc
			,AugToMar
			,AprToJul
			,FundCalcAug
			,FundCalcSep
			,FundCalcOct
			,FundCalcNov
			,FundCalcDec
			,FundCalcJan
			,FundCalcFeb
			,FundCalcMar
			,FundCalcApr
			,FundCalcMay
			,FundCalcJun
			,FundCalcJul
	)
	SELECT	* 
	FROM 
	(
			SELECT 'ILR 16-18 Levy Contracted Apprenticeships Programme Aim Indicative Earnings'					AS SubGroupHeader,1  AS SortOrder,'LineTotals1618LevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship (From May 2017) Levy Contract',	@CollectionPeriodInt,'ProgrammeAimOnProgPayment,ProgrammeAimBalPayment,ProgrammeAimCompletionPayment') UNION
			SELECT 'ILR 16-18 Levy Contracted Apprenticeships Maths and English Programme Funding'					AS SubGroupHeader,2  AS SortOrder,'LineTotals1618LevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship (From May 2017) Levy Contract',	@CollectionPeriodInt,'MathEngOnProgPayment,MathEngBalPayment') UNION
			SELECT 'ILR 16-18 Levy Contracted Apprenticeships Framework Uplift'										AS SubGroupHeader,3  AS SortOrder,'LineTotals1618LevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship (From May 2017) Levy Contract',	@CollectionPeriodInt,'LDApplic1618FrameworkUpliftBalancingPayment,LDApplic1618FrameworkUpliftCompletionPayment,LDApplic1618FrameworkUpliftOnProgPayment') UNION
			SELECT 'ILR 16-18 Levy Contracted Apprenticeships Disadvantage Payments'								AS SubGroupHeader,4  AS SortOrder,'LineTotals1618LevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship (From May 2017) Levy Contract',	@CollectionPeriodInt,'DisadvFirstPayment,DisadvSecondPayment') UNION
			SELECT 'ILR 16-18 Levy Contracted Apprenticeships Additional Payments for Providers'					AS SubGroupHeader,5  AS SortOrder,'LineTotals1618LevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship (From May 2017) Levy Contract',	@CollectionPeriodInt,'LearnDelFirstProv1618Pay,LearnDelSecondProv1618Pay') UNION
			SELECT 'ILR 16-18 Levy Contracted Apprenticeships Additional Payments for Employers'					AS SubGroupHeader,6  AS SortOrder,'LineTotals1618LevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship (From May 2017) Levy Contract',	@CollectionPeriodInt,'LearnDelFirstEmp1618Pay,LearnDelSecondEmp1618Pay') UNION
			SELECT 'ILR 16-18 Levy Contracted Apprenticeships Learning Support'										AS SubGroupHeader,7  AS SortOrder,'LineTotals1618LevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship (From May 2017) Levy Contract',	@CollectionPeriodInt,'LearnSuppFundCash') UNION
			SELECT 'EAS 16-18 Levy Contracted Apprenticeships Training Audit Adjustments'							AS SubGroupHeader,9  AS SortOrder,'LineTotals1618LevyContractedApprenticeships' as DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: 16-18 Levy Apprenticeships - Training',		@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Levy Contracted Apprenticeships Training Authorised Claims'							AS SubGroupHeader,10 AS SortOrder,'LineTotals1618LevyContractedApprenticeships' as DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: 16-18 Levy Apprenticeships - Training',		@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Levy Contracted Apprenticeships Additional Payments for Providers Audit Adjustments'	AS SubGroupHeader,11 AS SortOrder,'LineTotals1618LevyContractedApprenticeships' as DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: 16-18 Levy Apprenticeships - Provider',		@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Levy Contracted Apprenticeships Additional Payments for Providers Authorised Claims ' AS SubGroupHeader,12 AS SortOrder,'LineTotals1618LevyContractedApprenticeships' as DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: 16-18 Levy Apprenticeships - Provider',		@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Levy Contracted Apprenticeships Additional Payments for Providers Excess Learning Support'	AS SubGroupHeader,13 AS SortOrder,'LineTotals1618LevyContractedApprenticeships' as DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: 16-18 Levy Apprenticeships - Provider',	@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Levy Contracted Apprenticeships Additional Payments for Employers Audit Adjustments ' AS SubGroupHeader,14 AS SortOrder,'LineTotals1618LevyContractedApprenticeships' as DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: 16-18 Levy Apprenticeships - Employer',		@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Levy Contracted Apprenticeships Additional Payments for Employers Authorised Claims'	AS SubGroupHeader,15 AS SortOrder,'LineTotals1618LevyContractedApprenticeships' as DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: 16-18 Levy Apprenticeships - Employer',		@CollectionPeriodInt)
	) AS [1618LevyContractedApprenticeships]

	--16-18 Levy Contracted Apprenticeships Totals
	INSERT INTO [Report].[FundingSummary_Total1618LevyContractedApprenticeships]
	(
			 SubGroupHeader
			,SortOrder
			,DataSetName
			,YTDCalc
			,TotalCalc
			,AugToMar
			,AprToJul
			,FundCalcAug
			,FundCalcSep
			,FundCalcOct
			,FundCalcNov
			,FundCalcDec
			,FundCalcJan
			,FundCalcFeb
			,FundCalcMar
			,FundCalcApr
			,FundCalcMay
			,FundCalcJun
			,FundCalcJul
	)
	SELECT	* 
	FROM 
	(
			SELECT	'Total 16-18 Levy Contracted Apprenticeships'	AS SubGroupHeader
					,17												AS SortOrder
					,'LineTotals1618LevyContractedApprenticeships'	AS DataSetName
					,SUM(YTDCalc)									AS YTDCalc
					, SUM (TotalCalc)								AS TotalCalc
					,sum(AugToMar)									AS AugToMar
					,sum(AprToJul)									AS AprToJul
					,sum(FundCalcAug)								AS FundCalcAug
					,sum(FundCalcSep)								AS FundCalcSep
					,sum(FundCalcOct)								AS FundCalcOct
					,sum(FundCalcNov)								AS FundCalcNov
					,sum(FundCalcDec)								AS FundCalcDec
					,sum(FundCalcJan)								AS FundCalcJan
					,sum(FundCalcFeb)								AS FundCalcFeb
					,sum(FundCalcMar)								AS FundCalcMar
					,sum(FundCalcApr)								AS FundCalcApr
					,sum(FundCalcMay)								AS FundCalcMay
					,sum(FundCalcJun)								AS FundCalcJun
					,sum(FundCalcJul)								AS FundCalcJul
			FROM	[Report].[FundingSummary_1618LevyContractedApprenticeships]
	) AS TOTAL     
	

	--Adult Levy Contracted Apprenticeships
	INSERT INTO [Report].[FundingSummary_AdultLevyContractedApprenticeships]
	(
			 SubGroupHeader
			,SortOrder
			,DataSetName
			,YTDCalc
			,TotalCalc
			,AugToMar
			,AprToJul
			,FundCalcAug
			,FundCalcSep
			,FundCalcOct
			,FundCalcNov
			,FundCalcDec
			,FundCalcJan
			,FundCalcFeb
			,FundCalcMar
			,FundCalcApr
			,FundCalcMay
			,FundCalcJun
			,FundCalcJul
	)
	SELECT	* 
	FROM 
	(
			SELECT 'ILR Adult Levy Contracted Apprenticeships Programme Aim Indicative Earnings'					AS SubGroupHeader,1  AS SortOrder,'LineTotalsAdultLevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship (From May 2017) Levy Contract',	@CollectionPeriodInt,'ProgrammeAimOnProgPayment,ProgrammeAimBalPayment,ProgrammeAimCompletionPayment') UNION
			SELECT 'ILR Adult Levy Contracted Apprenticeships Maths and English Programme Funding'					AS SubGroupHeader,2  AS SortOrder,'LineTotalsAdultLevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship (From May 2017) Levy Contract',	@CollectionPeriodInt,'MathEngOnProgPayment,MathEngBalPayment') UNION
			SELECT 'ILR Adult Levy Contracted Apprenticeships Framework Uplift'										AS SubGroupHeader,3  AS SortOrder,'LineTotalsAdultLevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship (From May 2017) Levy Contract',	@CollectionPeriodInt,'LDApplic1618FrameworkUpliftBalancingPayment,LDApplic1618FrameworkUpliftCompletionPayment,LDApplic1618FrameworkUpliftOnProgPayment') UNION
			SELECT 'ILR Adult Levy Contracted Apprenticeships Disadvantage Payments'								AS SubGroupHeader,4  AS SortOrder,'LineTotalsAdultLevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship (From May 2017) Levy Contract',	@CollectionPeriodInt,'DisadvFirstPayment,DisadvSecondPayment') UNION
			SELECT 'ILR Adult Levy Contracted Apprenticeships Additional Payments for Providers'					AS SubGroupHeader,5  AS SortOrder,'LineTotalsAdultLevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship (From May 2017) Levy Contract',	@CollectionPeriodInt,'LearnDelFirstProv1618Pay,LearnDelSecondProv1618Pay') UNION
			SELECT 'ILR Adult Levy Contracted Apprenticeships Additional Payments for Employers'					AS SubGroupHeader,6  AS SortOrder,'LineTotalsAdultLevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship (From May 2017) Levy Contract',	@CollectionPeriodInt,'LearnDelFirstEmp1618Pay,LearnDelSecondEmp1618Pay') UNION
			SELECT 'ILR Adult Levy Contracted Apprenticeships Learning Support'										AS SubGroupHeader,7  AS SortOrder,'LineTotalsAdultLevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship (From May 2017) Levy Contract',	@CollectionPeriodInt,'LearnSuppFundCash') UNION	
			SELECT 'EAS Adult Levy Contracted Apprenticeships Training Audit Adjustments'							AS SubGroupHeader,9  AS SortOrder,'LineTotalsAdultLevyContractedApprenticeships' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: Adult Levy Apprenticeships - Training',		@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Levy Contracted Apprenticeships Training Authorised Claims'							AS SubGroupHeader,10 AS SortOrder,'LineTotalsAdultLevyContractedApprenticeships' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: Adult Levy Apprenticeships - Training',		@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Levy Contracted Apprenticeships Additional Payments for Providers Audit Adjustments'	AS SubGroupHeader,11 AS SortOrder,'LineTotalsAdultLevyContractedApprenticeships' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: Adult Levy Apprenticeships - Provider',		@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Levy Contracted Apprenticeships Additional Payments for Providers Authorised Claims ' AS SubGroupHeader,12 AS SortOrder,'LineTotalsAdultLevyContractedApprenticeships' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: Adult Levy Apprenticeships - Provider',		@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Levy Contracted Apprenticeships Additional Payments for Providers Excess Learning Support'	AS SubGroupHeader,13 AS SortOrder,'LineTotalsAdultLevyContractedApprenticeships' AS DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: Adult Levy Apprenticeships - Provider', @CollectionPeriodInt) UNION
			SELECT 'EAS Adult Levy Contracted Apprenticeships Additional Payments for Employers Audit Adjustments ' AS SubGroupHeader,14 AS SortOrder,'LineTotalsAdultLevyContractedApprenticeships' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: Adult Levy Apprenticeships - Employer',		@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Levy Contracted Apprenticeships Additional Payments for Employers Authorised Claims'	AS SubGroupHeader,15 AS SortOrder,'LineTotalsAdultLevyContractedApprenticeships' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: Adult Levy Apprenticeships - Employer',		@CollectionPeriodInt)
	) AS [AdultLevyContractedApprenticeships]

	--Adult Levy Contracted Apprenticeships Totals
	INSERT INTO [Report].[FundingSummary_TotalAdultLevyContractedApprenticeships]
	(
			 SubGroupHeader
			,SortOrder
			,DataSetName
			,YTDCalc
			,TotalCalc
			,AugToMar
			,AprToJul
			,FundCalcAug
			,FundCalcSep
			,FundCalcOct
			,FundCalcNov
			,FundCalcDec
			,FundCalcJan
			,FundCalcFeb
			,FundCalcMar
			,FundCalcApr
			,FundCalcMay
			,FundCalcJun
			,FundCalcJul
	)
	SELECT	* 
	FROM 
	(
			SELECT	'Total Adult Levy Contracted Apprenticeships'	AS SubGroupHeader
					,17												AS SortOrder
					,'LineTotalsAdultLevyContractedApprenticeships' AS DataSetName
					,SUM(YTDCalc)									AS YTDCalc
					,SUM(TotalCalc)									AS TotalCalc
					,SUM(AugToMar)									AS AugToMar
					,SUM(AprToJul)									AS AprToJul
					,SUM(FundCalcAug)								AS FundCalcAug
					,SUM(FundCalcSep)								AS FundCalcSep
					,SUM(FundCalcOct)								AS FundCalcOct
					,SUM(FundCalcNov)								AS FundCalcNov
					,SUM(FundCalcDec)								AS FundCalcDec
					,SUM(FundCalcJan)								AS FundCalcJan
					,SUM(FundCalcFeb)								AS FundCalcFeb
					,SUM(FundCalcMar)								AS FundCalcMar
					,SUM(FundCalcApr)								AS FundCalcApr
					,SUM(FundCalcMay)								AS FundCalcMay
					,SUM(FundCalcJun)								AS FundCalcJun
					,SUM(FundCalcJul)								AS FundCalcJul
			FROM	[Report].[FundingSummary_AdultLevyContractedApprenticeships]
	) AS TOTAL     

	--Total Levy Budget
	INSERT INTO [Report].[FundingSummary_TotalLevyBudget]
    (
			 SubGroupHeader
			,SortOrder
			,DataSetName
			,YTDCalc
			,TotalCalc
			,AugToMar
			,AprToJul
			,FundCalcAug
			,FundCalcSep
			,FundCalcOct
			,FundCalcNov
			,FundCalcDec
			,FundCalcJan
			,FundCalcFeb
			,FundCalcMar
			,FundCalcApr
			,FundCalcMay
			,FundCalcJun
			,FundCalcJul
	)
	SELECT	'Total Levy Contracted Apprenticeships Budget for starts on or after 1 May 2017'	AS SubGroupHeader
			,1																					AS SortOrder
			,'LineTotalsLevyBudget'																AS DataSetName
			,SUM(YTDCalc)																		AS YTDCalc
			,SUM (TotalCalc)																	AS TotalCalc
			,SUM(AugToMar)																		AS AugToMar
			,SUM(AprToJul)																		AS AprToJul
			,SUM(FundCalcAug)																	AS FundCalcAug
			,SUM(FundCalcSep)																	AS FundCalcSep
			,SUM(FundCalcOct)																	AS FundCalcOct
			,SUM(FundCalcNov)																	AS FundCalcNov
			,SUM(FundCalcDec)																	AS FundCalcDec
			,SUM(FundCalcJan)																	AS FundCalcJan
			,SUM(FundCalcFeb)																	AS FundCalcFeb
			,SUM(FundCalcMar)																	AS FundCalcMar
			,SUM(FundCalcApr)																	AS FundCalcApr
			,SUM(FundCalcMay)																	AS FundCalcMay
			,SUM(FundCalcJun)																	AS FundCalcJun
			,SUM(FundCalcJul)																	AS FundCalcJul 
	FROM 
	(
			SELECT	 FundCalcAug
					,FundCalcSep
					,FundCalcOct
					,FundCalcNov
					,FundCalcDec
					,FundCalcJan
					,FundCalcFeb
					,FundCalcMar
					,FundCalcApr
					,FundCalcMay
					,FundCalcJun
					,FundCalcJul
					,YTDCalc
					,TotalCalc
					,AugToMar
					,AprToJul 
			FROM	Report.FundingSummary_Total1618LevyContractedApprenticeships 

			UNION

			SELECT	 FundCalcAug
					,FundCalcSep
					,FundCalcOct
					,FundCalcNov
					,FundCalcDec
					,FundCalcJan
					,FundCalcFeb
					,FundCalcMar
					,FundCalcApr
					,FundCalcMay
					,FundCalcJun
					,FundCalcJul
					,YTDCalc
					,TotalCalc
					,AugToMar
					,AprToJul 
			FROM	Report.FundingSummary_TotalAdultLevyContractedApprenticeships
	) AS a	
	


	/********************************************************************************************************************************************************************/
			--Non-Levy Contracted Apprenticeships Budget for starts on or after 1 May 2017
	/********************************************************************************************************************************************************************/
	
	--16-18 Non-Levy Contracted Apprenticeships
	INSERT INTO [Report].[FundingSummary_1618NonLevyContractedApprenticeships]
	(
			 SubGroupHeader
			,SortOrder
			,DataSetName
			,YTDCalc
			,TotalCalc
			,AugToMar
			,AprToJul
			,FundCalcAug
			,FundCalcSep
			,FundCalcOct
			,FundCalcNov
			,FundCalcDec
			,FundCalcJan
			,FundCalcFeb
			,FundCalcMar
			,FundCalcApr
			,FundCalcMay
			,FundCalcJun
			,FundCalcJul
	)
	SELECT	* 
	FROM 
	(
			SELECT 'ILR 16-18 Non-Levy Contracted Apprenticeships Programme Aim Indicative Earnings'					AS SubGroupHeader,1  AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeships' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship (From May 2017) Non-Levy Contract (non-procured),16-18 Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'ProgrammeAimOnProgPayment,ProgrammeAimBalPayment,ProgrammeAimCompletionPayment') UNION
			SELECT '...of which Indicative Government Co-Investment Earnings'											AS SubGroupHeader,2  AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeships' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship (From May 2017) Non-Levy Contract (non-procured),16-18 Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'ProgrammeAimProgFundIndMinCoInvest') UNION
			SELECT 'ILR 16-18 Non-Levy Contracted Apprenticeships Maths and English Programme Funding'					AS SubGroupHeader,3  AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeships' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship (From May 2017) Non-Levy Contract (non-procured),16-18 Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'MathEngOnProgPayment,MathEngBalPayment') UNION
			SELECT 'ILR 16-18 Non-Levy Contracted Apprenticeships Framework Uplift'										AS SubGroupHeader,4	 AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeships' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship (From May 2017) Non-Levy Contract (non-procured),16-18 Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'LDApplic1618FrameworkUpliftBalancingPayment,LDApplic1618FrameworkUpliftCompletionPayment,LDApplic1618FrameworkUpliftOnProgPayment') UNION
			SELECT 'ILR 16-18 Non-Levy Contracted Apprenticeships Disadvantage Payments'								AS SubGroupHeader,5  AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeships' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship (From May 2017) Non-Levy Contract (non-procured),16-18 Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'DisadvFirstPayment,DisadvSecondPayment') UNION
			SELECT 'ILR 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Providers'					AS SubGroupHeader,6  AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeships' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship (From May 2017) Non-Levy Contract (non-procured),16-18 Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'LearnDelFirstProv1618Pay,LearnDelSecondProv1618Pay') UNION
			SELECT 'ILR 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Employers'					AS SubGroupHeader,7  AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeships' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship (From May 2017) Non-Levy Contract (non-procured),16-18 Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'LearnDelFirstEmp1618Pay,LearnDelSecondEmp1618Pay') UNION
			SELECT 'ILR 16-18 Non-Levy Contracted Apprenticeships Learning Support'										AS SubGroupHeader,8  AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeships' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship (From May 2017) Non-Levy Contract (non-procured),16-18 Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'LearnSuppFundCash')		UNION	
			SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships Training Audit Adjustments'							AS SubGroupHeader,10 AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeships' AS DataSetName, * FROM [dbo].[GetEASFunding] ('Audit Adjustments: 16-18 Non-Levy Apprenticeships - Training',		@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships Training Authorised Claims'							AS SubGroupHeader,11 AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeships' AS DataSetName, * FROM [dbo].[GetEASFunding] ('Authorised Claims: 16-18 Non-Levy Apprenticeships - Training',		@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Providers Audit Adjustments'	AS SubGroupHeader,12 AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeships' AS DataSetName, * FROM [dbo].[GetEASFunding] ('Audit Adjustments: 16-18 Non-Levy Apprenticeships - Provider',		@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Providers Authorised Claims '	AS SubGroupHeader,13 AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeships' AS DataSetName, * FROM [dbo].[GetEASFunding] ('Authorised Claims: 16-18 Non-Levy Apprenticeships - Provider',		@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Providers Excess Learning Support'	AS SubGroupHeader,14 AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeships' AS DataSetName, * FROM [dbo].[GetEASFunding] ('Excess Learning Support: 16-18 Non-Levy Apprenticeships - Provider',	@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Employers Audit Adjustments ' AS SubGroupHeader,15 AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeships' AS DataSetName, * FROM [dbo].[GetEASFunding] ('Audit Adjustments: 16-18 Non-Levy Apprenticeships - Employer',		@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Employers Authorised Claims'	AS SubGroupHeader,16 AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeships' AS DataSetName, * FROM [dbo].[GetEASFunding] ('Authorised Claims: 16-18 Non-Levy Apprenticeships - Employer',		@CollectionPeriodInt)
	) AS [1618NonLevyContractedApprenticeships]

	--16-18 Non-Levy Contracted Apprenticeships Totals
	INSERT INTO [Report].[FundingSummary_Total1618NonLevyContractedApprenticeships]
    (
			 SubGroupHeader
			,SortOrder
			,DataSetName
			,YTDCalc
			,TotalCalc
			,AugToMar
			,AprToJul
			,FundCalcAug
			,FundCalcSep
			,FundCalcOct
			,FundCalcNov
			,FundCalcDec
			,FundCalcJan
			,FundCalcFeb
			,FundCalcMar
			,FundCalcApr
			,FundCalcMay
			,FundCalcJun
			,FundCalcJul
	)
	SELECT * 
	FROM 
	(
			SELECT	'Total 16-18 Non-Levy Contracted Apprenticeships'	AS SubGroupHeader
					,18													AS SortOrder
					,'LineTotals1618NonLevyContractedApprenticeships'	AS DataSetName
					,SUM(YTDCalc)										AS YTDCalc
					,SUM (TotalCalc)									AS TotalCalc
					,sum(AugToMar)										AS AugToMar
					,sum(AprToJul)										AS AprToJul
					,sum(FundCalcAug)									AS FundCalcAug
					,sum(FundCalcSep)									AS FundCalcSep
					,sum(FundCalcOct)									AS FundCalcOct
					,sum(FundCalcNov)									AS FundCalcNov
					,sum(FundCalcDec)									AS FundCalcDec
					,sum(FundCalcJan)									AS FundCalcJan
					,sum(FundCalcFeb)									AS FundCalcFeb
					,sum(FundCalcMar)									AS FundCalcMar
					,sum(FundCalcApr)									AS FundCalcApr
					,sum(FundCalcMay)									AS FundCalcMay
					,sum(FundCalcJun)									AS FundCalcJun
					,sum(FundCalcJul)									AS FundCalcJul
			FROM	[Report].[FundingSummary_1618NonLevyContractedApprenticeships] 
			WHERE	SubGroupHeader 
			NOT IN	('ILR 16-18 Non-Levy Contracted Apprenticeships Programme Aim Indicative Earnings') 
			AND		DataSetName = 'LineTotals1618NonLevyContractedApprenticeships'
	) AS TOTAL 	

	--16-18 Non-Levy Contracted Apprenticeships From jan 2018
	INSERT INTO [Report].[FundingSummary_1618NonLevyContractedApprenticeships]
	(
			 SubGroupHeader
			,SortOrder
			,DataSetName
			,YTDCalc
			,TotalCalc
			,AugToMar
			,AprToJul
			,FundCalcAug
			,FundCalcSep
			,FundCalcOct
			,FundCalcNov
			,FundCalcDec
			,FundCalcJan
			,FundCalcFeb
			,FundCalcMar
			,FundCalcApr
			,FundCalcMay
			,FundCalcJun
			,FundCalcJul
	)
	SELECT	* 
	FROM 
	(
		SELECT 'ILR 16-18 Non-Levy Contracted Apprenticeships Programme Aim Indicative Earnings'					AS SubGroupHeader,1  AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship Non-Levy Contract (procured)',				 @CollectionPeriodInt,'ProgrammeAimOnProgPayment,ProgrammeAimBalPayment,ProgrammeAimCompletionPayment') UNION
		SELECT '...of which Indicative Government Co-Investment Earnings'											AS SubGroupHeader,2  AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship Non-Levy Contract (procured)',				 @CollectionPeriodInt,'ProgrammeAimProgFundIndMinCoInvest') UNION
		SELECT 'ILR 16-18 Non-Levy Contracted Apprenticeships Maths and English Programme Funding'					AS SubGroupHeader,3  AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship Non-Levy Contract (procured)',				 @CollectionPeriodInt,'MathEngOnProgPayment,MathEngBalPayment') UNION
		SELECT 'ILR 16-18 Non-Levy Contracted Apprenticeships Framework Uplift'										AS SubGroupHeader,4  AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship Non-Levy Contract (procured)',				 @CollectionPeriodInt,'LDApplic1618FrameworkUpliftBalancingPayment,LDApplic1618FrameworkUpliftCompletionPayment,LDApplic1618FrameworkUpliftOnProgPayment') UNION
		SELECT 'ILR 16-18 Non-Levy Contracted Apprenticeships Disadvantage Payments'								AS SubGroupHeader,5  AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship Non-Levy Contract (procured)',				 @CollectionPeriodInt,'DisadvFirstPayment,DisadvSecondPayment') UNION
		SELECT 'ILR 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Providers'					AS SubGroupHeader,6  AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship Non-Levy Contract (procured)',				 @CollectionPeriodInt,'LearnDelFirstProv1618Pay,LearnDelSecondProv1618Pay') UNION
		SELECT 'ILR 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Employers'					AS SubGroupHeader,7  AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship Non-Levy Contract (procured)',				 @CollectionPeriodInt,'LearnDelFirstEmp1618Pay,LearnDelSecondEmp1618Pay') UNION
		SELECT 'ILR 16-18 Non-Levy Contracted Apprenticeships Learning Support'										AS SubGroupHeader,8  AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('16-18 Apprenticeship Non-Levy Contract (procured)',				 @CollectionPeriodInt,'LearnSuppFundCash') UNION	
		SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships Training Audit Adjustments'							AS SubGroupHeader,10 AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: 16-18 Non-Levy Apprenticeships (procured) - Training',		 @CollectionPeriodInt) UNION
		SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships Training Authorised Claims'							AS SubGroupHeader,11 AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: 16-18 Non-Levy Apprenticeships (procured) - Training',		 @CollectionPeriodInt) UNION
		SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Providers Audit Adjustments'	AS SubGroupHeader,12 AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: 16-18 Non-Levy Apprenticeships (procured) - Provider',		 @CollectionPeriodInt) UNION
		SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Providers Authorised Claims ' AS SubGroupHeader,13 AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: 16-18 Non-Levy Apprenticeships (procured) - Provider',		 @CollectionPeriodInt) UNION
		SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Providers Excess Learning Support'	AS SubGroupHeader,14 AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: 16-18 Non-Levy Apprenticeships (procured) - Provider', @CollectionPeriodInt) UNION
		SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Employers Audit Adjustments ' AS SubGroupHeader,15 AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: 16-18 Non-Levy Apprenticeships (procured) - Employer',		 @CollectionPeriodInt) UNION
		SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Employers Authorised Claims'	AS SubGroupHeader,16 AS SortOrder, 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: 16-18 Non-Levy Apprenticeships (procured) - Employer',		 @CollectionPeriodInt)
	) AS [1618NonLevyContractedApprenticeships_1]

	--16-18 Non-Levy Contracted Apprenticeships Totals From jan 2008
	INSERT INTO [Report].[FundingSummary_Total1618NonLevyContractedApprenticeships]
    (
			 SubGroupHeader
			,SortOrder
			,DataSetName
			,YTDCalc
			,TotalCalc
			,AugToMar
			,AprToJul
			,FundCalcAug
			,FundCalcSep
			,FundCalcOct
			,FundCalcNov
			,FundCalcDec
			,FundCalcJan
			,FundCalcFeb
			,FundCalcMar
			,FundCalcApr
			,FundCalcMay
			,FundCalcJun
			,FundCalcJul
	)
	SELECT	* 
	FROM 
	(
			SELECT	'Total 16-18 Non-Levy Contracted Apprenticeships'			AS SubGroupHeader
					,18															AS SortOrder
					,'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName
					,SUM(YTDCalc)												AS YTDCalc
					,SUM (TotalCalc)											AS TotalCalc
					,SUM(AugToMar)												AS AugToMar
					,SUM(AprToJul)												AS AprToJul
					,SUM(FundCalcAug)											AS FundCalcAug
					,SUM(FundCalcSep)											AS FundCalcSep
					,SUM(FundCalcOct)											AS FundCalcOct
					,SUM(FundCalcNov)											AS FundCalcNov
					,SUM(FundCalcDec)											AS FundCalcDec
					,SUM(FundCalcJan)											AS FundCalcJan
					,SUM(FundCalcFeb)											AS FundCalcFeb
					,SUM(FundCalcMar)											AS FundCalcMar
					,SUM(FundCalcApr)											AS FundCalcApr
					,SUM(FundCalcMay)											AS FundCalcMay
					,SUM(FundCalcJun)											AS FundCalcJun
					,SUM(FundCalcJul)											AS FundCalcJul
			FROM	[Report].[FundingSummary_1618NonLevyContractedApprenticeships] 
			Where	SubGroupHeader 
			NOT IN	('ILR 16-18 Non-Levy Contracted Apprenticeships Programme Aim Indicative Earnings') 
			AND		DataSetName = 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018') TOTAL 	

	--Adult Non-Levy Contracted Apprenticeships
	INSERT INTO [Report].[FundingSummary_AdultNonLevyContractedApprenticeships]
	(
			 SubGroupHeader
			,SortOrder
			,DataSetName
			,YTDCalc
			,TotalCalc
			,AugToMar
			,AprToJul
			,FundCalcAug
			,FundCalcSep
			,FundCalcOct
			,FundCalcNov
			,FundCalcDec
			,FundCalcJan
			,FundCalcFeb
			,FundCalcMar
			,FundCalcApr
			,FundCalcMay
			,FundCalcJun
			,FundCalcJul
	)
	SELECT	* 
	FROM 
	(
			SELECT 'ILR Adult Non-Levy Contracted Apprenticeships Programme Aim Indicative Earnings'					AS SubGroupHeader,1  AS SortOrder,'LineTotalsAdultNonLevyContractedApprenticeships'  AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship (From May 2017) Non-Levy Contract (non-procured),19+ Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'ProgrammeAimOnProgPayment,ProgrammeAimBalPayment,ProgrammeAimCompletionPayment') UNION
			SELECT '...of which Indicative Government Co-Investment Earnings'											AS SubGroupHeader,2  AS SortOrder,'LineTotalsAdultNonLevyContractedApprenticeships'  AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship (From May 2017) Non-Levy Contract (non-procured),19+ Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'ProgrammeAimProgFundIndMinCoInvest') UNION
			SELECT 'ILR Adult Non-Levy Contracted Apprenticeships Maths and English Programme Funding'					AS SubGroupHeader,3  AS SortOrder ,'LineTotalsAdultNonLevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship (From May 2017) Non-Levy Contract (non-procured),19+ Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'MathEngOnProgPayment,MathEngBalPayment') UNION
			SELECT 'ILR Adult Non-Levy Contracted Apprenticeships Framework Uplift'										AS SubGroupHeader,4  AS SortOrder,'LineTotalsAdultNonLevyContractedApprenticeships'  AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship (From May 2017) Non-Levy Contract (non-procured),19+ Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'LDApplic1618FrameworkUpliftBalancingPayment,LDApplic1618FrameworkUpliftCompletionPayment,LDApplic1618FrameworkUpliftOnProgPayment') UNION
			SELECT 'ILR Adult Non-Levy Contracted Apprenticeships Disadvantage Payments'								AS SubGroupHeader,5  AS SortOrder ,'LineTotalsAdultNonLevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship (From May 2017) Non-Levy Contract (non-procured),19+ Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'DisadvFirstPayment,DisadvSecondPayment') UNION
			SELECT 'ILR Adult Non-Levy Contracted Apprenticeships Additional Payments for Providers'					AS SubGroupHeader,6  AS SortOrder ,'LineTotalsAdultNonLevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship (From May 2017) Non-Levy Contract (non-procured),19+ Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'LearnDelFirstProv1618Pay,LearnDelSecondProv1618Pay') UNION
			SELECT 'ILR Adult Non-Levy Contracted Apprenticeships Additional Payments for Employers'					AS SubGroupHeader,7  AS SortOrder ,'LineTotalsAdultNonLevyContractedApprenticeships' AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship (From May 2017) Non-Levy Contract (non-procured),19+ Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'LearnDelFirstEmp1618Pay,LearnDelSecondEmp1618Pay') UNION
			SELECT 'ILR Adult Non-Levy Contracted Apprenticeships Learning Support'										AS SubGroupHeader,8  AS SortOrder,'LineTotalsAdultNonLevyContractedApprenticeships'  AS DataSetName,*  FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship (From May 2017) Non-Levy Contract (non-procured),19+ Apprenticeship (From May 2017) Non-Levy Contract',@CollectionPeriodInt,'LearnSuppFundCash') UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships Training Audit Adjustments'							AS SubGroupHeader,10 AS SortOrder ,'LineTotalsAdultNonLevyContractedApprenticeships' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: Adult Non-Levy Apprenticeships - Training',		@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships Training Authorised Claims'							AS SubGroupHeader,11 AS SortOrder ,'LineTotalsAdultNonLevyContractedApprenticeships' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: Adult Non-Levy Apprenticeships - Training',		@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships Additional Payments for Providers Audit Adjustments'	AS SubGroupHeader,12 AS SortOrder,'LineTotalsAdultNonLevyContractedApprenticeships'  AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: Adult Non-Levy Apprenticeships - Provider',		@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships Additional Payments for Providers Authorised Claims ' AS SubGroupHeader,13 AS SortOrder ,'LineTotalsAdultNonLevyContractedApprenticeships' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: Adult Non-Levy Apprenticeships - Provider',		@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships Additional Payments for Providers Excess Learning Support'	AS SubGroupHeader,14 AS SortOrder ,'LineTotalsAdultNonLevyContractedApprenticeships' AS DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: Adult Non-Levy Apprenticeships - Provider', @CollectionPeriodInt) UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships Additional Payments for Employers Audit Adjustments ' AS SubGroupHeader,15 AS SortOrder ,'LineTotalsAdultNonLevyContractedApprenticeships' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: Adult Non-Levy Apprenticeships - Employer',		@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships Additional Payments for Employers Authorised Claims'	AS SubGroupHeader,16 AS SortOrder ,'LineTotalsAdultNonLevyContractedApprenticeships' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: Adult Non-Levy Apprenticeships - Employer',		@CollectionPeriodInt)
	) AS [AdultNonLevyContractedApprenticeships]

	--Adult Non-Levy Contracted Apprenticeships Totals
	INSERT INTO [Report].[FundingSummary_TotalAdultNonLevyContractedApprenticeships]
	(
			 SubGroupHeader
			,SortOrder
			,DataSetName
			,YTDCalc
			,TotalCalc
			,AugToMar
			,AprToJul
			,FundCalcAug
			,FundCalcSep
			,FundCalcOct
			,FundCalcNov
			,FundCalcDec
			,FundCalcJan
			,FundCalcFeb
			,FundCalcMar
			,FundCalcApr
			,FundCalcMay
			,FundCalcJun
			,FundCalcJul
	)
	SELECT	* 
	FROM 
	(
			SELECT	'Total Adult Non-Levy Contracted Apprenticeships'	as SubGroupHeader
					,18													as SortOrder
					,'LineTotalsAdultNonLevyContractedApprenticeships'	as DataSetName
					,SUM(YTDCalc)										AS YTDCalc
					,SUM (TotalCalc)									AS TotalCalc
					,sum(AugToMar)										AS AugToMar
					,sum(AprToJul)										AS AprToJul
					,sum(FundCalcAug)									AS FundCalcAug
					,sum(FundCalcSep)									AS FundCalcSep
					,sum(FundCalcOct)									AS FundCalcOct
					,sum(FundCalcNov)									AS FundCalcNov
					,sum(FundCalcDec)									AS FundCalcDec
					,sum(FundCalcJan)									AS FundCalcJan
					,sum(FundCalcFeb)									AS FundCalcFeb
					,sum(FundCalcMar)									AS FundCalcMar
					,sum(FundCalcApr)									AS FundCalcApr
					,sum(FundCalcMay)									AS FundCalcMay
					,sum(FundCalcJun)									AS FundCalcJun
					,sum(FundCalcJul)									AS FundCalcJul
			FROM	[Report].[FundingSummary_AdultNonLevyContractedApprenticeships] 
			WHERE	SubGroupHeader 
			NOT IN	('ILR Adult Non-Levy Contracted Apprenticeships Programme Aim Indicative Earnings') 
			AND		DataSetName = 'LineTotalsAdultNonLevyContractedApprenticeships'
	) AS TOTAL
	
	

		--Adult Non-Levy Contracted Apprenticeships From Jan 2018
	INSERT INTO [Report].[FundingSummary_AdultNonLevyContractedApprenticeships]
	(
			 SubGroupHeader
			,SortOrder
			,DataSetName
			,YTDCalc
			,TotalCalc
			,AugToMar
			,AprToJul
			,FundCalcAug
			,FundCalcSep
			,FundCalcOct
			,FundCalcNov
			,FundCalcDec
			,FundCalcJan
			,FundCalcFeb
			,FundCalcMar
			,FundCalcApr
			,FundCalcMay
			,FundCalcJun
			,FundCalcJul
	)
	SELECT	* 
	FROM 
	(
			SELECT 'ILR Adult Non-Levy Contracted Apprenticeships Programme Aim Indicative Earnings'					AS SubGroupHeader,1  AS SortOrder, 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship Non-Levy Contract (procured)',						@CollectionPeriodInt,'ProgrammeAimOnProgPayment,ProgrammeAimBalPayment,ProgrammeAimCompletionPayment') UNION
			SELECT '...of which Indicative Government Co-Investment Earnings'											AS SubGroupHeader,2  AS SortOrder, 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship Non-Levy Contract (procured)',						@CollectionPeriodInt,'ProgrammeAimProgFundIndMinCoInvest') UNION
			SELECT 'ILR Adult Non-Levy Contracted Apprenticeships Maths and English Programme Funding'					AS SubGroupHeader,3  AS SortOrder, 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship Non-Levy Contract (procured)',						@CollectionPeriodInt,'MathEngOnProgPayment,MathEngBalPayment') UNION
			SELECT 'ILR Adult Non-Levy Contracted Apprenticeships Framework Uplift'										AS SubGroupHeader,4  AS SortOrder, 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship Non-Levy Contract (procured)',						@CollectionPeriodInt,'LDApplic1618FrameworkUpliftBalancingPayment,LDApplic1618FrameworkUpliftCompletionPayment,LDApplic1618FrameworkUpliftOnProgPayment') UNION
			SELECT 'ILR Adult Non-Levy Contracted Apprenticeships Disadvantage Payments'								AS SubGroupHeader,5  AS SortOrder, 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship Non-Levy Contract (procured)',						@CollectionPeriodInt,'DisadvFirstPayment,DisadvSecondPayment') UNION
			SELECT 'ILR Adult Non-Levy Contracted Apprenticeships Additional Payments for Providers'					AS SubGroupHeader,6  AS SortOrder, 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship Non-Levy Contract (procured)',						@CollectionPeriodInt,'LearnDelFirstProv1618Pay,LearnDelSecondProv1618Pay') UNION
			SELECT 'ILR Adult Non-Levy Contracted Apprenticeships Additional Payments for Employers'					AS SubGroupHeader,7  AS SortOrder, 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship Non-Levy Contract (procured)',						@CollectionPeriodInt,'LearnDelFirstEmp1618Pay,LearnDelSecondEmp1618Pay') UNION
			SELECT 'ILR Adult Non-Levy Contracted Apprenticeships Learning Support'										AS SubGroupHeader,8  AS SortOrder, 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM [dbo].[GetAECFundingForType] ('19+ Apprenticeship Non-Levy Contract (procured)',						@CollectionPeriodInt,'LearnSuppFundCash') UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships Training Audit Adjustments'							AS SubGroupHeader,10 AS SortOrder, 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: Adult Non-Levy Apprenticeships (procured) - Training',			@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships Training Authorised Claims'							AS SubGroupHeader,11 AS SortOrder, 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: Adult Non-Levy Apprenticeships (procured) - Training',			@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships Additional Payments for Providers Audit Adjustments'	AS SubGroupHeader,12 AS SortOrder, 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: Adult Non-Levy Apprenticeships (procured) - Provider',			@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships Additional Payments for Providers Authorised Claims ' AS SubGroupHeader,13 AS SortOrder, 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: Adult Non-Levy Apprenticeships (procured) - Provider',			@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships Additional Payments for Providers Excess Learning Support'	AS SubGroupHeader,14 AS SortOrder, 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: Adult Non-Levy Apprenticeships (procured) - Provider',	@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships Additional Payments for Employers Audit Adjustments ' AS SubGroupHeader,15 AS SortOrder, 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: Adult Non-Levy Apprenticeships (procured) - Employer',			@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships Additional Payments for Employers Authorised Claims'	AS SubGroupHeader,16 AS SortOrder, 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: Adult Non-Levy Apprenticeships (procured) - Employer',			@CollectionPeriodInt)
	) AS [AdultNonLevyContractedApprenticeships_1]

	--Adult Non-Levy Contracted Apprenticeships Totals From Jan 2018
	INSERT INTO [Report].[FundingSummary_TotalAdultNonLevyContractedApprenticeships]
	(
			 SubGroupHeader
			,SortOrder
			,DataSetName
			,YTDCalc
			,TotalCalc
			,AugToMar
			,AprToJul
			,FundCalcAug
			,FundCalcSep
			,FundCalcOct
			,FundCalcNov
			,FundCalcDec
			,FundCalcJan
			,FundCalcFeb
			,FundCalcMar
			,FundCalcApr
			,FundCalcMay
			,FundCalcJun
			,FundCalcJul
	)
	SELECT	* 
	FROM 
	(
			SELECT	'Total Adult Non-Levy Contracted Apprenticeships'				AS SubGroupHeader
					,18																AS SortOrder 
					,'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018'	AS DataSetName
					,SUM(YTDCalc)													AS YTDCalc
					,SUM (TotalCalc)												AS TotalCalc
					,SUM(AugToMar)													AS AugToMar
					,SUM(AprToJul)													AS AprToJul
					,SUM(FundCalcAug)												AS FundCalcAug
					,SUM(FundCalcSep)												AS FundCalcSep
					,SUM(FundCalcOct)												AS FundCalcOct
					,SUM(FundCalcNov)												AS FundCalcNov
					,SUM(FundCalcDec)												AS FundCalcDec
					,SUM(FundCalcJan)												AS FundCalcJan
					,SUM(FundCalcFeb)												AS FundCalcFeb
					,SUM(FundCalcMar)												AS FundCalcMar
					,SUM(FundCalcApr)												AS FundCalcApr
					,SUM(FundCalcMay)												AS FundCalcMay
					,SUM(FundCalcJun)												AS FundCalcJun
					,SUM(FundCalcJul)												AS FundCalcJul
			FROM	[Report].[FundingSummary_AdultNonLevyContractedApprenticeships] 
			Where	SubGroupHeader 
			NOT IN	('ILR Adult Non-Levy Contracted Apprenticeships Programme Aim Indicative Earnings') 
			AND		DataSetName = 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018'
	) AS TOTAL
	


	--Total NonLevy Budget
	INSERT INTO [Report].[FundingSummary_TotalNonLevyBudget]
    (
				 SubGroupHeader
				,SortOrder
				,DataSetName
				,YTDCalc
				,TotalCalc
				,AugToMar
				,AprToJul
				,FundCalcAug
				,FundCalcSep
				,FundCalcOct
				,FundCalcNov
				,FundCalcDec
				,FundCalcJan
				,FundCalcFeb
				,FundCalcMar
				,FundCalcApr
				,FundCalcMay
				,FundCalcJun
				,FundCalcJul
	)
	SELECT		'Total Non-Levy Contracted Apprenticeships Budget - Non-procured delivery'	AS SubGroupHeader
				,1																			AS SortOrder
				,'LineTotalsNonLevyBudget'													AS DataSetName
				,SUM(YTDCalc)																AS YTDCalc
				,SUM(TotalCalc)																AS TotalCalc
				,sum(AugToMar)																AS AugToMar
				,SUM(AprToJul)																AS AprToJul
				,SUM(FundCalcAug)															AS FundCalcAug
				,SUM(FundCalcSep)															AS FundCalcSep
				,SUM(FundCalcOct)															AS FundCalcOct
				,SUM(FundCalcNov)															AS FundCalcNov
				,SUM(FundCalcDec)															AS FundCalcDec
				,SUM(FundCalcJan)															AS FundCalcJan
				,SUM(FundCalcFeb)															AS FundCalcFeb
				,SUM(FundCalcMar)															AS FundCalcMar
				,SUM(FundCalcApr)															AS FundCalcApr
				,SUM(FundCalcMay)															AS FundCalcMay
				,SUM(FundCalcJun)															AS FundCalcJun
				,SUM(FundCalcJul)															AS FundCalcJul 
	FROM
	( 
		SELECT	 FundCalcAug
				,FundCalcSep
				,FundCalcOct
				,FundCalcNov
				,FundCalcDec
				,FundCalcJan
				,FundCalcFeb
				,FundCalcMar
				,FundCalcApr
				,FundCalcMay
				,FundCalcJun
				,FundCalcJul
				,YTDCalc
				,TotalCalc
				,AugToMar
				,AprToJul 
		FROM	Report.FundingSummary_Total1618NonLevyContractedApprenticeships 
		WHERE	DataSetName ='LineTotals1618NonLevyContractedApprenticeships' 

		UNION

		SELECT	 FundCalcAug
				,FundCalcSep
				,FundCalcOct
				,FundCalcNov
				,FundCalcDec
				,FundCalcJan
				,FundCalcFeb
				,FundCalcMar
				,FundCalcApr
				,FundCalcMay
				,FundCalcJun
				,FundCalcJul
				,YTDCalc
				,TotalCalc
				,AugToMar
				,AprToJul 
		FROM	Report.FundingSummary_TotalAdultNonLevyContractedApprenticeships  
		WHERE	DataSetName ='LineTotalsAdultNonLevyContractedApprenticeships'
	) AS a
	
	INSERT INTO [Report].[FundingSummary_TotalNonLevyBudget]
    (
				 SubGroupHeader
				,SortOrder
				,DataSetName
				,YTDCalc
				,TotalCalc
				,AugToMar
				,AprToJul
				,FundCalcAug
				,FundCalcSep
				,FundCalcOct
				,FundCalcNov
				,FundCalcDec
				,FundCalcJan
				,FundCalcFeb
				,FundCalcMar
				,FundCalcApr
				,FundCalcMay
				,FundCalcJun
				,FundCalcJul
	)

	SELECT		'Total Non-Levy Contracted Apprenticeships Budget - Procured delivery'	AS SubGroupHeader
				,1																			AS SortOrder
				,'LineTotalsNonLevyBudgetFrmJan2018'										AS DataSetName
				,SUM(YTDCalc)																AS YTDCalc
				,SUM (TotalCalc)															AS TotalCalc
				,SUM(AugToMar)																AS AugToMar
				,SUM(AprToJul)																AS AprToJul
				,SUM(FundCalcAug)															AS FundCalcAug
				,SUM(FundCalcSep)															AS FundCalcSep
				,SUM(FundCalcOct)															AS FundCalcOct
				,SUM(FundCalcNov)															AS FundCalcNov
				,SUM(FundCalcDec)															AS FundCalcDec
				,SUM(FundCalcJan)															AS FundCalcJan
				,SUM(FundCalcFeb)															AS FundCalcFeb
				,SUM(FundCalcMar)															AS FundCalcMar
				,SUM(FundCalcApr)															AS FundCalcApr
				,SUM(FundCalcMay)															AS FundCalcMay
				,SUM(FundCalcJun)															AS FundCalcJun
				,SUM(FundCalcJul)															AS FundCalcJul 
	FROM 
	(
				SELECT	 FundCalcAug
						,FundCalcSep
						,FundCalcOct
						,FundCalcNov
						,FundCalcDec
						,FundCalcJan
						,FundCalcFeb
						,FundCalcMar
						,FundCalcApr
						,FundCalcMay
						,FundCalcJun
						,FundCalcJul
						,YTDCalc
						,TotalCalc
						,AugToMar
						,AprToJul 
				FROM	Report.FundingSummary_Total1618NonLevyContractedApprenticeships 
				WHERE	DataSetName = 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' 
				
				UNION
			
				SELECT	 FundCalcAug
						,FundCalcSep
						,FundCalcOct
						,FundCalcNov
						,FundCalcDec
						,FundCalcJan
						,FundCalcFeb
						,FundCalcMar
						,FundCalcApr
						,FundCalcMay
						,FundCalcJun
						,FundCalcJul
						,YTDCalc
						,TotalCalc
						,AugToMar
						,AprToJul 
				FROM	Report.FundingSummary_TotalAdultNonLevyContractedApprenticeships  
				WHERE	DataSetName = 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018'
	) AS a
	
	/********************************************************************************************************************************************************************/

	
	INSERT INTO [Report].[FundingSummary_AebOther]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT *
	FROM
	(
			SELECT 'ILR AEB - Other Learning Programme Funding'								AS SubGroupHeader,1 AS SortOrder,'LineTotalsAebOtherLearning' AS DataSetName, * FROM dbo.GetSFAFundingForType('AEB - Other Learning,AEB - Other Learning (non-procured)',	@CollectionPeriodInt) UNION
			SELECT 'ILR AEB - Other Learning (25+ High Needs Students) Programme Funding'	AS SubGroupHeader,3 AS SortOrder,'LineTotalsAebOtherLearning' AS DataSetName, * FROM dbo.GetEFAFundingForType('25+ Students with an EHCP',									@CollectionPeriodInt) UNION
			SELECT 'ILR AEB - Other Learning Learning Support'								AS SubGroupHeader,4 AS SortOrder,'LineTotalsAebOtherLearning' AS DataSetName, * FROM dbo.GetLSFFundingForType('AEB - Other Learning,AEB - Other Learning (non-procured)',	@CollectionPeriodInt) UNION
			SELECT 'EAS AEB - Other Learning Audit Adjustments'								AS SubGroupHeader,6 AS SortOrder,'LineTotalsAebOtherLearning' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: AEB-Other Learning',								@CollectionPeriodInt) UNION
			SELECT 'EAS AEB - Other Learning Authorised Claims'								AS SubGroupHeader,7 AS SortOrder,'LineTotalsAebOtherLearning' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: AEB-Other Learning',								@CollectionPeriodInt) UNION
			SELECT 'EAS AEB - Other Learning Excess Learning Support'						AS SubGroupHeader,8 AS SortOrder,'LineTotalsAebOtherLearning' AS DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: AEB-Other Learning',						@CollectionPeriodInt) 
	) AS A

	INSERT INTO [Report].[FundingSummary_TotalAebOther]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT * 
	FROM 
	(
			SELECT 'Total AEB - Other Learning'		AS SubGroupHeader
					,10								AS SortOrder
					,'LineTotalsAebOtherLearning'	AS DataSetName
					,SUM(YTDCalc)					AS YTDCalc
					,SUM (TotalCalc)				AS TotalCalc
					,SUM(AugToMar)					AS AugToMar
					,SUM(AprToJul)					AS AprToJul
					,SUM(FundCalcAug)				AS FundCalcAug
					,SUM(FundCalcSep)				AS FundCalcSep
					,SUM(FundCalcOct)				AS FundCalcOct
					,SUM(FundCalcNov)				AS FundCalcNov
					,SUM(FundCalcDec)				AS FundCalcDec
					,SUM(FundCalcJan)				AS FundCalcJan
					,SUM(FundCalcFeb)				AS FundCalcFeb
					,SUM(FundCalcMar)				AS FundCalcMar
					,SUM(FundCalcApr)				AS FundCalcApr
					,SUM(FundCalcMay)				AS FundCalcMay
					,SUM(FundCalcJun)				AS FundCalcJun
					,SUM(FundCalcJul)				AS FundCalcJul
			FROM	Report.FundingSummary_AebOther 
			WHERE	[DataSetName] ='LineTotalsAebOtherLearning'
	) AS TOTAL

	--'LineTotalsAebOtherLearning' Procured delivery 

	INSERT INTO [Report].[FundingSummary_AebOther]
	(
				 [SubGroupHeader]
				,[SortOrder]
				,[DataSetName]
				,[YTDCalc]
				,[TotalCalc]
				,[AugToMar]
				,[AprToJul]
				,[FundCalcAug]
				,[FundCalcSep]
				,[FundCalcOct]
				,[FundCalcNov]
				,[FundCalcDec]
				,[FundCalcJan]
				,[FundCalcFeb] 
				,[FundCalcMar] 
				,[FundCalcApr]
				,[FundCalcMay] 
				,[FundCalcJun]
				,[FundCalcJul]
	)
	SELECT *
	FROM
	(
			SELECT 'ILR AEB - Other Learning Programme Funding'		  AS SubGroupHeader,1 AS SortOrder,'LineTotalsAebOtherLearningFrmNov2017' AS DataSetName, * FROM dbo.GetSFAFundingForType('AEB - Other Learning (procured from Nov 2017)',		  @CollectionPeriodInt) UNION			
			SELECT 'ILR AEB - Other Learning Learning Support'		  AS SubGroupHeader,4 AS SortOrder,'LineTotalsAebOtherLearningFrmNov2017' AS DataSetName, * FROM dbo.GetLSFFundingForType('AEB - Other Learning (procured from Nov 2017)',		  @CollectionPeriodInt) UNION
			SELECT 'EAS AEB - Other Learning Audit Adjustments'		  AS SubGroupHeader,6 AS SortOrder,'LineTotalsAebOtherLearningFrmNov2017' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: AEB-Other Learning (From Nov 2017)',		  @CollectionPeriodInt) UNION
			SELECT 'EAS AEB - Other Learning Authorised Claims'		  AS SubGroupHeader,7 AS SortOrder,'LineTotalsAebOtherLearningFrmNov2017' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: AEB-Other Learning (From Nov 2017)',		  @CollectionPeriodInt) UNION
			SELECT 'EAS AEB - Other Learning Excess Learning Support' AS SubGroupHeader,8 AS SortOrder,'LineTotalsAebOtherLearningFrmNov2017' AS DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: AEB-Other Learning (From Nov 2017)', @CollectionPeriodInt) 
	) AS a

	INSERT INTO [Report].[FundingSummary_TotalAebOther]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	* 
	FROM 
	(
			SELECT	'Total AEB - Other Learning'			AS SubGroupHeader
					,10										AS SortOrder
					,'LineTotalsAebOtherLearningFrmNov2017' AS DataSetName
					,SUM(YTDCalc)							AS YTDCalc
					,SUM (TotalCalc)						AS TotalCalc
					,SUM(AugToMar)							AS AugToMar
					,SUM(AprToJul)							AS AprToJul
					,SUM(FundCalcAug)						AS FundCalcAug
					,SUM(FundCalcSep)						AS FundCalcSep
					,SUM(FundCalcOct)						AS FundCalcOct
					,SUM(FundCalcNov)						AS FundCalcNov
					,SUM(FundCalcDec)						AS FundCalcDec
					,SUM(FundCalcJan)						AS FundCalcJan
					,SUM(FundCalcFeb)						AS FundCalcFeb
					,SUM(FundCalcMar)						AS FundCalcMar
					,SUM(FundCalcApr)						AS FundCalcApr
					,SUM(FundCalcMay)						AS FundCalcMay
					,SUM(FundCalcJun)						AS FundCalcJun
					,SUM(FundCalcJul)						AS FundCalcJul
			FROM	Report.FundingSummary_AebOther 
			WHERE	[DataSetName] ='LineTotalsAebOtherLearningFrmNov2017'
	) AS TOTAL

	INSERT INTO [Report].[FundingSummary_24PlusAdvLoansBursary]
	(
			[SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)	
	SELECT	*
	FROM
	(
			SELECT 'ILR Advanced Loans Bursary Funding'						 AS SubGroupHeader,1 AS SortOrder,'LineTotals24PlusAdvLoansBursary' AS DataSetName, * FROM dbo.GetBursaryFundingForType('Advanced Learner Loans Bursary',			@CollectionPeriodInt) UNION
			SELECT 'ILR Advanced Loans Bursary Area Costs'					 AS SubGroupHeader,2 AS SortOrder,'LineTotals24PlusAdvLoansBursary' AS DataSetName, * FROM dbo.GetBursaryLoansAreaUpliftForType('Advanced Learner Loans Bursary',	@CollectionPeriodInt) UNION
			SELECT 'EAS Advanced Loans Bursary Excess Support'				 AS SubGroupHeader,4 AS SortOrder,'LineTotals24PlusAdvLoansBursary' AS DataSetName, * FROM dbo.GetEASFunding('Excess Support: Advanced Learner Loans Bursary',		@CollectionPeriodInt) UNION
			SELECT 'EAS Advanced Loans Bursary Area Costs Audit Adjustments' AS SubGroupHeader,5 AS SortOrder,'LineTotals24PlusAdvLoansBursary' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: Advanced Learner Loans Bursary',	@CollectionPeriodInt)
	) AS a

	INSERT INTO [Report].[FundingSummary_Total24PlusAdvLoansBursary]
	(
			[SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)	
	SELECT	* 
	FROM 
	(
			SELECT	'Total Advanced Loans Bursary'		AS SubGroupHeader
					,7									AS SortOrder
					,'LineTotals24PlusAdvLoansBursary'	AS DataSetName
					,SUM(YTDCalc)						AS YTDCalc
					,SUM (TotalCalc)					AS TotalCalc
					,sum(AugToMar)						AS AugToMar
					,sum(AprToJul)						AS AprToJul
					,sum(FundCalcAug)					AS FundCalcAug
					,sum(FundCalcSep)					AS FundCalcSep
					,sum(FundCalcOct)					AS FundCalcOct
					,sum(FundCalcNov)					AS FundCalcNov
					,sum(FundCalcDec)					AS FundCalcDec
					,sum(FundCalcJan)					AS FundCalcJan
					,sum(FundCalcFeb)					AS FundCalcFeb
					,sum(FundCalcMar)					AS FundCalcMar
					,sum(FundCalcApr)					AS FundCalcApr
					,sum(FundCalcMay)					AS FundCalcMay
					,sum(FundCalcJun)					AS FundCalcJun
					,sum(FundCalcJul)					AS FundCalcJul
			FROM	Report.FundingSummary_24PlusAdvLoansBursary
	) AS TOTAL

	INSERT INTO [Report].[FundingSummary_AdultOLASS]
	(
			[SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)	
	SELECT	*
	FROM
	(
			SELECT 'ILR Adult OLASS Programme Funding'		 AS SubGroupHeader,1 AS SortOrder,'LineTotalsAdultOLASS' AS DataSetName, * FROM dbo.GetSFAFundingForType('Adult OLASS',		@CollectionPeriodInt) UNION
			SELECT 'ILR Adult OLASS Learning Support'		 AS SubGroupHeader,2 AS SortOrder,'LineTotalsAdultOLASS' AS DataSetName, * FROM dbo.GetLSFFundingForType('Adult OLASS',		@CollectionPeriodInt) UNION
			SELECT 'EAS Adult OLASS Audit Adjustments'		 AS SubGroupHeader,4 AS SortOrder,'LineTotalsAdultOLASS' AS DataSetName, * FROM dbo.GetOLASSEASAuditAdjustmentsFunding(		@CollectionPeriodInt)UNION
			SELECT 'EAS Adult OLASS Authorised Claims'		 AS SubGroupHeader,5 AS SortOrder,'LineTotalsAdultOLASS' AS DataSetName, * FROM dbo.GetOLASSEASAuthorisedClaimsFunding(		@CollectionPeriodInt)UNION
			SELECT 'EAS Adult OLASS Excess Learning Support' AS SubGroupHeader,6 AS SortOrder,'LineTotalsAdultOLASS' AS DataSetName, * FROM dbo.GetOLASSEASExcessLearningSupportFunding(@CollectionPeriodInt) 
	) AS a

	INSERT INTO [Report].[FundingSummary_TotalAdultOLASS]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	* 
	FROM 
	(
			SELECT	'Total Adult OLASS'		AS SubGroupHeader
					,8						AS SortOrder
					,'LineTotalsAdultOLASS' AS DataSetName
					,SUM(YTDCalc)			AS YTDCalc
					,SUM (TotalCalc)		AS TotalCalc
					,SUM(AugToMar)			AS AugToMar
					,SUM(AprToJul)			AS AprToJul
					,SUM(FundCalcAug)		AS FundCalcAug
					,SUM(FundCalcSep)		AS FundCalcSep
					,SUM(FundCalcOct)		AS FundCalcOct
					,SUM(FundCalcNov)		AS FundCalcNov
					,SUM(FundCalcDec)		AS FundCalcDec
					,SUM(FundCalcJan)		AS FundCalcJan
					,SUM(FundCalcFeb)		AS FundCalcFeb
					,SUM(FundCalcMar)		AS FundCalcMar
					,SUM(FundCalcApr)		AS FundCalcApr
					,SUM(FundCalcMay)		AS FundCalcMay
					,SUM(FundCalcJun)		AS FundCalcJun
					,SUM(FundCalcJul)		AS FundCalcJul
			FROM	Report.FundingSummary_AdultOLASS
	) AS TOTAL

	INSERT INTO [Report].[FundingSummary_1618Trailblazers]
	(
			[SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	*
	FROM
	(
			SELECT 'ILR 16-18 Trailblazer Apprenticeships Programme Funding (Core Government Contribution, Maths and English)'	AS SubGroupHeader, 1 AS SortOrder,'LineTotals1618Trailblazers' AS DataSetName, * FROM dbo.GetTrailblazerOnProgFundingForType('16-18 Trailblazer Apprenticeship',		@CollectionPeriodInt) UNION
			SELECT 'ILR 16-18 Trailblazer Apprenticeships Employer Incentive Payments (Achievement, Small Employer, 16-18)'		AS SubGroupHeader, 2 AS SortOrder,'LineTotals1618Trailblazers' AS DataSetName, * FROM dbo.GetTrailblazerIncentivesFundingForType('16-18 Trailblazer Apprenticeship',	@CollectionPeriodInt) UNION
			SELECT 'ILR 16-18 Trailblazer Apprenticeships Learning Support'														AS SubGroupHeader, 3 AS SortOrder,'LineTotals1618Trailblazers' AS DataSetName, * FROM dbo.GetTrailblazerLSFFundingForType('16-18 Trailblazer Apprenticeship',			@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Trailblazer Apprenticeships Audit Adjustments'													AS SubGroupHeader, 5 AS SortOrder,'LineTotals1618Trailblazers' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: 16-18 Trailblazer Apprenticeships',			@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Trailblazer Apprenticeships Authorised Claims'													AS SubGroupHeader, 6 AS SortOrder,'LineTotals1618Trailblazers' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: 16-18 Trailblazer Apprenticeships',			@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Trailblazer Apprenticeships Excess Learning Support'												AS SubGroupHeader, 7 AS SortOrder,'LineTotals1618Trailblazers' AS DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: 16-18 Trailblazer Apprenticeships',	@CollectionPeriodInt)
	) AS a

	INSERT INTO [Report].[FundingSummary_Total1618Trailblazers]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	* 
	FROM 
	(
			SELECT	'Total 16-18 Trailblazer Apprenticeships for starts before 1 May 2017'	AS SubGroupHeader
					,9																		AS SortOrder
					,'LineTotals1618Trailblazers'											AS DataSetName
					,SUM(YTDCalc)															AS YTDCalc
					,SUM (TotalCalc)														AS TotalCalc
					,sum(AugToMar)															AS AugToMar
					,sum(AprToJul)															AS AprToJul
					,sum(FundCalcAug)														AS FundCalcAug
					,sum(FundCalcSep)														AS FundCalcSep
					,sum(FundCalcOct)														AS FundCalcOct
					,sum(FundCalcNov)														AS FundCalcNov
					,sum(FundCalcDec)														AS FundCalcDec
					,sum(FundCalcJan)														AS FundCalcJan
					,sum(FundCalcFeb)														AS FundCalcFeb
					,sum(FundCalcMar)														AS FundCalcMar
					,sum(FundCalcApr)														AS FundCalcApr
					,sum(FundCalcMay)														AS FundCalcMay
					,sum(FundCalcJun)														AS FundCalcJun
					,sum(FundCalcJul)														AS FundCalcJul
			From	[Report].[FundingSummary_1618Trailblazers]
	) AS TOTAL

	INSERT INTO [Report].[FundingSummary_1923Trailblazers]
	(
			[SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	*
	FROM
	(
			SELECT 'ILR 19-23 Trailblazer Apprenticeships Programme Funding (Core Government Contribution, Maths and English)'	AS SubGroupHeader,1 AS SortOrder,'LineTotals1923Trailblazers' AS DataSetName, * FROM dbo.GetTrailblazerOnProgFundingForType('19-23 Trailblazer Apprenticeship',				@CollectionPeriodInt) UNION
			SELECT 'ILR 19-23 Trailblazer Apprenticeships Employer Incentive Payments (Achievement, Small Employer, 16-18)'		AS SubGroupHeader,2 AS SortOrder,'LineTotals1923Trailblazers' AS DataSetName, * FROM dbo.GetTrailblazerAdultIncentivesFundingForType('19-23 Trailblazer Apprenticeship',	@CollectionPeriodInt) UNION
			SELECT 'ILR 19-23 Trailblazer Apprenticeships Learning Support'														AS SubGroupHeader,3 AS SortOrder,'LineTotals1923Trailblazers' AS DataSetName, * FROM dbo.GetTrailblazerLSFFundingForType('19-23 Trailblazer Apprenticeship',				@CollectionPeriodInt) UNION
			SELECT 'EAS 19-23 Trailblazer Apprenticeships Audit Adjustments'													AS SubGroupHeader,5 AS SortOrder,'LineTotals1923Trailblazers' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: 19-23 Trailblazer Apprenticeships',				@CollectionPeriodInt) UNION
			SELECT 'EAS 19-23 Trailblazer Apprenticeships Authorised Claims'													AS SubGroupHeader,6 AS SortOrder,'LineTotals1923Trailblazers' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: 19-23 Trailblazer Apprenticeships',				@CollectionPeriodInt) UNION
			SELECT 'EAS 19-23 Trailblazer Apprenticeships Excess Learning Support'												AS SubGroupHeader,7 AS SortOrder,'LineTotals1923Trailblazers' AS DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: 19-23 Trailblazer Apprenticeships',		@CollectionPeriodInt)
	) AS a

	INSERT INTO [Report].[FundingSummary_Total1923Trailblazers]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	* 
	FROM 
	(
			SELECT	'Total 19-23 Trailblazer Apprenticeships'	AS SubGroupHeader
					,9											AS SortOrder
					,'LineTotals1923Trailblazers'				AS DataSetName
					,SUM(YTDCalc)								AS YTDCalc
					,SUM (TotalCalc)							AS TotalCalc
					,SUM(AugToMar)								AS AugToMar
					,SUM(AprToJul)								AS AprToJul
					,SUM(FundCalcAug)							AS FundCalcAug
					,SUM(FundCalcSep)							AS FundCalcSep
					,SUM(FundCalcOct)							AS FundCalcOct
					,SUM(FundCalcNov)							AS FundCalcNov
					,SUM(FundCalcDec)							AS FundCalcDec
					,SUM(FundCalcJan)							AS FundCalcJan
					,SUM(FundCalcFeb)							AS FundCalcFeb
					,SUM(FundCalcMar)							AS FundCalcMar
					,SUM(FundCalcApr)							AS FundCalcApr
					,SUM(FundCalcMay)							AS FundCalcMay
					,SUM(FundCalcJun)							AS FundCalcJun
					,SUM(FundCalcJul)							AS FundCalcJul
			FROM	[Report].[FundingSummary_1923Trailblazers]
	) AS TOTAL

	INSERT INTO [Report].[FundingSummary_24PlusTrailblazers]
	(
			[SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	*
	FROM
	(
			SELECT 'ILR 24+ Trailblazer Apprenticeships Programme Funding (Core Government Contribution, Maths and English)' AS SubGroupHeader,1 AS SortOrder,'LineTotals24PlusTrailblazers' AS DataSetName, * FROM dbo.GetTrailblazerOnProgFundingForType('24+ Trailblazer Apprenticeship',			@CollectionPeriodInt) UNION
			SELECT 'ILR 24+ Trailblazer Apprenticeships Employer Incentive Payments (Achievement, Small Employer, 16-18)'	 AS SubGroupHeader,2 AS SortOrder,'LineTotals24PlusTrailblazers' AS DataSetName, * FROM dbo.GetTrailblazerAdultIncentivesFundingForType('24+ Trailblazer Apprenticeship',	@CollectionPeriodInt) UNION
			SELECT 'ILR 24+ Trailblazer Apprenticeships Learning Support'													 AS SubGroupHeader,3 AS SortOrder,'LineTotals24PlusTrailblazers' AS DataSetName, * FROM dbo.GetTrailblazerLSFFundingForType('24+ Trailblazer Apprenticeship',				@CollectionPeriodInt) UNION
			SELECT 'EAS 24+ Trailblazer Apprenticeships Audit Adjustments'													 AS SubGroupHeader,5 AS SortOrder,'LineTotals24PlusTrailblazers' AS DataSetName, * FROM dbo.GetEASFunding('Audit Adjustments: 24+ Trailblazer Apprenticeships',				@CollectionPeriodInt) UNION
			SELECT 'EAS 24+ Trailblazer Apprenticeships Authorised Claims'													 AS SubGroupHeader,6 AS SortOrder,'LineTotals24PlusTrailblazers' AS DataSetName, * FROM dbo.GetEASFunding('Authorised Claims: 24+ Trailblazer Apprenticeships',				@CollectionPeriodInt) UNION
			SELECT 'EAS 24+ Trailblazer Apprenticeships Excess Learning Support'											 AS SubGroupHeader,7 AS SortOrder,'LineTotals24PlusTrailblazers' AS DataSetName, * FROM dbo.GetEASFunding('Excess Learning Support: 24+ Trailblazer Apprenticeships',		@CollectionPeriodInt)
	) AS a

	INSERT INTO [Report].[FundingSummary_Total24PlusTrailblazers]
	(
			[SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	* 
	FROM 
	(
			SELECT	'Total 24+ Trailblazer Apprenticeships' AS SubGroupHeader
					,9										AS SortOrder
					,'LineTotals24PlusTrailblazers'			AS DataSetName
					,SUM(YTDCalc)							AS YTDCalc
					,SUM (TotalCalc)						AS TotalCalc
					,SUM(AugToMar)							AS AugToMar
					,SUM(AprToJul)							AS AprToJul
					,SUM(FundCalcAug)						AS FundCalcAug
					,SUM(FundCalcSep)						AS FundCalcSep
					,SUM(FundCalcOct)						AS FundCalcOct
					,SUM(FundCalcNov)						AS FundCalcNov
					,SUM(FundCalcDec)						AS FundCalcDec
					,SUM(FundCalcJan)						AS FundCalcJan
					,SUM(FundCalcFeb)						AS FundCalcFeb
					,SUM(FundCalcMar)						AS FundCalcMar
					,SUM(FundCalcApr)						AS FundCalcApr
					,SUM(FundCalcMay)						AS FundCalcMay
					,SUM(FundCalcJun)						AS FundCalcJun
					,SUM(FundCalcJul)						AS FundCalcJul
			FROM	[Report].[FundingSummary_24PlusTrailblazers]
	) TOTAL

	INSERT INTO [Report].[FundingSummary_Total1618Budget]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	'Total 16-18 Apprenticeships Budget'	AS SubGroupHeader
			,1										AS SortOrder
			,'LineTotals1618Budget'					AS DataSetName
			,SUM(YTDCalc)							AS YTDCalc
			,SUM (TotalCalc)						AS TotalCalc
			,SUM(AugToMar)							AS AugToMar
			,SUM(AprToJul)							AS AprToJul
			,SUM(FundCalcAug)						AS FundCalcAug
			,SUM(FundCalcSep)						AS FundCalcSep
			,SUM(FundCalcOct)						AS FundCalcOct
			,SUM(FundCalcNov)						AS FundCalcNov
			,SUM(FundCalcDec)						AS FundCalcDec
			,SUM(FundCalcJan)						AS FundCalcJan
			,SUM(FundCalcFeb)						AS FundCalcFeb
			,SUM(FundCalcMar)						AS FundCalcMar
			,SUM(FundCalcApr)						AS FundCalcApr
			,SUM(FundCalcMay)						AS FundCalcMay
			,SUM(FundCalcJun)						AS FundCalcJun
			,SUM(FundCalcJul)						AS FundCalcJul 
	FROM 
	(
			SELECT	 FundCalcAug
					,FundCalcSep
					,FundCalcOct
					,FundCalcNov
					,FundCalcDec
					,FundCalcJan
					,FundCalcFeb
					,FundCalcMar
					,FundCalcApr
					,FundCalcMay
					,FundCalcJun
					,FundCalcJul
					,YTDCalc
					,TotalCalc
					,AugToMar
					,AprToJul 
			FROM	Report.FundingSummary_Total1618 
			
			UNION

			SELECT	 FundCalcAug
					,FundCalcSep
					,FundCalcOct
					,FundCalcNov
					,FundCalcDec
					,FundCalcJan
					,FundCalcFeb
					,FundCalcMar
					,FundCalcApr
					,FundCalcMay
					,FundCalcJun
					,FundCalcJul
					,YTDCalc
					,TotalCalc
					,AugToMar
					,AprToJul 
			FROM	Report.FundingSummary_Total1618Trailblazers
	) AS a

	INSERT INTO [Report].[FundingSummary_TotalAdultAppBudget]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	'Total Adult Apprenticeships Budget for starts before 1 May 2017'	AS SubGroupHeader
			,1																	AS SortOrder
			,'LineTotalsAdultBudget'											AS DataSetName
			,SUM(YTDCalc)														AS YTDCalc
			,SUM(TotalCalc)														AS TotalCalc
			,SUM(AugToMar)														AS AugToMar
			,SUM(AprToJul)														AS AprToJul
			,SUM(FundCalcAug)													AS FundCalcAug
			,SUM(FundCalcSep)													AS FundCalcSep
			,SUM(FundCalcOct)													AS FundCalcOct
			,SUM(FundCalcNov)													AS FundCalcNov
			,SUM(FundCalcDec)													AS FundCalcDec
			,SUM(FundCalcJan)													AS FundCalcJan
			,SUM(FundCalcFeb)													AS FundCalcFeb
			,SUM(FundCalcMar)													AS FundCalcMar
			,SUM(FundCalcApr)													AS FundCalcApr
			,SUM(FundCalcMay)													AS FundCalcMay
			,SUM(FundCalcJun)													AS FundCalcJun
			,SUM(FundCalcJul)													AS FundCalcJul 
	FROM 
	(
			SELECT	 FundCalcAug
					,FundCalcSep
					,FundCalcOct
					,FundCalcNov
					,FundCalcDec
					,FundCalcJan
					,FundCalcFeb
					,FundCalcMar
					,FundCalcApr
					,FundCalcMay
					,FundCalcJun
					,FundCalcJul
					,YTDCalc
					,TotalCalc
					,AugToMar
					,AprToJul 
			FROM	Report.FundingSummary_Total1923				
			
			UNION

			SELECT	 FundCalcAug
					,FundCalcSep
					,FundCalcOct
					,FundCalcNov
					,FundCalcDec
					,FundCalcJan
					,FundCalcFeb
					,FundCalcMar
					,FundCalcApr
					,FundCalcMay
					,FundCalcJun
					,FundCalcJul
					,YTDCalc
					,TotalCalc
					,AugToMar
					,AprToJul 
			FROM	Report.FundingSummary_Total1923Trailblazers	

			UNION
			
			SELECT	 FundCalcAug
					,FundCalcSep
					,FundCalcOct
					,FundCalcNov
					,FundCalcDec
					,FundCalcJan
					,FundCalcFeb
					,FundCalcMar
					,FundCalcApr
					,FundCalcMay
					,FundCalcJun
					,FundCalcJul
					,YTDCalc
					,TotalCalc
					,AugToMar
					,AprToJul 
			FROM	Report.FundingSummary_Total24PlusTrailblazers	
			
			UNION

			SELECT	FundCalcAug
					,FundCalcSep
					,FundCalcOct
					,FundCalcNov
					,FundCalcDec
					,FundCalcJan
					,FundCalcFeb
					,FundCalcMar
					,FundCalcApr
					,FundCalcMay
					,FundCalcJun
					,FundCalcJul
					,YTDCalc
					,TotalCalc
					,AugToMar
					,AprToJul 
			FROM	Report.FundingSummary_Total24Plus
	) AS a

	INSERT INTO [Report].[FundingSummary_TotalNonAppBudget]
	(
			[SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun],[FundCalcJul]
	)
	SELECT	'Total Non-Apprenticeships'			AS SubGroupHeader
			,1									AS SortOrder
			,'LineTotalsNonApprenticeships'		AS DataSetName
			,SUM(YTDCalc)						AS YTDCalc
			,SUM(TotalCalc)						AS TotalCalc 
			,SUM(AugToMar)						AS AugToMar
			,SUM(AprToJul)						AS AprToJul
			,SUM(FundCalcAug)					AS FundCalcAug
			,SUM(FundCalcSep)					AS FundCalcSep
			,SUM(FundCalcOct)					AS FundCalcOct
			,SUM(FundCalcNov)					AS FundCalcNov
			,SUM(FundCalcDec)					AS FundCalcDec
			,SUM(FundCalcJan)					AS FundCalcJan
			,SUM(FundCalcFeb)					AS FundCalcFeb
			,SUM(FundCalcMar)					AS FundCalcMar
			,SUM(FundCalcApr)					AS FundCalcApr
			,SUM(FundCalcMay)					AS FundCalcMay
			,SUM(FundCalcJun)					AS FundCalcJun
			,SUM(FundCalcJul)					AS FundCalcJul
	FROM 
	(
			SELECT	 FundCalcAug
					,FundCalcSep
					,FundCalcOct
					,FundCalcNov
					,FundCalcDec
					,FundCalcJan
					,FundCalcFeb
					,FundCalcMar
					,FundCalcApr
					,FundCalcMay
					,FundCalcJun
					,FundCalcJul
					,YTDCalc
					,TotalCalc
					,AugToMar
					,AprToJul 
			FROM Report.FundingSummary_Total1924Traineeships 
			
			UNION
			
			SELECT	 FundCalcAug
					,FundCalcSep
					,FundCalcOct
					,FundCalcNov
					,FundCalcDec
					,FundCalcJan
					,FundCalcFeb
					,FundCalcMar
					,FundCalcApr
					,FundCalcMay
					,FundCalcJun
					,FundCalcJul
					,YTDCalc
					,TotalCalc
					,AugToMar
					,AprToJul 
			FROM	Report.FundingSummary_TotalAebOther
	) AS a

	INSERT INTO [Report].[FundingSummary_TotalAdultBudget]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	'Total Adult Education Budget – Non-procured delivery'	AS SubGroupHeader
			,1														AS SortOrder
			,'LineTotalsAdultSkillsBudget'							AS DataSetName
			,SUM(YTDCalc)											AS YTDCalc
			,SUM (TotalCalc)										AS TotalCalc
			,SUM(AugToMar)											AS AugToMar
			,SUM(AprToJul)											AS AprToJul
			,SUM(FundCalcAug)										AS FundCalcAug
			,SUM(FundCalcSep)										AS FundCalcSep
			,SUM(FundCalcOct)										AS FundCalcOct
			,SUM(FundCalcNov)										AS FundCalcNov
			,SUM(FundCalcDec)										AS FundCalcDec
			,SUM(FundCalcJan)										AS FundCalcJan
			,SUM(FundCalcFeb)										AS FundCalcFeb
			,SUM(FundCalcMar)										AS FundCalcMar
			,SUM(FundCalcApr)										AS FundCalcApr
			,SUM(FundCalcMay)										AS FundCalcMay
			,SUM(FundCalcJun)										AS FundCalcJun
			,SUM(FundCalcJul)										AS FundCalcJul 
	FROM 
	(
			SELECT	 FundCalcAug
					,FundCalcSep
					,FundCalcOct
					,FundCalcNov
					,FundCalcDec
					,FundCalcJan
					,FundCalcFeb
					,FundCalcMar
					,FundCalcApr
					,FundCalcMay
					,FundCalcJun
					,FundCalcJul
					,YTDCalc
					,TotalCalc
					,AugToMar
					,AprToJul 
			FROM	Report.FundingSummary_Total1924Traineeships 
			WHERE	DataSetName = 'LineTotals1924Traineeships'
			
			UNION
			
			SELECT	 FundCalcAug
					,FundCalcSep
					,FundCalcOct
					,FundCalcNov
					,FundCalcDec
					,FundCalcJan
					,FundCalcFeb
					,FundCalcMar
					,FundCalcApr
					,FundCalcMay
					,FundCalcJun
					,FundCalcJul
					,YTDCalc
					,TotalCalc
					,AugToMar
					,AprToJul 
			FROM	Report.FundingSummary_TotalAebOther 
			WHERE	DataSetName = 'LineTotalsAebOtherLearning'
	) AS a

	INSERT INTO [Report].[FundingSummary_TotalAdultBudget]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	'Total Adult Education Budget – Procured delivery from 1 Nov 2017'	AS SubGroupHeader
			,1																	AS SortOrder
			,'LineTotalsAdultSkillsBudgetFrmNov2017'							AS DataSetName
			,SUM(YTDCalc)														AS YTDCalc
			,SUM (TotalCalc)													AS TotalCalc
			,SUM(AugToMar)														AS AugToMar
			,SUM(AprToJul)														AS AprToJul
			,SUM(FundCalcAug)													AS FundCalcAug
			,SUM(FundCalcSep)													AS FundCalcSep
			,SUM(FundCalcOct)													AS FundCalcOct
			,SUM(FundCalcNov)													AS FundCalcNov
			,SUM(FundCalcDec)													AS FundCalcDec
			,SUM(FundCalcJan)													AS FundCalcJan
			,SUM(FundCalcFeb)													AS FundCalcFeb
			,SUM(FundCalcMar)													AS FundCalcMar
			,SUM(FundCalcApr)													AS FundCalcApr
			,SUM(FundCalcMay)													AS FundCalcMay
			,SUM(FundCalcJun)													AS FundCalcJun
			,SUM(FundCalcJul)													AS FundCalcJul 
	FROM 
	(
			SELECT	 FundCalcAug
					,FundCalcSep
					,FundCalcOct
					,FundCalcNov
					,FundCalcDec
					,FundCalcJan
					,FundCalcFeb
					,FundCalcMar
					,FundCalcApr
					,FundCalcMay
					,FundCalcJun
					,FundCalcJul
					,YTDCalc
					,TotalCalc
					,AugToMar
					,AprToJul 
			FROM	Report.FundingSummary_Total1924Traineeships 
			WHERE	DataSetName = 'LineTotals1924TraineeshipsFrmNov2017' 
			
			UNION
			
			SELECT	 FundCalcAug
					,FundCalcSep
					,FundCalcOct
					,FundCalcNov
					,FundCalcDec
					,FundCalcJan
					,FundCalcFeb
					,FundCalcMar
					,FundCalcApr
					,FundCalcMay
					,FundCalcJun
					,FundCalcJul
					,YTDCalc
					,TotalCalc
					,AugToMar
					,AprToJul 
			from	Report.FundingSummary_TotalAebOther 
			WHERE	DataSetName ='LineTotalsAebOtherLearningFrmNov2017'
	) AS a


	INSERT INTO [Report].[FundingSummary_LineTotalsOLASSEASCancellationCosts]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	*
	FROM
	(
			SELECT	'EAS Adult OLASS Cancellation Costs'	AS SubGroupHeader
					,1										AS SortOrder
					,'LineTotalsOLASSEASCancellationCosts'	AS DataSetName
					,* 
			FROM	dbo.GetOLASSEASCancellationCostsFunding(@CollectionPeriodInt)
	) AS a

	INSERT INTO [Report].[FundingSummary_ExceptionalLearningSupport]
	(
			 [SubGroupHeader]
			,[SortOrder]
			,[DataSetName]
			,[YTDCalc]
			,[TotalCalc]
			,[AugToMar]
			,[AprToJul]
			,[FundCalcAug]
			,[FundCalcSep]
			,[FundCalcOct]
			,[FundCalcNov]
			,[FundCalcDec]
			,[FundCalcJan]
			,[FundCalcFeb] 
			,[FundCalcMar] 
			,[FundCalcApr]
			,[FundCalcMay] 
			,[FundCalcJun]
			,[FundCalcJul]
	)
	SELECT	*
	FROM
	(
			SELECT 'EAS 16-18 Apprenticeship Frameworks Exceptional Learning Support'														AS SubGroupHeader,1  AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: 16-18 Apprenticeships',									@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Trailblazer Apprenticeships Exceptional Learning Support'														AS SubGroupHeader,2  AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: 16-18 Trailblazer Apprenticeships',						@CollectionPeriodInt) UNION
			SELECT 'EAS 19-23 Apprenticeship Frameworks Exceptional Learning Support'														AS SubGroupHeader,3  AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: 19-23 Apprenticeships',									@CollectionPeriodInt) UNION
			SELECT 'EAS 19-23 Trailblazer Apprenticeships Exceptional Learning Support'														AS SubGroupHeader,4  AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: 19-23 Trailblazer Apprenticeships',						@CollectionPeriodInt) UNION
			SELECT 'EAS 24+ Apprenticeship Frameworks Exceptional Learning Support'															AS SubGroupHeader,5  AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: 24+ Apprenticeships',										@CollectionPeriodInt) UNION
			SELECT 'EAS 24+ Trailblazer Apprenticeships Exceptional Learning Support'														AS SubGroupHeader,6  AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: 24+ Trailblazer Apprenticeships',							@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Levy Contracted Apprenticeships Exceptional Learning Support'													AS SubGroupHeader,7  AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: 16-18 Levy Apprenticeships - Provider',					@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Levy Contracted Apprenticeships Exceptional Learning Support'													AS SubGroupHeader,8  AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: Adult Levy Apprenticeships - Provider',					@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships - Non-procured delivery Exceptional Learning Support'	AS SubGroupHeader,9  AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: 16-18 Non-Levy Apprenticeships - Provider',				@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships - Non-procured delivery Exceptional Learning Support'	AS SubGroupHeader,10 AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: Adult Non-Levy Apprenticeships - Provider',				@CollectionPeriodInt) UNION
			SELECT 'EAS 16-18 Non-Levy Contracted Apprenticeships - Procured delivery Exceptional Learning Support'					AS SubGroupHeader,11 AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: 16-18 Non-Levy Apprenticeships (procured) - Provider',@CollectionPeriodInt) UNION
			SELECT 'EAS Adult Non-Levy Contracted Apprenticeships - Procured delivery Exceptional Learning Support'					AS SubGroupHeader,12 AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: Adult Non-Levy Apprenticeships (procured) - Provider',@CollectionPeriodInt) UNION
			SELECT 'EAS 19-24 Traineeships – Non-procured delivery Exceptional Learning Support'											AS SubGroupHeader,13 AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: 19-24 Traineeships',										@CollectionPeriodInt) UNION
			SELECT 'EAS AEB - Other Learning – Non-procured delivery Exceptional Learning Support'											AS SubGroupHeader,14 AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: AEB-Other Learning',										@CollectionPeriodInt) UNION
			SELECT 'EAS 19-24 Traineeships – Procured delivery from 1 Nov 2017 Exceptional Learning Support'								AS SubGroupHeader,15 AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: 19-24 Traineeships (From Nov 2017)',						@CollectionPeriodInt) UNION
			SELECT 'EAS AEB - Other Learning – Procured delivery from 1 Nov 2017 Exceptional Learning Support'								AS SubGroupHeader,16 AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: AEB-Other Learning (From Nov 2017)',						@CollectionPeriodInt) UNION
			SELECT 'EAS Advanced Loans Bursary Exceptional Learning Support'																AS SubGroupHeader,17 AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetEASFunding('Exceptional Learning Support: Advanced Learner Loans Bursary',							@CollectionPeriodInt) UNION
			SELECT 'EAS Adult OLASS Exceptional Learning Support'																			AS SubGroupHeader,18 AS SortOrder,'LineTotalsExceptionalLearningSupport' AS DataSetName, * FROM dbo.GetOLASSEASExceptionalLearningSupportFunding(@CollectionPeriodInt)
	) AS a
END

GO