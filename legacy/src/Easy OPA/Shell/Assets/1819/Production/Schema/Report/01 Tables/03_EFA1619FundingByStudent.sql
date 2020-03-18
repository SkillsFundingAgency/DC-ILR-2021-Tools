IF OBJECT_ID('[Report].[EFA1619FundingByStudent]') IS NOT NULL
BEGIN
    DROP TABLE [Report].[EFA1619FundingByStudent]
END

CREATE TABLE [Report].[EFA1619FundingByStudent] (
	[Fundline] [varchar](100),
	[LearnRefNumber] [varchar](12),
	[FamilyName] [varchar](100),
	[GivenNames] [varchar](100),
	[DateOfBirth] [Varchar](10),
	[PlanLearnHours] [int],
	[PlanEEPHours] [int],
	[TotalPlannedHours] [int],
	[RateBand] [varchar](50),
	[QualifiesForFunding] [Varchar](1),
	[OnProgPayment] [decimal](10, 5),
	[SecurityClassification] VARCHAR(100),
	[SortOrder] INT,
	[LearnerStartDate] DATETIME,
	[ProvSpecMon_A] VARCHAR(50),
	[ProvSpecMon_B] VARCHAR(50)
)
GO

