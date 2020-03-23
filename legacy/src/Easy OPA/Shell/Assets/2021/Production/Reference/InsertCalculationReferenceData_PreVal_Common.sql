truncate table Reference.LARS_Current_Version
insert into Reference.LARS_Current_Version (
	CurrentVersion
)
select	distinct
		[Version]
from	ReferenceInput.[MetaData_LarsVersion]
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
from	${runmode.inputsource}.LearningDelivery
			INNER JOIN ReferenceInput.LARS_LARSStandard LS
				ON LS.StandardCode = LearningDelivery.StdCode
			INNER JOIN ReferenceInput.LARS_LARSStandardFunding LSF
				on LSF.LARS_LARSStandard_Id = LS.Id
				and LSF.FundingCategory = 'StandardTblazer'
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
	from ${runmode.inputsource}.LearningDelivery
			inner join ReferenceInput.[LARS_LARSLearningDelivery] LLD
				on LLD.LearnAimRef = LearningDelivery.LearnAimRef
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
from	${runmode.inputsource}.LearningDelivery
			inner join ReferenceInput.LARS_LARSStandard ls
				on ls.StandardCode = LearningDelivery.StdCode
			inner join ReferenceInput.[LARS_LARSStandardCommonComponent] lscc
				on lscc.LARS_LARSStandard_Id = ls.Id
go

truncate table Reference.SFA_PostcodeAreaCost_Current_Version
insert into Reference.SFA_PostcodeAreaCost_Current_Version (
	CurrentVersion
)
select	[Version]
from	ReferenceInput.[MetaData_PostcodesVersion]
go