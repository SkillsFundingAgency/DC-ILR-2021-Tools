IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[GetEFAMathsAndEnglishReportCount]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[GetEFAMathsAndEnglishReportCount]
GO

CREATE PROCEDURE [Report].[GetEFAMathsAndEnglishReportCount]
	@ReferenceDate VARCHAR(50) = NULL,
	@LearnRefNumberFilter VARCHAR(50) = NULL,
	@ProvSpecLearnerDataA VARCHAR(100) = NULL,
	@ProvSpecLearnerDataB VARCHAR(100) = NULL,
	@ProvSpecLearnMonA VARCHAR(50) = NULL,
	@ProvSpecLearnMonB VARCHAR(50) = NULL
AS
BEGIN
	DECLARE @ConvertedReferenceDate DATETIME = (SELECT CASE ISNULL(@ReferenceDate, '') WHEN '' THEN NULL ELSE CONVERT(DATETIME, @ReferenceDate, 103) END) 

	SELECT COUNT(*)
	FROM [Report].[EFAMathsAndEnglishReportValues]
	WHERE (@ConvertedReferenceDate IS NULL OR [LearnerStartDate] <= @ConvertedReferenceDate)
		AND	([LearnRefNumber] = @LearnRefNumberFilter OR ISNULL(@LearnRefNumberFilter, '') = '')
		AND	([ConditionOfFundingMaths] = (SELECT dbo.StripSingleQuote(@ProvSpecLearnerDataA)) OR ISNULL((SELECT dbo.StripSingleQuote(@ProvSpecLearnerDataA)), '') = '')
		AND	([ConditionOfFundingEnglish] = (SELECT dbo.StripSingleQuote(@ProvSpecLearnerDataB)) OR ISNULL((SELECT dbo.StripSingleQuote(@ProvSpecLearnerDataB)), '') = '')
		AND	([ProvSpecMon_A] = @ProvSpecLearnMonA OR ISNULL(@ProvSpecLearnMonA, '') = '')
		AND	([ProvSpecMon_B] = @ProvSpecLearnMonB OR ISNULL(@ProvSpecLearnMonB, '') = '')
END

GO