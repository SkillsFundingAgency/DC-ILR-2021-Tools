if not exists(select schema_id from sys.schemas where name='Invalid')
	exec('create schema Invalid')
go
 
if object_id('Invalid.CollectionDetails','u') is not null
begin
	drop table Invalid.CollectionDetails
end
go
 
create table Invalid.CollectionDetails (
	CollectionDetails_Id int primary key,
	[Collection] varchar(3) not null,
	[Year] varchar(4) not null,
	FilePreparationDate date not null
)
go

if object_id('Invalid.Source','u') is not null
begin
	drop table Invalid.[Source]
end
go
 
create table Invalid.[Source] (
	Source_Id int primary key,
	ProtectiveMarking varchar(30) not null,
	UKPRN int not null,
	SoftwareSupplier varchar(40),
	SoftwarePackage varchar(30),
	Release varchar(20),
	SerialNo varchar(2) not null,
	[DateTime] datetime not null,
	ReferenceData varchar(100),
	ComponentSetVersion varchar(20)
)
go

if object_id('Invalid.SourceFile','u') is not null
begin
	drop table Invalid.SourceFile
end
go
 
create table Invalid.SourceFile (
	SourceFile_Id int primary key,
	SourceFileName varchar(50) not null
)
go

create index IX_Invalid_SourceFile on Invalid.SourceFile (
	SourceFileName asc
)
go

if object_id('Invalid.LearningProvider','u') is not null
begin
	drop table Invalid.LearningProvider
end
go
 
create table Invalid.LearningProvider (
	LearningProvider_Id int primary key,
	UKPRN int not null
)
go

create index IX_Invalid_LearningProvider on Invalid.LearningProvider (
	UKPRN asc
)
go

if object_id('Invalid.Learner','u') is not null
begin
	drop table Invalid.Learner
end
go
 
create table Invalid.Learner (		
	Learner_Id int primary key,
	LearnRefNumber varchar(100),
	PrevLearnRefNumber varchar(1000),
	PrevUKPRN bigint,
	PMUKPRN bigint,
	CampId varchar(8) NULL,
	ULN bigint,
	FamilyName varchar(1000),
	GivenNames varchar(1000),
	DateOfBirth date,
	Ethnicity bigint,
	Sex varchar(1000),
	LLDDHealthProb bigint,
	NINumber varchar(1000),
	PriorAttain bigint,
	Accom bigint,
	ALSCost bigint,
	PlanLearnHours bigint,
	PlanEEPHours bigint,
	MathGrade varchar(1000),
	EngGrade varchar(1000),
	PostcodePrior varchar(1000),
	Postcode varchar(1000),
	AddLine1 varchar(1000),
	AddLine2 varchar(1000),
	AddLine3 varchar(1000),
	AddLine4 varchar(1000),
	TelNo varchar(1000),
	Email varchar(1000)
)
go

create index IX_Invalid_Learner on Invalid.Learner (
	LearnRefNumber asc
)
go

if object_id('Invalid.ContactPreference','u') is not null
begin
	drop table Invalid.ContactPreference
end
go
 
create table Invalid.ContactPreference (
	ContactPreference_Id int primary key,
	Learner_Id int not null,
	LearnRefNumber varchar(100),
	ContPrefType varchar(100),
	ContPrefCode bigint
)
go

create index IX_Parent_Invalid_ContactPreference on Invalid.ContactPreference (
	Learner_Id asc
)
go

create index IX_Invalid_ContactPreference on Invalid.ContactPreference (
	LearnRefNumber asc,
	ContPrefType asc
)
go

if object_id('Invalid.LLDDandHealthProblem','u') is not null
begin
	drop table Invalid.LLDDandHealthProblem
end
go
 
create table Invalid.LLDDandHealthProblem (
	LLDDandHealthProblem_Id int primary key,
	Learner_Id int not null,
	LearnRefNumber varchar(100),
	LLDDCat bigint,
	PrimaryLLDD bigint
)
go

create index IX_Parent_Invalid_LLDDandHealthProblem on Invalid.LLDDandHealthProblem (
	Learner_Id asc
)
go

create index IX_Invalid_LLDDandHealthProblem on Invalid.LLDDandHealthProblem (
	LearnRefNumber asc,
	LLDDCat asc
)
go

if object_id('Invalid.LearnerFAM','u') is not null
begin
	drop table Invalid.LearnerFAM
end
go
 
create table Invalid.LearnerFAM (
	LearnerFAM_Id int primary key,
	Learner_Id int not null,
	LearnRefNumber varchar(100),
	LearnFAMType varchar(1000),
	LearnFAMCode bigint
)
go

create index IX_Parent_Invalid_LearnerFAM on Invalid.LearnerFAM (
	Learner_Id asc
)
go

create index IX_Invalid_LearnerFAM on Invalid.LearnerFAM (
	LearnRefNumber asc
)
go

if object_id('Invalid.ProviderSpecLearnerMonitoring','u') is not null
begin
	drop table Invalid.ProviderSpecLearnerMonitoring
end
go
 
create table Invalid.ProviderSpecLearnerMonitoring (
	ProviderSpecLearnerMonitoring_Id int primary key,
	Learner_Id int not null,
	LearnRefNumber varchar(100),
	ProvSpecLearnMonOccur varchar(100),
	ProvSpecLearnMon varchar(1000)
)
go

create index IX_Parent_Invalid_ProviderSpecLearnerMonitoring on Invalid.ProviderSpecLearnerMonitoring (
	Learner_Id asc
)
go

create index IX_Invalid_ProviderSpecLearnerMonitoring on Invalid.ProviderSpecLearnerMonitoring (
	LearnRefNumber asc,
	ProvSpecLearnMonOccur asc
)
go

if object_id('Invalid.LearnerEmploymentStatus','u') is not null
begin
	drop table Invalid.LearnerEmploymentStatus
end
go
 
create table Invalid.LearnerEmploymentStatus (
	LearnerEmploymentStatus_Id int primary key,
	Learner_Id int not null,
	LearnRefNumber varchar(100),
	EmpStat bigint,
	DateEmpStatApp date,
	EmpId bigint
)
go

create index IX_Parent_Invalid_LearnerEmploymentStatus on Invalid.LearnerEmploymentStatus (
	Learner_Id asc
)
go

create index IX_Invalid_LearnerEmploymentStatus on Invalid.LearnerEmploymentStatus (
	LearnRefNumber asc,
	DateEmpStatApp asc
)
go

if object_id('Invalid.EmploymentStatusMonitoring','u') is not null
begin
	drop table Invalid.EmploymentStatusMonitoring
end
go
 
create table Invalid.EmploymentStatusMonitoring (
	EmploymentStatusMonitoring_Id int primary key,
	LearnerEmploymentStatus_Id int not null,
	LearnRefNumber varchar(100),
	DateEmpStatApp date,
	ESMType varchar(100),
	ESMCode bigint
)
go

create index IX_Parent_Invalid_EmploymentStatusMonitoring on Invalid.EmploymentStatusMonitoring (
	LearnerEmploymentStatus_Id asc
)
go

create index IX_Invalid_EmploymentStatusMonitoring on Invalid.EmploymentStatusMonitoring (
	LearnRefNumber asc,
	DateEmpStatApp asc,
	ESMType asc
)
go

if object_id('Invalid.LearnerHE','u') is not null
begin
	drop table Invalid.LearnerHE
end
go
 
create table Invalid.LearnerHE (
	LearnerHE_Id int primary key,
	Learner_Id int not null,
	LearnRefNumber varchar(100),
	UCASPERID varchar(1000),
	TTACCOM bigint
)
go

create index IX_Parent_Invalid_LearnerHE on Invalid.LearnerHE (
	Learner_Id asc
)
go

create index IX_Invalid_LearnerHE on Invalid.LearnerHE (
	LearnRefNumber asc
)
go

if object_id('Invalid.LearnerHEFinancialSupport','u') is not null
begin
	drop table Invalid.LearnerHEFinancialSupport
end
go
 
create table Invalid.LearnerHEFinancialSupport (
	LearnerHEFinancialSupport_Id int primary key,
	LearnerHE_Id int not null,
	LearnRefNumber varchar(100),
	FINTYPE bigint,
	FINAMOUNT bigint
)
go

create index IX_Parent_Invalid_LearnerHEFinancialSupport on Invalid.LearnerHEFinancialSupport (
	LearnerHE_Id asc
)
go

create index IX_Invalid_LearnerHEFinancialSupport on Invalid.LearnerHEFinancialSupport (
	LearnRefNumber asc,
	FINTYPE asc
)
go

if object_id('Invalid.LearningDelivery','u') is not null
begin
	drop table Invalid.LearningDelivery
end
go
 
create table Invalid.LearningDelivery (
	LearningDelivery_Id int primary key,
	Learner_Id int not null,
	LearnRefNumber varchar(100),
	LearnAimRef varchar(1000),
	AimType bigint,
	AimSeqNumber bigint,
	LearnStartDate date,
	OrigLearnStartDate date,
	LearnPlanEndDate date,
	FundModel bigint,
	PHours bigint,
	OTJActHours bigint,
	ProgType bigint,
	FworkCode bigint,
	PwayCode bigint,
	StdCode bigint,
	PartnerUKPRN bigint,
	DelLocPostCode varchar(1000),
	LSDPostcode varchar(1000),
	AddHours bigint,
	PriorLearnFundAdj bigint,
	OtherFundAdj bigint,
	ConRefNumber varchar(1000),
	EPAOrgID varchar(1000),
	EmpOutcome bigint,
	CompStatus bigint,
	LearnActEndDate date,
	WithdrawReason bigint,
	Outcome bigint,
	AchDate date,
	OutGrade varchar(1000),
	SWSupAimId varchar(1000)
)
go

create index IX_Parent_Invalid_LearningDelivery on Invalid.LearningDelivery (
	Learner_Id asc
)
go

create index IX_Invalid_LearningDelivery on Invalid.LearningDelivery (
	LearnRefNumber asc,
	AimSeqNumber asc
)
go

if object_id('Invalid.LearningDeliveryFAM','u') is not null
begin
	drop table Invalid.LearningDeliveryFAM
end
go
 
create table Invalid.LearningDeliveryFAM (
	LearningDeliveryFAM_Id int primary key,
	LearningDelivery_Id int not null,
	LearnRefNumber varchar(100),
	AimSeqNumber bigint,
	LearnDelFAMType varchar(100),
	LearnDelFAMCode varchar(1000),
	LearnDelFAMDateFrom date,
	LearnDelFAMDateTo date
)
go

create index IX_Parent_Invalid_LearningDeliveryFAM on Invalid.LearningDeliveryFAM (
	LearningDelivery_Id asc
)
go

create index IX_Invalid_LearningDeliveryFAM on Invalid.LearningDeliveryFAM (
	LearnRefNumber asc,
	AimSeqNumber asc,
	LearnDelFAMType asc,
	LearnDelFAMDateFrom asc
)
go

if object_id('Invalid.LearningDeliveryWorkPlacement','u') is not null
begin
	drop table Invalid.LearningDeliveryWorkPlacement
end
go
 
create table Invalid.LearningDeliveryWorkPlacement (
	LearningDeliveryWorkPlacement_Id int primary key,
	LearningDelivery_Id int not null,
	LearnRefNumber varchar(100),
	AimSeqNumber bigint,
	WorkPlaceStartDate date,
	WorkPlaceEndDate date,
	WorkPlaceHours bigint,
	WorkPlaceMode bigint,
	WorkPlaceEmpId bigint
)
go

create index IX_Parent_Invalid_LearningDeliveryWorkPlacement on Invalid.LearningDeliveryWorkPlacement (
	LearningDelivery_Id asc
)
go

create index IX_Invalid_LearningDeliveryWorkPlacement on Invalid.LearningDeliveryWorkPlacement (
	LearnRefNumber asc,
	AimSeqNumber asc,
	WorkPlaceStartDate asc,
	WorkPlaceMode asc,
	WorkPlaceEmpId asc
)
go

if object_id('Invalid.AppFinRecord','u') is not null
begin
	drop table Invalid.AppFinRecord
end
go
 
create table Invalid.AppFinRecord (
	AppFinRecord_Id int primary key,
	LearningDelivery_Id int not null,
	LearnRefNumber varchar(100),
	AimSeqNumber bigint,
	AFinType varchar(100),
	AFinCode bigint,
	AFinDate date,
	AFinAmount bigint
)
go

create index IX_Parent_Invalid_AppFinRecord on Invalid.AppFinRecord (
	LearningDelivery_Id asc
)
go

create index IX_Invalid_AppFinRecord on Invalid.AppFinRecord (
	LearnRefNumber asc,
	AimSeqNumber asc,
	AFinType asc
)
go

if object_id('Invalid.ProviderSpecDeliveryMonitoring','u') is not null
begin
	drop table Invalid.ProviderSpecDeliveryMonitoring
end 
go
 
create table Invalid.ProviderSpecDeliveryMonitoring (
	ProviderSpecDeliveryMonitoring_Id int primary key,
	LearningDelivery_Id int not null,
	LearnRefNumber varchar(100),
	AimSeqNumber bigint,
	ProvSpecDelMonOccur varchar(100),
	ProvSpecDelMon varchar(1000)
)
go

create index IX_Parent_Invalid_ProviderSpecDeliveryMonitoring on Invalid.ProviderSpecDeliveryMonitoring (
	LearningDelivery_Id asc
)
go

create index IX_Invalid_ProviderSpecDeliveryMonitoring on Invalid.ProviderSpecDeliveryMonitoring (
	LearnRefNumber asc,
	AimSeqNumber asc,
	ProvSpecDelMonOccur asc
)
go

if object_id('Invalid.LearningDeliveryHE','u') is not null
begin
	drop table Invalid.LearningDeliveryHE
end
go
 
create table Invalid.LearningDeliveryHE (
	LearningDeliveryHE_Id int primary key,
	LearningDelivery_Id int not null,
	LearnRefNumber varchar(100),
	AimSeqNumber bigint,
	NUMHUS varchar(1000),
	SSN varchar(1000),
	QUALENT3 varchar(1000),
	SOC2000 bigint,
	SEC bigint,
	UCASAPPID varchar(1000),
	TYPEYR bigint,
	MODESTUD bigint,
	FUNDLEV bigint,
	FUNDCOMP bigint,
	STULOAD float,
	YEARSTU bigint,
	MSTUFEE bigint,
	PCOLAB float,
	PCFLDCS float,
	PCSLDCS float,
	PCTLDCS float,
	SPECFEE bigint,
	NETFEE bigint,
	GROSSFEE bigint,
	DOMICILE varchar(1000),
	ELQ bigint,
	HEPostCode varchar(1000)
)
go

create index IX_Parent_Invalid_LearningDeliveryHE on Invalid.LearningDeliveryHE (
	LearningDelivery_Id asc
)
go

create index IX_Invalid_LearningDeliveryHE on Invalid.LearningDeliveryHE (
	LearnRefNumber asc,
	AimSeqNumber asc
)
go

if object_id('Invalid.LearnerDestinationandProgression','u') is not null
begin
	drop table Invalid.LearnerDestinationandProgression
end
go
 
create table Invalid.LearnerDestinationandProgression (
	LearnerDestinationandProgression_Id int primary key,
	LearnRefNumber varchar(100),
	ULN bigint
)
go

create index IX_Invalid_LearnerDestinationandProgression on Invalid.LearnerDestinationandProgression (
	LearnRefNumber asc
)
go

if object_id('Invalid.DPOutcome','u') is not null
begin
	drop table Invalid.DPOutcome
end
go
 
create table Invalid.DPOutcome (
	DPOutcome_Id int primary key,
	LearnerDestinationandProgression_Id int not null,
	LearnRefNumber varchar(100),
	OutType varchar(100),
	OutCode bigint,
	OutStartDate date,
	OutEndDate date,
	OutCollDate date
)
go

create index IX_Parent_Invalid_DPOutcome on Invalid.DPOutcome (
	LearnerDestinationandProgression_Id asc
)
go

create index IX_Invalid_DPOutcome on Invalid.DPOutcome (
	LearnRefNumber asc,
	OutType asc,
	OutCode asc,
	OutStartDate asc
)
go
