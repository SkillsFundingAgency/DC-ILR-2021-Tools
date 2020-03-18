truncate table Reference.UniqueLearnerNumbers
insert into Reference.UniqueLearnerNumbers
select	Fromtables.ULN 
from	(
			--LearnerDestinationandProgression - UniqueLearnerNumbers
			select	ULN
			from	Input.LearnerDestinationandProgression

			union 

			--Learner - UniqueLearnerNumbers
			select	ULN
			from	Input.Learner
	) as FromTables
		inner merge join [${ULN.servername}].[${ULN.databasename}].[dbo].[UniqueLearnerNumbers]
			on UniqueLearnerNumbers.ULN = cast(FromTables.ULN as varchar(100))
go

truncate table [Reference].[vw_ContractAllocation]
insert into Reference.vw_ContractAllocation
select	distinct
		contractAllocationNumber,
		fundingStreamPeriodCode,
		startDate,
		stopNewStartsFromDate,
		deliveryUKPRN
from	[${FCS-Contracts.servername}].[${FCS-Contracts.databasename}].[dbo].[vw_ContractAllocation]
			inner join Input.LearningProvider
				on vw_ContractAllocation.deliveryUKPRN = LearningProvider.UKPRN
go

truncate table Reference.vw_ContractValidation
insert into	Reference.vw_ContractValidation
select	vw_ContractValidation.contractAllocationNumber,
		vw_ContractValidation.fundingStreamPeriodCode,
		vw_ContractValidation.startDate,
		vw_ContractValidation.UKPRN
from	Input.LearningProvider
			inner join [${FCS-Contracts.servername}].[${FCS-Contracts.databasename}].[dbo].[vw_ContractValidation]
				on vw_ContractValidation.UKPRN = LearningProvider.UKPRN
				and vw_ContractValidation.fundingStreamPeriodCode in (
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
			
truncate table Reference.Employers
insert into Reference.Employers
select	FromTables.URN
from	(
			select	WorkPlaceEmpId as 'URN'
			from	Input.LearningDeliveryWorkPlacement
			union 
			select	EmpId
			from	Input.LearnerEmploymentStatus
		) as FromTables
			inner merge join [${Employers.servername}].[${Employers.databasename}].[dbo].[Employers]
				on Employers.URN = FromTables.URN
go

truncate table Reference.Postcodes
insert into Reference.Postcodes
select	Postcodes.Postcode
from	Input.PostcodesList
			inner merge join [${Postcodes.servername}].[${Postcodes.databasename}].[dbo].[Postcodes]
				on Postcodes.Postcode = PostcodesList.PostCode
go

truncate table Reference.EligibilityRule
insert into Reference.EligibilityRule
select	distinct
		EligibilityRule.Benefits,
		EligibilityRule.LotReference,
		EligibilityRule.MaxAge,
		EligibilityRule.MaxLengthOfUnemployment,
		EligibilityRule.MaxPriorAttainment,
		EligibilityRule.MinAge,
		EligibilityRule.MinLengthOfUnemployment,
		EligibilityRule.MinPriorAttainment,
		EligibilityRule.TenderSpecificationReference
from	${ESF_Contract_Reference_Data.FQ}.dbo.EligibilityRule
			inner merge join [${ESF_Contract_Reference_Data.servername}].[${ESF_Contract_Reference_Data.databasename}].[dbo].[ContractAllocation]
				on EligibilityRule.TenderSpecificationReference = ContractAllocation.TenderSpecReference
				and EligibilityRule.LotReference = ContractAllocation.LotReference
			inner join Input.LearningDelivery
				on ContractAllocation.ContractAllocationNumber = LearningDelivery.ConRefNumber
go
 
truncate table Reference.EligibilityRuleEmploymentStatus
insert into Reference.EligibilityRuleEmploymentStatus
select	distinct
		LotReference,
		TenderSpecificationReference,
		EmploymentStatusCode
from	${ESF_Contract_Reference_Data.FQ}.dbo.EligibilityRuleEmploymentStatus
go
 
truncate table Reference.EligibilityRuleLocalAuthority
insert into Reference.EligibilityRuleLocalAuthority
select distinct
		LotReference,
		TenderSpecificationReference,
		LocalAuthorityCode
from	${ESF_Contract_Reference_Data.FQ}.dbo.EligibilityRuleLocalAuthority
go
 
truncate table Reference.EligibilityRuleLocalEnterprisePartnership
insert into Reference.EligibilityRuleLocalEnterprisePartnership
select	distinct
		LotReference,
		TenderSpecificationReference,
		LocalEnterprisePartnershipCode
from	${ESF_Contract_Reference_Data.FQ}.dbo.EligibilityRuleLocalEnterprisePartnership
go
 
truncate table Reference.EligibilityRuleSectorSubjectAreaLevel
insert into Reference.EligibilityRuleSectorSubjectAreaLevel
select	distinct
		LotReference,
		TenderSpecificationReference,
		MaxLevelCode,
		MinLevelCode,
		SectorSubjectAreaCode
from	${ESF_Contract_Reference_Data.FQ}.dbo.EligibilityRuleSectorSubjectAreaLevel
go

truncate table Reference.ONS_Postcode
insert into Reference.ONS_Postcode
select	distinct
		ONS_Postcode.doterm,
		ONS_Postcode.EffectiveFrom,
		ONS_Postcode.EffectiveTo,
		ONS_Postcode.lep1,
		ONS_Postcode.lep2,
		ONS_Postcode.oslaua,
		ONS_Postcode.pcds
from	Input.LearningDelivery
			inner merge join [${ONS_Postcode_Directory.servername}].[${ONS_Postcode_Directory.databasename}].[dbo].[ONS_Postcode]
				on ONS_Postcode.pcds = LearningDelivery.DelLocPostCode
go

truncate table Reference.AccountLegalEntity
insert into Reference.AccountLegalEntity
select	Id,
		PublicHashedId,
		AccountId,
		LegalEntityId
from	${DAS_Accounts.FQ}.dbo.AccountLegalEntity
go
