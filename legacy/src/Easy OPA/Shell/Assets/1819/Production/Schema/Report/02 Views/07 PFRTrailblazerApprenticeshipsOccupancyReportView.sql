
 IF OBJECT_ID('[Report].[PFRTrailblazerApprenticeshipsOccupancyReportView]') IS NOT NULL
 BEGIN
	 DROP VIEW [Report].[PFRTrailblazerApprenticeshipsOccupancyReportView]
 END
 GO


 CREATE VIEW [Report].[PFRTrailblazerApprenticeshipsOccupancyReportView] 
 AS


 WITH
 LearningDeliveryFAM_CTE AS
 (
 SELECT
	 [LD].[LearnRefNumber]
	 ,[LD].[AimSeqNumber]
	 ,MAX([LDFAM].[LearnDelFAMCode])		AS [Learning delivery funding and monitoring type - learning support funding (highest applicable)]
	 ,MAX([LDFAM].[LearnDelFAMDateFrom])	AS [Learning delivery funding and monitoring - LSF date applies from (earliest)]
	 ,MAX([LDFAM].[LearnDelFAMDateTo])	AS [Learning delivery funding and monitoring - LSF date applies to (latest)]

 FROM
				 [Valid].[LearningDelivery] AS [LD]
	 LEFT JOIN	[Valid].[LearningDeliveryFAM] AS [LDFAM] 
	 ON			[LDFAM].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[LDFAM].[AimSeqNumber] = [LD].[AimSeqNumber]
WHERE [LD].[FundModel] = 81
 GROUP BY
	 [LD].[LearnRefNumber]
	 ,[LD].[AimSeqNumber]
	 ,[LDFAM].[LearnDelFAMType]
	 ,[LD].[ProgType]

 HAVING
	 [LDFAM].[LearnDelFAMType] = 'LSF'
 AND		[LD].[ProgType] = 25
 )
 ,
 TNP_CTE AS
 (
 SELECT
	 [LearnRefNumber]
	 ,[AimSeqNumber]
	 ,MAX(CASE WHEN [AFinCode] = 1 THEN [AFinAmount] ELSE NULL END) AS [Latest total negotiated price (TNP) 1]
	 ,MAX(CASE WHEN [AFinCode] = 2 THEN [AFinAmount] ELSE NULL END) AS [Latest total negotiated price (TNP) 2]
 FROM
 (
	 SELECT
		  [TrailblazerApprenticeshipFinancialRecordLatestDate].[LearnRefNumber]
		 ,[TrailblazerApprenticeshipFinancialRecordLatestDate].[AimSeqNumber]
		 ,[TrailblazerApprenticeshipFinancialRecordLatestDate].[AimType]
		 ,[TrailblazerApprenticeshipFinancialRecordLatestDate].[StdCode] 
		 ,[TrailblazerApprenticeshipFinancialRecordLatestDate].[AFinType]
		 ,[TrailblazerApprenticeshipFinancialRecordLatestDate].[AFinCode]
		 ,[TrailblazerApprenticeshipFinancialRecordLatestDate].[LatestDate]
		 ,[TBL_FR].[AFinAmount]
	 FROM
				 [Valid].[AppFinRecord] AS [TBL_FR]
	 INNER JOIN
	 (
		 SELECT
			  [LD].[LearnRefNumber]
			 ,[LD].[AimSeqNumber]
			 ,[LD].[AimType]
			 ,[LD].[StdCode] 
			 ,[TBL_FR].[AFinType]
			 ,[TBL_FR].[AFinCode]
			 ,MAX([TBL_FR].[AFinDate]) AS [LatestDate]
		 FROM
						 [Valid].[LearningDelivery] AS [LD]
			 INNER JOIN	[Valid].[AppFinRecord] AS [TBL_FR] 
			 ON			[TBL_FR].[LearnRefNumber] = [LD].[LearnRefNumber]
			 AND			[TBL_FR].[AimSeqNumber] = [LD].[AimSeqNumber]

		 GROUP BY
			  [LD].[LearnRefNumber]
			 ,[LD].[AimSeqNumber]
			 ,[LD].[AimType]
			 ,[LD].[StdCode] 
			 ,[TBL_FR].[AFinType]
			 ,[TBL_FR].[AFinCode]

		 HAVING
			 [TBL_FR].[AFinType] = 'TNP'
		 AND [LD].[AimType] = 1

	 ) AS [TrailblazerApprenticeshipFinancialRecordLatestDate]

	 ON	[TrailblazerApprenticeshipFinancialRecordLatestDate].[LearnRefNumber] = [TBL_FR].[LearnRefNumber]
	 AND [TrailblazerApprenticeshipFinancialRecordLatestDate].[AimSeqNumber] = [TBL_FR].[AimSeqNumber]
	 AND [TrailblazerApprenticeshipFinancialRecordLatestDate].[AFinType] = [TBL_FR].[AFinType]
	 AND [TrailblazerApprenticeshipFinancialRecordLatestDate].[AFinCode] = [TBL_FR].[AFinCode]
	 AND [TrailblazerApprenticeshipFinancialRecordLatestDate].[LatestDate] = [TBL_FR].[AFinDate]

 ) AS [TrailblazerApprenticeshipFinancialRecordAmount]

 GROUP BY
	  [LearnRefNumber]
	 ,[AimSeqNumber]
 )
 ,
 PMR_CTE AS
 (
 SELECT 
	  [LD].[LearnRefNumber]
	 ,[LD].[AimSeqNumber]

	 ,SUM(CASE WHEN [TBL_FR].[AFinCode] IN (1,2) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	< 0 THEN [TBL_FR].[AFinAmount]	ELSE 0 END) -
	  SUM(CASE WHEN [TBL_FR].[AFinCode] IN (3) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	< 0 THEN [TBL_FR].[AFinAmount] ELSE 0 END)	AS [Period_BeforeThisYear]

	 ,SUM(CASE WHEN [TBL_FR].[AFinCode] IN (1,2) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 0 THEN [TBL_FR].[AFinAmount]	ELSE 0 END) -
	  SUM(CASE WHEN [TBL_FR].[AFinCode] IN (3) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 0 THEN [TBL_FR].[AFinAmount] ELSE 0 END)	AS [Period_1]

	 ,SUM(CASE WHEN [TBL_FR].[AFinCode] IN (1,2) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 1 THEN [TBL_FR].[AFinAmount]	ELSE 0 END) -
	  SUM(CASE WHEN [TBL_FR].[AFinCode] IN (3) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 1 THEN [TBL_FR].[AFinAmount] ELSE 0 END)	AS [Period_2]

	 ,SUM(CASE WHEN [TBL_FR].[AFinCode] IN (1,2) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 2 THEN [TBL_FR].[AFinAmount]	ELSE 0 END) -
	  SUM(CASE WHEN [TBL_FR].[AFinCode] IN (3) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 2 THEN [TBL_FR].[AFinAmount] ELSE 0 END)	AS [Period_3]

	 ,SUM(CASE WHEN [TBL_FR].[AFinCode] IN (1,2) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 3 THEN [TBL_FR].[AFinAmount]	ELSE 0 END) -
	  SUM(CASE WHEN [TBL_FR].[AFinCode] IN (3) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 3 THEN [TBL_FR].[AFinAmount] ELSE 0 END)	AS [Period_4]

	 ,SUM(CASE WHEN [TBL_FR].[AFinCode] IN (1,2) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 4 THEN [TBL_FR].[AFinAmount]	ELSE 0 END) -
	  SUM(CASE WHEN [TBL_FR].[AFinCode] IN (3) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 4 THEN [TBL_FR].[AFinAmount] ELSE 0 END)	AS [Period_5]

	 ,SUM(CASE WHEN [TBL_FR].[AFinCode] IN (1,2) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 5 THEN [TBL_FR].[AFinAmount]	ELSE 0 END) -
	  SUM(CASE WHEN [TBL_FR].[AFinCode] IN (3) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 5 THEN [TBL_FR].[AFinAmount] ELSE 0 END)	AS [Period_6]

	 ,SUM(CASE WHEN [TBL_FR].[AFinCode] IN (1,2) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 6 THEN [TBL_FR].[AFinAmount]	ELSE 0 END) -
	  SUM(CASE WHEN [TBL_FR].[AFinCode] IN (3) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 6 THEN [TBL_FR].[AFinAmount] ELSE 0 END)	AS [Period_7]

	 ,SUM(CASE WHEN [TBL_FR].[AFinCode] IN (1,2) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 7 THEN [TBL_FR].[AFinAmount]	ELSE 0 END) -
	  SUM(CASE WHEN [TBL_FR].[AFinCode] IN (3) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 7 THEN [TBL_FR].[AFinAmount] ELSE 0 END)	AS [Period_8]

	 ,SUM(CASE WHEN [TBL_FR].[AFinCode] IN (1,2) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 8 THEN [TBL_FR].[AFinAmount]	ELSE 0 END) -
	  SUM(CASE WHEN [TBL_FR].[AFinCode] IN (3) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 8 THEN [TBL_FR].[AFinAmount] ELSE 0 END)	AS [Period_9]

	 ,SUM(CASE WHEN [TBL_FR].[AFinCode] IN (1,2) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 9 THEN [TBL_FR].[AFinAmount]	ELSE 0 END) -
	  SUM(CASE WHEN [TBL_FR].[AFinCode] IN (3) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 9 THEN [TBL_FR].[AFinAmount] ELSE 0 END)	AS [Period_10]

	 ,SUM(CASE WHEN [TBL_FR].[AFinCode] IN (1,2) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 10 then[TBL_FR].[AFinAmount] ELSE 0 END) -
	  SUM(CASE WHEN [TBL_FR].[AFinCode] IN (3) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 10 then[TBL_FR].[AFinAmount] ELSE 0 END)	AS [Period_11]

	 ,SUM(CASE WHEN [TBL_FR].[AFinCode] IN (1,2) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 11 then[TBL_FR].[AFinAmount] ELSE 0 END) -
	  SUM(CASE WHEN [TBL_FR].[AFinCode] IN (3) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	= 11 then[TBL_FR].[AFinAmount] ELSE 0 END)	AS [Period_12]

	 ,SUM(CASE WHEN [TBL_FR].[AFinCode] IN (1,2) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	BETWEEN 0 AND 11 then[TBL_FR].[AFinAmount] ELSE 0 END) -
	  SUM(CASE WHEN [TBL_FR].[AFinCode] IN (3) AND DATEDIFF(MONTH, CONVERT(DATE, '2017-08-01'), [TBL_FR].[AFinDate])	BETWEEN 0 AND 11 then[TBL_FR].[AFinAmount] ELSE 0 END)	AS [Period_ThisYear]
 FROM
				 [Valid].[LearningDelivery] AS [LD]
	 LEFT JOIN	[Valid].[AppFinRecord] AS [TBL_FR] 
	 ON			[TBL_FR].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[TBL_FR].[AimSeqNumber] = [LD].[AimSeqNumber]
WHERE [LD].[FundModel] = 81
 GROUP BY 
	 [LD].[LearnRefNumber]
	 ,[LD].[AimSeqNumber]
	 ,[TBL_FR].[AFinType]
	 ,[LD].[ProgType]

 HAVING
	 [TBL_FR].[AFinType] = 'PMR'
 AND	[LD].[ProgType] = 25
 )
 ,
 CoreGovContPayment_CTE AS
 (
 SELECT 
	  [LD].[LearnRefNumber]
	 ,[LD].[AimSeqNumber]
	 ,[TBL_LD_PV].[AttributeName]
	 ,[TBL_LD_PV].[Period_1]
	 ,[TBL_LD_PV].[Period_2]
	 ,[TBL_LD_PV].[Period_3]
	 ,[TBL_LD_PV].[Period_4]
	 ,[TBL_LD_PV].[Period_5]
	 ,[TBL_LD_PV].[Period_6]
	 ,[TBL_LD_PV].[Period_7]
	 ,[TBL_LD_PV].[Period_8]
	 ,[TBL_LD_PV].[Period_9]
	 ,[TBL_LD_PV].[Period_10]
	 ,[TBL_LD_PV].[Period_11]
	 ,[TBL_LD_PV].[Period_12]

 FROM
				 [Valid].[LearningDelivery] AS [LD]
	 LEFT JOIN	[Rulebase].[TBL_LearningDelivery_PeriodisedValues] AS [TBL_LD_PV] 
	 ON			[TBL_LD_PV].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[TBL_LD_PV].[AimSeqNumber] = [LD].[AimSeqNumber]
 WHERE
	 [LD].[ProgType] = 25 AND [LD].[FundModel] = 81
 AND	[TBL_LD_PV].[AttributeName] = 'CoreGovContPayment'
 )
 ,
 MathEngOnProgPayment_CTE AS
 (
 SELECT 
	  [LD].[LearnRefNumber]
	 ,[LD].[AimSeqNumber]
	 ,[TBL_LD_PV].[AttributeName]
	 ,[TBL_LD_PV].[Period_1]
	 ,[TBL_LD_PV].[Period_2]
	 ,[TBL_LD_PV].[Period_3]
	 ,[TBL_LD_PV].[Period_4]
	 ,[TBL_LD_PV].[Period_5]
	 ,[TBL_LD_PV].[Period_6]
	 ,[TBL_LD_PV].[Period_7]
	 ,[TBL_LD_PV].[Period_8]
	 ,[TBL_LD_PV].[Period_9]
	 ,[TBL_LD_PV].[Period_10]
	 ,[TBL_LD_PV].[Period_11]
	 ,[TBL_LD_PV].[Period_12]

 FROM
				 [Valid].[LearningDelivery] AS [LD]
	 LEFT JOIN	[Rulebase].[TBL_LearningDelivery_PeriodisedValues] AS [TBL_LD_PV] 
	 ON			[TBL_LD_PV].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[TBL_LD_PV].[AimSeqNumber] = [LD].[AimSeqNumber]
 WHERE
	 [LD].[ProgType] = 25 AND [LD].[FundModel] = 81
 AND	[TBL_LD_PV].[AttributeName] = 'MathEngOnProgPayment'
 )
 ,
 MathEngBalPayment_CTE AS
 (
 SELECT 
	  [LD].[LearnRefNumber]
	 ,[LD].[AimSeqNumber]
	 ,[TBL_LD_PV].[AttributeName]
	 ,[TBL_LD_PV].[Period_1]
	 ,[TBL_LD_PV].[Period_2]
	 ,[TBL_LD_PV].[Period_3]
	 ,[TBL_LD_PV].[Period_4]
	 ,[TBL_LD_PV].[Period_5]
	 ,[TBL_LD_PV].[Period_6]
	 ,[TBL_LD_PV].[Period_7]
	 ,[TBL_LD_PV].[Period_8]
	 ,[TBL_LD_PV].[Period_9]
	 ,[TBL_LD_PV].[Period_10]
	 ,[TBL_LD_PV].[Period_11]
	 ,[TBL_LD_PV].[Period_12]

 FROM
				 [Valid].[LearningDelivery] AS [LD]
	 LEFT JOIN	[Rulebase].[TBL_LearningDelivery_PeriodisedValues] AS [TBL_LD_PV] 
	 ON			[TBL_LD_PV].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[TBL_LD_PV].[AimSeqNumber] = [LD].[AimSeqNumber]
 WHERE
	 [LD].[ProgType] = 25 AND [LD].[FundModel] = 81
 AND	[TBL_LD_PV].[AttributeName] = 'MathEngBalPayment'
 )
 ,
 LearnSuppFundCash_CTE AS
 (
 SELECT 
	  [LD].[LearnRefNumber]
	 ,[LD].[AimSeqNumber]
	 ,[TBL_LD_PV].[AttributeName]
	 ,[TBL_LD_PV].[Period_1]
	 ,[TBL_LD_PV].[Period_2]
	 ,[TBL_LD_PV].[Period_3]
	 ,[TBL_LD_PV].[Period_4]
	 ,[TBL_LD_PV].[Period_5]
	 ,[TBL_LD_PV].[Period_6]
	 ,[TBL_LD_PV].[Period_7]
	 ,[TBL_LD_PV].[Period_8]
	 ,[TBL_LD_PV].[Period_9]
	 ,[TBL_LD_PV].[Period_10]
	 ,[TBL_LD_PV].[Period_11]
	 ,[TBL_LD_PV].[Period_12]

 FROM
				 [Valid].[LearningDelivery] AS [LD]
	 LEFT JOIN	[Rulebase].[TBL_LearningDelivery_PeriodisedValues] AS [TBL_LD_PV] 
	 ON			[TBL_LD_PV].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[TBL_LD_PV].[AimSeqNumber] = [LD].[AimSeqNumber]
 WHERE
	 [LD].[ProgType] = 25 AND [LD].[FundModel] = 81
 AND	[TBL_LD_PV].[AttributeName] = 'LearnSuppFundCash'
 )
 ,
 SmallBusPayment_CTE AS
 (
 SELECT 
	  [LD].[LearnRefNumber]
	 ,[LD].[AimSeqNumber]
	 ,[TBL_LD_PV].[AttributeName]
	 ,[TBL_LD_PV].[Period_1]
	 ,[TBL_LD_PV].[Period_2]
	 ,[TBL_LD_PV].[Period_3]
	 ,[TBL_LD_PV].[Period_4]
	 ,[TBL_LD_PV].[Period_5]
	 ,[TBL_LD_PV].[Period_6]
	 ,[TBL_LD_PV].[Period_7]
	 ,[TBL_LD_PV].[Period_8]
	 ,[TBL_LD_PV].[Period_9]
	 ,[TBL_LD_PV].[Period_10]
	 ,[TBL_LD_PV].[Period_11]
	 ,[TBL_LD_PV].[Period_12]

 FROM
				 [Valid].[LearningDelivery] AS [LD]
	 LEFT JOIN	[Rulebase].[TBL_LearningDelivery_PeriodisedValues] AS [TBL_LD_PV] 
	 ON			[TBL_LD_PV].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[TBL_LD_PV].[AimSeqNumber] = [LD].[AimSeqNumber]
 WHERE
	 [LD].[ProgType] = 25 AND [LD].[FundModel] = 81
 AND	[TBL_LD_PV].[AttributeName] = 'SmallBusPayment'
 )
 ,
 YoungAppPayment_CTE AS
 (
 SELECT 
	  [LD].[LearnRefNumber]
	 ,[LD].[AimSeqNumber]
	 ,[TBL_LD_PV].[AttributeName]
	 ,[TBL_LD_PV].[Period_1]
	 ,[TBL_LD_PV].[Period_2]
	 ,[TBL_LD_PV].[Period_3]
	 ,[TBL_LD_PV].[Period_4]
	 ,[TBL_LD_PV].[Period_5]
	 ,[TBL_LD_PV].[Period_6]
	 ,[TBL_LD_PV].[Period_7]
	 ,[TBL_LD_PV].[Period_8]
	 ,[TBL_LD_PV].[Period_9]
	 ,[TBL_LD_PV].[Period_10]
	 ,[TBL_LD_PV].[Period_11]
	 ,[TBL_LD_PV].[Period_12]

 FROM
				 [Valid].[LearningDelivery] AS [LD]
	 LEFT JOIN	[Rulebase].[TBL_LearningDelivery_PeriodisedValues] AS [TBL_LD_PV] 
	 ON			[TBL_LD_PV].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[TBL_LD_PV].[AimSeqNumber] = [LD].[AimSeqNumber]
 WHERE
	 [LD].[ProgType] = 25 AND [LD].[FundModel] = 81
 AND	[TBL_LD_PV].[AttributeName] = 'YoungAppPayment'
 )
 ,
 AchPayment_CTE AS
 (
 SELECT 
	  [LD].[LearnRefNumber]
	 ,[LD].[AimSeqNumber]
	 ,[TBL_LD_PV].[AttributeName]
	 ,[TBL_LD_PV].[Period_1]
	 ,[TBL_LD_PV].[Period_2]
	 ,[TBL_LD_PV].[Period_3]
	 ,[TBL_LD_PV].[Period_4]
	 ,[TBL_LD_PV].[Period_5]
	 ,[TBL_LD_PV].[Period_6]
	 ,[TBL_LD_PV].[Period_7]
	 ,[TBL_LD_PV].[Period_8]
	 ,[TBL_LD_PV].[Period_9]
	 ,[TBL_LD_PV].[Period_10]
	 ,[TBL_LD_PV].[Period_11]
	 ,[TBL_LD_PV].[Period_12]

 FROM
				 [Valid].[LearningDelivery] AS [LD]
	 LEFT JOIN	[Rulebase].[TBL_LearningDelivery_PeriodisedValues] AS [TBL_LD_PV] 
	 ON			[TBL_LD_PV].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[TBL_LD_PV].[AimSeqNumber] = [LD].[AimSeqNumber]
 WHERE
	 [LD].[ProgType] = 25  AND [LD].[FundModel] = 81
 AND	[TBL_LD_PV].[AttributeName] = 'AchPayment'
 )
 SELECT 
	 ROW_NUMBER() OVER (ORDER BY [LD].[LearnRefNumber], [LD].[AimSeqNumber]  ASC) AS [RowNumber]

	 ,[L].[LearnRefNumber]									AS [Learner reference number]
	 ,[L].[ULN]												AS [Unique learner number]
	 ,CONVERT(VARCHAR(10), [L].[DateOfBirth]	, 103)		AS [Date of birth]	
	 ,[L].[PMUKPRN]											AS [Pre-merger UKPRN]
	 ,[LDen].[ProvSpecLearnMon_A]							AS [Provider specified learner monitoring (A)]
	 ,[LDen].[ProvSpecLearnMon_B]							AS [Provider specified learner monitoring (B)]
	 ,[LD].[AimSeqNumber]									AS [Aim sequence number] 
	 ,[LD].[LearnAimRef]									AS [Learning aim reference] 
	 ,[LARS_LD].[LearnAimRefTitle]							AS [Learning aim title]
	 ,[LD].[SWSupAimID]										AS [Software supplier aim identifier]
	 ,[LARS_LD].[NotionalNVQLevelv2]						AS [Notional NVQ level] 
	 ,[LD].[AimType]										AS [Aim type] 
	 ,[LD].[StdCode]										AS [Apprenticeship standard code]
	 ,[LD].[FundModel]										AS [Funding model]
	 ,[LD].[PriorLearnFundAdj]								AS [Funding adjustment for prior learning] 
	 ,[LD].[OtherFundAdj]									AS [Other funding adjustment] 
	 ,[LD].[OrigLearnStartDate]								AS [Original learning start date] 
	 ,[LD].[LearnStartDate]									AS [Learning start date] 
	 ,[LD].[LearnPlanEndDate]								AS [Learning planned end date] 
	 ,[LD].[CompStatus]										AS [Completion status] 
	 ,[LD].[LearnActEndDate]								AS [Learning actual end date] 
	 ,[LD].[Outcome]										AS [Outcome] 
	 ,[LD].[AchDate]										AS [Achievement date]
	 ,[LDH].[LrnDelFAM_SOF]									AS [Learning delivery funding and monitoring type - source of funding]
	 ,[LDH].[LrnDelFAM_EEF]									AS [Learning delivery funding and monitoring type - eligibility for enhanced apprenticeship funding]

	 ,[LearningDeliveryFAM_CTE].[Learning delivery funding and monitoring type - learning support funding (highest applicable)]	AS [Learning delivery funding and monitoring type - learning support funding (highest applicable)]
	 ,[LearningDeliveryFAM_CTE].[Learning delivery funding and monitoring - LSF date applies from (earliest)]					AS [Learning delivery funding and monitoring - LSF date applies from (earliest)]
	 ,[LearningDeliveryFAM_CTE].[Learning delivery funding and monitoring - LSF date applies to (latest)]						AS [Learning delivery funding and monitoring - LSF date applies to (latest)]

	 ,[LDH].[LDM1]										AS [Learning delivery funding and monitoring type - learning delivery monitoring (A)]
	 ,[LDH].[LDM2]										AS [Learning delivery funding and monitoring type - learning delivery monitoring (B)]
	 ,[LDH].[LDM3]										AS [Learning delivery funding and monitoring type - learning delivery monitoring (C)]
	 ,[LDH].[LDM4]										AS [Learning delivery funding and monitoring type - learning delivery monitoring (D)]
	 ,[LDH].[LrnDelFAM_RES]								AS [Learning delivery funding and monitoring type - restart indicator]
	 ,[LDH].[ProvSpecDelMon_A]						    AS [Provider specified delivery monitoring (A)]
	 ,[LDH].[ProvSpecDelMon_B]						    AS [Provider specified delivery monitoring (B)]
	 ,[LDH].[ProvSpecDelMon_C]					    	AS [Provider specified delivery monitoring (C)]
	 ,[LDH].[ProvSpecDelMon_D]						    AS [Provider specified delivery monitoring (D)]
	 ,[LD].[EPAOrgID]										AS [End point assessment organisation]
	 ,[LD].[PartnerUKPRN]									AS [Sub contracted or partnership UKPRN]
	 ,[LD].[DelLocPostcode]									AS [Delivery location postcode]

	 ,[TBL_LD].[CoreGovContCapApplicVal]					AS [LARS maximum core government contribution]
	 ,[TBL_LD].[SmallBusApplicVal]							AS [LARS small employer incentive]
	 ,[TBL_LD].[YoungAppApplicVal]							AS [LARS 16-18 year-old apprentice incentive]
	 ,[TBL_LD].[AchievementApplicVal]						AS [LARS achievement incentive]

	 ,[TBL_LD].[ApplicFundValDate]							AS [Applicable funding value date]
	 ,[TBL_LD].[FundLine]									AS [Funding line type]
	 ,[TBL_LD].[EmpIdFirstDayStandard]						AS [Employer identifier on first day of standard]
	 ,[TBL_LD].[EmpIdSmallBusDate]							AS [Employer identifier on small employer threshold date]
	 ,[TBL_LD].[EmpIdFirstYoungAppDate]						AS [Employer identifier on first 16-18 threshold date]
	 ,[TBL_LD].[EmpIdSecondYoungAppDate]					AS [Employer identifier on second 16-18 threshold date]
	 ,[TBL_LD].[EmpIdAchDate]								AS [Employer identifier on achievement date]
	 ,[TBL_LD].[MathEngLSFFundStart]						AS [Start indicator for maths, English and learning support]
	 ,[TBL_LD].[AgeStandardStart]							AS [Age at start of standard]
	 ,[TBL_LD].[YoungAppEligible]							AS [Eligible for 16-18 year-old apprentice incentive]
	 ,[TBL_LD].[SmallBusEligible]							AS [Eligible for small employer incentive]
	 ,[TBL_LD].[AchApplicDate]								AS [Applicable achievement date]

 -------------------------------------------------------------------------------
 -- Latest Totals
 -------------------------------------------------------------------------------

	 ,[TNP_CTE].[Latest total negotiated price (TNP) 1]	AS [Latest total negotiated price (TNP) 1]
	 ,[TNP_CTE].[Latest total negotiated price (TNP) 2]	AS [Latest total negotiated price (TNP) 2]

 -------------------------------------------------------------------------------
 -- Previous Year Totals
 -------------------------------------------------------------------------------

	 ,[PMR_CTE].[Period_BeforeThisYear]					AS [Sum of PMRs before this funding year]

 -------------------------------------------------------------------------------
 -- August
 -------------------------------------------------------------------------------

	 ,[PMR_CTE].[Period_1]						AS [Sum of August payment records (PMRs)]

	 ,[CoreGovContPayment_CTE].[Period_1]		AS [August core government contribution]
	 ,[MathEngOnProgPayment_CTE].[Period_1]		AS [August maths and English on-programme earned cash]
	 ,[MathEngBalPayment_CTE].[Period_1]			AS [August maths and English balancing earned cash]
	 ,[LearnSuppFundCash_CTE].[Period_1]			AS [August learning support earned cash]
	 ,[SmallBusPayment_CTE].[Period_1]			AS [August small employer incentive]
	 ,[YoungAppPayment_CTE].[Period_1]			AS [August 16-18 year-old apprentice incentive]
	 ,[AchPayment_CTE].[Period_1]				AS [August achievement incentive]

 -------------------------------------------------------------------------------
 -- September
 -------------------------------------------------------------------------------

	 ,[PMR_CTE].[Period_2]						AS [Sum of September payment records (PMRs)]

	 ,[CoreGovContPayment_CTE].[Period_2]		AS [September core government contribution]
	 ,[MathEngOnProgPayment_CTE].[Period_2]		AS [September maths and English on-programme earned cash]
	 ,[MathEngBalPayment_CTE].[Period_2]			AS [September maths and English balancing earned cash]
	 ,[LearnSuppFundCash_CTE].[Period_2]			AS [September learning support earned cash]
	 ,[SmallBusPayment_CTE].[Period_2]			AS [September small employer incentive]
	 ,[YoungAppPayment_CTE].[Period_2]			AS [September 16-18 year-old apprentice incentive]
	 ,[AchPayment_CTE].[Period_2]				AS [September achievement incentive]

 -------------------------------------------------------------------------------
 -- October
 -------------------------------------------------------------------------------

	 ,[PMR_CTE].[Period_3]						AS [Sum of October payment records (PMRs)]

	 ,[CoreGovContPayment_CTE].[Period_3]		AS [October core government contribution]
	 ,[MathEngOnProgPayment_CTE].[Period_3]		AS [October maths and English on-programme earned cash]
	 ,[MathEngBalPayment_CTE].[Period_3]			AS [October maths and English balancing earned cash]
	 ,[LearnSuppFundCash_CTE].[Period_3]			AS [October learning support earned cash]
	 ,[SmallBusPayment_CTE].[Period_3]			AS [October small employer incentive]
	 ,[YoungAppPayment_CTE].[Period_3]			AS [October 16-18 year-old apprentice incentive]
	 ,[AchPayment_CTE].[Period_3]				AS [October achievement incentive]

 -------------------------------------------------------------------------------
 -- November
 -------------------------------------------------------------------------------

	 ,[PMR_CTE].[Period_4]						AS [Sum of November payment records (PMRs)]

	 ,[CoreGovContPayment_CTE].[Period_4]		AS [November core government contribution]
	 ,[MathEngOnProgPayment_CTE].[Period_4]		AS [November maths and English on-programme earned cash]
	 ,[MathEngBalPayment_CTE].[Period_4]			AS [November maths and English balancing earned cash]
	 ,[LearnSuppFundCash_CTE].[Period_4]			AS [November learning support earned cash]
	 ,[SmallBusPayment_CTE].[Period_4]			AS [November small employer incentive]
	 ,[YoungAppPayment_CTE].[Period_4]			AS [November 16-18 year-old apprentice incentive]
	 ,[AchPayment_CTE].[Period_4]				AS [November achievement incentive]

 -------------------------------------------------------------------------------
 -- December
 -------------------------------------------------------------------------------

	 ,[PMR_CTE].[Period_5]						AS [Sum of December payment records (PMRs)]

	 ,[CoreGovContPayment_CTE].[Period_5]		AS [December core government contribution]
	 ,[MathEngOnProgPayment_CTE].[Period_5]		AS [December maths and English on-programme earned cash]
	 ,[MathEngBalPayment_CTE].[Period_5]			AS [December maths and English balancing earned cash]
	 ,[LearnSuppFundCash_CTE].[Period_5]			AS [December learning support earned cash]
	 ,[SmallBusPayment_CTE].[Period_5]			AS [December small employer incentive]
	 ,[YoungAppPayment_CTE].[Period_5]			AS [December 16-18 year-old apprentice incentive]
	 ,[AchPayment_CTE].[Period_5]				AS [December achievement incentive]

 -------------------------------------------------------------------------------
 -- January
 -------------------------------------------------------------------------------

	 ,[PMR_CTE].[Period_6]						AS [Sum of January payment records (PMRs)]

	 ,[CoreGovContPayment_CTE].[Period_6]		AS [January core government contribution]
	 ,[MathEngOnProgPayment_CTE].[Period_6]		AS [January maths and English on-programme earned cash]
	 ,[MathEngBalPayment_CTE].[Period_6]			AS [January maths and English balancing earned cash]
	 ,[LearnSuppFundCash_CTE].[Period_6]			AS [January learning support earned cash]
	 ,[SmallBusPayment_CTE].[Period_6]			AS [January small employer incentive]
	 ,[YoungAppPayment_CTE].[Period_6]			AS [January 16-18 year-old apprentice incentive]
	 ,[AchPayment_CTE].[Period_6]				AS [January achievement incentive]

 -------------------------------------------------------------------------------
 -- February
 -------------------------------------------------------------------------------

	 ,[PMR_CTE].[Period_7]						AS [Sum of February payment records (PMRs)]

	 ,[CoreGovContPayment_CTE].[Period_7]		AS [February core government contribution]
	 ,[MathEngOnProgPayment_CTE].[Period_7]		AS [February maths and English on-programme earned cash]
	 ,[MathEngBalPayment_CTE].[Period_7]			AS [February maths and English balancing earned cash]
	 ,[LearnSuppFundCash_CTE].[Period_7]			AS [February learning support earned cash]
	 ,[SmallBusPayment_CTE].[Period_7]			AS [February small employer incentive]
	 ,[YoungAppPayment_CTE].[Period_7]			AS [February 16-18 year-old apprentice incentive]
	 ,[AchPayment_CTE].[Period_7]				AS [February achievement incentive]

 -------------------------------------------------------------------------------
 -- March
 -------------------------------------------------------------------------------

	 ,[PMR_CTE].[Period_8]						AS [Sum of March payment records (PMRs)]

	 ,[CoreGovContPayment_CTE].[Period_8]		AS [March core government contribution]
	 ,[MathEngOnProgPayment_CTE].[Period_8]		AS [March maths and English on-programme earned cash]
	 ,[MathEngBalPayment_CTE].[Period_8]			AS [March maths and English balancing earned cash]
	 ,[LearnSuppFundCash_CTE].[Period_8]			AS [March learning support earned cash]
	 ,[SmallBusPayment_CTE].[Period_8]			AS [March small employer incentive]
	 ,[YoungAppPayment_CTE].[Period_8]			AS [March 16-18 year-old apprentice incentive]
	 ,[AchPayment_CTE].[Period_8]				AS [March achievement incentive]

 -------------------------------------------------------------------------------
 -- April
 -------------------------------------------------------------------------------

	 ,[PMR_CTE].[Period_9]						AS [Sum of April payment records (PMRs)]

	 ,[CoreGovContPayment_CTE].[Period_9]		AS [April core government contribution]
	 ,[MathEngOnProgPayment_CTE].[Period_9]		AS [April maths and English on-programme earned cash]
	 ,[MathEngBalPayment_CTE].[Period_9]			AS [April maths and English balancing earned cash]
	 ,[LearnSuppFundCash_CTE].[Period_9]			AS [April learning support earned cash]
	 ,[SmallBusPayment_CTE].[Period_9]			AS [April small employer incentive]
	 ,[YoungAppPayment_CTE].[Period_9]			AS [April 16-18 year-old apprentice incentive]
	 ,[AchPayment_CTE].[Period_9]				AS [April achievement incentive]

 -------------------------------------------------------------------------------
 -- May
 -------------------------------------------------------------------------------

	 ,[PMR_CTE].[Period_10]						AS [Sum of May payment records (PMRs)]

	 ,[CoreGovContPayment_CTE].[Period_10]		AS [May core government contribution]
	 ,[MathEngOnProgPayment_CTE].[Period_10]		AS [May maths and English on-programme earned cash]
	 ,[MathEngBalPayment_CTE].[Period_10]		AS [May maths and English balancing earned cash]
	 ,[LearnSuppFundCash_CTE].[Period_10]		AS [May learning support earned cash]
	 ,[SmallBusPayment_CTE].[Period_10]			AS [May small employer incentive]
	 ,[YoungAppPayment_CTE].[Period_10]			AS [May 16-18 year-old apprentice incentive]
	 ,[AchPayment_CTE].[Period_10]				AS [May achievement incentive]

 -------------------------------------------------------------------------------
 -- June
 -------------------------------------------------------------------------------

	 ,[PMR_CTE].[Period_11]						AS [Sum of June payment records (PMRs)]

	 ,[CoreGovContPayment_CTE].[Period_11]		AS [June core government contribution]
	 ,[MathEngOnProgPayment_CTE].[Period_11]		AS [June maths and English on-programme earned cash]
	 ,[MathEngBalPayment_CTE].[Period_11]		AS [June maths and English balancing earned cash]
	 ,[LearnSuppFundCash_CTE].[Period_11]		AS [June learning support earned cash]
	 ,[SmallBusPayment_CTE].[Period_11]			AS [June small employer incentive]
	 ,[YoungAppPayment_CTE].[Period_11]			AS [June 16-18 year-old apprentice incentive]
	 ,[AchPayment_CTE].[Period_11]				AS [June achievement incentive]

 -------------------------------------------------------------------------------
 -- July
 -------------------------------------------------------------------------------

	 ,[PMR_CTE].[Period_12]						AS [Sum of July payment records (PMRs)]

	 ,[CoreGovContPayment_CTE].[Period_12]		AS [July core government contribution]
	 ,[MathEngOnProgPayment_CTE].[Period_12]		AS [July maths and English on-programme earned cash]
	 ,[MathEngBalPayment_CTE].[Period_12]		AS [July maths and English balancing earned cash]
	 ,[LearnSuppFundCash_CTE].[Period_12]		AS [July learning support earned cash]
	 ,[SmallBusPayment_CTE].[Period_12]			AS [July small employer incentive]
	 ,[YoungAppPayment_CTE].[Period_12]			AS [July 16-18 year-old apprentice incentive]
	 ,[AchPayment_CTE].[Period_12]				AS [July achievement incentive]

 -------------------------------------------------------------------------------
 -- This Year Totals
 -------------------------------------------------------------------------------

	 ,[PMR_CTE].[Period_ThisYear]				AS [Total payment records (PMRs) for this funding year]

	 ,[CoreGovContPayment_CTE].[Period_1] + 
	  [CoreGovContPayment_CTE].[Period_2] + 
	  [CoreGovContPayment_CTE].[Period_3] + 
	  [CoreGovContPayment_CTE].[Period_4] + 
	  [CoreGovContPayment_CTE].[Period_5] + 
	  [CoreGovContPayment_CTE].[Period_6] + 
	  [CoreGovContPayment_CTE].[Period_7] + 
	  [CoreGovContPayment_CTE].[Period_8] + 
	  [CoreGovContPayment_CTE].[Period_9] + 
	  [CoreGovContPayment_CTE].[Period_10] + 
	  [CoreGovContPayment_CTE].[Period_11] + 
	  [CoreGovContPayment_CTE].[Period_12]		AS [Total core government contribution]

	 ,[MathEngOnProgPayment_CTE].[Period_1] + 
	  [MathEngOnProgPayment_CTE].[Period_2] + 
	  [MathEngOnProgPayment_CTE].[Period_3] + 
	  [MathEngOnProgPayment_CTE].[Period_4] + 
	  [MathEngOnProgPayment_CTE].[Period_5] + 
	  [MathEngOnProgPayment_CTE].[Period_6] + 
	  [MathEngOnProgPayment_CTE].[Period_7] + 
	  [MathEngOnProgPayment_CTE].[Period_8] + 
	  [MathEngOnProgPayment_CTE].[Period_9] + 
	  [MathEngOnProgPayment_CTE].[Period_10] + 
	  [MathEngOnProgPayment_CTE].[Period_11] + 
	  [MathEngOnProgPayment_CTE].[Period_12]		AS [Total maths and English on-programme earned cash]

	 ,[MathEngBalPayment_CTE].[Period_1] + 
	  [MathEngBalPayment_CTE].[Period_2] + 
	  [MathEngBalPayment_CTE].[Period_3] + 
	  [MathEngBalPayment_CTE].[Period_4] + 
	  [MathEngBalPayment_CTE].[Period_5] + 
	  [MathEngBalPayment_CTE].[Period_6] + 
	  [MathEngBalPayment_CTE].[Period_7] + 
	  [MathEngBalPayment_CTE].[Period_8] + 
	  [MathEngBalPayment_CTE].[Period_9] + 
	  [MathEngBalPayment_CTE].[Period_10] + 
	  [MathEngBalPayment_CTE].[Period_11] + 
	  [MathEngBalPayment_CTE].[Period_12]		AS [Total maths and English balancing earned cash]

	 ,[LearnSuppFundCash_CTE].[Period_1] + 
	  [LearnSuppFundCash_CTE].[Period_2] + 
	  [LearnSuppFundCash_CTE].[Period_3] + 
	  [LearnSuppFundCash_CTE].[Period_4] + 
	  [LearnSuppFundCash_CTE].[Period_5] + 
	  [LearnSuppFundCash_CTE].[Period_6] + 
	  [LearnSuppFundCash_CTE].[Period_7] + 
	  [LearnSuppFundCash_CTE].[Period_8] + 
	  [LearnSuppFundCash_CTE].[Period_9] + 
	  [LearnSuppFundCash_CTE].[Period_10] + 
	  [LearnSuppFundCash_CTE].[Period_11] + 
	  [LearnSuppFundCash_CTE].[Period_12]		AS [Total learning support earned cash]

	 ,[SmallBusPayment_CTE].[Period_1] + 
	  [SmallBusPayment_CTE].[Period_2] + 
	  [SmallBusPayment_CTE].[Period_3] + 
	  [SmallBusPayment_CTE].[Period_4] + 
	  [SmallBusPayment_CTE].[Period_5] + 
	  [SmallBusPayment_CTE].[Period_6] + 
	  [SmallBusPayment_CTE].[Period_7] + 
	  [SmallBusPayment_CTE].[Period_8] + 
	  [SmallBusPayment_CTE].[Period_9] + 
	  [SmallBusPayment_CTE].[Period_10] + 
	  [SmallBusPayment_CTE].[Period_11] + 
	  [SmallBusPayment_CTE].[Period_12]			AS [Total small employer incentive]

	 ,[YoungAppPayment_CTE].[Period_1] + 
	  [YoungAppPayment_CTE].[Period_2] + 
	  [YoungAppPayment_CTE].[Period_3] + 
	  [YoungAppPayment_CTE].[Period_4] + 
	  [YoungAppPayment_CTE].[Period_5] + 
	  [YoungAppPayment_CTE].[Period_6] + 
	  [YoungAppPayment_CTE].[Period_7] + 
	  [YoungAppPayment_CTE].[Period_8] + 
	  [YoungAppPayment_CTE].[Period_9] + 
	  [YoungAppPayment_CTE].[Period_10] + 
	  [YoungAppPayment_CTE].[Period_11] + 
	  [YoungAppPayment_CTE].[Period_12]			AS [Total 16-18 year-old apprentice incentive]

	 ,[AchPayment_CTE].[Period_1] + 
	  [AchPayment_CTE].[Period_2] + 
	  [AchPayment_CTE].[Period_3] + 
	  [AchPayment_CTE].[Period_4] + 
	  [AchPayment_CTE].[Period_5] + 
	  [AchPayment_CTE].[Period_6] + 
	  [AchPayment_CTE].[Period_7] + 
	  [AchPayment_CTE].[Period_8] + 
	  [AchPayment_CTE].[Period_9] + 
	  [AchPayment_CTE].[Period_10] + 
	  [AchPayment_CTE].[Period_11] + 
	  [AchPayment_CTE].[Period_12]				AS [Total achievement incentive]

	 ,'OFFICIAL - SENSITIVE'						AS [OFFICIAL - SENSITIVE]

 FROM
				 [Valid].[LearningDelivery] AS [LD]
	 LEFT JOIN	Reference.[LARS_LearningDelivery] AS [LARS_LD] --[${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_LearningDelivery] AS [LARS_LD] 
	 ON			[LARS_LD].[LearnAimRef] = [LD].[LearnAimRef]

	 LEFT JOIN	[Valid].[Learner] AS [L] 
	 ON			[L].[LearnRefNumber] = [LD].[LearnRefNumber]

	 LEFT JOIN	[Valid].[LearnerDenorm] AS [LDen] 
	 ON			[LDen].[LearnRefNumber] = [L].[LearnRefNumber]

	 LEFT JOIN	[Rulebase].[TBL_LearningDelivery] AS [TBL_LD] 
	 ON			[TBL_LD].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[TBL_LD].[AimSeqNumber] = [LD].[AimSeqNumber]

	 LEFT JOIN	[Report].[PFRTrailblazerApprenticeshipsOccupancyReport_PSDM_FAM_HelperView] AS [LDH] 
	 ON			[LDH].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[LDH].[AimSeqNumber] = [LD].[AimSeqNumber]

	 LEFT JOIN	[CoreGovContPayment_CTE]
	 ON			[CoreGovContPayment_CTE].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[CoreGovContPayment_CTE].[AimSeqNumber] = [LD].[AimSeqNumber]

	 LEFT JOIN	[MathEngOnProgPayment_CTE]
	 ON			[MathEngOnProgPayment_CTE].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[MathEngOnProgPayment_CTE].[AimSeqNumber] = [LD].[AimSeqNumber]

	 LEFT JOIN	[MathEngBalPayment_CTE]
	 ON			[MathEngBalPayment_CTE].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[MathEngBalPayment_CTE].[AimSeqNumber] = [LD].[AimSeqNumber]

	 LEFT JOIN	[LearnSuppFundCash_CTE]
	 ON			[LearnSuppFundCash_CTE].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[LearnSuppFundCash_CTE].[AimSeqNumber] = [LD].[AimSeqNumber]

	 LEFT JOIN	[SmallBusPayment_CTE]
	 ON			[SmallBusPayment_CTE].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[SmallBusPayment_CTE].[AimSeqNumber] = [LD].[AimSeqNumber]

	 LEFT JOIN	[YoungAppPayment_CTE]
	 ON			[YoungAppPayment_CTE].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[YoungAppPayment_CTE].[AimSeqNumber] = [LD].[AimSeqNumber]

	 LEFT JOIN	[AchPayment_CTE]
	 ON			[AchPayment_CTE].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[AchPayment_CTE].[AimSeqNumber] = [LD].[AimSeqNumber]

	 LEFT JOIN	[LearningDeliveryFAM_CTE]
	 ON			[LearningDeliveryFAM_CTE].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[LearningDeliveryFAM_CTE].[AimSeqNumber] = [LD].[AimSeqNumber]

	 LEFT JOIN	[TNP_CTE] 
	 ON			[TNP_CTE].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[TNP_CTE].[AimSeqNumber] = [LD].[AimSeqNumber]

	 LEFT JOIN	[PMR_CTE] 
	 ON			[PMR_CTE].[LearnRefNumber] = [LD].[LearnRefNumber]
	 AND			[PMR_CTE].[AimSeqNumber] = [LD].[AimSeqNumber]

 WHERE
	 [LD].[ProgType] = 25  AND [LD].[FundModel] = 81
