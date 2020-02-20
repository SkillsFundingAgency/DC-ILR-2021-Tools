IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[GetEFAFundingClaimReportParameters]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[GetEFAFundingClaimReportParameters]
GO

CREATE PROCEDURE [Report].[GetEFAFundingClaimReportParameters]
	@ReferenceDate VARCHAR(50) = NULL
AS
BEGIN
	SELECT
		(SELECT 'DefaultProvider' AS 'Name', ISNULL((select od.Name from [Valid].[LearningProvider] lp JOIN [${ORG.FullyQualified}].[${Org.Schemaname}].ORG_Details od ON od.UKPRN = lp.UKPRN), '') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'Title' AS 'Name', '16-19 Funding Claim Report' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ProtectionText' AS 'Name', 'OFFICIAL-SENSITIVE' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'UKPRN' AS 'Name', ISNULL((SELECT TOP 1 UKPRN FROM [Valid].[LearningProvider]), '') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'Year' AS 'Name', '${ContractAcademicYear}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'FileName' AS 'Name', ISNULL((SELECT TOP 1 FileName FROM XML_FileNames), '') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'AppVersion' AS 'Name', '${dcft.application.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'FilePreparationDate' AS 'Name', CONVERT(VARCHAR(10), ISNULL((SELECT TOP 1 FilePreparationDate FROM [Valid].[CollectionDetails]), ''), 103) AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'LarsVersion' AS 'Name', '${UoD.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'PostcodeFactorsVersion' AS 'Name', '${PostcodeFactorsReferenceData.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'LargeEmployersVersion' AS 'Name', '${Large_Employers_Reference_Data.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'OrgVersion' AS 'Name', '${ORG.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'CofrVersion' AS 'Name', '${EFA_CoF_Removal_Reference_Data.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ReferenceDate' AS 'Name', @ReferenceDate AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ComponentSetVersion' AS 'Name', (CASE '${dcft.componentset.version}' WHEN '' THEN 'N/A' ELSE '${dcft.componentset.version}' END) AS 'Value' FOR XML RAW('Parameter'), TYPE)
	FOR XML RAW('Parameters'), ELEMENTS
END
GO