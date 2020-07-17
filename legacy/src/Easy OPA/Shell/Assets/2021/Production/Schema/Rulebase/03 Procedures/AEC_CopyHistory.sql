IF object_id(
	'Rulebase.AEC_CopyHistory',
	'p'
) is not null begin drop procedure Rulebase.AEC_CopyHistory
END
GO

CREATE PROCEDURE Rulebase.AEC_CopyHistory
(  
  @pCollectionReturnCode varchar(3)		--Period just ran (R01)
)
AS 
BEGIN
	DELETE
	FROM [ReferenceInput].[AppsEarningHistory_ApprenticeshipEarningsHistory]
	WHERE [CollectionYear]='2021'
		AND [CollectionReturnCode]=@pCollectionReturnCode
		AND [UKPRN] in (select distinct UKPRN from Rulebase.AEC_HistoricEarningOutput)
  
	UPDATE [ReferenceInput].[AppsEarningHistory_ApprenticeshipEarningsHistory]
	SET [LatestInYear]=0 WHERE [LatestInYear]=1
		AND [CollectionYear]='2021'
		AND [UKPRN] in (select distinct UKPRN from Rulebase.AEC_HistoricEarningOutput)


	INSERT INTO [ReferenceInput].[AppsEarningHistory_ApprenticeshipEarningsHistory]
		([AppIdentifier]
		,[AppProgCompletedInTheYearInput]
		,[CollectionYear]
		,[CollectionReturnCode]
		,[DaysInYear]
		,[FworkCode]
		,[HistoricEffectiveTNPStartDateInput]
		,[HistoricEmpIdEndWithinYear]
		,[HistoricEmpIdStartWithinYear]
		,[HistoricLearner1618StartInput]
		,[HistoricPMRAmount]
		,[HistoricTNP1Input]
		,[HistoricTNP2Input]
		,[HistoricTNP3Input]
		,[HistoricTNP4Input]
		,[HistoricTotal1618UpliftPaymentsInTheYearInput]
		,[HistoricVirtualTNP3EndOfTheYearInput]
		,[HistoricVirtualTNP4EndOfTheYearInput]
		,[HistoricLearnDelProgEarliestACT2DateInput]
		,[LatestInYear]
		,[LearnRefNumber]
		,[ProgrammeStartDateIgnorePathway]
		,[ProgrammeStartDateMatchPathway]
		,[ProgType]
		,[PwayCode]
		,[STDCode]
		,[TotalProgAimPaymentsInTheYear]
		,[UptoEndDate]
		,[UKPRN]
		,[ULN])
	SELECT 
		[AppIdentifierOutput]
		,[AppProgCompletedInTheYearOutput]
		,'2021' as CollectionYear--2021
		,@pCollectionReturnCode--
		,[HistoricDaysInYearOutput]
		,[HistoricFworkCodeOutput]
		,[HistoricEffectiveTNPStartDateOutput]
		,[HistoricEmpIdEndWithinYearOutput]
		,[HistoricEmpIdStartWithinYearOutput]
		,[HistoricLearner1618AtStartOutput]
		,[HistoricPMRAmountOutput]
		,[HistoricTNP1Output]
		,[HistoricTNP2Output]
		,[HistoricTNP3Output]
		,[HistoricTNP4Output]
		,[HistoricTotal1618UpliftPaymentsInTheYear]
		,[HistoricVirtualTNP3EndofThisYearOutput]
		,[HistoricVirtualTNP4EndofThisYearOutput]
		,[HistoricLearnDelProgEarliestACT2DateOutput]
		,1 as LatestInYear --true/1
		,[LearnRefNumber]
		,[HistoricProgrammeStartDateIgnorePathwayOutput]
		,[HistoricProgrammeStartDateMatchPathwayOutput]
		,[HistoricProgTypeOutput]
		,[HistoricPwayCodeOutput]
		,[HistoricSTDCodeOutput]
		,[HistoricTotalProgAimPaymentsInTheYear]
		,[HistoricUptoEndDateOutput]
		,[UKPRN]
		,[HistoricULNOutput]
	FROM [Rulebase].[AEC_HistoricEarningOutput]
END
GO
