if not exists(select schema_id from sys.schemas where name='Reference')	
begin
	exec('create schema Reference')
end
go

if object_id('Reference.CampusIdentifier','u') is not null
begin
	drop table Reference.CampusIdentifier
end
go

create table Reference.CampusIdentifier (
	CampusIdentifier varchar(8) not null,
	MasterUKPRN bigint not null,
	OriginalUKPRN bigint null,
	EffectiveFrom date not null,
	EffectiveTo date null
)
go

if object_id('Reference.CampusIdentifier_SpecialistResources','u') is not null
begin
	drop table Reference.CampusIdentifier_SpecialistResources
end
go

create table Reference.CampusIdentifier_SpecialistResources (
	CampusIdentifier varchar(8) not null,
	SpecialistResources varchar(1) not null,
	EffectiveFrom date not null,
	EffectiveTo date null
)
go

create clustered index IX_dbo_SpecialistResources on Reference.CampusIdentifier_SpecialistResources (
	CampusIdentifier,
	SpecialistResources	asc
)
go

if object_id('Reference.ContractAllocation','u') is not null
begin
	drop table Reference.ContractAllocation
end
go

create table Reference.ContractAllocation (
	ContractAllocationNumber varchar(20) not null,
	LotReference varchar(100) not null,
	TenderSpecReference varchar(100) not null
)

create clustered index IX_ContractAllocation on Reference.ContractAllocation (
	ContractAllocationNumber,
	LotReference,
	TenderSpecReference
)
go
	
if object_id('Reference.LARS_ApprenticeshipFunding','u') is not null
begin
	drop table Reference.LARS_ApprenticeshipFunding
end
go

create table Reference.LARS_ApprenticeshipFunding (
	ApprenticeshipCode int not null,
	ApprenticeshipType varchar(50) not null,
	ProgType int not null,
	PwayCode int null,
	FundingCategory varchar(15) not null,
	EffectiveFrom date not null,
	EffectiveTo date,
	BandNumber int,
	CoreGovContributuionCap decimal(10,5),
	[1618Incentive] decimal(10,5),
	[1618ProviderAdditionalPayment] decimal(10,5),
	[1618EmployerAdditionalPayment] decimal(10,5),
	[1618FrameworkUplift] decimal(10,5),
	CareLeaverAdditionalPayment decimal(10,5),
	Duration decimal(10,5),
	ReservedValue2 decimal(10,5),
	ReservedValue3 decimal(10,5), 	
	MaxEmployerLevyCap decimal(10,5),
	FundableWithoutEmployer char(1)
)

create clustered index IX_LARS_ApprenticeshipFunding on Reference.LARS_ApprenticeshipFunding (
	ApprenticeshipCode,
	ApprenticeshipType,
	EffectiveFrom,
	FundingCategory,
	ProgType,
	PwayCode
)
go

if object_id('Reference.LARS_AnnualValue','u') is not null
begin
	drop table Reference.LARS_AnnualValue
end
go

create table Reference.LARS_AnnualValue (
	BasicSkills int,
	BasicSkillsParticipation int,
	BasicSkillsType int,
	EffectiveFrom date not null,
	EffectiveTo date,
	FullLevel2EntitlementCategory int,
	FullLevel2Percent decimal(5,2),
	FullLevel3EntitlementCategory int,
	FullLevel3Percent decimal(5,2),
	LearnAimRef varchar(8) not null,
	SfaApprovalStatus int
)
go

create clustered index IX_LARS_AnnualValue on Reference.LARS_AnnualValue (
	LearnAimRef
)
go

if object_id('Reference.LARS_CareerLearningPilot','u') is not null
begin
	drop table Reference.LARS_CareerLearningPilot
end
go

create table Reference.LARS_CareerLearningPilot (
	LearnAimRef varchar(8) not null,
	AreaCode varchar(50) not null,
	EffectiveFrom date not null,
	EffectiveTo date null,
	MaxLoanAmount decimal(10, 5) null,
	SubsidyPercent decimal(10, 5) null,
	SubsidyRate decimal(10, 5) null
)
go

create clustered index IX_LARS_CareerLearningPilot on Reference.LARS_CareerLearningPilot (
	LearnAimRef asc,
	AreaCode asc,
	EffectiveFrom asc
)
go

if object_id('Reference.CareerLearningPilot_Postcode','u') is not null
begin
	drop table Reference.CareerLearningPilot_Postcode
end
go

create table Reference.CareerLearningPilot_Postcode (
	Postcode varchar(10) not null,
	AreaCode varchar(50) not null,
	EffectiveFrom date not null,
	EffectiveTo date,
)
go

create clustered index IX_CareerLearningPilot_Postcode on Reference.CareerLearningPilot_Postcode (
	Postcode,
	EffectiveFrom
)
go

if object_id('Reference.LARS_Current_Version','u') is not null
begin
	drop table Reference.LARS_Current_Version
end
go

create table Reference.LARS_Current_Version (
	CurrentVersion varchar(100)
)
go

if object_id('Reference.LARS_FrameworkAims','u') is not null
begin
	drop table Reference.LARS_FrameworkAims
end
go

create table Reference.LARS_FrameworkAims (
	EffectiveTo date,
	FrameworkComponentType int,
	FworkCode int not null,
	LearnAimRef varchar(8) not null,
	ProgType int not null,
	PwayCode int not null
)
go

create clustered index IX_LARS_FrameworkAims on Reference.LARS_FrameworkAims (
	FworkCode,
	LearnAimRef,
	ProgType,
	PwayCode
)
go

if object_id('Reference.LARS_FrameworkCmnComp','u') is not null
begin
	drop table Reference.LARS_FrameworkCmnComp
end
go

create table Reference.LARS_FrameworkCmnComp (
	CommonComponent int not null,
	FworkCode int not null,
	ProgType int not null,
	PwayCode int not null,
	EffectiveFrom date not null,
	EffectiveTo date
)
go

create clustered index IX_LARS_FrameworkCmnComp on Reference.LARS_FrameworkCmnComp (
	CommonComponent,
	FworkCode,
	ProgType,
	PwayCode
)
go

if object_id('Reference.LARS_LearningDelivery','u') is not null
begin
	drop table Reference.LARS_LearningDelivery
end
go

create table Reference.LARS_LearningDelivery (
	AwardOrgAimRef varchar(50),
	AwardOrgCode varchar(20),
	CreditBasedFwkType int,
	EFACOFType int,
	EnglandFEHEStatus char(1),
	EnglPrscID int,
	FrameworkCommonComponent int,
	GuidedLearningHours int,
	LearnAimRef varchar(8) not null,
	LearnAimRefTitle varchar(254),
	LearnAimRefType varchar(4),
	LearnDirectClassSystemCode1 varchar(12),
	LearnDirectClassSystemCode2 varchar(12),
	LearnDirectClassSystemCode3 varchar(12),
	LearningDeliveryGenre varchar(3),
	NotionalNVQLevel char(1),
	NotionalNVQLevelv2 varchar(5),
	RegulatedCreditValue int,
	SectorSubjectAreaTier1 decimal(5,2),
	SectorSubjectAreaTier2 decimal(5,2),
	UnemployedOnly int,
	UnitType varchar(50),
	EffectiveFrom date not null,
	EffectiveTo date
)
go

create clustered index IX_LARS_LearningDelivery on Reference.LARS_LearningDelivery (
	LearnAimRef
)
go

if object_id('Reference.LARS_LearningDeliveryCategory','u') is not null
begin
	drop table Reference.LARS_LearningDeliveryCategory
end
go

create table Reference.LARS_LearningDeliveryCategory (
	CategoryRef int not null,
	EffectiveFrom date not null,
	EffectiveTo date,
	LearnAimRef varchar(8) not null
)
go

create clustered index IX_LARS_LearningDeliveryCategory on Reference.LARS_LearningDeliveryCategory (
	CategoryRef,
	EffectiveFrom,
	LearnAimRef
)
go

if object_id('Reference.LARS_StandardFunding','u') is not null
begin
	drop table Reference.LARS_StandardFunding
end
go

create table Reference.LARS_StandardFunding (
	[1618Incentive] decimal(10,5),
	AchievementIncentive decimal(10,5),
	CoreGovContributionCap decimal(10,5),
	EffectiveFrom date not null,
	EffectiveTo date,
	FundableWithoutEmployer varchar(50),
	FundingCategory varchar(15) not null,
	SmallBusinessIncentive decimal(10,5),
	StandardCode int not null
)
go

create clustered index IX_LARS_StandardFunding on Reference.LARS_StandardFunding (
	EffectiveFrom,
	FundingCategory,
	StandardCode
)
go

if object_id('Reference.LARS_Validity','u') is not null
begin
	drop table Reference.LARS_Validity
end
go

create table Reference.LARS_Validity (
	EndDate date,
	LastNewStartDate date,
	LearnAimRef varchar(8) not null,
	StartDate date not null,
	ValidityCategory varchar(50) not null
)
go

create clustered index IX_LARS_Validity on Reference.LARS_Validity (
	LearnAimRef,
	StartDate,
	ValidityCategory
)
go
					
if object_id('Reference.Org_Current_Version','u') is not null
begin
	drop table Reference.Org_Current_Version
end
go

create table Reference.Org_Current_Version (
	CurrentVersion varchar(100)
)
go

if object_id('Reference.DeliverableCodeMappings','u') is not null
begin
	drop table Reference.DeliverableCodeMappings
end
go

create table Reference.DeliverableCodeMappings (
	ExternalDeliverableCode nvarchar(5),
	FCSDeliverableCode bigint,
	DeliverableName nvarchar(120),
	FundingStreamPeriodCode nvarchar(20)
)
go

create clustered index IX_DeliverableCodeMappings on Reference.DeliverableCodeMappings (
	FCSDeliverableCode,
	FundingStreamPeriodCode
)
go

if object_id('Reference.FM25_PostcodeDisadvantage','u') is not null
begin
	drop table Reference.FM25_PostcodeDisadvantage
end
go

create table Reference.FM25_PostcodeDisadvantage (
	Postcode varchar(10) not null,
	Uplift decimal(10,5) not null,
	EffectiveFrom date null,
	EffectiveTo date null
)
go

create clustered index IX_FM25_PostcodeDisadvantage on Reference.FM25_PostcodeDisadvantage (
	Postcode
)
go

if object_id('Reference.LargeEmployers','u') is not null
begin
	drop table Reference.LargeEmployers
end
go

create table Reference.LargeEmployers (
	EffectiveFrom date not null,
	EffectiveTo date,
	ERN int not null
)
go

create clustered index IX_LargeEmployers on Reference.LargeEmployers (
	EffectiveFrom,
	ERN
)
go

if object_id('Reference.LARS_Funding','u') is not null
begin
	drop table Reference.LARS_Funding
end
go

create table Reference.LARS_Funding (
	EffectiveFrom date not null,
	EffectiveTo date,
	FundingCategory varchar(15) not null,
	LearnAimRef varchar(8) not null,
	RateUnWeighted decimal(10,5),
	RateWeighted decimal(10,5),
	WeightingFactor varchar(1) not null
)
go

create clustered index IX_LARS_Funding on Reference.LARS_Funding (
	EffectiveFrom,
	FundingCategory,
	LearnAimRef
)
go

if object_id('Reference.LARS_StandardCommonComponent','u') is not null
begin
	drop table Reference.LARS_StandardCommonComponent
end
go

create table Reference.LARS_StandardCommonComponent (
	CommonComponent int not null,
	EffectiveFrom date not null,
	EffectiveTo date,
	StandardCode int not null
)
go

create clustered index IX_LARS_StandardCommonComponent on Reference.LARS_StandardCommonComponent (
	StandardCode
)
go

if object_id('Reference.Lot','u') is not null
begin
	drop table Reference.Lot
end
go

create table Reference.Lot (
	CalcMethod int,
	LotReference varchar(100) not null,
	TenderSpecificationReference varchar(100) not null
)
go

create clustered index IX_Lot on Reference.Lot (
	LotReference,
	TenderSpecificationReference
)
go

if object_id('Reference.Org_Funding','u') is not null
begin
	drop table Reference.Org_Funding
end
go

create table Reference.Org_Funding (
	EffectiveFrom date not null,
	EffectiveTo date,
	FundingFactor varchar(250) not null,
	FundingFactorType varchar(100) not null,
	FundingFactorValue varchar(250) not null,
	UKPRN bigint not null
)
go

create clustered index IX_Org_Funding on Reference.Org_Funding (
	EffectiveFrom,
	FundingFactor,
	FundingFactorType,
	UKPRN
)
go

if object_id('Reference.SFA_PostcodeAreaCost_Current_Version','u') is not null
begin
	drop table Reference.SFA_PostcodeAreaCost_Current_Version
end
go

create table Reference.SFA_PostcodeAreaCost_Current_Version (
	CurrentVersion varchar(100)
)
go

if object_id('Reference.SFA_PostcodeAreaCost','u') is not null
begin
	drop table Reference.SFA_PostcodeAreaCost
end
go

create table Reference.SFA_PostcodeAreaCost (
	AreaCostFactor decimal(10,5) not null,
	EffectiveFrom date not null,
	EffectiveTo date,
	Postcode varchar(10) not null
)
go

create clustered index IX_SFA_PostcodeAreaCost on Reference.SFA_PostcodeAreaCost (
	EffectiveFrom,
	Postcode
)
go

if object_id('Reference.SFA_PostcodeDisadvantage','u') is not null
begin
	drop table Reference.SFA_PostcodeDisadvantage
end
go

create table Reference.SFA_PostcodeDisadvantage (
	EffectiveFrom date not null,
	EffectiveTo date,
	Postcode varchar(10) not null,
	Uplift decimal(10,5) not null,
	Apprenticeship_Uplift decimal(7,2) null
)
go

create clustered index IX_SFA_PostcodeDisadvantage on Reference.SFA_PostcodeDisadvantage (
	EffectiveFrom,
	Postcode
)
go

if object_id('Reference.vw_ContractDescription','u') is not null
begin
	drop table Reference.vw_ContractDescription
end
go

create table Reference.vw_ContractDescription (
	contractAllocationNumber nvarchar(100),
	contractEndDate datetime,
	contractStartDate datetime,
	deliverableCode int,
	fundingStreamPeriodCode nvarchar(100),
	learningRatePremiumFactor decimal(13,2),
	unitCost decimal(13,2)
)
go

create clustered index IX_vw_ContractDescription on Reference.vw_ContractDescription (
	contractAllocationNumber,
	deliverableCode,
	fundingStreamPeriodCode
)
go

if object_id ('Reference.PostcodeSpecialistResourceRefData', 'u') is not null
begin
	drop table Reference.PostcodeSpecialistResourceRefData
end
go

create table Reference.PostcodeSpecialistResourceRefData (
	UKPRN bigint not null,
	PostcodeSpecResEffectiveFrom date not null,
	PostcodeSpecResEffectiveTo date,
	PostcodeSpecResPostcode varchar(10),
	PostcodeSpecResSpecialistResources varchar(1),
)
go

create clustered index IX_PostcodeSpecialistResourceRefData on Reference.PostcodeSpecialistResourceRefData (
	PostcodeSpecResPostcode,
	UKPRN
)
go

if object_id ('Reference.AEC_LatestInYearEarningHistory', 'u') is not null
begin
	drop table Reference.AEC_LatestInYearEarningHistory
end
go

create table Reference.AEC_LatestInYearEarningHistory (
	AppIdentifier varchar(50) not null,
	AppProgCompletedInTheYearInput bit null,
	CollectionYear varchar(4) not null,
	CollectionReturnCode varchar(3) not null,
	DaysInYear int null,		
	FworkCode int null,
	HistoricEffectiveTNPStartDateInput date null,
	HistoricEmpIdEndWithinYear bigint null,
	HistoricEmpIdStartWithinYear bigint null,
	HistoricLearner1618StartInput bit null,
	HistoricPMRAmount decimal(12, 5) null,
	HistoricTNP1Input decimal(12, 5) null,
	HistoricTNP2Input decimal(12,5) null,
	HistoricTNP3Input decimal(12,5) null,
	HistoricTNP4Input decimal(12,5) null,
	HistoricTotal1618UpliftPaymentsInTheYearInput decimal(12,5) null,
	HistoricVirtualTNP3EndOfTheYearInput decimal(12, 5) null,
	HistoricVirtualTNP4EndOfTheYearInput decimal(12, 5) null,
	HistoricLearnDelProgEarliestACT2DateInput date null,
	LatestInYear bit not null,
	LearnRefNumber varchar(12) not null,
	ProgrammeStartDateIgnorePathway date null,
	ProgrammeStartDateMatchPathway date null,
	ProgType int null,
	PwayCode int null,	 	
	STDCode int null,		
	TotalProgAimPaymentsInTheYear decimal(12,5),
	UptoEndDate date null,
	UKPRN int not null,
	ULN bigint not null,
	primary key (
		LatestInYear desc,
		LearnRefNumber asc,
		UKPRN asc,
		CollectionYear asc,
		CollectionReturnCode asc,
		AppIdentifier asc
	)
)
go
