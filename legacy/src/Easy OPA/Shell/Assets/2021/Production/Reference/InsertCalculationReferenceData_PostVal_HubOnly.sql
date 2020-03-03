truncate table Reference.DeliverableCodeMappings
insert into Reference.DeliverableCodeMappings (
	ExternalDeliverableCode,
	FCSDeliverableCode,
	FundingStreamPeriodCode,
	DeliverableName
)
select	distinct
		DeliverableCodeMappings.ExternalDeliverableCode,
		DeliverableCodeMappings.FCSDeliverableCode,
		DeliverableCodeMappings.FundingStreamPeriodCode,
		DeliverableCodeMappings.DeliverableName
from	${FCS-Contracts.FQ}.dbo.DeliverableCodeMappings
			inner merge join [${FCS-Contracts.servername}].[${FCS-Contracts.databasename}].[dbo].[vw_ContractDescription]
				on DeliverableCodeMappings.FundingStreamPeriodCode = vw_ContractDescription.fundingStreamPeriodCode
				and DeliverableCodeMappings.FCSDeliverableCode = vw_ContractDescription.deliverableCode
			inner join Valid.LearningDelivery
				on vw_ContractDescription.contractAllocationNumber = LearningDelivery.ConRefNumber
go

truncate table Reference.vw_ContractDescription
insert into Reference.vw_ContractDescription (
	contractAllocationNumber,
	contractEndDate,
	contractStartDate,
	deliverableCode,
	fundingStreamPeriodCode,
	learningRatePremiumFactor,
	unitCost
)
select	distinct
		FCA.ContractAllocationNumber,
		FCA.EndDate,
		FCA.StartDate,
		FCD.DeliverableCode,
		FCA.FundingStreamPeriodCode,
		FCA.LearningRatePremiumFactor,
		FCD.UnitCost
from	ReferenceInput.ReferenceInput.FCS_FcsContractAllocation FCA
		INNER JOIN ReferenceInput.ReferenceInput.FCS_FcsContractDeliverable FCD
			on FCD.FCS_FcsContractAllocation_Id = FCA.Id
			inner merge join [${FCS-Contracts.servername}].[${FCS-Contracts.databasename}].[dbo].[DeliverableCodeMappings]
				on DeliverableCodeMappings.FundingStreamPeriodCode = FCA.fundingStreamPeriodCode
				and DeliverableCodeMappings.FCSDeliverableCode = FCD.deliverableCode
			inner join Valid.LearningDelivery
				on FCA.contractAllocationNumber = LearningDelivery.ConRefNumber
go

truncate table Reference.AEC_LatestInYearEarningHistory
insert into Reference.AEC_LatestInYearEarningHistory (
	AppIdentifier,
	AppProgCompletedInTheYearInput,
	CollectionYear,
	CollectionReturnCode,
	DaysInYear,
	FworkCode,
	HistoricEffectiveTNPStartDateInput,
	HistoricEmpIdEndWithinYear,
	HistoricEmpIdStartWithinYear,
	HistoricLearner1618StartInput,
	HistoricPMRAmount,
	HistoricTNP1Input,
	HistoricTNP2Input,
	HistoricTNP3Input,
	HistoricTNP4Input,
	HistoricTotal1618UpliftPaymentsInTheYearInput,
	HistoricVirtualTNP3EndOfTheYearInput,
	HistoricVirtualTNP4EndOfTheYearInput,
	LatestInYear,
	LearnRefNumber,
	ProgrammeStartDateIgnorePathway,
	ProgrammeStartDateMatchPathway,
	ProgType,
	PwayCode,
	STDCode,
	TotalProgAimPaymentsInTheYear,
	UptoEndDate,
	UKPRN,
	ULN,
	HistoricLearnDelProgEarliestACT2DateInput
)
select	distinct
		aec.AppIdentifier,
		aec.AppProgCompletedInTheYearInput,
		aec.CollectionYear,
		aec.CollectionReturnCode,
		aec.DaysInYear,
		aec.FworkCode,
		aec.HistoricEffectiveTNPStartDateInput,
		aec.HistoricEmpIdEndWithinYear,
		aec.HistoricEmpIdStartWithinYear,
		aec.HistoricLearner1618StartInput,
		aec.HistoricPMRAmount,
		aec.HistoricTNP1Input,
		aec.HistoricTNP2Input,
		aec.HistoricTNP3Input,
		aec.HistoricTNP4Input,
		aec.HistoricTotal1618UpliftPaymentsInTheYearInput,
		aec.HistoricVirtualTNP3EndOfTheYearInput,
		aec.HistoricVirtualTNP4EndOfTheYearInput,
		1,
		aec.LearnRefNumber,
		aec.ProgrammeStartDateIgnorePathway,
		aec.ProgrammeStartDateMatchPathway,
		aec.ProgType,
		aec.PwayCode,
		aec.STDCode,
		aec.TotalProgAimPaymentsInTheYear,
		aec.UptoEndDate,
		aec.UKPRN,
		aec.ULN,
		aec.HistoricLearnDelProgEarliestACT2DateInput
from	Valid.Learner as l
			--join [${DAS_EarningsHistoryRD.servername}].[${DAS_EarningsHistoryRD.databasename}].[${DAS_EarningsHistoryRD.schemaname}].AEC_LatestInYearEarningHistory as aec
			--join [${DAS_EarningsHistoryRD.servername}].[${DAS_EarningsHistoryRD.databasename}].[${DAS_EarningsHistoryRD.schemaname}].AppsEarningHistory_ApprenticeshipEarningsHistory as aec
			join ReferenceInput.ReferenceInput.AppsEarningHistory_ApprenticeshipEarningsHistory as aec
				on	aec.ULN = l.ULN
go
