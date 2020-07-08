if object_id('Rulebase.FM25_FM35_Get_Cases', 'p') is not null begin drop procedure Rulebase.FM25_FM35_Get_Cases
end
go
  create procedure Rulebase.FM25_FM35_Get_Cases as begin
select
  CaseData
from
  Rulebase.FM25_FM35_Cases  C
	JOIN dbo.UKPRNForProcedures UFP
	ON UFP.UKPRN = C.UKPRN
end
go
  if object_id('Rulebase.FM25_FM35_Insert_Cases', 'p') is not null begin drop procedure Rulebase.FM25_FM35_Insert_Cases
end
go
  create procedure Rulebase.FM25_FM35_Insert_Cases as begin
set
  nocount on
insert into
  Rulebase.FM25_FM35_Cases (UKPRN, LearnRefNumber, CaseData)
select
    ControllingTable.UKPRN,
  ControllingTable.LearnRefNumber,
  convert(
    xml,
    (
      select
        VLP.UKPRN as [@UKPRN],
        (
          select
            FM25.LearnRefNumber as [@LearnRefNumber],
            FM25.LearnerStartDate as [@LearnerStartDate],
            FM25.LearnerPlanEndDate as [@LearnerPlanEndDate],
            FM25.LearnerActEndDate as [@LearnerActEndDate],
            FM25.FundLine as [@FundLine],
            FM25.AcadMonthPayment as [@AcadMonthPayment],
            FM25.OnProgPayment as [@OnProgPayment]
          from
            Rulebase.FM25_Learner as FM25
          where
            FM25.LearnRefNumber = ControllingTable.LearnRefNumber
            and FM25.UKPRN = ControllingTable.UKPRN for xml path ('Learner'),
            type
        )
      from
        Valid.LearningProvider as VLP where VLP.UKPRN = ControllingTable.UKPRN for xml path ('global'),
        type
    )
  )
from
  (SELECT l.UKPRN, l.LearnRefNumber FROM Valid.Learner l inner join [dbo].UKPRNForProcedures p on l.UKPRN = p.UKPRN) as ControllingTable
  INNER JOIN Rulebase.FM25_Learner FM25L on FM25L.LearnRefNumber = ControllingTable.LearnRefNumber and FM25L.UKPRN = ControllingTable.UKPRN
end
go
  if object_id('Rulebase.FM25_FM35_Insert_global', 'p') is not null begin drop procedure Rulebase.FM25_FM35_Insert_global
end
go
  create procedure Rulebase.FM25_FM35_Insert_global (@RulebaseVersion varchar(10), @UKPRN int) as begin
insert into
  Rulebase.FM25_FM35_global (UKPRN, RulebaseVersion)
values
  (@UKPRN, @RulebaseVersion)
end
go
  if object_id('Rulebase.FM25_FM35_Insert_Learner', 'p') is not null begin drop procedure Rulebase.FM25_FM35_Insert_Learner
end
go
  create procedure Rulebase.FM25_FM35_Insert_Learner (
    @UKPRN int,
    @LearnRefNumber varchar(12),
    @LnrOnProgPay decimal(10, 5)
  ) as begin
set
  nocount on -- nothing to do, for the OPA blackbox only
end
go
  if object_id(
    'Rulebase.FM25_FM35_Insert_Learner_PeriodisedValues',
    'p'
  ) is not null begin drop procedure Rulebase.FM25_FM35_Insert_Learner_PeriodisedValues
end
go
  create procedure Rulebase.FM25_FM35_Insert_Learner_PeriodisedValues (
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
insert into
  Rulebase.FM25_FM35_Learner_PeriodisedValues (
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
    (select UKPRN from [dbo].UKPRNForProcedures),
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
  if object_id('Rulebase.FM25_FM35_PivotTemporals_Learner', 'p') is not null begin drop procedure Rulebase.FM25_FM35_PivotTemporals_Learner
end
go
  create procedure Rulebase.FM25_FM35_PivotTemporals_Learner as begin truncate table Rulebase.FM25_FM35_Learner_Period
insert into
  Rulebase.FM25_FM35_Learner_Period
select
  UKPRN,
  LearnRefNumber,
  [Period],
  max(
    case
      AttributeName
      when 'LnrOnProgPay' then [Value]
      else null
    end
  ) as LnrOnProgPay
from
  (
    select
      UKPRN,
      LearnRefNumber,
      AttributeName,
      cast(substring(PeriodValue.[Period], 8, 2) as int) as [Period],
      PeriodValue.[Value]
    from
      [Rulebase].[FM25_FM35_Learner_PeriodisedValues] unpivot (
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
