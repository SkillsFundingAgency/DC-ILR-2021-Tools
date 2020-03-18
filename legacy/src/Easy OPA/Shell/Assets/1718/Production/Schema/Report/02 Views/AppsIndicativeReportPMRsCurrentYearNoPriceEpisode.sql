 IF OBJECT_ID('[Report].[AppsIndicativeReportPMRsCurrentYearNoPriceEpisode]') IS NOT NULL
 BEGIN
	 DROP VIEW [Report].[AppsIndicativeReportPMRsCurrentYearNoPriceEpisode]
 END
 GO	

CREATE VIEW [Report].[AppsIndicativeReportPMRsCurrentYearNoPriceEpisode]
AS
	SELECT LD.LearnRefNumber, LD.AimSeqNumber,
		SUM(ISNULL(AFR1.AFinAmount, 0)) AS PMR1, 
		SUM(ISNULL(AFR2.AFinAmount, 0)) AS PMR2, 
		SUM(ISNULL(AFR3.AFinAmount, 0)) AS PMR3,
		SUM(ISNULL(AFR1.AFinAmount, 0) + ISNULL(AFR2.AFinAmount, 0) - ISNULL(AFR3.AFinAmount, 0)) AS PMRTotal
	FROM Valid.LearningDelivery AS LD 
		LEFT OUTER JOIN Rulebase.AEC_ApprenticeshipPriceEpisode AS PE 
			ON LD.LearnRefNumber = PE.LearnRefNumber 
			AND LD.AimSeqNumber = PE.PriceEpisodeAimSeqNumber 
			AND (PE.EpisodeStartDate >= '${YearStartDate}') 
			AND (PE.EpisodeStartDate <= '${YearEndDate}') 
		LEFT OUTER JOIN Valid.AppFinRecord AS AFR1 
			ON AFR1.LearnRefNumber = LD.LearnRefNumber 
			AND AFR1.AimSeqNumber = LD.AimSeqNumber 
			AND AFR1.AFinType = 'PMR' 
			AND AFR1.AFinCode = 1 
			AND AFR1.AFinDate >= '${YearStartDate}'
			AND AFR1.AFinDate <= '${YearEndDate}' 
		LEFT OUTER JOIN Valid.AppFinRecord AS AFR2 
			ON AFR2.LearnRefNumber = LD.LearnRefNumber 
			AND AFR2.AimSeqNumber = LD.AimSeqNumber  
			AND AFR2.AFinType = 'PMR' 
			AND AFR2.AFinCode = 2 
			AND AFR2.AFinDate >= '${YearStartDate}'
			AND AFR2.AFinDate <= '${YearEndDate}' 
		LEFT OUTER JOIN Valid.AppFinRecord AS AFR3 
			ON AFR3.LearnRefNumber = LD.LearnRefNumber 
			AND AFR3.AimSeqNumber = LD.AimSeqNumber 
			AND AFR3.AFinType = 'PMR' 
			AND AFR3.AFinCode = 3 
			AND AFR3.AFinDate >= '${YearStartDate}'
			AND AFR3.AFinDate <= '${YearEndDate}' 	
	WHERE PE.PriceEpisodeIdentifier IS NULL
	GROUP BY LD.LearnRefNumber, LD.AimSeqNumber, PE.PriceEpisodeIdentifier, AFR1.AFinAmount, AFR2.AFinAmount, AFR3.AFinAmount
	HAVING SUM(ISNULL(AFR1.AFinAmount, 0) + ISNULL(AFR2.AFinAmount, 0) - ISNULL(AFR3.AFinAmount, 0)) > 0
GO










