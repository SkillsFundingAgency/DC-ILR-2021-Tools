IF OBJECT_ID('[Report].[ESFAimsAndDeliverables]') IS NOT NULL
BEGIN
    DROP TABLE [Report].[ESFAimsAndDeliverables]
END
GO

CREATE TABLE [Report].[ESFAimsAndDeliverables](
	[Learner reference number] [varchar](12) NOT NULL,
	[Unique learner number] [bigint] NOT NULL,
	[Aim sequence number] [int] NOT NULL,
	[Contract reference number] [varchar](20) NULL,
	[Deliverable code] [varchar](5) NULL,
	[Deliverable name] [nvarchar](120) NULL,
	[Learning aim reference] [varchar](8) NOT NULL,
	[Unit cost] [decimal](10, 5) NULL,
	[Funding rate LARS plus ESOL hours] [decimal](9, 2) NULL,
	[Aim value] [decimal](9, 2) NULL,
	[Learning aim title] [varchar](254) NULL,
	[Pre-merger UKPRN] [int] NULL,
	[Provider specified learner monitoring (A)] [varchar](20) NULL,
	[Provider specified learner monitoring (B)] [varchar](20) NULL,
	[Software supplier aim identifier] [varchar](36) NULL,
	[Notional NVQ level] [varchar](1) NULL,
	[Tier 2 sector subject area] [decimal](5, 2) NULL,
	[Area uplift] [decimal](9, 5) NULL,
	[Learning rate premium] [decimal](9, 5) NULL,
	[Learning Start Date] [varchar](10) NULL,
	[Learning start date of first assessment] [varchar](10) NULL,
	[Learning planned end date] [varchar](10) NULL,
	[Completion status] [int] NULL,
	[Learning actual end date] [date] NULL,
	[Outcome] [int] NULL,
	[Additional delivery hours] [int] NULL,
	[Learning delivery funding and monitoring type restart indicator] [varchar](5) NULL,
	[Provider specified delivery monitoring (A)] [varchar](20) NULL,
	[Provider specified delivery monitoring (B)] [varchar](20) NULL,
	[Provider specified delivery monitoring (C)] [varchar](20) NULL,
	[Provider specified delivery monitoring (D)] [varchar](20) NULL,
	[Sub contracted or partnership UKPRN] [int] NULL,
	[Delivery location postcode] [varchar](8) NULL,
	[Latest possible progression start date] [varchar](10) NULL,
	[Eligible outcome start date] [varchar](10) NULL,
	[Eligible outcome end date] [varchar](10) NULL,
	[Eligible outcome collection date] [varchar](10) NULL,
	[Eligible outcome date used for progression length] [varchar](10) NULL,
	[Eligible outcome type] [varchar](4) NULL,
	[Eligible outcome code] [bigint] NULL,
	[Month] [varchar](6) NULL,
	[Deliverable volume] [bigint] NULL,
	[Start earnings] [char](18) NULL,
	[Achievement earnings] [char](18) NULL,
	[Additional programme cost earnings] [char](18)  NULL,
	[Progression earnings] [char](18) NULL,
	[Total earnings] [decimal](13, 5) NULL,
	[OFFICIAL-SENSITIVE] [varchar](20) NULL
) ON [PRIMARY]

GO
