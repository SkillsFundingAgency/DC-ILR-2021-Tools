IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[ESFAimsAndDeliverablesReportPopulateData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[ESFAimsAndDeliverablesReportPopulateData]
GO

CREATE PROCEDURE [Report].[ESFAimsAndDeliverablesReportPopulateData]	
AS
BEGIN	
	
	TRUNCATE TABLE [Report].[ESFAimsAndDeliverables]

	INSERT INTO [Report].[ESFAimsAndDeliverables]
           ([Learner reference number]
           ,[Unique learner number]
           ,[Aim sequence number]
           ,[Contract reference number]
           ,[Deliverable code]
           ,[Deliverable name]
           ,[Learning aim reference]
           ,[Unit cost]
           ,[Funding rate LARS plus ESOL hours]
           ,[Aim value]
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
           ,[Learning actual end date]
           ,[Outcome]
           ,[Additional delivery hours]
           ,[Learning delivery funding and monitoring type restart indicator]
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
           ,[Start earnings]
           ,[Achievement earnings]
           ,[Additional programme cost earnings]
           ,[Progression earnings]
           ,[Total earnings]
           ,[OFFICIAL-SENSITIVE])
		SELECT [Learner reference number]
      ,[Unique learner number]
      ,[Aim sequence number]
      ,[Contract reference number]
      ,[Deliverable code]
      ,[Deliverable name]
      ,[Learning aim reference]
      ,[Unit cost]
      ,[Funding rate LARS plus ESOL hours]
      ,[Aim value]
      ,[Learning aim title]
	  ,[Pre-merger UKPRN]
      ,[Provider specified learner monitoring (A)]
      ,[Provider specified learner monitoring (B)]
      ,[Software supplier aim identifier]
      ,[Notional NVQ level]
      ,[Tier 2 sector subject area]
      ,[Area uplift]
      ,[Learning rate premium]
      ,Convert(varchar(10),[Learning start date], 120)  AS 'Learning Start Date' 
      ,Convert(varchar(10),[Learning start date of first assessment], 120)  AS 'Learning start date of first assessment' 
      ,Convert(varchar(10),[Learning planned end date], 120)  AS 'Learning planned end date' 
      ,[Completion status]
      ,[Learning actual end date]
      ,[Outcome]
      ,[Additional delivery hours]
      ,[Learning delivery funding and monitoring type restart indicator]
      ,[Provider specified delivery monitoring (A)]
      ,[Provider specified delivery monitoring (B)]
      ,[Provider specified delivery monitoring (C)]
      ,[Provider specified delivery monitoring (D)]
      ,[Sub contracted or partnership UKPRN]
      ,[Delivery location postcode]
      ,Convert(varchar(10),[Latest possible progression start date], 120)  AS 'Latest possible progression start date' 
      ,Convert(varchar(10),[Eligible outcome start date], 120)  AS 'Eligible outcome start date' 
      ,Convert(varchar(10),[Eligible outcome end date], 120)  AS 'Eligible outcome end date' 
	  ,Convert(varchar(10),[Eligible outcome collection date], 120)  AS 'Eligible outcome collection date' 
      ,Convert(varchar(10),[Eligible outcome date used for progression length], 120)  AS 'Eligible outcome date used for progression length' 
      ,[Eligible outcome type]
      ,[Eligible outcome code]
      ,[Month]
	  ,[Deliverable volume]
      ,[Start earnings]      
      ,[Achievement earnings]      
      ,[Additional programme cost earnings]      
      ,[Progression earnings]
      ,[Total earnings]
      ,NULL
  FROM [Report].[ESFAimsAndDeliverablesReportView_DeliverableRows]
  UNION 
  SELECT [Learner reference number]
      ,[Unique learner number]
      ,[Aim sequence number]
      ,[Contract reference number]
      ,[Deliverable code]
      ,[Deliverable name]
      ,[Learning aim reference]
      ,[Unit cost]
      ,[Funding rate LARS plus ESOL hours]
      ,[Aim value]
      ,[Learning aim title]
	  ,[Pre-merger UKPRN]
      ,[Provider specified learner monitoring (A)]
      ,[Provider specified learner monitoring (B)]
      ,[Software supplier aim identifier]
      ,[Notional NVQ level]
      ,[Tier 2 sector subject area]
      ,[Area uplift]
      ,[Learning rate premium]
      ,Convert(varchar(10),[Learning start date], 120)  AS 'Learning Start Date' 
      ,Convert(varchar(10),[Learning start date of first assessment], 120)  AS 'Learning start date of first assessment' 
      ,Convert(varchar(10),[Learning planned end date], 120)  AS 'Learning planned end date' 
      ,[Completion status]
      ,[Learning actual end date]
      ,[Outcome]
      ,[Additional delivery hours]
      ,[Learning delivery funding and monitoring type restart indicator]
      ,[Provider specified delivery monitoring (A)]
      ,[Provider specified delivery monitoring (B)]
      ,[Provider specified delivery monitoring (C)]
      ,[Provider specified delivery monitoring (D)]
      ,[Sub contracted or partnership UKPRN]
      ,[Delivery location postcode]
      ,Convert(varchar(10),[Latest possible progression start date], 120)  AS 'Latest possible progression start date' 
      ,Convert(varchar(10),[Eligible outcome start date], 120)  AS 'Eligible outcome start date' 
      ,Convert(varchar(10),[Eligible outcome end date], 120)  AS 'Eligible outcome end date' 
	  ,Convert(varchar(10),[Eligible outcome collection date], 120)  AS 'Eligible outcome collection date' 
      ,Convert(varchar(10),[Eligible outcome date used for progression length], 120)  AS 'Eligible outcome date used for progression length' 
      ,[Eligible outcome type]
      ,[Eligible outcome code]
      ,[Month]
	  ,[Deliverable volume]
      ,[Start earnings]      
      ,[Achievement earnings]      
      ,[Additional programme cost earnings]      
      ,[Progression earnings]
      ,[Total earnings]
      ,NULL 
  FROM [Report].[ESFAimsAndDeliverablesReportView_NonDeliverableRows]
ORDER BY [Learner reference number], 
[Contract reference number], 
[Learning start date],
[Aim sequence number], 
[month], 
[Deliverable code] ASC





END