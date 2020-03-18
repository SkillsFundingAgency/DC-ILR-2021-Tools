
SELECT count(*)

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

