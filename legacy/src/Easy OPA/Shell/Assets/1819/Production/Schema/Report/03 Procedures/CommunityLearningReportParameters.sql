
IF  EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[CommunityLearningReportParameters]') AND type in (N'P',N'PC'))
BEGIN
DROP PROCEDURE [Report].[CommunityLearningReportParameters]
END

GO

CREATE Procedure [Report].[CommunityLearningReportParameters]
	
AS
BEGIN

	SELECT
	(SELECT 'DefaultProvider' AS 'Name', ISNULL((select od.Name from [Valid].[LearningProvider] lp JOIN  ${ORG.FQ}.[${Org.Schemaname}].ORG_Details od ON od.UKPRN = lp.UKPRN), '') AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'UKPRN' AS 'Name', ISNULL((SELECT TOP 1 UKPRN FROM [Valid].[LearningProvider]), 'N/A') AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'FileName' AS 'Name',  ISNULL((SELECT TOP (1) [FileName] FROM XML_FileNames),'N/A') AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'AppVersion' AS 'Name', '${dcft.application.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'FilePreparationDate' AS 'Name', CONVERT(VARCHAR(10), ISNULL((SELECT TOP 1 FilePreparationDate FROM [Valid].[CollectionDetails]), ''), 103) AS 'Value' FOR XML RAW('Parameter'), TYPE),	
	(SELECT 'RefData1'	AS 'Name', '${UoD.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'Title' AS 'Name', 'Summary of Learners by Non-Single-Budget Category' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'RefData2' AS 'Name', '${PostcodeFactorsReferenceData.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),	
	(SELECT 'Year' AS 'Name', '2017/18' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'RefData3' AS 'Name', '${Large_Employers_Reference_Data.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),		
	(SELECT 'RefData4' AS 'Name', '${ORG.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ComponentSetVersion' AS 'Name', (CASE '${dcft.componentset.version}' WHEN '' THEN 'N/A' ELSE '${dcft.componentset.version}' END) AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ProtectionText' AS 'Name', 'OFFICIAL-SENSITIVE' AS 'Value' FOR XML RAW('Parameter'), TYPE)
FOR XML RAW('Parameters'), ELEMENTS


END