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
			inner join ReferenceInput.[LARS_LARSFunding] LF
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
			INNER JOIN ReferenceInput.[LARS_LARSStandard] LS
				on LS.StandardCode = LearningDelivery.StdCode
			inner join ReferenceInput.[LARS_LARSStandardCommonComponent] LSCC
				on LSCC.LARS_LARSStandard_Id  = LS.Id

go


truncate table Reference.SFA_PostcodeAreaCost
insert into	Reference.SFA_PostcodeAreaCost (
	AreaCostFactor,
	EffectiveFrom,
	EffectiveTo,
	Postcode
)
select	distinct
		pac.AreaCostFactor,
		pac.EffectiveFrom,
		pac.EffectiveTo,
		p.Postcode
from	Valid.LearningDelivery as vld
inner join [ReferenceInput].Postcodes_Postcode p
				on p.PostCode = vld.DelLocPostCode
			inner join [ReferenceInput].[Postcodes_SfaAreaCost] as pac
				on pac.Postcodes_Postcode_Id = p.Id
go

truncate table Reference.SFA_PostcodeDisadvantage
insert into Reference.SFA_PostcodeDisadvantage (
	Apprenticeship_Uplift,
	EffectiveFrom,
	EffectiveTo,
	Postcode,
	Uplift
)
select	distinct
		pd.Uplift,
		pd.EffectiveFrom,
		pd.EffectiveTo,
		p.Postcode,
		pd.Uplift
from	Valid.Learner
			inner join [ReferenceInput].Postcodes_Postcode p
				on p.PostCode = Learner.PostcodePrior
			inner join [ReferenceInput].[Postcodes_SfaDisadvantage] as pd
				on pd.Postcodes_Postcode_Id = p.Id
go

