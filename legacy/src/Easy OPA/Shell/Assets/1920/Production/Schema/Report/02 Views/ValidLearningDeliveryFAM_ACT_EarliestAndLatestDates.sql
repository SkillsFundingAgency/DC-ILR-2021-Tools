
IF OBJECT_ID('[Report].[ValidLearningDeliveryFAM_ACT_EarliestAndLatestDates]') IS NOT NULL
BEGIN
	DROP VIEW [Report].[ValidLearningDeliveryFAM_ACT_EarliestAndLatestDates]
END
GO

CREATE VIEW [Report].[ValidLearningDeliveryFAM_ACT_EarliestAndLatestDates] 
AS

SELECT 
	LearnRefNumber, 
	AimSeqNumber, 
	LearnDelFAMType, 
	LearnDelFAMCode, 
	LearnDelFAMDateFrom, 
	ISNULL(LearnDelFAMDateTo, '9999-12-31') AS LearnDelFAMDateTo
FROM [Valid].[LearningDeliveryFAM]
WHERE LearnDelFAMType ='ACT'


GO

