IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[ESFFundingSummaryReportParameters]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Report].[ESFFundingSummaryReportParameters]
GO


CREATE procedure [Report].[ESFFundingSummaryReportParameters]

AS
BEGIN
 
	DECLARE @L_ukprn NVARCHAR(10)
	DECLARE @l_SuppFileDate nvarchar(10)
	DECLARE @ComponentSetVersion nVarChar(50)
	DECLARE @ShowComponentSetVersion int
		
	DECLARE @prevYear_1617_ILRFileName NVARCHAR(50)
	DECLARE @prevYear_1617_ILRFileUpdate DATETIME
	DECLARE @prevYear_1617_ILRFilePrepDate DATE

	DECLARE @prevYear_1516_ILRFileName NVARCHAR(50)
	DECLARE @prevYear_1516_ILRFileUpdate DATETIME
	DECLARE @prevYear_1516_ILRFilePrepDate DATE

	SET @L_ukprn = (SELECT TOP 1 UKPRN FROM [Valid].[LearningProvider])

	SET @l_SuppFileDate = (SELECT CONVERT(VARCHAR(10), ISNULL((SELECT TOP (1) [DateTime] FROM [${ESF_Supplementary_Data.FullyQualified}].[dbo].[SourceFile] with (nolock) WHERE UKPRN = @L_ukprn order by SourceFileId DESC), '01/01/1900'), 103))
	SET @l_SuppFileDate =  (SELECT CASE WHEN @l_SuppFileDate= '01/01/1900' THEN 'N/A' ELSE @l_SuppFileDate END )

	-- Componenet set version only visible in FIS reports
	SET @ComponentSetVersion = 'N/A'
	SET @ShowComponentSetVersion = 0 -- Note: 0 => Hide, other value e.g. 1 => Show

	SELECT @prevYear_1617_ILRFileUpdate=[FileUploadDate],@prevYear_1617_ILRFileName=[SourceFileName],@prevYear_1617_ILRFilePrepDate=[FilePreparationDate]
				FROM (SELECT Top 1 * FROM [Reference].[ESF_Processed_Providers] WHERE AcademicYear='2016/17' ORDER BY [ProcessedTime] DESC) PreviousYearFile

	SELECT @prevYear_1516_ILRFileUpdate=[FileUploadDate],@prevYear_1516_ILRFileName=[SourceFileName],@prevYear_1516_ILRFilePrepDate=[FilePreparationDate]
				FROM (SELECT Top 1 * FROM [Reference].[ESF_Processed_Providers] WHERE AcademicYear='2015/16' ORDER BY [ProcessedTime] DESC) PreviousYearFile
	
	SELECT
		(SELECT 'ProviderName' AS 'Name', ISNULL((select od.Name from [Valid].[LearningProvider] lp JOIN [${ORG.FullyQualified}].[${Org.Schemaname}].ORG_Details od ON od.UKPRN = lp.UKPRN), '') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'UKPRN' AS 'Name', ISNULL(@L_ukprn, 'N/A') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		
		(SELECT 'ILRFileName' AS 'Name',  ISNULL((SELECT TOP (1) [FileName] FROM XML_FileNames),'N/A') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'LastILRFileUpdate' AS 'Name',ISNULL((SELECT TOP(1) [FN06] FROM XML_FileNames WHERE [FN03] = (SELECT TOP 1 UKPRN FROM Valid.LearningProvider) ORDER BY [FN06] DESC),'') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'FilePrepDate' AS 'Name', CONVERT(VARCHAR(10), ISNULL((SELECT TOP 1 FilePreparationDate FROM [Input].CollectionDetails), ''), 103) AS 'Value' FOR XML RAW('Parameter'), TYPE),
			
		(SELECT 'PrevYear_1617_ILRFileName' AS 'Name',  ISNULL(@prevYear_1617_ILRFileName,'N/A') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'PrevYear_1617_LastILRFileUpdate' AS 'Name', CASE WHEN @prevYear_1617_ILRFileUpdate IS NULL THEN 'N/A' ELSE CONVERT(CHAR(19),@prevYear_1617_ILRFileUpdate,120) END AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'PrevYear_1617_FilePrepDate' AS 'Name', CASE WHEN @prevYear_1617_ILRFilePrepDate IS NULL THEN 'N/A' ELSE CONVERT(CHAR(19),@prevYear_1617_ILRFilePrepDate,103) END AS 'Value' FOR XML RAW('Parameter'), TYPE),

		(SELECT 'PrevYear_1516_ILRFileName' AS 'Name',  ISNULL(@prevYear_1516_ILRFileName,'N/A') AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'PrevYear_1516_LastILRFileUpdate' AS 'Name', CASE WHEN @prevYear_1516_ILRFileUpdate IS NULL THEN 'N/A' ELSE CONVERT(CHAR(19),@prevYear_1516_ILRFileUpdate,120) END AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'PrevYear_1516_FilePrepDate' AS 'Name', CASE WHEN @prevYear_1516_ILRFilePrepDate IS NULL THEN 'N/A' ELSE CONVERT(CHAR(19),@prevYear_1516_ILRFilePrepDate,103) END AS 'Value' FOR XML RAW('Parameter'), TYPE),

		(SELECT 'SuppDataFile' AS 'Name', CONVERT(VARCHAR(10), ISNULL((SELECT TOP (1) [FileName] FROM [${ESF_Supplementary_Data.FullyQualified}].[dbo].[SourceFile] with (nolock) WHERE UKPRN = @L_ukprn order by SourceFileId DESC), 'N/A'), 103) AS 'Value'  FOR XML RAW('Parameter'), TYPE),
		(SELECT 'LastSuppFileUpdate' AS 'Name',  @l_SuppFileDate AS  'Value' FOR XML RAW('Parameter'), TYPE),
	
		(SELECT 'SecurityClass' AS 'Name','OFFICIAL - SENSITIVE' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ShowComponentSetVersion' AS 'Name', @ShowComponentSetVersion AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ComponentSetVersion' AS 'Name', @ComponentSetVersion AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ApplicationVersion' AS 'Name', '${dcft.application.version}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'LarsData' AS 'Name', '${UoD.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'PostCodeData' AS 'Name',  '${PostcodeFactorsReferenceData.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'OrgData' AS 'Name', '${ORG.PreferredVersion}' AS 'Value' FOR XML RAW('Parameter'), TYPE),
		(SELECT 'ReportGeneratedAt' AS 'Name', (SELECT CONVERT(VARCHAR(10), GETDATE(), 103)) AS 'Value' FOR XML RAW('Parameter'), TYPE)

	FOR XML RAW('Parameters'), ELEMENTS

END

GO