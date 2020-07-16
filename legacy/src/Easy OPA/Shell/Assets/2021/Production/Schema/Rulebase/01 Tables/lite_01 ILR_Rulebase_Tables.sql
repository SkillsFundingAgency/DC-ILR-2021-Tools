--Rulebase schema
if not exists(
  select
    schema_id
  from
    sys.schemas
  where
    name = 'Rulebase'
) begin exec('create schema Rulebase')
end
go
  if object_id('Rulebase.FM25_FM35_Cases', 'u') is not null begin drop table Rulebase.FM25_FM35_Cases
end
go
  if object_id('Rulebase.FM25_FM35_global', 'u') is not null begin drop table Rulebase.FM25_FM35_global
end
go
  if object_id('Rulebase.FM25_FM35_Learner_Period', 'u') is not null begin drop table Rulebase.FM25_FM35_Learner_Period
end
go
  if object_id('Rulebase.FM25_FM35_Learner_PeriodisedValues','u') is not null begin drop table Rulebase.FM25_FM35_Learner_PeriodisedValues
end
go
if object_id('Rulebase.FM25_global', 'u') is not null begin drop table Rulebase.FM25_global
end
go
  if object_id('Rulebase.FM25_Cases', 'u') is not null begin drop table Rulebase.FM25_Cases
end
go
  if object_id('Rulebase.FM25_Learner', 'u') is not null begin drop table Rulebase.FM25_Learner
end
go
  if object_id('Rulebase.ALB_Cases', 'u') is not null begin drop table Rulebase.ALB_Cases
end
go
  if object_id('Rulebase.ALB_global', 'u') is not null begin drop table Rulebase.ALB_global
end
go
  if object_id('Rulebase.ALB_Learner_Period', 'u') is not null begin drop table Rulebase.ALB_Learner_Period
end
go
  if object_id('Rulebase.ALB_Learner_PeriodisedValues', 'u') is not null begin drop table Rulebase.ALB_Learner_PeriodisedValues
end
go
  if object_id('Rulebase.ALB_LearningDelivery', 'u') is not null begin drop table Rulebase.ALB_LearningDelivery
end
go
  if object_id('Rulebase.ALB_LearningDelivery_Period', 'u') is not null begin drop table Rulebase.ALB_LearningDelivery_Period
end
go
  if object_id('Rulebase.ALB_LearningDelivery_PeriodisedValues','u') is not null begin drop table Rulebase.ALB_LearningDelivery_PeriodisedValues
end
go
  if object_id('Rulebase.FM35_Cases', 'u') is not null begin drop table Rulebase.FM35_Cases
end
go
  if object_id('Rulebase.FM35_global', 'u') is not null begin drop table Rulebase.FM35_global
end
go
if object_id('Rulebase.FM25_FM35_global', 'u') is not null begin drop table Rulebase.FM35_global
end
go
  if object_id('Rulebase.FM35_LearningDelivery', 'u') is not null begin drop table Rulebase.FM35_LearningDelivery
end
go
  if object_id('Rulebase.FM35_LearningDelivery_Period', 'u') is not null begin drop table Rulebase.FM35_LearningDelivery_Period
end
go
  if object_id('Rulebase.FM35_LearningDelivery_PeriodisedValues','u') is not null begin drop table Rulebase.FM35_LearningDelivery_PeriodisedValues
end
go
  if object_id('Rulebase.TBL_Cases', 'u') is not null begin drop table Rulebase.TBL_Cases
end
go
  if object_id('Rulebase.TBL_global', 'u') is not null begin drop table Rulebase.TBL_global
end
go
  if object_id('Rulebase.TBL_LearningDelivery', 'u') is not null begin drop table Rulebase.TBL_LearningDelivery
end
go
  if object_id('Rulebase.TBL_LearningDelivery_Period', 'u') is not null begin drop table Rulebase.TBL_LearningDelivery_Period
end
go
  if object_id('Rulebase.TBL_LearningDelivery_PeriodisedValues','u') is not null begin drop table Rulebase.TBL_LearningDelivery_PeriodisedValues
end
go
  if object_id('Rulebase.AEC_Cases', 'u') is not null begin drop table Rulebase.AEC_Cases
end
go
  if object_id('Rulebase.AEC_global', 'u') is not null begin drop table Rulebase.AEC_global
end
go
  if object_id('Rulebase.AEC_LearningDelivery', 'u') is not null begin drop table Rulebase.AEC_LearningDelivery
end
go
  if object_id('Rulebase.AEC_LearningDelivery_Period', 'u') is not null begin drop table Rulebase.AEC_LearningDelivery_Period
end
go
  if object_id('Rulebase.AEC_LearningDelivery_PeriodisedValues','u') is not null begin drop table Rulebase.AEC_LearningDelivery_PeriodisedValues
end
go
  if object_id('Rulebase.AEC_LearningDelivery_PeriodisedTextValues','u') is not null begin drop table Rulebase.AEC_LearningDelivery_PeriodisedTextValues
end
go
  if object_id('Rulebase.AEC_HistoricEarningOutput', 'u') is not null begin drop table Rulebase.AEC_HistoricEarningOutput
end
go
  if object_id('Rulebase.AEC_ApprenticeshipPriceEpisode', 'u') is not null begin drop table Rulebase.AEC_ApprenticeshipPriceEpisode
end
go
  if object_id('Rulebase.AEC_ApprenticeshipPriceEpisode_Period','u') is not null begin drop table Rulebase.AEC_ApprenticeshipPriceEpisode_Period
end
go
  if object_id('Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues','u') is not null begin drop table Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues
end
go
 if object_id('Rulebase.ESF_global','u') is not null begin drop table Rulebase.ESF_global
end
go
 if object_id('Rulebase.ESF_LearningDelivery','u') is not null begin drop table Rulebase.ESF_LearningDelivery
end
go
 if object_id('Rulebase.ESF_LearningDeliveryDeliverable','u') is not null begin drop table Rulebase.ESF_LearningDeliveryDeliverable
end
go
 if object_id('Rulebase.ESF_LearningDeliveryDeliverable_Period','u') is not null begin drop table Rulebase.ESF_LearningDeliveryDeliverable_Period
end
go
 if object_id('Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues','u') is not null begin drop table Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues
end
go
 if object_id('Rulebase.ESF_DPOutcome','u') is not null begin drop table Rulebase.ESF_DPOutcome
end
go


-- Rulebase


create table Rulebase.AEC_ApprenticeshipPriceEpisode (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
    PriceEpisodeIdentifier varchar(25) not null,
	EpisodeStartDate date,
	EpisodeEffectiveTNPStartDate date,
	PriceEpisode1618FrameworkUpliftRemainingAmount decimal(12,5),
	PriceEpisode1618FrameworkUpliftTotPrevEarnings decimal(12,5),
	PriceEpisode1618FUBalValue decimal(12,5),
	PriceEpisode1618FUMonthInstValue decimal(12,5),
	PriceEpisode1618FUTotEarnings decimal(12,5),
	PriceEpisodeActualEndDate date,
	PriceEpisodeActualEndDateIncEPA date,
	PriceEpisodeAimSeqNumber bigint,
	PriceEpisodeActualInstalments int,
	PriceEpisodeApplic1618FrameworkUpliftCompElement decimal(12,5),
	PriceEpisodeCappedRemainingTNPAmount decimal(12,5),
	PriceEpisodeCompExemCode int,
	PriceEpisodeCompleted bit,
	PriceEpisodeCompletionElement decimal(12,5),
	PriceEpisodeContractType varchar(50),
	PriceEpisodeCumulativePMRs decimal(12,5),
	PriceEpisodeExpectedTotalMonthlyValue decimal(12,5),
	PriceEpisodeFirstAdditionalPaymentThresholdDate date,
	PriceEpisodeFundLineType varchar(100),
	PriceEpisodeInstalmentValue decimal(12,5),
	PriceEpisodeLearnerAdditionalPaymentThresholdDate date,
	PriceEpisodePlannedEndDate date,
	PriceEpisodePlannedInstalments int,
	PriceEpisodePreviousEarnings decimal(12,5),
	PriceEpisodePreviousEarningsSameProvider decimal(12,5),
	PriceEpisodeRedStartDate date,
	PriceEpisodeRedStatusCode int,
	PriceEpisodeRemainingAmountWithinUpperLimit decimal(12,5),
	PriceEpisodeRemainingTNPAmount decimal(12,5),
	PriceEpisodeSecondAdditionalPaymentThresholdDate date,
	PriceEpisodeTotalEarnings decimal(12,5),
	PriceEpisodeTotalPMRs decimal(12,5),
	PriceEpisodeTotalTNPPrice decimal(12,5),
	PriceEpisodeUpperBandLimit decimal(12,5),
	PriceEpisodeUpperLimitAdjustment decimal(12,5),
	TNP1 decimal(12,5),
	TNP2 decimal(12,5),
	TNP3 decimal(12,5),
	TNP4 decimal(12,5),
	primary key (
		UKPRN asc,
		LearnRefNumber asc,
		PriceEpisodeIdentifier asc
	)
)
go

create table Rulebase.AEC_ApprenticeshipPriceEpisode_Period (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	PriceEpisodeIdentifier varchar(25) not null,
	[Period] int not null,
	PriceEpisodeApplic1618FrameworkUpliftBalancing decimal(12,5),
	PriceEpisodeApplic1618FrameworkUpliftCompletionPayment decimal(12,5),
	PriceEpisodeApplic1618FrameworkUpliftOnProgPayment decimal(12,5),
	PriceEpisodeBalancePayment decimal(12,5),
	PriceEpisodeBalanceValue decimal(12,5),
	PriceEpisodeCompletionPayment decimal(12,5),
	PriceEpisodeFirstDisadvantagePayment decimal(12,5),
	PriceEpisodeFirstEmp1618Pay decimal(12,5),
	PriceEpisodeFirstProv1618Pay decimal(12,5),
	PriceEpisodeInstalmentsThisPeriod int,
	PriceEpisodeLearnerAdditionalPayment decimal(12,5),
	PriceEpisodeLevyNonPayInd int,
	PriceEpisodeLSFCash decimal(12,5),
	PriceEpisodeOnProgPayment decimal(12,5),
	PriceEpisodeProgFundIndMaxEmpCont decimal(12,5),
	PriceEpisodeProgFundIndMinCoInvest decimal(12,5),
	PriceEpisodeSecondDisadvantagePayment decimal(12,5),
	PriceEpisodeSecondEmp1618Pay decimal(12,5),
	PriceEpisodeSecondProv1618Pay decimal(12,5),
	PriceEpisodeSFAContribPct decimal(12,5),
	PriceEpisodeESFAContribPct decimal(12,5),
	PriceEpisodeTotProgFunding decimal(12,5),
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		PriceEpisodeIdentifier asc,
		[Period] asc
	)
)
go

create table Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	PriceEpisodeIdentifier varchar(25) not null,
	AttributeName varchar(100) not null,
	Period_1 decimal(15, 5),
	Period_2 decimal(15, 5),
	Period_3 decimal(15, 5),
	Period_4 decimal(15, 5),
	Period_5 decimal(15, 5),
	Period_6 decimal(15, 5),
	Period_7 decimal(15, 5),
	Period_8 decimal(15, 5),
	Period_9 decimal(15, 5),
	Period_10 decimal(15, 5),
	Period_11 decimal(15, 5),
	Period_12 decimal(15, 5),
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		PriceEpisodeIdentifier asc,
		AttributeName asc
	)
)
go

 create table Rulebase.AEC_Cases (
    UKPRN int,
    LearnRefNumber varchar(12),
    CaseData xml not null
  )

create table Rulebase.AEC_global (
	UKPRN int not null,
	LARSVersion varchar(100) not null,
	RulebaseVersion varchar(10) not null,
	[Year] varchar(4) not null
)
go

create table Rulebase.AEC_HistoricEarningOutput (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AppIdentifierOutput varchar(10) not null,
	AppProgCompletedInTheYearOutput bit,
	HistoricDaysInYearOutput int,
	HistoricEffectiveTNPStartDateOutput date,
	HistoricEmpIdEndWithinYearOutput int,
	HistoricEmpIdStartWithinYearOutput int,
	HistoricFworkCodeOutput int,
	HistoricLearnDelProgEarliestACT2DateOutput date,
	HistoricLearner1618AtStartOutput bit,
	HistoricPMRAmountOutput decimal(12,5),
	HistoricProgrammeStartDateIgnorePathwayOutput date,
	HistoricProgrammeStartDateMatchPathwayOutput date,
	HistoricProgTypeOutput int,
	HistoricPwayCodeOutput int,
	HistoricSTDCodeOutput int,
	HistoricTNP1Output decimal(12,5),
	HistoricTNP2Output decimal(12,5),
	HistoricTNP3Output decimal(12,5),
	HistoricTNP4Output decimal(12,5),
	HistoricTotal1618UpliftPaymentsInTheYear decimal(12,5),
	HistoricTotalProgAimPaymentsInTheYear decimal(12,5),
	HistoricULNOutput bigint,
	HistoricUptoEndDateOutput date,
	HistoricVirtualTNP3EndofThisYearOutput decimal(12,5),
	HistoricVirtualTNP4EndofThisYearOutput decimal(12,5)
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AppIdentifierOutput asc
	)
)
go

create table Rulebase.AEC_LearningDelivery (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	LearnAimRef varchar(8),
	ActualDaysIL int,
	ActualNumInstalm int,
	AdjStartDate date,
	AgeAtProgStart int,
	AppAdjLearnStartDate date,
	AppAdjLearnStartDateMatchPathway date,
	ApplicCompDate date,
	CombinedAdjProp decimal(12,5),
	Completed bit,
	FirstIncentiveThresholdDate date,
	FundStart bit,
	LDApplic1618FrameworkUpliftTotalActEarnings decimal(12,5),
	LearnDel1618AtStart bit,
	LearnDelAccDaysILCareLeavers int,
	LearnDelAppAccDaysIL int,
	LearnDelApplicCareLeaverIncentive decimal(12,5),
	LearnDelApplicDisadvAmount decimal(12,5),
	LearnDelApplicEmp1618Incentive decimal(12,5),
	LearnDelApplicEmpDate date,
	LearnDelApplicProv1618FrameworkUplift decimal(12,5),
	LearnDelApplicProv1618Incentive decimal(12,5),
	LearnDelAppPrevAccDaysIL int,
	LearnDelDaysIL int,
	LearnDelDisadAmount decimal(12,5),
	LearnDelEligDisadvPayment bit,
	LearnDelEmpIdFirstAdditionalPaymentThreshold int,
	LearnDelEmpIdSecondAdditionalPaymentThreshold int,
	LearnDelHistDaysCareLeavers int,
	LearnDelHistDaysThisApp int,
	LearnDelHistProgEarnings decimal(12,5),
	LearnDelInitialFundLineType varchar(100),
	LearnDelLearnerAddPayThresholdDate date,
	LearnDelMathEng bit,
	LearnDelNonLevyProcured bit,
	LearnDelPrevAccDaysILCareLeavers int,
	LearnDelProgEarliestACT2Date date,
	LearnDelRedCode int,
	LearnDelRedStartDate date,
	MathEngAimValue decimal(12,5),
	OutstandNumOnProgInstalm int,
	PlannedNumOnProgInstalm int,
	PlannedTotalDaysIL int,
	SecondIncentiveThresholdDate date,
	ThresholdDays int,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

create table Rulebase.AEC_LearningDelivery_Period (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	[Period] int not null,
	DisadvFirstPayment decimal(10, 5) null,
	DisadvSecondPayment decimal(10, 5) null,
	FundLineType varchar(100) null,
	InstPerPeriod int null,
	LDApplic1618FrameworkUpliftBalancingPayment decimal(10, 5) null,
	LDApplic1618FrameworkUpliftCompletionPayment decimal(10, 5) null,
	LDApplic1618FrameworkUpliftOnProgPayment decimal(10, 5) null,
	LearnDelContType varchar(50) null,
	LearnDelFirstEmp1618Pay decimal(10, 5) null,
	LearnDelFirstProv1618Pay decimal(10, 5) null,
	LearnDelLevyNonPayInd int null,
	LearnDelSecondEmp1618Pay decimal(10, 5) null,
	LearnDelSecondProv1618Pay decimal(10, 5) null,
	LearnDelSEMContWaiver bit null,
	LearnDelSFAContribPct decimal(10, 5) null,
	LearnDelESFAContribPct decimal(10, 5) null,
	LearnSuppFund bit null,
	LearnSuppFundCash decimal(10, 5) null,
	MathEngBalPayment decimal(10, 5) null,
	MathEngOnProgPayment decimal(10, 5) null,
	ProgrammeAimBalPayment decimal(10, 5) null,
	ProgrammeAimCompletionPayment decimal(10, 5) null,
	ProgrammeAimOnProgPayment decimal(10, 5) null,
	ProgrammeAimProgFundIndMaxEmpCont decimal(12, 5) null,
	ProgrammeAimProgFundIndMinCoInvest decimal(12, 5) null,
	ProgrammeAimTotProgFund decimal(12, 5) null,
	LearnDelLearnAddPayment decimal(12,5),
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		[Period] asc
	)
)
go

create table Rulebase.AEC_LearningDelivery_PeriodisedTextValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AttributeName varchar(100) not null,
	Period_1 varchar(255) null,
	Period_2 varchar(255) null,
	Period_3 varchar(255) null,
	Period_4 varchar(255) null,
	Period_5 varchar(255) null,
	Period_6 varchar(255) null,
	Period_7 varchar(255) null,
	Period_8 varchar(255) null,
	Period_9 varchar(255) null,
	Period_10 varchar(255) null,
	Period_11 varchar(255) null,
	Period_12 varchar(255) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		AttributeName asc
	)
)
go

create table Rulebase.AEC_LearningDelivery_PeriodisedValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AttributeName varchar(100) not null,
	Period_1 decimal(15, 5) null,
	Period_2 decimal(15, 5) null,
	Period_3 decimal(15, 5) null,
	Period_4 decimal(15, 5) null,
	Period_5 decimal(15, 5) null,
	Period_6 decimal(15, 5) null,
	Period_7 decimal(15, 5) null,
	Period_8 decimal(15, 5) null,
	Period_9 decimal(15, 5) null,
	Period_10 decimal(15, 5) null,
	Period_11 decimal(15, 5) null,
	Period_12 decimal(15, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		AttributeName asc
	)
)
go

create table Rulebase.ALB_Cases (
    UKPRN int,
    LearnRefNumber varchar(12),
    CaseData xml not null
	primary key clustered (
	UKPRN asc,
	LearnRefNumber asc
	)
  )
go

create table Rulebase.ALB_global (
	UKPRN int not null,
	LARSVersion varchar(100) null,
	PostcodeAreaCostVersion varchar(20) null,
	RulebaseVersion varchar(10) null
)
go

create table Rulebase.ALB_Learner_Period (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	[Period] int not null,
	ALBSeqNum int null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		[Period] asc
	)
)
go

create table Rulebase.ALB_Learner_PeriodisedValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AttributeName varchar(100) not null,
	Period_1 decimal(15, 5) null,
	Period_2 decimal(15, 5) null,
	Period_3 decimal(15, 5) null,
	Period_4 decimal(15, 5) null,
	Period_5 decimal(15, 5) null,
	Period_6 decimal(15, 5) null,
	Period_7 decimal(15, 5) null,
	Period_8 decimal(15, 5) null,
	Period_9 decimal(15, 5) null,
	Period_10 decimal(15, 5) null,
	Period_11 decimal(15, 5) null,
	Period_12 decimal(15, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AttributeName asc
	)
)
go

create table Rulebase.ALB_LearningDelivery (
	UKPRN bigint not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AreaCostFactAdj decimal(10, 5) null,
	WeightedRate decimal(12, 5) null,
	PlannedNumOnProgInstalm int null,
	FundStart bit null,
	Achieved bit null,
	ActualNumInstalm int null,
	OutstndNumOnProgInstalm int null,
	AreaCostInstalment decimal(12, 5) null,
	AdvLoan bit null,
	LoanBursAreaUplift bit null,
	LoanBursSupp bit null,
	FundLine varchar(50) null,
	LiabilityDate date null,
	ApplicProgWeightFact varchar(1) null,
	ApplicFactDate date null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

create table Rulebase.ALB_LearningDelivery_Period (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	[Period] int not null,
	ALBCode int null,
	ALBSupportPayment decimal(10, 5) null,
	AreaUpliftBalPayment decimal(10, 5) null,
	AreaUpliftOnProgPayment decimal(10, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		[Period] asc
	)
)
go

create table Rulebase.ALB_LearningDelivery_PeriodisedValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AttributeName varchar(100) not null,
	Period_1 decimal(15, 5) null,
	Period_2 decimal(15, 5) null,
	Period_3 decimal(15, 5) null,
	Period_4 decimal(15, 5) null,
	Period_5 decimal(15, 5) null,
	Period_6 decimal(15, 5) null,
	Period_7 decimal(15, 5) null,
	Period_8 decimal(15, 5) null,
	Period_9 decimal(15, 5) null,
	Period_10 decimal(15, 5) null,
	Period_11 decimal(15, 5) null,
	Period_12 decimal(15, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		AttributeName asc
	)
)
go

create table Rulebase.FM25_Cases (
    UKPRN int,
    LearnRefNumber varchar(12),
    CaseData xml not null,
    primary key clustered (UKPRN asc, LearnRefNumber asc)
  )
go

create table Rulebase.FM25_global (
	UKPRN int not null,
	LARSVersion varchar(50) null,
	OrgVersion varchar(50) null,
	PostcodeDisadvantageVersion varchar(50) null,
	RulebaseVersion varchar(10) null
)
go

create table Rulebase.FM25_Learner (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AcadMonthPayment int null,
	AcadProg bit null,
	ActualDaysILCurrYear int null,
	AreaCostFact1618Hist decimal(10, 5) null,
	Block1DisadvUpliftNew decimal(10, 5) null,
	Block2DisadvElementsNew decimal(10, 5) null,
	ConditionOfFundingEnglish varchar(100) null,
	ConditionOfFundingMaths varchar(100) null,
	CoreAimSeqNumber int null,
	FullTimeEquiv decimal(10, 5) null,
	FundLine varchar(100) null,
	LearnerActEndDate date null,
	LearnerPlanEndDate date null,
	LearnerStartDate date null,
	NatRate decimal(10, 5) null,
	OnProgPayment decimal(10, 5) null,
	PlannedDaysILCurrYear int null,
	ProgWeightHist decimal(10, 5) null,
	ProgWeightNew decimal(10, 5) null,
	PrvDisadvPropnHist decimal(10, 5) null,
	PrvHistLrgProgPropn decimal(10, 5) null,
	PrvRetentFactHist decimal(10, 5) null,
	RateBand varchar(50) null,
	RetentNew decimal(10, 5) null,
	StartFund bit null,
	ThresholdDays int null,
	TLevelStudent bit,
    PrvHistL3ProgMathEngProp decimal(10, 5),
	L3MathsEnglish1Year decimal(10,5) null,
	L3MathsEnglish2Year decimal(10,5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc
	)
)
go

 create table Rulebase.FM25_FM35_Cases (
    UKPRN int,
    LearnRefNumber varchar(12),
    CaseData xml not null
  )
go

create table Rulebase.FM25_FM35_global (
	UKPRN int not null,
	RulebaseVersion varchar(10) null
)
go

create table Rulebase.FM25_FM35_Learner_Period (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	[Period] int not null,
	LnrOnProgPay decimal(10, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		[Period] asc
	)
)
go

create table Rulebase.FM25_FM35_Learner_PeriodisedValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AttributeName varchar(100) not null,
	Period_1 decimal(15, 5) null,
	Period_2 decimal(15, 5) null,
	Period_3 decimal(15, 5) null,
	Period_4 decimal(15, 5) null,
	Period_5 decimal(15, 5) null,
	Period_6 decimal(15, 5) null,
	Period_7 decimal(15, 5) null,
	Period_8 decimal(15, 5) null,
	Period_9 decimal(15, 5) null,
	Period_10 decimal(15, 5) null,
	Period_11 decimal(15, 5) null,
	Period_12 decimal(15, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AttributeName asc
	)
)
go

create table Rulebase.ESF_global (
	UKPRN int,
	RulebaseVersion varchar(10),
)
go

create table Rulebase.ESF_LearningDelivery (
	LearnRefNumber varchar(12),
	UKPRN int not null,
	AimSeqNumber int,
	Achieved bit,
	AddProgCostElig bit,
	AdjustedAreaCostFactor decimal(9,5),
	AdjustedPremiumFactor decimal(9,5),
	AdjustedStartDate date,
	AimClassification varchar(50),
	AimValue decimal(10,5),
	ApplicWeightFundRate decimal(10,5),
	EligibleProgressionOutcomeCode bigint,
	EligibleProgressionOutcomeType varchar(4),
	EligibleProgressionOutomeStartDate date,
	FundStart bit,
	LARSWeightedRate decimal(10,5),
	LatestPossibleStartDate date,
	LDESFEngagementStartDate date,
	PotentiallyEligibleForProgression bit,
	ProgressionEndDate date,
	[Restart] bit,
	WeightedRateFromESOL decimal(10,5),
	LearnDelLearnerEmpAtStart bit
	primary key clustered (
		LearnRefNumber asc,
		UKPRN asc,
		AimSeqNumber asc
	)
)
go

create table Rulebase.ESF_LearningDeliveryDeliverable (
	LearnRefNumber varchar(12),
	UKPRN int not null,
	AimSeqNumber int,
	DeliverableCode varchar(5),
	DeliverableUnitCost decimal(10,5),
	primary key clustered (
		LearnRefNumber asc,
		UKPRN asc,
		AimSeqNumber asc,
		DeliverableCode asc
	)
)
go

create table Rulebase.ESF_LearningDeliveryDeliverable_Period (
	LearnRefNumber varchar(12),
	UKPRN int not null,
	AimSeqNumber int,
	DeliverableCode varchar(5),
	[Period] int,
	AchievementEarnings decimal(10,5),
	AdditionalProgCostEarnings decimal(10,5),
	DeliverableVolume bigint,
	ProgressionEarnings decimal(10,5),
	ReportingVolume int,
	StartEarnings decimal(10,5),
	primary key clustered (
		LearnRefNumber asc,
		UKPRN asc,
		AimSeqNumber asc,
		DeliverableCode asc,
		[Period] asc
	)
)
go

create table Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues (
	LearnRefNumber varchar(12) not null,
	UKPRN int not null,
	AimSeqNumber int not null,
	DeliverableCode varchar(5) not null,
	AttributeName varchar(100) not null,
	Period_1 decimal(15,5),
	Period_2 decimal(15,5),
	Period_3 decimal(15,5),
	Period_4 decimal(15,5),
	Period_5 decimal(15,5),
	Period_6 decimal(15,5),
	Period_7 decimal(15,5),
	Period_8 decimal(15,5),
	Period_9 decimal(15,5),
	Period_10 decimal(15,5),
	Period_11 decimal(15,5),
	Period_12 decimal(15,5),
	primary key clustered (
		LearnRefNumber asc,
		UKPRN asc,
		AimSeqNumber asc,
		DeliverableCode asc,
		AttributeName asc
	)
)
go

create table Rulebase.ESF_DPOutcome (
	LearnRefNumber varchar(12) not null,
	UKPRN int not null,
	OutCode int not null,
	OutType varchar(30) not null,
	OutStartDate date not null,
	OutcomeDateForProgression date,
	PotentialESFProgressionType bit,
	ProgressionType varchar(50),
	ReachedSixMonthPoint bit,
	ReachedThreeMonthPoint bit,
	ReachedTwelveMonthPoint bit
	primary key clustered (
		LearnRefNumber asc,
		UKPRN asc,
		OutCode asc,
		OutType asc,
		OutStartDate asc
	)
)
go

create table Rulebase.FM35_Cases (
    UKPRN int,
    LearnRefNumber varchar(12),
    CaseData xml not null
  )
go

create table Rulebase.FM35_global (
	UKPRN varchar(8) not null,
	CurFundYr varchar(9) null,
	LARSVersion varchar(100) null,
	OrgVersion varchar(100) null,
	PostcodeDisadvantageVersion varchar(50) null,
	RulebaseVersion varchar(10) null
)
go

create table Rulebase.FM35_LearningDelivery (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AchApplicDate date null,
	Achieved bit null,
	AchieveElement decimal(10, 5) null,
	AchievePayElig bit null,
	AchievePayPctPreTrans decimal(10, 5) null,
	AchPayTransHeldBack decimal(10, 5) null,
	ActualDaysIL int null,
	ActualNumInstalm int null,
	ActualNumInstalmPreTrans int null,
	ActualNumInstalmTrans int null,
	AdjLearnStartDate date null,
	AdltLearnResp bit null,
	AgeAimStart int null,
	AimValue decimal(10, 5) null,
	AppAdjLearnStartDate date null,
	AppAgeFact decimal(10, 5) null,
	AppATAGTA bit null,
	AppCompetency bit null,
	AppFuncSkill bit null,
	AppFuncSkill1618AdjFact decimal(10, 5) null,
	AppKnowl bit null,
	AppLearnStartDate date null,
	ApplicEmpFactDate date null,
	ApplicFactDate date null,
	ApplicFundRateDate date null,
	ApplicProgWeightFact varchar(1) null,
	ApplicUnweightFundRate decimal(10, 5) null,
	ApplicWeightFundRate decimal(10, 5) null,
	AppNonFund bit null,
	AreaCostFactAdj decimal(10, 5) null,
	BalInstalmPreTrans int null,
	BaseValueUnweight decimal(10, 5) null,
	CapFactor decimal(10, 5) null,
	DisUpFactAdj decimal(10, 4) null,
	EmpOutcomePayElig bit null,
	EmpOutcomePctHeldBackTrans decimal(10, 5) null,
	EmpOutcomePctPreTrans decimal(10, 5) null,
	EmpRespOth bit null,
	ESOL bit null,
	FullyFund bit null,
	FundLine varchar(100) null,
	FundStart bit null,
	LargeEmployerID int null,
	LargeEmployerFM35Fctr decimal(10, 2) null,
	LargeEmployerStatusDate date null,
	LearnDelFundOrgCode varchar(50),
	LTRCUpliftFctr decimal(10, 5) null,
	NonGovCont decimal(10, 5) null,
	OLASSCustody bit null,
	OnProgPayPctPreTrans decimal(10, 5) null,
	OutstndNumOnProgInstalm int null,
	OutstndNumOnProgInstalmTrans int null,
	PlannedNumOnProgInstalm int null,
	PlannedNumOnProgInstalmTrans int null,
	PlannedTotalDaysIL int null,
	PlannedTotalDaysILPreTrans int null,
	PropFundRemain decimal(10, 2) null,
	PropFundRemainAch decimal(10, 2) null,
	PrscHEAim bit null,
	Residential bit null,
	Restart bit null,
	SpecResUplift decimal(10, 5) null,
	StartPropTrans decimal(10, 5) null,
	ThresholdDays int null,
	Traineeship bit null,
	Trans bit null,
	TrnAdjLearnStartDate date null,
	TrnWorkPlaceAim bit null,
	TrnWorkPrepAim bit null,
	UnWeightedRateFromESOL decimal(10, 5) null,
	UnweightedRateFromLARS decimal(10, 5) null,
	WeightedRateFromESOL decimal(10, 5) null,
	WeightedRateFromLARS decimal(10, 5) null,
	ReservedUpliftFactor1 decimal(10, 5),
    ReservedUpliftRate1 decimal(10,5),
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

create table Rulebase.FM35_LearningDelivery_Period (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	[Period] int not null,
	AchievePayment decimal(10, 5) null,
	AchievePayPct decimal(10, 5) null,
	AchievePayPctTrans decimal(10, 5) null,
	BalancePayment decimal(10, 5) null,
	BalancePaymentUncapped decimal(10, 5) null,
	BalancePct decimal(10, 5) null,
	BalancePctTrans decimal(10, 5) null,
	EmpOutcomePay decimal(10, 5) null,
	EmpOutcomePct decimal(10, 5) null,
	EmpOutcomePctTrans decimal(10, 5) null,
	InstPerPeriod int null,
	LearnSuppFund bit null,
	LearnSuppFundCash decimal(10, 5) null,
	OnProgPayment decimal(10, 5) null,
	OnProgPaymentUncapped decimal(10, 5) null,
	OnProgPayPct decimal(10, 5) null,
	OnProgPayPctTrans decimal(10, 5) null,
	TransInstPerPeriod int null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		[Period] asc
	)
)
go

create table Rulebase.FM35_LearningDelivery_PeriodisedValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AttributeName varchar(100) not null,
	Period_1 decimal(15, 5) null,
	Period_2 decimal(15, 5) null,
	Period_3 decimal(15, 5) null,
	Period_4 decimal(15, 5) null,
	Period_5 decimal(15, 5) null,
	Period_6 decimal(15, 5) null,
	Period_7 decimal(15, 5) null,
	Period_8 decimal(15, 5) null,
	Period_9 decimal(15, 5) null,
	Period_10 decimal(15, 5) null,
	Period_11 decimal(15, 5) null,
	Period_12 decimal(15, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		AttributeName asc
	)
)
go

 create table Rulebase.TBL_Cases (
    UKPRN int,
    LearnRefNumber varchar(12),
    CaseData xml not null
  )
go

create table Rulebase.TBL_global (
	UKPRN int not null,
	CurFundYr varchar(10) null,
	LARSVersion varchar(100) null,
	RulebaseVersion varchar(10) null
)
go

create table Rulebase.TBL_LearningDelivery (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	ProgStandardStartDate date null,
	FundLine varchar(50) null,
	MathEngAimValue decimal(10, 5) null,
	PlannedNumOnProgInstalm int null,
	LearnSuppFundCash decimal(10, 5) null,
	AdjProgStartDate date null,
	LearnSuppFund bit null,
	MathEngOnProgPayment decimal(10, 5) null,
	InstPerPeriod int null,
	SmallBusPayment decimal(10, 5) null,
	YoungAppSecondPayment decimal(10, 5) null,
	CoreGovContPayment decimal(10, 5) null,
	YoungAppEligible bit null,
	SmallBusEligible bit null,
	MathEngOnProgPct int null,
	AgeStandardStart int null,
	YoungAppSecondThresholdDate date null,
	EmpIdFirstDayStandard int null,
	EmpIdFirstYoungAppDate int null,
	EmpIdSecondYoungAppDate int null,
	EmpIdSmallBusDate int null,
	YoungAppFirstThresholdDate date null,
	AchApplicDate date null,
	AchEligible bit null,
	Achieved bit null,
	AchievementApplicVal decimal(10, 5) null,
	AchPayment decimal(10, 5) null,
	ActualNumInstalm int null,
	CombinedAdjProp bigint null,
	EmpIdAchDate int null,
	LearnDelDaysIL int null,
	LearnDelStandardAccDaysIL int null,
	LearnDelStandardPrevAccDaysIL int null,
	LearnDelStandardTotalDaysIL int null,
	ActualDaysIL int null,
	MathEngBalPayment decimal(10, 5) null,
	MathEngBalPct bigint null,
	MathEngLSFFundStart bit null,
	PlannedTotalDaysIL int null,
	MathEngLSFThresholdDays int null,
	OutstandNumOnProgInstalm int null,
	SmallBusApplicVal decimal(10, 5) null,
	SmallBusStatusFirstDayStandard int null,
	SmallBusStatusThreshold int null,
	YoungAppApplicVal decimal(10, 5) null,
	CoreGovContCapApplicVal bigint null,
	CoreGovContUncapped decimal(10, 5) null,
	ApplicFundValDate date null,
	YoungAppFirstPayment decimal(10, 5) null,
	YoungAppPayment decimal(10, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

create table Rulebase.TBL_LearningDelivery_Period (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	[Period] int not null,
	AchPayment decimal(10, 5) null,
	CoreGovContPayment decimal(10, 5) null,
	CoreGovContUncapped decimal(10, 5) null,
	InstPerPeriod int null,
	LearnSuppFund bit null,
	LearnSuppFundCash decimal(10, 5) null,
	MathEngBalPayment decimal(10, 5) null,
	MathEngBalPct decimal(8, 5) null,
	MathEngOnProgPayment decimal(10, 5) null,
	MathEngOnProgPct decimal(8, 5) null,
	SmallBusPayment decimal(10, 5) null,
	YoungAppFirstPayment decimal(10, 5) null,
	YoungAppPayment decimal(10, 5) null,
	YoungAppSecondPayment decimal(10, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		[Period] asc
	)
)
go

create table Rulebase.TBL_LearningDelivery_PeriodisedValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AttributeName varchar(100) not null,
	Period_1 decimal(15, 5) null,
	Period_2 decimal(15, 5) null,
	Period_3 decimal(15, 5) null,
	Period_4 decimal(15, 5) null,
	Period_5 decimal(15, 5) null,
	Period_6 decimal(15, 5) null,
	Period_7 decimal(15, 5) null,
	Period_8 decimal(15, 5) null,
	Period_9 decimal(15, 5) null,
	Period_10 decimal(15, 5) null,
	Period_11 decimal(15, 5) null,
	Period_12 decimal(15, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		AttributeName asc
	)
)
go
