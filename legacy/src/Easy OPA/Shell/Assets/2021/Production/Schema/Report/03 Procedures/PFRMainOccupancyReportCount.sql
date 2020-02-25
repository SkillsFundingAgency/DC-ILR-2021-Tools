IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[PFRMainOccupancyReportCount]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[PFRMainOccupancyReportCount]
GO

CREATE PROCEDURE [Report].[PFRMainOccupancyReportCount]
	
AS
BEGIN
	SELECT COUNT(*) FROM PFRMainOccupancyReport

END

GO