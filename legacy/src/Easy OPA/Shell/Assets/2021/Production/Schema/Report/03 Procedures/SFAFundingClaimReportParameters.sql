IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[SFAFundingClaimReportParameters]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[SFAFundingClaimReportParameters]
GO

CREATE PROCEDURE [Report].[SFAFundingClaimReportParameters]
	
AS
BEGIN
	SELECT
	(SELECT 'DefaultProvider' AS 'Name', ISNULL((select od.Name from [Valid].[LearningProvider] lp JOIN [${ORG.FullyQualified}].[${Org.Schemaname}].ORG_Details od ON od.UKPRN = lp.UKPRN), '') AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'UKPRN' AS 'Name', ISNULL((SELECT TOP 1 UKPRN FROM [Valid].[LearningProvider]), 'N/A') AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'FileName' AS 'Name',  ISNULL((SELECT TOP (1) [FileName] FROM XML_FileNames),'N/A') AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'AppVersion' AS 'Name', '${dcft.application.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'FilePreparationDate' AS 'Name', CONVERT(VARCHAR(10), ISNULL((SELECT TOP 1 FilePreparationDate FROM [Input].CollectionDetails), ''), 103) AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'RefData1' AS 'Name', '${UoD.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'RefData2' AS 'Name', '${PostcodeFactorsReferenceData.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'Year' AS 'Name', '${ContractAcademicYear}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'Title' AS 'Name', 'Adult Funding Claim Report' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'IsOnline' AS 'Name', CASE '${dcft.runmode}' WHEN 'DS' THEN '0' ELSE '1' End AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'RefData3' AS 'Name', '${Large_Employers_Reference_Data.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'RefData4' AS 'Name', '${ORG.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ComponentSetVersion' AS 'Name', (CASE '${dcft.componentset.version}' WHEN '' THEN 'N/A' ELSE '${dcft.componentset.version}' END) AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ProtectionText' AS 'Name','OFFICIAL-SENSITIVE' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ReportGeneratedAt' AS 'Name', (SELECT CONVERT(VARCHAR(10), GETDATE(), 108) + ' on ' + CONVERT(VARCHAR(10), GETDATE(), 103)) AS 'Value' FOR XML RAW('Parameter'), TYPE)
FOR XML RAW('Parameters'), ELEMENTS

END

GO