
IF  EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[SFAFundingModel35SummaryReportParameters]') AND type in (N'P',N'PC'))
BEGIN
DROP PROCEDURE [Report].[SFAFundingModel35SummaryReportParameters]
END

GO

CREATE Procedure [Report].[SFAFundingModel35SummaryReportParameters]
	@ProvSpecLearnMonA VARCHAR(50) = '',
	@ProvSpecLearnMonB VARCHAR(50) = '',
	@ProvSpecDelMonA VARCHAR(50) = '',
	@ProvSpecDelMonB VARCHAR(50) = '',
	@ProvSpecDelMonC VARCHAR(50) = '',
	@ProvSpecDelMonD VARCHAR(50) = '',
	@FundLineFilter VARCHAR(50) =''	
AS
BEGIN
	SELECT
		(SELECT 'ProvSpecLearnMonA'		AS 'Name', @ProvSpecLearnMonA AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ProvSpecLearnMonB'		AS 'Name', @ProvSpecLearnMonB AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ProvSpecDelMonA'		AS 'Name', @ProvSpecDelMonA AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ProvSpecDelMonB'		AS 'Name', @ProvSpecDelMonB AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ProvSpecDelMonC'		AS 'Name', @ProvSpecDelMonC AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ProvSpecDelMonD'		AS 'Name', @ProvSpecDelMonD AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'FundLineFilter'		AS 'Name', @FundLineFilter AS 'Value' FOR XML RAW('Parameter'), TYPE),		
		(SELECT 'DefaultProvider'		AS 'Name', ISNULL((select od.Name from [Valid].[LearningProvider] lp JOIN  ${ORG.FQ}.[${Org.Schemaname}].ORG_Details od ON od.UKPRN = lp.UKPRN), '') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'UKPRN'					AS 'Name', ISNULL((SELECT TOP 1 UKPRN FROM [Valid].[LearningProvider]), 'N/A') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'FileName'				AS 'Name',  ISNULL((SELECT TOP (1) [FileName] FROM XML_FileNames),'N/A') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'AppVersion'			AS 'Name', '${dcft.application.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'FilePreparationDate'	AS 'Name', CONVERT(VARCHAR(10), ISNULL((SELECT TOP 1 FilePreparationDate FROM [Input].CollectionDetails), ''), 103) AS 'Value' FOR XML RAW('Parameter'), TYPE),		
		(SELECT 'RefData1'				AS 'Name', '${UoD.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'RefData2'				AS 'Name', '${PostcodeFactorsReferenceData.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),	
		(SELECT 'Year'					AS 'Name', '${ContractAcademicYear}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'Title'					AS 'Name', 'Summary of Funding Model 35 Funding' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'RefData3'				AS 'Name', '${Large_Employers_Reference_Data.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),			
		(SELECT 'RefData4'				AS 'Name', '${ORG.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ComponentSetVersion'	AS 'Name', '${dcft.componentset.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ProtectionText'		AS 'Name','OFFICIAL - SENSITIVE' AS 'Value' FOR XML RAW('Parameter'), TYPE)
	FOR XML RAW('Parameters'), ELEMENTS
END