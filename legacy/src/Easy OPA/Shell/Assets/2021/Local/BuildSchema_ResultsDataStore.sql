if exists (select * from sys.Schemas where name = '${ilrFileName}') 
begin 
	DECLARE @Sql VARCHAR(MAX),
	@Schema VARCHAR(30)

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
SELECT (SELECT TOP(1) UKPRN FROM [${ilrFileName}].ALB_Global) as UKPRN,
*
FROM Rulebase.ALB_Learner_Period
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
Period_12
)
SELECT (SELECT TOP(1) UKPRN FROM [${ilrFileName}].ALB_Global) as UKPRN,
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
Period_12
FROM Rulebase.ALB_Learner_PeriodisedValues
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
SELECT (SELECT TOP(1) UKPRN FROM [${ilrFileName}].ALB_Global) as UKPRN,
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
SELECT (SELECT TOP(1) UKPRN FROM [${ilrFileName}].ALB_Global) as UKPRN,
LearnRefNumber,
AimSeqNumber,
[Period],
ALBCode,
ALBSupportPayment,
AreaUpliftBalPayment,
AreaUpliftOnProgPayment
FROM Rulebase.ALB_LearningDelivery_Period
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
Period_12
)
SELECT (SELECT TOP(1) UKPRN FROM [${ilrFileName}].ALB_Global) as UKPRN,
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
Period_12
FROM Rulebase.ALB_LearningDelivery_PeriodisedValues
GO

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
	(SELECT TOP(1) UKPRN FROM [${ilrFileName}].TBL_global) as UKPRN, 
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
(SELECT TOP(1) UKPRN FROM [${ilrFileName}].TBL_global) as UKPRN, 
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
)SELECT (SELECT TOP(1) UKPRN FROM [${ilrFileName}].TBL_global) as UKPRN, 
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
go