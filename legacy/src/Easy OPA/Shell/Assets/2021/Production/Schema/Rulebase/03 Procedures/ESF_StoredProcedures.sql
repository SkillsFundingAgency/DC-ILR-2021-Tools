if object_id('Rulebase.ESF_Get_Cases', 'p') is not null begin drop procedure Rulebase.ESF_Get_Cases
end
go
  create procedure Rulebase.ESF_Get_Cases as begin
select
  CaseData
from
  Rulebase.ESF_Cases C
	JOIN dbo.UKPRNForProcedures UFP
	ON UFP.UKPRN = C.UKPRN
end
go
  if object_id('Rulebase.ESF_Insert_Cases', 'p') is not null begin drop procedure Rulebase.ESF_Insert_Cases
end
go
  create procedure Rulebase.ESF_Insert_Cases as begin
insert into
 Rulebase.ESF_Cases (UKPRN, LearnRefNumber, CaseData)
select
 ControllingTable.UKPRN,
 ControllingTable.LearnRefNumber,
 convert(
  xml,(
   select
    LearningProvider.UKPRN as [@UKPRN],
    (
     select
      l.DateOfBirth as [@DateOfBirth],
      l.LearnRefNumber as [@LearnRefNumber],
      (
       select
        les.DateEmpStatApp as [@DateEmpStatApp],
        les.[EmpStat] as [@EMPStat]
       from
        Valid.LearnerEmploymentStatus as les
       where
        les.LearnRefNumber = l.LearnRefNumber
        and les.UKPRN = l.UKPRN for xml path ('LearnerEmploymentStatus'),
        type
      ),
      (
       select
        dp.OutType as [@OutType],
        dp.OutCode as [@OutCode],
        dp.OutStartDate as [@OutStartDate],
        dp.OutEndDate as [@OutEndDate],
        dp.OutCollDate as [@OutCollDate]
       from
        Valid.DPOutcome as dp
       where
        dp.LearnRefNumber = l.LearnRefNumber
        and dp.UKPRN = l.UKPRN for xml path ('DPOutcome'),
        type
      ),
      (
       select
        ld.LearnAimRef as [@LearnAimRef],
        ld.ConRefNumber as [@ConRefNumber],
        ld.AimSeqNumber as [@AimSeqNumber],
        ld.LearnStartDate as [@LearnStartDate],
        ld.LearnPlanEndDate as [@LearnPlanEndDate],
        ld.LearnActEndDate as [@LearnActEndDate],
        ld.OrigLearnStartDate as [@OrigLearnStartDate],
        ld.CompStatus as [@CompStatus],
        ld.Outcome as [@Outcome],
        lld.LearningDeliveryGenre as [@GenreCode],
        ld.AchDate as [@AchDate],
        ld.PriorLearnFundAdj as [@PriorLearnFundAdj],
        ld.OtherFundAdj as [@OtherFundAdj],
        ld.AddHours as [@AddHours],
        LOT.CalcMethod as [@CalcMethod],
        (
         select
          ESFData.ExternalDeliverableCode as [@ESFDeliverableCode],
          ESFData.contractStartDate as [@EffectiveContractStartDate],
          ESFData.contractEndDate as [@EffectiveContractEndDate],
          ESFData.learningRatePremiumFactor as [@ESFDataPremiumFactor],
          ESFData.unitCost as [@UnitCost]
         from
          (
           select
            vw_ContractDescription.contractEndDate,
            vw_ContractDescription.contractStartDate,
            vw_ContractDescription.learningRatePremiumFactor,
            DeliverableCodeMappings.ExternalDeliverableCode,
            vw_ContractDescription.unitCost,
            vw_ContractDescription.contractAllocationNumber,
            DeliverableCodeMappings.FundingStreamPeriodCode,
            DeliverableCodeMappings.FCSDeliverableCode
           from
            Reference.DeliverableCodeMappings
            inner join Reference.vw_ContractDescription on DeliverableCodeMappings.FundingStreamPeriodCode = vw_ContractDescription.fundingStreamPeriodCode
            and DeliverableCodeMappings.FCSDeliverableCode = vw_ContractDescription.deliverableCode
          ) as ESFData
         where
          ESFData.contractAllocationNumber = ld.ConRefNumber for xml path ('ESFData'),
          type
        ),
        (
         select
          lf.FundingCategory as [@LARSFundingCategory],
          lf.EffectiveFrom as [@LARSFundingEffectiveFrom],
          lf.EffectiveTo as [@LARSFundingEffectiveTo],
          lf.RateWeighted as [@LARSFundingWeightedRate]
         from
          Reference.LARS_Funding as lf
         where
          lf.LearnAimRef = ld.LearnAimRef for xml path ('LearningDeliveryLARSFunding'),
          type
        ),
        (
         select
          lav.BasicSkillsType as [@LearnDelAnnValBasicSkillsTypeCode],
          lav.EffectiveFrom as [@LearnDelAnnValDateFrom],
          lav.EffectiveTo as [@LearnDelAnnValDateTo]
         from
          Reference.LARS_AnnualValue as lav
         where
          lav.LearnAimRef = ld.LearnAimRef for xml path ('LearningDeliveryAnnualValue'),
          type
        ),
        (
         select
          SFA_PostcodeAreaCost.EffectiveFrom as [@AreaCosEffectiveFrom],
          SFA_PostcodeAreaCost.EffectiveTo as [@AreaCosEffectiveTo],
          SFA_PostcodeAreaCost.AreaCostFactor as [@AreaCosFactor]
         from
          Reference.SFA_PostcodeAreaCost
         where
          SFA_PostcodeAreaCost.Postcode = ld.DelLocPostCode for xml path ('SFA_PostcodeAreaCost'),
          type
        ),
        (
         select
          LearnDelFAMCode as [@LearnDelFAMCode],
          LearnDelFAMDateFrom as [@LearnDelFAMDateFrom],
          LearnDelFAMDateTo as [@LearnDelFAMDateTo],
          LearnDelFAMType as [@LearnDelFAMType]
         from
          Valid.LearningDeliveryFAM
         where
          LearnRefNumber = ld.LearnRefNumber
          and UKPRN = ld.UKPRN
          and AimSeqNumber = ld.AimSeqNumber for xml path ('LearningDeliveryFAM'),
          type
        )
       from
        Valid.LearningDelivery as ld
        left join Reference.LARS_LearningDelivery as lld on lld.LearnAimRef = ld.LearnAimRef
        left join (
         select
          Lot.CalcMethod,
          ContractAllocation.ContractAllocationNumber,
          Lot.TenderSpecificationReference,
          Lot.LotReference
         from
          Reference.Lot
          inner join Reference.ContractAllocation on Lot.TenderSpecificationReference = ContractAllocation.TenderSpecReference
          and Lot.LotReference = ContractAllocation.LotReference
        ) as LOT on LOT.ContractAllocationNumber = ld.ConRefNumber
       where
        ld.LearnRefNumber = l.LearnRefNumber
        and ld.UKPRN = l.UKPRN
        and ld.FundModel = 70 for xml path ('LearningDelivery'),
        type
      )
     from
      Valid.Learner as l
     where
      l.LearnRefNumber = globalLearner.LearnRefNumber
      and l.UKPRN = globalLearner.UKPRN for xml path ('Learner'),
      type
    )
   from
    Valid.Learner as globalLearner
    cross join Valid.LearningProvider
    cross join Reference.LARS_Current_Version
   where
    globalLearner.LearnRefNumber = ControllingTable.LearnRefNumber
    and globalLearner.UKPRN = ControllingTable.UKPRN for xml path ('global'),
    type
  )
 )
from
 (SELECT l.UKPRN, l.LearnRefNumber FROM Valid.Learner l inner join [dbo].UKPRNForProcedures p on l.UKPRN = p.UKPRN) as ControllingTable
 inner join (
  select
   distinct ld.UKPRN,
   ld.LearnRefNumber
  from
   Valid.LearningDelivery ld
   join [dbo].UKPRNForProcedures p on p.UKPRN = ld.UKPRN
  where
   ld.FundModel = 70
 ) as Filter_LearningDelivery on Filter_LearningDelivery.LearnRefNumber = ControllingTable.LearnRefNumber
 and Filter_LearningDelivery.UKPRN = ControllingTable.UKPRN
end
go
  if object_id('Rulebase.ESF_Insert_global', 'p') is not null begin drop procedure Rulebase.ESF_Insert_global
end
go
  create procedure Rulebase.ESF_Insert_global (@RulebaseVersion varchar(10), @UKPRN int) as begin
insert into
  Rulebase.ESF_global (UKPRN, RulebaseVersion)
values
  (@UKPRN, @RulebaseVersion)
end
go
  if object_id('Rulebase.ESF_Insert_Learner', 'p') is not null begin drop procedure Rulebase.ESF_Insert_Learner
end
go
  create procedure Rulebase.ESF_Insert_Learner (@LearnRefNumber varchar(12)) as begin -- nothing to do, but i has to be here for the OPA black box
set
  nocount on
end
go
  if object_id('Rulebase.ESF_Insert_LearningDelivery', 'p') is not null begin drop procedure Rulebase.ESF_Insert_LearningDelivery
end
go
  create procedure Rulebase.ESF_Insert_LearningDelivery (
    @UKPRN int,
    @LearnRefNumber varchar(12),
    @Achieved bit,
    @AddProgCostElig bit,
    @AdjustedAreaCostFactor decimal(9, 5),
    @AdjustedPremiumFactor decimal(9, 5),
    @AdjustedStartDate date,
    @AimClassification varchar(50),
    @AimSeqNumber int,
    @AimValue decimal(10, 5),
    @ApplicWeightFundRate decimal(10, 5),
    @EligibleProgressionOutcomeCode bigint,
    @EligibleProgressionOutcomeType varchar(4),
    @EligibleProgressionOutomeStartDate date,
    @FundStart bit,
    @LARSWeightedRate decimal(10, 5),
    @LatestPossibleStartDate date,
    @LDESFEngagementStartDate date,
    @PotentiallyEligibleForProgression bit,
    @ProgressionEndDate date,
    @Restart bit,
    @WeightedRateFromESOL decimal(10, 5),
    @LearnDelLearnerEmpAtStart bit
  ) as begin
insert into
  Rulebase.ESF_LearningDelivery (
    UKPRN,
    LearnRefNumber,
    AimSeqNumber,
    Achieved,
    AddProgCostElig,
    AdjustedAreaCostFactor,
    AdjustedPremiumFactor,
    AdjustedStartDate,
    AimClassification,
    AimValue,
    ApplicWeightFundRate,
    EligibleProgressionOutcomeCode,
    EligibleProgressionOutcomeType,
    EligibleProgressionOutomeStartDate,
    LearnDelLearnerEmpAtStart,
    FundStart,
    LARSWeightedRate,
    LatestPossibleStartDate,
    LDESFEngagementStartDate,
    PotentiallyEligibleForProgression,
    ProgressionEndDate,
    [Restart],
    WeightedRateFromESOL
  )
values
  (
    @UKPRN,
    @LearnRefNumber,
    @AimSeqNumber,
    @Achieved,
    @AddProgCostElig,
    @AdjustedAreaCostFactor,
    @AdjustedPremiumFactor,
    @AdjustedStartDate,
    @AimClassification,
    @AimValue,
    @ApplicWeightFundRate,
    @EligibleProgressionOutcomeCode,
    @EligibleProgressionOutcomeType,
    @EligibleProgressionOutomeStartDate,
    @LearnDelLearnerEmpAtStart,
    @FundStart,
    @LARSWeightedRate,
    @LatestPossibleStartDate,
    @LDESFEngagementStartDate,
    @PotentiallyEligibleForProgression,
    @ProgressionEndDate,
    @Restart,
    @WeightedRateFromESOL
  )
end
go
  if object_id(
    'Rulebase.ESF_Insert_LearningDeliveryDeliverable',
    'p'
  ) is not null begin drop procedure Rulebase.ESF_Insert_LearningDeliveryDeliverable
end
go
  -- the parameter to insertion mismatch is down to some values being 'periodised'
  create procedure Rulebase.ESF_Insert_LearningDeliveryDeliverable (
    @UKPRN int,
    @LearnRefNumber varchar(12),
    @AimSeqNumber int,
    @AchievementEarnings decimal(10, 5),
    @AdditionalProgCostEarnings decimal(10, 5),
    @DeliverableCode varchar(5),
    @DeliverableUnitCost decimal(10, 5),
    @DeliverableVolume bigint,
    @ProgressionEarnings decimal(10, 5),
    @ReportingVolume int,
    @StartEarnings decimal(10, 5)
  ) as begin
insert into
  Rulebase.ESF_LearningDeliveryDeliverable (
    UKPRN,
    LearnRefNumber,
    AimSeqNumber,
    DeliverableCode,
    DeliverableUnitCost
  )
values
  (
    @UKPRN,
    @LearnRefNumber,
    @AimSeqNumber,
    @DeliverableCode,
    @DeliverableUnitCost
  )
end
go
  if object_id(
    'Rulebase.ESF_Insert_LearningDeliveryDeliverable_PeriodisedValues',
    'p'
  ) is not null begin drop procedure Rulebase.ESF_Insert_LearningDeliveryDeliverable_PeriodisedValues
end
go
  create procedure Rulebase.ESF_Insert_LearningDeliveryDeliverable_PeriodisedValues (
    @LearnRefNumber varchar(12),
    @AimSeqNumber int,
    @DeliverableCode varchar(5),
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
  Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues (
    UKPRN,
    LearnRefNumber,
    AimSeqNumber,
    DeliverableCode,
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
    @DeliverableCode,
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
    'Rulebase.ESF_PivotTemporals_LearningDeliveryDeliverable',
    'p'
  ) is not null begin drop procedure Rulebase.ESF_PivotTemporals_LearningDeliveryDeliverable
end
go
  create procedure Rulebase.ESF_PivotTemporals_LearningDeliveryDeliverable as begin truncate table Rulebase.ESF_LearningDeliveryDeliverable_Period
insert into
  Rulebase.ESF_LearningDeliveryDeliverable_Period (
    UKPRN,
    LearnRefNumber,
    AimSeqNumber,
    DeliverableCode,
    [Period],
    AchievementEarnings,
    AdditionalProgCostEarnings,
    DeliverableVolume,
    ProgressionEarnings,
    ReportingVolume,
    StartEarnings
  )
select
  UKPRN,
  LearnRefNumber,
  AimSeqNumber,
  DeliverableCode,
  [Period],
  max(
    case
      AttributeName
      when 'AchievementEarnings' then [Value]
      else null
    end
  ) as AchievementEarnings,
  max(
    case
      AttributeName
      when 'AdditionalProgCostEarnings' then [Value]
      else null
    end
  ) as AdditionalProgCostEarnings,
  max(
    case
      AttributeName
      when 'DeliverableVolume' then [Value]
      else null
    end
  ) as DeliverableVolume,
  max(
    case
      AttributeName
      when 'ProgressionEarnings' then [Value]
      else null
    end
  ) as ProgressionEarnings,
  max(
    case
      AttributeName
      when 'ReportingVolume' then [Value]
      else null
    end
  ) as ReportingVolume,
  max(
    case
      AttributeName
      when 'StartEarnings' then [Value]
      else null
    end
  ) as StartEarnings
from
  (
    select
      UKPRN,
      LearnRefNumber,
      AimSeqNumber,
      DeliverableCode,
      AttributeName,
      cast(substring(PeriodValue.[Period], 8, 2) as int) as [Period],
      PeriodValue.[Value]
    from
      Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues unpivot (
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
  ) as Bob
group by
  UKPRN,
  LearnRefNumber,
  AimSeqNumber,
  DeliverableCode,
  [Period]
end
go
  if object_id('Rulebase.ESF_Insert_DPOutcome', 'p') is not null begin drop procedure Rulebase.ESF_Insert_DPOutcome
end
go
  create procedure Rulebase.ESF_Insert_DPOutcome (
    @UKPRN int,
    @LearnRefNumber varchar(12),
    @OutCode int,
    @OutcomeDateForProgression date,
    @OutStartDate date,
    @OutType varchar(30),
    @PotentialESFProgressionType bit,
    @ProgressionType varchar(50),
    @ReachedSixMonthPoint bit,
    @ReachedThreeMonthPoint bit,
    @ReachedTwelveMonthPoint bit
  ) as begin
insert into
  Rulebase.ESF_DPOutcome (
    UKPRN,
    LearnRefNumber,
    OutCode,
    OutType,
    OutStartDate,
    OutcomeDateForProgression,
    PotentialESFProgressionType,
    ProgressionType,
    ReachedSixMonthPoint,
    ReachedThreeMonthPoint,
    ReachedTwelveMonthPoint
  )
values
  (
    @UKPRN,
    @LearnRefNumber,
    @OutCode,
    @OutType,
    @OutStartDate,
    @OutcomeDateForProgression,
    @PotentialESFProgressionType,
    @ProgressionType,
    @ReachedSixMonthPoint,
    @ReachedThreeMonthPoint,
    @ReachedTwelveMonthPoint
  )
end
go
