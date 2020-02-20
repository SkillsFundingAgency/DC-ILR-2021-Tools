IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[AppsIndicativeEarningsReportCount]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[AppsIndicativeEarningsReportCount]
GO

CREATE PROCEDURE [Report].[AppsIndicativeEarningsReportCount]
AS
BEGIN

	SELECT COUNT(*) FROM  [Report].[AppsIndicativeEarningsReport]

END

GO