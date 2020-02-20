IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[EFA1619FundingByStudentReportData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[EFA1619FundingByStudentReportData]
GO

CREATE PROCEDURE [Report].[EFA1619FundingByStudentReportData]
	@Page INT,
	@PageSize INT,
	@ReferenceDate VARCHAR(50) = NULL,
	@LearnRefNumberFilter VARCHAR(50) = NULL,
	@ProvSpecLearnMonA VARCHAR(50) = NULL,
	@ProvSpecLearnMonB VARCHAR(50) = NULL
AS
BEGIN
	SELECT LTRIM(RTRIM((stringVal))) as LearnRefNumber into #LearnRefNumbers FROM dbo.ConvertCSVToTable(ISNULL(@LearnRefNumberFilter, ''));
	DELETE FROM #LearnRefNumbers WHERE ISNULL(LearnRefNumber, '') = '';

	DECLARE @ConvertedReferenceDate datetime = (SELECT CASE @ReferenceDate WHEN ' ' THEN NULL ELSE CONVERT (datetime, @ReferenceDate, 103)END)

		SELECT [Funding line type],[Learner reference number],[Family name], [Given names],[Date of birth],[Planned learning hours],
				[Planned employability, enrichment and pastoral hours],[Total planned hours],[Funding band],[Qualifies for funding],[Total funding], '' AS [OFFICIAL - SENSITIVE]--[Security classification]
		FROM 
		(
		SELECT ROW_NUMBER() OVER (ORDER BY  [SortOrder],[Funding line type],[Learner reference number]) AS [RowNumber],
			[Funding line type],[Learner reference number],[Family name], [Given names],[Date of birth],[Planned learning hours],
				[Planned employability, enrichment and pastoral hours],[Total planned hours],[Funding band],[Qualifies for funding],[Total funding],[SortOrder]--[Security classification]
		FROM 
		(
			SELECT DISTINCT
				l.Fundline as 'Funding line type',
				l.LearnRefNumber as 'Learner reference number',
				l.FamilyName as 'Family name', 
				l.GivenNames as 'Given names',
				l.DateOfBirth as 'Date of birth',
				l.PlanLearnHours as 'Planned learning hours',
				l.PlanEEPHours as 'Planned employability, enrichment and pastoral hours',
				l.[TotalPlannedHours] as 'Total planned hours',
				l.RateBand as 'Funding band',
				l.[QualifiesForFunding]  as 'Qualifies for funding',
				l.OnProgPayment as 'Total funding',				
				--l.[SecurityClassification] as 'Security classification',
				l.SortOrder
			FROM [Report].[EFA1619FundingByStudent] l WITH (NOLOCK) 
			WHERE 
				
				(@ConvertedReferenceDate IS NULL OR l.LearnerStartDate <= @ConvertedReferenceDate) AND
				(ISNULL(@LearnRefNumberFilter, '') = '' OR EXISTS(SELECT TOP 1 1 FROM #LearnRefNumbers lrn WHERE lrn.LearnRefNumber = l.LearnRefNumber)) AND
				(l.ProvSpecMon_A = @ProvSpecLearnMonA OR ISNULL(@ProvSpecLearnMonA, '') = '') AND
				(l.ProvSpecMon_B = @ProvSpecLearnMonB OR ISNULL(@ProvSpecLearnMonB, '') = '') 		
		)[EFA1619Funding]
		)OUTER_SELECT	
		WHERE RowNumber BETWEEN ((@Page - 1) * @PageSize) AND (@Page * @PageSize -1)
	ORDER BY [SortOrder],[Funding line type];

    DROP TABLE #LearnRefNumbers;
END

GO