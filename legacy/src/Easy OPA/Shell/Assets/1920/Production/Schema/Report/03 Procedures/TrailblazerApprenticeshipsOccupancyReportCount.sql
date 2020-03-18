 IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[TrailblazerApprenticeshipsOccupancyReportCount]') AND type in (N'P', N'PC'))
	 DROP PROCEDURE [Report].[TrailblazerApprenticeshipsOccupancyReportCount]
 GO

 CREATE PROCEDURE [Report].[TrailblazerApprenticeshipsOccupancyReportCount]
	
 AS
 BEGIN

	 SELECT COUNT(*) FROM  [Report].[TrailblazerApprenticeshipsOccupancyReport] 

 END

 GO