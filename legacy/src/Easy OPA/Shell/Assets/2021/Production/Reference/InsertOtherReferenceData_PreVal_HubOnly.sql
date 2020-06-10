--truncate table Reference.UniqueLearnerNumbers
--insert into Reference.UniqueLearnerNumbers
--select	Fromtables.ULN 
--from	(
--			--LearnerDestinationandProgression - UniqueLearnerNumbers
--			select	ULN
--			from	Valid.LearnerDestinationandProgression

--			union 

--			--Learner - UniqueLearnerNumbers
--			select	ULN
--			from	Valid.Learner
--	) as FromTables
--		inner merge join [${ULN.servername}].[${ULN.databasename}].[dbo].[UniqueLearnerNumbers]
--			on UniqueLearnerNumbers.ULN = cast(FromTables.ULN as varchar(100))
--go

truncate table [Reference].[vw_ContractAllocation]
insert into Reference.vw_ContractAllocation
select	distinct
		fca.ContractAllocationNumber,
		fca.FundingStreamPeriodCode,
		fca.StartDate,
		fca.StopNewStartsFromDate,
		fca.deliveryUKPRN
from	ReferenceInput.FCS_FcsContractAllocation fca
			inner join Valid.LearningProvider
				on fca.DeliveryUKPRN = LearningProvider.UKPRN
go

truncate table Reference.vw_ContractValidation
insert into	Reference.vw_ContractValidation
select	fca.ContractAllocationNumber,
		fca.FundingStreamPeriodCode,
		fca.StartDate,
		fca.DeliveryUKPRN
from	Valid.LearningProvider
			inner join ReferenceInput.FCS_FcsContractAllocation fca
				on fca.DeliveryUKPRN = LearningProvider.UKPRN
				and fca.FundingStreamPeriodCode in (
					'ESF1420',
					'LEVY1799',
					'16-18NLAP2018',
					'ALLBC1819',
					'AEBC1819',
					'ANLAP2018',
					'ALLB1819',
					'APPS1819',
					'AEB-TOL1819',
					'16-18TRN1819',
					'CLP1819'
				)
go
			
--truncate table Reference.Employers
--insert into Reference.Employers
--select	FromTables.URN
--from	(
--			select	WorkPlaceEmpId as 'URN'
--			from	Valid.LearningDeliveryWorkPlacement
--			union 
--			select	EmpId
--			from	Valid.LearnerEmploymentStatus
--		) as FromTables
--			inner merge join [${Employers.servername}].[${Employers.databasename}].[dbo].[Employers]
--				on Employers.URN = FromTables.URN
--go

truncate table Reference.Postcodes
insert into Reference.Postcodes
select	p.Postcode
from	(SELECT distinct Postcode From Valid.Learner) as PostcodesList
			inner merge join [ReferenceInput].[Postcodes_Postcode] p
				on p.Postcode = PostcodesList.Postcode
go

truncate table Reference.EligibilityRule
insert into Reference.EligibilityRule
select	distinct
		eer.Benefits,
		eer.LotReference,
		eer.MaxAge,
		eer.MaxLengthOfUnemployment,
		eer.MaxPriorAttainment,
		eer.MinAge,
		eer.MinLengthOfUnemployment,
		eer.MinPriorAttainment,
		eer.TenderSpecReference
from	[ReferenceInput].[FCS_EsfEligibilityRule] eer
			inner join [ReferenceInput].[FCS_FcsContractAllocation] fca
				on eer.Id = fca.EsfEligibilityRule_Id
			inner join Valid.LearningDelivery
				on fca.ContractAllocationNumber = LearningDelivery.ConRefNumber
go
 
truncate table Reference.EligibilityRuleEmploymentStatus
insert into Reference.EligibilityRuleEmploymentStatus
select	distinct
		eer.LotReference,
		eer.TenderSpecReference,
		eeres.Code
from	[ReferenceInput].[FCS_EsfEligibilityRule] eer
		inner join [ReferenceInput].[FCS_EsfEligibilityRuleEmploymentStatus] eeres
			on eer.Id = eeres.FCS_EsfEligibilityRule_Id
go
 
truncate table Reference.EligibilityRuleLocalAuthority
insert into Reference.EligibilityRuleLocalAuthority
select distinct
		eer.LotReference,
		eer.TenderSpecReference,
		eera.Code
from	[ReferenceInput].[FCS_EsfEligibilityRuleLocalAuthority] eera
		inner join [ReferenceInput].[FCS_EsfEligibilityRule] eer
			on eera.FCS_EsfEligibilityRule_Id = eer.Id
go
 
truncate table Reference.EligibilityRuleLocalEnterprisePartnership
insert into Reference.EligibilityRuleLocalEnterprisePartnership
select	distinct
		LotReference,
		TenderSpecReference,
		eerep.Code
from	[ReferenceInput].[FCS_EsfEligibilityRuleLocalEnterprisePartnership] eerep
		inner join [ReferenceInput].[FCS_EsfEligibilityRule] eer
			on eerep.FCS_EsfEligibilityRule_Id = eer.Id
go
 
truncate table Reference.EligibilityRuleSectorSubjectAreaLevel
insert into Reference.EligibilityRuleSectorSubjectAreaLevel
select	distinct
		eer.LotReference,
		eer.TenderSpecReference,
		eerssa.MaxLevelCode,
		eerssa.MinLevelCode,
		eerssa.SectorSubjectAreaCode
from	[ReferenceInput].[FCS_EsfEligibilityRuleSectorSubjectAreaLevel] eerssa
		inner join [ReferenceInput].[FCS_EsfEligibilityRule] eer
			on eerssa.FCS_EsfEligibilityRule_Id = eer.Id
go

--truncate table Reference.ONS_Postcode
--insert into Reference.ONS_Postcode
--select	distinct
--		ONS_Postcode.doterm,
--		ONS_Postcode.EffectiveFrom,
--		ONS_Postcode.EffectiveTo,
--		ONS_Postcode.lep1,
--		ONS_Postcode.lep2,
--		ONS_Postcode.oslaua,
--		ONS_Postcode.pcds
--from	Valid.LearningDelivery
--			inner merge join [${ONS_Postcode_Directory.servername}].[${ONS_Postcode_Directory.databasename}].[dbo].[ONS_Postcode]
--				on ONS_Postcode.pcds = LearningDelivery.DelLocPostCode
--go

--truncate table Reference.AccountLegalEntity
--insert into Reference.AccountLegalEntity
--select	Id,
--		PublicHashedId,
--		AccountId,
--		LegalEntityId
--from	${DAS_Accounts.FQ}.dbo.AccountLegalEntity
--go
