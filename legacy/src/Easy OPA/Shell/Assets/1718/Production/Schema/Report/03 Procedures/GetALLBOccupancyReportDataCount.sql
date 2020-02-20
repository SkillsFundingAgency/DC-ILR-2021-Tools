IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[GetALLBOccupancyReportDataCount]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[GetALLBOccupancyReportDataCount]
GO

CREATE PROCEDURE [Report].[GetALLBOccupancyReportDataCount]
AS
BEGIN
	SELECT COUNT(*) FROM [Report].[ALLBOccupancyReportData]
END
GO