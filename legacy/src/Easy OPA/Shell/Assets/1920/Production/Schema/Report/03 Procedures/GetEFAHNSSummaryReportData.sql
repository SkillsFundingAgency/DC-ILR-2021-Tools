IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[GetEFAHNSSummaryReportData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[GetEFAHNSSummaryReportData]
GO

CREATE PROCEDURE [Report].[GetEFAHNSSummaryReportData]
AS
BEGIN
	DECLARE @TempExportTable TABLE (DetailsInfo XML)

	INSERT INTO @TempExportTable 
	VALUES (
		(
		 SELECT [StudentNumbers_A_A]
				  ,[StudentNumbers_A_B]
				  ,[StudentNumbers_A_C]
				  ,[StudentNumbers_A_D]
				  ,[StudentNumbers_A_E]
				  ,[StudentNumbers_A_F]
				  ,[StudentNumbers_B_A]
				  ,[StudentNumbers_B_B]
				  ,[StudentNumbers_B_C]
				  ,[StudentNumbers_B_D]
				  ,[StudentNumbers_B_E]
				  ,[StudentNumbers_B_F]
				  ,[StudentNumbers_C_A]
				  ,[StudentNumbers_C_B]
				  ,[StudentNumbers_C_C]
				  ,[StudentNumbers_C_D]
				  ,[StudentNumbers_C_E]
				  ,[StudentNumbers_C_F]
				  ,[StudentNumbers_D_A]
				  ,[StudentNumbers_D_B]
				  ,[StudentNumbers_D_C]
				  ,[StudentNumbers_D_D]
				  ,[StudentNumbers_D_E]
				  ,[StudentNumbers_D_F]
				  ,[StudentNumbers_E_A]
				  ,[StudentNumbers_E_B]
				  ,[StudentNumbers_E_C]
				  ,[StudentNumbers_E_D]
				  ,[StudentNumbers_E_E]
				  ,[StudentNumbers_E_F]
				  ,[HNS_Students_1624]
		FROM [Report].[EFAHNSSumaryReport]
		FOR XML PATH('StudentNumber'), ELEMENTS)
	)

	SELECT 
		DetailsInfo AS '*'
	FROM @TempExportTable
	FOR XML PATH('StudentNumbers')
END
GO