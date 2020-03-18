if not exists(select * from sys.schemas where name = 'Rulebase')
begin
	exec('create schema Rulebase')
end
go

if object_id('Rulebase.EFA_Get_Cases', 'p') is not null
begin
	drop procedure Rulebase.EFA_Get_Cases
end
go

create procedure Rulebase.EFA_Get_Cases as 
begin
	select	CaseData
	from	Rulebase.EFA_Cases
end	
go

if object_id('Rulebase.EFA_Insert_Cases','p') is not null
begin
	drop procedure Rulebase.EFA_Insert_Cases
end
go

create procedure Rulebase.EFA_Insert_Cases
as begin
	insert into Rulebase.EFA_Cases (
		[LearnRefNumber],
		[CaseData]
	)
	select	controller.LearnRefNumber,
			CONVERT ( xml, (select	[areaCost].FundingFactorValue as [@AreaCostFactor1618],
									disadProportion.FundingFactorValue as [@DisadvantageProportion],
									progProp.FundingFactorValue as [@HistoricLargeProgrammeProportion],
									[LARS_Current_Version].[CurrentVersion] as [@LARSVersion],
									[Org_Current_Version].[CurrentVersion] as [@OrgVersion],
									progCostFact.FundingFactorValue as [@ProgrammeWeighting],
									retFact.FundingFactorValue as [@RetentionFactor],						
									case when specialRes.FundingFactorValue = '1' then 'true' else 'false' end as [@SpecialistResources],
									lp.UKPRN as [@UKPRN],
									(select	l.[DateOfBirth] as [@DateOfBirth],
											l.[EngGrade] as [@EngGrade],
											l.[LearnRefNumber] as [@LearnRefNumber],
											learnDenorm.ECF as [@LrnFAM_ECF],
											learnDenorm.[EDF1] as [@LrnFAM_EDF1],
											learnDenorm.EDF2 as [@LrnFAM_EDF2],
											learnDenorm.EHC as [@LrnFAM_EHC],
											learnDenorm.HNS as [@LrnFAM_HNS],
											----v1: The Learning difficulty assessment (LDA) funding and monitoring type has been removed. 
											--learnDenorm.LDA as [@LrnFAM_LDA],
											 0 as [@LrnFAM_LDA], -- Until Ali investigates why this is still used, setting to zero
											learnDenorm.MCF as [@LrnFAM_MCF],
											l.[MathGrade] as [@MathGrade],
											l.[PlanEEPHours] as [@PlanEEPHours],
											l.[PlanLearnHours] as [@PlanLearnHours],
											case when l.[Postcode] = 'ZZ99 9ZZ' 
												then [Learner_EFA_PostcodeDisadvantage_Current_Postcode].[Uplift] 
												else [Learner_EFA_PostcodeDisadvantage].[Uplift] 
											end as [@PostcodeDisadvantageUplift],
											l.[ULN] as [@ULN],
											(select	ld.AimSeqNumber as [@AimSeqNumber],
													ld.AimType as [@AimType],
													lld.AwardOrgCode as [@AwardOrgCode],
													ld.CompStatus as [@CompStatus],
													lld.EFACOFType as [@EFACOFType],
													ld.FundModel as [@FundModel],
													ld.LearnActEndDate as [@LearnActEndDate],
													ld.LearnAimRef as [@LearnAimRef],
													lld.LearnAimRefTitle as [@LearnAimRfTitle],
													lld.LearnAimRefType as [@LearnAimRefType],
													ld.LearnPlanEndDate as [@LearnPlanEndDate],
													ld.LearnStartDate as [@LearnStartDate],
													ldd.LDFAM_SOF as [@LrnDelFAM_SOF],
													ldd.LDM1 as [@LearnDelFAM_LDM1],
													ldd.LDM2 as [@LearnDelFAM_LDM2],
													ldd.LDM3 as [@LearnDelFAM_LDM3],
													ldd.LDM4 as [@LearnDelFAM_LDM4],
													ld.ProgType as [@ProgType],
													lld.SectorSubjectAreaTier2 as [@SectorSubjectAreaTier2],
													ld.WithdrawReason as [@WithdrawReason],
													(select	lv.ValidityCategory as [@ValidityCategory],
															lv.LastNewStartDate as [@ValidityLastNewStartDate],
															lv.StartDate as [@ValidityStartDate]
													from	Reference.LARS_Validity as lv
													where	lv.LearnAimRef = ld.LearnAimRef
													for xml path('LearningDeliveryLARSValidity'), type)
											from	Valid.LearningDelivery as ld
														join Valid.LearningDeliveryDenorm as ldd
															on ldd.LearnRefNumber = ld.LearnRefNumber
															and ldd.AimSeqNumber = ld.AimSeqNumber
														left join Reference.LARS_LearningDelivery as lld
															on lld.LearnAimRef = ld.LearnAimRef												
											where	ld.LearnRefNumber = l.LearnRefNumber							
											for xml path('LearningDelivery'), type),
											(select	dp.[OutCode] as [@OutCode],
													dp.[OutType] as [@OutType]
											from	Valid.DPOutcome as dp
											where	dp.LearnRefNumber = l.LearnRefNumber
											for xml path('DPOutcome'), type)
									from	Valid.Learner as l
												join Valid.LearnerDenorm as learnDenorm
													on l.LearnRefNumber = learnDenorm.LearnRefNumber
												left join [Reference].[EFA_PostcodeDisadvantage] as [Learner_EFA_PostcodeDisadvantage]
													on [Learner_EFA_PostcodeDisadvantage].[Postcode]=l.[Postcode]
												left join [Reference].[EFA_PostcodeDisadvantage] as [Learner_EFA_PostcodeDisadvantage_Current_Postcode]
													on [Learner_EFA_PostcodeDisadvantage_Current_Postcode].[Postcode]=l.[Postcode]
												left join [Reference].[EFA_PostcodeDisadvantage] as pd
													on pd.Postcode = l.Postcode
													and pd.EffectiveTo is null												 
									where	l.LearnRefNumber = globalLearner.LearnRefNumber
									for xml path('Learner'), type)
							from	Valid.Learner as globalLearner
										cross join [Valid].[LearningProvider] as lp
										cross join [Reference].[LARS_Current_Version]			
										cross join Reference.Org_Current_Version			
										left join [Reference].[Org_Funding] as [areaCost]
											on [areaCost].[UKPRN] = lp.[UKPRN]
											and [areaCost].[FundingFactorType] = 'EFA 16-19'
											and [areaCost].[FundingFactor] = 'HISTORIC AREA COST FACTOR'
											and [areaCost].[EffectiveFrom] = '1-Aug-2017'
										left join [Reference].[Org_Funding] as disadProportion
											on disadProportion.[UKPRN]=lp.[UKPRN]
											and disadProportion.[FundingFactorType]='EFA 16-19'
											and disadProportion.[FundingFactor]='HISTORIC DISADVANTAGE FUNDING PROPORTION'
											and disadProportion.[EffectiveFrom]='1-Aug-2017'
										left join [Reference].[Org_Funding] as progProp
											on progProp.[UKPRN]=lp.[UKPRN]
											and progProp.[FundingFactorType]='EFA 16-19'
											and progProp.[FundingFactor]='HISTORIC LARGE PROGRAMME PROPORTION'
											and progProp.[EffectiveFrom]='1-Aug-2017'
										left join [Reference].[Org_Funding] as progCostFact
											on progCostFact.[UKPRN]=lp.[UKPRN]
											and progCostFact.[FundingFactorType]='EFA 16-19'
											and progCostFact.[FundingFactor]='HISTORIC PROGRAMME COST WEIGHTING FACTOR'
											and progCostFact.[EffectiveFrom]='1-Aug-2017'
										left join [Reference].[Org_Funding] as retFact
											on retFact.[UKPRN]=lp.[UKPRN]
											and retFact.[FundingFactorType]='EFA 16-19'
											and retFact.[FundingFactor]='HISTORIC RETENTION FACTOR'
											and retFact.[EffectiveFrom]='1-Aug-2017'
										left join [Reference].[Org_Funding] as specialRes
											on specialRes.[UKPRN]=lp.[UKPRN]
											and specialRes.[FundingFactorType]='EFA 16-19'
											and specialRes.[FundingFactor]='SPECIALIST RESOURCES'
							where	globalLearner.LearnRefNumber = controller.LearnRefNumber
							for xml path ('global'), type))
			from	(select	distinct
							LearnRefNumber
					from	Valid.LearningDelivery 
					where	FundModel = 25
		) as controller
end
go

if object_id('Rulebase.EFA_Insert_global', 'p') is not null
begin
	drop procedure Rulebase.EFA_Insert_global
end
go

create procedure Rulebase.EFA_Insert_global (
	@LARSVersion varchar(50),
	@OrgVersion varchar(50),
	@PostcodeDisadvantageVersion varchar(50),
	@RulebaseVersion varchar(10),
	@UKPRN int
) as
begin
	insert into Rulebase.EFA_global (
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

if object_id('Rulebase.EFA_Insert_Learner', 'p') is not null
begin
	drop procedure Rulebase.EFA_Insert_Learner
end
go

create procedure Rulebase.EFA_Insert_Learner (
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
	insert into Rulebase.EFA_Learner (
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
