truncate table Reference.LARS_Framework
insert into Reference.LARS_Framework (
	EffectiveTo,
	FworkCode,
	ProgType,
	PwayCode
)
select	distinct
		ldf.EffectiveTo,
		ldf.FworkCode,
		ldf.ProgType,
		ldf.PwayCode
from	Valid.LearningDelivery
			inner join ReferenceInput.[LARS_LARSFrameworkDesktop] ldf
				on ldf.FworkCode = LearningDelivery.FworkCode
				and ldf.ProgType = LearningDelivery.ProgType
go

--truncate table Reference.LARS_LearningDeliveryCategory
--insert into Reference.LARS_LearningDeliveryCategory (
--	CategoryRef,
--	EffectiveFrom,
--	EffectiveTo,
--	LearnAimRef
--)
--select	distinct
--		LARS_LearningDeliveryCategory.CategoryRef,
--		LARS_LearningDeliveryCategory.EffectiveFrom,
--		LARS_LearningDeliveryCategory.EffectiveTo,
--		LARS_LearningDeliveryCategory.LearnAimRef
--from	[ReferenceInput].[LARS_LARSLearningDeliveryCategory] lldc
--			inner merge join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_LearningDeliveryCategory_Children]
--				on LARS_LearningDeliveryCategory_Children.CategoryRef = LARS_LearningDeliveryCategory.CategoryRef
--			inner join Valid.LearningDelivery
--				on LARS_LearningDeliveryCategory.LearnAimRef = LearningDelivery.LearnAimRef
--go
 
--truncate table Reference.LARS_LearningDeliveryCategory_Children
--insert into Reference.LARS_LearningDeliveryCategory_Children (
--	CategoryRef,
--	ParentCategoryRef,
--	RootCategoryRef
--)
--select	distinct
--		LARS_LearningDeliveryCategory_Children.CategoryRef,
--		LARS_LearningDeliveryCategory_Children.ParentCategoryRef,
--		LARS_LearningDeliveryCategory_Children.RootCategoryRef
--from	[${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_LearningDeliveryCategory_Children]
--			inner merge join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_LearningDeliveryCategory]
--				on LARS_LearningDeliveryCategory_Children.CategoryRef = LARS_LearningDeliveryCategory.CategoryRef
--			inner join Valid.LearningDelivery
--				on LARS_LearningDeliveryCategory.LearnAimRef = LearningDelivery.LearnAimRef
--go
 
--truncate table Reference.LARS_LearningDeliveryCategory_TopMostCategory
--insert into Reference.LARS_LearningDeliveryCategory_TopMostCategory (
--	CategoryRef,
--	LearnAimRef
--)
--select	distinct
--		LARS_LearningDeliveryCategory_TopMostCategory.CategoryRef,
--		LARS_LearningDeliveryCategory_TopMostCategory.LearnAimRef
--from	Valid.LearningDelivery
--			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_LearningDeliveryCategory_TopMostCategory]
--				on LARS_LearningDeliveryCategory_TopMostCategory.LearnAimRef = LearningDelivery.LearnAimRef
--				and LARS_LearningDeliveryCategory_TopMostCategory.CategoryRef = 9
--go
 
--truncate table Reference.LARS_Section96
--insert into Reference.LARS_Section96 (
--	LearnAimRef,
--	Section96ApprovalStatus,
--	Section96ReviewDate,
--	Section96Valid16to18
--)
--select	distinct
--		LARS_Section96.LearnAimRef,
--		LARS_Section96.Section96ApprovalStatus,
--		LARS_Section96.Section96ReviewDate,
--		LARS_Section96.Section96Valid16to18
--from	Valid.LearningDelivery
--			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_Section96]
--				on LARS_Section96.LearnAimRef = LearningDelivery.LearnAimRef
--go
 
truncate table Reference.LARS_Standard
insert into Reference.LARS_Standard (
	EffectiveTo,
	StandardCode,
	NotionalEndLevel
)
select	distinct
		ls.EffectiveTo,
		ls.StandardCode,
		ls.NotionalEndLevel
from	Valid.LearningDelivery
			inner join ReferenceInput.[LARS_LARSStandard] ls
				on ls.StandardCode = LearningDelivery.StdCode
go
 
truncate table Reference.Org_Details
insert into Reference.Org_Details (
	LegalOrgType,
	--ThirdSector,
	UKPRN
)
select	distinct
		o.LegalOrgType,
		--Org_Details.ThirdSector,
		o.UKPRN
from	Valid.LearningProvider
			inner join [ReferenceInput].[Organisations_Organisation] o
				on o.UKPRN = LearningProvider.UKPRN
go
 
truncate table Reference.Org_PartnerUKPRN
insert into Reference.Org_PartnerUKPRN (
	UKPRN
)
select	o.PartnerUKPRN
from	Valid.Learner
			inner join [ReferenceInput].[Organisations_Organisation] o
				on o.PartnerUKPRN = Learner.PrevUKPRN
union 
select	o.PartnerUKPRN
from	Valid.LearningDelivery
			inner join [ReferenceInput].[Organisations_Organisation] o
				on o.PartnerUKPRN = LearningDelivery.PartnerUKPRN
go

truncate table Reference.Org_PMUKPRN
insert into Reference.Org_PMUKPRN (
	UKPRN
)
select	distinct 
		o.PartnerUKPRN
FROM	Valid.Learner
			inner join ReferenceInput.Organisations_Organisation o
				ON o.PartnerUKPRN = Learner.PMUKPRN
go

--truncate table Reference.ORG_HMPP_Postcode
--insert into Reference.ORG_HMPP_Postcode (
--	HMPPPostcode,
--	UKPRN,
--	EffectiveFrom
--)
--select	Org_HMPP_Postcode.HMPPPostcode,
--		Org_HMPP_Postcode.UKPRN,
--		Org_HMPP_Postcode.EffectiveFrom
--from	Valid.Learner
--			cross join Valid.LearningProvider
--			inner join [ReferenceInput].[MetaData_HmppPostcodesVersion]
--				on Org_HMPP_Postcode.UKPRN = LearningProvider.UKPRN
--				and Learner.Postcode = Org_HMPP_Postcode.HMPPPostcode
--go
