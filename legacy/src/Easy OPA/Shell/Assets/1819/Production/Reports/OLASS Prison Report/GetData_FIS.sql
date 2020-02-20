DECLARE @ProviderUKPRN BIGINT = (SELECT UKPRN FROM Valid.LearningProvider)

--ILR
SELECT
	[Unit of Procurement]
	,[Prison]
	,[Funding Type]
	,[ILR/EAS]
	,[Period_1] 'Aug-15'
	,[Period_2] 'Sep-15'
	,[Period_3] 'Oct-15'
	,[Period_4] 'Nov-15'
	,[Period_5] 'Dec-15'
	,[Period_6] 'Jan-16'
	,[Period_7] 'Feb-16'
	,[Period_8] 'Mar-16'
	,[Period_9] 'Apr-16'
	,[Period_10] 'May-16'
	,[Period_11] 'Jun-16'
	,[Period_12] 'Jul-16'
	,'OFFICIAL-SENSITIVE' 'Security Classification'
FROM 
(
SELECT
	ORDUL.UoPName 'Unit of Procurement'
	,ODPL.PrisonName 'Prison'
	,[Funding Type] 'Funding Type'
	,'ILR' 'ILR/EAS'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2015-08-01' AND OCOHU.EffectiveTo IS NULL THEN Period_1
				WHEN OCOHU.EffectiveFrom <= '2015-08-01' AND OCOHU.EffectiveTo >= '2015-08-31' THEN Period_1
				ELSE 0 END) 'Period_1'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2015-09-01' AND OCOHU.EffectiveTo IS NULL THEN Period_2
				WHEN OCOHU.EffectiveFrom <= '2015-09-01' AND OCOHU.EffectiveTo >= '2015-09-30' THEN Period_2
				ELSE 0 END) 'Period_2'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2015-10-01' AND OCOHU.EffectiveTo IS NULL THEN Period_3
				WHEN OCOHU.EffectiveFrom <= '2015-10-01' AND OCOHU.EffectiveTo >= '2015-10-31' THEN Period_3
				ELSE 0 END) 'Period_3'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2015-11-01' AND OCOHU.EffectiveTo IS NULL THEN Period_4
				WHEN OCOHU.EffectiveFrom <= '2015-11-01' AND OCOHU.EffectiveTo >= '2015-11-30' THEN Period_4
				ELSE 0 END) 'Period_4'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2015-12-01' AND OCOHU.EffectiveTo IS NULL THEN Period_5
				WHEN OCOHU.EffectiveFrom <= '2015-12-01' AND OCOHU.EffectiveTo >= '2015-12-31' THEN Period_5
				ELSE 0 END) 'Period_5'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2016-01-01' AND OCOHU.EffectiveTo IS NULL THEN Period_6
				WHEN OCOHU.EffectiveFrom <= '2016-01-01' AND OCOHU.EffectiveTo >= '2016-01-31' THEN Period_6
				ELSE 0 END) 'Period_6'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2016-02-01' AND OCOHU.EffectiveTo IS NULL THEN Period_7
				WHEN OCOHU.EffectiveFrom <= '2016-02-01' AND OCOHU.EffectiveTo >= '2016-02-29' THEN Period_7
				ELSE 0 END) 'Period_7'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2016-03-01' AND OCOHU.EffectiveTo IS NULL THEN Period_8
				WHEN OCOHU.EffectiveFrom <= '2016-03-01' AND OCOHU.EffectiveTo >= '2016-03-31' THEN Period_8
				ELSE 0 END) 'Period_8'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2016-04-01' AND OCOHU.EffectiveTo IS NULL THEN Period_9
				WHEN OCOHU.EffectiveFrom <= '2016-04-01' AND OCOHU.EffectiveTo >= '2016-04-30' THEN Period_9
				ELSE 0 END) 'Period_9'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2016-05-01' AND OCOHU.EffectiveTo IS NULL THEN Period_10
				WHEN OCOHU.EffectiveFrom <= '2016-05-01' AND OCOHU.EffectiveTo >= '2016-05-31' THEN Period_10
				ELSE 0 END) 'Period_10'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2016-06-01' AND OCOHU.EffectiveTo IS NULL THEN Period_11
				WHEN OCOHU.EffectiveFrom <= '2016-06-01' AND OCOHU.EffectiveTo >= '2016-06-30' THEN Period_11
				ELSE 0 END) 'Period_11'
	,SUM(CASE WHEN OCOHU.EffectiveFrom <= '2016-07-01' AND OCOHU.EffectiveTo IS NULL THEN Period_12
				WHEN OCOHU.EffectiveFrom <= '2016-07-01' AND OCOHU.EffectiveTo >= '2016-07-31' THEN Period_12
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
	FROM Rulebase.SFA_LearningDelivery LD
	INNER JOIN Valid.LearningDelivery VLD
		ON LD.AimSeqNumber = VLD.AimSeqNumber AND LD.LearnRefNumber = VLD.LearnRefNumber
	INNER JOIN Rulebase.SFA_LearningDelivery_PeriodisedValues LDPV
		ON LD.AimSeqNumber = LDPV.AimSeqNumber AND LD.LearnRefNumber = LDPV.LearnRefNumber
	WHERE FundLine = 'Adult OLASS' AND LDPV.AttributeName IN ('OnProgPayment', 'BalancePayment', 'AchievePayment', 'EmpOutcomePay', 'LearnSuppFundCash')
	GROUP BY LDPV.AttributeName, VLD.DelLocPostCode) ResultTable
INNER JOIN [${ORG.FullyQualified}].[${ORG.Schemaname}].[Org_HMPP_PostCode] OCOHP
	ON OCOHP.HMPPPostCode = ResultTable.DelLocPostCode
INNER JOIN [${ORG.FullyQualified}].[${ORG.Schemaname}].[Org_HMPP_UOP] OCOHU
	ON OCOHP.UKPRN = OCOHU.UKPRN
INNER JOIN [Static].[UoPLookup] ORDUL
	ON ORDUL.UoPCode = OCOHU.UOPCode
INNER JOIN [Static].[PrisonLookup] ODPL
	ON ODPL.Postcode = OCOHP.HMPPPostCode
GROUP BY [Funding Type], ORDUL.UoPName, ODPL.PrisonName) tbl
ORDER BY tbl.[Unit of Procurement] ASC, tbl.Prison ASC, tbl.[ILR/EAS] DESC, tbl.[Funding Type] ASC