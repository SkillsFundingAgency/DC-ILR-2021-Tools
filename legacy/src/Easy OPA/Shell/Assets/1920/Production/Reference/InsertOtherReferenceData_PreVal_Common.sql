truncate table Reference.LARS_Framework
insert into Reference.LARS_Framework (
	EffectiveTo,
	FworkCode,
	ProgType,
	PwayCode
)
select	distinct
		LARS_Framework.EffectiveTo,
		LARS_Framework.FworkCode,
		LARS_Framework.ProgType,
		LARS_Framework.PwayCode
from	${runmode.inputsource}.LearningDelivery
			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_Framework]
				on LARS_Framework.FworkCode = LearningDelivery.FworkCode
				and LARS_Framework.ProgType = LearningDelivery.ProgType
go

truncate table Reference.LARS_LearningDeliveryCategory
insert into Reference.LARS_LearningDeliveryCategory (
	CategoryRef,
	EffectiveFrom,
	EffectiveTo,
	LearnAimRef
)
select	distinct
		LARS_LearningDeliveryCategory.CategoryRef,
		LARS_LearningDeliveryCategory.EffectiveFrom,
		LARS_LearningDeliveryCategory.EffectiveTo,
		LARS_LearningDeliveryCategory.LearnAimRef
from	[${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_LearningDeliveryCategory]
			inner merge join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_LearningDeliveryCategory_Children]
				on LARS_LearningDeliveryCategory_Children.CategoryRef = LARS_LearningDeliveryCategory.CategoryRef
			inner join ${runmode.inputsource}.LearningDelivery
				on LARS_LearningDeliveryCategory.LearnAimRef = LearningDelivery.LearnAimRef
go
 
truncate table Reference.LARS_LearningDeliveryCategory_Children
insert into Reference.LARS_LearningDeliveryCategory_Children (
	CategoryRef,
	ParentCategoryRef,
	RootCategoryRef
)
select	distinct
		LARS_LearningDeliveryCategory_Children.CategoryRef,
		LARS_LearningDeliveryCategory_Children.ParentCategoryRef,
		LARS_LearningDeliveryCategory_Children.RootCategoryRef
from	[${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_LearningDeliveryCategory_Children]
			inner merge join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_LearningDeliveryCategory]
				on LARS_LearningDeliveryCategory_Children.CategoryRef = LARS_LearningDeliveryCategory.CategoryRef
			inner join ${runmode.inputsource}.LearningDelivery
				on LARS_LearningDeliveryCategory.LearnAimRef = LearningDelivery.LearnAimRef
go
 
truncate table Reference.LARS_LearningDeliveryCategory_TopMostCategory
insert into Reference.LARS_LearningDeliveryCategory_TopMostCategory (
	CategoryRef,
	LearnAimRef
)
select	distinct
		LARS_LearningDeliveryCategory_TopMostCategory.CategoryRef,
		LARS_LearningDeliveryCategory_TopMostCategory.LearnAimRef
from	${runmode.inputsource}.LearningDelivery
			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_LearningDeliveryCategory_TopMostCategory]
				on LARS_LearningDeliveryCategory_TopMostCategory.LearnAimRef = LearningDelivery.LearnAimRef
				and LARS_LearningDeliveryCategory_TopMostCategory.CategoryRef = 9
go
 
truncate table Reference.LARS_Section96
insert into Reference.LARS_Section96 (
	LearnAimRef,
	Section96ApprovalStatus,
	Section96ReviewDate,
	Section96Valid16to18
)
select	distinct
		LARS_Section96.LearnAimRef,
		LARS_Section96.Section96ApprovalStatus,
		LARS_Section96.Section96ReviewDate,
		LARS_Section96.Section96Valid16to18
from	${runmode.inputsource}.LearningDelivery
			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_Section96]
				on LARS_Section96.LearnAimRef = LearningDelivery.LearnAimRef
go
 
truncate table Reference.LARS_Standard
insert into Reference.LARS_Standard (
	EffectiveTo,
	StandardCode,
	NotionalEndLevel
)
select	distinct
		LARS_Standard.EffectiveTo,
		LARS_Standard.StandardCode,
		LARS_Standard.NotionalEndLevel
from	${runmode.inputsource}.LearningDelivery
			inner join [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_Standard]
				on LARS_Standard.StandardCode = LearningDelivery.StdCode
go
 
truncate table Reference.Org_Details
insert into Reference.Org_Details (
	LegalOrgType,
	ThirdSector,
	UKPRN
)
select	distinct
		Org_Details.LegalOrgType,
		Org_Details.ThirdSector,
		Org_Details.UKPRN
from	${runmode.inputsource}.LearningProvider
			inner join [${ORG.FullyQualified}].[${Org.Schemaname}].[Org_Details]
				on Org_Details.UKPRN = LearningProvider.UKPRN
go
 
truncate table Reference.Org_PartnerUKPRN
insert into Reference.Org_PartnerUKPRN (
	UKPRN
)
select	Org_PartnerUKPRN.UKPRN
from	${runmode.inputsource}.Learner
			inner join [${ORG.FullyQualified}].[${Org.Schemaname}].[Org_PartnerUKPRN]
				on Org_PartnerUKPRN.UKPRN = Learner.PrevUKPRN
union 
select	Org_PartnerUKPRN.UKPRN
from	${runmode.inputsource}.LearningDelivery
			inner join [${ORG.FullyQualified}].[${Org.Schemaname}].[Org_PartnerUKPRN]
				on Org_PartnerUKPRN.UKPRN = LearningDelivery.PartnerUKPRN
go

truncate table Reference.Org_PMUKPRN
insert into Reference.Org_PMUKPRN (
	UKPRN
)
select	distinct 
		Org_PartnerUKPRN.UKPRN
FROM	${runmode.inputsource}.Learner
			inner join [${ORG.FullyQualified}].[${Org.Schemaname}].[Org_PartnerUKPRN]
				ON Org_PartnerUKPRN.UKPRN = Learner.PMUKPRN
go

truncate table Reference.ORG_HMPP_Postcode
insert into Reference.ORG_HMPP_Postcode (
	HMPPPostcode,
	UKPRN,
	EffectiveFrom
)
select	Org_HMPP_Postcode.HMPPPostcode,
		Org_HMPP_Postcode.UKPRN,
		Org_HMPP_Postcode.EffectiveFrom
from	${runmode.inputsource}.Learner
			cross join ${runmode.inputsource}.LearningProvider
			inner join [${ORG.FullyQualified}].[${Org.Schemaname}].[Org_HMPP_Postcode]
				on Org_HMPP_Postcode.UKPRN = LearningProvider.UKPRN
				and Learner.Postcode = Org_HMPP_Postcode.HMPPPostcode
go
