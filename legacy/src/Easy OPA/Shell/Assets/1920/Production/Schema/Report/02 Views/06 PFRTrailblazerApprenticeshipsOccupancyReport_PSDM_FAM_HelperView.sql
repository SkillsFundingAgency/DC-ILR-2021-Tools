 
 IF OBJECT_ID('[Report].[PFRTrailblazerApprenticeshipsOccupancyReport_PSDM_FAM_HelperView]') IS NOT NULL
 BEGIN
	 DROP VIEW [Report].[PFRTrailblazerApprenticeshipsOccupancyReport_PSDM_FAM_HelperView]
 END
 GO

 CREATE VIEW [Report].[PFRTrailblazerApprenticeshipsOccupancyReport_PSDM_FAM_HelperView] 
 AS
  
SELECT [LDD].[LearnRefNumber], [LDD].[AimSeqNumber],
	 [LDD].[ProvSpecDelMon_A],
	 [LDD].[ProvSpecDelMon_B],
	 [LDD].[ProvSpecDelMon_C],
	 [LDD].[ProvSpecDelMon_D],
	 [LDFAM_SOF].[LearnDelFAMCode] AS [LrnDelFAM_SOF],
	 [LDFAM_EEF].[LearnDelFAMCode] AS [LrnDelFAM_EEF],
	 [LDFAM_RES].[LearnDelFAMCode] AS [LrnDelFAM_RES],
	 [LDD].[LDM1],
	 [LDD].[LDM2],
	 [LDD].[LDM3],
	 [LDD].[LDM4]   
 FROM [Valid].[LearningDeliveryDenorm] AS [LDD] 
 
LEFT JOIN	[Valid].[LearningDeliveryFAM] AS [LDFAM_SOF] 
	 ON			[LDD].[LearnRefNumber] = [LDFAM_SOF].[LearnRefNumber]
	 AND			[LDD].[AimSeqNumber] = [LDFAM_SOF].[AimSeqNumber]
	 AND			[LDFAM_SOF].[LearnDelFAMType] = 'SOF'

LEFT JOIN	[Valid].[LearningDeliveryFAM] AS [LDFAM_EEF] 
	 ON			[LDD].[LearnRefNumber] = [LDFAM_EEF].[LearnRefNumber]
	 AND			[LDD].[AimSeqNumber] = [LDFAM_EEF].[AimSeqNumber]
	 AND			[LDFAM_EEF].[LearnDelFAMType] = 'EEF'

LEFT JOIN	[Valid].[LearningDeliveryFAM] AS [LDFAM_RES] 
	 ON			[LDD].[LearnRefNumber] = [LDFAM_RES].[LearnRefNumber]
	 AND			[LDD].[AimSeqNumber] = [LDFAM_RES].[AimSeqNumber]
	 AND			[LDFAM_RES].[LearnDelFAMType] = 'RES'

