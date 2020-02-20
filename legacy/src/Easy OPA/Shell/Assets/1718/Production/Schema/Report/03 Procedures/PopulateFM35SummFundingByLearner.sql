IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[PopulateFM35SummFundingByLearner]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[PopulateFM35SummFundingByLearner]
GO

CREATE PROCEDURE [Report].[PopulateFM35SummFundingByLearner]
AS
BEGIN
	DECLARE @UKPRN BIGINT = (SELECT TOP 1 [UKPRN] FROM [Valid].[LearningProvider])

	-- Clear previous report data - needed by FIS
	TRUNCATE TABLE [Report].[FM35SummFundingByLearner]

	-- Populate [Report] schema table
	INSERT INTO [Report].[FM35SummFundingByLearner]
		SELECT DISTINCT
			@UKPRN,
			l.LearnRefNumber,
			l.FamilyName,
			l.GivenNames,
			A.ProvSpecLearnMon as ProvSpecMon_A,
			B.ProvSpecLearnMon as ProvSpecMon_B,
			SUM (sfaldpv.Period_1 + sfaldpv.Period_2 + sfaldpv.Period_3 + sfaldpv.Period_4 + sfaldpv.Period_5 + sfaldpv.Period_6 + sfaldpv.Period_7 + sfaldpv.Period_8 + sfaldpv.Period_9 + sfaldpv.Period_10 + sfaldpv.Period_11 + sfaldpv.Period_12), 
			'',
			sfald.FundLine,
			ld.DelLocPostCode
		FROM [Valid].[Source] s, [Valid].[Learner] l
			LEFT JOIN [Valid].[ProviderSpecLearnerMonitoring] A ON l.LearnRefNumber = A.LearnRefNumber and A.ProvSpecLearnMonOccur = 'A'
			LEFT JOIN [Valid].[ProviderSpecLearnerMonitoring] B ON l.LearnRefNumber = B.LearnRefNumber and B.ProvSpecLearnMonOccur = 'B'
			LEFT JOIN [Valid].[LearningDelivery] ld ON ld.LearnRefNumber = l.LearnRefNumber
			LEFT JOIN [Rulebase].[SFA_LearningDelivery_PeriodisedValues] sfaldpv ON sfaldpv.LearnRefNumber = ld.LearnRefNumber 
				AND sfaldpv.AimSeqNumber = ld.AimSeqNumber 
				AND sfaldpv.AttributeName IN ('OnProgPayment', 'BalancePayment', 'EmpOutcomePay', 'AchievePayment', 'LearnSuppFundCash')
			LEFT JOIN [Rulebase].[SFA_LearningDelivery] sfald ON sfald.LearnRefNumber = ld.LearnRefNumber 
				AND	sfald.AimSeqNumber = ld.AimSeqNumber
		WHERE ld.FundModel = 35 
		GROUP BY l.LearnRefNumber, l.FamilyName, l.GivenNames, A.ProvSpecLearnMon, B.ProvSpecLearnMon, sfald.FundLine, ld.DelLocPostCode
END
GO