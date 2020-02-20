if not exists(select schema_id from sys.schemas where name='Reference')	
	exec('create schema [Reference]')
go

if object_id('[Reference].[EligibilityRule]','u') is not null
	drop table [Reference].[EligibilityRule]
go

create table [Reference].[EligibilityRule]
(
	[Benefits] bit,
	[LotReference] varchar(100) not null,
	[MaxAge] int,
	[MaxLengthOfUnemployment] int,
	[MaxPriorAttainment] varchar(2),
	[MinAge] int,
	[MinLengthOfUnemployment] int,
	[MinPriorAttainment] varchar(2),
	[TenderSpecificationReference] varchar(100) not null
)
create clustered index IX_EligibilityRule on [Reference].[EligibilityRule]
(
	[LotReference],
	[TenderSpecificationReference]
)
go

if object_id('[Reference].[EligibilityRuleEmploymentStatus]','u') is not null
	drop table [Reference].[EligibilityRuleEmploymentStatus]
go

create table [Reference].[EligibilityRuleEmploymentStatus]
(
	[LotReference] varchar(100) not null,
	[TenderSpecificationReference] varchar(100) not null,
	[EmploymentStatusCode] int not null
)
create clustered index IX_EligibilityRuleEmploymentStatus on [Reference].[EligibilityRuleEmploymentStatus]
(
	[LotReference],
	[TenderSpecificationReference]
)
go

if object_id('[Reference].[EligibilityRuleLocalAuthority]','u') is not null
	drop table [Reference].[EligibilityRuleLocalAuthority]
go

create table [Reference].[EligibilityRuleLocalAuthority]
(
	[LotReference] varchar(100) not null,
	[TenderSpecificationReference] varchar(100) not null,
	[LocalAuthorityCode] varchar(255) not null
)
create clustered index IX_EligibilityRuleLocalAuthority on [Reference].[EligibilityRuleLocalAuthority]
(
	[LotReference],
	[TenderSpecificationReference]
)
go

if object_id('[Reference].[EligibilityRuleLocalEnterprisePartnership]','u') is not null
	drop table [Reference].[EligibilityRuleLocalEnterprisePartnership]
go

create table [Reference].[EligibilityRuleLocalEnterprisePartnership]
(
	[LotReference] varchar(100) not null,
	[TenderSpecificationReference] varchar(100) not null,
	[LocalEnterprisePartnershipCode] varchar(255) not null
)
create clustered index IX_EligibilityRuleLocalEnterprisePartnership on [Reference].[EligibilityRuleLocalEnterprisePartnership]
(
	[LotReference],
	[TenderSpecificationReference]
)
go

if object_id('[Reference].[EligibilityRuleSectorSubjectAreaLevel]','u') is not null
	drop table [Reference].[EligibilityRuleSectorSubjectAreaLevel]
go

create table [Reference].[EligibilityRuleSectorSubjectAreaLevel]
(
	[LotReference] varchar(100) not null,
	[TenderSpecificationReference] varchar(100) not null,
	[MaxLevelCode] varchar(1),
	[MinLevelCode] varchar(1),
	[SectorSubjectAreaCode] decimal(5,2)
)
create clustered index IX_EligibilityRuleSectorSubjectAreaLevel on [Reference].[EligibilityRuleSectorSubjectAreaLevel]
(
	[LotReference],
	[TenderSpecificationReference]
)
go

if object_id('[Reference].[Employers]','u') is not null
	drop table [Reference].[Employers]
go

create table [Reference].[Employers]
(
	[URN] int not null
)
create clustered index IX_Employers on [Reference].[Employers]
(
	[URN]
)
go

if object_id('[Reference].[LARS_Framework]','u') is not null
	drop table [Reference].[LARS_Framework]
go

create table [Reference].[LARS_Framework]
(
	[EffectiveTo] date,
	[FworkCode] int not null,
	[ProgType] int not null,
	[PwayCode] int not null
)
create clustered index IX_LARS_Framework on [Reference].[LARS_Framework]
(
	[FworkCode],
	[ProgType],
	[PwayCode]
)
go

if object_id('[Reference].[LARS_LearningDeliveryCategory_Children]','u') is not null
	drop table [Reference].[LARS_LearningDeliveryCategory_Children]
go

create table [Reference].[LARS_LearningDeliveryCategory_Children]
(
	[CategoryRef] int,
	[ParentCategoryRef] int,
	[RootCategoryRef] int
)
create clustered index IX_LARS_LearningDeliveryCategory_Children on [Reference].[LARS_LearningDeliveryCategory_Children]
(
	[CategoryRef]
)
go

if object_id('[Reference].[LARS_LearningDeliveryCategory_TopMostCategory]','u') is not null
	drop table [Reference].[LARS_LearningDeliveryCategory_TopMostCategory]
go

create table [Reference].[LARS_LearningDeliveryCategory_TopMostCategory]
(
	[CategoryRef] int,
	[LearnAimRef] varchar(8)
)
create clustered index IX_LARS_LearningDeliveryCategory_TopMostCategory on [Reference].[LARS_LearningDeliveryCategory_TopMostCategory]
(
	[CategoryRef],
	[LearnAimRef]
)
go

if object_id('[Reference].[LARS_Section96]','u') is not null
	drop table [Reference].[LARS_Section96]
go

create table [Reference].[LARS_Section96]
(
	[LearnAimRef] varchar(8) not null,
	[Section96ApprovalStatus] int,
	[Section96ReviewDate] date,
	[Section96Valid16to18] int
)
create clustered index IX_LARS_Section96 on [Reference].[LARS_Section96]
(
	[LearnAimRef]
)
go

if object_id('[Reference].[LARS_Standard]','u') is not null
	drop table [Reference].[LARS_Standard]
go

create table [Reference].[LARS_Standard]
(
	[EffectiveTo] date,
	[StandardCode] int not null,
	[NotionalEndLevel] varchar(5)
)
create clustered index IX_LARS_Standard on [Reference].[LARS_Standard]
(
	[StandardCode]
)
go

if object_id('[Reference].[ONS_Postcode]','u') is not null
	drop table [Reference].[ONS_Postcode]
go

create table [Reference].[ONS_Postcode]
(
	[doterm] varchar(6),
	[EffectiveFrom] date not null,
	[EffectiveTo] date,
	[lep1] varchar(9),
	[lep2] varchar(9),
	[oslaua] varchar(9),
	[pcds] varchar(8) not null
)
create clustered index IX_ONS_Postcode on [Reference].[ONS_Postcode]
(
	[EffectiveFrom],
	[pcds]
)	
go
					
if object_id('[Reference].[Org_Details]','u') is not null
	drop table [Reference].[Org_Details]
go

create table [Reference].[Org_Details]
(
	[LegalOrgType] varchar(50),
	[ThirdSector] int,
	[UKPRN] bigint not null
)
create clustered index IX_Org_Details on [Reference].[Org_Details]
(
	[UKPRN]
)
go

if object_id('[Reference].[Org_HMPP_PostCode]','u') is not null
	drop table [Reference].[Org_HMPP_PostCode]
go

create table [Reference].[Org_HMPP_PostCode]
(
	[EffectiveFrom] date not null,
	[HMPPPostCode] varchar(15) not null,
	[UKPRN] bigint not null
)
create clustered index IX_Org_HMPP_PostCode on [Reference].[Org_HMPP_PostCode]
(
	[EffectiveFrom],
	[HMPPPostCode],
	[UKPRN]
)
go

if object_id('[Reference].[Org_PartnerUKPRN]','u') is not null
	drop table [Reference].[Org_PartnerUKPRN]
go

create table [Reference].[Org_PartnerUKPRN]
(
	[UKPRN] bigint not null
)
create clustered index IX_Org_PartnerUKPRN on [Reference].[Org_PartnerUKPRN]
(
	[UKPRN]
)	
go

if object_id('[Reference].[Org_PMUKPRN]','u') is not null
	drop table [Reference].[Org_PMUKPRN]
go

create table [Reference].[Org_PMUKPRN]
(
	[UKPRN] bigint not null
)
create clustered index IX_Org_PMUKPRN on [Reference].[Org_PMUKPRN]
(
	[UKPRN]
)	
go

if object_id('[Reference].[Postcodes]','u') is not null
	drop table [Reference].[Postcodes]
go

create table [Reference].[Postcodes]
(
	[Postcode] nvarchar(8) not null
)
create clustered index IX_Postcodes on [Reference].[Postcodes]
(
	[Postcode]
)
go

if object_id('[Reference].[UniqueLearnerNumbers]','u') is not null
	drop table [Reference].[UniqueLearnerNumbers]
go

create table [Reference].[UniqueLearnerNumbers]
(
	[ULN] bigint primary key
)
go

if object_id('[Reference].[vw_ContractAllocation]','u') is not null
	drop table [Reference].[vw_ContractAllocation]
go

create table [Reference].[vw_ContractAllocation]
(
	[contractAllocationNumber] nvarchar(100),
	[startDate] nvarchar(100)
)
create clustered index IX_vw_ContractAllocation on [Reference].[vw_ContractAllocation]
(
	[contractAllocationNumber]
)
go

if object_id('[Reference].[vw_ContractValidation]','u') is not null
	drop table [Reference].[vw_ContractValidation]
go

create table [Reference].[vw_ContractValidation]
(
	[contractAllocationNumber] nvarchar(100),
	[fundingStreamPeriodCode] nvarchar(100),
	[startDate] nvarchar(100),
	[UKPRN] int
)
create clustered index IX_vw_ContractValidation on [Reference].[vw_ContractValidation]
(
	[contractAllocationNumber],
	[fundingStreamPeriodCode],
	[startDate],
	[UKPRN]
)
go

if object_id ('Reference.[EPAOrganisation]', 'u') is not null
begin
	drop table Reference.EPAOrganisation
end
go

CREATE TABLE [Reference].[EPAOrganisation](
	[EPAOrgId] [nvarchar](100) NOT NULL,	
	[Name] [nvarchar](250) NULL,	
	[EffectiveFrom] [datetime] NULL,
	[EffectiveTo] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[EPAOrgId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
go
