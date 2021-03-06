﻿if not exists(select * from sys.schemas where name = 'Rulebase')
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
	from	Rulebase.FM25_Cases
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
		LearnRefNumber,
		CaseData
	)
	select	controller.LearnRefNumber,
							-- global
			CONVERT (xml,	(select	lp.UKPRN as [@UKPRN],
									LARS_Current_Version.CurrentVersion as [@LARSVersion],
									Org_Current_Version.CurrentVersion as [@OrgVersion],
									areaCost.FundingFactorValue as [@AreaCostFactor1618],
									disadProportion.FundingFactorValue as [@DisadvantageProportion],
									progProp.FundingFactorValue as [@HistoricLargeProgrammeProportion],
									progCostFact.FundingFactorValue as [@ProgrammeWeighting],
									retFact.FundingFactorValue as [@RetentionFactor],						
									case when specialRes.FundingFactorValue = '1' 
										then 'true' 
										else 'false'
									end as [@SpecialistResources],
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
											case when l.Postcode = 'ZZ99 9ZZ' 
												then Learner_FM25_PostcodeDisadvantage_Prior_Postcode.Uplift 
												else Learner_FM25_PostcodeDisadvantage.Uplift
											end as [@PostcodeDisadvantageUplift],
											(select	OutCode as [@OutCode],
													OutType as [@OutType]
											from	Valid.DPOutcome
											where	LearnRefNumber = l.LearnRefNumber
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
													-- learning delivery fam
													(select	LearnDelFAMCode as [@LearnDelFAMCode],
															LearnDelFAMType as [@LearnDelFAMType],
															LearnDelFAMDateFrom as [@LearnDelFAMDateFrom],
															LearnDelFAMDateTo as [@LearnDelFAMDateTo]
													from	Valid.LearningDeliveryFAM
													where	LearnRefNumber = ld.LearnRefNumber
													and		AimSeqNumber = ld.AimSeqNumber
													for xml path('LearningDeliveryFAM'), type),
													-- learning delivery lars validity
													(select	ValidityCategory as [@ValidityCategory],
															LastNewStartDate as [@ValidityLastNewStartDate],
															StartDate as [@ValidityStartDate]
													from	Reference.LARS_Validity
													where	LearnAimRef = ld.LearnAimRef
													for xml path('LearningDeliveryLARSValidity'), type)
											from	Valid.LearningDelivery as ld
														left join Reference.LARS_LearningDelivery as lld
															on lld.LearnAimRef = ld.LearnAimRef
											where	ld.LearnRefNumber = l.LearnRefNumber
											for xml path('LearningDelivery'), type)
									from	Valid.Learner as l
												join Valid.LearnerDenorm as learnDenorm
													on l.LearnRefNumber = learnDenorm.LearnRefNumber

												-- i moved one side to postcode prior CME: 2019-08-07
												left join Reference.FM25_PostcodeDisadvantage as Learner_FM25_PostcodeDisadvantage
													on Learner_FM25_PostcodeDisadvantage.Postcode = l.Postcode
												left join Reference.FM25_PostcodeDisadvantage as Learner_FM25_PostcodeDisadvantage_Prior_Postcode
													on Learner_FM25_PostcodeDisadvantage_Prior_Postcode.Postcode = l.PostcodePrior
												
												left join Reference.FM25_PostcodeDisadvantage as pd
													on pd.Postcode = l.Postcode
													and pd.EffectiveTo is null
									where	l.LearnRefNumber = globalLearner.LearnRefNumber
									for xml path('Learner'), type)
							from	Valid.Learner as globalLearner
										cross join Valid.LearningProvider as lp
										cross join Reference.LARS_Current_Version			
										cross join Reference.Org_Current_Version
										left join Reference.Org_Funding as areaCost
											on areaCost.UKPRN = lp.UKPRN
											and areaCost.FundingFactorType = 'EFA 16-19'
											and areaCost.FundingFactor = 'HISTORIC AREA COST FACTOR'
											and areaCost.EffectiveFrom = '01-Aug-2019'
										left join Reference.Org_Funding as disadProportion
											on disadProportion.UKPRN = lp.UKPRN
											and disadProportion.FundingFactorType = 'EFA 16-19'
											and disadProportion.FundingFactor = 'HISTORIC DISADVANTAGE FUNDING PROPORTION'
											and disadProportion.EffectiveFrom = '01-Aug-2019'
										left join Reference.Org_Funding as progProp
											on progProp.UKPRN = lp.UKPRN
											and progProp.FundingFactorType = 'EFA 16-19'
											and progProp.FundingFactor = 'HISTORIC LARGE PROGRAMME PROPORTION'
											and progProp.EffectiveFrom = '01-Aug-2019'
										left join Reference.Org_Funding as progCostFact
											on progCostFact.UKPRN = lp.UKPRN
											and progCostFact.FundingFactorType = 'EFA 16-19'
											and progCostFact.FundingFactor = 'HISTORIC PROGRAMME COST WEIGHTING FACTOR'
											and progCostFact.EffectiveFrom = '01-Aug-2019'
										left join Reference.Org_Funding as retFact
											on retFact.UKPRN = lp.UKPRN
											and retFact.FundingFactorType = 'EFA 16-19'
											and retFact.FundingFactor = 'HISTORIC RETENTION FACTOR'
											and retFact.EffectiveFrom = '01-Aug-2019'
										left join Reference.Org_Funding as specialRes
											on specialRes.UKPRN = lp.UKPRN
											and specialRes.FundingFactorType = 'EFA 16-19'
											and specialRes.FundingFactor = 'SPECIALIST RESOURCES'
											-- and specialRes.EffectiveFrom = '01-Aug-2013' <= this is the only funding factor that doesn't have an annual renewal??
							where	globalLearner.LearnRefNumber = controller.LearnRefNumber 
							for xml path ('global'), type))
					from	(select	distinct
									LearnRefNumber
							from	Valid.LearningDelivery
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
	@ThresholdDays int
) as
begin
	insert into Rulebase.FM25_Learner (
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
		ThresholdDays
	) values (
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
		@ThresholdDays
	)
end
go
