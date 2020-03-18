IF OBJECT_ID('Report.GetTrailblazerLearnSuppFundCash') IS NOT NULL
BEGIN
    DROP FUNCTION  [Report].[GetTrailblazerLearnSuppFundCash]
END
GO

CREATE FUNCTION [Report].[GetTrailblazerLearnSuppFundCash] (@learnerTypes VARCHAR(MAX), @completeYear bit)
RETURNS decimal(15,5)
AS 
BEGIN
	DECLARE @retValue decimal(15,5);

	SELECT @retValue = (SELECT SUM(CASE @completeYear
				WHEN 0 THEN Total6Months 
				WHEN 1 THEN TotalYear END) as ReturnTotal FROM (
		SELECT 0 as Total6Months, 0 as TotalYear
		UNION ALL
		--SELECT  SUM(LDTFP.LearnSuppFundCash_ACM1 + LDTFP.LearnSuppFundCash_ACM2 + LDTFP.LearnSuppFundCash_ACM3 + 
		--			LDTFP.LearnSuppFundCash_ACM4 + LDTFP.LearnSuppFundCash_ACM5 + LDTFP.LearnSuppFundCash_ACM6) as Total6Months,
		--	SUM(LDTFP.LearnSuppFundCash_ACM1 + LDTFP.LearnSuppFundCash_ACM2 + LDTFP.LearnSuppFundCash_ACM3 + 
		--			LDTFP.LearnSuppFundCash_ACM4 + LDTFP.LearnSuppFundCash_ACM5 + LDTFP.LearnSuppFundCash_ACM6 + LDTFP.LearnSuppFundCash_ACM7 +
		--			LDTFP.LearnSuppFundCash_ACM8 + LDTFP.LearnSuppFundCash_ACM9 + LDTFP.LearnSuppFundCash_ACM10 + LDTFP.LearnSuppFundCash_ACM11 +
		--			LDTFP.LearnSuppFundCash_ACM12)
		--	as TotalYear
		SELECT 
			SUM(CASE WHEN AttributeName = 'LearnSuppFundCash' THEN Period_1 + Period_2 + Period_3 + Period_4 + Period_5 + Period_6 ELSE 0 END) AS Total6Months,
			SUM(CASE WHEN AttributeName = 'LearnSuppFundCash' THEN Period_1 + Period_2 + Period_3 + Period_4 + Period_5 + Period_6 + PERIOD_7 + Period_8 + Period_9 + Period_10 + Period_11 + Period_12 ELSE 0 END) AS TotalYear
		FROM (SELECT DISTINCT LearnRefNumber, AimSeqNumber FROM [Rulebase].[TBL_LearningDelivery] WHERE FundLine IN (SELECT * FROM ConvertCSVToTable(@learnerTypes)))LD
		INNER JOIN [Rulebase].[TBL_LearningDelivery_PeriodisedValues] LDPV ON LD.LearnRefNumber = LDPV.LearnRefNumber AND LD.AimSeqNumber = LDPV.AimSeqNumber) AS ReturnTable)

				--FROM (SELECT DISTINCT LearnRefNumber,AimSeqNumber FROM  LearningDelivery WHERE FundModel =81 AND ProgType = 25)LD 
			 --   INNER JOIN LearningDelTrailblazerFund LDTF ON LDTF.LearnRefNumber = LD.LearnRefNumber AND LDTF.AimSeqNumber = [LD].AimSeqNumber
				--INNER JOIN LearningDelTrailblazerFundPeriod LDTFP ON LDTFP.LearnRefNumber = LDTF.LearnRefNumber and LDTFP.AimSeqNumber = LDTF.AimSeqNumber
				--WHERE LDTF.FundLine IN (SELECT * FROM ConvertCSVToTable(@learnerTypes))) as ReturnTable)
	return @retValue;
END
GO