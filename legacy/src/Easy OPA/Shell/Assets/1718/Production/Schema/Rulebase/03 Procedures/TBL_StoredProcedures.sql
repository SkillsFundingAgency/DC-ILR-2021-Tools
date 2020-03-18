if object_id('[Rulebase].[TBL_Get_Cases]','p') is not null
	drop procedure [Rulebase].[TBL_Get_Cases]
GO


create procedure [Rulebase].[TBL_Get_Cases] as

	begin
		set nocount on
		select
			CaseData
		from
			[Rulebase].[TBL_Cases]
	end
GO
if object_id('[Rulebase].[TBL_Insert_Cases]','p') is not null
	drop procedure [Rulebase].[TBL_Insert_Cases]
GO


create procedure [Rulebase].[TBL_Insert_Cases] as

	begin
		set nocount on

		insert into
			[Rulebase].[TBL_Cases]
			(
				[LearnRefNumber],
				CaseData
			)
		select
			[Filter_LearningDelivery].[LearnRefNumber],
			convert(xml,
				(
					select
						[LARS_Current_Version].[CurrentVersion] as [@LARSVersion],
						[LearningProvider].[UKPRN] as [@UKPRN],
						(
							select
								[Learner].[DateOfBirth] as [@DateOfBirth],
								[Learner].[LearnRefNumber] as [@LearnRefNumber],
								(
									select
										[LearningDelivery].[AchDate] as [@AchDate],
										[LearningDelivery].[AimSeqNumber] as [@AimSeqNumber],
										[LearningDelivery].[AimType] as [@AimType],
										[LearningDelivery].[CompStatus] as [@CompStatus],
										[LARS_LearningDelivery].[FrameworkCommonComponent] as [@FrameworkCommonComponent],
										[LearningDelivery].[LearnActEndDate] as [@LearnActEndDate],
										[LearningDelivery].[LearnAimRef] as [@LearnAimRef],
										[LearningDelivery].[LearnPlanEndDate] as [@LearnPlanEndDate],
										[LearningDelivery].[LearnStartDate] as [@LearnStartDate],
										eef.LearnDelFAMCode as [@LrnDelFAM_EEF],
										ffi.LearnDelFAMCode as [@LrnDelFAM_FFI],
										LDM.LDM1 as [@LrnDelFAM_LDM1],
										LDM.LDM2 as [@LrnDelFAM_LDM2],
										LDM.LDM3 as [@LrnDelFAM_LDM3],
										LDM.LDM4 as [@LrnDelFAM_LDM4],
										res.LearnDelFAMCode as [@LrnDelFAM_RES],
										sof.SOF as [@LrnDelFAM_SOF],
										spp.LearnDelFAMCode as [@LrnDelFAM_SPP],
										[LearningDelivery].[OrigLearnStartDate] as [@OrigLearnStartDate],
										[LearningDelivery].[OtherFundAdj] as [@OtherFundAdj],
										[LearningDelivery].[Outcome] as [@Outcome],
										[LearningDelivery].[PriorLearnFundAdj] as [@PriorLearnFundAdj],
										[LearningDelivery].[ProgType] as [@ProgType],
										[LearningDelivery].[StdCode] as [@STDCode],
										[LearningDelivery].[WithdrawReason] as [@WithdrawReason],
										(
											select
												[AppFinRecord].[AFinAmount] as [@AFinAmount],
												[AppFinRecord].[AFinCode] as [@AFinCode],
												AppFinRecord.[AFinDate] as [@AFinDate],
												AppFinRecord.[AFinType] as [@AFinType]
											from
												[Valid].[AppFinRecord]
											where
												[AppFinRecord].[LearnRefNumber] = [LearningDelivery].[LearnRefNumber]
												and [AppFinRecord].[AimSeqNumber] = [LearningDelivery].[AimSeqNumber]
											for xml path ('ApprenticeshipFinancialRecord'), type
										),
										(
											select
												[LearningDeliveryFAM].[LearnDelFAMCode] as [@LearnDelFAMCode],
												[LearningDeliveryFAM].[LearnDelFAMDateFrom] as [@LearnDelFAMDateFrom],
												[LearningDeliveryFAM].[LearnDelFAMDateTo] as [@LearnDelFAMDateTo],
												[LearningDeliveryFAM].[LearnDelFAMType] as [@LearnDelFAMType]
											from
												[Valid].[LearningDeliveryFAM]
											where
												[LearningDeliveryFAM].[LearnRefNumber] = [LearningDelivery].[LearnRefNumber]
												and [LearningDeliveryFAM].[AimSeqNumber] = [LearningDelivery].[AimSeqNumber]
											for xml path ('LearningDeliveryFAM'), type
										),
										(
											select
												[LARS_StandardCommonComponent].[CommonComponent] as [@LARSCommonComponent],
												[LARS_StandardCommonComponent].[EffectiveFrom] as [@LARSEffectiveFrom],
												[LARS_StandardCommonComponent].[EffectiveTo] as [@LARSEffectiveTo],
												[LARS_StandardCommonComponent].[StandardCode] as [@LARSStandardCode]
											from
												[Reference].[LARS_StandardCommonComponent]
											where
												[LARS_StandardCommonComponent].[StandardCode]=[LearningDelivery].[StdCode]
											for xml path ('LARS_StandardCommonComponent'), type
										),
										(
											select
												[LARS_StandardFunding].[FundableWithoutEmployer] as [@FundableWithoutEmployer],
												[LARS_StandardFunding].[1618Incentive] as [@SF1618Incentive],
												[LARS_StandardFunding].[AchievementIncentive] as [@SFAchIncentive],
												[LARS_StandardFunding].[CoreGovContributionCap] as [@SFCoreGovContCap],
												[LARS_StandardFunding].[EffectiveFrom] as [@SFEffectiveFromDate],
												[LARS_StandardFunding].[EffectiveTo] as [@SFEffectiveToDate],
												[LARS_StandardFunding].[SmallBusinessIncentive] as [@SFSmallBusIncentive]
											from
												[Reference].[LARS_StandardFunding]
											where
												[LARS_StandardFunding].[StandardCode]=[LearningDelivery].[StdCode]
												and [LARS_StandardFunding].[FundingCategory]='StandardTblazer'
											for xml path ('LARS_StandardFunding'), type
										)
									from
										[Valid].[LearningDelivery]
										left join [Reference].[LARS_LearningDelivery]
											on [LARS_LearningDelivery].[LearnAimRef]=[LearningDelivery].[LearnAimRef]
										left join
										(
											select
												[LearnRefNumber],
												max([LDM1]) as [LDM1],
												max([LDM2]) as [LDM2],
												max([LDM3]) as [LDM3],
												max([LDM4]) as [LDM4]
											from
												(
													select
														LearnRefNumber,
														case row_number() over (partition by [LearnRefNumber] order by [LearnRefNumber]) when 1 then LearnDelFAMCode else null end  as [LDM1],
														case row_number() over (partition by [LearnRefNumber] order by [LearnRefNumber]) when 2 then LearnDelFAMCode else null end  as [LDM2],
														case row_number() over (partition by [LearnRefNumber] order by [LearnRefNumber]) when 3 then LearnDelFAMCode else null end  as [LDM3],
														case row_number() over (partition by [LearnRefNumber] order by [LearnRefNumber]) when 4 then LearnDelFAMCode else null end  as [LDM4]
													from
														[Valid].[LearningDeliveryFAM]
													where
														[LearnDelFAMType]='LDM'
												) as [LDMs]
											group by
												[LearnRefNumber]
										) as [LDM]
										on [LDM].[LearnRefNumber]=[LearningDelivery].[LearnRefNumber]

										left join (
											select
												sld.LearnDelFAMCode as SOF,
												sld.AimSeqNumber,
												sld.LearnRefNumber
											from 
												Valid.LearningDeliveryFAM as sld
											where
												sld.LearnDelFAMType = 'SOF'
										) as sof
											on sof.AimSeqNumber = LearningDelivery.AimSeqNumber
											and sof.LearnRefNumber = LearningDelivery.LearnRefNumber
										left join (
											select
												sld.LearnDelFAMCode,
												sld.AimSeqNumber,
												sld.LearnRefNumber
											from 
												Valid.LearningDeliveryFAM as sld
											where
												sld.LearnDelFAMType = 'EEF'
										) as eef
											on eef.AimSeqNumber = LearningDelivery.AimSeqNumber
											and LearningDelivery.LearnRefNumber = eef.LearnRefNumber
										left join (
											select top 1
												sld.LearnDelFAMCode,
												sld.AimSeqNumber,
												sld.LearnRefNumber
											from 
												Valid.LearningDeliveryFAM as sld
											where
												sld.LearnDelFAMType = 'FFI'
										) as ffi
											on ffi.AimSeqNumber = LearningDelivery.AimSeqNumber
											and ffi.LearnRefNumber = LearningDelivery.LearnRefNumber
										left join (
											select
												sld.LearnDelFAMCode,
												sld.AimSeqNumber,
												sld.LearnRefNumber
											from 
												Valid.LearningDeliveryFAM as sld
											where
												sld.LearnDelFAMType = 'RES'
										) as res
											on res.AimSeqNumber = LearningDelivery.AimSeqNumber
											and res.LearnRefNumber = LearningDelivery.LearnRefNumber

										left join (
											select
												sld.LearnDelFAMCode,
												sld.AimSeqNumber,
												sld.LearnRefNumber
											from 
												Valid.LearningDeliveryFAM as sld
											where
												sld.LearnDelFAMType = 'SPP'
										) as spp
											on spp.AimSeqNumber = LearningDelivery.AimSeqNumber
											and spp.LearnRefNumber = LearningDelivery.LearnRefNumber
									where
										[LearningDelivery].[LearnRefNumber] = [Learner].[LearnRefNumber]
										and [LearningDelivery].[ProgType]=25
										and [LearningDelivery].[FundModel]=81									

									for xml path ('LearningDelivery'), type
								),
								(
									select
										[LearnerEmploymentStatus].[DateEmpStatApp] as [@DateEmpStatApp],
										[LearnerEmploymentStatus].[EmpId] as [@EmpId],
										[LearnerEmploymentStatus].[EmpStat] as [@EMPStat],
										[EmpStatMon_SEM].[ESMCode] as [@EmpStatMon_SEM]
									from
										[Valid].[LearnerEmploymentStatus]
										left join [Valid].[EmploymentStatusMonitoring] as [EmpStatMon_SEM]
											on [EmpStatMon_SEM].[LearnRefNumber]=[LearnerEmploymentStatus].[LearnRefNumber]
											and [EmpStatMon_SEM].[ESMType]='SEM'
									where
										[LearnerEmploymentStatus].[LearnRefNumber] = [Learner].[LearnRefNumber]
									for xml path ('LearnerEmploymentStatus'), type
								)
							from
								[Valid].[Learner]
							where
								[Learner].[LearnRefNumber] = [Filter_LearningDelivery].[LearnRefNumber]
							for xml path ('Learner'), type
						)
					from
						[Valid].[LearningProvider]
						cross join [Reference].[LARS_Current_Version]
					for xml path ('global'), type
				)
			)
		from
			(
				select distinct
					[LearningDelivery].[LearnRefNumber]
				from
					[Valid].[LearningDelivery]
				where
					[LearningDelivery].[ProgType]=25
					and [LearningDelivery].[FundModel]=81
			) [Filter_LearningDelivery]
	end
GO
if object_id('[Rulebase].[TBL_Insert_global]','p') is not null
	drop procedure [Rulebase].[TBL_Insert_global]
GO
-- =====================================================================================================
-- Generated by Data Dictionary Version 1.0.0.0
-- Date: 27 July 2016 15:31
-- Profile: DCSS Calculation
-- Rulebase Version: ILR Trailblazer Funding Calculation 1617, Drop 000, Version 1617.02
-- =====================================================================================================

create procedure [Rulebase].[TBL_Insert_global]
	(
		@UKPRN int,
		@CurFundYr varchar(10),
		@LARSVersion varchar(100),
		@RulebaseVersion varchar(10)
	)
as
	begin
		set nocount on
		insert into
			[Rulebase].[TBL_global]
		values (
			@UKPRN,
			@CurFundYr,
			@LARSVersion,
			@RulebaseVersion
		)
	end
go
if object_id('[Rulebase].[TBL_Insert_LearningDelivery]','p') is not null
	drop procedure [Rulebase].[TBL_Insert_LearningDelivery]
GO
-- =====================================================================================================
-- Generated by Data Dictionary Version 1.0.0.0
-- Date: 27 July 2016 15:31
-- Profile: DCSS Calculation
-- Rulebase Version: ILR Trailblazer Funding Calculation 1617, Drop 000, Version 1617.02
-- =====================================================================================================

create procedure [Rulebase].[TBL_Insert_LearningDelivery]
	(
		@LearnRefNumber varchar(12)
		,@AimSeqNumber int
		,@ProgStandardStartDate date
		,@FundLine varchar(50)
		,@MathEngAimValue	decimal(10,5)
		,@PlannedNumOnProgInstalm int
		,@LearnSuppFundCash decimal(10,5)
		,@AdjProgStartDate date
		,@LearnSuppFund bit
		,@MathEngOnProgPayment decimal(10,5)
		,@InstPerPeriod int
		,@SmallBusPayment decimal(10,5)
		,@YoungAppSecondPayment decimal(10,5)
		,@CoreGovContPayment decimal(10,5)
		,@YoungAppEligible bit
		,@SmallBusEligible bit
		,@MathEngOnProgPct int
		,@AgeStandardStart int
		,@YoungAppSecondThresholdDate date
		,@EmpIdFirstDayStandard int
		,@EmpIdFirstYoungAppDate int
		,@EmpIdSecondYoungAppDate int
		,@EmpIdSmallBusDate int 
		,@YoungAppFirstThresholdDate date 
		,@AchApplicDate date
		,@AchEligible bit
		,@Achieved bit
		,@AchievementApplicVal decimal(10,5)
		,@AchPayment decimal(10,5)
		,@ActualNumInstalm int
		,@CombinedAdjProp bigint
		,@EmpIdAchDate int
		,@LearnDelDaysIL int
		,@LearnDelStandardAccDaysIL int
		,@LearnDelStandardPrevAccDaysIL int
		,@LearnDelStandardTotalDaysIL int
		,@ActualDaysIL int
		,@MathEngBalPayment decimal(10,5)
		,@MathEngBalPct bigint
		,@MathEngLSFFundStart bit
		,@PlannedTotalDaysIL int
		,@MathEngLSFThresholdDays int
		,@OutstandNumOnProgInstalm int
		,@SmallBusApplicVal decimal(10,5)
		,@SmallBusStatusFirstDayStandard int
		,@SmallBusStatusThreshold int
		,@YoungAppApplicVal decimal(10,5)
		,@CoreGovContCapApplicVal bigint
		,@CoreGovContUncapped decimal(10,5)
		,@ApplicFundValDate date
		,@YoungAppFirstPayment decimal(10,5)
		,@YoungAppPayment decimal(10,5)
	)
as
	begin
		set nocount on
		insert into
			[Rulebase].[TBL_LearningDelivery]
			(
				LearnRefNumber
				,AimSeqNumber
				,ProgStandardStartDate
				,FundLine
				,MathEngAimValue
				,PlannedNumOnProgInstalm
				,LearnSuppFundCash
				,AdjProgStartDate
				,LearnSuppFund
				,MathEngOnProgPayment
				,InstPerPeriod
				,SmallBusPayment
				,YoungAppSecondPayment
				,CoreGovContPayment
				,YoungAppEligible
				,SmallBusEligible
				,MathEngOnProgPct
				,AgeStandardStart
				,YoungAppSecondThresholdDate
				,EmpIdFirstDayStandard
				,EmpIdFirstYoungAppDate
				,EmpIdSecondYoungAppDate
				,EmpIdSmallBusDate
				,YoungAppFirstThresholdDate
				,AchApplicDate
				,AchEligible
				,Achieved 
				,AchievementApplicVal 
				,AchPayment 
				,ActualNumInstalm 
				,CombinedAdjProp
				,EmpIdAchDate 
				,LearnDelDaysIL 
				,LearnDelStandardAccDaysIL
				,LearnDelStandardPrevAccDaysIL
				,LearnDelStandardTotalDaysIL
				,ActualDaysIL 
				,MathEngBalPayment 
				,MathEngBalPct
				,MathEngLSFFundStart
				,PlannedTotalDaysIL 
				,MathEngLSFThresholdDays 
				,OutstandNumOnProgInstalm 
				,SmallBusApplicVal 
				,SmallBusStatusFirstDayStandard
				,SmallBusStatusThreshold
				,YoungAppApplicVal 
				,CoreGovContCapApplicVal
				,CoreGovContUncapped 
				,ApplicFundValDate 
				,YoungAppFirstPayment 
				,YoungAppPayment 
			)
		values (
			@LearnRefNumber
			,@AimSeqNumber
			,@ProgStandardStartDate
			,@FundLine
			,@MathEngAimValue
			,@PlannedNumOnProgInstalm
			,@LearnSuppFundCash
			,@AdjProgStartDate
			,@LearnSuppFund
			,@MathEngOnProgPayment
			,@InstPerPeriod
			,@SmallBusPayment
			,@YoungAppSecondPayment
			,@CoreGovContPayment
			,@YoungAppEligible
			,@SmallBusEligible
			,@MathEngOnProgPct
			,@AgeStandardStart
			,@YoungAppSecondThresholdDate
			,@EmpIdFirstDayStandard
			,@EmpIdFirstYoungAppDate
			,@EmpIdSecondYoungAppDate
			,@EmpIdSmallBusDate
			,@YoungAppFirstThresholdDate
			,@AchApplicDate
			,@AchEligible
			,@Achieved 
			,@AchievementApplicVal 
			,@AchPayment 
			,@ActualNumInstalm 
			,@CombinedAdjProp
			,@EmpIdAchDate 
			,@LearnDelDaysIL 
			,@LearnDelStandardAccDaysIL
			,@LearnDelStandardPrevAccDaysIL
			,@LearnDelStandardTotalDaysIL
			,@ActualDaysIL 
			,@MathEngBalPayment 
			,@MathEngBalPct
			,@MathEngLSFFundStart
			,@PlannedTotalDaysIL 
			,@MathEngLSFThresholdDays 
			,@OutstandNumOnProgInstalm 
			,@SmallBusApplicVal 
			,@SmallBusStatusFirstDayStandard
			,@SmallBusStatusThreshold
			,@YoungAppApplicVal 
			,@CoreGovContCapApplicVal
			,@CoreGovContUncapped 
			,@ApplicFundValDate 
			,@YoungAppFirstPayment 
			,@YoungAppPayment 
		)
	end
go
if object_id('[Rulebase].[TBL_Insert_LearningDelivery_PeriodisedValues]','p') is not null
	drop procedure [Rulebase].[TBL_Insert_LearningDelivery_PeriodisedValues]
GO
-- =====================================================================================================
-- Generated by Data Dictionary Version 1.0.0.0
-- Date: 27 July 2016 15:31
-- Profile: DCSS Calculation
-- Rulebase Version: ILR Trailblazer Funding Calculation 1617, Drop 000, Version 1617.02
-- =====================================================================================================
create procedure [Rulebase].[TBL_Insert_LearningDelivery_PeriodisedValues]
	(
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
	)
as
	begin
		set nocount on
		insert into
			[Rulebase].[TBL_LearningDelivery_PeriodisedValues]
				(
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
				)
		values
			(
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
GO
if object_id('[Rulebase].[TBL_PivotTemporals_LearningDelivery]','p') is not null
	drop procedure [Rulebase].[TBL_PivotTemporals_LearningDelivery]
GO
-- =====================================================================================================
-- Generated by Data Dictionary Version 1.0.0.0
-- Date: 27 July 2016 15:31
-- Profile: DCSS Calculation
-- Rulebase Version: ILR Trailblazer Funding Calculation 1617, Drop 000, Version 1617.02
-- =====================================================================================================
create procedure [Rulebase].[TBL_PivotTemporals_LearningDelivery] as
	begin
		truncate table [Rulebase].[TBL_LearningDelivery_Period]
		insert into
			[Rulebase].[TBL_LearningDelivery_Period]
			(
				LearnRefNumber
				,AimSeqNumber
				,Period
				,AchPayment
				,CoreGovContPayment
				,CoreGovContUncapped
				,InstPerPeriod
				,LearnSuppFund
				,[LearnSuppFundCash]
				,[MathEngBalPayment]
				,[MathEngBalPct]
				,[MathEngOnProgPayment]
				,[MathEngOnProgPct] 
				,[SmallBusPayment]
				,[YoungAppFirstPayment]
				,[YoungAppPayment]
				,[YoungAppSecondPayment]
			)
		select
			LearnRefNumber,
			AimSeqNumber,
			Period,
			max(case AttributeName when 'AchPayment' then Value else null end) AchPayment,
			max(case AttributeName when 'CoreGovContPayment' then Value else null end) CoreGovContPayment,
			max(case AttributeName when 'CoreGovContUncapped' then Value else null end) CoreGovContUncapped,
			max(case AttributeName when 'InstPerPeriod' then Value else null end) InstPerPeriod,
			max(case AttributeName when 'LearnSuppFund' then Value else null end) LearnSuppFund,
			max(case AttributeName when 'LearnSuppFundCash' then Value else null end) LearnSuppFundCash,
			max(case AttributeName when 'MathEngBalPayment' then Value else null end) MathEngBalPayment,
			max(case AttributeName when 'MathEngBalPct' then Value else null end) MathEngBalPct,
			max(case AttributeName when 'MathEngOnProgPayment' then Value else null end) MathEngOnProgPayment,
			max(case AttributeName when 'MathEngOnProgPct' then Value else null end) MathEngOnProgPct,
			max(case AttributeName when 'SmallBusPayment' then Value else null end) SmallBusPayment,
			max(case AttributeName when 'YoungAppFirstPayment' then Value else null end) YoungAppFirstPayment,
			max(case AttributeName when 'YoungAppPayment' then Value else null end) YoungAppPayment,
			max(case AttributeName when 'YoungAppSecondPayment' then Value else null end) YoungAppSecondPayment
		from
			(
				select
					LearnRefNumber,
					AimSeqNumber,
					AttributeName,
					cast(substring(PeriodValue.Period,8,2) as int) Period,
					PeriodValue.Value
				from
					[Rulebase].[TBL_LearningDelivery_PeriodisedValues]
					unpivot (Value for Period in (Period_1,Period_2,Period_3,Period_4,Period_5,Period_6,Period_7,Period_8,Period_9,Period_10,Period_11,Period_12)) as PeriodValue
			) as TBLPeriodValues
		group by
			TBLPeriodValues.LearnRefNumber,
			TBLPeriodValues.AimSeqNumber,
			TBLPeriodValues.Period
	end
GO
