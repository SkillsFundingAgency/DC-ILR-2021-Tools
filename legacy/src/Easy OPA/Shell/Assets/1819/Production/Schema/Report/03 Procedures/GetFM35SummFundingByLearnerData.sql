IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[GetFM35SummFundingByLearnerData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[GetFM35SummFundingByLearnerData]
GO

CREATE PROCEDURE [Report].[GetFM35SummFundingByLearnerData]
	@Page INT,
	@PageSize INT,
	@LearnRefNumber VARCHAR(12) = NULL,
	@FundLine VARCHAR(100) = NULL,
	@DelLocPostCode VARCHAR(8) = NULL,
	@ProvSpecLearnMonA VARCHAR(20) = NULL,
	@ProvSpecLearnMonB VARCHAR(20) = NULL
AS
BEGIN
	SELECT
		[UKPRN] AS [UKPRN],
		[LearnRefNumber] AS [Learner Reference],
		[FamilyName] AS [Surname],
		[GivenNames] AS [Forenames],
		[ProvSpecMon_A] AS [Provider Specified Learner Data A],
		[ProvSpecMon_B] AS [Provider Specified Learner Data B],
		[Funding] AS N'Funding (£)',
		'' AS 'OFFICIAL-SENSITIVE'
	FROM (
		SELECT 
			ROW_NUMBER() OVER (ORDER BY
				CASE 
					WHEN ISNUMERIC([LearnRefNumber]) = 1 
						THEN RIGHT(REPLICATE('0', 13) + [LearnRefNumber], 12)
					WHEN ISNUMERIC([LearnRefNumber]) = 0 
						THEN LEFT([LearnRefNumber] + REPLICATE('', 13), 12)
					ELSE [LearnRefNumber]
				END) AS [RowNumber],
			[UKPRN],
			[LearnRefNumber],
			[FamilyName],
			[GivenNames],
			[ProvSpecMon_A],
			[ProvSpecMon_B],
			SUM([Funding]) AS [Funding]
			--[Security_Classification]
		FROM [Report].[FM35SummFundingByLearner]
		WHERE ([ProvSpecMon_A] = @ProvSpecLearnMonA OR ISNULL(@ProvSpecLearnMonA, '') = '') 
			AND ([ProvSpecMon_B] = @ProvSpecLearnMonB OR ISNULL(@ProvSpecLearnMonB, '') = '') 
			AND ([LearnRefNumber] = @LearnRefNumber OR ISNULL(@LearnRefNumber, '') = '')
			AND ([FundLine] = @FundLine OR ISNULL(@FundLine, '') = '') 
			AND ([DelLocPostCode] = @DelLocPostCode OR ISNULL(@DelLocPostCode, '') = '')
		GROUP BY [UKPRN], [LearnRefNumber], [FamilyName], [GivenNames], [ProvSpecMon_A], [ProvSpecMon_B]
	) AS OUTER_SELECT
	WHERE [RowNumber] BETWEEN((@Page - 1) * @PageSize) AND (@Page * @PageSize - 1)
	ORDER BY [RowNumber]
END
GO