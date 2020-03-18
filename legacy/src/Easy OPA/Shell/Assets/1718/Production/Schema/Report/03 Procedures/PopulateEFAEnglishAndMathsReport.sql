IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[PopulateEFAMathsAndEnglishReport]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[PopulateEFAMathsAndEnglishReport]
GO

CREATE PROCEDURE [Report].[PopulateEFAMathsAndEnglishReport]
AS
BEGIN
	-- Clear previous report data - needed by FIS
	TRUNCATE TABLE [Report].[EFAMathsAndEnglishReportValues]

	;WITH ProvSpecLearnMon_CTE AS 
	(
		SELECT ProvSpecLearnMon.* FROM [Valid].[ProviderSpecLearnerMonitoring] PIVOT (MAX(ProvSpecLearnMon) FOR ProvSpecLearnMonOccur IN ([A],[B]))AS ProvSpecLearnMon
	)
	-- Populate [Report].[EFAMathsAndEnglishReportValues]
	INSERT INTO [Report].[EFAMathsAndEnglishReportValues]
		SELECT
			[FundLine],
			[LearnRefNumber],
			[FamilyName],
			[GivenNames],
			[DateOfBirth],
			[ConditionOfFundingMaths],
			[ConditionOfFundingEnglish],
			[RateBand],
			[SecurityClassification],
			[SortOrder],
			[LearnerStartDate],
			[ProvSpecMon_A],
			[ProvSpecMon_B]
		FROM (
			SELECT DISTINCT
				lefa.FundLine AS [FundLine],
				l.LearnRefNumber AS [LearnRefNumber],
				l.FamilyName AS [FamilyName], 
				l.GivenNames AS [GivenNames],
				CONVERT(VARCHAR(10), l.DateOfBirth, 103) AS [DateOfBirth],
				lefa.ConditionOfFundingMaths AS [ConditionOfFundingMaths],
				lefa.ConditionOfFundingEnglish AS [ConditionOfFundingEnglish],
				lefa.RateBand AS [RateBand],
				'OFFICIAL-SENSITIVE' AS [SecurityClassification],
				(CASE
					WHEN lefa.Fundline= '14-16 Direct Funded Students' THEN 1
					WHEN lefa.Fundline= '16-19 Students (excluding High Needs Students)' THEN 2
					WHEN lefa.Fundline= '16-19 High Needs Students' THEN 3
					WHEN lefa.Fundline= '19-24 Students with an EHCP' THEN 4					
					WHEN lefa.Fundline= '19+ Continuing Students (excluding EHCP)' THEN 5
					ELSE 6
				END) AS [SortOrder],
				lefa.LearnerStartDate AS [LearnerStartDate],
				[ProvSpecLearnMon].[A] AS [ProvSpecMon_A],
				[ProvSpecLearnMon].[B] AS [ProvSpecMon_B]
			FROM [Valid].[Learner] l WITH (NOLOCK) 
			LEFT JOIN [ProvSpecLearnMon_CTE] [ProvSpecLearnMon] ON [ProvSpecLearnMon].[LearnRefNumber] = [L].[LearnRefNumber]
				JOIN [Rulebase].[EFA_Learner] lefa  WITH (NOLOCK) ON lefa.LearnRefNumber = l.LearnRefNumber WHERE lefa.StartFund = 1
					AND lefa.Fundline IN ('14-16 Direct Funded Students',
											'16-19 Students (excluding High Needs Students)',
											'16-19 High Needs Students',
											'19-24 Students with an EHCP',											
											'19+ Continuing Students (excluding EHCP)')
		) EFAEnglishAndMaths
END

GO