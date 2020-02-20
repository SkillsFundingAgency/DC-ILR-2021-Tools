IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[GetFM35SummFundingByLearnerCount]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[GetFM35SummFundingByLearnerCount]
GO

CREATE PROCEDURE [Report].[GetFM35SummFundingByLearnerCount]
	@LearnRefNumber VARCHAR = NULL,
	@FundLine VARCHAR = NULL,
	@DelLocPostCode VARCHAR = NULL,
	@ProvSpecLearnMonA VARCHAR = NULL,
	@ProvSpecLearnMonB VARCHAR = NULL
AS
BEGIN
	SELECT COUNT(*)
	FROM (
		SELECT 
			[UKPRN],
			[LearnRefNumber],
			[FamilyName],
			[GivenNames],
			[ProvSpecMon_A],
			[ProvSpecMon_B],
			SUM([Funding]) AS [Funding],
			[Security_Classification]
		FROM [Report].[FM35SummFundingByLearner]
		WHERE ([ProvSpecMon_A] = @ProvSpecLearnMonA OR ISNULL(@ProvSpecLearnMonA, '') = '') 
			AND ([ProvSpecMon_B] = @ProvSpecLearnMonB OR ISNULL(@ProvSpecLearnMonB, '') = '') 
			AND ([LearnRefNumber] = @LearnRefNumber OR ISNULL(@LearnRefNumber, '') = '')
			AND ([FundLine] = @FundLine OR ISNULL(@FundLine, '') = '') 
			AND ([DelLocPostCode] = @DelLocPostCode OR ISNULL(@DelLocPostCode, '') = '')
		GROUP BY [UKPRN], [LearnRefNumber], [FamilyName], [GivenNames], [ProvSpecMon_A], [ProvSpecMon_B], [Security_Classification]
	) AS OUTER_SELECT
END
GO