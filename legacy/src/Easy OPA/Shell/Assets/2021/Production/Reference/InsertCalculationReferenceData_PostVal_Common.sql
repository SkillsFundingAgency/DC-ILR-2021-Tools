truncate table Reference.LARS_Funding
insert into Reference.LARS_Funding
select	distinct
		LF.EffectiveFrom,
		LF.EffectiveTo,
		LF.FundingCategory,
		LF.LearnAimRef,
		LF.RateUnWeighted,
		LF.RateWeighted,
		LF.WeightingFactor
from	Valid.LearningDelivery
			inner join ReferenceInput.ReferenceInput.[LARS_LARSFunding] LF
				on LF.LearnAimRef = LearningDelivery.LearnAimRef
go

truncate table Reference.LARS_StandardCommonComponent
insert into Reference.LARS_StandardCommonComponent
select	distinct
		LSCC.CommonComponent,
		LSCC.EffectiveFrom,
		LSCC.EffectiveTo,
		LS.StandardCode
from	Valid.LearningDelivery
			INNER JOIN ReferenceInput.ReferenceInput.LARS_LARSStandard LS
				on LS.StandardCode = LearningDelivery.StdCode
			inner join ReferenceInput.ReferenceInput.[LARS_LARSStandardCommonComponent] LSCC
				on LSCC.LARS_LARSStandard_Id  = LS.Id

go
