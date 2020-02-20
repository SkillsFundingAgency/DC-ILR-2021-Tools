IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[PopulateALLBOccupancyReport]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[PopulateALLBOccupancyReport]
GO

CREATE PROCEDURE [Report].[PopulateALLBOccupancyReport]
AS
BEGIN
TRUNCATE TABLE [Report].[ALLBOccupancyReportData]	;

	WITH ProvSpecLearnMon_CTE AS
	( 
		SELECT	ProvSpecLearnMon.* 
		FROM	[Valid].[ProviderSpecLearnerMonitoring] 
		PIVOT	(MAX(ProvSpecLearnMon) 
		FOR		ProvSpecLearnMonOccur IN ([A],[B]))AS ProvSpecLearnMon
	)
	,LearnDelFAM_CTE_rn AS
    (
      SELECT	 [LearnRefNumber]	
				,[AimSeqNumber]	
				,[LearnDelFAMType]	
				,[LearnDelFAMCode]	
				,CAST((ROW_NUMBER() OVER(PARTITION BY [LearnRefNumber] ORDER BY [LearnDelFAMCode] ))AS VARCHAR) AS RN
      FROM		[Valid].[LearningDeliveryFAM]
      WHERE		[LearnDelFAMType] = 'LDM'

      UNION

      SELECT	 [LearnRefNumber]
				,[AimSeqNumber]
				,[LearnDelFAMType]
				,[LearnDelFAMCode]
				,'' AS RN
      FROM		[Valid].[LearningDeliveryFAM]
      WHERE		[LearnDelFAMType] <> 'LDM'
    )
	,LearnDelFAM_CTE_pivdata AS
    (
		SELECT   [LearnRefNumber]
				,[AimSeqNumber]
				,[LearnDelFAMType]+RN AS [LearnDelFAMType]
				,[LearnDelFAMCode] 
		FROM	LearnDelFAM_CTE_rn
    )
	,LearnDelFAM_CTE AS
	(
		SELECT	* 
		FROM	LearnDelFAM_CTE_pivdata f 
		PIVOT	( MAX(LearnDelFAMCode) FOR [LearnDelFAMType] IN ([ADL],[ALB],[LDM1],[LDM2],[LDM3],[LDM4])) LearnDelFAM 
	)
	,[LearnDelFAM_ALB_CTE] AS
	(
		SELECT		 LearnRefNumber
					,AimSeqNumber
					,MAX(LearnDelFAMCode)			AS LearnDelFAMCode
					,MIN(LearnDelFAMDateFrom)		AS LearnDelFAMDateFrom_Earliest
					,MAX(LearnDelFAMDateTo)			AS LearnDelFAMDateTo_Latest 
		FROM		[Valid].[LearningDeliveryFAM] 
		WHERE		LearnDelFAMType ='ALB' 
		GROUP BY	LearnRefNumber
					,AimSeqNumber
	)
	,ProvSpecDelMon_CTE AS 
	(
		SELECT	ProvSpecDelMon.* 
		FROM	[Valid].[ProviderSpecDeliveryMonitoring] 
		PIVOT	(MAX(ProvSpecDelMon) FOR ProvSpecDelMonOccur IN ([A],[B],[C],[D]))AS ProvSpecDelMon
	)
	,AllbData_CTE AS 
	(
		SELECT DISTINCT 
					 [L].[LearnRefNumber]									AS [Learner_reference_number] 
					,[L].[ULN]												AS [Unique_learner_number] 
					,CONVERT(VARCHAR(10), [L].[DateOfBirth], 103)			AS [Date_of_birth] 
					,[L].[PMUKPRN]											AS [PMUKPRN] 
					,[ProvSpecLearnMon].[A]									AS [Provider_specified_learner_monitoring_A] 
					,[ProvSpecLearnMon].[B]									AS [Provider_specified_learner_monitoring_B] 
					,[LD].[AimSeqNumber]									AS [Aim_sequence_number] 
					,[LD].[LearnAimRef]										AS [Learning_aim_reference] 
					,[LARS].[LearnAimRefTitle]								AS [Learning_aim_title] 
					,[LD].[SWSupAimID]										AS [Software_supplier_aim_identifier] 
					,ISNULL([ALB_LD].[WeightedRate], 0)						AS [Applicable_funding_rate] 
					,ISNULL([ALB_LD].[ApplicProgWeightFact], 0)				AS [Applicable_programme_weighting] 
					,[LARS].[NotionalNVQLevelv2]							AS [Notional_NVQ_level] 
					,[LARS].[SectorSubjectAreaTier2]						AS [Tier_2_sector_subject_area] 
					,[LD].[AimType]											AS [Aim_type] 
					,[LD].[FundModel]										AS [Funding_model] 
					,[LD].[PriorLearnFundAdj]								AS [Funding_adjustment_for_prior_learning] 
					,[LD].[OtherFundAdj]									AS [Other_funding_adjustment] 
					,[LD].[OrigLearnStartDate]								AS [Original_learning_start_date] 
					,[LD].[LearnStartDate]									AS [Learning_start_date] 
					,[LD].[LearnPlanEndDate]								AS [Learning_planned_end_date] 
					,[LD].[CompStatus]										AS [Completion_status] 
					,[LD].[LearnActEndDate]									AS [Learning_actual_end_date] 
					,[LD].[Outcome]											AS [Outcome] 
					,[LDFAM].[ADL]											AS [Learning_delivery_funding_and_monitoring_type_Advanced_Learner_Loans_indicator] 
					,[LDFAM_ALB].LearnDelFAMCode							AS [Learning_delivery_funding_and_monitoring_type_Advanced_Learner_Loans_Bursary_funding] 
					,[LDFAM_ALB].LearnDelFAMDateFrom_Earliest				AS [Learning_delivery_funding_and_monitoring_ALB_date_applies_from] 
					,[LDFAM_ALB].LearnDelFAMDateTo_Latest					AS [Learning_delivery_funding_and_monitoring_ALB_date_applies_to] 
					,[LDFAM].[LDM1]											AS [Learning_delivery_funding_and_monitoring_type_learning_delivery_monitoring_A] 
					,[LDFAM].[LDM2]											AS [Learning_delivery_funding_and_monitoring_type_learning_delivery_monitoring_B] 
					,[LDFAM].[LDM3]											AS [Learning_delivery_funding_and_monitoring_type_learning_delivery_monitoring_C] 
					,[LDFAM].[LDM4]											AS [Learning_delivery_funding_and_monitoring_type_learning_delivery_monitoring_D] 
					,[ProvSpecDelMon].[A]									AS [Provider_specified_delivery_monitoring_A] 
					,[ProvSpecDelMon].[B]									AS [Provider_specified_delivery_monitoring_B] 
					,[ProvSpecDelMon].[C]									AS [Provider_specified_delivery_monitoring_C] 
					,[ProvSpecDelMon].[D]									AS [Provider_specified_delivery_monitoring_D] 
					,[LD].[PartnerUKPRN]									AS [Sub_contracted_or_partnership_UKPRN] 
					,[LD].[DelLocPostcode]									AS [Delivery_location_postcode] 
					,ISNULL([ALB_LD].[AreaCostFactAdj], 0)					AS [Area_uplift] 
					,[ALB_LD].[FundLine]									AS [Funding_line_type] 
					,[ALB_LD].[LiabilityDate]								AS [First_liability_date] 
					,[ALB_LD].[PlannedNumOnProgInstalm]						AS [Planned_number_of_instalments] 
					,[ALB_LD].[ApplicFactDate]								AS [Date_used_for_factor_lookups] 
					,ISNULL([ALB_LD_PV1].[Period_1],  0)					AS [August_ALB_code_used] 
					,ISNULL([ALB_LD_PV2].[Period_1],  0)					AS [August_ALB_support_payment_earned_cash] 
					,ISNULL([ALB_LD_PV3].[Period_1],  0)					AS [August_loans_bursary_for_area_costs_on_programme_earned_cash] 
					,ISNULL([ALB_LD_PV4].[Period_1],  0)					AS [August_loans_bursary_for_area_costs_balancing_earned_cash] 

					,ISNULL([ALB_LD_PV2].[Period_1],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_1], 0) 
					+ ISNULL([ALB_LD_PV4].[Period_1], 0)					AS [August_loans_bursary_total_earned_cash] 

					,ISNULL([ALB_LD_PV1].[Period_2],  0)					AS [September_ALB_Code_used] 
					,ISNULL([ALB_LD_PV2].[Period_2],  0)					AS [September_ALB_support_payment_earned_cash] 
					,ISNULL([ALB_LD_PV3].[Period_2],  0)					AS [September_loans_bursary_for_area_costs_on_programme_earned_cash] 
					,ISNULL([ALB_LD_PV4].[Period_2],  0)					AS [September_loans_bursary_for_area_costs_balancing_earned_cash] 

					,ISNULL([ALB_LD_PV2].[Period_2],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_2], 0) 
					+ ISNULL([ALB_LD_PV4].[Period_2], 0)					AS [September_loans_bursary_total_earned_cash]
			 
					,ISNULL([ALB_LD_PV1].[Period_3],  0)					AS [October_ALB_Code_used] 
					,ISNULL([ALB_LD_PV2].[Period_3],  0)					AS [October_ALB_support_payment_earned_cash] 
					,ISNULL([ALB_LD_PV3].[Period_3],  0)					AS [October_loans_bursary_for_area_costs_on_programme_earned_cash] 
					,ISNULL([ALB_LD_PV4].[Period_3],  0)					AS [October_loans_bursary_for_area_costs_balancing_earned_cash] 

					,ISNULL([ALB_LD_PV2].[Period_3],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_3], 0) 
					+ ISNULL([ALB_LD_PV4].[Period_3], 0)					AS [October_loans_bursary_total_earned_cash] 

					,ISNULL([ALB_LD_PV1].[Period_4],  0)					AS [November_ALB_Code_used] 
					,ISNULL([ALB_LD_PV2].[Period_4],  0)					AS [November_ALB_support_payment_earned_cash] 
					,ISNULL([ALB_LD_PV3].[Period_4],  0)					AS [November_loans_bursary_for_area_costs_on_programme_earned_cash] 
					,ISNULL([ALB_LD_PV4].[Period_4],  0)					AS [November_loans_bursary_for_area_costs_balancing_earned_cash] 

					,ISNULL([ALB_LD_PV2].[Period_4],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_4], 0) 
					+ ISNULL([ALB_LD_PV4].[Period_4], 0)					AS [November_loans_bursary_total_earned_cash] 

					,ISNULL([ALB_LD_PV1].[Period_5],  0)					AS [December_ALB_Code_used] 
					,ISNULL([ALB_LD_PV2].[Period_5],  0)					AS [December_ALB_support_payment_earned_cash] 
					,ISNULL([ALB_LD_PV3].[Period_5],  0)					AS [December_loans_bursary_for_area_costs_on_programme_earned_cash] 
					,ISNULL([ALB_LD_PV4].[Period_5],  0)					AS [December_loans_bursary_for_area_costs_balancing_earned_cash] 

					,ISNULL([ALB_LD_PV2].[Period_5],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_5], 0) 
					+ ISNULL([ALB_LD_PV4].[Period_5], 0)					AS [December_loans_bursary_total_earned_cash] 

					,ISNULL([ALB_LD_PV1].[Period_6],  0)					AS [January_ALB_Code_used] 
					,ISNULL([ALB_LD_PV2].[Period_6],  0)					AS [January_ALB_support_payment_earned_cash] 
					,ISNULL([ALB_LD_PV3].[Period_6],  0)					AS [January_loans_bursary_for_area_costs_on_programme_earned_cash] 
					,ISNULL([ALB_LD_PV4].[Period_6],  0)					AS [January_loans_bursary_for_area_costs_balancing_earned_cash] 

					,ISNULL([ALB_LD_PV2].[Period_6],  0) 
					+ISNULL([ALB_LD_PV3].[Period_6],  0) 
					+ISNULL([ALB_LD_PV4].[Period_6],  0)					AS [January_loans_bursary_total_earned_cash] 

					,ISNULL([ALB_LD_PV1].[Period_7],  0)					AS [February_ALB_Code_used] 
					,ISNULL([ALB_LD_PV2].[Period_7],  0)					AS [February_ALB_support_payment_earned_cash] 
					,ISNULL([ALB_LD_PV3].[Period_7],  0)					AS [February_loans_bursary_for_area_costs_on_programme_earned_cash] 
					,ISNULL([ALB_LD_PV4].[Period_7],  0)					AS [February_loans_bursary_for_area_costs_balancing_earned_cash] 

					,ISNULL([ALB_LD_PV2].[Period_7],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_7], 0) 
					+ ISNULL([ALB_LD_PV4].[Period_7], 0)					AS [February_loans_bursary_total_earned_cash] 

					,ISNULL([ALB_LD_PV1].[Period_8],  0)					AS [March_ALB_Code_used] 
					,ISNULL([ALB_LD_PV2].[Period_8],  0)					AS [March_ALB_support_payment_earned_cash] 
					,ISNULL([ALB_LD_PV3].[Period_8],  0)					AS [March_loans_bursary_for_area_costs_on_programme_earned_cash] 
					,ISNULL([ALB_LD_PV4].[Period_8],  0)					AS [March_loans_bursary_for_area_costs_balancing_earned_cash] 

					,ISNULL([ALB_LD_PV2].[Period_8],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_8], 0) 
					+ ISNULL([ALB_LD_PV4].[Period_8], 0)					AS [March_loans_bursary_total_earned_cash] 

					,ISNULL([ALB_LD_PV1].[Period_9],  0)					AS [April_ALB_Code_used] 
					,ISNULL([ALB_LD_PV2].[Period_9],  0)					AS [April_ALB_support_payment_earned_cash] 
					,ISNULL([ALB_LD_PV3].[Period_9],  0)					AS [April_loans_bursary_for_area_costs_on_programme_earned_cash] 
					,ISNULL([ALB_LD_PV4].[Period_9],  0)					AS [April_loans_bursary_for_area_costs_balancing_earned_cash] 

					,ISNULL([ALB_LD_PV2].[Period_9],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_9], 0) 
					+ ISNULL([ALB_LD_PV4].[Period_9], 0)					AS [April_loans_bursary_total_earned_cash] 
					,ISNULL([ALB_LD_PV1].[Period_10], 0)					AS [May_ALB_Code_used] 
					,ISNULL([ALB_LD_PV2].[Period_10], 0)					AS [May_ALB_support_payment_earned_cash] 
					,ISNULL([ALB_LD_PV3].[Period_10], 0)					AS [May_loans_bursary_for_area_costs_on_programme_earned_cash] 
					,ISNULL([ALB_LD_PV4].[Period_10], 0)					AS [May_loans_bursary_for_area_costs_balancing_earned_cash] 

					,ISNULL([ALB_LD_PV2].[Period_10],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_10], 0) 
					+ ISNULL([ALB_LD_PV4].[Period_10], 0)					AS [May_loans_bursary_total_earned_cash] 

					,ISNULL([ALB_LD_PV1].[Period_11],  0)					AS [June_ALB_Code_used] 
					,ISNULL([ALB_LD_PV2].[Period_11],  0)					AS [June_ALB_support_payment_earned_cash] 
					,ISNULL([ALB_LD_PV3].[Period_11],  0)					AS [June_loans_bursary_for_area_costs_on_programme_earned_cash] 
					,ISNULL([ALB_LD_PV4].[Period_11],  0)					AS [June_loans_bursary_for_area_costs_balancing_earned_cash] 

					,ISNULL([ALB_LD_PV2].[Period_11] , 0)
					+ ISNULL([ALB_LD_PV3].[Period_11], 0)
					+ ISNULL([ALB_LD_PV4].[Period_11], 0)					AS [June_loans_bursary_total_earned_cash] 
					,ISNULL([ALB_LD_PV1].[Period_12],  0)					AS [July_ALB_Code_used] 
					,ISNULL([ALB_LD_PV2].[Period_12],  0)					AS [July_ALB_support_payment_earned_cash] 
					,ISNULL([ALB_LD_PV3].[Period_12],  0)					AS [July_loans_bursary_for_area_costs_on_programme_earned_cash] 
					,ISNULL([ALB_LD_PV4].[Period_12],  0)					AS [July_loans_bursary_for_area_costs_balancing_earned_cash] 

					,ISNULL([ALB_LD_PV2].[Period_12],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_12], 0) 
					+ ISNULL([ALB_LD_PV4].[Period_12], 0)					AS [July_loans_bursary_total_earned_cash] 

					,ISNULL([ALB_LD_PV2].[Period_1],   0) 
					+ ISNULL([ALB_LD_PV2].[Period_2],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_3],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_4],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_5],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_6],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_7],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_8],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_9],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_10], 0) 
					+ ISNULL([ALB_LD_PV2].[Period_11], 0) 
					+ ISNULL([ALB_LD_PV2].[Period_12], 0)					AS [Total_ALB_support_payment_earned_cash] 

					,ISNULL([ALB_LD_PV3].[Period_1],   0) 
					+ ISNULL([ALB_LD_PV3].[Period_2],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_3],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_4],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_5],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_6],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_7],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_8],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_9],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_10], 0) 
					+ ISNULL([ALB_LD_PV3].[Period_11], 0) 
					+ ISNULL([ALB_LD_PV3].[Period_12], 0)					AS [Total_loans_bursary_for_area_costs_on_programme_earned_cash] 

					,ISNULL([ALB_LD_PV4].[Period_1],   0) 
					+ ISNULL([ALB_LD_PV4].[Period_2],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_3],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_4],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_5],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_6],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_7],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_8],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_9],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_10], 0) 
					+ ISNULL([ALB_LD_PV4].[Period_11], 0) 
					+ ISNULL([ALB_LD_PV4].[Period_12], 0)					AS [Total_loans_bursary_for_area_costs_balancing_earned_cash] 

					,ISNULL([ALB_LD_PV2].[Period_1],   0) 
					+ ISNULL([ALB_LD_PV2].[Period_2],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_3],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_4],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_5],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_6],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_7],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_8],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_9],  0) 
					+ ISNULL([ALB_LD_PV2].[Period_10], 0) 
					+ ISNULL([ALB_LD_PV2].[Period_11], 0) 
					+ ISNULL([ALB_LD_PV2].[Period_12], 0) 
					+ ISNULL([ALB_LD_PV3].[Period_1],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_2],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_3],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_4],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_5],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_6],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_7],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_8],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_9],  0) 
					+ ISNULL([ALB_LD_PV3].[Period_10], 0) 
					+ ISNULL([ALB_LD_PV3].[Period_11], 0)
					+ ISNULL([ALB_LD_PV3].[Period_12], 0) 
					+ ISNULL([ALB_LD_PV4].[Period_1],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_2],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_3],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_4],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_5],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_6],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_7],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_8],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_9],  0) 
					+ ISNULL([ALB_LD_PV4].[Period_10], 0) 
					+ ISNULL([ALB_LD_PV4].[Period_11], 0) 
					+ ISNULL([ALB_LD_PV4].[Period_12], 0)				AS [Total_earned_cash] 

					,''													AS [OFFICIAL_SENSITIVE] 
		FROM		[VALID].[LearningDelivery]							AS [LD]
		LEFT JOIN	[Reference].[LARS_LearningDelivery]					AS [LARS] 
			   ON	[LARS].[LearnAimRef]								=  [LD].[LearnAimRef]

		LEFT JOIN	[Rulebase].[ALB_LearningDelivery]					AS [ALB_LD] 
			   ON	[ALB_LD].[AimSeqNumber]								=  [LD].[AimSeqNumber]
			  AND	[ALB_LD].[LearnRefNumber]							=  [LD].[LearnRefNumber]

		LEFT JOIN	[LearnDelFAM_CTE]									AS [LDFAM] 
			   ON	[LDFAM].[AimSeqNumber]								=  [LD].[AimSeqNumber] 
			  AND	[LDFAM].[LearnRefNumber]							=  [LD].[LearnRefNumber]

		LEFT JOIN	[LearnDelFAM_ALB_CTE]								AS [LDFAM_ALB] 
			   ON	[LDFAM_ALB].[AimSeqNumber]							=  [LD].[AimSeqNumber] 
			  AND	[LDFAM_ALB].[LearnRefNumber]						=  [LD].[LearnRefNumber]

		LEFT JOIN	[ProvSpecDelMon_CTE]								AS [ProvSpecDelMon] 
			   ON	[ProvSpecDelMon].[LearnRefNumber]					=  [LD].[LearnRefNumber] 
			  AND	[ProvSpecDelMon].[AimSeqNumber]						=  [LD].[AimSeqNumber]

		LEFT JOIN	[ProvSpecLearnMon_CTE]								AS [ProvSpecLearnMon] 
			   ON	[ProvSpecLearnMon].[LearnRefNumber]					=  [LD].[LearnRefNumber]

		LEFT JOIN	[Rulebase].[ALB_LearningDelivery_PeriodisedValues]	AS ALB_LD_PV1 
			   ON	[ALB_LD_PV1].[AimSeqNumber]							=  [LD].[AimSeqNumber]
			  AND	[ALB_LD_PV1].[LearnRefNumber]						=  [LD].[LearnRefNumber]
			  AND	[ALB_LD_PV1].[AttributeName]						=  'ALBCode'

		LEFT JOIN	[Rulebase].[ALB_LearningDelivery_PeriodisedValues]	AS ALB_LD_PV2 
			   ON	[ALB_LD_PV2].[AimSeqNumber]							=  [LD].[AimSeqNumber]
			  AND	[ALB_LD_PV2].[LearnRefNumber]						=  [LD].[LearnRefNumber]
			  AND	[ALB_LD_PV2].[AttributeName]						=  'ALBSupportPayment'

		LEFT JOIN	[Rulebase].[ALB_LearningDelivery_PeriodisedValues]	AS ALB_LD_PV3 
			   ON	[ALB_LD_PV3].[AimSeqNumber]							=  [LD].[AimSeqNumber]
			  AND	[ALB_LD_PV3].[LearnRefNumber]						=  [LD].[LearnRefNumber]
			  AND	[ALB_LD_PV3].[AttributeName]						= 'AreaUpliftOnProgPayment'

		LEFT JOIN	[Rulebase].[ALB_LearningDelivery_PeriodisedValues]	AS ALB_LD_PV4 
			   ON	[ALB_LD_PV4].[AimSeqNumber]							=  [LD].[AimSeqNumber]
			  AND	[ALB_LD_PV4].[LearnRefNumber]						=  [LD].[LearnRefNumber]
			  AND	[ALB_LD_PV4].[AttributeName]						=  'AreaUpliftBalPayment'

		LEFT JOIN	[VALID].[Learner]									AS [L] 
			   ON	[L].[LearnRefNumber]								=  [LD].[LearnRefNumber]

		WHERE		[LD].[FundModel] = 99 
		AND			[LDFAM].ADL = 1
		AND			(LDFAM.ALB IS NOT NULL OR [ALB_LD].[AreaCostFactAdj] > 0)
		GROUP BY
					 [L].[LearnRefNumber] 
					,[L].[ULN] 
					,[L].[DateOfBirth] 
					,[L].[PMUKPRN] 
					,[ProvSpecLearnMon].[A] 
					,[ProvSpecLearnMon].[B] 
					,[LD].[AimSeqNumber] 
					,[LD].[LearnAimRef] 
					,[LARS].[LearnAimRefTitle] 
					,[LD].[SWSupAimID] 
					,[ALB_LD].[WeightedRate] 
					,[ALB_LD].[ApplicProgWeightFact] 
					,[LARS].[NotionalNVQLevelv2] 
					,[LARS].[SectorSubjectAreaTier2] 
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
					,[LDFAM].[ADL]
					,[LDFAM].[ALB]
					,[LDFAM].[LDM1]							
					,[LDFAM].[LDM2]							
					,[LDFAM].[LDM3]							
					,[LDFAM].[LDM4]							
					,[LDFAM_ALB].[LearnDelFAMCode]
					,[LDFAM_ALB].[LearnDelFAMDateFrom_Earliest]
					,[LDFAM_ALB].[LearnDelFAMDateTo_Latest]
					,[ProvSpecDelMon].[A]						
					,[ProvSpecDelMon].[B]						
					,[ProvSpecDelMon].[C]						
					,[ProvSpecDelMon].[D]		
					,[LD].[PartnerUKPRN] 
					,[LD].[DelLocPostcode] 
					,[ALB_LD].[AreaCostFactAdj] 
					,[ALB_LD].[FundLine] 
					,[ALB_LD].[LiabilityDate] 
					,[ALB_LD].[PlannedNumOnProgInstalm] 
					,[ALB_LD].[ApplicFactDate] 
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
	)

	INSERT INTO [Report].[ALLBOccupancyReportData]
			SELECT * FROM [AllbData_CTE]
END
GO