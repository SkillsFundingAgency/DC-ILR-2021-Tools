﻿
SELECT

	(SELECT 'WarningFilter' AS 'Name', '${Warning}' AS 'Value' FOR XML RAW('Parameter'), TYPE),

	(SELECT 'FundModelFilter' AS 'Name', '${FundModel}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'UKPRNFilter' AS 'Name', '${UKPRN}' AS 'Value' FOR XML RAW('Parameter'), TYPE),

	(SELECT 'ProviderSpecDelOccurAFilter' AS 'Name', '${ProviderSpecDeliveryA}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ProviderSpecDelOccurBFilter' AS 'Name', '${ProviderSpecDeliveryB}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ProviderSpecDelOccurCFilter' AS 'Name', '${ProviderSpecDeliveryC}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ProviderSpecDelOccurDFilter' AS 'Name', '${ProviderSpecDeliveryD}' AS 'Value' FOR XML RAW('Parameter'), TYPE),

	(SELECT 'ProviderSpecLearnOccurAFilter' AS 'Name', '${ProviderSpecLearnerA}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ProviderSpecLearnOccurBFilter' AS 'Name', '${ProviderSpecLearnerB}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	
	(SELECT 'DefaultProvider' AS 'Name', ISNULL((select od.Name from Input.LearningProvider lp JOIN [${ORG.FullyQualified}].[${Org.Schemaname}].ORG_Details od ON od.UKPRN = lp.UKPRN), '') AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'Title' AS 'Name', 'Rule Violations Summary Report' AS 'Value'  FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ProtectionText' AS 'Name', 'OFFICIAL - SENSITIVE - Personal' AS 'Value' FOR XML RAW('Parameter'), TYPE),

	(SELECT 'UKPRN' AS 'Name', ISNULL((SELECT TOP 1 UKPRN FROM Input.LearningProvider), '') AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'Year' AS 'Name', '${ReportAcademicYear}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'FileName' AS 'Name', ISNULL((SELECT TOP 1 FileName FROM XML_FileNames), '') AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'AppVersion' AS 'Name', '${dcft.application.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'FilePreparationDate' AS 'Name', CONVERT(VARCHAR(10), ISNULL((SELECT TOP 1 FilePreparationDate FROM Input.CollectionDetails), ''), 103) AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'LarsVersion' AS 'Name', '${UoD.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'PostcodeFactorsVersion' AS 'Name', '${PostcodeFactors.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'LargeEmployerVersion' AS 'Name', '${LargeEmployers.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'RefData4' AS 'Name', '${ORG.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ComponentSetVersion' AS 'Name', '${dcft.componentset.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE)
	
FOR XML RAW('Parameters'), ELEMENTS
