IF OBJECT_ID('Report.GetSFALearnSuppFundCash') IS NOT NULL
BEGIN
    DROP FUNCTION  [Report].[GetSFALearnSuppFundCash]
END
GO

CREATE FUNCTION [Report].[GetSFALearnSuppFundCash] (@learnerTypes VARCHAR(MAX), @completeYear bit)
RETURNS decimal(15,5)
AS 
BEGIN
	DECLARE @retValue decimal(15,5);

	SELECT @retValue = (SELECT SUM(CASE @completeYear
				WHEN 0 THEN Total6Months
				WHEN 1 THEN TotalYear END) as ReturnTotal FROM (
		SELECT 0 as Total6Months, 0 as TotalYear
		UNION ALL
		SELECT  SUM(sfap.LearnSuppFundCash_ACM1 + sfap.LearnSuppFundCash_ACM2 + sfap.LearnSuppFundCash_ACM3 + 
					sfap.LearnSuppFundCash_ACM4 + sfap.LearnSuppFundCash_ACM5 + sfap.LearnSuppFundCash_ACM6) as Total6Months,
			SUM(sfap.LearnSuppFundCash_ACM1 + sfap.LearnSuppFundCash_ACM2 + sfap.LearnSuppFundCash_ACM3 + 
					sfap.LearnSuppFundCash_ACM4 + sfap.LearnSuppFundCash_ACM5 + sfap.LearnSuppFundCash_ACM6 + sfap.LearnSuppFundCash_ACM7 +
					sfap.LearnSuppFundCash_ACM8 + sfap.LearnSuppFundCash_ACM9 + sfap.LearnSuppFundCash_ACM10 + sfap.LearnSuppFundCash_ACM11 +
					sfap.LearnSuppFundCash_ACM12)
			as TotalYear
				FROM (SELECT DISTINCT LearnRefNumber,AimSeqNumber FROM  Valid.LearningDeliveryDenorm WHERE FundModel IN (25, 35)OR([FundModel] = 99 AND LDFAM_ADL = 1))LD 
			    --INNER JOIN LearningDeliverySFAFund sfaf ON sfaf.LearnRefNumber = LD.LearnRefNumber AND sfaf.AimSeqNumber = [LD].AimSeqNumber
				INNER JOIN [Rulebase].[SFA_LearningDelivery] sfaf ON sfaf.LearnRefNumber = LD.LearnRefNumber AND sfaf.AimSeqNumber = [LD].AimSeqNumber
				--INNER JOIN LearningDelSFAFundPeriod sfap ON sfap.LearnRefNumber = sfaf.LearnRefNumber and sfap.AimSeqNumber = sfaf.AimSeqNumber				
				INNER JOIN [Rulebase].[SFA_LearningDeliveryPeriod] sfap ON sfap.LearnRefNumber = sfaf.LearnRefNumber and sfap.AimSeqNumber = sfaf.AimSeqNumber		

				WHERE sfaf.FundLine IN (SELECT * FROM ConvertCSVToTable(@learnerTypes))) as ReturnTable)
	return @retValue;
END
GO
