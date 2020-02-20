-- [Report].[EFAMathsAndEnglishReportValues] table
IF OBJECT_ID('[Report].[EFAMathsAndEnglishReportValues]') IS NOT NULL
BEGIN
    DROP TABLE [Report].[EFAMathsAndEnglishReportValues]
END

CREATE TABLE [Report].[EFAMathsAndEnglishReportValues] (
	[FundLine] VARCHAR(100),
	[LearnRefNumber] VARCHAR(12),
	[FamilyName] VARCHAR(100),
	[GivenNames] VARCHAR(100),
	[DateOfBirth] VARCHAR(10),
	[ConditionOfFundingMaths] VARCHAR(100),
	[ConditionOfFundingEnglish] VARCHAR(100),
	[RateBand] VARCHAR(50),
	[SecurityClassification] VARCHAR(100),
	[SortOrder] INT,
	[LearnerStartDate] DATETIME,
	[ProvSpecMon_A] VARCHAR(50),
	[ProvSpecMon_B] VARCHAR(50)
)
GO
