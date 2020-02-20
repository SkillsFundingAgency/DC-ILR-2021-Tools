IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[EFA1619FundingByStudentReportPopulateData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[EFA1619FundingByStudentReportPopulateData]
GO

CREATE PROCEDURE [Report].[EFA1619FundingByStudentReportPopulateData]
AS
BEGIN
	-- Clear previous report data - needed by FIS
	TRUNCATE TABLE [Report].[EFA1619FundingByStudent]

	;WITH LearnDelFAM_CTE AS
	(
		SELECT * FROM  [Valid].[LearningDeliveryFAM] f PIVOT( MAX(LearnDelFAMCode) FOR [LearnDelFAMType] IN ([ACT],[SOF],[FFI],[EEF],[LDM1],[LDM2],[LDM3],[LDM4],[RES])) LearnDelFAM 
	)
	,ProvSpecLearnMon_CTE AS 
	(
		SELECT ProvSpecLearnMon.* FROM [Valid].[ProviderSpecLearnerMonitoring] PIVOT (MAX(ProvSpecLearnMon) FOR ProvSpecLearnMonOccur IN ([A],[B]))AS ProvSpecLearnMon
	)

	-- Populate Report Data
	INSERT INTO [Report].[EFA1619FundingByStudent](
	[Fundline],[LearnRefNumber] ,[FamilyName],[GivenNames] ,[DateOfBirth] ,	[PlanLearnHours] ,	[PlanEEPHours] ,	[TotalPlannedHours] ,	[RateBand] ,
	[QualifiesForFunding] ,	[OnProgPayment] ,	[SecurityClassification] ,	[SortOrder] ,	[LearnerStartDate] ,	[ProvSpecMon_A] ,	[ProvSpecMon_B])

	SELECT DISTINCT
				lefa.Fundline,
				l.LearnRefNumber,
				l.FamilyName, 
				l.GivenNames,
				CONVERT(VARCHAR(10), l.DateOfBirth, 103),
				l.PlanLearnHours,
				l.PlanEEPHours,
				ISNULL(l.PlanLearnHours,0)+ISNULL(l.PlanEEPHours,0) AS [TotalPlannedHours],
				lefa.RateBand,
				CASE WHEN lefa.StartFund = 1 THEN 'Y' ELSE 'N' END,
				lefa.OnProgPayment,
				'OFFICIAL-SENSITIVE',
				SortOrder = CASE	WHEN lefa.Fundline= '14-16 Direct Funded Students' THEN 1
									WHEN lefa.Fundline= '16-19 Students (excluding High Needs Students)' THEN 2
									WHEN lefa.Fundline= '16-19 High Needs Students' THEN 3
									WHEN lefa.Fundline= '19-24 Students with an EHCP' THEN 4
									WHEN lefa.Fundline= '19+ Continuing Students (excluding EHCP)' THEN 5									
							ELSE 6 END,
						lefa.LearnerStartDate,
						[ProvSpecLearnMon].[A] AS ProvSpecMon_A,
						[ProvSpecLearnMon].[B] AS ProvSpecMon_B
			FROM valid.Learner l WITH (NOLOCK) 
			INNER JOIN Valid.LearningDelivery LD ON L.[LearnRefNumber] = LD.[LearnRefNumber] AND LD.FUNDMODEL=25 			
			INNER JOIN [LearnDelFAM_CTE] [LDFAM] ON	[LDFAM].[AimSeqNumber] = [LD].[AimSeqNumber] AND [LDFAM].[LearnRefNumber] = [LD].[LearnRefNumber] AND [LDFAM].[SOF] = 107
			LEFT JOIN [ProvSpecLearnMon_CTE] [ProvSpecLearnMon] ON [ProvSpecLearnMon].[LearnRefNumber] = [LD].[LearnRefNumber]
			INNER JOIN Rulebase.FM25_Learner lefa  WITH (NOLOCK) ON lefa.LearnRefNumber = l.LearnRefNumber 
			WHERE 
				lefa.Fundline IN ('14-16 Direct Funded Students',
											'16-19 Students (excluding High Needs Students)',
											'16-19 High Needs Students',
											'19-24 Students with an EHCP',
											'19+ Continuing Students (excluding EHCP)')
											

END

GO