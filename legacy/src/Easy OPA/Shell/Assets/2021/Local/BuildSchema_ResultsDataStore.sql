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
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc
	)
)
go

INSERT INTO [${ilrFileName}].FM25_Learner(
UKPRN,
LearnRefNumber,
AcadMonthPayment,
AcadProg,
ActualDaysILCurrYear,
AreaCostFact1618Hist,
Block1DisadvUpliftNew,
Block2DisadvElementsNew,
ConditionOfFundingEnglish,
ConditionOfFundingMaths,
CoreAimSeqNumber,
	FullTimeEquiv,
	FundLine,
	LearnerActEndDate,
	LearnerPlanEndDate,
	LearnerStartDate,
	NatRate,
	OnProgPayment,
	PlannedDaysILCurrYear,
	ProgWeightHist,
	ProgWeightNew,
	PrvDisadvPropnHist,
	PrvHistLrgProgPropn,
	PrvRetentFactHist,
	RateBand,
	RetentNew,
	StartFund,
	ThresholdDays
	
)
SELECT (SELECT TOP(1) UKPRN from [${ilrFileName}].FM25_global) as UKPRN, 
* 
FROM Rulebase.FM25_Learner
go



-- ILR File Copy
if object_id('[${ilrFileName}].CollectionDetails','u') is not null
begin
	drop table [${ilrFileName}].CollectionDetails
end
go
 
create table [${ilrFileName}].CollectionDetails (
	[Collection] varchar(3) not null,
	[Year] varchar(4) not null,
	FilePreparationDate date null
)
go

INSERT INTO [${ilrFileName}].CollectionDetails
SELECT * FROM Valid.CollectionDetails
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
SELECT * from Valid.Source
go

if object_id('[${ilrFileName}].SourceFile','u') is not null
begin
	drop table [${ilrFileName}].SourceFile
end
go
 
create table [${ilrFileName}].SourceFile (
	SourceFileName varchar(50) not null,
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
go

if object_id('[${ilrFileName}].Learner','u') is not null
begin
	drop table [${ilrFileName}].Learner
end
go
 
create table [${ilrFileName}].Learner (
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
go

if object_id('[${ilrFileName}].ContactPreference','u') is not null
begin
	drop table [${ilrFileName}].ContactPreference
end
go
 
create table [${ilrFileName}].ContactPreference (
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
go

if object_id('[${ilrFileName}].LLDDandHealthProblem','u') is not null
begin
	drop table [${ilrFileName}].LLDDandHealthProblem
end
go
 
create table [${ilrFileName}].LLDDandHealthProblem (
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
go

if object_id('[${ilrFileName}].LearnerFAM','u') is not null
begin
	drop table [${ilrFileName}].LearnerFAM
end
go
 
create table [${ilrFileName}].LearnerFAM (
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
go

if object_id('[${ilrFileName}].ProviderSpecLearnerMonitoring','u') is not null
begin
	drop table [${ilrFileName}].ProviderSpecLearnerMonitoring
end
go
 
create table [${ilrFileName}].ProviderSpecLearnerMonitoring (
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
go

if object_id('[${ilrFileName}].LearnerEmploymentStatus','u') is not null
begin
	drop table [${ilrFileName}].LearnerEmploymentStatus
end
go
 
create table [${ilrFileName}].LearnerEmploymentStatus (
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
go

if object_id('[${ilrFileName}].LearnerEmploymentStatusDenormTbl','u') is not null
begin
	drop table [${ilrFileName}].LearnerEmploymentStatusDenormTbl
end
go

create table [${ilrFileName}].LearnerEmploymentStatusDenormTbl (
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
go

if object_id('[${ilrFileName}].EmploymentStatusMonitoring','u') is not null
begin
	drop table [${ilrFileName}].EmploymentStatusMonitoring
end
go
 
create table [${ilrFileName}].EmploymentStatusMonitoring ( 
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
go

if object_id('[${ilrFileName}].LearnerHE','u') is not null
begin
	drop table [${ilrFileName}].LearnerHE
end
go
 
create table [${ilrFileName}].LearnerHE (
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
go

if object_id('[${ilrFileName}].LearnerHEFinancialSupport','u') is not null
begin
	drop table [${ilrFileName}].LearnerHEFinancialSupport
end
go
 
create table [${ilrFileName}].LearnerHEFinancialSupport (
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
go

if object_id('[${ilrFileName}].LearningDelivery','u') is not null
begin
	drop table [${ilrFileName}].LearningDelivery
end
go
 
create table [${ilrFileName}].LearningDelivery (
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
go

if object_id('[${ilrFileName}].LearningDeliveryDenormTbl','U') is not null
begin
	drop table [${ilrFileName}].LearningDeliveryDenormTbl
end
go

create table [${ilrFileName}].LearningDeliveryDenormTbl (
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
go

if object_id('[${ilrFileName}].LearningDeliveryFAM','u') is not null
begin
	drop table [${ilrFileName}].LearningDeliveryFAM
end
go
 
create table [${ilrFileName}].LearningDeliveryFAM (
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
go

if object_id('[${ilrFileName}].LearningDeliveryWorkPlacement','u') is not null
begin
	drop table [${ilrFileName}].LearningDeliveryWorkPlacement
end
go
 
create table [${ilrFileName}].LearningDeliveryWorkPlacement (
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
go

if object_id('[${ilrFileName}].AppFinRecord','u') is not null
begin
	drop table [${ilrFileName}].AppFinRecord
end
go
 
create table [${ilrFileName}].AppFinRecord (
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
go

if object_id('[${ilrFileName}].ProviderSpecDeliveryMonitoring','u') is not null
begin
	drop table [${ilrFileName}].ProviderSpecDeliveryMonitoring
end
go
 
create table [${ilrFileName}].ProviderSpecDeliveryMonitoring (
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
go

if object_id('[${ilrFileName}].LearningDeliveryHE','u') is not null
begin
	drop table [${ilrFileName}].LearningDeliveryHE
end
go
 
create table [${ilrFileName}].LearningDeliveryHE (
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
go

if object_id('[${ilrFileName}].LearnerDestinationandProgression','u') is not null
begin
	drop table [${ilrFileName}].LearnerDestinationandProgression
end
go
 
create table [${ilrFileName}].LearnerDestinationandProgression (
	LearnRefNumber varchar(12) not null,
	ULN bigint not null,
	primary key clustered (
		LearnRefNumber asc
	)
)
go

INSERT INTO [${ilrFileName}].LearnerDestinationandProgression
SELECT * FROM Valid.LearnerDestinationandProgression
go

if object_id('[${ilrFileName}].DPOutcome','u') is not null
begin
	drop table [${ilrFileName}].DPOutcome
end
go
 
create table [${ilrFileName}].DPOutcome (
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
go