declare @pUKPRN int = (select top 1 UKPRN from Rulebase.AEC_global);
exec [${DAS_EarningsHistoryRD.databasename}].[dbo].[PrepareForNewData] '${year}', '${returnPeriod}', @pUKPRN
go

insert into [${DAS_EarningsHistoryRD.databasename}].[dbo].[AEC_EarningHistory] (
	AppIdentifier,
	AppProgCompletedInTheYearInput,
	--BalancingProgAimPaymentsInTheYear,
	CollectionYear,
	CollectionReturnCode,
	--CompletionProgaimPaymentsInTheYear,
	DaysInYear,
	FworkCode,
	HistoricEffectiveTNPStartDateInput,
	HistoricLearner1618StartInput,
	HistoricTotal1618UpliftPaymentsInTheYearInput,
	HistoricTNP1Input,
	HistoricTNP2Input,
	HistoricTNP3Input,
	HistoricTNP4Input,
	HistoricVirtualTNP3EndOfTheYearInput,
	HistoricVirtualTNP4EndOfTheYearInput,
	LatestInYear,
	LearnRefNumber,
	--OnProgProgAimPaymentsInTheYear,
	ProgrammeStartDateIgnorePathway,
	ProgrammeStartDateMatchPathway,
	ProgType,
	PwayCode,
	STDCode,
	TotalProgAimPaymentsInTheYear,
	UptoEndDate,
	UKPRN,
	ULN,
	HistoricEmpIdEndWithinYear,
	HistoricEmpIdStartWithinYear,
	HistoricPMRAmount,
	HistoricLearnDelProgEarliestACT2DateInput
)
select	AppIdentifierOutput,
		AppProgCompletedInTheYearOutput,
		--BalancingProgAimPaymentsInTheYear,
		'${year}',
		'${returnPeriod}',
		--CompletionProgaimPaymentsInTheYear,
		HistoricDaysInYearOutput,
		HistoricFworkCodeOutput,
		HistoricEffectiveTNPStartDateOutput,
		HistoricLearner1618AtStartOutput,
		HistoricTotal1618UpliftPaymentsInTheYear,
		HistoricTNP1Output,
		HistoricTNP2Output,
		HistoricTNP3Output,
		HistoricTNP4Output,
		HistoricVirtualTNP3EndofThisYearOutput,
		HistoricVirtualTNP4EndofThisYearOutput,
		1,
		LearnRefNumber,
		--OnProgProgAimPaymentsInTheYear,
		HistoricProgrammeStartDateIgnorePathwayOutput,
		HistoricProgrammeStartDateMatchPathwayOutput,
		HistoricProgTypeOutput,
		HistoricPwayCodeOutput,
		HistoricSTDCodeOutput,
		HistoricTotalProgAimPaymentsInTheYear,
		HistoricUptoEndDateOutput,
		UKPRN,
		HistoricULNOutput,
		HistoricEmpIdEndWithinYearOutput,
		HistoricEmpIdStartWithinYearOutput,
		HistoricPMRAmountOutput,
		HistoricLearnDelProgEarliestACT2DateOutput
from	DEDS_Rulebase.AEC_HistoricEarningOutput
go