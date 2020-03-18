IF OBJECT_ID('Report.ILR_RuleViolationView') IS NOT NULL
BEGIN
	DROP VIEW [Report].[ILR_RuleViolationView]
END
GO

CREATE VIEW [Report].[ILR_RuleViolationView]
AS

SELECT /* DISTINCT removed as we want to capture each error occurrence */
	[VE].[RuleName]
	,[VE].[Source]
	,[VE].[Severity]
	,[VE].[LearnRefNumber]
	,[VE].[FieldValues]
	,[VE].[ErrorMessage]
	,[VE].[FileLevelError]
	,[VE].[AimSeqNum]
	,[LD].[LearnAimRef]
	,[LD].[FundModel]
	,[LD].[PartnerUKPRN]
	,[LD].[SWSupAimID] 
	,[pslmA].[ProvSpecLearnMon] AS [ProviderSpecLearnOccurA]
	,[pslmB].[ProvSpecLearnMon] AS [ProviderSpecLearnOccurB]
	,[psdmA].[ProvSpecDelMon] AS [ProviderSpecDelOccurA]
	,[psdmB].[ProvSpecDelMon] AS [ProviderSpecDelOccurB]
	,[psdmC].[ProvSpecDelMon] AS [ProviderSpecDelOccurC]
	,[psdmD].[ProvSpecDelMon] AS [ProviderSpecDelOccurD]

FROM [Report].[ValidationError] [VE]
LEFT JOIN [Input].[Learner] [L] 
	ON [L].[LearnRefNumber] = [VE].[LearnRefNumber]
LEFT JOIN [Input].[LearningDelivery] [LD] 
	ON [VE].[AimSeqNum] = [LD].[AimSeqNumber] 
		AND [LD].[Learner_Id] = [L].[Learner_Id]
LEFT JOIN [Input].[ProviderSpecLearnerMonitoring] [pslmA] 
	ON [pslmA].[ProvSpecLearnMonOccur] = 'A'
		AND [pslmA].[Learner_Id] = [L].[Learner_Id]
LEFT JOIN [Input].[ProviderSpecLearnerMonitoring] [pslmB] 
	ON [pslmB].[ProvSpecLearnMonOccur] = 'B'
		AND [pslmB].[Learner_Id] = [L].[Learner_Id]
LEFT JOIN [Input].[ProviderSpecDeliveryMonitoring] [psdmA] 
	ON [psdmA].[ProvSpecDelMonOccur] = 'A'
		AND [psdmA].[LearningDelivery_Id] = [LD].[LearningDelivery_Id]
LEFT JOIN [Input].[ProviderSpecDeliveryMonitoring] [psdmB] 
	ON [psdmB].[ProvSpecDelMonOccur] = 'B'
		AND [psdmB].[LearningDelivery_Id] = [LD].[LearningDelivery_Id]
LEFT JOIN [Input].[ProviderSpecDeliveryMonitoring] [psdmC] 
	ON [psdmC].[ProvSpecDelMonOccur] = 'C'
		AND [psdmC].[LearningDelivery_Id] = [LD].[LearningDelivery_Id]
LEFT JOIN [Input].[ProviderSpecDeliveryMonitoring] [psdmD] 
	ON [psdmD].[ProvSpecDelMonOccur] = 'D' 
		AND [psdmD].[LearningDelivery_Id] = [LD].[LearningDelivery_Id]
GO
