IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[TrailblazerEmployerIncentivesReportCount]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[TrailblazerEmployerIncentivesReportCount]
GO

CREATE PROCEDURE [Report].[TrailblazerEmployerIncentivesReportCount]
	
AS
BEGIN

	SELECT COUNT(*) FROM  [Report].[TrailblazerEmployerIncentives] 

END

GO