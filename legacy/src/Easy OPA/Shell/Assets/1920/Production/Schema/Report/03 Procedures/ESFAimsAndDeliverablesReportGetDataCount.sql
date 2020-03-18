IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[ESFAimsAndDeliverablesReportGetDataCount]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[ESFAimsAndDeliverablesReportGetDataCount]
GO

CREATE PROCEDURE [Report].[ESFAimsAndDeliverablesReportGetDataCount]	
AS
BEGIN	
	
	Select Count(*) FROM  [Report].[ESFAimsAndDeliverables]

END