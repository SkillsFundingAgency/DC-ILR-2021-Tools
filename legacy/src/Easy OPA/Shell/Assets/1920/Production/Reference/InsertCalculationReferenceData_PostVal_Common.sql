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
 
truncate table Reference.LargeEmployers
insert into Reference.LargeEmployers
select	distinct
		LargeEmployers.EffectiveFrom,
		LargeEmployers.EffectiveTo,
		LargeEmployers.ERN
from	Valid.LearnerEmploymentStatus
			inner join [${Large_Employers_Reference_Data.FullyQualified}].[${Large_Employers_Reference_Data.schemaname}].[LargeEmployers]
				on LargeEmployers.ERN = LearnerEmploymentStatus.EmpId
go

truncate table Reference.LARS_Funding
insert into Reference.LARS_Funding
select	distinct
		LARS_Funding.EffectiveFrom,
		LARS_Funding.EffectiveTo,
		LARS_Funding.FundingCategory,
		LARS_Funding.LearnAimRef,
		LARS_Funding.RateUnWeighted,
		LARS_Funding.RateWeighted,
		LARS_Funding.WeightingFactor
from	Valid.LearningDelivery
			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_Funding]
				on LARS_Funding.LearnAimRef = LearningDelivery.LearnAimRef
go

truncate table Reference.LARS_StandardCommonComponent
insert into Reference.LARS_StandardCommonComponent
select	distinct
		LARS_StandardCommonComponent.CommonComponent,
		LARS_StandardCommonComponent.EffectiveFrom,
		LARS_StandardCommonComponent.EffectiveTo,
		LARS_StandardCommonComponent.StandardCode
from	Valid.LearningDelivery
			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_StandardCommonComponent]
				on LARS_StandardCommonComponent.StandardCode = LearningDelivery.StdCode
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
		pac.Postcode
from	Valid.LearningDelivery as vld
			inner join [${PostcodeFactorsReferenceData.FullyQualified}].[${PostcodeFactorsReferenceData.schemaname}].[SFA_PostcodeAreaCost] as pac
				on pac.Postcode = vld.DelLocPostCode
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
		pd.Apprenticeship_Uplift,
		pd.EffectiveFrom,
		pd.EffectiveTo,
		pd.Postcode,
		pd.Uplift
from	Valid.Learner
			inner join [${PostcodeFactorsReferenceData.FullyQualified}].[${PostcodeFactorsReferenceData.schemaname}].[SFA_PostcodeDisadvantage] as pd
				on pd.Postcode = Learner.PostcodePrior
go
