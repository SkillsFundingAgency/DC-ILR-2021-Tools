if object_id('Rulebase.AEC_History_SingleProvider', 'p') is not null begin drop procedure Rulebase.AEC_History_SingleProvider
end
go

CREATE PROCEDURE Rulebase.AEC_History_SingleProvider
(
	@pUKPRN int,							-- UKPRN of the provider you are manipulating history for
	@pCollectionReturnCode nvarchar(3),		-- Period you ran for (eg. R01)
	@pReset bit								-- 1 if you need to reset history for another run of the same collection year
)
AS
BEGIN
DECLARE @output nvarchar(max);
-- Reset
IF @pReset = 1
	BEGIN
		SET @output = 'DELETED'
		DELETE
		FROM ReferenceInput.AppsEarningHistory_ApprenticeshipEarningsHistory
		WHERE [CollectionYear]='2021'
			AND [CollectionReturnCode]=@pCollectionReturnCode
			AND [UKPRN]=@pUKPRN
		SELECT cast(@@rowcount as nvarchar(max)) + ' were ' + @output;
		SET @output = 'UPDATED'
		UPDATE ReferenceInput.AppsEarningHistory_ApprenticeshipEarningsHistory
			SET [LatestInYear]=1 WHERE [LatestInYear]=0
			AND [CollectionYear]='2021'
			AND [CollectionReturnCode]= (SELECT TOP(1) CollectionReturnCode FROM ReferenceInput.AppsEarningHistory_ApprenticeshipEarningsHistory WHERE UKPRN = @pUKPRN ORDER BY CollectionReturnCode DESC)
		SELECT cast(@@rowcount as nvarchar(max)) + ' were ' + @output + 'from 1 to 0'
	END
ELSE
	BEGIN
	IF @pCollectionReturnCode = (SELECT DISTINCT CollectionReturnCode FROM ReferenceInput.AppsEarningHistory_ApprenticeshipEarningsHistory where LatestInYear = 1)
		BEGIN
			SET @output = 'UPDATED'
			UPDATE [ReferenceInput].[AppsEarningHistory_ApprenticeshipEarningsHistory]
			SET 
				[AppIdentifier]										= heo.AppIdentifierOutput
				,[AppProgCompletedInTheYearInput]					= heo.AppProgCompletedInTheYearOutput
				,[CollectionYear]									= '2021'
				,[CollectionReturnCode]								= @pCollectionReturnCode
				,[DaysInYear]										= heo.HistoricDaysInYearOutput
				,[FworkCode]										= heo.HistoricFworkCodeOutput
				,[HistoricEffectiveTNPStartDateInput]				= heo.HistoricEffectiveTNPStartDateOutput
				,[HistoricEmpIdEndWithinYear]						= heo.HistoricEmpIdEndWithinYearOutput
				,[HistoricEmpIdStartWithinYear]						= heo.HistoricEmpIdStartWithinYearOutput
				,[HistoricLearner1618StartInput] 					= heo.[HistoricLearner1618AtStartOutput]
				,[HistoricPMRAmount]								= heo.[HistoricPMRAmountOutput]
				,[HistoricTNP1Input]								= heo.[HistoricTNP1Output]
				,[HistoricTNP2Input]								= heo.[HistoricTNP2Output]
				,[HistoricTNP3Input]								= heo.[HistoricTNP3Output]
				,[HistoricTNP4Input]								= heo.[HistoricTNP4Output]
				,[HistoricTotal1618UpliftPaymentsInTheYearInput]	= heo.[HistoricTotal1618UpliftPaymentsInTheYear]
				,[HistoricVirtualTNP3EndOfTheYearInput]				= heo.[HistoricVirtualTNP3EndofThisYearOutput]
				,[HistoricVirtualTNP4EndOfTheYearInput]				= heo.[HistoricVirtualTNP4EndofThisYearOutput]
				,[HistoricLearnDelProgEarliestACT2DateInput]		= heo.[HistoricLearnDelProgEarliestACT2DateOutput]
				,[LatestInYear]										= 1 
				,[LearnRefNumber]									= heo.[LearnRefNumber]
				,[ProgrammeStartDateIgnorePathway]					= heo.[HistoricProgrammeStartDateIgnorePathwayOutput]
				,[ProgrammeStartDateMatchPathway]					= heo.[HistoricProgrammeStartDateMatchPathwayOutput]
				,[ProgType]											= heo.[HistoricProgTypeOutput]
				,[PwayCode]											= heo.[HistoricPwayCodeOutput]
				,[STDCode]											= heo.[HistoricSTDCodeOutput]
				,[TotalProgAimPaymentsInTheYear]					= heo.[HistoricTotalProgAimPaymentsInTheYear]
				,[UptoEndDate]										= heo.[HistoricUptoEndDateOutput]
				,[UKPRN]											= heo.[UKPRN]
				,[ULN]												= heo.[HistoricULNOutput]
			FROM  
			[ReferenceInput].[AppsEarningHistory_ApprenticeshipEarningsHistory] aeh
			INNER JOIN Rulebase.AEC_HistoricEarningOutput  heo
			ON aeh.LearnRefNumber = heo.LearnRefNumber
			and aeh.UKPRN = heo.UKPRN
			and aeh.LatestInYear = 1
			WHERE heo.UKPRN = @pUKPRN
		END
	ELSE
		BEGIN
			SET @output = 'UPDATED'
			UPDATE [ReferenceInput].[AppsEarningHistory_ApprenticeshipEarningsHistory]
				SET [LatestInYear] = 0
				WHERE LatestInYear = 1
				AND UKPRN = @pUKPRN
			-- INSERT
			SELECT cast(@@rowcount as nvarchar(max)) + ' were ' + @output + 'from 0 to 1'
			SET @output = 'INSERTED'
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
				,@pCollectionReturnCode
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
			WHERE UKPRN = @pUKPRN
		END
	SELECT cast(@@rowcount as nvarchar(max)) + ' were ' + @output
	END
END
GO

 if object_id('Rulebase.AEC_History_MultiProvider', 'p') is not null begin drop procedure Rulebase.AEC_History_MiltiProvider
end
go

CREATE PROCEDURE Rulebase.AEC_History_SingleProvider
(
	@pCollectionReturnCode nvarchar(3),		-- Period you ran for (eg. R01)
	@pReset bit								-- 1 if you need to reset history for another run of the same collection year
)
AS
BEGIN
DECLARE @output nvarchar(max);
-- Reset
IF @pReset = 1
	BEGIN
		SET @output = 'DELETED'
		DELETE
		FROM ReferenceInput.AppsEarningHistory_ApprenticeshipEarningsHistory
		WHERE [CollectionYear]='2021'
			AND [CollectionReturnCode]=@pCollectionReturnCode
			AND [UKPRN] in (SELECT DISTINCT UKPRN FROM [Rulebase].[AEC_HistoricEarningOutput])
		SELECT cast(@@rowcount as nvarchar(max)) + ' were ' + @output;
		SET @output = 'UPDATED'
		UPDATE ReferenceInput.AppsEarningHistory_ApprenticeshipEarningsHistory
			SET [LatestInYear]= 1 WHERE [LatestInYear]=0
			AND [CollectionYear]='2021'
			AND [CollectionReturnCode]= (SELECT TOP(1) CollectionReturnCode FROM ReferenceInput.AppsEarningHistory_ApprenticeshipEarningsHistory WHERE LatestInYear = 1 and UKPRN in (SELECT DISTINCT UKPRN FROM [Rulebase].[AEC_HistoricEarningOutput]) ORDER BY CollectionReturnCode DESC)
			and UKPRN in (SELECT DISTINCT UKPRN FROM [Rulebase].[AEC_HistoricEarningOutput])
		SELECT cast(@@rowcount as nvarchar(max)) + ' were ' + @output + 'from 1 to 0'
	END
ELSE
	BEGIN
	IF @pCollectionReturnCode = (SELECT DISTINCT CollectionReturnCode FROM ReferenceInput.AppsEarningHistory_ApprenticeshipEarningsHistory where LatestInYear = 1)
		BEGIN
			SET @output = 'UPDATED'
			UPDATE [ReferenceInput].[AppsEarningHistory_ApprenticeshipEarningsHistory]
			SET 
				[AppIdentifier]										= heo.AppIdentifierOutput
				,[AppProgCompletedInTheYearInput]					= heo.AppProgCompletedInTheYearOutput
				,[CollectionYear]									= '2021'
				,[CollectionReturnCode]								= @pCollectionReturnCode
				,[DaysInYear]										= heo.HistoricDaysInYearOutput
				,[FworkCode]										= heo.HistoricFworkCodeOutput
				,[HistoricEffectiveTNPStartDateInput]				= heo.HistoricEffectiveTNPStartDateOutput
				,[HistoricEmpIdEndWithinYear]						= heo.HistoricEmpIdEndWithinYearOutput
				,[HistoricEmpIdStartWithinYear]						= heo.HistoricEmpIdStartWithinYearOutput
				,[HistoricLearner1618StartInput] 					= heo.[HistoricLearner1618AtStartOutput]
				,[HistoricPMRAmount]								= heo.[HistoricPMRAmountOutput]
				,[HistoricTNP1Input]								= heo.[HistoricTNP1Output]
				,[HistoricTNP2Input]								= heo.[HistoricTNP2Output]
				,[HistoricTNP3Input]								= heo.[HistoricTNP3Output]
				,[HistoricTNP4Input]								= heo.[HistoricTNP4Output]
				,[HistoricTotal1618UpliftPaymentsInTheYearInput]	= heo.[HistoricTotal1618UpliftPaymentsInTheYear]
				,[HistoricVirtualTNP3EndOfTheYearInput]				= heo.[HistoricVirtualTNP3EndofThisYearOutput]
				,[HistoricVirtualTNP4EndOfTheYearInput]				= heo.[HistoricVirtualTNP4EndofThisYearOutput]
				,[HistoricLearnDelProgEarliestACT2DateInput]		= heo.[HistoricLearnDelProgEarliestACT2DateOutput]
				,[LatestInYear]										= 1 
				,[LearnRefNumber]									= heo.[LearnRefNumber]
				,[ProgrammeStartDateIgnorePathway]					= heo.[HistoricProgrammeStartDateIgnorePathwayOutput]
				,[ProgrammeStartDateMatchPathway]					= heo.[HistoricProgrammeStartDateMatchPathwayOutput]
				,[ProgType]											= heo.[HistoricProgTypeOutput]
				,[PwayCode]											= heo.[HistoricPwayCodeOutput]
				,[STDCode]											= heo.[HistoricSTDCodeOutput]
				,[TotalProgAimPaymentsInTheYear]					= heo.[HistoricTotalProgAimPaymentsInTheYear]
				,[UptoEndDate]										= heo.[HistoricUptoEndDateOutput]
				,[UKPRN]											= heo.[UKPRN]
				,[ULN]												= heo.[HistoricULNOutput]
			FROM  
			[ReferenceInput].[AppsEarningHistory_ApprenticeshipEarningsHistory] aeh
			INNER JOIN Rulebase.AEC_HistoricEarningOutput  heo
			ON aeh.LearnRefNumber = heo.LearnRefNumber
			and aeh.UKPRN = heo.UKPRN
			and aeh.LatestInYear = 1
			WHERE heo.UKPRN in (SELECT DISTINCT UKPRN FROM [Rulebase].[AEC_HistoricEarningOutput])
		END
	ELSE
		BEGIN
			SET @output = 'UPDATED'
			UPDATE [ReferenceInput].[AppsEarningHistory_ApprenticeshipEarningsHistory]
				SET [LatestInYear] = 0
				WHERE LatestInYear = 1
				AND UKPRN in (SELECT DISTINCT UKPRN FROM [Rulebase].[AEC_HistoricEarningOutput])
			-- INSERT
			SELECT cast(@@rowcount as nvarchar(max)) + ' were ' + @output + 'from 0 to 1'
			SET @output = 'INSERTED'
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
				,@pCollectionReturnCode
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
	SELECT cast(@@rowcount as nvarchar(max)) + ' were ' + @output
	END
END
GO
