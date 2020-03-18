IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[GetEFAMathsAndEnglishReportData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[GetEFAMathsAndEnglishReportData]
GO

CREATE PROCEDURE [Report].[GetEFAMathsAndEnglishReportData]
	@Page INT,
	@PageSize INT,
	@ReferenceDate VARCHAR(50) = NULL,
	@LearnRefNumberFilter VARCHAR(50) = NULL,
	@ProvSpecLearnerDataA VARCHAR(100) = NULL,
	@ProvSpecLearnerDataB VARCHAR(100) = NULL,
	@ProvSpecLearnMonA VARCHAR(50) = NULL,
	@ProvSpecLearnMonB VARCHAR(50) = NULL
AS
BEGIN
	DECLARE @ConvertedReferenceDate DATETIME = (SELECT CASE ISNULL(@ReferenceDate, '') WHEN '' THEN NULL ELSE CONVERT(DATETIME, @ReferenceDate, 103) END) 

	SELECT
		[FundLine] AS [Funding line type],
		[LearnRefNumber] AS [Learner reference number],
		[FamilyName] AS [Family name],
		[GivenNames] AS [Given names],
		[DateOfBirth] AS [Date of birth],
		[ConditionOfFundingMaths] AS [Maths GCSE status],
		[ConditionOfFundingEnglish] AS [English GCSE status],
		[RateBand] AS [Funding band],
		'' AS 'OFFICIAL-SENSITIVE'
	FROM (
		SELECT
			ROW_NUMBER() OVER (ORDER BY  [SortOrder],[FundLine], [LearnRefNumber]) AS [RowNumber],
			[FundLine],
			[LearnRefNumber],
			[FamilyName],
			[GivenNames],
			[DateOfBirth],
			[ConditionOfFundingMaths],
			[ConditionOfFundingEnglish],
			[RateBand],
			--[SecurityClassification],
			[SortOrder]
		FROM [Report].[EFAMathsAndEnglishReportValues]
		WHERE (@ConvertedReferenceDate IS NULL OR [LearnerStartDate] <= @ConvertedReferenceDate)
			AND	([LearnRefNumber] = @LearnRefNumberFilter OR ISNULL(@LearnRefNumberFilter, '') = '')
			AND	([ConditionOfFundingMaths] = (SELECT dbo.StripSingleQuote(@ProvSpecLearnerDataA)) OR ISNULL((SELECT dbo.StripSingleQuote(@ProvSpecLearnerDataA)), '') = '')
			AND	([ConditionOfFundingEnglish] = (SELECT dbo.StripSingleQuote(@ProvSpecLearnerDataB)) OR ISNULL((SELECT dbo.StripSingleQuote(@ProvSpecLearnerDataB)), '') = '')
			AND	([ProvSpecMon_A] = @ProvSpecLearnMonA OR ISNULL(@ProvSpecLearnMonA, '') = '')
			AND	([ProvSpecMon_B] = @ProvSpecLearnMonB OR ISNULL(@ProvSpecLearnMonB, '') = '')
	) OUTER_SELECT
	WHERE RowNumber BETWEEN ((@Page - 1) * @PageSize) AND (@Page * @PageSize - 1)
	ORDER BY [SortOrder], [FundLine], [LearnRefNumber]
END

GO