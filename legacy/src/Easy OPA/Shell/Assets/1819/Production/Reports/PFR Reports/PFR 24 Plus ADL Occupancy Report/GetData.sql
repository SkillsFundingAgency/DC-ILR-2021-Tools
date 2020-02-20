--DECLARE @Page int = 1;
--DECLARE @PageSize int = 10000;
SELECT 
	[Learner reference number],[Unique learner number],[Date of birth],Postcode	,[Provider specified learner monitoring (A)]	,[Provider specified learner monitoring (B)]
	,[Aim sequence number] 	,[Learning aim reference] 	,[Learning aim title]	,[Software supplier aim identifier]	,[Applicable funding rate]	,[Applicable programme weighting]
	,[Notional NVQ level] 	,[Tier 2 sector subject area] 	,[Course type]	,[Max number years]	,[Last permitted payment date]	,[Aim type] 	,[Funding model]	,[Funding adjustment for prior learning] 
	,[Other funding adjustment]     ,[Original learning start date]     ,[Learning start date]     ,[Learning planned end date]     ,[Completion status]     ,[Learning actual end date] 
	,[Outcome]     ,[Learning delivery funding and monitoring type - 24+ Advanced Learning Loans indicator]    ,[Learning delivery funding and monitoring type - 24+ Advanced Learning Loans Bursary funding]
	,[Learning delivery funding and monitoring - ALB date applies from]    ,[Learning delivery funding and monitoring - ALB date applies to]    ,[Learning delivery funding and monitoring type - special projects and pilots]
	,[Learning delivery funding and monitoring type - learning delivery monitoring (A)]	,[Learning delivery funding and monitoring type - Learning delivery monitoring (B)]
	,[Learning delivery funding and monitoring type - Learning delivery monitoring (C)]	,[Learning delivery funding and monitoring type - Learning delivery monitoring (D)]
	,[Provider specified delivery monitoring (A)]	,[Provider specified delivery monitoring (B)]	,[Provider specified delivery monitoring (C)]	,[Provider specified delivery monitoring (D)]
	,[Sub contracted or partnership UKPRN]    ,[Delivery location postcode]	,[Area uplift]	,[Funding line type]	,[First liability date]	,[Planned number of instalments]
	,[August ALB code used]    ,[August ALB support payment earned cash]	,[August loans bursary for area costs on programme earned cash]	,[August loans bursary for area costs balancing earned cash]
	,[August loans bursary total earned cash]	, [September ALB Code used]    ,[September ALB support payment earned cash]	,[September loans bursary for area costs on programme earned cash]
	,[September loans bursary for area costs balancing earned cash]	,[September loans bursary total earned cash]	,[October ALB Code used]    ,[October ALB support payment earned cash]
	,[October loans bursary for area costs on programme earned cash]	,[October loans bursary for area costs balancing earned cash]	,[October loans bursary total earned cash]
	,[November ALB Code used]    ,[November ALB support payment earned cash]	 ,[November loans bursary for area costs on programme earned cash]	,[November loans bursary for area costs balancing earned cash]
	,[November loans bursary total earned cash]	,[December ALB Code used]     ,[December ALB support payment earned cash]	, [December loans bursary for area costs on programme earned cash]
	,[December loans bursary for area costs balancing earned cash]	, [December loans bursary total earned cash],	[January ALB Code used] ,    [January ALB support payment earned cash]
	, [January loans bursary for area costs on programme earned cash]	 ,[January loans bursary for area costs balancing earned cash]	 ,[January loans bursary total earned cash]
	,[February ALB Code used]     ,[February ALB support payment earned cash]	 ,[February loans bursary for area costs on programme earned cash]	 ,[February loans bursary for area costs balancing earned cash]
	,[February loans bursary total earned cash]	 ,[March ALB Code used]     ,[March ALB support payment earned cash]	 ,[March loans bursary for area costs on programme earned cash]	,[March loans bursary for area costs balancing earned cash]
	,[March loans bursary total earned cash]	,[April ALB Code used]     ,[April ALB support payment earned cash]	 ,[April loans bursary for area costs on programme earned cash]
	,[April loans bursary for area costs balancing earned cash]	, [April loans bursary total earned cash]	 ,[May ALB Code used]     ,[May ALB support payment earned cash]	 ,[May loans bursary for area costs on programme earned cash]
	,[May loans bursary for area costs balancing earned cash]	 ,[May loans bursary total earned cash],	[June ALB Code used] ,    [June ALB support payment earned cash]	, [June loans bursary for area costs on programme earned cash]
	,[June loans bursary for area costs balancing earned cash]	 ,[June loans bursary total earned cash]	,[July ALB Code used]    ,[July ALB support payment earned cash]	, [July loans bursary for area costs on programme earned cash]
	, [July loans bursary for area costs balancing earned cash]	, [July loans bursary total earned cash],	 [Total ALB support payment earned cash],	 [Total loans bursary for area costs on programme earned cash]
	,	 [Total loans bursary for area costs balancing earned cash],	 [Total earned cash],	 [Security Classification]
FROM
(
SELECT 
	ROW_NUMBER() OVER (ORDER BY  [Learner reference number], [Learning aim reference]) AS [RowNumber],
	[Learner reference number],[Unique learner number],[Date of birth],Postcode	,[Provider specified learner monitoring (A)]	,[Provider specified learner monitoring (B)]
	,[Aim sequence number] 	,[Learning aim reference] 	,[Learning aim title]	,[Software supplier aim identifier]	,[Applicable funding rate]	,[Applicable programme weighting]
	,[Notional NVQ level] 	,[Tier 2 sector subject area] 	,[Course type]	,[Max number years]	,[Last permitted payment date]	,[Aim type] 	,[Funding model]	,[Funding adjustment for prior learning] 
	,[Other funding adjustment]     ,[Original learning start date]     ,[Learning start date]     ,[Learning planned end date]     ,[Completion status]     ,[Learning actual end date] 
	,[Outcome]     ,[Learning delivery funding and monitoring type - 24+ Advanced Learning Loans indicator]    ,[Learning delivery funding and monitoring type - 24+ Advanced Learning Loans Bursary funding]
	,[Learning delivery funding and monitoring - ALB date applies from]    ,[Learning delivery funding and monitoring - ALB date applies to]    ,[Learning delivery funding and monitoring type - special projects and pilots]
	,[Learning delivery funding and monitoring type - learning delivery monitoring (A)]	,[Learning delivery funding and monitoring type - Learning delivery monitoring (B)]
	,[Learning delivery funding and monitoring type - Learning delivery monitoring (C)]	,[Learning delivery funding and monitoring type - Learning delivery monitoring (D)]
	,[Provider specified delivery monitoring (A)]	,[Provider specified delivery monitoring (B)]	,[Provider specified delivery monitoring (C)]	,[Provider specified delivery monitoring (D)]
	,[Sub contracted or partnership UKPRN]    ,[Delivery location postcode]	,[Area uplift]	,[Funding line type]	,[First liability date]	,[Planned number of instalments]
	,[August ALB code used]    ,[August ALB support payment earned cash]	,[August loans bursary for area costs on programme earned cash]	,[August loans bursary for area costs balancing earned cash]
	,[August loans bursary total earned cash]	, [September ALB Code used]    ,[September ALB support payment earned cash]	,[September loans bursary for area costs on programme earned cash]
	,[September loans bursary for area costs balancing earned cash]	,[September loans bursary total earned cash]	,[October ALB Code used]    ,[October ALB support payment earned cash]
	,[October loans bursary for area costs on programme earned cash]	,[October loans bursary for area costs balancing earned cash]	,[October loans bursary total earned cash]
	,[November ALB Code used]    ,[November ALB support payment earned cash]	 ,[November loans bursary for area costs on programme earned cash]	,[November loans bursary for area costs balancing earned cash]
	,[November loans bursary total earned cash]	,[December ALB Code used]     ,[December ALB support payment earned cash]	, [December loans bursary for area costs on programme earned cash]
	,[December loans bursary for area costs balancing earned cash]	, [December loans bursary total earned cash],	[January ALB Code used] ,    [January ALB support payment earned cash]
	, [January loans bursary for area costs on programme earned cash]	 ,[January loans bursary for area costs balancing earned cash]	 ,[January loans bursary total earned cash]
	,[February ALB Code used]     ,[February ALB support payment earned cash]	 ,[February loans bursary for area costs on programme earned cash]	 ,[February loans bursary for area costs balancing earned cash]
	,[February loans bursary total earned cash]	 ,[March ALB Code used]     ,[March ALB support payment earned cash]	 ,[March loans bursary for area costs on programme earned cash]	,[March loans bursary for area costs balancing earned cash]
	,[March loans bursary total earned cash]	,[April ALB Code used]     ,[April ALB support payment earned cash]	 ,[April loans bursary for area costs on programme earned cash]
	,[April loans bursary for area costs balancing earned cash]	, [April loans bursary total earned cash]	 ,[May ALB Code used]     ,[May ALB support payment earned cash]	 ,[May loans bursary for area costs on programme earned cash]
	,[May loans bursary for area costs balancing earned cash]	 ,[May loans bursary total earned cash],	[June ALB Code used] ,    [June ALB support payment earned cash]	, [June loans bursary for area costs on programme earned cash]
	,[June loans bursary for area costs balancing earned cash]	 ,[June loans bursary total earned cash]	,[July ALB Code used]    ,[July ALB support payment earned cash]	, [July loans bursary for area costs on programme earned cash]
	, [July loans bursary for area costs balancing earned cash]	, [July loans bursary total earned cash],	 [Total ALB support payment earned cash],	 [Total loans bursary for area costs on programme earned cash]
	,	 [Total loans bursary for area costs balancing earned cash],	 [Total earned cash],	 [Security Classification]
FROM
(
SELECT DISTINCT
	[L].[LearnRefNumber]									AS [Learner reference number]
    ,[L].[ULN]												AS [Unique learner number]
	,CONVERT(VARCHAR(10), [L].[DateOfBirth]	, 103)			AS [Date of birth]							
	,[L].[HomePostCode]										AS Postcode
	,[L].[ProvSpecMon_A]								AS [Provider specified learner monitoring (A)]
	,[L].[ProvSpecMon_B]								AS [Provider specified learner monitoring (B)]
    ,[LD].[AimSeqNumber]									AS [Aim sequence number] 
	,[LD].[LearnAimRef]										AS [Learning aim reference] 
	,[LARS].[LearnAimRefTitle]								AS [Learning aim title]
	,[LD].[SWSupAimID]										AS [Software supplier aim identifier]
	,[ALB_LD].[WeightedRate]								AS [Applicable funding rate]
	,[ALB_LD].[ApplicProgWeightFact]						AS [Applicable programme weighting]
	,[LARS].[NotionalNVQLevelv2]							AS [Notional NVQ level] 
	,[LARS].[SectorSubjectAreaTier2]						AS [Tier 2 sector subject area] 
	,[ALB_LD].[CourseType]									AS [Course type]
	,[ALB_LD].[MaxNumYears]									AS [Max number years]
	,[ALB_LD].[ALBPaymentEndDate]							AS [Last permitted payment date]
	,[LD].[AimType]											AS [Aim type] 
	,[LD].[FundModel]										AS [Funding model]
	,[LD].[PriorLearnFundAdj]								AS [Funding adjustment for prior learning] 
	,[LD].[OtherFundAdj]									AS [Other funding adjustment] 
    ,[LD].[OrigLearnStartDate]								AS [Original learning start date] 
    ,[LD].[LearnStartDate]									AS [Learning start date] 
    ,[LD].[LearnPlanEndDate]								AS [Learning planned end date] 
    ,[LD].[CompStatus]										AS [Completion status] 
    ,[LD].[LearnActEndDate]									AS [Learning actual end date] 
    ,[LD].[Outcome]											AS [Outcome] 
    ,[LD].[LrnDelFAM_ADL]									AS [Learning delivery funding and monitoring type - 24+ Advanced Learning Loans indicator]
    ,(SELECT MAX ([LDFAM].[LearnDelFAMCode]) WHERE LDFAM.LearnDelFAMType = 'ALB')				AS [Learning delivery funding and monitoring type - 24+ Advanced Learning Loans Bursary funding]
    ,(SELECT MIN([LDFAM].[LearnDelFAMDateFrom]) WHERE LDFAM.LearnDelFAMType = 'ALB')			AS [Learning delivery funding and monitoring - ALB date applies from]
    ,(SELECT MAX([LDFAM].[LearnDelFAMDateTo]) WHERE LDFAM.LearnDelFAMType = 'ALB')							AS [Learning delivery funding and monitoring - ALB date applies to]
    ,[LD].[LrnDelFAM_SPP]									AS [Learning delivery funding and monitoring type - special projects and pilots]
	,[LD].[LrnDelFAM_LDM1]									AS [Learning delivery funding and monitoring type - learning delivery monitoring (A)]
	,[LD].[LrnDelFAM_LDM2]									AS [Learning delivery funding and monitoring type - Learning delivery monitoring (B)]
	,[LD].[LrnDelFAM_LDM3]									AS [Learning delivery funding and monitoring type - Learning delivery monitoring (C)]
	,[LD].[LrnDelFAM_LDM4]									AS [Learning delivery funding and monitoring type - Learning delivery monitoring (D)]
	,[LD].[ProvSpecMon_A]								AS [Provider specified delivery monitoring (A)]
	,[LD].[ProvSpecMon_B]								AS [Provider specified delivery monitoring (B)]
	,[LD].[ProvSpecMon_C]								AS [Provider specified delivery monitoring (C)]
	,[LD].[ProvSpecMon_D]								AS [Provider specified delivery monitoring (D)]
	,[LD].[PartnerUKPRN]									AS [Sub contracted or partnership UKPRN]
    ,[LD].[DelLocPostcode]									AS [Delivery location postcode]
	,[ALB_LD].[AreaCostFactAdj]								AS [Area uplift]
	,[ALB_LD].[FundLine]									AS [Funding line type]
	,[ALB_LD].[LiabilityDate]									AS [First liability date]
	,[ALB_LD].[PlannedNumOnProgInstalm]							AS [Planned number of instalments]

	,[ALB_LD_PV1].[Period_1]								AS [August ALB code used]
    ,[ALB_LD_PV2].[Period_1]								AS [August ALB support payment earned cash]
	,[ALB_LD_PV3].[Period_1]								AS [August loans bursary for area costs on programme earned cash]
	,[ALB_LD_PV4].[Period_1]								AS [August loans bursary for area costs balancing earned cash]
	,[ALB_LD_PV2].[Period_1] +
	 [ALB_LD_PV3].[Period_1] +
	 [ALB_LD_PV4].[Period_1]								AS [August loans bursary total earned cash]

	,[ALB_LD_PV1].[Period_2]								AS [September ALB Code used]
    ,[ALB_LD_PV2].[Period_2]								AS [September ALB support payment earned cash]
	,[ALB_LD_PV3].[Period_2]								AS [September loans bursary for area costs on programme earned cash]
	,[ALB_LD_PV4].[Period_2]								AS [September loans bursary for area costs balancing earned cash]
	,[ALB_LD_PV2].[Period_2] +
	 [ALB_LD_PV3].[Period_2] +
	 [ALB_LD_PV4].[Period_2]								AS [September loans bursary total earned cash]

	,[ALB_LD_PV1].[Period_3]								AS [October ALB Code used]
    ,[ALB_LD_PV2].[Period_3]								AS [October ALB support payment earned cash]
	,[ALB_LD_PV3].[Period_3]								AS [October loans bursary for area costs on programme earned cash]
	,[ALB_LD_PV4].[Period_3]								AS [October loans bursary for area costs balancing earned cash]
	,[ALB_LD_PV2].[Period_3] +
	 [ALB_LD_PV3].[Period_3] +
	 [ALB_LD_PV4].[Period_3]								AS [October loans bursary total earned cash]

	,[ALB_LD_PV1].[Period_4]								AS [November ALB Code used]
    ,[ALB_LD_PV2].[Period_4]								AS [November ALB support payment earned cash]
	,[ALB_LD_PV3].[Period_4]								AS [November loans bursary for area costs on programme earned cash]
	,[ALB_LD_PV4].[Period_4]								AS [November loans bursary for area costs balancing earned cash]
	,[ALB_LD_PV2].[Period_4] +
	 [ALB_LD_PV3].[Period_4] +
	 [ALB_LD_PV4].[Period_4]								AS [November loans bursary total earned cash]

	,[ALB_LD_PV1].[Period_5]								AS [December ALB Code used]
    ,[ALB_LD_PV2].[Period_5]								AS [December ALB support payment earned cash]
	,[ALB_LD_PV3].[Period_5]								AS [December loans bursary for area costs on programme earned cash]
	,[ALB_LD_PV4].[Period_5]								AS [December loans bursary for area costs balancing earned cash]
	,[ALB_LD_PV2].[Period_5] +
	 [ALB_LD_PV3].[Period_5] +
	 [ALB_LD_PV4].[Period_5]								AS [December loans bursary total earned cash]

	,[ALB_LD_PV1].[Period_6]								AS [January ALB Code used]
    ,[ALB_LD_PV2].[Period_6]								AS [January ALB support payment earned cash]
	,[ALB_LD_PV3].[Period_6]								AS [January loans bursary for area costs on programme earned cash]
	,[ALB_LD_PV4].[Period_6]								AS [January loans bursary for area costs balancing earned cash]
	,[ALB_LD_PV2].[Period_6] +
	 [ALB_LD_PV3].[Period_6] +
	 [ALB_LD_PV4].[Period_6]								AS [January loans bursary total earned cash]

	,[ALB_LD_PV1].[Period_7]								AS [February ALB Code used]
    ,[ALB_LD_PV2].[Period_7]								AS [February ALB support payment earned cash]
	,[ALB_LD_PV3].[Period_7]								AS [February loans bursary for area costs on programme earned cash]
	,[ALB_LD_PV4].[Period_7]								AS [February loans bursary for area costs balancing earned cash]
	,[ALB_LD_PV2].[Period_7] +
	 [ALB_LD_PV3].[Period_7] +
	 [ALB_LD_PV4].[Period_7]								AS [February loans bursary total earned cash]

	,[ALB_LD_PV1].[Period_8]								AS [March ALB Code used]
    ,[ALB_LD_PV2].[Period_8]								AS [March ALB support payment earned cash]
	,[ALB_LD_PV3].[Period_8]								AS [March loans bursary for area costs on programme earned cash]
	,[ALB_LD_PV4].[Period_8]								AS [March loans bursary for area costs balancing earned cash]
	,[ALB_LD_PV2].[Period_8] +
	 [ALB_LD_PV3].[Period_8] +
	 [ALB_LD_PV4].[Period_8]								AS [March loans bursary total earned cash]

	,[ALB_LD_PV1].[Period_9]								AS [April ALB Code used]
    ,[ALB_LD_PV2].[Period_9]								AS [April ALB support payment earned cash]
	,[ALB_LD_PV3].[Period_9]								AS [April loans bursary for area costs on programme earned cash]
	,[ALB_LD_PV4].[Period_9]								AS [April loans bursary for area costs balancing earned cash]
	,[ALB_LD_PV2].[Period_9] +
	 [ALB_LD_PV3].[Period_9] +
	 [ALB_LD_PV4].[Period_9]								AS [April loans bursary total earned cash]

	,[ALB_LD_PV1].[Period_10]								AS [May ALB Code used]
    ,[ALB_LD_PV2].[Period_10]								AS [May ALB support payment earned cash]
	,[ALB_LD_PV3].[Period_10]								AS [May loans bursary for area costs on programme earned cash]
	,[ALB_LD_PV4].[Period_10]								AS [May loans bursary for area costs balancing earned cash]
	,[ALB_LD_PV2].[Period_10] +
	 [ALB_LD_PV3].[Period_10] +
	 [ALB_LD_PV4].[Period_10]								AS [May loans bursary total earned cash]

	,[ALB_LD_PV1].[Period_11]								AS [June ALB Code used]
    ,[ALB_LD_PV2].[Period_11]								AS [June ALB support payment earned cash]
	,[ALB_LD_PV3].[Period_11]								AS [June loans bursary for area costs on programme earned cash]
	,[ALB_LD_PV4].[Period_11]								AS [June loans bursary for area costs balancing earned cash]
	,[ALB_LD_PV2].[Period_11] +
	 [ALB_LD_PV3].[Period_11] +
	 [ALB_LD_PV4].[Period_11]								AS [June loans bursary total earned cash]

	,[ALB_LD_PV1].[Period_12]								AS [July ALB Code used]
    ,[ALB_LD_PV2].[Period_12]								AS [July ALB support payment earned cash]
	,[ALB_LD_PV3].[Period_12]								AS [July loans bursary for area costs on programme earned cash]
	,[ALB_LD_PV4].[Period_12]								AS [July loans bursary for area costs balancing earned cash]
	,[ALB_LD_PV2].[Period_12] +
	 [ALB_LD_PV3].[Period_12] +
	 [ALB_LD_PV4].[Period_12]								AS [July loans bursary total earned cash]

	,[ALB_LD_PV2].[Period_1]+
	 [ALB_LD_PV2].[Period_2]+
	 [ALB_LD_PV2].[Period_3]+
	 [ALB_LD_PV2].[Period_4]+
	 [ALB_LD_PV2].[Period_5]+
	 [ALB_LD_PV2].[Period_6]+
	 [ALB_LD_PV2].[Period_7]+
	 [ALB_LD_PV2].[Period_8]+
	 [ALB_LD_PV2].[Period_9]+
	 [ALB_LD_PV2].[Period_10]+
	 [ALB_LD_PV2].[Period_11]+
	 [ALB_LD_PV2].[Period_12]								AS [Total ALB support payment earned cash]

	,[ALB_LD_PV3].[Period_1]+
	 [ALB_LD_PV3].[Period_2]+
	 [ALB_LD_PV3].[Period_3]+
	 [ALB_LD_PV3].[Period_4]+
	 [ALB_LD_PV3].[Period_5]+
	 [ALB_LD_PV3].[Period_6]+
	 [ALB_LD_PV3].[Period_7]+
	 [ALB_LD_PV3].[Period_8]+
	 [ALB_LD_PV3].[Period_9]+
	 [ALB_LD_PV3].[Period_10]+
	 [ALB_LD_PV3].[Period_11]+
	 [ALB_LD_PV3].[Period_12]								AS [Total loans bursary for area costs on programme earned cash]

	,[ALB_LD_PV4].[Period_1]+
	 [ALB_LD_PV4].[Period_2]+
	 [ALB_LD_PV4].[Period_3]+
	 [ALB_LD_PV4].[Period_4]+
	 [ALB_LD_PV4].[Period_5]+
	 [ALB_LD_PV4].[Period_6]+
	 [ALB_LD_PV4].[Period_7]+
	 [ALB_LD_PV4].[Period_8]+
	 [ALB_LD_PV4].[Period_9]+
	 [ALB_LD_PV4].[Period_10]+
	 [ALB_LD_PV4].[Period_11]+
	 [ALB_LD_PV4].[Period_12]								AS [Total loans bursary for area costs balancing earned cash]

	 ,[ALB_LD_PV2].[Period_1]+[ALB_LD_PV2].[Period_2]+
	 [ALB_LD_PV2].[Period_3]+[ALB_LD_PV2].[Period_4]+
	 [ALB_LD_PV2].[Period_5]+[ALB_LD_PV2].[Period_6]+
	 [ALB_LD_PV2].[Period_7]+[ALB_LD_PV2].[Period_8]+
	 [ALB_LD_PV2].[Period_9]+[ALB_LD_PV2].[Period_10]+
	 [ALB_LD_PV2].[Period_11]+[ALB_LD_PV2].[Period_12]+
	 [ALB_LD_PV3].[Period_1]+[ALB_LD_PV3].[Period_2]+
	 [ALB_LD_PV3].[Period_3]+[ALB_LD_PV3].[Period_4]+
	 [ALB_LD_PV3].[Period_5]+[ALB_LD_PV3].[Period_6]+
	 [ALB_LD_PV3].[Period_7]+[ALB_LD_PV3].[Period_8]+
	 [ALB_LD_PV3].[Period_9]+[ALB_LD_PV3].[Period_10]+
	 [ALB_LD_PV3].[Period_11]+[ALB_LD_PV3].[Period_12]+
	 [ALB_LD_PV4].[Period_1]+[ALB_LD_PV4].[Period_2]+
	 [ALB_LD_PV4].[Period_3]+[ALB_LD_PV4].[Period_4]+
	 [ALB_LD_PV4].[Period_5]+[ALB_LD_PV4].[Period_6]+
	 [ALB_LD_PV4].[Period_7]+[ALB_LD_PV4].[Period_8]+
	 [ALB_LD_PV4].[Period_9]+[ALB_LD_PV4].[Period_10]+
	 [ALB_LD_PV4].[Period_11]+[ALB_LD_PV4].[Period_12]		AS [Total earned cash]


	,'OFFICIAL - SENSITIVE' as [Security Classification]

FROM [VALID].[LearningDelivery] [LD] 
LEFT JOIN [${UoD.FullyQualified}].[Core].LARS_LearningDelivery [LARS] ON [LARS].[LearnAimRef] = [LD].[LearnAimRef]
LEFT JOIN [Rulebase].[ALB_LearningDelivery] ALB_LD ON ALB_LD.[AimSeqNumber] = [LD].[AimSeqNumber] AND ALB_LD.[LearnRefNumber] = [LD].[LearnRefNumber]
LEFT JOIN [VALID].[LearningDeliveryFAM] [LDFAM] ON [LDFAM].[AimSeqNumber] = [LD].[AimSeqNumber] AND [LDFAM].[LearnRefNumber] = [LD].[LearnRefNumber]
LEFT JOIN [Rulebase].[ALB_LearningDelivery_PeriodisedValues] ALB_LD_PV1 ON ALB_LD_PV1.[AimSeqNumber] = [LD].[AimSeqNumber] AND ALB_LD_PV1.[LearnRefNumber] = [LD].[LearnRefNumber] and ALB_LD_PV1.[AttributeName]= 'ALBCode'
LEFT JOIN [Rulebase].[ALB_LearningDelivery_PeriodisedValues] ALB_LD_PV2 ON ALB_LD_PV2.[AimSeqNumber] = [LD].[AimSeqNumber] AND ALB_LD_PV2.[LearnRefNumber] = [LD].[LearnRefNumber] and ALB_LD_PV2.[AttributeName]= 'ALBSupportPayment'
LEFT JOIN [Rulebase].[ALB_LearningDelivery_PeriodisedValues] ALB_LD_PV3 ON ALB_LD_PV3.[AimSeqNumber] = [LD].[AimSeqNumber] AND ALB_LD_PV3.[LearnRefNumber] = [LD].[LearnRefNumber] and ALB_LD_PV3.[AttributeName]= 'AreaUpliftOnProgPayment'
LEFT JOIN [Rulebase].[ALB_LearningDelivery_PeriodisedValues] ALB_LD_PV4 ON ALB_LD_PV4.[AimSeqNumber] = [LD].[AimSeqNumber] AND ALB_LD_PV4.[LearnRefNumber] = [LD].[LearnRefNumber] and ALB_LD_PV4.[AttributeName]= 'AreaUpliftBalPayment'
LEFT JOIN [VALID].[Learner] AS [L] ON [L].[LearnRefNumber] = [LD].[LearnRefNumber]
WHERE [LD].[FundModel] = 99 AND [LD].[LrnDelFAM_ADL] = 1 
GROUP by
	[L].[LearnRefNumber]
    ,[L].[ULN]	
	,[L].[DateOfBirth]	
	,[L].[HomePostCode]	
	,[L].[ProvSpecMon_A]								
	,[L].[ProvSpecMon_B]								
    ,[LD].[AimSeqNumber]
	,[LD].[LearnAimRef]	
	,[LARS].[LearnAimRefTitle]
	,[LD].[SWSupAimID]			
	,[ALB_LD].[WeightedRate]	
	,[ALB_LD].[ApplicProgWeightFact]
	,[LARS].[NotionalNVQLevelv2]
	,[LARS].[SectorSubjectAreaTier2]	
	,[ALB_LD].[CourseType]				
	,[ALB_LD].[MaxNumYears]				
	,[ALB_LD].[ALBPaymentEndDate]		
	,[LD].[AimType]						
	,[LD].[FundModel]					
	,[LD].[PriorLearnFundAdj]			
	,[LD].[OtherFundAdj]				
    ,[LD].[OrigLearnStartDate]			
    ,[LD].[LearnStartDate]				
    ,[LD].[LearnPlanEndDate]			
    ,[LD].[CompStatus]		
    ,[LD].[LearnActEndDate]
    ,[LD].[Outcome]			
    ,[LD].[LrnDelFAM_ADL]
	,[LDFAM].[LearnDelFAMType]	
    ,[LD].[LrnDelFAM_SPP]
	,[LD].[LrnDelFAM_LDM1]
	,[LD].[LrnDelFAM_LDM2]
	,[LD].[LrnDelFAM_LDM3]
	,[LD].[LrnDelFAM_LDM4]	
	,[LD].[ProvSpecMon_A]
	,[LD].[ProvSpecMon_B]
	,[LD].[ProvSpecMon_C]
	,[LD].[ProvSpecMon_D]
	,[LD].[PartnerUKPRN]	
    ,[LD].[DelLocPostcode]
	,[ALB_LD].[AreaCostFactAdj]
	,[ALB_LD].[FundLine]		
	,[ALB_LD].[LiabilityDate]		
	,[ALB_LD].[PlannedNumOnProgInstalm]	

	,[ALB_LD_PV1].[Period_1]
    ,[ALB_LD_PV2].[Period_1]
	,[ALB_LD_PV3].[Period_1]
	,[ALB_LD_PV4].[Period_1]
	
	,[ALB_LD_PV1].[Period_2]
    ,[ALB_LD_PV2].[Period_2]
	,[ALB_LD_PV3].[Period_2]
	,[ALB_LD_PV4].[Period_2]
	

	,[ALB_LD_PV1].[Period_3]
    ,[ALB_LD_PV2].[Period_3]
	,[ALB_LD_PV3].[Period_3]
	,[ALB_LD_PV4].[Period_3]
	
	,[ALB_LD_PV1].[Period_4]
    ,[ALB_LD_PV2].[Period_4]
	,[ALB_LD_PV3].[Period_4]
	,[ALB_LD_PV4].[Period_4]
	

	,[ALB_LD_PV1].[Period_5]
    ,[ALB_LD_PV2].[Period_5]
	,[ALB_LD_PV3].[Period_5]
	,[ALB_LD_PV4].[Period_5]
	
	,[ALB_LD_PV1].[Period_6]
    ,[ALB_LD_PV2].[Period_6]
	,[ALB_LD_PV3].[Period_6]
	,[ALB_LD_PV4].[Period_6]
	
	,[ALB_LD_PV1].[Period_7]
    ,[ALB_LD_PV2].[Period_7]
	,[ALB_LD_PV3].[Period_7]
	,[ALB_LD_PV4].[Period_7]
	
	,[ALB_LD_PV1].[Period_8]
    ,[ALB_LD_PV2].[Period_8]
	,[ALB_LD_PV3].[Period_8]
	,[ALB_LD_PV4].[Period_8]
	

	,[ALB_LD_PV1].[Period_9]
    ,[ALB_LD_PV2].[Period_9]
	,[ALB_LD_PV3].[Period_9]
	,[ALB_LD_PV4].[Period_9]
	

	,[ALB_LD_PV1].[Period_10]
    ,[ALB_LD_PV2].[Period_10]
	,[ALB_LD_PV3].[Period_10]
	,[ALB_LD_PV4].[Period_10]
	

	,[ALB_LD_PV1].[Period_11]
    ,[ALB_LD_PV2].[Period_11]
	,[ALB_LD_PV3].[Period_11]
	,[ALB_LD_PV4].[Period_11]
	

	,[ALB_LD_PV1].[Period_12]
    ,[ALB_LD_PV2].[Period_12]
	,[ALB_LD_PV3].[Period_12]
	,[ALB_LD_PV4].[Period_12]
)INNER_SELECT
)OUTER_SELECT
WHERE RowNumber BETWEEN ((@Page - 1) * @PageSize) AND (@Page * @PageSize -1)	
ORDER BY [Learner reference number], [Learning aim reference]
