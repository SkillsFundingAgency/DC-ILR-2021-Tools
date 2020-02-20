truncate table Reference.Lot
insert into Reference.Lot (
	CalcMethod,
	LotReference,
	TenderSpecificationReference
)
select	distinct
		Lot.CalcMethod,
		Lot.LotReference,
		Lot.TenderSpecificationReference
from	${ESF_Contract_Reference_Data.FQ}.dbo.Lot
			inner merge join [${ESF_Contract_Reference_Data.servername}].[${ESF_Contract_Reference_Data.databasename}].[dbo].[ContractAllocation]
				on Lot.TenderSpecificationReference = ContractAllocation.TenderSpecReference
				and Lot.LotReference = ContractAllocation.LotReference
			inner join ${runmode.inputsource}.LearningDelivery
				on ContractAllocation.ContractAllocationNumber = LearningDelivery.ConRefNumber
go

truncate table Reference.ContractAllocation
insert into Reference.ContractAllocation
select	distinct
		ContractAllocation.ContractAllocationNumber,
		ContractAllocation.LotReference,
		ContractAllocation.TenderSpecReference
from	${ESF_Contract_Reference_Data.FQ}.dbo.ContractAllocation
			inner merge join [${ESF_Contract_Reference_Data.servername}].[${ESF_Contract_Reference_Data.databasename}].[dbo].[EligibilityRule]
				on EligibilityRule.TenderSpecificationReference = ContractAllocation.TenderSpecReference
				and EligibilityRule.LotReference = ContractAllocation.LotReference
			inner join ${runmode.inputsource}.LearningDelivery
				on ContractAllocation.ContractAllocationNumber = LearningDelivery.ConRefNumber
go
