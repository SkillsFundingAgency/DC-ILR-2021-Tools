truncate table Reference.FM25_PostcodeDisadvantage
insert into Reference.FM25_PostcodeDisadvantage
select	distinct
		pc.Postcode,
		PFRD_PC_Disadvantage.Uplift,
		PFRD_PC_Disadvantage.EffectiveFrom,
		PFRD_PC_Disadvantage.EffectiveTo
from	Valid.Learner
			inner join ReferenceInput.[Postcodes_Postcode] pc
				on pc.PostCode = Learner.Postcode
			inner join ReferenceInput.[Postcodes_EfaDisadvantage] as PFRD_PC_Disadvantage
				on PFRD_PC_Disadvantage.Postcodes_Postcode_Id = pc.Id
UNION
select	distinct
		pc.Postcode,
		PFRD_PC_Disadvantage.Uplift,
		PFRD_PC_Disadvantage.EffectiveFrom,
		PFRD_PC_Disadvantage.EffectiveTo
from	Valid.Learner
			inner join ReferenceInput.[Postcodes_Postcode] pc
				on pc.PostCode = Learner.PostcodePrior
			inner join ReferenceInput.[Postcodes_EfaDisadvantage] as PFRD_PC_Disadvantage
				on PFRD_PC_Disadvantage.Postcodes_Postcode_Id = pc.Id
go

truncate table Reference.LargeEmployers
insert into Reference.LargeEmployers
select	distinct
		eed.EffectiveFrom,
		eed.EffectiveTo,
		ee.ERN
from	Valid.LearnerEmploymentStatus
			inner join ReferenceInput.Employers_Employer ee
				on ee.ERN = LearnerEmploymentStatus.EmpId
			inner join ReferenceInput.Employers_LargeEmployerEffectiveDates eed
				on eed.Employers_Employer_Id = ee.Id
go

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

truncate table Reference.PostcodeSpecialistResourceRefData
insert into Reference.PostcodeSpecialistResourceRefData (
	UKPRN,
	PostcodeSpecResEffectiveFrom,
	PostcodeSpecResEffectiveTo,
	PostcodeSpecResPostcode,
	PostcodeSpecResSpecialistResources
)
SELECT
	psr.UKPRN,
	psr.EffectiveFrom,
	psr.EffectiveTo,
	psr.Postcode,
	psr.SpecialistResources 
FROM [Valid].[LearningProvider] lp
	INNER JOIN [ReferenceInput].Organisations_PostcodesSpecialistResources psr
		ON psr.UKPRN = lp.UKPRN
GO

truncate table Reference.Org_Funding
insert into Reference.Org_Funding
select	distinct
		oof.EffectiveFrom,
		oof.EffectiveTo,
		oof.OrgFundFactor,
		oof.OrgFundFactType,
		oof.OrgFundFactValue,
		oo.UKPRN
from	Valid.LearningProvider lp
inner join ReferenceInput.Organisations_Organisation oo
on lp.UKPRN = oo.UKPRN
			inner join ReferenceInput.[Organisations_OrganisationFunding] oof
				on oof.Organisations_Organisation_Id = oo.Id
go
