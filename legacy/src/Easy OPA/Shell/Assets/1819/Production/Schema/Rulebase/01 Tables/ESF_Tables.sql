if not exists(select schema_id from sys.schemas where name='Rulebase')
begin
	exec('create schema Rulebase')
end
go

if object_id('Rulebase.ESF_Cases','u') is not null
begin
	drop table Rulebase.ESF_Cases
end
go

create table Rulebase.ESF_Cases (
	LearnRefNumber varchar(12),
	CaseData xml not null
)
go

if object_id('Rulebase.ESF_global','u') is not null
begin
	drop table Rulebase.ESF_global
end
go

create table Rulebase.ESF_global (
	UKPRN int,
	RulebaseVersion varchar(10),
)
go

if object_id('Rulebase.ESF_LearningDelivery','u') is not null
begin
	drop table Rulebase.ESF_LearningDelivery
end
go

create table Rulebase.ESF_LearningDelivery (
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
	LearnDelLearnerEmpAtStart bit,
	FundStart bit,
	LARSWeightedRate decimal(10,5),
	LatestPossibleStartDate date,
	LDESFEngagementStartDate date,
	PotentiallyEligibleForProgression bit,
	ProgressionEndDate date,
	[Restart] bit,
	WeightedRateFromESOL decimal(10,5)
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

if object_id('Rulebase.ESF_LearningDeliveryDeliverable','u') is not null
begin
	drop table Rulebase.ESF_LearningDeliveryDeliverable
end
go

create table Rulebase.ESF_LearningDeliveryDeliverable (
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	DeliverableCode varchar(5),
	DeliverableUnitCost decimal(10,5),
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc,
		DeliverableCode asc
	)
)
go

if object_id('Rulebase.ESF_LearningDeliveryDeliverable_Period','u') is not null
begin
	drop table Rulebase.ESF_LearningDeliveryDeliverable_Period
end
go

create table Rulebase.ESF_LearningDeliveryDeliverable_Period (
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
		AimSeqNumber asc,
		DeliverableCode asc,
		Period asc
	)
)
go

if object_id('Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues','u') is not null
begin
	drop table Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues
end
go

create table Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues (
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	DeliverableCode varchar(5),
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
		AimSeqNumber asc,
		DeliverableCode asc,
		AttributeName asc
	)
)
go

if object_id('Rulebase.ESF_DPOutcome','u') is not null
begin
	drop table Rulebase.ESF_DPOutcome
end
go

create table Rulebase.ESF_DPOutcome (
	LearnRefNumber varchar(12),
	OutCode int,
	OutType varchar(30),
	OutStartDate date,
	OutcomeDateForProgression date,
	PotentialESFProgressionType bit,
	ProgressionType varchar(50),
	ReachedSixMonthPoint bit,
	ReachedThreeMonthPoint bit,
	ReachedTwelveMonthPoint bit
	primary key clustered (
		LearnRefNumber asc,
		OutCode asc,
		OutType asc,
		OutStartDate asc
	)
)
go

if object_id('[Rulebase].[ESF_LearnerEmploymentStatus]','u') is not null
	drop table [Rulebase].[ESF_LearnerEmploymentStatus]
create table [Rulebase].[ESF_LearnerEmploymentStatus] (
		[LearnRefNumber] varchar(12),
		[LearnDelLearnerEmpAtStart] bit,
		primary key clustered
		(
			[LearnRefNumber] asc
		)
	)
go