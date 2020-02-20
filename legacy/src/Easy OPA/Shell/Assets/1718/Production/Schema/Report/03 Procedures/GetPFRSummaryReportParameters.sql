IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[GetPFRSummaryReportParameters]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[GetPFRSummaryReportParameters]
GO

CREATE PROCEDURE [Report].[GetPFRSummaryReportParameters]
AS
BEGIN
	DECLARE @CollectionPeriod DATE = (SELECT
		CASE '${dcft.runmode}'
			WHEN 'DS' THEN
				(SELECT TOP 1 ISNULL([FilePreparationDate], CONVERT(DATE, GETDATE())) FROM [Valid].[CollectionDetails])
			ELSE CONVERT(DATE, GETDATE()) END);

		DECLARE @CollectionPeriodInt INT = (SELECT ISNULL((SELECT CAST(RIGHT(CollectionReturnCode, LEN(CollectionReturnCode)-1) AS INT) 
	 FROM [Reference].[CollectionCalendar] WHERE @CollectionPeriod BETWEEN [ProposedOpenDate] AND [ProposedClosedDate]),12));

	SELECT	
		(SELECT 'ProviderName' AS 'Name', ISNULL((select Top(1) od.Name from Valid.LearningProvider lp JOIN ${ORG.FQ}.[${Org.Schemaname}].ORG_Details od ON od.UKPRN = lp.UKPRN), ' ') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'UKPRN' AS 'Name', ISNULL((SELECT TOP 1 CAST(UKPRN AS VARCHAR) FROM Valid.LearningProvider), 'N/A') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ILRFile' AS 'Name',  ISNULL((SELECT TOP (1) [FileName] FROM XML_FileNames),'N/A') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'LastILRFileUpdate' AS 'Name',ISNULL((SELECT TOP(1) [FN06] FROM XML_FileNames WHERE [FN03] = (SELECT TOP 1 UKPRN FROM Valid.LearningProvider) ORDER BY [FN06] DESC),' ') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'LastEASUpdate' AS 'Name', ' ' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'LastEASOLASSUpdate' AS 'Name', ' ' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'SecurityClassification' AS 'Name', 'OFFICIAL-SENSITIVE' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'IsOnlineFlag' AS 'Name',  Case '${dcft.runmode}' WHEN 'DS' THEN 'False' ELSE 'True' End AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ComponentSetVersion' AS 'Name', '${dcft.componentset.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ApplicationVersion' AS 'Name', '${dcft.application.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'FilePreparationDate' AS 'Name', CONVERT(VARCHAR(10), ISNULL((SELECT TOP 1 [FilePreparationDate] FROM [Valid].[CollectionDetails]), ' '), 103) AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'LarsData' AS 'Name', '${UoD.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'OrgData' AS 'Name', '${ORG.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ReportGeneratedAt' AS 'Name', (SELECT CONVERT(VARCHAR(10), GETDATE(), 108) + ' on ' + CONVERT(VARCHAR(10), GETDATE(), 103)) AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'PostCodeData' AS 'Name', '${PostcodeFactorsReferenceData.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'LargeEmployerData' AS 'Name', '${Large_Employers_Reference_Data.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),	
		(SELECT 'CollectionPeriod' AS 'Name', @CollectionPeriodInt AS 'Value' FOR XML RAW('Parameter'), TYPE)
	FOR XML RAW('Parameters'), ELEMENTS
END
GO