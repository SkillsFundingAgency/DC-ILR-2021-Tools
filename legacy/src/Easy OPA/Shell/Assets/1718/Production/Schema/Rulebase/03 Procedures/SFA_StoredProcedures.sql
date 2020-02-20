if object_id('[Rulebase].[SFA_Get_Cases]','p') is not null
	drop procedure [Rulebase].[SFA_Get_Cases]
GO


create procedure [Rulebase].[SFA_Get_Cases] as

	begin
		set nocount on
		select
			CaseData
		from
			[Rulebase].[SFA_Cases]
	end
GO
if object_id('[Rulebase].[SFA_Insert_Cases]','p') is not null
	drop procedure [Rulebase].[SFA_Insert_Cases]
GO


create procedure [Rulebase].[SFA_Insert_Cases] as

	begin
		set nocount ON

		DECLARE @UKPRN int         
		SELECT	@UKPRN = UKPRN
		FROM
		(SELECT top 1 UKPRN from Valid.LearningProvider) AS T

		insert into
		[Rulebase].[SFA_Cases]
		(
			[LearnRefNumber],
			CaseData
		)
        select 
            cntrl.[LearnRefNumber],
            convert(xml,
                    (
                        select
                            lv.[CurrentVersion] as [@LARSVersion],
                            ov.[CurrentVersion] as [@OrgVersion],
                            @UKPRN as [@UKPRN],
                            (
                                    select
                                            l.[DateOfBirth] as [@DateOfBirth],
                                            l.[LearnRefNumber] as [@LearnRefNumber],
                                            (
                                                select
                                                        ld.[AchDate] as [@AchDate],
                                                        ld.[AddHours] as [@AddHours],
                                                        ld.[AimSeqNumber] as [@AimSeqNumber],
                                                        ld.[AimType] as [@AimType],
                                                        ld.[CompStatus] as [@CompStatus],
                                                        ld.[EmpOutcome] as [@EmpOutcome],
                                                        [LARS_LearningDelivery].[EnglandFEHEStatus] as [@EnglandFEHEStatus],
                                                        [LARS_LearningDelivery].[EnglPrscID] as [@EnglPrscID],
                                                        [LARS_LearningDelivery].[FrameworkCommonComponent] as [@FrameworkCommonComponent],
                                                        [LARS_FrameworkAims].[FrameworkComponentType] as [@FrameworkComponentType],
                                                        ld.[FworkCode] as [@FworkCode],
                                                        ld.[LearnActEndDate] as [@LearnActEndDate],
                                                        ld.[LearnPlanEndDate] as [@LearnPlanEndDate],
                                                        ld.[LearnStartDate] as [@LearnStartDate],
                                                        ld.LDFAM_EEF as [@LrnDelFAM_EEF],
                                                        ld.LDFAM_FFI as [@LrnDelFAM_FFI],
                                                        ld.LDM1 as [@LrnDelFAM_LDM1],
                                                        ld.LDM2 as [@LrnDelFAM_LDM2],
                                                        ld.LDM3 as [@LrnDelFAM_LDM3],
                                                        ld.LDM4 as [@LrnDelFAM_LDM4],
                                                        ld.LDFAM_RES as [@LrnDelFAM_RES],
                                                        ld.[OrigLearnStartDate] as [@OrigLearnStartDate],
                                                        ld.[OtherFundAdj] as [@OtherFundAdj],
                                                        ld.[Outcome] as [@Outcome],
                                                        ld.[PriorLearnFundAdj] as [@PriorLearnFundAdj],
                                                        ld.[ProgType] as [@ProgType],
                                                        ld.[PwayCode] as [@PwayCode]
                                                        ,(
                                                                select
                                                                    [LearningDeliveryFAM].[LearnDelFAMCode] as [@LearnDelFAMCode],
                                                                    [LearningDeliveryFAM].[LearnDelFAMDateFrom] as [@LearnDelFAMDateFrom],
                                                                    [LearningDeliveryFAM].[LearnDelFAMDateTo] as [@LearnDelFAMDateTo],
                                                                    [LearningDeliveryFAM].[LearnDelFAMType] as [@LearnDelFAMType]
                                                                from
                                                                    [Valid].[LearningDeliveryFAM]
                                                                where
                                                                    [LearningDeliveryFAM].[LearnRefNumber] = ld.[LearnRefNumber]
                                                                    and [LearningDeliveryFAM].[AimSeqNumber] = ld.[AimSeqNumber]
                                                                for xml path ('LearningDeliveryFAM'), type
                                                        )
                                                        ,(
                                                                select
                                                                    [LARS_LearningDeliveryCategory].[EffectiveFrom] as [@LearnDelCatDateFrom],
                                                                    [LARS_LearningDeliveryCategory].[EffectiveTo] as [@LearnDelCatDateTo],
                                                                    [LARS_LearningDeliveryCategory].[CategoryRef] as [@LearnDelCatRef]
                                                                from
                                                                    [Reference].[LARS_LearningDeliveryCategory]
                                                                where
                                                                    [LARS_LearningDeliveryCategory].[LearnAimRef]=ld.[LearnAimRef]
                                                                for xml path ('LearningDeliveryLARSCategory'), type
                                                        ),
                                                        (
                                                                select
                                                                    [LARS_AnnualValue].[BasicSkillsType] as [@LearnDelAnnValBasicSkillsTypeCode],
                                                                    [LARS_AnnualValue].[EffectiveFrom] as [@LearnDelAnnValDateFrom],
                                                                    [LARS_AnnualValue].[EffectiveTo] as [@LearnDelAnnValDateTo]
                                                                from
                                                                    [Reference].[LARS_AnnualValue]
                                                                where
                                                                    [LARS_AnnualValue].[LearnAimRef]=ld.[LearnAimRef]
                                                                for xml path ('LearningDeliveryAnnualValue'), type
                                                        ),
                                                        (
                                                                select
                                                                    [LARS_Funding].[FundingCategory] as [@LARSFundCategory],
                                                                    [LARS_Funding].[EffectiveFrom] as [@LARSFundEffectiveFrom],
                                                                    [LARS_Funding].[EffectiveTo] as [@LARSFundEffectiveTo],
                                                                    [LARS_Funding].[RateUnWeighted] as [@LARSFundUnweightedRate],
                                                                    [LARS_Funding].[RateWeighted] as [@LARSFundWeightedRate],
                                                                    [LARS_Funding].[WeightingFactor] as [@LARSFundWeightingFactor]
                                                                from
                                                                    [Reference].[LARS_Funding]
                                                                where
                                                                    [LARS_Funding].[LearnAimRef]=ld.[LearnAimRef]
                                                                for xml path ('LearningDeliveryLARS_Funding'), type
                                                        ),
                                                        (
                                                                select
                                                                    [SFA_PostcodeAreaCost].[EffectiveFrom] as [@AreaCosEffectiveFrom],
                                                                    [SFA_PostcodeAreaCost].[EffectiveTo] as [@AreaCosEffectiveTo],
                                                                    [SFA_PostcodeAreaCost].[AreaCostFactor] as [@AreaCosFactor]
                                                                from
                                                                    [Reference].[SFA_PostcodeAreaCost]
                                                                where
                                                                    [SFA_PostcodeAreaCost].[Postcode]=ld.[DelLocPostCode]
                                                                for xml path ('SFA_PostcodeAreaCost'), type
                                                        )
                                                FROM
 															[Valid].[LearningDeliveryDenormTbl] as ld
                                                                                                                                     
												LEFT JOIN	
															[Reference].[LARS_LearningDelivery] on [LARS_LearningDelivery].[LearnAimRef]=ld.[LearnAimRef]

											    LEFT JOIN	
															[Reference].[LARS_FrameworkAims]
													   ON	[LARS_FrameworkAims].[FworkCode]=ld.[FworkCode]
													  AND	[LARS_FrameworkAims].[ProgType]=ld.[ProgType]
													  AND	[LARS_FrameworkAims].[PwayCode]=ld.[PwayCode]
													  AND	[LARS_FrameworkAims].[LearnAimRef]=ld.[LearnAimRef]
                                                WHERE
                                                        ld.LearnRefNumber = l.LearnRefNumber
														and ld.FundModel = 35
                                                for xml path ('LearningDelivery'), type
                                            )
                                            ,(
                                                select
                                                        [LearnerEmploymentStatus].[DateEmpStatApp] as [@DateEmpStatApp],
                                                        [LearnerEmploymentStatus].[EmpId] as [@EmpId],
                                                        (
                                                                select
                                                                    [LargeEmployers].[EffectiveFrom] as [@LargeEmpEffectiveFrom],
                                                                    [LargeEmployers].[EffectiveTo] as [@LargeEmpEffectiveTo]
                                                                from
                                                                    [Reference].[LargeEmployers]
                                                                where
                                                                    [LargeEmployers].[ERN]=[LearnerEmploymentStatus].[EmpId]
                                                                for xml path ('LargeEmployerReferenceData'), type
                                                        )
                                                from
                                                        [Valid].[LearnerEmploymentStatus]
                                                where
                                                        [LearnerEmploymentStatus].[LearnRefNumber] = l.[LearnRefNumber]
                                                for xml path ('LearnerEmploymentStatus'), type
                                            ),
                                            (
                                                select
                                                        [SFA_PostcodeDisadvantage].[EffectiveFrom] as [@DisUpEffectiveFrom],
                                                        [SFA_PostcodeDisadvantage].[EffectiveTo] as [@DisUpEffectiveTo],
                                                        [SFA_PostcodeDisadvantage].[Uplift] as [@DisUplift]
                                                from
                                                        [Reference].[SFA_PostcodeDisadvantage]
                                                where
                                                        [SFA_PostcodeDisadvantage].[Postcode]=l.[PostcodePrior]
                                                for xml path ('SFA_PostcodeDisadvantage'), type
                                            )
                                    from
                                            [Valid].[Learner] as l
                                    where
                                            l.[LearnRefNumber] = globalLearner.[LearnRefNumber]
                                    for xml path ('Learner'), type
                            ),
                            (
                                    select
                                            [Org_Funding].[EffectiveFrom] as [@OrgFundEffectiveFrom],
                                            [Org_Funding].[EffectiveTo] as [@OrgFundEffectiveTo],
                                            [Org_Funding].[FundingFactor] as [@OrgFundFactor],
                                            [Org_Funding].[FundingFactorType] as [@OrgFundFactType],
                                            [Org_Funding].[FundingFactorValue] as [@OrgFundFactValue]
                                    from
                                            [Reference].[Org_Funding]
                                    where
                                            [Org_Funding].[UKPRN] = @UKPRN
                                            and [Org_Funding].[FundingFactorType]='Adult Skills'
                                    for xml path ('OrgFunding'), type
                            )
                        from
                            Valid.Learner as globalLearner
                            cross join [Reference].[LARS_Current_Version] as lv
                            cross join [Reference].[Org_Current_Version] as ov
                        where
                            globalLearner.LearnRefNumber = cntrl.LearnRefNumber
                        for xml path ('global'), type
                    )
            )
        from
		(
            select distinct
                    filterLD.LearnRefNumber
            from
                    Valid.LearningDelivery as filterLD
            where
                    filterLD.FundModel = 35
		) as cntrl
	end
GO
if object_id('[Rulebase].[SFA_Insert_global]','p') is not null
	drop procedure [Rulebase].[SFA_Insert_global]
GO
-- =====================================================================================================
-- Generated by Data Dictionary Version 1.0.0.0
-- Date: 29 June 2016 11:18
-- Profile: DCSS Calculation
-- Rulebase Version: ILR SFA Calculation 1617, Drop 000, Version 1617.02
-- =====================================================================================================

create procedure [Rulebase].[SFA_Insert_global]
	(
		@UKPRN varchar(8),
		@CurFundYr varchar(9),
		@LARSVersion varchar(100),
		@OrgVersion varchar(100),
		@PostcodeDisadvantageVersion varchar(50),
		@RulebaseVersion varchar(10)
	)
as
	begin
		set nocount on
		insert into
			[Rulebase].[SFA_global]
			(
				[UKPRN],
				[CurFundYr],
				[LARSVersion],
				[OrgVersion],
				[PostcodeDisadvantageVersion],
				[RulebaseVersion]
			)
		values (
			@UKPRN,
			@CurFundYr,
			@LARSVersion,
			@OrgVersion,
			@PostcodeDisadvantageVersion,
			@RulebaseVersion
		)
	end
go
if object_id('[Rulebase].[SFA_Insert_LearningDelivery]','p') is not null
	drop procedure [Rulebase].[SFA_Insert_LearningDelivery]
GO
-- =====================================================================================================
-- Generated by Data Dictionary Version 1.0.0.0
-- Date: 29 June 2016 11:18
-- Profile: DCSS Calculation
-- Rulebase Version: ILR SFA Calculation 1617, Drop 000, Version 1617.02
-- =====================================================================================================

create procedure [Rulebase].[SFA_Insert_LearningDelivery]
	(
		@LearnRefNumber varchar(12),
		@AimSeqNumber int,
		@AchApplicDate date,
		@Achieved bit,
		@AchieveElement decimal(10,5),
		@AchievePayElig bit,
		@AchievePayment decimal(10,5),
		@AchievePayPct decimal(10,5),
		@AchievePayPctPreTrans decimal(10,5),
		@AchievePayPctTrans decimal(10,5),
		@AchPayTransHeldBack decimal(10,5),
		@ActualDaysIL int,
		@ActualNumInstalm int,
		@ActualNumInstalmPreTrans int,
		@ActualNumInstalmTrans int,
		@AdjLearnStartDate date,
		@AdltLearnResp bit,
		@AgeAimStart int,
		@AimValue decimal(10,5),
		@AppAdjLearnStartDate date,
		@AppAgeFact decimal(10,5),
		@AppATAGTA bit,
		@AppCompetency bit,
		@AppFuncSkill bit,
		@AppFuncSkill1618AdjFact decimal(10,5),
		@AppKnowl bit,
		@AppLearnStartDate date,
		@ApplicEmpFactDate date,
		@ApplicFactDate date,
		@ApplicFundRateDate date,
		@ApplicProgWeightFact varchar(1),
		@ApplicUnweightFundRate decimal(10,5),
		@ApplicWeightFundRate decimal(10,5),
		@AppNonFund bit,
		@AreaCostFactAdj decimal(10,5),
		@BalancePayment decimal(10,5),
		@BalancePaymentUncapped decimal(10,5),
		@BalancePct decimal(10,5),
		@BalancePctTrans decimal(10,5),
		@BalInstalmPreTrans int,
		@BaseValueUnweight decimal(10,5),
		@CapFactor decimal(10,5),
		@DisUpFactAdj decimal(10,4),
		@EmpOutcomePay decimal(10,5),
		@EmpOutcomePayElig bit,
		@EmpOutcomePct decimal(10,5),
		@EmpOutcomePctHeldBackTrans decimal(10,5),
		@EmpOutcomePctPreTrans decimal(10,5),
		@EmpOutcomePctTrans decimal(10,5),
		@EmpRespOth bit,
		@ESOL bit,
		@FullyFund bit,
		@FundLine varchar(100),
		@FundStart bit,
		@InstPerPeriod int,
		@LargeEmployerID int,
		@LargeEmployerSFAFctr decimal(10,2),
		@LargeEmployerStatusDate date,
		@LearnSuppFund bit,
		@LearnSuppFundCash decimal(10,5),
		@LTRCUpliftFctr decimal(10,5),
		@NonGovCont decimal(10,5),
		@OLASSCustody bit,
		@OnProgPayment decimal(10,5),
		@OnProgPaymentUncapped decimal(10,5),
		@OnProgPayPct decimal(10,5),
		@OnProgPayPctPreTrans decimal(10,5),
		@OnProgPayPctTrans decimal(10,5),
		@OutstndNumOnProgInstalm int,
		@OutstndNumOnProgInstalmTrans int,
		@PlannedNumOnProgInstalm int,
		@PlannedNumOnProgInstalmTrans int,
		@PlannedTotalDaysIL int,
		@PlannedTotalDaysILPreTrans int,
		@PropFundRemain decimal(10,2),
		@PropFundRemainAch decimal(10,2),
		@PrscHEAim bit,
		@Residential bit,
		@Restart bit,
		@SpecResUplift decimal(10,5),
		@StartPropTrans decimal(10,5),
		@ThresholdDays int,
		@Traineeship bit,
		@Trans bit,
		@TransInstPerPeriod int,
		@TrnAdjLearnStartDate date,
		@TrnWorkPlaceAim bit,
		@TrnWorkPrepAim bit,
		@UnWeightedRateFromESOL decimal(10,5),
		@UnweightedRateFromLARS decimal(10,5),
		@WeightedRateFromESOL decimal(10,5),
		@WeightedRateFromLARS decimal(10,5)
	)
as
	begin
		set nocount on
		insert into
			[Rulebase].[SFA_LearningDelivery]
			(
				[LearnRefNumber],
				[AimSeqNumber],
				[AchApplicDate],
				[Achieved],
				[AchieveElement],
				[AchievePayElig],
				[AchievePayPctPreTrans],
				[AchPayTransHeldBack],
				[ActualDaysIL],
				[ActualNumInstalm],
				[ActualNumInstalmPreTrans],
				[ActualNumInstalmTrans],
				[AdjLearnStartDate],
				[AdltLearnResp],
				[AgeAimStart],
				[AimValue],
				[AppAdjLearnStartDate],
				[AppAgeFact],
				[AppATAGTA],
				[AppCompetency],
				[AppFuncSkill],
				[AppFuncSkill1618AdjFact] ,
				[AppKnowl],
				[AppLearnStartDate],
				[ApplicEmpFactDate],
				[ApplicFactDate],
				[ApplicFundRateDate],
				[ApplicProgWeightFact],
				[ApplicUnweightFundRate] ,
				[ApplicWeightFundRate],
				[AppNonFund],
				[AreaCostFactAdj],
				[BalInstalmPreTrans],
				[BaseValueUnweight],
				[CapFactor],
				[DisUpFactAdj],
				[EmpOutcomePayElig],
				[EmpOutcomePctHeldBackTrans],
				[EmpOutcomePctPreTrans],
				[EmpRespOth],
				[ESOL],
				[FullyFund],
				[FundLine],
				[FundStart],
				[LargeEmployerID],
				[LargeEmployerSFAFctr],
				[LargeEmployerStatusDate],
				[LTRCUpliftFctr],
				[NonGovCont],
				[OLASSCustody],
				[OnProgPayPctPreTrans],
				[OutstndNumOnProgInstalm],
				[OutstndNumOnProgInstalmTrans],
				[PlannedNumOnProgInstalm] ,
				[PlannedNumOnProgInstalmTrans],
				[PlannedTotalDaysIL],
				[PlannedTotalDaysILPreTrans],
				[PropFundRemain],
				[PropFundRemainAch] ,
				[PrscHEAim],
				[Residential],
				[Restart],
				[SpecResUplift] ,
				[StartPropTrans],
				[ThresholdDays],
				[Traineeship],
				[Trans],
				[TrnAdjLearnStartDate],
				[TrnWorkPlaceAim],
				[TrnWorkPrepAim],
				[UnWeightedRateFromESOL],
				[UnweightedRateFromLARS],
				[WeightedRateFromESOL],
				[WeightedRateFromLARS]
			)
		values (
			@LearnRefNumber,
			@AimSeqNumber,
			@AchApplicDate,
			@Achieved,
			@AchieveElement,
			@AchievePayElig,
			@AchievePayPctPreTrans,
			@AchPayTransHeldBack,
			@ActualDaysIL,
			@ActualNumInstalm,
			@ActualNumInstalmPreTrans,
			@ActualNumInstalmTrans,
			@AdjLearnStartDate,
			@AdltLearnResp,
			@AgeAimStart,
			@AimValue,
			@AppAdjLearnStartDate,
			@AppAgeFact,
			@AppATAGTA,
			@AppCompetency,
			@AppFuncSkill,
			@AppFuncSkill1618AdjFact,
			@AppKnowl,
			@AppLearnStartDate,
			@ApplicEmpFactDate,
			@ApplicFactDate,
			@ApplicFundRateDate,
			@ApplicProgWeightFact,
			@ApplicUnweightFundRate,
			@ApplicWeightFundRate,
			@AppNonFund,
			@AreaCostFactAdj,
			@BalInstalmPreTrans,
			@BaseValueUnweight,
			@CapFactor,
			@DisUpFactAdj,
			@EmpOutcomePayElig,
			@EmpOutcomePctHeldBackTrans,
			@EmpOutcomePctPreTrans,
			@EmpRespOth,
			@ESOL,
			@FullyFund,
			@FundLine,
			@FundStart,
			@LargeEmployerID,
			@LargeEmployerSFAFctr,
			@LargeEmployerStatusDate,
			@LTRCUpliftFctr,
			@NonGovCont,
			@OLASSCustody,
			@OnProgPayPctPreTrans,
			@OutstndNumOnProgInstalm,
			@OutstndNumOnProgInstalmTrans,
			@PlannedNumOnProgInstalm,
			@PlannedNumOnProgInstalmTrans,
			@PlannedTotalDaysIL,
			@PlannedTotalDaysILPreTrans,
			@PropFundRemain,
			@PropFundRemainAch,
			@PrscHEAim,
			@Residential,
			@Restart,
			@SpecResUplift,
			@StartPropTrans,
			@ThresholdDays,
			@Traineeship,
			@Trans,
			@TrnAdjLearnStartDate,
			@TrnWorkPlaceAim,
			@TrnWorkPrepAim,
			@UnWeightedRateFromESOL,
			@UnweightedRateFromLARS,
			@WeightedRateFromESOL,
			@WeightedRateFromLARS
		)
	end
go
if object_id('[Rulebase].[SFA_Insert_LearningDelivery_PeriodisedValues]','p') is not null
	drop procedure [Rulebase].[SFA_Insert_LearningDelivery_PeriodisedValues]
GO
-- =====================================================================================================
-- Generated by Data Dictionary Version 1.0.0.0
-- Date: 29 June 2016 11:18
-- Profile: DCSS Calculation
-- Rulebase Version: ILR SFA Calculation 1617, Drop 000, Version 1617.02
-- =====================================================================================================
create procedure [Rulebase].[SFA_Insert_LearningDelivery_PeriodisedValues]
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
			[Rulebase].[SFA_LearningDelivery_PeriodisedValues]
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
if object_id('[Rulebase].[SFA_PivotTemporals_LearningDelivery]','p') is not null
	drop procedure [Rulebase].[SFA_PivotTemporals_LearningDelivery]
GO
-- =====================================================================================================
-- Generated by Data Dictionary Version 1.0.0.0
-- Date: 29 June 2016 11:18
-- Profile: DCSS Calculation
-- Rulebase Version: ILR SFA Calculation 1617, Drop 000, Version 1617.02
-- =====================================================================================================
create procedure [Rulebase].[SFA_PivotTemporals_LearningDelivery] as
	begin
		truncate table [Rulebase].[SFA_LearningDelivery_Period]
		insert into
			[Rulebase].[SFA_LearningDelivery_Period]
		select
			LearnRefNumber,
			AimSeqNumber,
			Period,
			max(case AttributeName when 'AchievePayment' then Value else null end) AchievePayment,
			max(case AttributeName when 'AchievePayPct' then Value else null end) AchievePayPct,
			max(case AttributeName when 'AchievePayPctTrans' then Value else null end) AchievePayPctTrans,
			max(case AttributeName when 'BalancePayment' then Value else null end) BalancePayment,
			max(case AttributeName when 'BalancePaymentUncapped' then Value else null end) BalancePaymentUncapped,
			max(case AttributeName when 'BalancePct' then Value else null end) BalancePct,
			max(case AttributeName when 'BalancePctTrans' then Value else null end) BalancePctTrans,
			max(case AttributeName when 'EmpOutcomePay' then Value else null end) EmpOutcomePay,
			max(case AttributeName when 'EmpOutcomePct' then Value else null end) EmpOutcomePct,
			max(case AttributeName when 'EmpOutcomePctTrans' then Value else null end) EmpOutcomePctTrans,
			max(case AttributeName when 'InstPerPeriod' then Value else null end) InstPerPeriod,
			max(case AttributeName when 'LearnSuppFund' then Value else null end) LearnSuppFund,
			max(case AttributeName when 'LearnSuppFundCash' then Value else null end) LearnSuppFundCash,
			max(case AttributeName when 'OnProgPayment' then Value else null end) OnProgPayment,
			max(case AttributeName when 'OnProgPaymentUncapped' then Value else null end) OnProgPaymentUncapped,
			max(case AttributeName when 'OnProgPayPct' then Value else null end) OnProgPayPct,
			max(case AttributeName when 'OnProgPayPctTrans' then Value else null end) OnProgPayPctTrans,
			max(case AttributeName when 'TransInstPerPeriod' then Value else null end) TransInstPerPeriod
		from
			(
				select
					LearnRefNumber,
					AimSeqNumber,
					AttributeName,
					cast(substring(PeriodValue.Period,8,2) as int) Period,
					PeriodValue.Value
				from
					[Rulebase].[SFA_LearningDelivery_PeriodisedValues]
					unpivot (Value for Period in (Period_1,Period_2,Period_3,Period_4,Period_5,Period_6,Period_7,Period_8,Period_9,Period_10,Period_11,Period_12)) as PeriodValue
			) Bob
		group by
			LearnRefNumber,
			AimSeqNumber,
			Period
	end
GO
