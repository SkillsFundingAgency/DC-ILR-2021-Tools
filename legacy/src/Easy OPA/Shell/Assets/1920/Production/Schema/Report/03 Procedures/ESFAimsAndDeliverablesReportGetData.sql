IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[ESFAimsAndDeliverablesReportGetData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[ESFAimsAndDeliverablesReportGetData]
GO

CREATE PROCEDURE [Report].[ESFAimsAndDeliverablesReportGetData]	
AS
BEGIN	
	
	SELECT [Learner reference number]
      ,[Unique learner number]
      ,[Aim sequence number]
      ,[Contract reference number]
      ,[Deliverable code]
      ,[Deliverable name]
      ,[Learning aim reference]
      ,[Unit cost] as [Unit cost (£)]
      ,[Funding rate LARS plus ESOL hours] as [Funding rate - LARS plus ESOL hours (£)]
      ,[Aim value] as [Aim value (£)]
      ,[Learning aim title]
	  ,[Pre-merger UKPRN]
      ,[Provider specified learner monitoring (A)]
      ,[Provider specified learner monitoring (B)]
      ,[Software supplier aim identifier]
      ,[Notional NVQ level]
      ,[Tier 2 sector subject area]
      ,[Area uplift]
      ,[Learning rate premium]
      ,[Learning Start Date]
      ,[Learning start date of first assessment]
      ,[Learning planned end date]
      ,[Completion status]
      ,Convert(varchar(10),[Learning actual end date]) as [Learning actual end date]
      ,[Outcome]
      ,[Additional delivery hours]
      ,[Learning delivery funding and monitoring type restart indicator] as [Learning delivery funding and monitoring type – restart indicator]
      ,[Provider specified delivery monitoring (A)]
      ,[Provider specified delivery monitoring (B)]
      ,[Provider specified delivery monitoring (C)]
      ,[Provider specified delivery monitoring (D)]
      ,[Sub contracted or partnership UKPRN]
      ,[Delivery location postcode]
      ,[Latest possible progression start date]
      ,[Eligible outcome start date]
      ,[Eligible outcome end date]
      ,[Eligible outcome collection date]
      ,[Eligible outcome date used for progression length]
      ,[Eligible outcome type]
      ,[Eligible outcome code]
      ,[Month]
      ,[Deliverable volume]
      ,[Start earnings] as [Start earnings (£)]
      ,[Achievement earnings] as [Achievement earnings (£)]
      ,[Additional programme cost earnings] as [Additional programme cost earnings (£)]
      ,[Progression earnings] as [Progression earnings (£)]
      ,[Total earnings] as [Total earnings (£)]
      ,[OFFICIAL-SENSITIVE]   
	   FROM  [Report].[ESFAimsAndDeliverables]
	ORDER BY [Learner reference number], 
	[Contract reference number], 
	[Learning start date],
	[Aim sequence number], 
	[month], 
	[Deliverable code] ASC





END