
IF OBJECT_ID('[Report].[ESFAimsAndDeliverablesReportView_NonDeliverableRows]') IS NOT  NULL
BEGIN
	DROP VIEW  [Report].[ESFAimsAndDeliverablesReportView_NonDeliverableRows]
END
GO

CREATE VIEW [Report].[ESFAimsAndDeliverablesReportView_NonDeliverableRows] AS





SELECT 
	DISTINCT vl.[LearnRefNumber] AS 'Learner reference number', 
	vl.[ULN] AS 'Unique learner number',  
	vld.[AimSeqNumber] AS 'Aim sequence number', 
	vld.[ConRefNumber] AS 'Contract reference number', 
	eld.[DeliverableCode] AS 'Deliverable code', 
	dcm.[DeliverableName] AS 'Deliverable name',  
	vld.[LearnAimRef] AS 'Learning aim reference', 
	eld.[DeliverableUnitCost] AS 'Unit cost', 
	CAST(el.[ApplicWeightFundRate] AS decimal(9,2)) AS 'Funding rate LARS plus ESOL hours', 
	CAST(el.[AimValue] AS DECIMAL(9,2)) AS 'Aim value', 
	lld.LearnaimRefTitle AS 'Learning aim title', 
	vl.[PMUKPRN] AS 'Pre-merger UKPRN',
	vl.[ProvSpecLearnMon_A] AS 'Provider specified learner monitoring (A)', 
	vl.[ProvSpecLearnMon_B] AS 'Provider specified learner monitoring (B)',  
	vld.[SWSupAimId] AS 'Software supplier aim identifier', 
	lld.NotionalNVQLevelv2 AS 'Notional NVQ level', 
	lld.SectorSubjectAreaTier2 AS 'Tier 2 sector subject area', 
	el.[AdjustedAreaCostFactor] AS 'Area uplift', 
	el.[AdjustedPremiumFactor] AS 'Learning rate premium', 
	vld.[LearnStartDate] AS 'Learning start date', 
	el.[LDESFEngagementStartDate] AS 'Learning start date of first assessment', 
	vld.[LearnPlanEndDate] AS 'Learning planned end date', 
	vld.[CompStatus] AS 'Completion status', 
	vld.[LearnActEndDate] AS 'Learning actual end date', 
	vld.[Outcome] AS 'Outcome', 
	vld.[AddHours] AS 'Additional delivery hours', 
	vld.[LDFAM_RES] AS 'Learning delivery funding and monitoring type restart indicator',  
	vld.[ProvSpecDelMon_A] AS 'Provider specified delivery monitoring (A)', 
	vld.[ProvSpecDelMon_B] AS 'Provider specified delivery monitoring (B)', 
	vld.[ProvSpecDelMon_C] AS 'Provider specified delivery monitoring (C)', 
	vld.[ProvSpecDelMon_D] AS 'Provider specified delivery monitoring (D)', 
	vld.[PartnerUKPRN] AS 'Sub contracted or partnership UKPRN', 
	vld.[DelLocPostCode] AS 'Delivery location postcode', 
	el.[LatestPossibleStartDate] AS 'Latest possible progression start date', 
	el.[EligibleProgressionOutomeStartDate] AS 'Eligible outcome start date', 
	dpo.OutEndDate  AS 'Eligible outcome end date',  
	dpo.OutCollDate AS 'Eligible outcome collection date',
	edpo.OutcomeDateForProgression  AS 'Eligible outcome date used for progression length', 
	el.[EligibleProgressionOutcomeType] AS 'Eligible outcome type', 
	el.[EligibleProgressionOutcomeCode] AS 'Eligible outcome code', 
	ISNULL(CAST(NULL AS CHAR(18)), '') AS 'Month', 
	NULL  AS 'Deliverable volume',
	NULL  AS 'Reporting volume',
	ISNULL(CAST(NULL AS CHAR(18)), '') AS 'Start earnings',
	ISNULL(CAST(NULL AS CHAR(18)), '') AS 'Achievement earnings', 
	ISNULL(CAST(NULL AS CHAR(18)), '') AS 'Additional programme cost earnings', 
	ISNULL(CAST(NULL AS CHAR(18)), '') AS 'Progression earnings', 
    NULL AS 'Total earnings',
	NULL AS 'OFFICIAL-SENSITIVE'

	FROM [Valid].[LearnerDenorm] vl

	INNER JOIN [Valid].[LearningDeliveryDenorm] vld 
		ON vl.LearnRefNumber = vld.LearnRefNumber
		AND vld.[FundModel] = 70

	INNER JOIN [Rulebase].[ESF_LearningDelivery] el 
		ON vl.LearnRefNumber = el.LearnRefNumber 
		AND vld.[AimSeqNumber] = el.[AimSeqNumber]

	LEFT JOIN [Rulebase].[ESF_LearningDeliveryDeliverable] eld
		ON vl.[LearnRefNumber] = eld.[LearnRefNumber] 
		AND vld.[AimSeqNumber] = eld.[AimSeqNumber]

	LEFT JOIN [Valid].[DPOutcome] dpo --for Eligible outcome end date
		ON dpo.OutType=el.EligibleProgressionOutcomeType 
		AND dpo.OutCode=el.EligibleProgressionOutcomeCode 
		AND dpo.OutStartDate=el.EligibleProgressionOutomeStartDate
		AND dpo.LearnRefNumber = vl.LearnRefNumber

	LEFT JOIN [Rulebase].[ESF_DPOutcome] edpo --for Eligible outcome date used for progression length
		ON edpo.[OutType] = el.[EligibleProgressionOutcomeType] 
		AND edpo.OutCode = el.EligibleProgressionOutcomeCode 
		AND edpo.[OutStartDate] = el.EligibleProgressionOutomeStartDate 
		AND edpo.LearnRefNumber = vl.LearnRefNumber

	LEFT JOIN [Reference].[DeliverableCodeMappings] dcm
		ON eld.[DeliverableCode] = dcm.[ExternalDeliverableCode]
		AND dcm.FundingStreamPeriodCode = 'ESF1420'

	LEFT JOIN [Rulebase].[ESF_LearningDeliveryDeliverable_Period] eldp
		ON vl.LearnRefNumber = eldp.LearnRefNumber 
		AND vld.AimSeqNumber = eldp.AimSeqNumber 
		AND eld.deliverablecode = eldp.deliverablecode

	INNER JOIN [Reference].[LARS_LearningDelivery] lld 
		ON lld.LearnAimRef = vld.LearnAimRef

	LEFT JOIN  [Report].[ESFAimsAndDeliverablesReportView_DeliverableRows] dr 
	ON vl.LearnRefNumber = dr.[Learner reference number] 
	AND vld.AimSeqNumber = dr.[Aim sequence number]

	WHERE dr.[Learner reference number] is null



GO

