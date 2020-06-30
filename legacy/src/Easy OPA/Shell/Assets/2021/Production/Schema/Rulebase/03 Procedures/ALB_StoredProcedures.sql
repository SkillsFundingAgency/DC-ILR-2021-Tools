if object_id('[Rulebase].[ALB_Get_Cases]', 'p') is not null begin drop procedure [Rulebase].[ALB_Get_Cases]
end
go
  create procedure [Rulebase].[ALB_Get_Cases] as begin
set
  nocount on
select
  CaseData
from
  [Rulebase].[ALB_Cases]
end
go
  if object_id('[Rulebase].[ALB_Insert_Cases]', 'p') is not null begin drop procedure [Rulebase].[ALB_Insert_Cases]
end
go
  create procedure [Rulebase].[ALB_Insert_Cases] as begin
set
  nocount on
insert into
  [Rulebase].[ALB_Cases] (UKPRN, [LearnRefNumber], CaseData)
select
  ControllingTable.UKPRN,
  ControllingTable.[LearnRefNumber],
  convert(
    xml,
    (
      select
        [LARS_Current_Version].[CurrentVersion] as [@LARSVersion],
        [SFA_PostcodeAreaCost_Current_Version].[CurrentVersion] as [@PostcodeAreaCostVersion],
        [LearningProvider].[UKPRN] as [@UKPRN],
        (
          select
            [Learner].[LearnRefNumber] as [@LearnRefNumber],
            (
              select
                [ldd].[FundModel] as [@LearnDelFundModel],
                [lars_ld].[LearnAimRefType] as [@LearnAimRefType],
                [ldd].[AimSeqNumber] as [@AimSeqNumber],
                [ldd].[CompStatus] as [@CompStatus],
                [ldd].[Outcome] as [@Outcome],
                [ldd].[LearnStartDate] as [@LearnStartDate],
                [ldd].[LearnPlanEndDate] as [@LearnPlanEndDate],
                [ldd].[LearnActEndDate] as [@LearnActEndDate],
                [ldd].[OrigLearnStartDate] as [@OrigLearnStartDate],
                [lars_ld].[NotionalNVQLevelv2] as [@NotionalNVQLevelv2],
                [lars_ld].[RegulatedCreditValue] as [@RegulatedCreditValue],
                [ldd].[PriorLearnFundAdj] as [@PriorLearnFundAdj],
                [ldd].[OtherFundAdj] as [@OtherFundAdj],
                (
                  select
                    [LearnDelFAMCode] as [@LearnDelFAMCode],
                    [LearnDelFAMDateFrom] as [@LearnDelFAMDateFrom],
                    [LearnDelFAMDateTo] as [@LearnDelFAMDateTo],
                    [LearnDelFAMType] as [@LearnDelFAMType]
                  from
                    [Valid].[LearningDeliveryFAM]
                  where
                    [LearnRefNumber] = [ldd].[LearnRefNumber]
                    and UKPRN = ldd.UKPRN
                    and [AimSeqNumber] = [ldd].[AimSeqNumber] for xml path ('LearningDeliveryFAM'),
                    type
                ),
                (
                  select
                    [EffectiveFrom] as [@AreaCosEffectiveFrom],
                    [EffectiveTo] as [@AreaCosEffectiveTo],
                    [AreaCostFactor] as [@AreaCosFactor]
                  from
                    [Reference].[SFA_PostcodeAreaCost]
                  where
                    [Postcode] = [ldd].[DelLocPostCode] for xml path ('SFA_PostcodeAreaCost'),
                    type
                ),
                (
                  select
                    [FundingCategory] as [@LARSFundCategory],
                    [EffectiveFrom] as [@LARSFundEffectiveFrom],
                    [EffectiveTo] as [@LARSFundEffectiveTo],
                    [RateWeighted] as [@LARSFundWeightedRate],
                    [WeightingFactor] as [@LARSFundWeightingFactor]
                  from
                    [Reference].[LARS_Funding]
                  where
                    [LearnAimRef] = [ldd].[LearnAimRef]
                    and UKPRN = ldd.UKPRN for xml path ('LearningDeliveryLARS_Funding'),
                    type
                )
              from
                [Valid].[LearningDeliveryDenormTbl] as ldd
                left join [Reference].[LARS_LearningDelivery] as lars_ld on [lars_ld].[LearnAimRef] = [ldd].[LearnAimRef]
              where
                [ldd].[LearnRefNumber] = [Learner].[LearnRefNumber]
                and ldd.UKPRN = Learner.UKPRN
                and [ldd].[FundModel] = 99 for xml path ('LearningDelivery'),
                type
            )
          from
            [Valid].[Learner]
          where
            [Learner].[LearnRefNumber] = [ControllingTable].[LearnRefNumber]
            and Learner.UKPRN = ControllingTable.UKPRN for xml path ('Learner'),
            type
        )
      from
        [Valid].[LearningProvider]
        cross join [Reference].[LARS_Current_Version]
        cross join [Reference].[SFA_PostcodeAreaCost_Current_Version]
        where UKPRN = ControllingTable.UKPRN
        for xml path ('global'),
        type
    )
  )
from
  [Valid].[Learner] ControllingTable
  inner join (
    select
      distinct ld.UKPRN,
      [LearnRefNumber]
    from
      [Valid].[LearningDelivery] ld
      join [dbo].UKPRNForProcedures ufp on ufp.UKPRN = ld.UKPRN
    where
      [FundModel] = 99
  ) as [Filter_LearningDelivery] on [Filter_LearningDelivery].[LearnRefNumber] = [ControllingTable].[LearnRefNumber]
end
go
  if object_id('[Rulebase].[ALB_Insert_global]', 'p') is not null begin drop procedure [Rulebase].[ALB_Insert_global]
end
go
  create procedure [Rulebase].[ALB_Insert_global] (
    @UKPRN int,
    @LARSVersion varchar(100),
    @PostcodeAreaCostVersion varchar(20),
    @RulebaseVersion varchar(10)
  ) as begin
set
  nocount on
insert into
  [Rulebase].[ALB_global] (
    UKPRN,
    LARSVersion,
    PostcodeAreaCostVersion,
    RulebaseVersion
  )
values
  (
    @UKPRN,
    @LARSVersion,
    @PostcodeAreaCostVersion,
    @RulebaseVersion
  )
end
go
  if object_id('[Rulebase].[ALB_Insert_Learner]', 'p') is not null begin drop procedure [Rulebase].[ALB_Insert_Learner]
end
go
  create procedure [Rulebase].[ALB_Insert_Learner] (@UKPRN int, @LearnRefNumber varchar(12), @ALBSeqNum int) as begin
set
  nocount on -- nothing is persisted here, this is just required for OPA
end
go
  if object_id(
    '[Rulebase].[ALB_Insert_Learner_PeriodisedValues]',
    'p'
  ) is not null begin drop procedure [Rulebase].[ALB_Insert_Learner_PeriodisedValues]
end
go
  create procedure [Rulebase].[ALB_Insert_Learner_PeriodisedValues] (
    @LearnRefNumber varchar(12),
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
  [Rulebase].[ALB_Learner_PeriodisedValues] (
    UKPRN,
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
  )
values
  (
     (SELECT TOP(1) UKPRN FROM [dbo].UKPRNForProcedures),
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
  if object_id('[Rulebase].[ALB_PivotTemporals_Learner]', 'p') is not null begin drop procedure [Rulebase].[ALB_PivotTemporals_Learner]
end
go
  create procedure [Rulebase].[ALB_PivotTemporals_Learner] as begin truncate table [Rulebase].[ALB_Learner_Period]
insert into
  [Rulebase].[ALB_Learner_Period]
select
  UKPRN,
  LearnRefNumber,
  [Period],
  max(
    case
      AttributeName
      when 'ALBSeqNum' then Value
      else null
    end
  ) as ALBSeqNum
from
  (
    select
      UKPRN,
      LearnRefNumber,
      AttributeName,
      cast(substring([PeriodValue].[Period], 8, 2) as int) as [Period],
      [PeriodValue].[Value]
    from
      [Rulebase].[ALB_Learner_PeriodisedValues] unpivot (
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
group by
  UKPRN,
  LearnRefNumber,
  [Period]
end
go
  if object_id('[Rulebase].[ALB_Insert_LearningDelivery]', 'p') is not null begin drop procedure [Rulebase].[ALB_Insert_LearningDelivery]
end
go
  create procedure [Rulebase].[ALB_Insert_LearningDelivery] (
    @UKPRN int,
    @LearnRefNumber varchar(12),
    @AimSeqNumber int,
    @AreaCostFactAdj decimal(10, 5),
    @WeightedRate decimal(12, 5),
    @PlannedNumOnProgInstalm int,
    @FundStart bit,
    @Achieved bit,
    @ActualNumInstalm int,
    @OutstndNumOnProgInstalm int,
    @AreaCostInstalment decimal(12, 5),
    @AdvLoan bit,
    @LoanBursAreaUplift bit,
    @LoanBursSupp bit,
    @FundLine varchar(50),
    @LiabilityDate date,
    @ApplicProgWeightFact varchar(1),
    @ApplicFactDate date,
    -- the next 4 are periodic pivots
    @AreaUpliftOnProgPayment decimal(12, 5),
    @AreaUpliftBalPayment decimal(12, 5),
    @ALBCode int,
    @ALBSupportPayment decimal(12, 5)
  ) as begin
set
  nocount on
insert into
  [Rulebase].[ALB_LearningDelivery] (
    UKPRN,
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
    ApplicFactDate
  )
values
  (
    @UKPRN,
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
    @ApplicFactDate
  )
end
go
  if object_id(
    '[Rulebase].[ALB_Insert_LearningDelivery_PeriodisedValues]',
    'p'
  ) is not null begin drop procedure [Rulebase].[ALB_Insert_LearningDelivery_PeriodisedValues]
end
go
  create procedure [Rulebase].[ALB_Insert_LearningDelivery_PeriodisedValues] (
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
  [Rulebase].[ALB_LearningDelivery_PeriodisedValues] (
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
    '[Rulebase].[ALB_PivotTemporals_LearningDelivery]',
    'p'
  ) is not null begin drop procedure [Rulebase].[ALB_PivotTemporals_LearningDelivery]
end
go
  create procedure [Rulebase].[ALB_PivotTemporals_LearningDelivery] as begin truncate table [Rulebase].[ALB_LearningDelivery_Period]
insert into
  [Rulebase].[ALB_LearningDelivery_Period]
select
  UKPRN,
  LearnRefNumber,
  AimSeqNumber,
  [Period],
  max(
    case
      AttributeName
      when 'AreaUpliftOnProgPayment' then [Value]
      else null
    end
  ) as AreaUpliftOnProgPayment,
  max(
    case
      AttributeName
      when 'AreaUpliftBalPayment' then [Value]
      else null
    end
  ) as AreaUpliftBalPayment,
  max(
    case
      AttributeName
      when 'ALBCode' then [Value]
      else null
    end
  ) as ALBCode,
  max(
    case
      AttributeName
      when 'ALBSupportPayment' then [Value]
      else null
    end
  ) as ALBSupportPayment
from
  (
    select
      UKPRN,
      LearnRefNumber,
      AimSeqNumber,
      AttributeName,
      cast(substring([PeriodValue].[Period], 8, 2) as int) as [Period],
      [PeriodValue].[Value]
    from
      [Rulebase].[ALB_LearningDelivery_PeriodisedValues] unpivot (
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
group by
  UKPRN,
  LearnRefNumber,
  AimSeqNumber,
  [Period]
end
go
