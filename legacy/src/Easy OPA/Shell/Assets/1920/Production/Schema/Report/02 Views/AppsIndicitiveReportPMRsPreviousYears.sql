 
IF OBJECT_ID('Report.GetValidAppFinRecordPreviousYears') IS NOT NULL
BEGIN
	DROP FUNCTION Report.GetValidAppFinRecordPreviousYears
END
GO

CREATE FUNCTION [Report].[GetValidAppFinRecordPreviousYears] (@LearnRefNumber varchar(12),@AimSeqNumber int,@AFinCode int)
RETURNS INT
AS 
BEGIN
DECLARE @summed int
	SELECT
	@summed = SUM(ISNULL(AFinAmount,0)) 
	from [Valid].[AppFinRecord]
	where [AFinType] = 'PMR' AND LearnRefNumber = @LearnRefNumber
	AND AFinDate < '${YearStartDate}' 
	AND AFinCode = @AFinCode AND AimSeqNumber = @AimSeqNumber
	GROUP BY  LearnRefNumber,AimSeqNumber,AFinType,AFinCode
	return @summed
END
GO

 IF OBJECT_ID('[Report].[AppsIndicitiveReportPMRsPreviousYears]') IS NOT NULL
 BEGIN
	 DROP VIEW [Report].[AppsIndicitiveReportPMRsPreviousYears]
 END
 GO	

create view [Report].[AppsIndicitiveReportPMRsPreviousYears]
as
SELECT 
	pe.LearnRefNumber, PriceEpisodeIdentifier, 
	EpisodeEffectiveTNPStartDate, 
	pe.EpisodeStartDate, 
	PriceEpisodeActualEndDate, 
	PriceEpisodeActualInstalments, 
	MinPmrBaseTables.PriceEpisodeAimSeqNumber, 
	--Sum here to handle different PM values recorded against same Aim/Price Episode
	SUM(MinPmrBaseTables.TNP1) AS TNP1, 
	SUM(MinPmrBaseTables.TNP2) AS TNP2, 
	SUM(MinPmrBaseTables.TNP3) AS TNP3, 
	SUM(MinPmrBaseTables.TNP4) AS TNP4, 
	SUM(MinPmrBaseTables.TNPTotal) AS TNPTotal

FROM 
	[Rulebase].[AEC_ApprenticeshipPriceEpisode] pe 
INNER JOIN 
	(
	--Assign values to earliest Episode Start date per Aim sequence
	SELECT
		MIN(EpisodeStartDate) "EpisodeStartDate",
		 LearnRefNumber, 
		 PriceEpisodeAimSeqNumber,
		 TNP1, 
		 TNP2,
		 TNP3, 
		 TNP4,
		 TNPTotal
	FROM
	(
	--Handles same PMR values for same price episodes
		SELECT
			PriceEpisodeIdentifier,
			EpisodeStartDate,
			LearnRefNumber, 
			PriceEpisodeAimSeqNumber,
			ISNULL(TNP1,0) AS TNP1, 
			ISNULL(TNP2,0) AS TNP2, 
			ISNULL(TNP3,0) AS TNP3,  
			ISNULL(TNP4,0) AS TNP4, 
			((ISNULL(TNP1,0)+ISNULL(TNP2,0)) -ISNULL(TNP3,0)) as TNPTotal
			
		FROM
		(
			SELECT
			pe.PriceEpisodeIdentifier,
			EpisodeStartDate,
			pe.LearnRefNumber, 
			pe.PriceEpisodeAimSeqNumber,
			[Report].[GetValidAppFinRecordPreviousYears] (pe.LearnRefNumber,pe.PriceEpisodeAimSeqNumber ,1) AS TNP1, 
			[Report].[GetValidAppFinRecordPreviousYears] (pe.LearnRefNumber,pe.PriceEpisodeAimSeqNumber ,2) AS TNP2,
			[Report].[GetValidAppFinRecordPreviousYears] (pe.LearnRefNumber,pe.PriceEpisodeAimSeqNumber ,3) AS TNP3, 
			[Report].[GetValidAppFinRecordPreviousYears] (pe.LearnRefNumber,pe.PriceEpisodeAimSeqNumber ,4) AS TNP4										
			from Rulebase.AEC_ApprenticeshipPriceEpisode pe			
			WHERE pe.EpisodeStartDate >= '${YearStartDate}' and pe.EpisodeStartDate <= '${YearEndDate}'			
		) PmrBaseEpisodes
	)PmrReSum
	
	GROUP BY  LearnRefNumber,  PriceEpisodeAimSeqNumber, TNP1,  TNP2, TNP3,  TNP4, TNPTotal

) MinPmrBaseTables
on MinPmrBaseTables.LearnRefNumber = pe.LearnRefNumber
and MinPmrBaseTables.EpisodeStartDate = pe.EpisodeStartDate 
and MinPmrBaseTables.PriceEpisodeAimSeqNumber = pe.PriceEpisodeAimSeqNumber
GROUP BY pe.LearnRefNumber, PriceEpisodeIdentifier, EpisodeEffectiveTNPStartDate, pe.EpisodeStartDate, PriceEpisodeActualEndDate, 
	PriceEpisodeActualInstalments, 
	MinPmrBaseTables.PriceEpisodeAimSeqNumber



GO






