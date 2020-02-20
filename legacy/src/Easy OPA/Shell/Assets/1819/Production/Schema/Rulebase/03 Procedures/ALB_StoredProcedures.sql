if object_id('[Rulebase].[ALB_Get_Cases]','p') is not null
begin
	drop procedure [Rulebase].[ALB_Get_Cases]
end
go

create procedure [Rulebase].[ALB_Get_Cases] as
begin
	set nocount on
	select	CaseData
	from	[Rulebase].[ALB_Cases]
end
go

if object_id('[Rulebase].[ALB_Insert_Cases]','p') is not null
begin
	drop procedure [Rulebase].[ALB_Insert_Cases]
end
go

create procedure [Rulebase].[ALB_Insert_Cases] as
begin
	set nocount on

	insert into [Rulebase].[ALB_Cases] (
		[LearnRefNumber],
		CaseData
	)
	select	ControllingTable.[LearnRefNumber],
			convert(xml, (
				select	[LARS_Current_Version].[CurrentVersion] as [@LARSVersion],
						[SFA_PostcodeAreaCost_Current_Version].[CurrentVersion] as [@PostcodeAreaCostVersion],
						[LearningProvider].[UKPRN] as [@UKPRN],
						(select		[Learner].[LearnRefNumber] as [@LearnRefNumber],
									(select	[ldd].[AimSeqNumber] as [@AimSeqNumber],
											[ldd].[CompStatus] as [@CompStatus],
											[ldd].[LearnActEndDate] as [@LearnActEndDate],
											[lars_ld].[LearnAimRefType] as [@LearnAimRefType],
											[ldd].[FundModel] as [@LearnDelFundModel],
											[ldd].[LearnPlanEndDate] as [@LearnPlanEndDate],
											[ldd].[LearnStartDate] as [@LearnStartDate],
											adl.LearnDelFAMCode as [@LrnDelFAM_ADL],
											ldd.LDM1 as [@LrnDelFAM_LDM1],
											ldd.LDM2 as [@LrnDelFAM_LDM2],
											ldd.LDM3 as [@LrnDelFAM_LDM3],
											ldd.LDM4 as [@LrnDelFAM_LDM4],
											res.LearnDelFAMCode as [@LrnDelFAM_RES],
											[lars_ld].[NotionalNVQLevelv2] as [@NotionalNVQLevelv2],
											[ldd].[OrigLearnStartDate] as [@OrigLearnStartDate],
											[ldd].[OtherFundAdj] as [@OtherFundAdj],
											[ldd].[Outcome] as [@Outcome],
											[ldd].[PriorLearnFundAdj] as [@PriorLearnFundAdj],
											[lars_ld].[RegulatedCreditValue] as [@RegulatedCreditValue],
											(select	[LearnDelFAMCode] as [@LearnDelFAMCode],
													[LearnDelFAMDateFrom] as [@LearnDelFAMDateFrom],
													[LearnDelFAMDateTo] as [@LearnDelFAMDateTo],
													[LearnDelFAMType] as [@LearnDelFAMType]
											from	[Valid].[LearningDeliveryFAM]
											where	[LearnRefNumber] = [ldd].[LearnRefNumber]
											and		[AimSeqNumber] = [ldd].[AimSeqNumber]
											for xml path ('LearningDeliveryFAM'), type),
											(select	[EffectiveFrom] as [@AreaCosEffectiveFrom],
													[EffectiveTo] as [@AreaCosEffectiveTo],
													[AreaCostFactor] as [@AreaCosFactor]
											from	[Reference].[SFA_PostcodeAreaCost]
											where	[Postcode] = [ldd].[DelLocPostCode]
											for xml path ('SFA_PostcodeAreaCost'), type),
											(select	[FundingCategory] as [@LARSFundCategory],
													[EffectiveFrom] as [@LARSFundEffectiveFrom],
													[EffectiveTo] as [@LARSFundEffectiveTo],
													[RateWeighted] as [@LARSFundWeightedRate],
													[WeightingFactor] as [@LARSFundWeightingFactor]
											from	[Reference].[LARS_Funding]
											where	[LearnAimRef] = [ldd].[LearnAimRef]
											for xml path ('LearningDeliveryLARS_Funding'), type),
											(select	[AreaCode] as [@SubsidyPilotAreaCode],
													[EffectiveFrom] as [@SubsidyPilotEffectiveFrom],
													[EffectiveTo] as [@SubsidyPilotEffectiveTo]
											from	[Reference].[CareerLearningPilot_Postcode]
											where	[Postcode] = [ldd].[DelLocPostCode]
											for xml path ('SubsidyPilotPostcodeArea'), type),
											(select	[AreaCode] as [@LearnDelLARSCarPilFundAreaCode],
													[EffectiveTo] as [@LearnDelLARSCarPilFundEffToDate],
													[EffectiveFrom] as [@LearnDelLARSCarPilFundEffFromDate],
													[SubsidyRate] as [@LearnDelLARSCarPilFundSubsidyRate]
											from	[Reference].[LARS_CareerLearningPilot]
											where	[LearnAimRef] = [ldd].[LearnAimRef]
											for xml path ('LARS_CareerLearningPilot'), type)
									from	[Valid].[LearningDeliveryDenormTbl] as ldd
												left join [Reference].[LARS_LearningDelivery] as lars_ld
													on [lars_ld].[LearnAimRef] = [ldd].[LearnAimRef]
												left join (select	sld.LearnRefNumber,
																	sld.LearnDelFAMCode,
																	sld.AimSeqNumber
															from	Valid.LearningDeliveryFAM as sld
															where	sld.LearnDelFAMType = 'RES') as res
													on res.AimSeqNumber = ldd.AimSeqNumber and res.LearnRefNumber = ldd.LearnRefNumber
												left join (select	sld.LearnRefNumber,
																	sld.LearnDelFAMCode,
																	sld.AimSeqNumber
															from	Valid.LearningDeliveryFAM as sld
															where	sld.LearnDelFAMType = 'ADL') as adl
													on adl.AimSeqNumber = ldd.AimSeqNumber and adl.LearnRefNumber = ldd.LearnRefNumber
									where	[ldd].[LearnRefNumber] = [Learner].[LearnRefNumber]
									and		[ldd].[FundModel] in (99, 81)
									for xml path ('LearningDelivery'), type)
						from	[Valid].[Learner]
						where	[Learner].[LearnRefNumber] = [ControllingTable].[LearnRefNumber]
						for xml path ('Learner'), type)
				from	[Valid].[LearningProvider]
							cross join [Reference].[LARS_Current_Version]
							cross join [Reference].[SFA_PostcodeAreaCost_Current_Version]
				for xml path ('global'), type))
	from	[Valid].[Learner] ControllingTable
				inner join (select	distinct
									[LearnRefNumber]
							from	[Valid].[LearningDelivery]
							where	[FundModel] in (99, 81)) as [Filter_LearningDelivery]
					on [Filter_LearningDelivery].[LearnRefNumber] = [ControllingTable].[LearnRefNumber]
end
go

if object_id('[Rulebase].[ALB_Insert_global]','p') is not null
begin
	drop procedure [Rulebase].[ALB_Insert_global]
end
go

create procedure [Rulebase].[ALB_Insert_global] (
	@UKPRN int,
	@LARSVersion varchar(100),
	@PostcodeAreaCostVersion varchar(20),
	@RulebaseVersion varchar(10)
) as
begin
	set nocount on
	insert into [Rulebase].[ALB_global] (
		UKPRN,
		LARSVersion,
		PostcodeAreaCostVersion,
		RulebaseVersion
	) values (
		@UKPRN,
		@LARSVersion,
		@PostcodeAreaCostVersion,
		@RulebaseVersion
	)
end
go

if object_id('[Rulebase].[ALB_Insert_Learner]','p') is not null
begin
	drop procedure [Rulebase].[ALB_Insert_Learner]
end
go

create procedure [Rulebase].[ALB_Insert_Learner] (
	@LearnRefNumber varchar(12),
	@ALBSeqNum int
) as
begin
	set nocount on
	-- nothing is persisted here, this is just required for OPA 
end
go

if object_id('[Rulebase].[ALB_Insert_Learner_PeriodisedValues]','p') is not null
begin
	drop procedure [Rulebase].[ALB_Insert_Learner_PeriodisedValues]
end
go

create procedure [Rulebase].[ALB_Insert_Learner_PeriodisedValues] (
	@LearnRefNumber varchar(12),
	@AttributeName varchar(100),
	@Period_1 decimal(15,5),
	@Period_2 decimal(15,5),
	@Period_3 decimal(15,5),
	@Period_4 decimal(15,5),
	@Period_5 decimal(15,5),
	@Period_6 decimal(15,5),
	@Period_7 decimal(15,5),
	@Period_8 decimal(15,5),
	@Period_9 decimal(15,5),
	@Period_10 decimal(15,5),
	@Period_11 decimal(15,5),
	@Period_12 decimal(15,5)
) as
begin
	set nocount on
	insert into [Rulebase].[ALB_Learner_PeriodisedValues] (
		LearnRefNumber,
		AttributeName,
		Period_1,
		Period_2,
		Period_3,
		Period_4,
		Period_5,
		Period_6,
		Period_7,
		Period_8,
		Period_9,
		Period_10,
		Period_11,
		Period_12
	) values (
		@LearnRefNumber,
		@AttributeName,
		@Period_1,
		@Period_2,
		@Period_3,
		@Period_4,
		@Period_5,
		@Period_6,
		@Period_7,
		@Period_8,
		@Period_9,
		@Period_10,
		@Period_11,
		@Period_12
	)
end
go

if object_id('[Rulebase].[ALB_PivotTemporals_Learner]','p') is not null
begin
	drop procedure [Rulebase].[ALB_PivotTemporals_Learner]
end
go

create procedure [Rulebase].[ALB_PivotTemporals_Learner] as
begin
	truncate table [Rulebase].[ALB_Learner_Period]

	insert into [Rulebase].[ALB_Learner_Period]
	select	LearnRefNumber,
			[Period],
			max(case AttributeName when 'ALBSeqNum' then Value else null end) as ALBSeqNum
	from	(select	LearnRefNumber,
					AttributeName,
					cast(substring([PeriodValue].[Period], 8, 2) as int) as [Period],
					[PeriodValue].[Value]
			from	[Rulebase].[ALB_Learner_PeriodisedValues]
						unpivot ([Value] for [Period] in (Period_1, Period_2, Period_3, Period_4, Period_5, Period_6, Period_7, Period_8, Period_9, Period_10, Period_11, Period_12)) as PeriodValue
			) as UnrequiredAlias
	group by
			LearnRefNumber,
			[Period]
end
go

if object_id('[Rulebase].[ALB_Insert_LearningDelivery]','p') is not null
begin
	drop procedure [Rulebase].[ALB_Insert_LearningDelivery]
end
go

create procedure [Rulebase].[ALB_Insert_LearningDelivery] (
	@LearnRefNumber varchar(12),
	@AimSeqNumber int,
	@AreaCostFactAdj decimal(10,5),
	@WeightedRate decimal(12,5),
	@PlannedNumOnProgInstalm int,
	@FundStart bit,
	@Achieved bit,
	@ActualNumInstalm int,
	@OutstndNumOnProgInstalm int,
	@AreaCostInstalment decimal(12,5),
	@AdvLoan bit,
	@LoanBursAreaUplift bit,
	@LoanBursSupp bit,
	@FundLine varchar(50),
	@LiabilityDate date,
	@ApplicProgWeightFact varchar(1),
	@ApplicFactDate date,
	@LearnDelEligCareerLearnPilot bit,
	@LearnDelApplicSubsidyPilotAreaCode	varchar(50),
	@LearnDelApplicLARSCarPilFundSubRate decimal(12,5),
	@LearnDelCarLearnPilotAimValue decimal(12,5),
	@LearnDelCarLearnPilotInstalAmount	decimal(12,5),
	@AreaUpliftOnProgPayment decimal(12,5),
	@AreaUpliftBalPayment decimal(12,5),
	@ALBCode int,
	@ALBSupportPayment decimal(12,5),
	@LearnDelCarLearnPilotOnProgPayment decimal(12,5),
	@LearnDelCarLearnPilotBalPayment decimal(12,5)
) as
begin
	set nocount on
	insert into [Rulebase].[ALB_LearningDelivery] (
		LearnRefNumber,
		AimSeqNumber,
		AreaCostFactAdj,
		WeightedRate,
		PlannedNumOnProgInstalm,
		FundStart,
		Achieved,
		ActualNumInstalm,
		OutstndNumOnProgInstalm,
		AreaCostInstalment,
		AdvLoan,
		LoanBursAreaUplift,
		LoanBursSupp,
		FundLine,
		LiabilityDate,
		ApplicProgWeightFact,
		ApplicFactDate,
		LearnDelEligCareerLearnPilot,
		LearnDelApplicSubsidyPilotAreaCode,
		LearnDelApplicLARSCarPilFundSubRate,
		LearnDelCarLearnPilotAimValue,
		LearnDelCarLearnPilotInstalAmount
	) values (
		@LearnRefNumber,
		@AimSeqNumber,
		@AreaCostFactAdj,
		@WeightedRate,
		@PlannedNumOnProgInstalm,
		@FundStart,
		@Achieved,
		@ActualNumInstalm,
		@OutstndNumOnProgInstalm,
		@AreaCostInstalment,
		@AdvLoan,
		@LoanBursAreaUplift,
		@LoanBursSupp,
		@FundLine,
		@LiabilityDate,
		@ApplicProgWeightFact,
		@ApplicFactDate,
		@LearnDelEligCareerLearnPilot,
		@LearnDelApplicSubsidyPilotAreaCode,
		@LearnDelApplicLARSCarPilFundSubRate,
		@LearnDelCarLearnPilotAimValue,
		@LearnDelCarLearnPilotInstalAmount
	)
end
go

if object_id('[Rulebase].[ALB_Insert_LearningDelivery_PeriodisedValues]','p') is not null
begin
	drop procedure [Rulebase].[ALB_Insert_LearningDelivery_PeriodisedValues]
end
go

create procedure [Rulebase].[ALB_Insert_LearningDelivery_PeriodisedValues] (
	@LearnRefNumber varchar(12),
	@AimSeqNumber int,
	@AttributeName varchar(100),
	@Period_1 decimal(15,5),
	@Period_2 decimal(15,5),
	@Period_3 decimal(15,5),
	@Period_4 decimal(15,5),
	@Period_5 decimal(15,5),
	@Period_6 decimal(15,5),
	@Period_7 decimal(15,5),
	@Period_8 decimal(15,5),
	@Period_9 decimal(15,5),
	@Period_10 decimal(15,5),
	@Period_11 decimal(15,5),
	@Period_12 decimal(15,5)
) as
begin
	set nocount on
	insert into [Rulebase].[ALB_LearningDelivery_PeriodisedValues] (
		LearnRefNumber,
		AimSeqNumber,
		AttributeName,
		Period_1,
		Period_2,
		Period_3,
		Period_4,
		Period_5,
		Period_6,
		Period_7,
		Period_8,
		Period_9,
		Period_10,
		Period_11,
		Period_12
	) values (
		@LearnRefNumber,
		@AimSeqNumber,
		@AttributeName,
		@Period_1,
		@Period_2,
		@Period_3,
		@Period_4,
		@Period_5,
		@Period_6,
		@Period_7,
		@Period_8,
		@Period_9,
		@Period_10,
		@Period_11,
		@Period_12
	)
end
go

if object_id('[Rulebase].[ALB_PivotTemporals_LearningDelivery]','p') is not null
begin
	drop procedure [Rulebase].[ALB_PivotTemporals_LearningDelivery]
end
go

create procedure [Rulebase].[ALB_PivotTemporals_LearningDelivery] as
begin
	truncate table [Rulebase].[ALB_LearningDelivery_Period]

	insert into [Rulebase].[ALB_LearningDelivery_Period]
	select	LearnRefNumber,
			AimSeqNumber,
			[Period],
			max(case AttributeName when 'AreaUpliftOnProgPayment' then [Value] else null end) as AreaUpliftOnProgPayment,
			max(case AttributeName when 'AreaUpliftBalPayment' then [Value] else null end) as AreaUpliftBalPayment,
			max(case AttributeName when 'ALBCode' then [Value] else null end) as ALBCode,
			max(case AttributeName when 'ALBSupportPayment' then [Value] else null end) as ALBSupportPayment,
			max(case AttributeName when 'LearnDelCarLearnPilotOnProgPayment' then [Value] else null end) as LearnDelCarLearnPilotOnProgPayment,
			max(case AttributeName when 'LearnDelCarLearnPilotBalPayment' then [Value] else null end) as LearnDelCarLearnPilotBalPayment
	from	(select	LearnRefNumber,
					AimSeqNumber,
					AttributeName,
					cast(substring([PeriodValue].[Period], 8, 2) as int) as [Period],
					[PeriodValue].[Value]
			from	[Rulebase].[ALB_LearningDelivery_PeriodisedValues]
						unpivot ([Value] for [Period] in (Period_1, Period_2, Period_3, Period_4, Period_5, Period_6, Period_7, Period_8, Period_9, Period_10, Period_11, Period_12)) as PeriodValue
			) as UnrequiredAlias
	group by
			LearnRefNumber,
			AimSeqNumber,
			[Period]
end
go
