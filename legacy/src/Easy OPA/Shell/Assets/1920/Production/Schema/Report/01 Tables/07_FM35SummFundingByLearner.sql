IF OBJECT_ID('[Report].[FM35SummFundingByLearner]') IS NOT NULL
BEGIN
    DROP TABLE [Report].[FM35SummFundingByLearner]
END
GO

CREATE TABLE [Report].[FM35SummFundingByLearner] (
	[UKPRN] BIGINT,
	[LearnRefNumber] VARCHAR(12),
	[FamilyName] VARCHAR(100),
	[GivenNames] VARCHAR(100),
	[ProvSpecMon_A] VARCHAR(20),
	[ProvSpecMon_B] VARCHAR(20),
	[Funding] DECIMAL(38, 5),
	[Security_Classification] VARCHAR(20),
	[FundLine] VARCHAR(100),
	[DelLocPostCode] VARCHAR(8)
)
GO
