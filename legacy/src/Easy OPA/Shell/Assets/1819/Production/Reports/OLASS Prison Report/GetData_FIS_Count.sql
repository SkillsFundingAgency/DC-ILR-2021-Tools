DECLARE @ProviderUKPRN BIGINT = (SELECT UKPRN FROM Valid.LearningProvider)

--ILR
SELECT
	COUNT(*)
FROM 
(
SELECT
	ORDUL.UoPName 'Unit of Procurement'
	,ODPL.PrisonName 'Prison'
	,[Funding Type] 'Funding Type'
	,'ILR' 'ILR/EAS'
	,SUM(Period_1) 'Period_1'
	,SUM(Period_2) 'Period_2'
	,SUM(Period_3) 'Period_3'
	,SUM(Period_4) 'Period_4'
	,SUM(Period_5) 'Period_5'
	,SUM(Period_6) 'Period_6'
	,SUM(Period_7) 'Period_7'
	,SUM(Period_8) 'Period_8'
	,SUM(Period_9) 'Period_9'
	,SUM(Period_10) 'Period_10'
	,SUM(Period_11) 'Period_11'
	,SUM(Period_12) 'Period_12'
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