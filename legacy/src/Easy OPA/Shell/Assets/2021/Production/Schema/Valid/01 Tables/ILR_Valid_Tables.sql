if not exists(select schema_id from sys.schemas where name='Valid')
 exec('create schema Valid')
go

if object_id('Valid.CollectionDetails','u') is not null
begin
	drop table Valid.CollectionDetails
end
go

create table Valid.CollectionDetails (
    [UKPRN] int not null,
	[Collection] varchar(3) not null,
	[Year] varchar(4) not null,
	FilePreparationDate date null
)
go

if object_id('Valid.Source','u') is not null
begin
	drop table Valid.[Source]
end
go

create table Valid.[Source] (
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

if object_id('Valid.SourceFile','u') is not null
begin
	drop table Valid.SourceFile
end
go

create table Valid.SourceFile (
    [UKPRN] int not null,
	SourceFileName varchar(50) not null,
	FilePreparationDate date null,
	SoftwareSupplier varchar(40) null,
	SoftwarePackage varchar(30) null,
	Release varchar(20) null,
	SerialNo varchar(2) null,
	[DateTime] datetime null
)
go

if object_id('Valid.LearningProvider','u') is not null
begin
	drop table Valid.LearningProvider
end
go

create table Valid.LearningProvider (
	UKPRN int not null,
	primary key clustered (
		UKPRN asc
	)
)
go

if object_id('Valid.Learner','u') is not null
begin
	drop table Valid.Learner
end
go

create table Valid.Learner (
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
		UKPRN asc,
		LearnRefNumber asc
	)
)
go

if object_id('Valid.ContactPreference','u') is not null
begin
	drop table Valid.ContactPreference
end
go

create table Valid.ContactPreference (
    [UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	ContPrefType varchar(3) not null,
	ContPrefCode int not null,
	primary key (
		UKPRN asc,
		LearnRefNumber,
		ContPrefType,
		ContPrefCode
	)
)
go

if object_id('Valid.LLDDandHealthProblem','u') is not null
begin
	drop table Valid.LLDDandHealthProblem
end
go

create table Valid.LLDDandHealthProblem (
    [UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	LLDDCat int not null,
	PrimaryLLDD int null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		LLDDCat asc
	)
)
go

if object_id('Valid.LearnerFAM','u') is not null
begin
	drop table Valid.LearnerFAM
end
go

create table Valid.LearnerFAM (
    [UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	LearnFAMType varchar(3) null,
	LearnFAMCode int not null
	--primary key clustered(
	--	UKPRN asc,
	--	LearnRefNumber asc
	--)
)
go

create clustered index IX_Valid_LearnerFAM on Valid.LearnerFAM (
	LearnRefNumber asc
)
go

if object_id('Valid.ProviderSpecLearnerMonitoring','u') is not null
begin
	drop table Valid.ProviderSpecLearnerMonitoring
end
go

create table Valid.ProviderSpecLearnerMonitoring (
    [UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	ProvSpecLearnMonOccur varchar(1) not null,
	ProvSpecLearnMon varchar(20) not null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		ProvSpecLearnMonOccur asc
	)
)
go

if object_id('Valid.LearnerEmploymentStatus','u') is not null
begin
	drop table Valid.LearnerEmploymentStatus
end
go

create table Valid.LearnerEmploymentStatus (
    [UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	EmpStat int null,
	DateEmpStatApp date not null,
	EmpId bigint,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		DateEmpStatApp asc
	)
)
go

if object_id('Valid.LearnerEmploymentStatusDenormTbl','u') is not null
begin
	drop table Valid.LearnerEmploymentStatusDenormTbl
end
go

create table Valid.LearnerEmploymentStatusDenormTbl (
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
	
)
go
create clustered index IX_Valid_LearnerEmploymentStatusDenormTbl on Valid.LearnerEmploymentStatusDenormTbl (
		UKPRN asc,
		LearnRefNumber asc,
		DateEmpStatApp asc
	)
	go

if object_id('Valid.EmploymentStatusMonitoring','u') is not null
begin
	drop table Valid.EmploymentStatusMonitoring
end
go

create table Valid.EmploymentStatusMonitoring (
    [UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	DateEmpStatApp date not null,
	ESMType varchar(3) not null,
	ESMCode int null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		DateEmpStatApp asc,
		ESMType asc
	)
)
go

if object_id('Valid.LearnerHE','u') is not null
begin
	drop table Valid.LearnerHE
end
go

create table Valid.LearnerHE (
    [UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	UCASPERID varchar(10) null,
	TTACCOM int null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc
	)
)
go

if object_id('Valid.LearnerHEFinancialSupport','u') is not null
begin
	drop table Valid.LearnerHEFinancialSupport
end
go

create table Valid.LearnerHEFinancialSupport (
    [UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	FINTYPE int not null,
	FINAMOUNT int not null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		FINTYPE asc
	)
)
go

if object_id('Valid.LearningDelivery','u') is not null
begin
	drop table Valid.LearningDelivery
end
go

create table Valid.LearningDelivery (
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
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		FundModel asc
	)
)
go

create index IDX_FundModel ON Valid.LearningDelivery (
	FundModel
)
go

if object_id('Valid.LearningDeliveryDenormTbl','U') is not null
begin
	drop table Valid.LearningDeliveryDenormTbl
end
go

create table Valid.LearningDeliveryDenormTbl (
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
	--primary key clustered (
	--	UKPRN asc,
	--	LearnRefNumber asc,
	--	AimSeqNumber asc
	--)
)
go

create clustered index IX_Valid_LearningDeliveryDenormTbl on Valid.LearningDeliveryDenormTbl(
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc
)
go

if object_id('Valid.LearningDeliveryFAM','u') is not null
begin
	drop table Valid.LearningDeliveryFAM
end
go

create table Valid.LearningDeliveryFAM (
    [UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	LearnDelFAMType varchar(3) not null,
	LearnDelFAMCode varchar(5) not null,
	LearnDelFAMDateFrom date null,
	LearnDelFAMDateTo date null
	--primary key clustered(	
	--	UKPRN asc,
	--	LearnRefNumber asc,
	--	AimSeqNumber asc
	--)
)
go

create clustered index IX_Valid_LearningDeliveryFAM on Valid.LearningDeliveryFAM (
	UKPRN asc,
	LearnRefNumber asc,
	AimSeqNumber asc,
	LearnDelFAMType asc,
	LearnDelFAMDateFrom asc
)
go

if object_id('Valid.LearningDeliveryWorkPlacement','u') is not null
begin
	drop table Valid.LearningDeliveryWorkPlacement
end
go

create table Valid.LearningDeliveryWorkPlacement (
    [UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	WorkPlaceStartDate date not null,
	WorkPlaceEndDate date null,
	WorkPlaceHours int null,
	WorkPlaceMode int not null,
	WorkPlaceEmpId int null
	--primary key clustered(	
	--	UKPRN asc,
	--	LearnRefNumber asc,
	--	AimSeqNumber asc
	--)
)
go

create clustered index IX_Valid_LearningDeliveryWorkPlacement on Valid.LearningDeliveryWorkPlacement (
	LearnRefNumber asc,
	AimSeqNumber asc,
	WorkPlaceStartDate asc,
	WorkPlaceMode asc,
	WorkPlaceEmpId asc
)
go

if object_id('Valid.AppFinRecord','u') is not null
begin
	drop table Valid.AppFinRecord
end
go

create table Valid.AppFinRecord (
    [UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AFinType varchar(3) not null,
	AFinCode int not null,
	AFinDate date not null,
	AFinAmount int not null
--primary key clustered(	
--		UKPRN asc,
--		LearnRefNumber asc,
--		AimSeqNumber asc,
--		AFinType asc
--	)
)
go

create clustered index IX_Valid_AppFinRecord on Valid.AppFinRecord (
	LearnRefNumber asc,
	AimSeqNumber asc,
	AFinType asc
)
go

if object_id('Valid.ProviderSpecDeliveryMonitoring','u') is not null
begin
	drop table Valid.ProviderSpecDeliveryMonitoring
end
go

create table Valid.ProviderSpecDeliveryMonitoring (
    [UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	ProvSpecDelMonOccur varchar(1) not null,
	ProvSpecDelMon varchar(20) not null,
	primary key clustered (
	UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		ProvSpecDelMonOccur asc
	)
)
go

if object_id('Valid.LearningDeliveryHE','u') is not null
begin
	drop table Valid.LearningDeliveryHE
end
go

create table Valid.LearningDeliveryHE (
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
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

if object_id('Valid.LearnerDestinationandProgression','u') is not null
begin
	drop table Valid.LearnerDestinationandProgression
end
go

create table Valid.LearnerDestinationandProgression (
    [UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	ULN bigint not null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc
	)
)
go

if object_id('Valid.DPOutcome','u') is not null
begin
	drop table Valid.DPOutcome
end
go

create table Valid.DPOutcome (
    [UKPRN] int not null,
	LearnRefNumber varchar(12) not null,
	OutType varchar(3) not null,
	OutCode int not null,
	OutStartDate date not null,
	OutEndDate date null,
	OutCollDate date not null
	--primary key clustered(
	--	UKPRN asc,
	--	LearnRefNumber asc,
	--	OutType asc,
	--	OutCode asc,
	--	OutStartDate asc
	--)
)
go

create clustered index IX_Valid_DPOutcome on Valid.DPOutcome (
	UKPRN asc,
	LearnRefNumber asc,
	OutType asc,
	OutCode asc,
	OutStartDate asc
)
go

if object_id('Valid.File','u') is not null
begin
	drop table Valid.[File]
end
go

create table Valid.[File] (
	[UKPRN] int not null,
	[FileName] varchar(55)
	primary key(
		[FileName] asc
	)
)

INSERT INTO Valid.[File]
	SELECT 
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) as UKPRN,
	[FileName]
	FROM dbo.[File]
