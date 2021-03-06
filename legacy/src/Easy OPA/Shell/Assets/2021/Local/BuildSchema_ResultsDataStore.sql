if exists (select * from sys.Schemas where name = '${ilrFileName}') 
begin 
	DECLARE @Sql VARCHAR(MAX),
	@Schema VARCHAR(55)

SET @Schema = '${ilrFileName}'

SELECT @Sql = COALESCE(@Sql,'') + 'DROP TABLE [%SCHEMA%].' + QUOTENAME(TABLE_NAME) + ';' + CHAR(13)
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = @Schema
    AND TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME

SELECT @Sql = COALESCE(@Sql, '') + 'DROP SCHEMA [%SCHEMA%];'

SELECT @Sql = COALESCE(REPLACE(@Sql,'%SCHEMA%',@Schema), '')


EXEC(@Sql)
end
go

create schema [${ilrFileName}]
go

-- AEC

create table [${ilrFileName}].AEC_global (
	UKPRN int not null,
	LARSVersion varchar(100) not null,
	RulebaseVersion varchar(10) not null,
	[Year] varchar(4) not null,
	primary key clustered (
		UKPRN asc
	)
)
go

INSERT INTO [${ilrFileName}].AEC_global
SELECT * FROM Rulebase.AEC_global
WHERE UKPRN = ${UKPRN}

create table [${ilrFileName}].AEC_ApprenticeshipPriceEpisode (
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

INSERT INTO [${ilrFileName}].AEC_ApprenticeshipPriceEpisode
select * FROM Rulebase.AEC_ApprenticeshipPriceEpisode
WHERE UKPRN = ${UKPRN}

create table [${ilrFileName}].AEC_ApprenticeshipPriceEpisode_Period (
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

INSERT INTO [${ilrFileName}].AEC_ApprenticeshipPriceEpisode_Period
SELECT * FROM Rulebase.AEC_ApprenticeshipPriceEpisode_Period
WHERE UKPRN = ${UKPRN}

create table [${ilrFileName}].AEC_ApprenticeshipPriceEpisode_PeriodisedValues (
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

INSERT INTO [${ilrFileName}].AEC_ApprenticeshipPriceEpisode_PeriodisedValues
SELECT * FROM Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues
WHERE UKPRN = ${UKPRN}
go


create table [${ilrFileName}].AEC_HistoricEarningOutput (
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

INSERT INTO [${ilrFileName}].AEC_HistoricEarningOutput
select * FROM Rulebase.AEC_HistoricEarningOutput
WHERE UKPRN = ${UKPRN}
go

create table [${ilrFileName}].AEC_LearningDelivery (
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

INSERT INTO [${ilrFileName}].AEC_LearningDelivery
select * FROM Rulebase.AEC_LearningDelivery
WHERE UKPRN = ${UKPRN}
go

create table [${ilrFileName}].AEC_LearningDelivery_Period (
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

INSERT INTO [${ilrFileName}].AEC_LearningDelivery_Period
select * FROM Rulebase.AEC_LearningDelivery_Period
WHERE UKPRN = ${UKPRN}
go

create table [${ilrFileName}].AEC_LearningDelivery_PeriodisedTextValues (
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

INSERT INTO [${ilrFileName}].AEC_LearningDelivery_PeriodisedTextValues
select * FROM Rulebase.AEC_LearningDelivery_PeriodisedTextValues
WHERE UKPRN = ${UKPRN}
go

create table [${ilrFileName}].AEC_LearningDelivery_PeriodisedValues (
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

INSERT INTO [${ilrFileName}].AEC_LearningDelivery_PeriodisedValues
select * FROM Rulebase.AEC_LearningDelivery_PeriodisedValues
WHERE UKPRN = ${UKPRN}
go

-- ALB

create table [${ilrFileName}].ALB_global (
	UKPRN int not null,
	LARSVersion varchar(100) null,
	PostcodeAreaCostVersion varchar(20) null,
	RulebaseVersion varchar(10) null,
	primary key clustered (
		UKPRN asc
	)
)
go

INSERT INTO [${ilrFileName}].ALB_Global (
UKPRN,
LARSVersion,
PostcodeAreaCostVersion,
RulebaseVersion
) 
SELECT UKPRN, LARSVersion, PostcodeAreaCostVersion, RulebaseVersion FROM Rulebase.ALB_Global
WHERE UKPRN = ${UKPRN}
GO

create table [${ilrFileName}].ALB_Learner_Period (
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

INSERT INTO [${ilrFileName}].ALB_Learner_Period(
	UKPRN,
	LearnRefNumber,
	[Period],
	ALBSeqNum
)
SELECT
*
FROM Rulebase.ALB_Learner_Period
WHERE UKPRN = ${UKPRN}
GO

create table [${ilrFileName}].ALB_Learner_PeriodisedValues (
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

INSERT INTO [${ilrFileName}].ALB_Learner_PeriodisedValues(
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
SELECT UKPRN,
LearnRefNumber, AttributeName, Period_1,
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
FROM Rulebase.ALB_Learner_PeriodisedValues
WHERE UKPRN = ${UKPRN}
GO

create table [${ilrFileName}].ALB_LearningDelivery (
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

INSERT INTO [${ilrFileName}].ALB_LearningDelivery(
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
SELECT UKPRN,
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
FROM Rulebase.ALB_LearningDelivery
WHERE UKPRN = ${UKPRN}
GO

create table [${ilrFileName}].ALB_LearningDelivery_Period (
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

INSERT INTO [${ilrFileName}].ALB_LearningDelivery_Period(
UKPRN,
LearnRefNumber,
AimSeqNumber,
[Period],
ALBCode,
ALBSupportPayment,
AreaUpliftBalPayment,
AreaUpliftOnProgPayment
)
SELECT UKPRN,
LearnRefNumber,
AimSeqNumber,
[Period],
ALBCode,
ALBSupportPayment,
AreaUpliftBalPayment,
AreaUpliftOnProgPayment
FROM Rulebase.ALB_LearningDelivery_Period
WHERE UKPRN = ${UKPRN}
GO

create table [${ilrFileName}].ALB_LearningDelivery_PeriodisedValues (
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

INSERT INTO [${ilrFileName}].ALB_LearningDelivery_PeriodisedValues(
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
SELECT UKPRN,
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
FROM Rulebase.ALB_LearningDelivery_PeriodisedValues
WHERE UKPRN = ${UKPRN}
GO

-- ESF

create table [${ilrFileName}].ESF_global (
	UKPRN int,
	RulebaseVersion varchar(10),
)
go

INSERT INTO [${ilrFileName}].ESF_global
SELECT * FROM Rulebase.ESF_global
WHERE UKPRN = ${UKPRN}
GO

create table [${ilrFileName}].ESF_LearningDelivery (
	UKPRN int not null,
	LearnRefNumber varchar(12),
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
		--UKPRN asc,
		AimSeqNumber asc
	)
)
go

INSERT INTO [${ilrFileName}].ESF_LearningDelivery(
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
SELECT UKPRN,
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
FROM Rulebase.ESF_LearningDelivery
WHERE UKPRN = ${UKPRN}
go

create table [${ilrFileName}].ESF_LearningDeliveryDeliverable (
	UKPRN int not null,
	LearnRefNumber varchar(12),
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

INSERT INTO [${ilrFileName}].ESF_LearningDeliveryDeliverable
SELECT 
* FROM Rulebase.ESF_LearningDeliveryDeliverable
WHERE UKPRN = ${UKPRN}
go

create table [${ilrFileName}].ESF_LearningDeliveryDeliverable_Period (
	UKPRN int not null,
	LearnRefNumber varchar(12),
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

INSERT INTO [${ilrFileName}].ESF_LearningDeliveryDeliverable_Period
SELECT
* FROM Rulebase.ESF_LearningDeliveryDeliverable_Period
WHERE UKPRN = ${UKPRN}
go

create table [${ilrFileName}].ESF_LearningDeliveryDeliverable_PeriodisedValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
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

INSERT INTO [${ilrFileName}].ESF_LearningDeliveryDeliverable_PeriodisedValues
SELECT
* FROM Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues
WHERE UKPRN = ${UKPRN}
go

create table [${ilrFileName}].ESF_DPOutcome (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
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

INSERT INTO [${ilrFileName}].ESF_DPOutcome
SELECT
* FROM Rulebase.ESF_DPOutcome
WHERE UKPRN = ${UKPRN}
GO

-- FM25

create table [${ilrFileName}].FM25_global (
	UKPRN int not null,
	LARSVersion varchar(50) null,
	OrgVersion varchar(50) null,
	PostcodeDisadvantageVersion varchar(50) null,
	RulebaseVersion varchar(10) null,
	primary key clustered (
		UKPRN asc
	)
)
go

INSERT INTO [${ilrFileName}].FM25_global(
UKPRN,
LARSVersion,
OrgVersion,
PostcodeDisadvantageVersion,
RulebaseVersion
)
SELECT UKPRN, LARSVersion, OrgVersion, PostcodeDisadvantageVersion, RulebaseVersion from Rulebase.FM25_global
WHERE UKPRN = ${UKPRN}
go

create table [${ilrFileName}].FM25_Learner (
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
	PrvHistL3ProgMathEngProp decimal(10,5),
	L3MathsEnglish1Year decimal(10,5),
	L3MathsEnglish2Year decimal(10,5),
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc
	)
)
go

INSERT INTO [${ilrFileName}].FM25_Learner
SELECT * 
FROM Rulebase.FM25_Learner
WHERE UKPRN = ${UKPRN}
go

-- FM25 Periodisation

create table [${ilrFileName}].FM25_FM35_global (
	UKPRN int not null,
	RulebaseVersion varchar(10) null,
	primary key clustered (
		UKPRN asc
	)
)
go

INSERT INTO [${ilrFileName}].FM25_FM35_global
SELECT * FROM Rulebase.FM25_FM35_global
WHERE UKPRN = ${UKPRN}
go

create table [${ilrFileName}].FM25_FM35_Learner_Period (
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

INSERT INTO [${ilrFileName}].FM25_FM35_Learner_Period
SELECT 
* FROM Rulebase.FM25_FM35_Learner_Period
WHERE UKPRN = ${UKPRN}
GO

create table [${ilrFileName}].FM25_FM35_Learner_PeriodisedValues (
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

INSERT INTO [${ilrFileName}].FM25_FM35_Learner_PeriodisedValues
SELECT
* FROM Rulebase.FM25_FM35_Learner_PeriodisedValues
WHERE UKPRN = ${UKPRN}
GO

-- FM35
create table [${ilrFileName}].FM35_global (
	UKPRN varchar(8) not null,
	CurFundYr varchar(9) null,
	LARSVersion varchar(100) null,
	OrgVersion varchar(100) null,
	PostcodeDisadvantageVersion varchar(50) null,
	RulebaseVersion varchar(10) null,
	primary key clustered (
		UKPRN asc
	)
)
go

INSERT INTO [${ilrFileName}].FM35_global
SELECT * FROM Rulebase.FM35_global
WHERE UKPRN = ${UKPRN}
go

create table [${ilrFileName}].FM35_LearningDelivery (
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
	ReservedUpliftFactor1 decimal(10, 5) null,
	ReservedUpliftRate1 decimal(10, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

INSERT INTO [${ilrFileName}].FM35_LearningDelivery
SELECT
* FROM Rulebase.FM35_LearningDelivery
WHERE UKPRN = ${UKPRN}
go

create table [${ilrFileName}].FM35_LearningDelivery_Period (
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

INSERT INTO [${ilrFileName}].FM35_LearningDelivery_Period
SELECT
* FROM Rulebase.FM35_LearningDelivery_Period
WHERE UKPRN = ${UKPRN}
go

create table [${ilrFileName}].FM35_LearningDelivery_PeriodisedValues (
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

INSERT INTO [${ilrFileName}].FM35_LearningDelivery_PeriodisedValues
SELECT
* FROM Rulebase.FM35_LearningDelivery_PeriodisedValues
WHERE UKPRN = ${UKPRN}
go

-- TBL

create table [${ilrFileName}].TBL_global (
	UKPRN int not null,
	CurFundYr varchar(10) null,
	LARSVersion varchar(100) null,
	RulebaseVersion varchar(10) null,
	primary key clustered (
		UKPRN asc
	)
)
go

INSERT INTO [${ilrFileName}].TBL_global (
UKPRN,
	CurFundYr,
	LARSVersion,
	RulebaseVersion
)
SELECT UKPRN, CurFundYr,LARSVersion, RulebaseVersion FROM Rulebase.TBL_global
WHERE UKPRN = ${UKPRN}
go

create table [${ilrFileName}].TBL_LearningDelivery (
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

INSERT INTO [${ilrFileName}].TBL_LearningDelivery(
	UKPRN ,
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
SELECT 
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
FROM Rulebase.TBL_LearningDelivery
WHERE UKPRN = ${UKPRN}
go

create table [${ilrFileName}].TBL_LearningDelivery_Period (
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

INSERT INTO [${ilrFileName}].TBL_LearningDelivery_Period (
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
) SELECT 
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
FROM Rulebase.TBL_LearningDelivery_Period
WHERE UKPRN = ${UKPRN}
GO

create table [${ilrFileName}].TBL_LearningDelivery_PeriodisedValues (
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

INSERT INTO [${ilrFileName}].TBL_LearningDelivery_PeriodisedValues(
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
)SELECT UKPRN, 
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
FROM Rulebase.TBL_LearningDelivery_PeriodisedValues
WHERE UKPRN = ${UKPRN}
go


-- ILR File Copy

if object_id('[${ilrFileName}].CollectionDetails','u') is not null
begin
	drop table [${ilrFileName}].CollectionDetails
end
go
 
create table [${ilrFileName}].CollectionDetails (
	[UKPRN] int not null,
	[Collection] varchar(3) not null,
	[Year] varchar(4) not null,
	FilePreparationDate date null
)
go

INSERT INTO [${ilrFileName}].CollectionDetails
SELECT * FROM Valid.CollectionDetails
WHERE UKPRN = ${UKPRN}
go


if object_id('[${ilrFileName}].Source','u') is not null
begin
	drop table [${ilrFileName}].[Source]
end
go
 
create table [${ilrFileName}].[Source] (
	ProtectiveMarking varchar(30) null,
	UKPRN int not null,
	SoftwareSupplier varchar(40) null,
	SoftwarePackage varchar(30) null,
	Release varchar(20) null,
	SerialNo varchar(2) null,
	[DateTime] datetime null,
	ReferenceData varchar(100) null,
	ComponentSetVersion varchar(20) null
)
go

INSERT INTO [${ilrFileName}].[Source]
SELECT * from Valid.[Source]
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].SourceFile','u') is not null
begin
	drop table [${ilrFileName}].SourceFile
end
go
 
create table [${ilrFileName}].SourceFile (
	[UKPRN] int not null,
	SourceFileName varchar(50) null,
	FilePreparationDate date null,
	SoftwareSupplier varchar(40) null,
	SoftwarePackage varchar(30) null,
	Release varchar(20) null,
	SerialNo varchar(2) null,
	[DateTime] datetime null
)
go

create clustered index IX_Valid_SourceFile on [${ilrFileName}].SourceFile (
	SourceFileName asc
)
go

INSERT INTO [${ilrFileName}].SourceFile
SELECT * FROM Valid.SourceFile
WHERE UKPRN = ${UKPRN}
go


if object_id('[${ilrFileName}].LearningProvider','u') is not null
begin
	drop table [${ilrFileName}].LearningProvider
end
go
 
create table [${ilrFileName}].LearningProvider ( 
	UKPRN int not null,
	primary key clustered (
		UKPRN asc
	)
)
go

INSERT INTO [${ilrFileName}].LearningProvider
SELECT * FROM Valid.LearningProvider
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].Learner','u') is not null
begin
	drop table [${ilrFileName}].Learner
end
go
 
create table [${ilrFileName}].Learner (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	PrevLearnRefNumber varchar(12) null,
	PrevUKPRN int null,
	PMUKPRN int null,
	CampId varchar(8) null,
	ULN bigint not null,
	FamilyName varchar(100) null,
	GivenNames varchar(100) null,
	DateOfBirth date null,
	Ethnicity int not null,
	Sex varchar(1) not null,
	LLDDHealthProb int not null,
	NINumber varchar(9) null,
	PriorAttain int null,
	Accom int null,
	ALSCost int null,
	PlanLearnHours int null,
	PlanEEPHours int null,
	MathGrade varchar(4) null,
	EngGrade varchar(4) null,
	PostcodePrior varchar(8) null,
	Postcode varchar(8) null,
	AddLine1 varchar(50) null,
	AddLine2 varchar(50) null,
	AddLine3 varchar(50) null,
	AddLine4 varchar(50) null,
	TelNo varchar(18) null,
	Email varchar(1000),
	primary key clustered (
		LearnRefNumber asc
	)
)
go

INSERT INTO [${ilrFileName}].Learner
SELECT * FROM Valid.Learner
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].ContactPreference','u') is not null
begin
	drop table [${ilrFileName}].ContactPreference
end
go
 
create table [${ilrFileName}].ContactPreference (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	ContPrefType varchar(3) not null,
	ContPrefCode int not null,
	primary key (
		LearnRefNumber,
		ContPrefType,
		ContPrefCode
	)
)
go

INSERT INTO [${ilrFileName}].ContactPreference
SELECT * FROM Valid.ContactPreference
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].LLDDandHealthProblem','u') is not null
begin
	drop table [${ilrFileName}].LLDDandHealthProblem
end
go
 
create table [${ilrFileName}].LLDDandHealthProblem (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	LLDDCat int not null,
	PrimaryLLDD int null, 
	primary key clustered (
		LearnRefNumber asc,
		LLDDCat asc
	)
)
go

INSERT INTO [${ilrFileName}].LLDDandHealthProblem
SELECT * FROM Valid.LLDDandHealthProblem
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].LearnerFAM','u') is not null
begin
	drop table [${ilrFileName}].LearnerFAM
end
go
 
create table [${ilrFileName}].LearnerFAM (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	LearnFAMType varchar(3) null,
	LearnFAMCode int not null
)
go

create clustered index IX_Valid_LearnerFAM on [${ilrFileName}].LearnerFAM (
	LearnRefNumber asc
)
go

INSERT INTO [${ilrFileName}].LearnerFAM
SELECT * FROM Valid.LearnerFAM
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].ProviderSpecLearnerMonitoring','u') is not null
begin
	drop table [${ilrFileName}].ProviderSpecLearnerMonitoring
end
go

create table [${ilrFileName}].ProviderSpecLearnerMonitoring (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	ProvSpecLearnMonOccur varchar(1) not null,
	ProvSpecLearnMon varchar(20) not null,
	primary key clustered (
		LearnRefNumber asc,
		ProvSpecLearnMonOccur asc
	)
)
go

INSERT INTO [${ilrFileName}].ProviderSpecLearnerMonitoring
SELECT * FROM Valid.ProviderSpecLearnerMonitoring
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].LearnerEmploymentStatus','u') is not null
begin
	drop table [${ilrFileName}].LearnerEmploymentStatus
end
go
 
create table [${ilrFileName}].LearnerEmploymentStatus (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	EmpStat int null,
	DateEmpStatApp date not null,
	EmpId bigint,
	primary key clustered (
		LearnRefNumber asc,
		DateEmpStatApp asc
	)
)
go

INSERT INTO [${ilrFileName}].LearnerEmploymentStatus
SELECT * FROM Valid.LearnerEmploymentStatus
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].LearnerEmploymentStatusDenormTbl','u') is not null
begin
	drop table [${ilrFileName}].LearnerEmploymentStatusDenormTbl
end
go

create table [${ilrFileName}].LearnerEmploymentStatusDenormTbl (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	EmpStat int null,
	EmpId int null,
	DateEmpStatApp date not null,
	ESMCode_BSI int null,
	ESMCode_EII int null,
	ESMCode_LOE int null,
	ESMCode_LOU int null,
	ESMCode_PEI int null,
	ESMCode_SEI int null,
	ESMCode_SEM int null,
	primary key clustered (
		LearnRefNumber asc,
		DateEmpStatApp asc
	)
)
go

INSERT INTO [${ilrFileName}].LearnerEmploymentStatusDenormTbl
SELECT * FROM Valid.LearnerEmploymentStatusDenormTbl
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].EmploymentStatusMonitoring','u') is not null
begin
	drop table [${ilrFileName}].EmploymentStatusMonitoring
end
go
 
create table [${ilrFileName}].EmploymentStatusMonitoring ( 
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	DateEmpStatApp date not null,
	ESMType varchar(3) not null,
	ESMCode int null,
	primary key clustered (
		LearnRefNumber asc,
		DateEmpStatApp asc,
		ESMType asc
	)
)
go

INSERT INTO [${ilrFileName}].EmploymentStatusMonitoring
SELECT * FROM Valid.EmploymentStatusMonitoring
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].LearnerHE','u') is not null
begin
	drop table [${ilrFileName}].LearnerHE
end
go
 
create table [${ilrFileName}].LearnerHE (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	UCASPERID varchar(10) null,
	TTACCOM int null, 
	primary key clustered (
		LearnRefNumber asc
	)
)
go

INSERT INTO [${ilrFileName}].LearnerHE
SELECT * FROM Valid.LearnerHE
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].LearnerHEFinancialSupport','u') is not null
begin
	drop table [${ilrFileName}].LearnerHEFinancialSupport
end
go
 
create table [${ilrFileName}].LearnerHEFinancialSupport (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	FINTYPE int not null,
	FINAMOUNT int not null,
	primary key clustered (
		LearnRefNumber asc,
		FINTYPE asc
	)
)
go

INSERT INTO [${ilrFileName}].LearnerHEFinancialSupport
SELECT * FROM Valid.LearnerHEFinancialSupport
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].LearningDelivery','u') is not null
begin
	drop table [${ilrFileName}].LearningDelivery
end
go
 
create table [${ilrFileName}].LearningDelivery (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	LearnAimRef varchar(8) not null,
	AimType int not null,
	AimSeqNumber int not null,
	LearnStartDate date not null,
	OrigLearnStartDate date null,
	LearnPlanEndDate date not null,
	FundModel int not null,
	PHours bigint null,
	OTJActHours bigint null,
	ProgType int null,
	FworkCode int null,
	PwayCode int null,
	StdCode int null,
	PartnerUKPRN int null,
	DelLocPostCode varchar(8) null,
	LSDPostcode varchar(8) null,
	AddHours int null,
	PriorLearnFundAdj int null,
	OtherFundAdj int null,
	ConRefNumber varchar(20) null,
	EPAOrgID varchar(7) null,
	EmpOutcome int null,
	CompStatus int not null,
	LearnActEndDate date null,
	WithdrawReason int null,
	Outcome int null,
	AchDate date null,
	OutGrade varchar(6) null,
	SWSupAimId varchar(36) null,
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

create index IDX_FundModel ON [${ilrFileName}].LearningDelivery (
	FundModel
)
go

INSERT INTO [${ilrFileName}].LearningDelivery
SELECT * FROM Valid.LearningDelivery
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].LearningDeliveryDenormTbl','U') is not null
begin
	drop table [${ilrFileName}].LearningDeliveryDenormTbl
end
go

create table [${ilrFileName}].LearningDeliveryDenormTbl (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	LearnAimRef varchar(8) not null,
	AimType int not null,
	AimSeqNumber int not null,
	LearnStartDate date not null,
	OrigLearnStartDate date null,
	LearnPlanEndDate date not null,
	FundModel int not null,
	ProgType int null,
	FworkCode int null,
	PwayCode int null,
	StdCode int null,
	PartnerUKPRN int null,
	DelLocPostCode varchar(8) null,
	LSDPostcode varchar(8) null,
	AddHours int null,
	PriorLearnFundAdj int null,
	OtherFundAdj int null,
	ConRefNumber varchar(20) null,
	EPAOrgID varchar(7) null,
	EmpOutcome int null,
	CompStatus int not null,
	LearnActEndDate date null,
	WithdrawReason int null,
	Outcome int null,
	AchDate date null,
	OutGrade varchar(6) null,
	SWSupAimId varchar(36) null,
	HEM1 varchar(5) null,
	HEM2 varchar(5) null,
	HEM3 varchar(5) null,
	HHS1 varchar(5) null,
	HHS2 varchar(5) null,
	LDFAM_SOF varchar(5) null,
	LDFAM_EEF varchar(5) null,
	LDFAM_RES varchar(5) null,
	LDFAM_ADL varchar(5) null,
	LDFAM_FFI varchar(5) null,
	LDFAM_WPP varchar(5) null,
	LDFAM_POD varchar(5) null,
	LDFAM_ASL varchar(5) null,
	LDFAM_FLN varchar(5) null,
	LDFAM_NSA varchar(5) null,
	ProvSpecDelMon_A varchar(20) null,
	ProvSpecDelMon_B varchar(20) null,
	ProvSpecDelMon_C varchar(20) null,
	ProvSpecDelMon_D varchar(20) null,
	LDM1 varchar(5) null,
	LDM2 varchar(5) null,
	LDM3 varchar(5) null,
	LDM4 varchar(5) null,
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

INSERT INTO [${ilrFileName}].LearningDeliveryDenormTbl
SELECT * FROM Valid.LearningDeliveryDenormTbl
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].LearningDeliveryFAM','u') is not null
begin
	drop table [${ilrFileName}].LearningDeliveryFAM
end
go
 
create table [${ilrFileName}].LearningDeliveryFAM (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	LearnDelFAMType varchar(3) not null,
	LearnDelFAMCode varchar(5) not null,
	LearnDelFAMDateFrom date null,
	LearnDelFAMDateTo date null
)
go

create clustered index IX_Valid_LearningDeliveryFAM on [${ilrFileName}].LearningDeliveryFAM (
	LearnRefNumber asc,
	AimSeqNumber asc,
	LearnDelFAMType asc,
	LearnDelFAMDateFrom asc
)
go

INSERT INTO [${ilrFileName}].LearningDeliveryFAM
SELECT * FROM Valid.LearningDeliveryFAM
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].LearningDeliveryWorkPlacement','u') is not null
begin
	drop table [${ilrFileName}].LearningDeliveryWorkPlacement
end
go
 
create table [${ilrFileName}].LearningDeliveryWorkPlacement (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	WorkPlaceStartDate date not null,
	WorkPlaceEndDate date null,
	WorkPlaceHours int null,
	WorkPlaceMode int not null,
	WorkPlaceEmpId int null
)
go

create clustered index IX_Valid_LearningDeliveryWorkPlacement on [${ilrFileName}].LearningDeliveryWorkPlacement (
	LearnRefNumber asc,
	AimSeqNumber asc,
	WorkPlaceStartDate asc,
	WorkPlaceMode asc,
	WorkPlaceEmpId asc
)
go

INSERT INTO [${ilrFileName}].LearningDeliveryWorkPlacement
SELECT * FROM Valid.LearningDeliveryWorkPlacement
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].AppFinRecord','u') is not null
begin
	drop table [${ilrFileName}].AppFinRecord
end
go
 
create table [${ilrFileName}].AppFinRecord (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AFinType varchar(3) not null,
	AFinCode int not null,
	AFinDate date not null,
	AFinAmount int not null
)
go

create clustered index IX_Valid_AppFinRecord on [${ilrFileName}].AppFinRecord (
	LearnRefNumber asc,
	AimSeqNumber asc,
	AFinType asc
)
go

INSERT INTO [${ilrFileName}].AppFinRecord
SELECT * FROM Valid.AppFinRecord
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].ProviderSpecDeliveryMonitoring','u') is not null
begin
	drop table [${ilrFileName}].ProviderSpecDeliveryMonitoring
end
go
 
create table [${ilrFileName}].ProviderSpecDeliveryMonitoring (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	ProvSpecDelMonOccur varchar(1) not null,
	ProvSpecDelMon varchar(20) not null,
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc,
		ProvSpecDelMonOccur asc
	)
)
go

INSERT INTO [${ilrFileName}].ProviderSpecDeliveryMonitoring
SELECT * FROM Valid.ProviderSpecDeliveryMonitoring
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].LearningDeliveryHE','u') is not null
begin
	drop table [${ilrFileName}].LearningDeliveryHE
end
go
 
create table [${ilrFileName}].LearningDeliveryHE (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	NUMHUS varchar(20) null,
	SSN varchar(13) null,
	QUALENT3 varchar(3) null,
	SOC2000 int null,
	SEC int null,
	UCASAPPID varchar(9) null,
	TYPEYR int not null,
	MODESTUD int not null,
	FUNDLEV int not null,
	FUNDCOMP int not null,
	STULOAD decimal(4,1) null,
	YEARSTU int not null,
	MSTUFEE int not null,
	PCOLAB decimal(4,1) null,
	PCFLDCS decimal(4,1) null,
	PCSLDCS decimal(4,1) null,
	PCTLDCS decimal(4,1) null,
	SPECFEE int not null,
	NETFEE int null,
	GROSSFEE int null,
	DOMICILE varchar(2) null,
	ELQ int null,
	HEPostCode varchar(8) null,
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

INSERT INTO [${ilrFileName}].LearningDeliveryHE
SELECT * FROM Valid.LearningDeliveryHE
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].LearnerDestinationandProgression','u') is not null
begin
	drop table [${ilrFileName}].LearnerDestinationandProgression
end
go
 
create table [${ilrFileName}].LearnerDestinationandProgression (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	ULN bigint not null,
	primary key clustered (
		LearnRefNumber asc
	)
)
go

INSERT INTO [${ilrFileName}].LearnerDestinationandProgression
SELECT * FROM Valid.LearnerDestinationandProgression
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].DPOutcome','u') is not null
begin
	drop table [${ilrFileName}].DPOutcome
end
go
 
create table [${ilrFileName}].DPOutcome (
	[UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	OutType varchar(3) not null,
	OutCode int not null,
	OutStartDate date not null,
	OutEndDate date null,
	OutCollDate date not null
)
go

create clustered index IX_Valid_DPOutcome on [${ilrFileName}].DPOutcome (
	LearnRefNumber asc,
	OutType asc,
	OutCode asc,
	OutStartDate asc
)
go

INSERT INTO [${ilrFileName}].DPOutcome
SELECT * FROM Valid.DPOutcome
WHERE UKPRN = ${UKPRN}
go

if object_id('[${ilrFileName}].File','u') is not null
begin
	drop table [${ilrFileName}].[File]
end
go
 
create table [${ilrFileName}].[File] (
	[UKPRN] int not null,
	[FileName] varchar(55)
)
go

INSERT INTO [${ilrFileName}].[File]
SELECT * FROM Valid.[File]
WHERE UKPRN = ${UKPRN}
go