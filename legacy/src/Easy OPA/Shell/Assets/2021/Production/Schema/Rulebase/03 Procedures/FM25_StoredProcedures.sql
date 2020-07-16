if not exists(select * from sys.schemas where name = 'Rulebase')
begin
	exec('create schema Rulebase')
end
go

if object_id('Rulebase.FM25_Get_Cases', 'p') is not null
begin
	drop procedure Rulebase.FM25_Get_Cases
end
go

create procedure Rulebase.FM25_Get_Cases as 
begin
	select	CaseData
	from	Rulebase.FM25_Cases C
	JOIN dbo.UKPRNForProcedures UFP
	ON UFP.UKPRN = C.UKPRN
end	
go

if object_id('Rulebase.FM25_Insert_Cases','p') is not null
begin
	drop procedure Rulebase.FM25_Insert_Cases
end
go

create procedure Rulebase.FM25_Insert_Cases
as 
begin
	insert into Rulebase.FM25_Cases (
		UKPRN,
		LearnRefNumber,
		CaseData
	)
	select controller.UKPRN,
			controller.LearnRefNumber,
							-- global
			CONVERT (xml,	(select	globalLearner.UKPRN as [@UKPRN],
									LARS_Current_Version.CurrentVersion as [@LARSVersion],
									Org_Current_Version.CurrentVersion as [@OrgVersion],
									areaCost.FundingFactorValue as [@AreaCostFactor1618],
									disadProportion.FundingFactorValue as [@DisadvantageProportion],
									progProp.FundingFactorValue as [@HistoricLargeProgrammeProportion],
									progCostFact.FundingFactorValue as [@ProgrammeWeighting],
									retFact.FundingFactorValue as [@RetentionFactor],
									disadLevel3.FundingFactorValue as [@Level3ProgMathsandEnglishProportion],
									case when specialRes.FundingFactorValue = '1' 
										then 'true' 
										else 'false'
									end as [@SpecialistResources],
									-- Postcode Specialist Resources
									(
									  SELECT
										PostcodeSpecResEffectiveFrom as [@PostcodeSpecResEffectiveFrom],
										PostcodeSpecResEffectiveTo as [@PostcodeSpecResEffectiveTo],
										PostcodeSpecResPostcode as [@PostcodeSpecResPostcode],
										PostcodeSpecResSpecialistResources as [@PostcodeSpecResSpecialistResources]
									  FROM
										Reference.PostcodeSpecialistResourceRefData
									  WHERE
										UKPRN = controller.UKPRN
										for xml path ('Postcode_Specialist_Resource_RefData'),
										type
									),
									-- learner
									(select	l.LearnRefNumber as [@LearnRefNumber],
											l.ULN as [@ULN],
											l.DateOfBirth as [@DateOfBirth],
											l.EngGrade as [@EngGrade],
											l.MathGrade as [@MathGrade],
											learnDenorm.ECF as [@LrnFAM_ECF],
											learnDenorm.EDF1 as [@LrnFAM_EDF1],
											learnDenorm.EDF2 as [@LrnFAM_EDF2],
											learnDenorm.EHC as [@LrnFAM_EHC],
											learnDenorm.HNS as [@LrnFAM_HNS],
											learnDenorm.MCF as [@LrnFAM_MCF],
											l.PlanEEPHours as [@PlanEEPHours],
											l.PlanLearnHours as [@PlanLearnHours],
											pd.Uplift as [@PostcodeDisadvantageUplift],
											(select	OutCode as [@OutCode],
													OutType as [@OutType]
											from	Valid.DPOutcome
											where	LearnRefNumber = l.LearnRefNumber
											AND UKPRN =l.UKPRN
											for xml path('DPOutcome'), type),
											(select	EffectiveFrom as [@EffectiveFrom],
													EffectiveTo as [@EffectiveTo],
													SpecialistResources as [@CampusFundingSpecialistResources]
											from Reference.CampusIdentifier_SpecialistResources
											where	CampusIdentifier = l.CampId
											for xml path ('Camps_Identifiers_Reference_DataFunding'), type),
											-- learning delivery
											(select	ld.LearnAimRef as [@LearnAimRef],
													ld.AimType as [@AimType],
													ld.AimSeqNumber as [@AimSeqNumber],
													ld.DelLocPostCode as [@DelLocPostCode],
													ld.FundModel as [@FundModel],
													ld.ProgType as [@ProgType],
													ld.LearnStartDate as [@LearnStartDate],
													ld.LearnPlanEndDate as [@LearnPlanEndDate],
													ld.LearnActEndDate as [@LearnActEndDate],
													ld.CompStatus as [@CompStatus],
													ld.WithdrawReason as [@WithdrawReason],
													lld.LearnAimRefTitle as [@LearnAimRefTitle],
													lld.LearnAimRefType as [@LearnAimRefType],
													lld.AwardOrgCode as [@AwardOrgCode],
													lld.EFACOFType as [@EFACOFType],
													lld.SectorSubjectAreaTier2 as [@SectorSubjectAreaTier2],
													lld.NotionalNVQLevel as [@NotionalNVQLevel],
													lld.GuidedLearningHours as [@GuidedLearningHours],
													ld.PHours as [@PHours],
													-- Add in inputs
													-- learning delivery fam
													(select	LearnDelFAMCode as [@LearnDelFAMCode],
															LearnDelFAMType as [@LearnDelFAMType],
															LearnDelFAMDateFrom as [@LearnDelFAMDateFrom],
															LearnDelFAMDateTo as [@LearnDelFAMDateTo]
													from	Valid.LearningDeliveryFAM
													where	LearnRefNumber = ld.LearnRefNumber
													AND UKPRN = ld.UKPRN
													and		AimSeqNumber = ld.AimSeqNumber
													for xml path('LearningDeliveryFAM'), type),
													-- learning delivery lars validity
													(select	ValidityCategory as [@ValidityCategory],
															LastNewStartDate as [@ValidityLastNewStartDate],
															StartDate as [@ValidityStartDate]
													from	Reference.LARS_Validity
													where	LearnAimRef = ld.LearnAimRef
													AND UKPRN = ld.UKPRN
													for xml path('LearningDeliveryLARSValidity'), type)
											from	Valid.LearningDelivery as ld
														left join Reference.LARS_LearningDelivery as lld
															on lld.LearnAimRef = ld.LearnAimRef
											where	ld.LearnRefNumber = l.LearnRefNumber
											AND ld.UKPRN = l.UKPRN
											for xml path('LearningDelivery'), type)
									from	Valid.Learner as l
											join Valid.LearnerDenormTbl as learnDenorm
		on l.LearnRefNumber = learnDenorm.LearnRefNumber
		and l.UKPRN = learnDenorm.UKPRN
	left join Reference.FM25_PostcodeDisadvantage as pd
		on pd.Postcode =
		CASE
			WHEN l.PostcodePrior = 'ZZ99 9ZZ' OR l.PostcodePrior = NULL THEN l.Postcode
			ELSE  l.PostcodePrior
		END
		and pd.EffectiveTo is null
									where	l.LearnRefNumber = globalLearner.LearnRefNumber
									AND l.UKPRN = globalLearner.UKPRN
									for xml path('Learner'), type)
							from	Valid.Learner as globalLearner
										--cross join Valid.LearningProvider as lp
										cross join Reference.LARS_Current_Version			
										cross join Reference.Org_Current_Version
										left join Reference.Org_Funding as areaCost
											on areaCost.UKPRN = globalLearner.UKPRN
											and areaCost.FundingFactorType = 'EFA 16-19'
											and areaCost.FundingFactor = 'HISTORIC AREA COST FACTOR'
											and areaCost.EffectiveFrom = '01-Aug-2020'
										left join Reference.Org_Funding as disadProportion
											on disadProportion.UKPRN = globalLearner.UKPRN
											and disadProportion.FundingFactorType = 'EFA 16-19'
											and disadProportion.FundingFactor = 'HISTORIC DISADVANTAGE FUNDING PROPORTION'
											and disadProportion.EffectiveFrom = '01-Aug-2020'
										left join Reference.Org_Funding as disadLevel3
											on disadLevel3.UKPRN = globalLearner.UKPRN
											and disadLevel3.FundingFactorType = 'EFA 16-19'
											and disadLevel3.FundingFactor = 'HISTORIC LEVEL 3 PROGRAMME MATHS AND ENGLISH PROPORTION'
											and disadLevel3.EffectiveFrom = '01-Aug-2020'
										left join Reference.Org_Funding as progProp
											on progProp.UKPRN = globalLearner.UKPRN
											and progProp.FundingFactorType = 'EFA 16-19'
											and progProp.FundingFactor = 'HISTORIC LARGE PROGRAMME PROPORTION'
											and progProp.EffectiveFrom = '01-Aug-2020'
										left join Reference.Org_Funding as progCostFact
											on progCostFact.UKPRN = globalLearner.UKPRN
											and progCostFact.FundingFactorType = 'EFA 16-19'
											and progCostFact.FundingFactor = 'HISTORIC PROGRAMME COST WEIGHTING FACTOR'
											and progCostFact.EffectiveFrom = '01-Aug-2020'
										left join Reference.Org_Funding as retFact
											on retFact.UKPRN = globalLearner.UKPRN
											and retFact.FundingFactorType = 'EFA 16-19'
											and retFact.FundingFactor = 'HISTORIC RETENTION FACTOR'
											and retFact.EffectiveFrom = '01-Aug-2020'
										left join Reference.Org_Funding as specialRes
											on specialRes.UKPRN = globalLearner.UKPRN
											and specialRes.FundingFactorType = 'EFA 16-19'
											and specialRes.FundingFactor = 'SPECIALIST RESOURCES'
											-- and specialRes.EffectiveFrom = '01-Aug-2013' <= this is the only funding factor that doesn't have an annual renewal??
							where	globalLearner.LearnRefNumber = controller.LearnRefNumber
							AND globalLearner.UKPRN = controller.UKPRN
							for xml path ('global'), type))
					from	(select	distinct
									ld.LearnRefNumber,
									ld.UKPRN
							from	Valid.LearningDelivery ld
							join [dbo].UKPRNForProcedures ufp
								on ufp.UKPRN = ld.UKPRN
							where	FundModel = 25
					) as controller
end
go

if object_id('Rulebase.FM25_Insert_global', 'p') is not null
begin
	drop procedure [Rulebase].[FM25_Insert_global]
end
go

create procedure [Rulebase].[FM25_Insert_global] (
	@LARSVersion varchar(50),
	@OrgVersion varchar(50),
	@PostcodeDisadvantageVersion varchar(50),
	@RulebaseVersion varchar(10),
	@UKPRN int
) as
begin
	insert into Rulebase.FM25_global (
		UKPRN,
		LARSVersion,
		OrgVersion,
		PostcodeDisadvantageVersion,
		RulebaseVersion
	) values (
		@UKPRN,
		@LARSVersion,
		@OrgVersion,
		@PostcodeDisadvantageVersion,
		@RulebaseVersion
	)
end
go

if object_id('Rulebase.FM25_Insert_Learner', 'p') is not null
begin
	drop procedure Rulebase.FM25_Insert_Learner
end
go

create procedure [Rulebase].[FM25_Insert_Learner] (
	@UKPRN int,
	@AcadMonthPayment int,
	@AcadProg bit,
	@ActualDaysILCurrYear int,
	@AreaCostFact1618Hist decimal(10,5),
	@Block1DisadvUpliftNew decimal(10,5),
	@Block2DisadvElementsNew decimal(10,5),
	@ConditionOfFundingEnglish varchar(100),
	@ConditionOfFundingMaths varchar(100),
	@CoreAimSeqNumber int,
	@FullTimeEquiv decimal(10,5),
	@FundLine varchar(100),
	@LearnerActEndDate date,
	@LearnerPlanEndDate date,
	@LearnerStartDate date,
	@LearnRefNumber varchar(12),
	@NatRate decimal(10,5),
	@OnProgPayment decimal(10,5),
	@PlannedDaysILCurrYear int,
	@ProgWeightHist decimal(10,5),
	@ProgWeightNew decimal(10,5),
	@PrvDisadvPropnHist decimal(10,5),
	@PrvHistLrgProgPropn decimal(10,5),
	@PrvRetentFactHist decimal(10,5),
	@RateBand varchar(50),
	@RetentNew decimal(10,5),
	@StartFund bit,
	@ThresholdDays int,
	@TLevelStudent bit,
	@PrvHistL3ProgMathEngProp decimal(10,5),
	@L3MathsEnglish1Year decimal(10,5),
	@L3MathsEnglish2Year decimal(10,5)
) as
begin
	insert into Rulebase.FM25_Learner (
		UKPRN,
		LearnRefNumber,
		AcadMonthPayment,
		AcadProg,
		ActualDaysILCurrYear,
		AreaCostFact1618Hist,
		Block1DisadvUpliftNew,
		Block2DisadvElementsNew,
		ConditionOfFundingEnglish,
		ConditionOfFundingMaths,
		CoreAimSeqNumber,
		FullTimeEquiv,
		FundLine,
		LearnerActEndDate,
		LearnerPlanEndDate,
		LearnerStartDate,
		NatRate,
		OnProgPayment,
		PlannedDaysILCurrYear,
		ProgWeightHist,
		ProgWeightNew,
		PrvDisadvPropnHist,
		PrvHistLrgProgPropn,
		PrvRetentFactHist,
		RateBand,
		RetentNew,
		StartFund,
		ThresholdDays,
		TLevelStudent,
		PrvHistL3ProgMathEngProp,
		L3MathsEnglish1Year,
		L3MathsEnglish2Year
	) values (
		@UKPRN,
		@LearnRefNumber,
		@AcadMonthPayment,
		@AcadProg,
		@ActualDaysILCurrYear,
		@AreaCostFact1618Hist,
		@Block1DisadvUpliftNew,
		@Block2DisadvElementsNew,
		@ConditionOfFundingEnglish,
		@ConditionOfFundingMaths,
		@CoreAimSeqNumber,
		@FullTimeEquiv,
		@FundLine,
		@LearnerActEndDate,
		@LearnerPlanEndDate,
		@LearnerStartDate,
		@NatRate,
		@OnProgPayment,
		@PlannedDaysILCurrYear,
		@ProgWeightHist,
		@ProgWeightNew,
		@PrvDisadvPropnHist,
		@PrvHistLrgProgPropn,
		@PrvRetentFactHist,
		@RateBand,
		@RetentNew,
		@StartFund,
		@ThresholdDays,
		@TLevelStudent,
		@PrvHistL3ProgMathEngProp,
		@L3MathsEnglish1Year,
		@L3MathsEnglish2Year
	)
end
go
