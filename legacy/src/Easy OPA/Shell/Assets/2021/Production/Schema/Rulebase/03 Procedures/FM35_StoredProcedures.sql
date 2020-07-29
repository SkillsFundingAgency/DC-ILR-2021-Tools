if object_id('Rulebase.FM35_Get_Cases', 'p') is not null begin drop procedure Rulebase.FM35_Get_Cases
end
go
  create procedure Rulebase.FM35_Get_Cases as begin
set
  nocount on
select
  CaseData
from
  Rulebase.FM35_Cases C
	JOIN dbo.UKPRNForProcedures UFP
	ON UFP.UKPRN = C.UKPRN
end
go
  if object_id('Rulebase.FM35_Insert_Cases', 'p') is not null begin drop procedure Rulebase.FM35_Insert_Cases
end
go
  create procedure Rulebase.FM35_Insert_Cases as begin
insert into
  Rulebase.FM35_Cases (UKPRN, LearnRefNumber, CaseData)
select
  cntrl.UKPRN,
  cntrl.LearnRefNumber,
  convert(
    xml,
    (
      select
        cntrl.UKPRN as [@UKPRN],
        lv.CurrentVersion as [@LARSVersion],
        ov.CurrentVersion as [@OrgVersion],
        -- PostcodeDisadvantageVersion
        (
          select
            EffectiveFrom as [@OrgFundEffectiveFrom],
            EffectiveTo as [@OrgFundEffectiveTo],
            FundingFactor as [@OrgFundFactor],
            FundingFactorValue as [@OrgFundFactValue],
            FundingFactorType as [@OrgFundFactType]
          from
            Reference.Org_Funding
          where
            UKPRN = cntrl.UKPRN
            and FundingFactorType = 'Adult Skills' for xml path ('OrgFunding'),
            type
        ),
        (
          select
            l.LearnRefNumber as [@LearnRefNumber],
            l.DateOfBirth as [@DateOfBirth],
            (
              select
                EffectiveFrom as [@DisUpEffectiveFrom],
                EffectiveTo as [@DisUpEffectiveTo],
                Uplift as [@DisUplift]
              from
                Reference.SFA_PostcodeDisadvantage
              where
                Postcode = l.PostcodePrior for xml path ('SFA_PostcodeDisadvantage'),
                type
            ),
            (
              select
                EffectiveFrom as [@EffectiveFrom],
                EffectiveTo as [@EffectiveTo],
                CASE
					WHEN SpecialistResources = 1 THEN 'Y'
					WHEN SpecialistResources = 0 THEN 'N'
				END as [@SpecialistResources]
              from
                Reference.CampusIdentifier_SpecialistResources
              where
                CampusIdentifier = l.CampId for xml path ('Camps_Identifiers_Reference_DataFunding'),
                type
            ),
            (
              select
                EmpId as [@EmpId],
                DateEmpStatApp as [@DateEmpStatApp],
                (
                  select
                    EffectiveFrom as [@LargeEmpEffectiveFrom],
                    EffectiveTo as [@LargeEmpEffectiveTo]
                  from
                    Reference.LargeEmployers
                  where
                    ERN = EmpId for xml path ('LargeEmployerReferenceData'),
                    type
                )
              from
                Valid.LearnerEmploymentStatus
              where
                LearnRefNumber = l.LearnRefNumber
                and UKPRN = l.UKPRN for xml path ('LearnerEmploymentStatus'),
                type
            ),
            (
              select
                ld.AimSeqNumber as [@AimSeqNumber],
                ld.AimType as [@AimType],
                ld.ProgType as [@ProgType],
                ld.LearnStartDate as [@LearnStartDate],
                ld.OrigLearnStartDate as [@OrigLearnStartDate],
                ld.LearnPlanEndDate as [@LearnPlanEndDate],
                ld.LearnActEndDate as [@LearnActEndDate],
                ld.AchDate as [@AchDate],
                ld.AddHours as [@AddHours],
                ld.CompStatus as [@CompStatus],
                ld.Outcome as [@Outcome],
                ld.EmpOutcome as [@EmpOutcome],
                lars_ld.EnglPrscID as [@EnglPrscID],
                lars_ld.EnglandFEHEStatus as [@EnglandFEHEStatus],
                ld.FundModel as [@FundModel],
                ld.DelLocPostCode as [@DelLocPostCode],
                ld.FworkCode as [@FworkCode],
                lars_ld.FrameworkCommonComponent as [@FrameworkCommonComponent],
                lars_fa.FrameworkComponentType as [@FrameworkComponentType],
                ld.PwayCode as [@PwayCode],
                ld.PriorLearnFundAdj as [@PriorLearnFundAdj],
                ld.OtherFundAdj as [@OtherFundAdj],
                (
                  select
                    LearnDelFAMType as [@LearnDelFAMType],
                    LearnDelFAMCode as [@LearnDelFAMCode],
                    LearnDelFAMDateFrom as [@LearnDelFAMDateFrom],
                    LearnDelFAMDateTo as [@LearnDelFAMDateTo]
                  from
                    Valid.LearningDeliveryFAM
                  where
                    LearnRefNumber = ld.LearnRefNumber
                    and UKPRN = ld.UKPRN
                    and AimSeqNumber = ld.AimSeqNumber for xml path ('LearningDeliveryFAM'),
                    type
                ),
                (
                  select
                    CategoryRef as [@LearnDelCatRef],
                    EffectiveFrom as [@LearnDelCatDateFrom],
                    EffectiveTo as [@LearnDelCatDateTo]
                  from
                    Reference.LARS_LearningDeliveryCategory
                  where
                    LearnAimRef = ld.LearnAimRef
                    and UKPRN = ld.UKPRN for xml path ('LearningDeliveryLARSCategory'),
                    type
                ),
                (
                  select
                    BasicSkillsType as [@LearnDelAnnValBasicSkillsTypeCode],
                    EffectiveFrom as [@LearnDelAnnValDateFrom],
                    EffectiveTo as [@LearnDelAnnValDateTo]
                  from
                    Reference.LARS_AnnualValue
                  where
                    LearnAimRef = ld.LearnAimRef
                    and UKPRN = ld.UKPRN for xml path ('LearningDeliveryAnnualValue'),
                    type
                ),
                (
                  select
                    FundingCategory as [@LARSFundCategory],
                    EffectiveFrom as [@LARSFundEffectiveFrom],
                    EffectiveTo as [@LARSFundEffectiveTo],
                    RateUnWeighted as [@LARSFundUnweightedRate],
                    RateWeighted as [@LARSFundWeightedRate],
                    WeightingFactor as [@LARSFundWeightingFactor]
                  from
                    Reference.LARS_Funding
                  where
                    LearnAimRef = ld.LearnAimRef
                    and UKPRN = ld.UKPRN for xml path ('LearningDeliveryLARS_Funding'),
                    type
                ),
                (
                  select
                    AreaCostFactor as [@AreaCosFactor],
                    EffectiveFrom as [@AreaCosEffectiveFrom],
                    EffectiveTo as [@AreaCosEffectiveTo]
                  from
                    Reference.SFA_PostcodeAreaCost
                  where
                    Postcode = ld.DelLocPostCode for xml path ('SFA_PostcodeAreaCost'),
                    type
                )
              from
                Valid.LearningDeliveryDenormTbl as ld
                left join Reference.LARS_LearningDelivery as lars_ld on lars_ld.LearnAimRef = ld.LearnAimRef
                left join Reference.LARS_FrameworkAims as lars_fa on lars_fa.FworkCode = ld.FworkCode
                and lars_fa.ProgType = ld.ProgType
                and lars_fa.PwayCode = ld.PwayCode
                and lars_fa.LearnAimRef = ld.LearnAimRef
              where
                ld.LearnRefNumber = l.LearnRefNumber
                and ld.UKPRN = l.UKPRN
				for xml path ('LearningDelivery'),
                type
            )
          from
            Valid.Learner as l
          where
            l.LearnRefNumber = globalLearner.LearnRefNumber
            and l.UKPRN = globalLearner.UKPRN for xml path ('Learner'),
            type
        ),
        (
          SELECT
            PostcodeSpecResEffectiveFrom as [@PostcodeSpecResEffectiveFrom],
            PostcodeSpecResEffectiveTo as [@PostcodeSpecResEffectiveTo],
            PostcodeSpecResPostcode as [@PostcodeSpecResPostcode],
            PostcodeSpecResSpecialistResources as [@PostcodeSpecResSpecialistResources]
          FROM
            Reference.PostcodeSpecialistResourceRefData
          WHERE
            UKPRN = cntrl.UKPRN for xml path ('Postcode_Specialist_Resource_RefData'),
            type
        )
      from
        Valid.Learner as globalLearner
        cross join Reference.LARS_Current_Version as lv
        cross join Reference.Org_Current_Version as ov
      where
        globalLearner.LearnRefNumber = cntrl.LearnRefNumber
        and globalLearner.UKPRN = cntrl.UKPRN for xml path ('global'),
        type
    )
  )
from
  (
    select
      distinct filterLd.UKPRN,
      filterLD.LearnRefNumber
    from
      Valid.LearningDelivery as filterLD
      inner join [dbo].UKPRNForProcedures p on p.UKPRN = filterLD.UKPRN
    where
      filterLD.FundModel IN (35, 81)
  ) as cntrl
end
go
  if object_id('Rulebase.FM35_Insert_global', 'p') is not null begin drop procedure Rulebase.FM35_Insert_global
end
go
  create procedure Rulebase.FM35_Insert_global (
    @UKPRN varchar(8),
    @CurFundYr varchar(9),
    @LARSVersion varchar(100),
    @OrgVersion varchar(100),
    @PostcodeDisadvantageVersion varchar(50),
    @RulebaseVersion varchar(10)
  ) as begin
set
  nocount on
insert into
  Rulebase.FM35_global (
    UKPRN,
    CurFundYr,
    LARSVersion,
    OrgVersion,
    PostcodeDisadvantageVersion,
    RulebaseVersion
  )
values
  (
    @UKPRN,
    @CurFundYr,
    @LARSVersion,
    @OrgVersion,
    @PostcodeDisadvantageVersion,
    @RulebaseVersion
  )
end
go
  if object_id('Rulebase.FM35_Insert_LearningDelivery', 'p') is not null begin drop procedure Rulebase.FM35_Insert_LearningDelivery
end
go
  create procedure Rulebase.FM35_Insert_LearningDelivery (
    @UKPRN int,
    @LearnRefNumber varchar(12),
    -- passed through, key
    @AimSeqNumber int,
    -- passed through, key
    @AchApplicDate date,
    @Achieved bit,
    @AchieveElement decimal(10, 5),
    @AchievePayElig bit,
    @AchievePayment decimal(10, 5),
    -- periodised
    @AchievePayPct decimal(10, 5),
    -- periodised
    @AchievePayPctPreTrans decimal(10, 5),
    @AchievePayPctTrans decimal(10, 5),
    -- periodised
    @AchPayTransHeldBack decimal(10, 5),
    @ActualDaysIL int,
    @ActualNumInstalm int,
    @ActualNumInstalmPreTrans int,
    @ActualNumInstalmTrans int,
    @AdjLearnStartDate date,
    @AdltLearnResp bit,
    @AgeAimStart int,
    @AimValue decimal(10, 5),
    @AppAdjLearnStartDate date,
    @AppAgeFact decimal(10, 5),
    @AppATAGTA bit,
    @AppCompetency bit,
    @AppFuncSkill bit,
    @AppFuncSkill1618AdjFact decimal(10, 5),
    @AppKnowl bit,
    @AppLearnStartDate date,
    @ApplicEmpFactDate date,
    @ApplicFactDate date,
    @ApplicFundRateDate date,
    @ApplicProgWeightFact varchar(1),
    @ApplicUnweightFundRate decimal(10, 5),
    @ApplicWeightFundRate decimal(10, 5),
    @AppNonFund bit,
    @AreaCostFactAdj decimal(10, 5),
    @BalancePayment decimal(10, 5),
    -- periodised
    @BalancePaymentUncapped decimal(10, 5),
    -- periodised
    @BalancePct decimal(10, 5),
    -- periodised
    @BalancePctTrans decimal(10, 5),
    -- periodised
    @BalInstalmPreTrans int,
    @BaseValueUnweight decimal(10, 5),
    @CapFactor decimal(10, 5),
    @DisUpFactAdj decimal(10, 5),
    @EmpOutcomePay decimal(10, 5),
    -- periodised
    @EmpOutcomePayElig bit,
    @EmpOutcomePct decimal(10, 5),
    -- periodised
    @EmpOutcomePctHeldBackTrans decimal(10, 5),
    @EmpOutcomePctPreTrans decimal(10, 5),
    @EmpOutcomePctTrans decimal(10, 5),
    -- periodised
    @EmpRespOth bit,
    @ESOL bit,
    @FullyFund bit,
    @FundLine varchar(100),
    @FundStart bit,
    @InstPerPeriod int,
    -- periodised
    @LargeEmployerID int,
    @LargeEmployerFM35Fctr decimal(10, 5),
    @LargeEmployerStatusDate date,
    @LearnDelFundOrgCode varchar(50),
    -- new for 1920?
    @LearnSuppFund bit,
    -- periodised ?? can this turn on and off for each period?
    @LearnSuppFundCash decimal(10, 5),
    -- periodised
    @LTRCUpliftFctr decimal(10, 5),
    @NonGovCont decimal(10, 5),
    @OLASSCustody bit,
    @OnProgPayment decimal(10, 5),
    -- periodised
    @OnProgPaymentUncapped decimal(10, 5),
    -- periodised
    @OnProgPayPct decimal(10, 5),
    -- periodised
    @OnProgPayPctPreTrans decimal(10, 5),
    @OnProgPayPctTrans decimal(10, 5),
    -- periodised
    @OutstndNumOnProgInstalm int,
    @OutstndNumOnProgInstalmTrans int,
    @PlannedNumOnProgInstalm int,
    @PlannedNumOnProgInstalmTrans int,
    @PlannedTotalDaysIL int,
    @PlannedTotalDaysILPreTrans int,
    @PropFundRemain decimal(10, 5),
    @PropFundRemainAch decimal(10, 5),
    @PrscHEAim bit,
    @Residential bit,
    @Restart bit,
    @SpecResUplift decimal(10, 5),
    @StartPropTrans decimal(10, 5),
    @ThresholdDays int,
    @Traineeship bit,
    @Trans bit,
    @TransInstPerPeriod int,
    -- periodised
    @TrnAdjLearnStartDate date,
    @TrnWorkPlaceAim bit,
    @TrnWorkPrepAim bit,
    @UnWeightedRateFromESOL decimal(10, 5),
    @UnweightedRateFromLARS decimal(10, 5),
    @WeightedRateFromESOL decimal(10, 5),
    @WeightedRateFromLARS decimal(10, 5),
    @ReservedUpliftFactor1 decimal(10, 5),
    @ReservedUpliftRate1 decimal(10, 5)
  ) as begin
set
  nocount on
insert into
  Rulebase.FM35_LearningDelivery (
    UKPRN,
    LearnRefNumber,
    AimSeqNumber,
    AchApplicDate,
    Achieved,
    AchieveElement,
    AchievePayElig,
    AchievePayPctPreTrans,
    AchPayTransHeldBack,
    ActualDaysIL,
    ActualNumInstalm,
    ActualNumInstalmPreTrans,
    ActualNumInstalmTrans,
    AdjLearnStartDate,
    AdltLearnResp,
    AgeAimStart,
    AimValue,
    AppAdjLearnStartDate,
    AppAgeFact,
    AppATAGTA,
    AppCompetency,
    AppFuncSkill,
    AppFuncSkill1618AdjFact,
    AppKnowl,
    AppLearnStartDate,
    ApplicEmpFactDate,
    ApplicFactDate,
    ApplicFundRateDate,
    ApplicProgWeightFact,
    ApplicUnweightFundRate,
    ApplicWeightFundRate,
    AppNonFund,
    AreaCostFactAdj,
    BalInstalmPreTrans,
    BaseValueUnweight,
    CapFactor,
    DisUpFactAdj,
    EmpOutcomePayElig,
    EmpOutcomePctHeldBackTrans,
    EmpOutcomePctPreTrans,
    EmpRespOth,
    ESOL,
    FullyFund,
    FundLine,
    FundStart,
    LargeEmployerID,
    LargeEmployerFM35Fctr,
    LargeEmployerStatusDate,
    LearnDelFundOrgCode,
    LTRCUpliftFctr,
    NonGovCont,
    OLASSCustody,
    OnProgPayPctPreTrans,
    OutstndNumOnProgInstalm,
    OutstndNumOnProgInstalmTrans,
    PlannedNumOnProgInstalm,
    PlannedNumOnProgInstalmTrans,
    PlannedTotalDaysIL,
    PlannedTotalDaysILPreTrans,
    PropFundRemain,
    PropFundRemainAch,
    PrscHEAim,
    Residential,
    [Restart],
    SpecResUplift,
    StartPropTrans,
    ThresholdDays,
    Traineeship,
    Trans,
    TrnAdjLearnStartDate,
    TrnWorkPlaceAim,
    TrnWorkPrepAim,
    UnWeightedRateFromESOL,
    UnweightedRateFromLARS,
    WeightedRateFromESOL,
    WeightedRateFromLARS,
    ReservedUpliftFactor1,
    ReservedUpliftRate1
  )
values
  (
    @UKPRN,
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
    @LargeEmployerFM35Fctr,
    @LargeEmployerStatusDate,
    @LearnDelFundOrgCode,
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
    @WeightedRateFromLARS,
    @ReservedUpliftFactor1,
    @ReservedUpliftRate1
  )
end
go
  if object_id(
    'Rulebase.FM35_Insert_LearningDelivery_PeriodisedValues',
    'p'
  ) is not null begin drop procedure Rulebase.FM35_Insert_LearningDelivery_PeriodisedValues
end
go
  create procedure Rulebase.FM35_Insert_LearningDelivery_PeriodisedValues (
    @LearnRefNumber varchar(12),
    @AimSeqNumber int,
    @AttributeName varchar(100),
    @Period_1 decimal(15, 5),
    @Period_2 decimal(15, 5),
    @Period_3 decimal(15, 5),
    @Period_4 decimal(15, 5),
    @Period_5 decimal(15, 5),
    @Period_6 decimal(15, 5),
    @Period_7 decimal(15, 5),
    @Period_8 decimal(15, 5),
    @Period_9 decimal(15, 5),
    @Period_10 decimal(15, 5),
    @Period_11 decimal(15, 5),
    @Period_12 decimal(15, 5)
  ) as begin
set
  nocount on
insert into
  Rulebase.FM35_LearningDelivery_PeriodisedValues (
    UKPRN,
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
    (SELECT TOP(1) UKPRN FROM [dbo].UKPRNForProcedures),
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
  if object_id(
    'Rulebase.FM35_PivotTemporals_LearningDelivery',
    'p'
  ) is not null begin drop procedure Rulebase.FM35_PivotTemporals_LearningDelivery
end
go
  create procedure Rulebase.FM35_PivotTemporals_LearningDelivery as begin truncate table Rulebase.FM35_LearningDelivery_Period
insert into
  Rulebase.FM35_LearningDelivery_Period
select
 UnrequiredAlias.UKPRN,
 LearnRefNumber,
 AimSeqNumber,
 [Period],
 max(
  case
   AttributeName
   when 'AchievePayment' then [Value]
   else null
  end
 ) AchievePayment,
 max(
  case
   AttributeName
   when 'AchievePayPct' then [Value]
   else null
  end
 ) AchievePayPct,
 max(
  case
   AttributeName
   when 'AchievePayPctTrans' then [Value]
   else null
  end
 ) AchievePayPctTrans,
 max(
  case
   AttributeName
   when 'BalancePayment' then [Value]
   else null
  end
 ) BalancePayment,
 max(
  case
   AttributeName
   when 'BalancePaymentUncapped' then [Value]
   else null
  end
 ) BalancePaymentUncapped,
 max(
  case
   AttributeName
   when 'BalancePct' then [Value]
   else null
  end
 ) BalancePct,
 max(
  case
   AttributeName
   when 'BalancePctTrans' then [Value]
   else null
  end
 ) BalancePctTrans,
 max(
  case
   AttributeName
   when 'EmpOutcomePay' then [Value]
   else null
  end
 ) EmpOutcomePay,
 max(
  case
   AttributeName
   when 'EmpOutcomePct' then [Value]
   else null
  end
 ) EmpOutcomePct,
 max(
  case
   AttributeName
   when 'EmpOutcomePctTrans' then [Value]
   else null
  end
 ) EmpOutcomePctTrans,
 max(
  case
   AttributeName
   when 'InstPerPeriod' then [Value]
   else null
  end
 ) InstPerPeriod,
 max(
  case
   AttributeName
   when 'LearnSuppFund' then [Value]
   else null
  end
 ) LearnSuppFund,
 max(
  case
   AttributeName
   when 'LearnSuppFundCash' then [Value]
   else null
  end
 ) LearnSuppFundCash,
 max(
  case
   AttributeName
   when 'OnProgPayment' then [Value]
   else null
  end
 ) OnProgPayment,
 max(
  case
   AttributeName
   when 'OnProgPaymentUncapped' then [Value]
   else null
  end
 ) OnProgPaymentUncapped,
 max(
  case
   AttributeName
   when 'OnProgPayPct' then [Value]
   else null
  end
 ) OnProgPayPct,
 max(
  case
   AttributeName
   when 'OnProgPayPctTrans' then [Value]
   else null
  end
 ) OnProgPayPctTrans,
 max(
  case
   AttributeName
   when 'TransInstPerPeriod' then [Value]
   else null
  end
 ) TransInstPerPeriod
from
 (
  select
   UKPRN,
   LearnRefNumber,
   AimSeqNumber,
   AttributeName,
   cast(substring(PeriodValue.[Period], 8, 2) as int) as [Period],
   PeriodValue.[Value]
  from
   Rulebase.FM35_LearningDelivery_PeriodisedValues pv unpivot (
    [Value] for [Period] in (
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
   ) as PeriodValue
   
 ) as UnrequiredAlias
 JOIN dbo.UKPRNForProcedures ufp
   on ufp.UKPRN = UnrequiredAlias.UKPRN
group by
 UnrequiredAlias.UKPRN,
 LearnRefNumber,
 AimSeqNumber,
 [Period]
end
go
