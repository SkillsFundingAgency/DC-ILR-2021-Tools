truncate table Reference.CampusIdentifier
insert into Reference.CampusIdentifier (
	CampusIdentifier,
	MasterUKPRN,
	OriginalUKPRN,
	EffectiveFrom,
	EffectiveTo
)
select	distinct
		CI.CampusIdentifier,
		CI.MasterUKPRN,
		CI.OriginalUKPRN,
		CI.EffectiveFrom,
		CI.EffectiveTo
from	${Campus_Identifier_Reference_Data.FQ}.dbo.CampusIdentifier as CI
			join ${runmode.inputsource}.Learner as L
				on CI.CampusIdentifier = L.CampId
go

truncate table Reference.CampusIdentifier_SpecialistResources
insert into Reference.CampusIdentifier_SpecialistResources (
	CampusIdentifier,
	EffectiveFrom,
	EffectiveTo,
	SpecialistResources
)
select	distinct
		CI.CampusIdentifier,
		CI.EffectiveFrom,
		CI.EffectiveTo,
		CI.SpecialistResources
from	${Campus_Identifier_Reference_Data.FQ}.dbo.SpecialistResources as CI
			join ${runmode.inputsource}.Learner as L
				on CI.CampusIdentifier = L.CampId
go

truncate table Reference.LARS_Current_Version
insert into Reference.LARS_Current_Version (
	CurrentVersion
)
select	distinct
		CurrentVersion
from	[${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_Current_Version]
go

truncate table Reference.Org_Current_Version
insert into Reference.Org_Current_Version (
	CurrentVersion
)
select	distinct
		Org_Current_Version.CurrentVersion
from	[${ORG.FullyQualified}].[${Org.Schemaname}].[Org_Current_Version]
go

truncate table Reference.LARS_Validity
insert into Reference.LARS_Validity (
	EndDate,
	LastNewStartDate,
	LearnAimRef,
	StartDate,
	ValidityCategory
)
select	distinct
		LARS_Validity.EndDate,
		LARS_Validity.LastNewStartDate,
		LARS_Validity.LearnAimRef,
		LARS_Validity.StartDate,
		LARS_Validity.ValidityCategory
from	Valid.LearningDelivery
			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_Validity]
				on LARS_Validity.LearnAimRef = LearningDelivery.LearnAimRef
go 

truncate table Reference.LARS_LearningDelivery
insert into Reference.LARS_LearningDelivery (
	AwardOrgAimRef,
	AwardOrgCode,
	CreditBasedFwkType,
	EFACOFType,
	EnglandFEHEStatus,
	EnglPrscID,
	FrameworkCommonComponent,
	LearnAimRef,
	LearnAimRefTitle,
	LearnAimRefType,
	LearnDirectClassSystemCode1,
	LearnDirectClassSystemCode2,
	LearnDirectClassSystemCode3,
	LearningDeliveryGenre,
	NotionalNVQLevel,
	NotionalNVQLevelv2,
	RegulatedCreditValue,
	SectorSubjectAreaTier1,
	SectorSubjectAreaTier2,
	UnemployedOnly,
	UnitType,
	EffectiveFrom
)
select	distinct
		LARS_LearningDelivery.AwardOrgAimRef,
		LARS_LearningDelivery.AwardOrgCode,
		LARS_LearningDelivery.CreditBasedFwkType,
		LARS_LearningDelivery.EFACOFType,
		LARS_LearningDelivery.EnglandFEHEStatus,
		LARS_LearningDelivery.EnglPrscID,
		LARS_LearningDelivery.FrameworkCommonComponent,
		LARS_LearningDelivery.LearnAimRef,
		LARS_LearningDelivery.LearnAimRefTitle,
		LARS_LearningDelivery.LearnAimRefType,
		LARS_LearningDelivery.LearnDirectClassSystemCode1,
		LARS_LearningDelivery.LearnDirectClassSystemCode2,
		LARS_LearningDelivery.LearnDirectClassSystemCode3,
		LARS_LearningDelivery.LearningDeliveryGenre,
		LARS_LearningDelivery.NotionalNVQLevel,
		LARS_LearningDelivery.NotionalNVQLevelv2,
		LARS_LearningDelivery.RegulatedCreditValue,
		LARS_LearningDelivery.SectorSubjectAreaTier1,
		LARS_LearningDelivery.SectorSubjectAreaTier2,
		LARS_LearningDelivery.UnemployedOnly,
		LARS_LearningDelivery.UnitType,
		LARS_LearningDelivery.EffectiveFrom
from	Valid.LearningDelivery
			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_LearningDelivery]
				on LARS_LearningDelivery.LearnAimRef = LearningDelivery.LearnAimRef
go

truncate table Reference.FM25_PostcodeDisadvantage
insert into Reference.FM25_PostcodeDisadvantage
select	distinct
		PFRD_PC_Disadvantage.Postcode,
		PFRD_PC_Disadvantage.Uplift,
		PFRD_PC_Disadvantage.EffectiveFrom,
		PFRD_PC_Disadvantage.EffectiveTo
from	Valid.Learner
			inner join [${PostcodeFactorsReferenceData.FullyQualified}].[${PostcodeFactorsReferenceData.schemaname}].[EFA_PostcodeDisadvantage] as PFRD_PC_Disadvantage
				on PFRD_PC_Disadvantage.Postcode = Learner.Postcode
go


truncate table Reference.Org_Funding
insert into Reference.Org_Funding
select	distinct
		Org_Funding.EffectiveFrom,
		Org_Funding.EffectiveTo,
		Org_Funding.FundingFactor,
		Org_Funding.FundingFactorType,
		Org_Funding.FundingFactorValue,
		Org_Funding.UKPRN
from	Valid.LearningProvider
			inner join [${ORG.FullyQualified}].[${Org.Schemaname}].[Org_Funding]
				on Org_Funding.UKPRN = LearningProvider.UKPRN
go

