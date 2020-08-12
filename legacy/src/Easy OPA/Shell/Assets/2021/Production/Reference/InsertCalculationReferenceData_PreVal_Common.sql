

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
		CI.UKPRN,
		CI.UKPRN,
		CI.EffectiveFrom,
		CI.EffectiveTo
from	ReferenceInput.Organisations_OrganisationCampusIdentifier as CI
			join Valid.Learner as L
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
		sr.EffectiveFrom,
		sr.EffectiveTo,
		sr.IsSpecialistResource
from	
ReferenceInput.Organisations_OrganisationCampusIdentifier as ci
	join Valid.Learner as L
	on CI.CampusIdentifier = L.CampId
		join ReferenceInput.Organisations_SpecialistResource as sr
			on sr.Organisations_OrganisationCampusIdentifier_Id = ci.Id
go

truncate table Reference.LARS_AnnualValue
insert into Reference.LARS_AnnualValue (
	BasicSkills,
	--BasicSkillsParticipation,
	BasicSkillsType,
	EffectiveFrom,
	EffectiveTo,
	FullLevel2EntitlementCategory,
	FullLevel2Percent,
	FullLevel3EntitlementCategory,
	FullLevel3Percent,
	LearnAimRef
	--SfaApprovalStatus
)
select	distinct
		lav.BasicSkills,
		--lav.BasicSkillsParticipation,
		lav.BasicSkillsType,
		lav.EffectiveFrom,
		lav.EffectiveTo,
		lav.FullLevel2EntitlementCategory,
		lav.FullLevel2Percent,
		lav.FullLevel3EntitlementCategory,
		lav.FullLevel3Percent,
		lav.LearnAimRef
		--lav.SfaApprovalStatus
from	Valid.LearningDelivery ld
			inner join ReferenceInput.[LARS_LARSAnnualValue] lav
				on lav.LearnAimRef = ld.LearnAimRef
go

truncate table Reference.LARS_Current_Version
insert into Reference.LARS_Current_Version (
	CurrentVersion
)
select	distinct
		[Version]
from	ReferenceInput.[MetaData_LarsVersion]
go

truncate table Reference.SFA_PostcodeAreaCost_Current_Version
insert into Reference.SFA_PostcodeAreaCost_Current_Version (
	CurrentVersion
)
select	[Version]
from	ReferenceInput.[MetaData_PostcodesVersion]
go


--truncate table Reference.LARS_CareerLearningPilot
--insert into Reference.LARS_CareerLearningPilot (
--	LearnAimRef,
--	AreaCode,
--	EffectiveFrom,
--	EffectiveTo,
--	MaxLoanAmount,
--	SubsidyPercent,
--	SubsidyRate
--)
--select	LearnAimRef,
--		AreaCode,
--		EffectiveFrom,
--		EffectiveTo,
--		MaxLoanAmount,
--		SubsidyPercent,
--		SubsidyRate
--from	[${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_CareerLearningPilot]
--go

--truncate table Reference.CareerLearningPilot_Postcode
--insert into Reference.CareerLearningPilot_Postcode (
--	Postcode,
--	AreaCode,
--	EffectiveFrom,
--	EffectiveTo 
--)
--select	Postcode,
--		AreaCode,
--		EffectiveFrom,
--		EffectiveTo 
--from	[${PostcodeFactorsReferenceData.FullyQualified}].[${PostcodeFactorsReferenceData.schemaname}].[CareerLearningPilot_Postcode]
--go

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
		lfa.EffectiveTo,
		lfa.FrameworkComponentType,
		lfa.FworkCode,
		lfa.LearnAimRef,
		lfa.ProgType,
		lfa.PwayCode
from	Valid.LearningDelivery
			inner join ReferenceInput.[LARS_LARSFrameworkAim] lfa
				on lfa.FworkCode = LearningDelivery.FworkCode
				and lfa.ProgType = LearningDelivery.ProgType
				and lfa.PwayCode = LearningDelivery.PwayCode
				and lfa.LearnAimRef = LearningDelivery.LearnAimRef
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
		lfcc.CommonComponent,
		lfcc.EffectiveFrom,
		lfcc.EffectiveTo,
		ldf.FworkCode,
		ldf.ProgType,
		ldf.PwayCode
from	ReferenceInput.LARS_LARSFrameworkCommonComponent lfcc
			inner join ReferenceInput.LARS_LARSFrameworkDesktop ldf
				on lfcc.LARS_LARSFrameworkDesktop_Id = ldf.Id
			inner join ReferenceInput.[LARS_LARSLearningDelivery] lld
				on lfcc.CommonComponent = lld.FrameworkCommonComponent
			inner join Valid.LearningDelivery
				on lld.LearnAimRef = LearningDelivery.LearnAimRef
				and ldf.FworkCode = LearningDelivery.FworkCode
				and ldf.ProgType = LearningDelivery.ProgType
				and ldf.PwayCode = LearningDelivery.PwayCode
go
 
truncate table Reference.LARS_LearningDelivery
insert into Reference.LARS_LearningDelivery (
	--AwardOrgAimRef,
	AwardOrgCode,
	--CreditBasedFwkType,
	EFACOFType,
	EnglandFEHEStatus,
	EnglPrscID,
	FrameworkCommonComponent,
	GuidedLearningHours,
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
	--UnemployedOnly,
	--UnitType,
	EffectiveFrom
)
	select	distinct
		--LLD.AwardOrgAimRef,
		LLD.AwardOrgCode,
		--LLD.CreditBasedFwkType,
		LLD.EFACOFType,
		LLD.EnglandFEHEStatus,
		LLD.EnglPrscID,
		LLD.FrameworkCommonComponent,
		LLD.GuidedLearningHours,
		LLD.LearnAimRef,
		LLD.LearnAimRefTitle,
		LLD.LearnAimRefType,
		LLD.LearnDirectClassSystemCode1,
		LLD.LearnDirectClassSystemCode2,
		LLD.LearnDirectClassSystemCode3,
		LLD.LearningDeliveryGenre,
		LLD.NotionalNVQLevel,
		LLD.NotionalNVQLevelv2,
		LLD.RegulatedCreditValue,
		LLD.SectorSubjectAreaTier1,
		LLD.SectorSubjectAreaTier2,
		--LLD.UnemployedOnly,
		--LLD.UnitType,
		LLD.EffectiveFrom
	from Valid.LearningDelivery
			inner join ReferenceInput.[LARS_LARSLearningDelivery] LLD
				on LLD.LearnAimRef = LearningDelivery.LearnAimRef
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
		LSF.SixteenToEighteenIncentive,
		LSF.AchievementIncentive,
		LSF.CoreGovContributionCap,
		LSF.EffectiveFrom,
		LSF.EffectiveTo,
		LSF.FundableWithoutEmployer,
		LSF.FundingCategory,
		LSF.SmallBusinessIncentive,
		LS.StandardCode
from	Valid.LearningDelivery
			INNER JOIN ReferenceInput.LARS_LARSStandard LS
				ON LS.StandardCode = LearningDelivery.StdCode
			INNER JOIN ReferenceInput.LARS_LARSStandardFunding LSF
				on LSF.LARS_LARSStandard_Id = LS.Id
				and LSF.FundingCategory = 'StandardTblazer'
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
		lv.EffectiveTo,
		lv.LastNewStartDate,
		lv.LearnAimRef,
		lv.EffectiveFrom,
		lv.ValidityCategory
from	Valid.LearningDelivery
			inner join ReferenceInput.[LARS_LARSValidity] lv
				on lv.LearnAimRef = LearningDelivery.LearnAimRef
go 

truncate table Reference.Org_Current_Version
insert into Reference.Org_Current_Version (
	CurrentVersion
)
select	distinct
		[Version]
from	ReferenceInput.[MetaData_OrganisationsVersion]
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
select	ls.StandardCode,
		'STD' as ApprenticeshipType,
		lsaf.ProgType,
		lsaf.PwayCode,
		lsaf.FundingCategory,
		lsaf.EffectiveFrom,
		lsaf.EffectiveTo,
		lsaf.BandNumber,
		lsaf.CoreGovContributionCap,
		lsaf.SixteenToEighteenIncentive,
		lsaf.SixteenToEighteenProviderAdditionalPayment,
		lsaf.[SixteenToEighteenEmployerAdditionalPayment],
		lsaf.SixteenToEighteenFrameworkUplift,
		lsaf.CareLeaverAdditionalPayment,
		lsaf.Duration,
		lsaf.ReservedValue2,
		lsaf.ReservedValue3,
		lsaf.MaxEmployerLevyCap,
		lsaf.FundableWithoutEmployer
from	Valid.LearningDelivery
			inner join ReferenceInput.LARS_LARSStandard ls
				on ls.StandardCode = LearningDelivery.StdCode
			inner join [ReferenceInput].[LARS_LARSStandardApprenticeshipFunding] lsaf	
				on ls.Id = lsaf.LARS_LARSStandard_Id
				and lsaf.ProgType = LearningDelivery.ProgType
				and lsaf.PwayCode = 0
union
select	ls.FworkCode,
		'FWK' as ApprenticeshipType,
		ls.ProgType,
		ls.PwayCode,
		lsaf.FundingCategory,
		lsaf.EffectiveFrom,
		lsaf.EffectiveTo,
		lsaf.BandNumber,
		lsaf.CoreGovContributionCap,
		lsaf.[SixteenToEighteenIncentive],
		lsaf.[SixteenToEighteenProviderAdditionalPayment],
		lsaf.[SixteenToEighteenEmployerAdditionalPayment],
		lsaf.[SixteenToEighteenFrameworkUplift],
		lsaf.CareLeaverAdditionalPayment,
		lsaf.Duration,
		lsaf.ReservedValue2,
		lsaf.ReservedValue3,
		lsaf.MaxEmployerLevyCap,
		lsaf.FundableWithoutEmployer
from	Valid.LearningDelivery
			inner join ReferenceInput.LARS_LARSFrameworkDesktop ls
				on ls.FworkCode = LearningDelivery.FworkCode
				and ls.ProgType = LearningDelivery.ProgType
				and ls.PwayCode = LearningDelivery.PwayCode
			inner join [ReferenceInput].[LARS_LARSFrameworkApprenticeshipFunding] lsaf
				on ls.Id = lsaf.LARS_LARSFrameworkDesktop_Id
				and ls.FworkCode = LearningDelivery.FworkCode
go

truncate table Reference.LARS_StandardCommonComponent
insert into Reference.LARS_StandardCommonComponent (
	CommonComponent,
	EffectiveFrom,
	EffectiveTo,
	StandardCode
)
select	distinct
		lscc.CommonComponent,
		lscc.EffectiveFrom,
		lscc.EffectiveTo,
		ls.StandardCode
from	Valid.LearningDelivery
			inner join ReferenceInput.LARS_LARSStandard ls
				on ls.StandardCode = LearningDelivery.StdCode
			inner join ReferenceInput.[LARS_LARSStandardCommonComponent] lscc
				on lscc.LARS_LARSStandard_Id = ls.Id
go
