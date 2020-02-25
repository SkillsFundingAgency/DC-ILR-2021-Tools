
IF OBJECT_ID('[Report].[ValidLearningDeliveryFAM_LSF_EarliestAndLatestDates]') IS NOT NULL
BEGIN
	DROP VIEW [Report].[ValidLearningDeliveryFAM_LSF_EarliestAndLatestDates]
END
GO

CREATE VIEW [Report].[ValidLearningDeliveryFAM_LSF_EarliestAndLatestDates] 
AS

SELECT dates.[LearnRefNumber],dates.[AimSeqNumber],dates.[LearnDelFAMType],maxCode.[LearnDelFAMCode],dates.LearnDelFamDateFrom_Earliest,dates.LearnDelFamDateTo_Latest
FROM
(
SELECT [LearnRefNumber],[AimSeqNumber],[LearnDelFAMType],
			LearnDelFamDateFrom_Earliest = MIN([LearnDelFAMDateFrom]),
			LearnDelFamDateTo_Latest =  MAX([LearnDelFAMDateTo])
	  FROM [Valid].[LearningDeliveryFAM]
	  WHERE LearnDelFAMType  ='LSF'
	  GROUP BY [LearnRefNumber],[AimSeqNumber],[LearnDelFAMType]	
) dates
LEFT JOIN
(
SELECT [LearnRefNumber],[AimSeqNumber],LearnDelFAMCode = MAX(LearnDelFAMCode),[LearnDelFAMType]	
				FROM [Valid].[LearningDeliveryFAM]
				WHERE LearnDelFAMType ='LSF'
				GROUP BY [LearnRefNumber],[AimSeqNumber],[LearnDelFAMType]
) maxCode
on maxCode.LearnRefNumber = dates.LearnRefNumber
and maxCode.AimSeqNumber = dates.AimSeqNumber
and maxCode.LearnDelFAMType = dates.LearnDelFAMType


GO


