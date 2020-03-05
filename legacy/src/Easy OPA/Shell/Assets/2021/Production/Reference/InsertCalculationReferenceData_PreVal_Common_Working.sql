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

truncate table Reference.LARS_AnnualValue
insert into Reference.LARS_AnnualValue (
	BasicSkills,
	BasicSkillsParticipation,
	BasicSkillsType,
	EffectiveFrom,
	EffectiveTo,
	FullLevel2EntitlementCategory,
	FullLevel2Percent,
	FullLevel3EntitlementCategory,
	FullLevel3Percent,
	LearnAimRef,
	SfaApprovalStatus
)
select	distinct
		LARS_AnnualValue.BasicSkills,
		LARS_AnnualValue.BasicSkillsParticipation,
		LARS_AnnualValue.BasicSkillsType,
		LARS_AnnualValue.EffectiveFrom,
		LARS_AnnualValue.EffectiveTo,
		LARS_AnnualValue.FullLevel2EntitlementCategory,
		LARS_AnnualValue.FullLevel2Percent,
		LARS_AnnualValue.FullLevel3EntitlementCategory,
		LARS_AnnualValue.FullLevel3Percent,
		LARS_AnnualValue.LearnAimRef,
		LARS_AnnualValue.SfaApprovalStatus
from	${runmode.inputsource}.LearningDelivery
			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_AnnualValue]
				on LARS_AnnualValue.LearnAimRef = LearningDelivery.LearnAimRef
go

truncate table Reference.LARS_Current_Version
insert into Reference.LARS_Current_Version (
	CurrentVersion
)
select	distinct
		CurrentVersion
from	[${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_Current_Version]
go

truncate table Reference.SFA_PostcodeAreaCost_Current_Version
insert into Reference.SFA_PostcodeAreaCost_Current_Version (
	CurrentVersion
)
select	CurrentVersion
from	[${PostcodeFactorsReferenceData.FullyQualified}].[${PostcodeFactorsReferenceData.schemaname}].[PostCode_Current_Version]
go

truncate table Reference.LARS_CareerLearningPilot
insert into Reference.LARS_CareerLearningPilot (
	LearnAimRef,
	AreaCode,
	EffectiveFrom,
	EffectiveTo,
	MaxLoanAmount,
	SubsidyPercent,
	SubsidyRate
)
select	LearnAimRef,
		AreaCode,
		EffectiveFrom,
		EffectiveTo,
		MaxLoanAmount,
		SubsidyPercent,
		SubsidyRate
from	[${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_CareerLearningPilot]
go

truncate table Reference.CareerLearningPilot_Postcode
insert into Reference.CareerLearningPilot_Postcode (
	Postcode,
	AreaCode,
	EffectiveFrom,
	EffectiveTo 
)
select	Postcode,
		AreaCode,
		EffectiveFrom,
		EffectiveTo 
from	[${PostcodeFactorsReferenceData.FullyQualified}].[${PostcodeFactorsReferenceData.schemaname}].[CareerLearningPilot_Postcode]
go

truncate table Reference.LARS_FrameworkAims
insert into Reference.LARS_FrameworkAims (
	EffectiveTo,
	FrameworkComponentType,
	FworkCode,
	LearnAimRef,
	ProgType,
	PwayCode
)
select	distinct
		LARS_FrameworkAims.EffectiveTo,
		LARS_FrameworkAims.FrameworkComponentType,
		LARS_FrameworkAims.FworkCode,
		LARS_FrameworkAims.LearnAimRef,
		LARS_FrameworkAims.ProgType,
		LARS_FrameworkAims.PwayCode
from	${runmode.inputsource}.LearningDelivery
			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_FrameworkAims]
				on LARS_FrameworkAims.FworkCode = LearningDelivery.FworkCode
				and LARS_FrameworkAims.ProgType = LearningDelivery.ProgType
				and LARS_FrameworkAims.PwayCode = LearningDelivery.PwayCode
				and LARS_FrameworkAims.LearnAimRef = LearningDelivery.LearnAimRef
go
 
truncate table Reference.LARS_FrameworkCmnComp
insert into Reference.LARS_FrameworkCmnComp (
	CommonComponent,
	EffectiveFrom,
	EffectiveTo,
	FworkCode,
	ProgType,
	PwayCode
)
select	distinct
		LARS_FrameworkCmnComp.CommonComponent,
		LARS_FrameworkCmnComp.EffectiveFrom,
		LARS_FrameworkCmnComp.EffectiveTo,
		LARS_FrameworkCmnComp.FworkCode,
		LARS_FrameworkCmnComp.ProgType,
		LARS_FrameworkCmnComp.PwayCode
from	[${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_FrameworkCmnComp]
			inner merge join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_LearningDelivery]
				on LARS_FrameworkCmnComp.CommonComponent = LARS_LearningDelivery.FrameworkCommonComponent
			inner join ${runmode.inputsource}.LearningDelivery
				on LARS_LearningDelivery.LearnAimRef = LearningDelivery.LearnAimRef
				and LARS_FrameworkCmnComp.FworkCode = LearningDelivery.FworkCode
				and LARS_FrameworkCmnComp.ProgType = LearningDelivery.ProgType
				and LARS_FrameworkCmnComp.PwayCode = LearningDelivery.PwayCode
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
from	${runmode.inputsource}.LearningDelivery
			inner join [${LARS.schemaname}].[LARS_LearningDelivery]
				on LARS_LearningDelivery.LearnAimRef = LearningDelivery.LearnAimRef
go
 
truncate table Reference.LARS_StandardFunding
insert into Reference.LARS_StandardFunding (
	[1618Incentive],
	AchievementIncentive,
	CoreGovContributionCap,
	EffectiveFrom,
	EffectiveTo,
	FundableWithoutEmployer,
	FundingCategory,
	SmallBusinessIncentive,
	StandardCode
)
select	distinct
		LARS_StandardFunding.[1618Incentive],
		LARS_StandardFunding.AchievementIncentive,
		LARS_StandardFunding.CoreGovContributionCap,
		LARS_StandardFunding.EffectiveFrom,
		LARS_StandardFunding.EffectiveTo,
		LARS_StandardFunding.FundableWithoutEmployer,
		LARS_StandardFunding.FundingCategory,
		LARS_StandardFunding.SmallBusinessIncentive,
		LARS_StandardFunding.StandardCode
from	${runmode.inputsource}.LearningDelivery
			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_StandardFunding]
				on LARS_StandardFunding.StandardCode = LearningDelivery.StdCode
				and LARS_StandardFunding.FundingCategory = 'StandardTblazer'
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
from	${runmode.inputsource}.LearningDelivery
			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_Validity]
				on LARS_Validity.LearnAimRef = LearningDelivery.LearnAimRef
go 

truncate table Reference.Org_Current_Version
insert into Reference.Org_Current_Version (
	CurrentVersion
)
select	distinct
		Org_Current_Version.CurrentVersion
from	[${ORG.FullyQualified}].[${Org.Schemaname}].[Org_Current_Version]
go
 
truncate table Reference.LARS_ApprenticeshipFunding
insert into Reference.LARS_ApprenticeshipFunding (
	ApprenticeshipCode,
	ApprenticeshipType,
	ProgType,
	PwayCode,
	FundingCategory,
	EffectiveFrom,
	EffectiveTo,
	BandNumber,
	CoreGovContributuionCap,
	[1618Incentive],
	[1618ProviderAdditionalPayment],
	[1618EmployerAdditionalPayment],
	[1618FrameworkUplift],
	CareLeaverAdditionalPayment,
	Duration,
	ReservedValue2,
	ReservedValue3,
	MaxEmployerLevyCap,
	FundableWithoutEmployer
)
select	LARS_ApprenticeshipFunding.ApprenticeshipCode,
		LARS_ApprenticeshipFunding.ApprenticeshipType,
		LARS_ApprenticeshipFunding.ProgType,
		LARS_ApprenticeshipFunding.PwayCode,
		LARS_ApprenticeshipFunding.FundingCategory,
		LARS_ApprenticeshipFunding.EffectiveFrom,
		LARS_ApprenticeshipFunding.EffectiveTo,
		LARS_ApprenticeshipFunding.BandNumber,
		LARS_ApprenticeshipFunding.CoreGovContributionCap,
		LARS_ApprenticeshipFunding.[1618Incentive],
		LARS_ApprenticeshipFunding.[1618ProviderAdditionalPayment],
		LARS_ApprenticeshipFunding.[1618EmployerAdditionalPayment],
		LARS_ApprenticeshipFunding.[1618FrameworkUplift],
		LARS_ApprenticeshipFunding.CareLeaverAdditionalPayment,
		LARS_ApprenticeshipFunding.Duration,
		LARS_ApprenticeshipFunding.ReservedValue2,
		LARS_ApprenticeshipFunding.ReservedValue3,
		LARS_ApprenticeshipFunding.MaxEmployerLevyCap,
		LARS_ApprenticeshipFunding.FundableWithoutEmployer
from	${runmode.inputsource}.LearningDelivery
			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_ApprenticeshipFunding]
				on LARS_ApprenticeshipFunding.ApprenticeshipType = 'STD'
				and LARS_ApprenticeshipFunding.ApprenticeshipCode = LearningDelivery.StdCode
				and LARS_ApprenticeshipFunding.ProgType = LearningDelivery.ProgType
				and LARS_ApprenticeshipFunding.PwayCode = 0
union
select	LARS_ApprenticeshipFunding.ApprenticeshipCode,
		LARS_ApprenticeshipFunding.ApprenticeshipType,
		LARS_ApprenticeshipFunding.ProgType,
		LARS_ApprenticeshipFunding.PwayCode,
		LARS_ApprenticeshipFunding.FundingCategory,
		LARS_ApprenticeshipFunding.EffectiveFrom,
		LARS_ApprenticeshipFunding.EffectiveTo,
		LARS_ApprenticeshipFunding.BandNumber,
		LARS_ApprenticeshipFunding.CoreGovContributionCap,
		LARS_ApprenticeshipFunding.[1618Incentive],
		LARS_ApprenticeshipFunding.[1618ProviderAdditionalPayment],
		LARS_ApprenticeshipFunding.[1618EmployerAdditionalPayment],
		LARS_ApprenticeshipFunding.[1618FrameworkUplift],
		LARS_ApprenticeshipFunding.CareLeaverAdditionalPayment,
		LARS_ApprenticeshipFunding.Duration,
		LARS_ApprenticeshipFunding.ReservedValue2,
		LARS_ApprenticeshipFunding.ReservedValue3,
		LARS_ApprenticeshipFunding.MaxEmployerLevyCap,
		LARS_ApprenticeshipFunding.FundableWithoutEmployer
from	${runmode.inputsource}.LearningDelivery
			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_ApprenticeshipFunding]
				on LARS_ApprenticeshipFunding.ApprenticeshipType = 'FWK'
				and LARS_ApprenticeshipFunding.ApprenticeshipCode = LearningDelivery.FworkCode
				and LARS_ApprenticeshipFunding.ProgType = LearningDelivery.ProgType
				and LARS_ApprenticeshipFunding.PwayCode = LearningDelivery.PwayCode
go

truncate table Reference.LARS_StandardCommonComponent
insert into Reference.LARS_StandardCommonComponent (
	CommonComponent,
	EffectiveFrom,
	EffectiveTo,
	StandardCode
)
select	distinct
		LARS_StandardCommonComponent.CommonComponent,
		LARS_StandardCommonComponent.EffectiveFrom,
		LARS_StandardCommonComponent.EffectiveTo,
		LARS_StandardCommonComponent.StandardCode
from	${runmode.inputsource}.LearningDelivery
			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_StandardCommonComponent]
				on LARS_StandardCommonComponent.StandardCode = LearningDelivery.StdCode
go
