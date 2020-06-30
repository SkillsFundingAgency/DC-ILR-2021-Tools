if object_id('Rulebase.TBL_Get_Cases', 'p') is not null begin drop procedure Rulebase.TBL_Get_Cases
end
go
  create procedure Rulebase.TBL_Get_Cases as begin
select
  CaseData
from
  Rulebase.TBL_Cases
end
go
  if object_id('Rulebase.TBL_Insert_Cases', 'p') is not null begin drop procedure Rulebase.TBL_Insert_Cases
end
go
  create procedure Rulebase.TBL_Insert_Cases as begin
insert into
  Rulebase.TBL_Cases (UKPRN, LearnRefNumber, CaseData)
select
  Filter_LearningDelivery.UKPRN,
  Filter_LearningDelivery.LearnRefNumber,
  convert(
    xml,
    (
      select
        LARS_Current_Version.CurrentVersion as [@LARSVersion],
        LearningProvider.UKPRN as [@UKPRN],
        (
          select
            Learner.DateOfBirth as [@DateOfBirth],
            Learner.LearnRefNumber as [@LearnRefNumber],
            (
              select
                LearningDelivery.AchDate as [@AchDate],
                LearningDelivery.AimSeqNumber as [@AimSeqNumber],
                LearningDelivery.AimType as [@AimType],
                LearningDelivery.CompStatus as [@CompStatus],
                LARS_LearningDelivery.FrameworkCommonComponent as [@FrameworkCommonComponent],
                LearningDelivery.LearnActEndDate as [@LearnActEndDate],
                LearningDelivery.LearnAimRef as [@LearnAimRef],
                LearningDelivery.LearnPlanEndDate as [@LearnPlanEndDate],
                LearningDelivery.LearnStartDate as [@LearnStartDate],
                LearningDelivery.OrigLearnStartDate as [@OrigLearnStartDate],
                LearningDelivery.OtherFundAdj as [@OtherFundAdj],
                LearningDelivery.Outcome as [@Outcome],
                LearningDelivery.PriorLearnFundAdj as [@PriorLearnFundAdj],
                LearningDelivery.ProgType as [@ProgType],
                LearningDelivery.StdCode as [@STDCode],
                LearningDelivery.WithdrawReason as [@WithdrawReason],
                (
                  select
                    AppFinRecord.AFinAmount as [@AFinAmount],
                    AppFinRecord.AFinCode as [@AFinCode],
                    AppFinRecord.AFinDate as [@AFinDate],
                    AppFinRecord.AFinType as [@AFinType]
                  from
                    Valid.AppFinRecord
                  where
                    AppFinRecord.LearnRefNumber = LearningDelivery.LearnRefNumber
                    and AppFinRecord.UKPRN = LearningDelivery.UKPRN
                    and AppFinRecord.AimSeqNumber = LearningDelivery.AimSeqNumber for xml path ('ApprenticeshipFinancialRecord'),
                    type
                ),
                (
                  select
                    LearningDeliveryFAM.LearnDelFAMCode as [@LearnDelFAMCode],
                    LearningDeliveryFAM.LearnDelFAMDateFrom as [@LearnDelFAMDateFrom],
                    LearningDeliveryFAM.LearnDelFAMDateTo as [@LearnDelFAMDateTo],
                    LearningDeliveryFAM.LearnDelFAMType as [@LearnDelFAMType]
                  from
                    Valid.LearningDeliveryFAM
                  where
                    LearningDeliveryFAM.LearnRefNumber = LearningDelivery.LearnRefNumber
                    and LearningDeliveryFAM.UKPRN = LearningDelivery.UKPRN
                    and LearningDeliveryFAM.AimSeqNumber = LearningDelivery.AimSeqNumber for xml path ('LearningDeliveryFAM'),
                    type
                ),
                (
                  select
                    LARS_StandardCommonComponent.CommonComponent as [@LARSCommonComponent],
                    LARS_StandardCommonComponent.EffectiveFrom as [@LARSEffectiveFrom],
                    LARS_StandardCommonComponent.EffectiveTo as [@LARSEffectiveTo],
                    LARS_StandardCommonComponent.StandardCode as [@LARSStandardCode]
                  from
                    Reference.LARS_StandardCommonComponent
                  where
                    LARS_StandardCommonComponent.StandardCode = LearningDelivery.StdCode for xml path ('LARS_StandardCommonComponent'),
                    type
                ),
                (
                  select
                    LARS_StandardFunding.FundableWithoutEmployer as [@FundableWithoutEmployer],
                    LARS_StandardFunding.[1618Incentive] as [@SF1618Incentive],
                    LARS_StandardFunding.AchievementIncentive as [@SFAchIncentive],
                    LARS_StandardFunding.CoreGovContributionCap as [@SFCoreGovContCap],
                    LARS_StandardFunding.EffectiveFrom as [@SFEffectiveFromDate],
                    LARS_StandardFunding.EffectiveTo as [@SFEffectiveToDate],
                    LARS_StandardFunding.SmallBusinessIncentive as [@SFSmallBusIncentive]
                  from
                    Reference.LARS_StandardFunding
                  where
                    LARS_StandardFunding.StandardCode = LearningDelivery.StdCode
                    and LARS_StandardFunding.FundingCategory = 'StandardTblazer' for xml path ('LARS_StandardFunding'),
                    type
                )
              from
                Valid.LearningDelivery
                left join Reference.LARS_LearningDelivery on LARS_LearningDelivery.LearnAimRef = LearningDelivery.LearnAimRef
              where
                LearningDelivery.LearnRefNumber = Learner.LearnRefNumber
                and LearningDelivery.UKPRN = Learner.UKPRN
                and LearningDelivery.ProgType = 25
                and LearningDelivery.FundModel = 81 for xml path ('LearningDelivery'),
                type
            ),
            (
              select
                LearnerEmploymentStatus.DateEmpStatApp as [@DateEmpStatApp],
                LearnerEmploymentStatus.EmpId as [@EmpId],
                LearnerEmploymentStatus.EmpStat as [@EMPStat],
                EmpStatMon_SEM.ESMCode as [@EmpStatMon_SEM]
              from
                Valid.LearnerEmploymentStatus
                left join Valid.EmploymentStatusMonitoring as EmpStatMon_SEM on EmpStatMon_SEM.LearnRefNumber = LearnerEmploymentStatus.LearnRefNumber
                and EmpStatMon_SEM.UKPRN = LearnerEmploymentStatus.UKPRN
                and EmpStatMon_SEM.ESMType = 'SEM'
              where
                LearnerEmploymentStatus.LearnRefNumber = Learner.LearnRefNumber for xml path ('LearnerEmploymentStatus'),
                type
            )
          from
            Valid.Learner
          where
            Learner.LearnRefNumber = Filter_LearningDelivery.LearnRefNumber for xml path ('Learner'),
            type
        )
      from
        Valid.LearningProvider
        cross join Reference.LARS_Current_Version
        where UKPRN = Filter_LearningDelivery.UKPRN for xml path ('global'),
        type
    )
  )
from
  (
    select
      distinct ld.UKPRN,
      ld.LearnRefNumber
    from
      Valid.LearningDelivery ld
      inner join [dbo].UKPRNForProcedures p on p.UKPRN = ld.UKPRN
    where
      ld.ProgType = 25
      and ld.FundModel = 81
  ) as Filter_LearningDelivery
end
go
  if object_id('Rulebase.TBL_Insert_global', 'p') is not null begin drop procedure [Rulebase].[TBL_Insert_global]
end
go
  create procedure Rulebase.TBL_Insert_global (
    @UKPRN int,
    @CurFundYr varchar(10),
    @LARSVersion varchar(100),
    @RulebaseVersion varchar(10)
  ) as begin
insert into
  Rulebase.TBL_global (
    UKPRN,
    CurFundYr,
    LARSVersion,
    RulebaseVersion
  )
values
  (
    @UKPRN,
    @CurFundYr,
    @LARSVersion,
    @RulebaseVersion
  )
end
go
  if object_id('[Rulebase].[TBL_Insert_LearningDelivery]', 'p') is not null begin drop procedure [Rulebase].[TBL_Insert_LearningDelivery]
end
go
  create procedure [Rulebase].[TBL_Insert_LearningDelivery] (
    @UKPRN int,
    @LearnRefNumber varchar(12),
    @AimSeqNumber int,
    @ProgStandardStartDate date,
    @FundLine varchar(50),
    @MathEngAimValue decimal(10, 5),
    @PlannedNumOnProgInstalm int,
    @LearnSuppFundCash decimal(10, 5),
    @AdjProgStartDate date,
    @LearnSuppFund bit,
    @MathEngOnProgPayment decimal(10, 5),
    @InstPerPeriod int,
    @SmallBusPayment decimal(10, 5),
    @YoungAppSecondPayment decimal(10, 5),
    @CoreGovContPayment decimal(10, 5),
    @YoungAppEligible bit,
    @SmallBusEligible bit,
    @MathEngOnProgPct int,
    @AgeStandardStart int,
    @YoungAppSecondThresholdDate date,
    @EmpIdFirstDayStandard int,
    @EmpIdFirstYoungAppDate int,
    @EmpIdSecondYoungAppDate int,
    @EmpIdSmallBusDate int,
    @YoungAppFirstThresholdDate date,
    @AchApplicDate date,
    @AchEligible bit,
    @Achieved bit,
    @AchievementApplicVal decimal(10, 5),
    @AchPayment decimal(10, 5),
    @ActualNumInstalm int,
    @CombinedAdjProp decimal(10, 5),
    @EmpIdAchDate int,
    @LearnDelDaysIL int,
    @LearnDelStandardAccDaysIL int,
    @LearnDelStandardPrevAccDaysIL int,
    @LearnDelStandardTotalDaysIL int,
    @ActualDaysIL int,
    @MathEngBalPayment decimal(10, 5),
    @MathEngBalPct bigint,
    @MathEngLSFFundStart bit,
    @PlannedTotalDaysIL int,
    @MathEngLSFThresholdDays int,
    @OutstandNumOnProgInstalm int,
    @SmallBusApplicVal decimal(10, 5),
    @SmallBusStatusFirstDayStandard int,
    @SmallBusStatusThreshold int,
    @YoungAppApplicVal decimal(10, 5),
    @CoreGovContCapApplicVal bigint,
    @CoreGovContUncapped decimal(10, 5),
    @ApplicFundValDate date,
    @YoungAppFirstPayment decimal(10, 5),
    @YoungAppPayment decimal(10, 5)
  ) as begin
set
  nocount on
insert into
  [Rulebase].[TBL_LearningDelivery] (
    UKPRN,
    LearnRefNumber,
    AimSeqNumber,
    ProgStandardStartDate,
    FundLine,
    MathEngAimValue,
    PlannedNumOnProgInstalm,
    LearnSuppFundCash,
    AdjProgStartDate,
    LearnSuppFund,
    MathEngOnProgPayment,
    InstPerPeriod,
    SmallBusPayment,
    YoungAppSecondPayment,
    CoreGovContPayment,
    YoungAppEligible,
    SmallBusEligible,
    MathEngOnProgPct,
    AgeStandardStart,
    YoungAppSecondThresholdDate,
    EmpIdFirstDayStandard,
    EmpIdFirstYoungAppDate,
    EmpIdSecondYoungAppDate,
    EmpIdSmallBusDate,
    YoungAppFirstThresholdDate,
    AchApplicDate,
    AchEligible,
    Achieved,
    AchievementApplicVal,
    AchPayment,
    ActualNumInstalm,
    CombinedAdjProp,
    EmpIdAchDate,
    LearnDelDaysIL,
    LearnDelStandardAccDaysIL,
    LearnDelStandardPrevAccDaysIL,
    LearnDelStandardTotalDaysIL,
    ActualDaysIL,
    MathEngBalPayment,
    MathEngBalPct,
    MathEngLSFFundStart,
    PlannedTotalDaysIL,
    MathEngLSFThresholdDays,
    OutstandNumOnProgInstalm,
    SmallBusApplicVal,
    SmallBusStatusFirstDayStandard,
    SmallBusStatusThreshold,
    YoungAppApplicVal,
    CoreGovContCapApplicVal,
    CoreGovContUncapped,
    ApplicFundValDate,
    YoungAppFirstPayment,
    YoungAppPayment
  )
values
  (
    @UKPRN,
    @LearnRefNumber,
    @AimSeqNumber,
    @ProgStandardStartDate,
    @FundLine,
    @MathEngAimValue,
    @PlannedNumOnProgInstalm,
    @LearnSuppFundCash,
    @AdjProgStartDate,
    @LearnSuppFund,
    @MathEngOnProgPayment,
    @InstPerPeriod,
    @SmallBusPayment,
    @YoungAppSecondPayment,
    @CoreGovContPayment,
    @YoungAppEligible,
    @SmallBusEligible,
    @MathEngOnProgPct,
    @AgeStandardStart,
    @YoungAppSecondThresholdDate,
    @EmpIdFirstDayStandard,
    @EmpIdFirstYoungAppDate,
    @EmpIdSecondYoungAppDate,
    @EmpIdSmallBusDate,
    @YoungAppFirstThresholdDate,
    @AchApplicDate,
    @AchEligible,
    @Achieved,
    @AchievementApplicVal,
    @AchPayment,
    @ActualNumInstalm,
    @CombinedAdjProp,
    @EmpIdAchDate,
    @LearnDelDaysIL,
    @LearnDelStandardAccDaysIL,
    @LearnDelStandardPrevAccDaysIL,
    @LearnDelStandardTotalDaysIL,
    @ActualDaysIL,
    @MathEngBalPayment,
    @MathEngBalPct,
    @MathEngLSFFundStart,
    @PlannedTotalDaysIL,
    @MathEngLSFThresholdDays,
    @OutstandNumOnProgInstalm,
    @SmallBusApplicVal,
    @SmallBusStatusFirstDayStandard,
    @SmallBusStatusThreshold,
    @YoungAppApplicVal,
    @CoreGovContCapApplicVal,
    @CoreGovContUncapped,
    @ApplicFundValDate,
    @YoungAppFirstPayment,
    @YoungAppPayment
  )
end
go
  if object_id(
    '[Rulebase].[TBL_Insert_LearningDelivery_PeriodisedValues]',
    'p'
  ) is not null begin drop procedure [Rulebase].[TBL_Insert_LearningDelivery_PeriodisedValues]
end
go
  create procedure [Rulebase].[TBL_Insert_LearningDelivery_PeriodisedValues] (
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
insert into
  [Rulebase].[TBL_LearningDelivery_PeriodisedValues] (
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
    '[Rulebase].[TBL_PivotTemporals_LearningDelivery]',
    'p'
  ) is not null begin drop procedure [Rulebase].[TBL_PivotTemporals_LearningDelivery]
end
go
  create procedure [Rulebase].[TBL_PivotTemporals_LearningDelivery] as begin truncate table [Rulebase].[TBL_LearningDelivery_Period]
insert into
  [Rulebase].[TBL_LearningDelivery_Period] (
    UKPRN,
    LearnRefNumber,
    AimSeqNumber,
    [Period],
    AchPayment,
    CoreGovContPayment,
    CoreGovContUncapped,
    InstPerPeriod,
    LearnSuppFund,
    LearnSuppFundCash,
    MathEngBalPayment,
    MathEngBalPct,
    MathEngOnProgPayment,
    MathEngOnProgPct,
    SmallBusPayment,
    YoungAppFirstPayment,
    YoungAppPayment,
    YoungAppSecondPayment
  )
select
  UKPRN,
  LearnRefNumber,
  AimSeqNumber,
  [Period],
  max(
    case
      AttributeName
      when 'AchPayment' then Value
      else null
    end
  ) as AchPayment,
  max(
    case
      AttributeName
      when 'CoreGovContPayment' then Value
      else null
    end
  ) as CoreGovContPayment,
  max(
    case
      AttributeName
      when 'CoreGovContUncapped' then Value
      else null
    end
  ) as CoreGovContUncapped,
  max(
    case
      AttributeName
      when 'InstPerPeriod' then Value
      else null
    end
  ) as InstPerPeriod,
  max(
    case
      AttributeName
      when 'LearnSuppFund' then Value
      else null
    end
  ) as LearnSuppFund,
  max(
    case
      AttributeName
      when 'LearnSuppFundCash' then Value
      else null
    end
  ) as LearnSuppFundCash,
  max(
    case
      AttributeName
      when 'MathEngBalPayment' then Value
      else null
    end
  ) as MathEngBalPayment,
  max(
    case
      AttributeName
      when 'MathEngBalPct' then Value
      else null
    end
  ) as MathEngBalPct,
  max(
    case
      AttributeName
      when 'MathEngOnProgPayment' then Value
      else null
    end
  ) as MathEngOnProgPayment,
  max(
    case
      AttributeName
      when 'MathEngOnProgPct' then Value
      else null
    end
  ) as MathEngOnProgPct,
  max(
    case
      AttributeName
      when 'SmallBusPayment' then Value
      else null
    end
  ) as SmallBusPayment,
  max(
    case
      AttributeName
      when 'YoungAppFirstPayment' then Value
      else null
    end
  ) as YoungAppFirstPayment,
  max(
    case
      AttributeName
      when 'YoungAppPayment' then Value
      else null
    end
  ) as YoungAppPayment,
  max(
    case
      AttributeName
      when 'YoungAppSecondPayment' then Value
      else null
    end
  ) as YoungAppSecondPayment
from
  (
    select
      UKPRN,
      LearnRefNumber,
      AimSeqNumber,
      AttributeName,
      cast(substring(PeriodValue.Period, 8, 2) as int) as [Period],
      PeriodValue.Value
    from
      Rulebase.TBL_LearningDelivery_PeriodisedValues unpivot (
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
  ) as TBLPeriodValues
group by
  TBLPeriodValues.UKPRN,
  TBLPeriodValues.LearnRefNumber,
  TBLPeriodValues.AimSeqNumber,
  TBLPeriodValues.[Period]
end
go
