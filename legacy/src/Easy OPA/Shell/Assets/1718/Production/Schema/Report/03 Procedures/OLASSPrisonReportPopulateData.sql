IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[OLASSPrisonReportPopulateData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[OLASSPrisonReportPopulateData]
GO

CREATE PROCEDURE [Report].[OLASSPrisonReportPopulateData]	
AS
BEGIN	
	
	TRUNCATE TABLE [Report].[OLASSPrisonReport]

	DECLARE @ProviderUKPRN BIGINT = (SELECT UKPRN FROM Valid.LearningProvider)

DECLARE @FundingTypes TABLE
(
	FundingType NVARCHAR(250)
)

INSERT INTO @FundingTypes
VALUES ('Adult OLASS Programme Funding'), ('Adult OLASS Learning Support')

DECLARE @DummyLines TABLE
(
	UnitOfProcurement NVARCHAR(250)
	,PrisonName NVARCHAR(250)
	,FundingType NVARCHAR(50)
)

INSERT INTO @DummyLines
SELECT 
	UOPL.UoPName
	,PRIL.PrisonName
	,FundingType
FROM [${OLASSReference.FullyQualified}].[dbo].[UoPLookup] UOPL
INNER JOIN [${ORG.FullyQualified}].[${ORG.Schemaname}].[Org_HMPP_UOP] OCOHU
	ON UOPL.UoPCode = OCOHU.UOPCode
INNER JOIN [${ORG.FullyQualified}].[${ORG.Schemaname}].[Org_HMPP_PostCode] OCOHP
	ON OCOHP.UKPRN = OCOHU.UKPRN
INNER JOIN [${OLASSReference.FullyQualified}].[dbo].[PrisonLookup] PRIL
	ON OCOHP.HMPPPostCode = PRIL.Postcode
,@FundingTypes
WHERE UOPL.UOPCode IN
(
	SELECT DISTINCT ORDUL.UoPCode FROM [Valid].[LearningDelivery]
	INNER JOIN [${ORG.FullyQualified}].[${ORG.Schemaname}].[Org_HMPP_PostCode] OCOHP
		ON OCOHP.HMPPPostCode = DelLocPostCode
	INNER JOIN [${ORG.FullyQualified}].[${ORG.Schemaname}].[Org_HMPP_UOP] OCOHU
		ON OCOHP.UKPRN = OCOHU.UKPRN
	INNER JOIN [${OLASSReference.FullyQualified}].[dbo].[UoPLookup] ORDUL
		ON ORDUL.UoPCode = OCOHU.UOPCode
)

--ILR
INSERT INTO [Report].[OLASSPrisonReport]
           ([Unit of Procurement]
           ,[Prison]
           ,[Funding Type]
           ,[ILR/EAS]
           ,[Aug-16]
           ,[Sep-16]
           ,[Oct-16]
           ,[Nov-16]
           ,[Dec-16]
           ,[Jan-17]
           ,[Feb-17]
           ,[Mar-17]
           ,[Apr-17]
           ,[May-17]
           ,[Jun-17]
           ,[Jul-17]
           ,[Security Classification])
SELECT
	[Unit of Procurement]
	,[Prison]
	,[Funding Type]
	,[ILR/EAS]
	,[Period_1] 'Aug-16'
	,[Period_2] 'Sep-16'
	,[Period_3] 'Oct-16'
	,[Period_4] 'Nov-16'
	,[Period_5] 'Dec-16'
	,[Period_6] 'Jan-17'
	,[Period_7] 'Feb-17'
	,[Period_8] 'Mar-17'
	,[Period_9] 'Apr-17'
	,[Period_10] 'May-17'
	,[Period_11] 'Jun-17'
	,[Period_12] 'Jul-17'
	,'OFFICIAL-SENSITIVE' 'Security Classification'
FROM 
(
SELECT
	DL.UnitOfProcurement 'Unit of Procurement'
	,DL.PrisonName 'Prison'
	,DL.FundingType 'Funding Type'
	,'ILR' 'ILR/EAS'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2016-08-01' AND OCOHU.EffectiveTo IS NULL THEN Period_1
				WHEN OCOHU.EffectiveFrom <= '2016-08-01' AND OCOHU.EffectiveTo >= '2016-08-31' THEN Period_1
				ELSE 0 END) 'Period_1'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2016-09-01' AND OCOHU.EffectiveTo IS NULL THEN Period_2
				WHEN OCOHU.EffectiveFrom <= '2016-09-01' AND OCOHU.EffectiveTo >= '2016-09-30' THEN Period_2
				ELSE 0 END) 'Period_2'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2016-10-01' AND OCOHU.EffectiveTo IS NULL THEN Period_3
				WHEN OCOHU.EffectiveFrom <= '2016-10-01' AND OCOHU.EffectiveTo >= '2016-10-31' THEN Period_3
				ELSE 0 END) 'Period_3'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2016-11-01' AND OCOHU.EffectiveTo IS NULL THEN Period_4
				WHEN OCOHU.EffectiveFrom <= '2016-11-01' AND OCOHU.EffectiveTo >= '2016-11-30' THEN Period_4
				ELSE 0 END) 'Period_4'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2016-12-01' AND OCOHU.EffectiveTo IS NULL THEN Period_5
				WHEN OCOHU.EffectiveFrom <= '2016-12-01' AND OCOHU.EffectiveTo >= '2016-12-31' THEN Period_5
				ELSE 0 END) 'Period_5'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2017-01-01' AND OCOHU.EffectiveTo IS NULL THEN Period_6
				WHEN OCOHU.EffectiveFrom <= '2017-01-01' AND OCOHU.EffectiveTo >= '2017-01-31' THEN Period_6
				ELSE 0 END) 'Period_6'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2017-02-01' AND OCOHU.EffectiveTo IS NULL THEN Period_7
				WHEN OCOHU.EffectiveFrom <= '2017-02-01' AND OCOHU.EffectiveTo >= '2017-02-28' THEN Period_7
				ELSE 0 END) 'Period_7'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2017-03-01' AND OCOHU.EffectiveTo IS NULL THEN Period_8
				WHEN OCOHU.EffectiveFrom <= '2017-03-01' AND OCOHU.EffectiveTo >= '2017-03-31' THEN Period_8
				ELSE 0 END) 'Period_8'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2017-04-01' AND OCOHU.EffectiveTo IS NULL THEN Period_9
				WHEN OCOHU.EffectiveFrom <= '2017-04-01' AND OCOHU.EffectiveTo >= '2017-04-30' THEN Period_9
				ELSE 0 END) 'Period_9'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2017-05-01' AND OCOHU.EffectiveTo IS NULL THEN Period_10
				WHEN OCOHU.EffectiveFrom <= '2017-05-01' AND OCOHU.EffectiveTo >= '2017-05-31' THEN Period_10
				ELSE 0 END) 'Period_10'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2017-06-01' AND OCOHU.EffectiveTo IS NULL THEN Period_11
				WHEN OCOHU.EffectiveFrom <= '2017-06-01' AND OCOHU.EffectiveTo >= '2017-06-30' THEN Period_11
				ELSE 0 END) 'Period_11'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2017-07-01' AND OCOHU.EffectiveTo IS NULL THEN Period_12
				WHEN OCOHU.EffectiveFrom <= '2017-07-01' AND OCOHU.EffectiveTo >= '2017-07-31' THEN Period_12
				ELSE 0 END) 'Period_12'
FROM
	(SELECT
		VLD.DelLocPostCode
		,CASE WHEN AttributeName IN ('OnProgPayment', 'BalancePayment', 'AchievePayment', 'EmpOutcomePay') THEN 'Adult OLASS Programme Funding'
			 WHEN AttributeName = 'LearnSuppFundCash' THEN 'Adult OLASS Learning Support' END 'Funding Type'
		,SUM(CASE WHEN AttributeName IN ('OnProgPayment', 'BalancePayment', 'AchievePayment', 'EmpOutcomePay', 'LearnSuppFundCash') THEN Period_1 ELSE 0 END) 'Period_1'
		,SUM(CASE WHEN AttributeName IN ('OnProgPayment', 'BalancePayment', 'AchievePayment', 'EmpOutcomePay', 'LearnSuppFundCash') THEN Period_2 ELSE 0 END) 'Period_2'
		,SUM(CASE WHEN AttributeName IN ('OnProgPayment', 'BalancePayment', 'AchievePayment', 'EmpOutcomePay', 'LearnSuppFundCash') THEN Period_3 ELSE 0 END) 'Period_3'
		,SUM(CASE WHEN AttributeName IN ('OnProgPayment', 'BalancePayment', 'AchievePayment', 'EmpOutcomePay', 'LearnSuppFundCash') THEN Period_4 ELSE 0 END) 'Period_4'
		,SUM(CASE WHEN AttributeName IN ('OnProgPayment', 'BalancePayment', 'AchievePayment', 'EmpOutcomePay', 'LearnSuppFundCash') THEN Period_5 ELSE 0 END) 'Period_5'
		,SUM(CASE WHEN AttributeName IN ('OnProgPayment', 'BalancePayment', 'AchievePayment', 'EmpOutcomePay', 'LearnSuppFundCash') THEN Period_6 ELSE 0 END) 'Period_6'
		,SUM(CASE WHEN AttributeName IN ('OnProgPayment', 'BalancePayment', 'AchievePayment', 'EmpOutcomePay', 'LearnSuppFundCash') THEN Period_7 ELSE 0 END) 'Period_7'
		,SUM(CASE WHEN AttributeName IN ('OnProgPayment', 'BalancePayment', 'AchievePayment', 'EmpOutcomePay', 'LearnSuppFundCash') THEN Period_8 ELSE 0 END) 'Period_8'
		,SUM(CASE WHEN AttributeName IN ('OnProgPayment', 'BalancePayment', 'AchievePayment', 'EmpOutcomePay', 'LearnSuppFundCash') THEN Period_9 ELSE 0 END) 'Period_9'
		,SUM(CASE WHEN AttributeName IN ('OnProgPayment', 'BalancePayment', 'AchievePayment', 'EmpOutcomePay', 'LearnSuppFundCash') THEN Period_10 ELSE 0 END) 'Period_10'
		,SUM(CASE WHEN AttributeName IN ('OnProgPayment', 'BalancePayment', 'AchievePayment', 'EmpOutcomePay', 'LearnSuppFundCash') THEN Period_11 ELSE 0 END) 'Period_11'
		,SUM(CASE WHEN AttributeName IN ('OnProgPayment', 'BalancePayment', 'AchievePayment', 'EmpOutcomePay', 'LearnSuppFundCash') THEN Period_12 ELSE 0 END) 'Period_12'
	FROM [Valid].[LearningDelivery] VLD
	LEFT OUTER JOIN [Rulebase].[SFA_LearningDelivery] LD
		ON LD.AimSeqNumber = VLD.AimSeqNumber AND LD.LearnRefNumber = VLD.LearnRefNumber
	LEFT OUTER JOIN Rulebase.SFA_LearningDelivery_PeriodisedValues LDPV
		ON LD.AimSeqNumber = LDPV.AimSeqNumber AND LD.LearnRefNumber = LDPV.LearnRefNumber
	WHERE FundLine = 'Adult OLASS' AND LDPV.AttributeName IN ('OnProgPayment', 'BalancePayment', 'AchievePayment', 'EmpOutcomePay', 'LearnSuppFundCash')
	GROUP BY LDPV.AttributeName, VLD.DelLocPostCode) ResultTable
INNER JOIN [${ORG.FullyQualified}].[${ORG.Schemaname}].[Org_HMPP_PostCode] OCOHP
	ON OCOHP.HMPPPostCode = ResultTable.DelLocPostCode
INNER JOIN [${ORG.FullyQualified}].[${ORG.Schemaname}].[Org_HMPP_UOP] OCOHU
	ON OCOHP.UKPRN = OCOHU.UKPRN
INNER JOIN [${OLASSReference.FullyQualified}].[dbo].[UoPLookup] ORDUL
	ON ORDUL.UoPCode = OCOHU.UOPCode
INNER JOIN [${OLASSReference.FullyQualified}].[dbo].[PrisonLookup] ODPL
	ON ODPL.Postcode = OCOHP.HMPPPostCode
RIGHT OUTER JOIN @DummyLines DL
	ON DL.PrisonName = ODPL.PrisonName AND DL.UnitOfProcurement = ORDUL.UoPName AND [Funding Type] = DL.FundingType
GROUP BY DL.FundingType, DL.UnitOfProcurement, DL.PrisonName

UNION ALL
--OLASS
SELECT 
	UnitOfProcurementName 'Unit Of Procurement'
	,PrisonName
	,[Funding Type]
	,'EAS' 'ILR/EAS'
	,CAST(ISNULL([1], 0) AS DECIMAL(38,5)) 'Period_1'
	,CAST(ISNULL([2], 0) AS DECIMAL(38,5)) 'Period_2'
	,CAST(ISNULL([3], 0) AS DECIMAL(38,5)) 'Period_3'
	,CAST(ISNULL([4], 0) AS DECIMAL(38,5)) 'Period_4'
	,CAST(ISNULL([5], 0) AS DECIMAL(38,5)) 'Period_5'
	,CAST(ISNULL([6], 0) AS DECIMAL(38,5)) 'Period_6'
	,CAST(ISNULL([7], 0) AS DECIMAL(38,5)) 'Period_7'
	,CAST(ISNULL([8], 0) AS DECIMAL(38,5)) 'Period_8'
	,CAST(ISNULL([9], 0) AS DECIMAL(38,5)) 'Period_9'
	,CAST(ISNULL([10], 0) AS DECIMAL(38,5)) 'Period_10'
	,CAST(ISNULL([11], 0) AS DECIMAL(38,5)) 'Period_11'
	,CAST(ISNULL([12], 0) AS DECIMAL(38,5)) 'Period_12'
FROM
(
SELECT
	UnitOfProcurementName
	,PrisonName
	,sv.CollectionPeriod
	,'Adult OLASS Excess Learning Support' 'Funding Type'
	,ExcessLearningSupport 'Value'
FROM [${OLASSEAS.FullyQualified}].[dbo].[OLASS_Submission_Values] sv
INNER JOIN [${OLASSEAS.FullyQualified}].[dbo].[OLASS_Submission] s
	ON s.Submission_Id = sv.Submission_Id AND s.CollectionPeriod = sv.CollectionPeriod
	AND s.UKPRN = @ProviderUKPRN
UNION ALL
SELECT
	UnitOfProcurementName
	,PrisonName
	,sv.CollectionPeriod
	,'Adult OLASS Exceptional Learning Support' 'Funding Type'
	,ExceptionalLearningSupport 'Value'
FROM [${OLASSEAS.FullyQualified}].[dbo].[OLASS_Submission_Values] sv
INNER JOIN [${OLASSEAS.FullyQualified}].[dbo].[OLASS_Submission] s
	ON s.Submission_Id = sv.Submission_Id AND s.CollectionPeriod = sv.CollectionPeriod
	AND s.UKPRN = @ProviderUKPRN
UNION ALL
SELECT
	UnitOfProcurementName
	,PrisonName
	,sv.CollectionPeriod
	,'Adult OLASS Audit Adjustments' 'Funding Type'
	,AuditAdjustments 'Value'
FROM [${OLASSEAS.FullyQualified}].[dbo].[OLASS_Submission_Values] sv
INNER JOIN [${OLASSEAS.FullyQualified}].[dbo].[OLASS_Submission] s
	ON s.Submission_Id = sv.Submission_Id AND s.CollectionPeriod = sv.CollectionPeriod
	AND s.UKPRN = @ProviderUKPRN
UNION ALL
SELECT
	UnitOfProcurementName
	,PrisonName
	,sv.CollectionPeriod
	,'Adult OLASS Authorised Claims' 'Funding Type'
	,AuthorisedClaims 'Value'
FROM [${OLASSEAS.FullyQualified}].[dbo].[OLASS_Submission_Values] sv
INNER JOIN [${OLASSEAS.FullyQualified}].[dbo].[OLASS_Submission] s
	ON s.Submission_Id = sv.Submission_Id AND s.CollectionPeriod = sv.CollectionPeriod
	AND s.UKPRN = @ProviderUKPRN
UNION ALL
SELECT
	UnitOfProcurementName
	,PrisonName
	,sv.CollectionPeriod
	,'Adult OLASS Cancellation Costs' 'Funding Type'
	,CancellationCosts 'Value'
FROM [${OLASSEAS.FullyQualified}].[dbo].[OLASS_Submission_Values] sv
INNER JOIN [${OLASSEAS.FullyQualified}].[dbo].[OLASS_Submission] s
	ON s.Submission_Id = sv.Submission_Id AND s.CollectionPeriod = sv.CollectionPeriod
	AND s.UKPRN = @ProviderUKPRN
) p
PIVOT
(
	SUM(Value)
	FOR CollectionPeriod IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
) AS pvt) tbl
ORDER BY tbl.[Unit of Procurement] ASC, tbl.Prison ASC, tbl.[ILR/EAS] DESC, tbl.[Funding Type] ASC
	

END