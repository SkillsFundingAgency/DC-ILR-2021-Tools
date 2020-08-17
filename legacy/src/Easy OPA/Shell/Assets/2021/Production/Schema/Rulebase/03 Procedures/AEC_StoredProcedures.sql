if object_id('Rulebase.AEC_Get_Cases', 'p') is not null begin drop procedure Rulebase.AEC_Get_Cases
end
go
  create procedure Rulebase.AEC_Get_Cases as begin
set
  nocount on
select
  CaseData
from
  Rulebase.AEC_Cases C
	JOIN dbo.UKPRNForProcedures UFP
	ON UFP.UKPRN = C.UKPRN
end
go
  if object_id('Rulebase.AEC_Insert_Cases', 'p') is not null begin drop procedure Rulebase.AEC_Insert_Cases
end
go
  create procedure Rulebase.AEC_Insert_Cases (@ReturnPeriod varchar(5)) as begin
set
  nocount on
insert into
  Rulebase.AEC_Cases (UKPRN, LearnRefNumber, CaseData)
select
  ControllingTable.UKPRN,
  ControllingTable.[LearnRefNumber],
  convert(
    xml,
    (
      select
        ControllingTable.UKPRN as [@UKPRN],
        lars_cv.CurrentVersion as [@LARSVersion],
        @ReturnPeriod as [@CollectionPeriod],
        '2021' as [@Year],

        (
          select
            l.LearnRefNumber as [@LearnRefNumber],
            l.ULN as [@ULN],
            l.DateOfBirth as [@DateOfBirth],
            l.PrevUKPRN as [@PrevUKPRN],
            l.PMUKPRN as [@PMUKPRN],
            (
              select
                LearnRefNumber as [@HistoricLearnRefNumberInput],
                UKPRN as [@HistoricUKPRNInput],
                ULN as [@HistoricULNInput],
                ProgType as [@HistoricProgTypeInput],
                PwayCode as [@HistoricPwayCodeInput],
                FworkCode as [@HistoricFworkCodeInput],
                STDCode as [@HistoricSTDCodeInput],
                case
                  HistoricLearner1618StartInput
                  when 1 then 'true'
                  else 'false'
                end as [@HistoricLearner1618AtStartInput],
                AppIdentifier as [@AppIdentifierInput],
                case
                  AppProgCompletedInTheYearInput
                  when 1 then 'true'
                  else 'false'
                end as [@AppProgCompletedInTheYearInput],
                CollectionReturnCode as [@HistoricCollectionReturnInput],
                CollectionYear as [@HistoricCollectionYearInput],
                DaysInYear as [@HistoricDaysInYearInput],
                HistoricEffectiveTNPStartDateInput as [@HistoricEffectiveTNPStartDateInput],
                HistoricEmpIdStartWithinYear as [@HistoricEmpIdStartWithinYear],
                HistoricEmpIdEndWithinYear as [@HistoricEmpIdEndWithinYearInput],
                ProgrammeStartDateIgnorePathway as [@HistoricProgrammeStartDateIgnorePathwayInput],
                ProgrammeStartDateMatchPathway as [@HistoricProgrammeStartDateMatchPathwayInput],
                HistoricLearnDelProgEarliestACT2DateInput as [@HistoricLearnDelProgEarliestACT2DateInput],
                UptoEndDate as [@HistoricUptoEndDateInput],
                HistoricPMRAmount as [@HistoricPMRAmountInput],
                HistoricTNP1Input as [@HistoricTNP1Input],
                HistoricTNP2Input as [@HistoricTNP2Input],
                HistoricTNP3Input as [@HistoricTNP3Input],
                HistoricTNP4Input as [@HistoricTNP4Input],
                HistoricVirtualTNP3EndOfTheYearInput as [@HistoricVirtualTNP3EndofTheYearInput],
                HistoricVirtualTNP4EndOfTheYearInput as [@HistoricVirtualTNP4EndofTheYearInput],
                HistoricTotal1618UpliftPaymentsInTheYearInput as [@HistoricTotal1618UpliftPaymentsInTheYearInput],
                TotalProgAimPaymentsInTheYear as [@HistoricTotalProgAimPaymentsInTheYearInput]
              from
                Reference.AEC_LatestInYearEarningHistory
              where
                ULN = l.ULN for xml path ('HistoricEarningInput'),
                type
            ),
            (
              select
                les.EmpId as [@EmpId],
                les.DateEmpStatApp as [@DateEmpStatApp],
                les.EmpStat as [@EMPStat],
                lesd.ESMCode_SEM as [@EmpStatMon_SEM]
              from
                Valid.LearnerEmploymentStatus as les
                join Valid.LearnerEmploymentStatusDenorm as lesd on lesd.LearnRefNumber = les.LearnRefNumber
                and lesd.UKPRN = les.UKPRN
                and lesd.DateEmpStatApp = les.DateEmpStatApp
              where
                les.LearnRefNumber = l.LearnRefNumber
                and les.UKPRN = l.UKPRN for xml path ('LearnerEmploymentStatus'),
                type
            ),
            (
              select
                EffectiveFrom as [@DisUpEffectiveFrom],
                EffectiveTo as [@DisUpEffectiveTo],
                Apprenticeship_Uplift as [@DisApprenticeshipUplift]
              from
                Reference.SFA_PostcodeDisadvantage
              where
                Postcode = l.PostcodePrior for xml path ('SFA_PostcodeDisadvantage'),
                type
            ),
            (
              select
                ld.AimSeqNumber as [@AimSeqNumber],
                ld.LearnAimRef as [@LearnAimRef],
                ld.AimType as [@AimType],
                ld.ProgType as [@ProgType],
                ld.PwayCode as [@PwayCode],
                ld.FworkCode as [@FworkCode],
                ld.StdCode as [@STDCode],
                ld.CompStatus as [@CompStatus],
                ld.LearnStartDate as [@LearnStartDate],
                ld.LearnPlanEndDate as [@LearnPlanEndDate],
                ld.LearnActEndDate as [@LearnActEndDate],
                ld.OrigLearnStartDate as [@OrigLearnStartDate],
                ld.AchDate as [@AchDate],
                lars_ld.FrameworkCommonComponent as [@FrameworkCommonComponent],
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
                    AFinType as [@AFinType],
                    AFinCode as [@AFinCode],
                    AFinDate as [@AFinDate],
                    AFinAmount as [@AFinAmount]
                  from
                    Valid.AppFinRecord
                  where
                    LearnRefNumber = ld.LearnRefNumber
                    and UKPRN = ld.UKPRN
                    and AimSeqNumber = ld.AimSeqNumber for xml path ('ApprenticeshipFinancialRecord'),
                    type
                ),
                (
                  select
                    ld_lars_fcc.CommonComponent as [@LARSFrameworkCommonComponentCode],
                    ld_lars_fcc.EffectiveFrom as [@LARSFrameworkCommonComponentEffectiveFrom],
                    ld_lars_fcc.EffectiveTo as [@LARSFrameworkCommonComponentEffectiveTo]
                  from
                    (
                      select
                        lars_fcc.CommonComponent,
                        lars_fcc.EffectiveFrom,
                        lars_fcc.EffectiveTo,
                        lars_ld.LearnAimRef,
                        lars_fcc.FworkCode,
                        lars_fcc.ProgType,
                        lars_fcc.PwayCode
                      from
                        Reference.LARS_FrameworkCmnComp as lars_fcc
                        inner join Reference.LARS_LearningDelivery as lars_ld on lars_fcc.CommonComponent = lars_ld.FrameworkCommonComponent
                    ) as ld_lars_fcc
                  where
                    ld_lars_fcc.LearnAimRef = ld.LearnAimRef
                    and ld_lars_fcc.FworkCode = ld.FworkCode
                    and ld_lars_fcc.ProgType = ld.ProgType
                    and ld_lars_fcc.PwayCode = ld.PwayCode for xml path ('LARS_FrameworkCmnComp'),
                    type
                ),
                (
                  select
                    CommonComponent as [@LARSStandardCommonComponentCode],
                    EffectiveFrom as [@LARSStandardCommonComponentEffectiveFrom],
                    EffectiveTo as [@LARSStandardCommonComponentEffectiveTo]
                  from
                    Reference.LARS_StandardCommonComponent
                  where
                    StandardCode = ld.StdCode
                    and UKPRN = ld.UKPRN for xml path ('LARS_StandardCommonComponent'),
                    type
                ),
                (
                  select
                    FundingCategory as [@LARSFundCategory],
                    EffectiveFrom as [@LARSFundEffectiveFrom],
                    EffectiveTo as [@LARSFundEffectiveTo],
                    RateWeighted as [@LARSFundWeightedRate]
                  from
                    Reference.LARS_Funding
                  where
                    LearnAimRef = ld.LearnAimRef
                    and UKPRN = ld.UKPRN for xml path ('LearningDeliveryLARS_Funding'),
                    type
                ),
                (
                  select
                    FundingCategory as [@StandardAFFundingCategory],
                    EffectiveFrom as [@StandardAFEffectiveFrom],
                    EffectiveTo as [@StandardAFEffectiveTo],
                    [1618FrameworkUplift] as [@StandardAF1618FrameworkUplift],
                    [1618EmployerAdditionalPayment] as [@StandardAF1618EmployerAdditionalPayment],
                    [1618ProviderAdditionalPayment] as [@StandardAF1618ProviderAdditionalPayment],
                    CareLeaverAdditionalPayment as [@StandardAFCareLeaverAdditionalPayment],
                    MaxEmployerLevyCap as [@StandardAFMaxEmployerLevyCap],
                    ReservedValue2 as [@StandardAFReservedValue2],
                    ReservedValue3 as [@StandardAFReservedValue3]
                  from
                    Reference.LARS_ApprenticeshipFunding
                  where
                    ApprenticeshipType = 'STD'
                    and ApprenticeshipCode = ld.StdCode
                    and UKPRN = ld.UKPRN
                    and ProgType = ld.ProgType
                    and PwayCode = 0 for xml path ('Standard_LARS_ApprenticshipFunding'),
                    type
                ),
                (
                  select
                    FundingCategory as [@FrameworkAFFundingCategory],
                    EffectiveFrom as [@FrameworkAFEffectiveFrom],
                    EffectiveTo as [@FrameworkAFEffectiveTo],
                    [1618FrameworkUplift] as [@FrameworkAF1618FrameworkUplift],
                    [1618EmployerAdditionalPayment] as [@FrameworkAF1618EmployerAdditionalPayment],
                    [1618ProviderAdditionalPayment] as [@FrameworkAF1618ProviderAdditionalPayment],
                    CareLeaverAdditionalPayment as [@FrameworkAFCareLeaverAdditionalPayment],
                    MaxEmployerLevyCap as [@FrameworkAFMaxEmployerLevyCap],
                    ReservedValue2 as [@FrameworkAFReservedValue2],
                    ReservedValue3 as [@FrameworkAFReservedValue3]
                  from
                    Reference.LARS_ApprenticeshipFunding
                  where
                    ApprenticeshipType = 'FWK'
                    and ApprenticeshipCode = ld.FworkCode
                    and UKPRN = ld.UKPRN
                    and ProgType = ld.ProgType
                    and PwayCode = ld.PwayCode for xml path ('Framework_LARS_ApprenticshipFunding'),
                    type
                )
              from
                Valid.LearningDelivery as ld
                left join Reference.LARS_LearningDelivery as lars_ld on lars_ld.LearnAimRef = ld.LearnAimRef
              where
                ld.LearnRefNumber = l.LearnRefNumber
                and ld.UKPRN = l.UKPRN
                and ld.FundModel = 36 for xml path ('LearningDelivery'),
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
        cross join Reference.LARS_Current_Version as lars_cv
      where
        globalLearner.LearnRefNumber = ControllingTable.LearnRefNumber
        and globalLearner.UKPRN = ControllingTable.UKPRN for xml path ('global'),
        type
    )
  )
from
  (
    select
      distinct ufp.UKPRN,
      LearnRefNumber
    from
      Valid.LearningDelivery ld
      join [dbo].UKPRNForProcedures ufp on ufp.UKPRN = ld.UKPRN
    where
      FundModel = 36
  ) as ControllingTable
end
go
  if object_id('Rulebase.AEC_Insert_global', 'p') is not null begin drop procedure Rulebase.AEC_Insert_global
end
go
  create procedure Rulebase.AEC_Insert_global (
    @LARSVersion varchar(100),
    @RulebaseVersion varchar(10),
    @UKPRN int,
    @Year varchar(4)
  ) as begin
set
  nocount on
insert into
  Rulebase.AEC_global (
    UKPRN,
    LARSVersion,
    RulebaseVersion,
    [Year]
  )
values
  (
    @UKPRN,
    @LARSVersion,
    @RulebaseVersion,
    @Year
  )
end
go
  if object_id('Rulebase.AEC_Insert_Learner', 'p') is not null begin drop procedure Rulebase.AEC_Insert_Learner
end
go
  create procedure Rulebase.AEC_Insert_Learner (@UKPRN int, @LearnRefNumber varchar(12)) as begin
set
  nocount on
end
go
  if object_id('Rulebase.AEC_Insert_LearningDelivery', 'p') is not null begin drop procedure Rulebase.AEC_Insert_LearningDelivery
end
go
  create procedure Rulebase.AEC_Insert_LearningDelivery (
    @UKPRN int,
    @LearnRefNumber varchar(12),
    @AimSeqNumber int,
    @LearnAimRef varchar(8),
    @ActualDaysIL int = null,
    @ActualNumInstalm int = null,
    @AdjStartDate date = null,
    @AgeAtProgStart int = null,
    @AppAdjLearnStartDate date = null,
    @AppAdjLearnStartDateMatchPathway date = null,
    @ApplicCompDate date = null,
    @CombinedAdjProp decimal(12, 5) = null,
    @Completed bit = null,
    @FirstIncentiveThresholdDate date = null,
    @FundStart bit = null,
    @LDApplic1618FrameworkUpliftTotalActEarnings decimal(12, 5) = null,
    @LearnDel1618AtStart bit = null,
    @LearnDelAccDaysILCareLeavers int = null,
    @LearnDelAppAccDaysIL int = null,
    @LearnDelApplicCareLeaverIncentive decimal(12, 5) = null,
    @LearnDelApplicDisadvAmount decimal(12, 5) = null,
    @LearnDelApplicEmp1618Incentive decimal(12, 5) = null,
    @LearnDelApplicEmpDate date = null,
    @LearnDelApplicProv1618FrameworkUplift decimal(12, 5) = null,
    @LearnDelApplicProv1618Incentive decimal(12, 5) = null,
    @LearnDelAppPrevAccDaysIL int = null,
    @LearnDelDaysIL int = null,
    @LearnDelDisadAmount decimal(12, 5) = null,
    @LearnDelEligDisadvPayment bit = null,
    @LearnDelEmpIdFirstAdditionalPaymentThreshold int = null,
    @LearnDelEmpIdSecondAdditionalPaymentThreshold int = null,
    @LearnDelLearnerAddPayThresholdDate date = null,
    @LearnDelHistDaysCareLeavers int = null,
    @LearnDelHistDaysThisApp int = null,
    @LearnDelHistProgEarnings decimal(12, 5) = null,
    @LearnDelInitialFundLineType varchar(100) = null,
    @LearnDelMathEng bit = null,
    @LearnDelNonLevyProcured bit = null,
    @LearnDelPrevAccDaysILCareLeavers int = null,
    @LearnDelProgEarliestACT2Date date = null,
    @LearnDelRedCode int = null,
    @LearnDelRedStartDate date = null,
    @MathEngAimValue decimal(12, 5) = null,
    @OutstandNumOnProgInstalm int = null,
    @PlannedNumOnProgInstalm int = null,
    @PlannedTotalDaysIL int = null,
    @SecondIncentiveThresholdDate date = null,
    @ThresholdDays int = null,
    -- periodised
    @DisadvFirstPayment decimal(12, 5) = null,
    @DisadvSecondPayment decimal(12, 5) = null,
    @FundLineType varchar(100) = null,
    @InstPerPeriod int = null,
    @LDApplic1618FrameworkUpliftBalancingPayment decimal(12, 5) = null,
    @LDApplic1618FrameworkUpliftCompletionPayment decimal(12, 5) = null,
    @LDApplic1618FrameworkUpliftOnProgPayment decimal(12, 5) = null,
    @LearnDelContType varchar(50) = null,
    @LearnDelFirstEmp1618Pay decimal(12, 5) = null,
    @LearnDelFirstProv1618Pay decimal(12, 5) = null,
    @LearnDelLearnAddPayment decimal(12, 5) = null,
    @LearnDelLevyNonPayInd int = null,
    @LearnDelSecondEmp1618Pay decimal(12, 5) = null,
    @LearnDelSecondProv1618Pay decimal(12, 5) = null,
    @LearnDelSEMContWaiver bit = null,
    @LearnDelSFAContribPct decimal(12, 5) = null,
    @LearnDelESFAContribPct decimal(12, 5) = null,
    @LearnSuppFund bit = null,
    @LearnSuppFundCash decimal(12, 5) = null,
    @MathEngBalPayment decimal(12, 5) = null,
    @MathEngOnProgPayment decimal(12, 5) = null,
    @ProgrammeAimBalPayment decimal(12, 5) = null,
    @ProgrammeAimCompletionPayment decimal(12, 5) = null,
    @ProgrammeAimOnProgPayment decimal(12, 5) = null,
    @ProgrammeAimProgFundIndMaxEmpCont decimal(12, 5) = null,
    @ProgrammeAimProgFundIndMinCoInvest decimal(12, 5) = null,
    @ProgrammeAimTotProgFund decimal(12, 5) = null
  ) as begin
set
  nocount on
insert into
  Rulebase.AEC_LearningDelivery (
    UKPRN,
    LearnRefNumber,
    AimSeqNumber,
    LearnAimRef,
    ActualDaysIL,
    ActualNumInstalm,
    AdjStartDate,
    AgeAtProgStart,
    AppAdjLearnStartDate,
    AppAdjLearnStartDateMatchPathway,
    ApplicCompDate,
    CombinedAdjProp,
    Completed,
    FirstIncentiveThresholdDate,
    FundStart,
    LDApplic1618FrameworkUpliftTotalActEarnings,
    LearnDel1618AtStart,
    LearnDelAccDaysILCareLeavers,
    LearnDelAppAccDaysIL,
    LearnDelApplicCareLeaverIncentive,
    LearnDelApplicDisadvAmount,
    LearnDelApplicEmp1618Incentive,
    LearnDelApplicEmpDate,
    LearnDelApplicProv1618FrameworkUplift,
    LearnDelApplicProv1618Incentive,
    LearnDelAppPrevAccDaysIL,
    LearnDelDaysIL,
    LearnDelDisadAmount,
    LearnDelEligDisadvPayment,
    LearnDelEmpIdFirstAdditionalPaymentThreshold,
    LearnDelEmpIdSecondAdditionalPaymentThreshold,
    LearnDelLearnerAddPayThresholdDate,
    LearnDelHistDaysCareLeavers,
    LearnDelHistDaysThisApp,
    LearnDelHistProgEarnings,
    LearnDelInitialFundLineType,
    LearnDelMathEng,
    LearnDelNonLevyProcured,
    LearnDelPrevAccDaysILCareLeavers,
    LearnDelProgEarliestACT2Date,
    LearnDelRedCode,
    LearnDelRedStartDate,
    MathEngAimValue,
    OutstandNumOnProgInstalm,
    PlannedNumOnProgInstalm,
    PlannedTotalDaysIL,
    SecondIncentiveThresholdDate,
    ThresholdDays
  )
values
  (
    @UKPRN,
    @LearnRefNumber,
    @AimSeqNumber,
    @LearnAimRef,
    @ActualDaysIL,
    @ActualNumInstalm,
    @AdjStartDate,
    @AgeAtProgStart,
    @AppAdjLearnStartDate,
    @AppAdjLearnStartDateMatchPathway,
    @ApplicCompDate,
    @CombinedAdjProp,
    @Completed,
    @FirstIncentiveThresholdDate,
    @FundStart,
    @LDApplic1618FrameworkUpliftTotalActEarnings,
    @LearnDel1618AtStart,
    @LearnDelAccDaysILCareLeavers,
    @LearnDelAppAccDaysIL,
    @LearnDelApplicCareLeaverIncentive,
    @LearnDelApplicDisadvAmount,
    @LearnDelApplicEmp1618Incentive,
    @LearnDelApplicEmpDate,
    @LearnDelApplicProv1618FrameworkUplift,
    @LearnDelApplicProv1618Incentive,
    @LearnDelAppPrevAccDaysIL,
    @LearnDelDaysIL,
    @LearnDelDisadAmount,
    @LearnDelEligDisadvPayment,
    @LearnDelEmpIdFirstAdditionalPaymentThreshold,
    @LearnDelEmpIdSecondAdditionalPaymentThreshold,
    @LearnDelLearnerAddPayThresholdDate,
    @LearnDelHistDaysCareLeavers,
    @LearnDelHistDaysThisApp,
    @LearnDelHistProgEarnings,
    @LearnDelInitialFundLineType,
    @LearnDelMathEng,
    @LearnDelNonLevyProcured,
    @LearnDelPrevAccDaysILCareLeavers,
    @LearnDelProgEarliestACT2Date,
    @LearnDelRedCode,
    @LearnDelRedStartDate,
    @MathEngAimValue,
    @OutstandNumOnProgInstalm,
    @PlannedNumOnProgInstalm,
    @PlannedTotalDaysIL,
    @SecondIncentiveThresholdDate,
    @ThresholdDays
  )
end
go
  if object_id(
    'Rulebase.AEC_Insert_LearningDelivery_PeriodisedValues',
    'p'
  ) is not null begin drop procedure Rulebase.AEC_Insert_LearningDelivery_PeriodisedValues
end
go
  create procedure Rulebase.AEC_Insert_LearningDelivery_PeriodisedValues (
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
  Rulebase.AEC_LearningDelivery_PeriodisedValues (
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
    'Rulebase.AEC_Insert_LearningDelivery_PeriodisedTextValues',
    'p'
  ) is not null begin drop procedure Rulebase.AEC_Insert_LearningDelivery_PeriodisedTextValues
end
go
  create procedure Rulebase.AEC_Insert_LearningDelivery_PeriodisedTextValues (
    @LearnRefNumber varchar(12),
    @AimSeqNumber int,
    @AttributeName varchar(100),
    @Period_1 varchar(255) = null,
    @Period_2 varchar(255) = null,
    @Period_3 varchar(255) = null,
    @Period_4 varchar(255) = null,
    @Period_5 varchar(255) = null,
    @Period_6 varchar(255) = null,
    @Period_7 varchar(255) = null,
    @Period_8 varchar(255) = null,
    @Period_9 varchar(255) = null,
    @Period_10 varchar(255) = null,
    @Period_11 varchar(255) = null,
    @Period_12 varchar(255) = null
  ) as begin
set
  nocount on
insert into
  Rulebase.AEC_LearningDelivery_PeriodisedTextValues (
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
    case
      @Period_1
      when 'Unknown' then null
      else @Period_1
    end,
    case
      @Period_2
      when 'Unknown' then null
      else @Period_2
    end,
    case
      @Period_3
      when 'Unknown' then null
      else @Period_3
    end,
    case
      @Period_4
      when 'Unknown' then null
      else @Period_4
    end,
    case
      @Period_5
      when 'Unknown' then null
      else @Period_5
    end,
    case
      @Period_6
      when 'Unknown' then null
      else @Period_6
    end,
    case
      @Period_7
      when 'Unknown' then null
      else @Period_7
    end,
    case
      @Period_8
      when 'Unknown' then null
      else @Period_8
    end,
    case
      @Period_9
      when 'Unknown' then null
      else @Period_9
    end,
    case
      @Period_10
      when 'Unknown' then null
      else @Period_10
    end,
    case
      @Period_11
      when 'Unknown' then null
      else @Period_11
    end,
    case
      @Period_12
      when 'Unknown' then null
      else @Period_12
    end
  )
end
go
  if object_id(
    'Rulebase.AEC_PivotTemporals_LearningDelivery',
    'p'
  ) is not null begin drop procedure Rulebase.AEC_PivotTemporals_LearningDelivery
end
go
  create procedure Rulebase.AEC_PivotTemporals_LearningDelivery as begin -- why is there a truncate here???
  -- truncate table [Rulebase].[AEC_LearningDelivery_Period]
insert into
  Rulebase.AEC_LearningDelivery_Period (
    UKPRN,
    LearnRefNumber,
    AimSeqNumber,
    [Period],
    DisadvFirstPayment,
    DisadvSecondPayment,
    FundLineType,
    InstPerPeriod,
    LDApplic1618FrameworkUpliftBalancingPayment,
    LDApplic1618FrameworkUpliftCompletionPayment,
    LDApplic1618FrameworkUpliftOnProgPayment,
    LearnDelContType,
    LearnDelFirstEmp1618Pay,
    LearnDelFirstProv1618Pay,
    LearnDelLearnAddPayment,
    LearnDelLevyNonPayInd,
    LearnDelSecondEmp1618Pay,
    LearnDelSecondProv1618Pay,
    LearnDelSEMContWaiver,
    LearnDelSFAContribPct,
    LearnDelESFAContribPct,
    LearnSuppFund,
    LearnSuppFundCash,
    MathEngBalPayment,
    MathEngOnProgPayment,
    ProgrammeAimBalPayment,
    ProgrammeAimCompletionPayment,
    ProgrammeAimOnProgPayment,
    ProgrammeAimProgFundIndMaxEmpCont,
    ProgrammeAimProgFundIndMinCoInvest,
    ProgrammeAimTotProgFund
  )
select
  UnrequiredAlias.UKPRN,
  LearnRefNumber,
  AimSeqNumber,
  [Period],
  max(
    case
      AttributeName
      when 'DisadvFirstPayment' then Value
      else null
    end
  ) as DisadvFirstPayment,
  max(
    case
      AttributeName
      when 'DisadvSecondPayment' then Value
      else null
    end
  ) as DisadvSecondPayment,
  null as FundLineType,
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
      when 'LDApplic1618FrameworkUpliftBalancingPayment' then Value
      else null
    end
  ) as LDApplic1618FrameworkUpliftBalancingPayment,
  max(
    case
      AttributeName
      when 'LDApplic1618FrameworkUpliftCompletionPayment' then Value
      else null
    end
  ) as LDApplic1618FrameworkUpliftCompletionPayment,
  max(
    case
      AttributeName
      when 'LDApplic1618FrameworkUpliftOnProgPayment' then Value
      else null
    end
  ) as LDApplic1618FrameworkUpliftOnProgPayment,
  null as LearnDelContType,
  max(
    case
      AttributeName
      when 'LearnDelFirstEmp1618Pay' then Value
      else null
    end
  ) as LearnDelFirstEmp1618Pay,
  max(
    case
      AttributeName
      when 'LearnDelFirstProv1618Pay' then Value
      else null
    end
  ) as LearnDelFirstProv1618Pay,
  max(
    case
      AttributeName
      when 'LearnDelLearnAddPayment' then Value
      else null
    end
  ) as LearnDelLearnAddPayment,
  max(
    case
      AttributeName
      when 'LearnDelLevyNonPayInd' then Value
      else null
    end
  ) as LearnDelLevyNonPayInd,
  max(
    case
      AttributeName
      when 'LearnDelSecondEmp1618Pay' then Value
      else null
    end
  ) as LearnDelSecondEmp1618Pay,
  max(
    case
      AttributeName
      when 'LearnDelSecondProv1618Pay' then Value
      else null
    end
  ) as LearnDelSecondProv1618Pay,
  max(
    case
      AttributeName
      when 'LearnDelSEMContWaiver' then Value
      else null
    end
  ) as LearnDelSEMContWaiver,
  max(
    case
      AttributeName
      when 'LearnDelSFAContribPct' then Value
      else null
    end
  ) as LearnDelSFAContribPct,
  max(
    case
      AttributeName
      when 'LearnDelESFAContribPct' then Value
      else null
    end
  ) as LearnDelESFAContribPct,
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
      when 'MathEngOnProgPayment' then Value
      else null
    end
  ) as MathEngOnProgPayment,
  max(
    case
      AttributeName
      when 'ProgrammeAimBalPayment' then Value
      else null
    end
  ) as ProgrammeAimBalPayment,
  max(
    case
      AttributeName
      when 'ProgrammeAimCompletionPayment' then Value
      else null
    end
  ) as ProgrammeAimCompletionPayment,
  max(
    case
      AttributeName
      when 'ProgrammeAimOnProgPayment' then Value
      else null
    end
  ) as ProgrammeAimOnProgPayment,
  max(
    case
      AttributeName
      when 'ProgrammeAimProgFundIndMaxEmpCont' then Value
      else null
    end
  ) as ProgrammeAimProgFundIndMaxEmpCont,
  max(
    case
      AttributeName
      when 'ProgrammeAimProgFundIndMinCoInvest' then Value
      else null
    end
  ) as ProgrammeAimProgFundIndMinCoInvest,
  max(
    case
      AttributeName
      when 'ProgrammeAimTotProgFund' then Value
      else null
    end
  ) as ProgrammeAimTotProgFund
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
      Rulebase.AEC_LearningDelivery_PeriodisedValues unpivot (
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
  join dbo.UKPRNForProcedures ufp
	on UnrequiredAlias.UKPRN = ufp.UKPRN
group by
	UnrequiredAlias.UKPRN,
  LearnRefNumber,
  AimSeqNumber,
  [Period]
update
  Rulebase.AEC_LearningDelivery_Period
set
  FundLineType = SecondPass.FundLineType,
  LearnDelContType = SecondPass.LearnDelContType
from
  Rulebase.AEC_LearningDelivery_Period as FirstPass
  inner join (
    select
	  UnrequiredAlias.UKPRN,
      LearnRefNumber,
      AimSeqNumber,
      [Period],
      max(
        case
          AttributeName
          when 'FundLineType' then [Value]
          else null
        end
      ) as FundLineType,
      max(
        case
          AttributeName
          when 'LearnDelContType' then [Value]
          else null
        end
      ) as LearnDelContType
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
          Rulebase.AEC_LearningDelivery_PeriodisedTextValues unpivot (
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
	  join dbo.UKPRNForProcedures ufp
		on UnrequiredAlias.UKPRN = ufp.UKPRN
    group by
	  UnrequiredAlias.UKPRN,
      LearnRefNumber,
      AimSeqNumber,
      [Period]
  ) as SecondPass on FirstPass.LearnRefNumber = SecondPass.LearnRefNumber
  and FirstPass.AimSeqNumber = SecondPass.AimSeqNumber
  and FirstPass.[Period] = SecondPass.[Period]
end
go
  if object_id('Rulebase.AEC_Insert_HistoricEarningOutput', 'p') is not null begin drop procedure Rulebase.AEC_Insert_HistoricEarningOutput
end
go
  create procedure Rulebase.AEC_Insert_HistoricEarningOutput (
    @UKPRN int,
    @LearnRefNumber varchar(12),
    @AppIdentifierOutput varchar(10),
    @AppProgCompletedInTheYearOutput bit,
    @HistoricDaysInYearOutput int,
    @HistoricEffectiveTNPStartDateOutput date,
    @HistoricEmpIdEndWithinYearOutput int,
    @HistoricEmpIdStartWithinYearOutput int,
    @HistoricFworkCodeOutput int,
    @HistoricLearnDelProgEarliestACT2DateOutput date,
    @HistoricLearner1618AtStartOutput bit,
    @HistoricPMRAmountOutput decimal(12, 5),
    @HistoricProgrammeStartDateIgnorePathwayOutput date,
    @HistoricProgrammeStartDateMatchPathwayOutput date,
    @HistoricProgTypeOutput int,
    @HistoricPwayCodeOutput int,
    @HistoricSTDCodeOutput int,
    @HistoricTNP1Output decimal(12, 5),
    @HistoricTNP2Output decimal(12, 5),
    @HistoricTNP3Output decimal(12, 5),
    @HistoricTNP4Output decimal(12, 5),
    @HistoricTotal1618UpliftPaymentsInTheYear decimal(12, 5),
    @HistoricTotalProgAimPaymentsInTheYear decimal(12, 5),
    @HistoricULNOutput bigint,
    @HistoricUptoEndDateOutput date,
    @HistoricVirtualTNP3EndofThisYearOutput decimal(12, 5),
    @HistoricVirtualTNP4EndofThisYearOutput decimal(12, 5)
  ) as begin
set
  nocount on
insert into
  Rulebase.AEC_HistoricEarningOutput (
	UKPRN,
    LearnRefNumber,
    AppIdentifierOutput,
    AppProgCompletedInTheYearOutput,
    HistoricDaysInYearOutput,
    HistoricEffectiveTNPStartDateOutput,
    HistoricEmpIdEndWithinYearOutput,
    HistoricEmpIdStartWithinYearOutput,
    HistoricFworkCodeOutput,
    HistoricLearnDelProgEarliestACT2DateOutput,
    HistoricLearner1618AtStartOutput,
    HistoricPMRAmountOutput,
    HistoricProgrammeStartDateIgnorePathwayOutput,
    HistoricProgrammeStartDateMatchPathwayOutput,
    HistoricProgTypeOutput,
    HistoricPwayCodeOutput,
    HistoricSTDCodeOutput,
    HistoricTNP1Output,
    HistoricTNP2Output,
    HistoricTNP3Output,
    HistoricTNP4Output,
    HistoricTotal1618UpliftPaymentsInTheYear,
    HistoricTotalProgAimPaymentsInTheYear,
    HistoricULNOutput,
    HistoricUptoEndDateOutput,
    HistoricVirtualTNP3EndofThisYearOutput,
    HistoricVirtualTNP4EndofThisYearOutput
  )
values
  (
    @UKPRN,
    @LearnRefNumber,
    @AppIdentifierOutput,
    @AppProgCompletedInTheYearOutput,
    @HistoricDaysInYearOutput,
    @HistoricEffectiveTNPStartDateOutput,
    @HistoricEmpIdEndWithinYearOutput,
    @HistoricEmpIdStartWithinYearOutput,
    @HistoricFworkCodeOutput,
    @HistoricLearnDelProgEarliestACT2DateOutput,
    @HistoricLearner1618AtStartOutput,
    @HistoricPMRAmountOutput,
    @HistoricProgrammeStartDateIgnorePathwayOutput,
    @HistoricProgrammeStartDateMatchPathwayOutput,
    @HistoricProgTypeOutput,
    @HistoricPwayCodeOutput,
    @HistoricSTDCodeOutput,
    @HistoricTNP1Output,
    @HistoricTNP2Output,
    @HistoricTNP3Output,
    @HistoricTNP4Output,
    @HistoricTotal1618UpliftPaymentsInTheYear,
    @HistoricTotalProgAimPaymentsInTheYear,
    @HistoricULNOutput,
    @HistoricUptoEndDateOutput,
    @HistoricVirtualTNP3EndofThisYearOutput,
    @HistoricVirtualTNP4EndofThisYearOutput
  )
end
go
  if object_id(
    'Rulebase.AEC_Insert_ApprenticeshipPriceEpisode',
    'p'
  ) is not null begin drop procedure Rulebase.AEC_Insert_ApprenticeshipPriceEpisode
end
go
  create procedure Rulebase.AEC_Insert_ApprenticeshipPriceEpisode (
    @UKPRN int,
    @LearnRefNumber varchar(12),
    @PriceEpisodeIdentifier varchar(25),
    @EpisodeStartDate date = null,
    @EpisodeEffectiveTNPStartDate date = null,
    @PriceEpisode1618FrameworkUpliftRemainingAmount decimal(12, 5) = null,
    @PriceEpisode1618FrameworkUpliftTotPrevEarnings decimal(12, 5) = null,
    @PriceEpisode1618FUBalValue decimal(12, 5) = null,
    @PriceEpisode1618FUMonthInstValue decimal(12, 5) = null,
    @PriceEpisode1618FUTotEarnings decimal(12, 5) = null,
    @PriceEpisodeActualEndDate date = null,
    @PriceEpisodeActualEndDateIncEPA date = null,
    @PriceEpisodeAimSeqNumber bigint = null,
    @PriceEpisodeActualInstalments int = null,
    @PriceEpisodeApplic1618FrameworkUpliftCompElement decimal(12, 5) = null,
    @PriceEpisodeCappedRemainingTNPAmount decimal(12, 5) = null,
    @PriceEpisodeCompExemCode int = null,
    @PriceEpisodeCompleted bit = null,
    @PriceEpisodeCompletionElement decimal(12, 5) = null,
    @PriceEpisodeContractType varchar(50) = null,
    @PriceEpisodeCumulativePMRs decimal(12, 5) = null,
    @PriceEpisodeExpectedTotalMonthlyValue decimal(12, 5) = null,
    @PriceEpisodeFirstAdditionalPaymentThresholdDate date = null,
    @PriceEpisodeFundLineType varchar(100) = null,
    @PriceEpisodeInstalmentValue decimal(12, 5) = null,
    @PriceEpisodeLearnerAdditionalPaymentThresholdDate date = null,
    @PriceEpisodePlannedEndDate date = null,
    @PriceEpisodePlannedInstalments int = null,
    @PriceEpisodePreviousEarnings decimal(12, 5) = null,
    @PriceEpisodePreviousEarningsSameProvider decimal(12, 5) = null,
    @PriceEpisodeRedStartDate date = null,
    @PriceEpisodeRedStatusCode int = null,
    @PriceEpisodeRemainingAmountWithinUpperLimit decimal(12, 5) = null,
    @PriceEpisodeRemainingTNPAmount decimal(12, 5) = null,
    @PriceEpisodeSecondAdditionalPaymentThresholdDate date = null,
    @PriceEpisodeTotalEarnings decimal(12, 5) = null,
    @PriceEpisodeTotalPMRs decimal(12, 5) = null,
    @PriceEpisodeTotalTNPPrice decimal(12, 5) = null,
    @PriceEpisodeUpperBandLimit decimal(12, 5) = null,
    @PriceEpisodeUpperLimitAdjustment decimal(12, 5) = null,
    @TNP1 decimal(12, 5) = null,
    @TNP2 decimal(12, 5) = null,
    @TNP3 decimal(12, 5) = null,
    @TNP4 decimal(12, 5) = null,
    -- periodised
    @PriceEpisodeApplic1618FrameworkUpliftBalancing decimal(12, 5) = null,
    @PriceEpisodeApplic1618FrameworkUpliftCompletionPayment decimal(12, 5) = null,
    @PriceEpisodeApplic1618FrameworkUpliftOnProgPayment decimal(12, 5) = null,
    @PriceEpisodeBalancePayment decimal(12, 5) = null,
    @PriceEpisodeBalanceValue decimal(12, 5) = null,
    @PriceEpisodeCompletionPayment decimal(12, 5) = null,
    @PriceEpisodeFirstDisadvantagePayment decimal(12, 5) = null,
    @PriceEpisodeFirstEmp1618Pay decimal(12, 5) = null,
    @PriceEpisodeFirstProv1618Pay decimal(12, 5) = null,
    @PriceEpisodeInstalmentsThisPeriod int = null,
    @PriceEpisodeLearnerAdditionalPayment decimal(12, 5) = null,
    @PriceEpisodeLevyNonPayInd int = null,
    @PriceEpisodeLSFCash decimal(12, 5) = null,
    @PriceEpisodeOnProgPayment decimal(12, 5) = null,
    @PriceEpisodeProgFundIndMaxEmpCont decimal(12, 5) = null,
    @PriceEpisodeProgFundIndMinCoInvest decimal(12, 5) = null,
    @PriceEpisodeSecondDisadvantagePayment decimal(12, 5) = null,
    @PriceEpisodeSecondEmp1618Pay decimal(12, 5) = null,
    @PriceEpisodeSecondProv1618Pay decimal(12, 5) = null,
    @PriceEpisodeSFAContribPct decimal(12, 5) = null,
    @PriceEpisodeESFAContribPct decimal(12, 5) = null,
    @PriceEpisodeTotProgFunding decimal(12, 5) = null
  ) as begin
set
  nocount on
insert into
  Rulebase.AEC_ApprenticeshipPriceEpisode (
    UKPRN,
    LearnRefNumber,
    PriceEpisodeIdentifier,
    EpisodeStartDate,
    EpisodeEffectiveTNPStartDate,
    PriceEpisode1618FrameworkUpliftRemainingAmount,
    PriceEpisode1618FrameworkUpliftTotPrevEarnings,
    PriceEpisode1618FUBalValue,
    PriceEpisode1618FUMonthInstValue,
    PriceEpisode1618FUTotEarnings,
    PriceEpisodeActualEndDate,
    PriceEpisodeActualEndDateIncEPA,
    PriceEpisodeAimSeqNumber,
    PriceEpisodeActualInstalments,
    PriceEpisodeApplic1618FrameworkUpliftCompElement,
    PriceEpisodeCappedRemainingTNPAmount,
    PriceEpisodeCompExemCode,
    PriceEpisodeCompleted,
    PriceEpisodeCompletionElement,
    PriceEpisodeContractType,
    PriceEpisodeCumulativePMRs,
    PriceEpisodeExpectedTotalMonthlyValue,
    PriceEpisodeFirstAdditionalPaymentThresholdDate,
    PriceEpisodeFundLineType,
    PriceEpisodeInstalmentValue,
    PriceEpisodeLearnerAdditionalPaymentThresholdDate,
    PriceEpisodePlannedEndDate,
    PriceEpisodePlannedInstalments,
    PriceEpisodePreviousEarnings,
    PriceEpisodePreviousEarningsSameProvider,
    PriceEpisodeRedStartDate,
    PriceEpisodeRedStatusCode,
    PriceEpisodeRemainingAmountWithinUpperLimit,
    PriceEpisodeRemainingTNPAmount,
    PriceEpisodeSecondAdditionalPaymentThresholdDate,
    PriceEpisodeTotalEarnings,
    PriceEpisodeTotalPMRs,
    PriceEpisodeTotalTNPPrice,
    PriceEpisodeUpperBandLimit,
    PriceEpisodeUpperLimitAdjustment,
    TNP1,
    TNP2,
    TNP3,
    TNP4
  )
values
  (
    @UKPRN,
    @LearnRefNumber,
    @PriceEpisodeIdentifier,
    @EpisodeStartDate,
    @EpisodeEffectiveTNPStartDate,
    @PriceEpisode1618FrameworkUpliftRemainingAmount,
    @PriceEpisode1618FrameworkUpliftTotPrevEarnings,
    @PriceEpisode1618FUBalValue,
    @PriceEpisode1618FUMonthInstValue,
    @PriceEpisode1618FUTotEarnings,
    @PriceEpisodeActualEndDate,
    @PriceEpisodeActualEndDateIncEPA,
    @PriceEpisodeAimSeqNumber,
    @PriceEpisodeActualInstalments,
    @PriceEpisodeApplic1618FrameworkUpliftCompElement,
    @PriceEpisodeCappedRemainingTNPAmount,
    @PriceEpisodeCompExemCode,
    @PriceEpisodeCompleted,
    @PriceEpisodeCompletionElement,
    @PriceEpisodeContractType,
    @PriceEpisodeCumulativePMRs,
    @PriceEpisodeExpectedTotalMonthlyValue,
    @PriceEpisodeFirstAdditionalPaymentThresholdDate,
    @PriceEpisodeFundLineType,
    @PriceEpisodeInstalmentValue,
    @PriceEpisodeLearnerAdditionalPaymentThresholdDate,
    @PriceEpisodePlannedEndDate,
    @PriceEpisodePlannedInstalments,
    @PriceEpisodePreviousEarnings,
    @PriceEpisodePreviousEarningsSameProvider,
    @PriceEpisodeRedStartDate,
    @PriceEpisodeRedStatusCode,
    @PriceEpisodeRemainingAmountWithinUpperLimit,
    @PriceEpisodeRemainingTNPAmount,
    @PriceEpisodeSecondAdditionalPaymentThresholdDate,
    @PriceEpisodeTotalEarnings,
    @PriceEpisodeTotalPMRs,
    @PriceEpisodeTotalTNPPrice,
    @PriceEpisodeUpperBandLimit,
    @PriceEpisodeUpperLimitAdjustment,
    @TNP1,
    @TNP2,
    @TNP3,
    @TNP4
  )
end
go
  if object_id(
    'Rulebase.AEC_Insert_ApprenticeshipPriceEpisode_PeriodisedValues',
    'p'
  ) is not null begin drop procedure Rulebase.AEC_Insert_ApprenticeshipPriceEpisode_PeriodisedValues
end
go
  create procedure Rulebase.AEC_Insert_ApprenticeshipPriceEpisode_PeriodisedValues (
    @LearnRefNumber varchar(12),
    @PriceEpisodeIdentifier varchar(25),
    @AttributeName varchar(100),
    @Period_1 decimal(15, 5) = null,
    @Period_2 decimal(15, 5) = null,
    @Period_3 decimal(15, 5) = null,
    @Period_4 decimal(15, 5) = null,
    @Period_5 decimal(15, 5) = null,
    @Period_6 decimal(15, 5) = null,
    @Period_7 decimal(15, 5) = null,
    @Period_8 decimal(15, 5) = null,
    @Period_9 decimal(15, 5) = null,
    @Period_10 decimal(15, 5) = null,
    @Period_11 decimal(15, 5) = null,
    @Period_12 decimal(15, 5) = null
  ) as begin
set
  nocount on
insert into
  Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues (
    UKPRN,
    LearnRefNumber,
    PriceEpisodeIdentifier,
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
    @PriceEpisodeIdentifier,
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
    'Rulebase.AEC_PivotTemporals_ApprenticeshipPriceEpisode',
    'p'
  ) is not null begin drop procedure Rulebase.AEC_PivotTemporals_ApprenticeshipPriceEpisode
end
go
  create procedure Rulebase.AEC_PivotTemporals_ApprenticeshipPriceEpisode as begin -- why is there a truncate here???
  -- truncate table Rulebase.AEC_ApprenticeshipPriceEpisode_Period
insert into
  Rulebase.AEC_ApprenticeshipPriceEpisode_Period (
    UKPRN,
    LearnRefNumber,
    PriceEpisodeIdentifier,
    [Period],
    PriceEpisodeApplic1618FrameworkUpliftBalancing,
    PriceEpisodeApplic1618FrameworkUpliftCompletionPayment,
    PriceEpisodeApplic1618FrameworkUpliftOnProgPayment,
    PriceEpisodeBalancePayment,
    PriceEpisodeBalanceValue,
    PriceEpisodeCompletionPayment,
    PriceEpisodeFirstDisadvantagePayment,
    PriceEpisodeFirstEmp1618Pay,
    PriceEpisodeFirstProv1618Pay,
    PriceEpisodeInstalmentsThisPeriod,
    PriceEpisodeLearnerAdditionalPayment,
    PriceEpisodeLevyNonPayInd,
    PriceEpisodeLSFCash,
    PriceEpisodeOnProgPayment,
    PriceEpisodeProgFundIndMaxEmpCont,
    PriceEpisodeProgFundIndMinCoInvest,
    PriceEpisodeSecondDisadvantagePayment,
    PriceEpisodeSecondEmp1618Pay,
    PriceEpisodeSecondProv1618Pay,
    PriceEpisodeSFAContribPct,
    PriceEpisodeESFAContribPct,
    PriceEpisodeTotProgFunding
  )
select
  UnrequiredAlias.UKPRN,
  LearnRefNumber,
  PriceEpisodeIdentifier,
  [Period],
  max(
    case
      AttributeName
      when 'PriceEpisodeApplic1618FrameworkUpliftBalancing' then Value
      else null
    end
  ) as PriceEpisodeApplic1618FrameworkUpliftBalancing,
  max(
    case
      AttributeName
      when 'PriceEpisodeApplic1618FrameworkUpliftCompletionPayment' then Value
      else null
    end
  ) as PriceEpisodeApplic1618FrameworkUpliftCompletionPayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeApplic1618FrameworkUpliftOnProgPayment' then Value
      else null
    end
  ) as PriceEpisodeApplic1618FrameworkUpliftOnProgPayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeBalancePayment' then Value
      else null
    end
  ) as PriceEpisodeBalancePayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeBalanceValue' then Value
      else null
    end
  ) as PriceEpisodeBalanceValue,
  max(
    case
      AttributeName
      when 'PriceEpisodeCompletionPayment' then Value
      else null
    end
  ) as PriceEpisodeCompletionPayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeFirstDisadvantagePayment' then Value
      else null
    end
  ) as PriceEpisodeFirstDisadvantagePayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeFirstEmp1618Pay' then Value
      else null
    end
  ) as PriceEpisodeFirstEmp1618Pay,
  max(
    case
      AttributeName
      when 'PriceEpisodeFirstProv1618Pay' then Value
      else null
    end
  ) as PriceEpisodeFirstProv1618Pay,
  max(
    case
      AttributeName
      when 'PriceEpisodeInstalmentsThisPeriod' then Value
      else null
    end
  ) as PriceEpisodeInstalmentsThisPeriod,
  max(
    case
      AttributeName
      when 'PriceEpisodeLearnerAdditionalPayment' then Value
      else null
    end
  ) as PriceEpisodeLearnerAdditionalPayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeLevyNonPayInd' then Value
      else null
    end
  ) as PriceEpisodeLevyNonPayInd,
  max(
    case
      AttributeName
      when 'PriceEpisodeLSFCash' then Value
      else null
    end
  ) as PriceEpisodeLSFCash,
  max(
    case
      AttributeName
      when 'PriceEpisodeOnProgPayment' then Value
      else null
    end
  ) as PriceEpisodeOnProgPayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeProgFundIndMaxEmpCont' then Value
      else null
    end
  ) as PriceEpisodeProgFundIndMaxEmpCont,
  max(
    case
      AttributeName
      when 'PriceEpisodeProgFundIndMinCoInvest' then Value
      else null
    end
  ) as PriceEpisodeProgFundIndMinCoInvest,
  max(
    case
      AttributeName
      when 'PriceEpisodeSecondDisadvantagePayment' then Value
      else null
    end
  ) as PriceEpisodeSecondDisadvantagePayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeSecondEmp1618Pay' then Value
      else null
    end
  ) as PriceEpisodeSecondEmp1618Pay,
  max(
    case
      AttributeName
      when 'PriceEpisodeSecondProv1618Pay' then Value
      else null
    end
  ) as PriceEpisodeSecondProv1618Pay,
  max(
    case
      AttributeName
      when 'PriceEpisodeSFAContribPct' then Value
      else null
    end
  ) as PriceEpisodeSFAContribPct,
  max(
    case
      AttributeName
      when 'PriceEpisodeESFAContribPct' then Value
      else null
    end
  ) as PriceEpisodeESFAContribPct,
  max(
    case
      AttributeName
      when 'PriceEpisodeTotProgFunding' then Value
      else null
    end
  ) as PriceEpisodeTotProgFunding
from
  (
    select
    UKPRN,
      LearnRefNumber,
      PriceEpisodeIdentifier,
      AttributeName,
      cast(substring([PeriodValue].[Period], 8, 2) as int) as [Period],
      [PeriodValue].[Value]
    from
      Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues unpivot (
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
  join dbo.UKPRNForProcedures ufp
	on ufp.UKPRN = UnrequiredAlias.UKPRN
group by
UnrequiredAlias.UKPRN,
  LearnRefNumber,
  PriceEpisodeIdentifier,
  [Period]
end
go