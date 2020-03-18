IF OBJECT_ID('[Report].[SFAFundingClaimReportData]') IS NOT NULL
BEGIN
    DROP TABLE [Report].[SFAFundingClaimReportData]
END

CREATE TABLE [Report].[SFAFundingClaimReportData] (
	[FundLine] NVARCHAR(200),
	[Total6Months] DECIMAL(18, 5),
	[TotalYear] DECIMAL(18, 5),
	[SortOrder] INT,
	[SubGroupDescription] NVARCHAR(100),
	[UKPRN] BIGINT,
	[Warning] NVARCHAR(150) DEFAULT 'This report displays indicative figures only. DO NOT use it for your actual funding claims. Instead use the report that is generated from the Hub.',
	[SecurityClassification] NVARCHAR(20) DEFAULT 'OFFICIAL - SENSITIVE' 
)
GO
