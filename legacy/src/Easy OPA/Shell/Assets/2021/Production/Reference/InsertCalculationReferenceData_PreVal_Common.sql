truncate table Reference.LARS_Current_Version
insert into Reference.LARS_Current_Version (
	CurrentVersion
)
select	distinct
		[Version]
from	ReferenceInput.ReferenceInput.[LARS_LARSVersion]
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
			INNER JOIN ReferenceInput.ReferenceInput.LARS_LARSStandard LS
				ON LS.StandardCode = LearningDelivery.StdCode
			INNER JOIN ReferenceInput.ReferenceInput.LARS_LARSStandardFunding LSF
				on LSF.LARS_LARSStandard_Id = LS.Id
				and LSF.FundingCategory = 'StandardTblazer'
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
			inner join ReferenceInput.ReferenceInput.LARS_LARSStandard ls
				on ls.StandardCode = LearningDelivery.StdCode
			inner join ReferenceInput.ReferenceInput.[LARS_LARSStandardCommonComponent] lscc
				on lscc.LARS_LARSStandard_Id = ls.Id
go
