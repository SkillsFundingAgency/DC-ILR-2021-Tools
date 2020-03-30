﻿SELECT
	(SELECT 'Title' AS 'Name', 'EFA 16-19 Summary of Funding by student (valid)' AS 'Value'  FOR XML RAW('Parameter'), TYPE),
	(SELECT 'DefaultProvider' AS 'Name', ISNULL((select od.Name from VALID.LearningProvider lp JOIN [${ORG.FullyQualified}].[${Org.Schemaname}].ORG_Details od ON od.UKPRN = lp.UKPRN), '') AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'UKPRN' AS 'Name', ISNULL((SELECT TOP 1 UKPRN FROM VALID.LearningProvider), 'N/A') AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'FileName' AS 'Name', ISNULL((SELECT TOP (1) [FileName] FROM XML_FileNames),'') AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'Year' AS 'Name', '2015/16' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'LearnRefNumberFilter' AS 'Name', '${LearnRefNumberFilter}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ProvSpecDelMonA' AS 'Name', '${ProvSpecDelMonA}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ProvSpecDelMonB' AS 'Name', '${ProvSpecDelMonB}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ProvSpecLearnMonA' AS 'Name', '${ProvSpecLearnMonA}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ProvSpecLearnMonB' AS 'Name', '${ProvSpecLearnMonB}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ComponentSetVersion' AS 'Name', '${dcft.componentset.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'AppVersion' AS 'Name', '${dcft.application.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'FilePreparationDate' AS 'Name', CONVERT(VARCHAR(10), ISNULL((SELECT TOP 1 FilePreparationDate FROM Input.CollectionDetails), ''), 103) AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'RefData1' AS 'Name', '${UoD.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'RefData2' AS 'Name', '${PostcodeFactors.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'RefData3' AS 'Name', '${LargeEmployers.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'RefData4' AS 'Name', '${ORG.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ReferenceDate' AS 'Name', '${ReferenceDate}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'ProtectionText' AS 'Name', 'OFFICIAL-SENSITIVE' AS 'Value' FOR XML RAW('Parameter'), TYPE),
	(SELECT 'Collection' AS 'Name', 'ILR' AS 'Value' FOR XML RAW('Parameter'), TYPE)
FOR XML RAW('Parameters'), ELEMENTS