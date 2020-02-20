
IF  EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[EFAHNSDetailCount]') AND type in (N'P',N'PC'))
BEGIN
DROP PROCEDURE [Report].[EFAHNSDetailCount]
END

GO

CREATE Procedure [Report].[EFAHNSDetailCount]	
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

	
		SELECT		count(*)
		FROM [Report].[EFAHNSDetailReport]
		WHERE  (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate) AND
				(ISNULL(@LearnRefNumberFilter, '') = '' OR EXISTS(SELECT TOP 1 1 FROM #LearnRefNumbers lrn WHERE lrn.LearnRefNumber = [Learner Reference])) AND
				(ProvSpecMon_A = @ProvSpecLearnMonA OR ISNULL(@ProvSpecLearnMonA, '') = '') AND
				(ProvSpecMon_B = @ProvSpecLearnMonB OR ISNULL(@ProvSpecLearnMonB, '') = '') 

END