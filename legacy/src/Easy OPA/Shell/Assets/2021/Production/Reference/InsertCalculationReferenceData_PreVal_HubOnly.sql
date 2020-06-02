truncate table Reference.Lot
insert into Reference.Lot (
	CalcMethod,
	LotReference,
	TenderSpecificationReference
)
select	distinct
		eer.CalcMethod,
		Lot.LotReference,
		eer.TenderSpecReference
from	ReferenceInput.[FCS_FcsContractAllocation] Lot
		inner join ReferenceInput.FCS_EsfEligibilityRule eer
			on eer.Id = Lot.EsfEligibilityRule_Id
		inner join Valid.LearningDelivery
			on Lot.ContractAllocationNumber = LearningDelivery.ConRefNumber
go

--truncate table Reference.ContractAllocation
insert into Reference.ContractAllocation
select	distinct
		fca.ContractAllocationNumber,
		fca.LotReference,
		fca.TenderSpecReference
from	ReferenceInput.[FCS_FcsContractAllocation] fca
			inner join ReferenceInput.FCS_EsfEligibilityRule eer
				on eer.Id = fca.EsfEligibilityRule_Id
			inner join Valid.LearningDelivery ld
				on fca.ContractAllocationNumber = ld.ConRefNumber
go
