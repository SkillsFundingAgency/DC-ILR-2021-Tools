
IF  EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[EFAHNSDetailReportData]') AND type in (N'P',N'PC'))
BEGIN
DROP PROCEDURE [Report].[EFAHNSDetailReportData]
END

GO

CREATE Procedure [Report].[EFAHNSDetailReportData]
	@Page int,
	@PageSize int,
  	@ReferenceDate VARCHAR(50) = NULL,
	@LearnRefNumberFilter VARCHAR(50) = NULL,	
	@ProvSpecLearnMonA VARCHAR(50) = NULL,
	@ProvSpecLearnMonB VARCHAR(50) = NULL
AS
BEGIN

	SELECT LTRIM(RTRIM((stringVal))) as LearnRefNumber into #LearnRefNumbers FROM dbo.ConvertCSVToTable(ISNULL(@LearnRefNumberFilter, ''));
	DELETE FROM #LearnRefNumbers WHERE ISNULL(LearnRefNumber, '') = '';

	DECLARE @ConvertedReferenceDate datetime = 
		(SELECT CASE @ReferenceDate WHEN ' ' THEN NULL ELSE CONVERT (datetime, @ReferenceDate, 103)END)

	SELECT 
	 	[Fund Line] AS [Funding line type],
		[Learner Reference] AS [Learner reference number],	
		[Surname] AS  [Family name],
		[Forename] AS [Given names],
		[A - Students with an EHCP],
        [B - Students without an EHCP],
        [C - High Needs Students (HNS) without an EHCP],
        [D - Students with an EHCP and HNS],
        [E - Students with an EHCP but without HNS],
        --[F - Students with an LDA],	
		[OFFICIAL – SENSITIVE]
	FROM
	(
		SELECT		ROW_NUMBER() OVER (ORDER BY  [Fund Line], [Learner Reference]) AS [RowNumber],
					[Fund Line],
					[Learner Reference],
					[Surname],
					[Forename],
					[A - Students with an EHCP],
					[B - Students without an EHCP],
					[C - High Needs Students (HNS) without an EHCP],
					[D - Students with an EHCP and HNS],
					[E - Students with an EHCP but without HNS],
					--[F - Students with an LDA],	
					'' as 'OFFICIAL – SENSITIVE',
					SortOrder
		FROM [Report].[EFAHNSDetailReport]
		WHERE  (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate) AND
				(ISNULL(@LearnRefNumberFilter, '') = '' OR EXISTS(SELECT TOP 1 1 FROM #LearnRefNumbers lrn WHERE lrn.LearnRefNumber = [Learner Reference])) AND
				(ProvSpecMon_A = @ProvSpecLearnMonA OR ISNULL(@ProvSpecLearnMonA, '') = '') AND
				(ProvSpecMon_B = @ProvSpecLearnMonB OR ISNULL(@ProvSpecLearnMonB, '') = '') 
	) HighNeedsStudentsReport
	WHERE RowNumber BETWEEN ((@Page - 1) * @PageSize) AND (@Page * @PageSize - 1)
	ORDER BY [SortOrder], [Fund Line], [Learner Reference]	

END