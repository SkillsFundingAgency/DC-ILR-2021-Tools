IF OBJECT_ID('Report.GetSFAOnProgPayment') IS NOT NULL
BEGIN
    DROP FUNCTION  [Report].[GetSFAOnProgPayment]
END
GO

CREATE FUNCTION [Report].[GetSFAOnProgPayment] (@learnerTypes VARCHAR(MAX), @completeYear bit)
RETURNS decimal(15,5)
AS 
BEGIN
	DECLARE @retValue decimal(15,5);

	SELECT @retValue = (SELECT SUM(CASE @completeYear
				WHEN 0 THEN Total6Months
				WHEN 1 THEN TotalYear END) as ReturnTotal FROM (
		SELECT 0 as Total6Months, 0 as TotalYear
		UNION ALL
		SELECT  SUM(sfap.OnProgPayment_ACM1 + sfap.OnProgPayment_ACM2 + sfap.OnProgPayment_ACM3 +
					 sfap.OnProgPayment_ACM4 + sfap.OnProgPayment_ACM5 + sfap.OnProgPayment_ACM6 + BalancePayment_ACM1 + BalancePayment_ACM2 +
					 BalancePayment_ACM3 + BalancePayment_ACM4 + BalancePayment_ACM5 + BalancePayment_ACM6 + AchievePayment_ACM1 +
					 AchievePayment_ACM2 + AchievePayment_ACM3 + AchievePayment_ACM4 + AchievePayment_ACM5 + AchievePayment_ACM6)  as Total6Months,
			 SUM(sfap.OnProgPayment_ACM1 + sfap.OnProgPayment_ACM2 + sfap.OnProgPayment_ACM3 + sfap.OnProgPayment_ACM4 + sfap.OnProgPayment_ACM5 +
				 sfap.OnProgPayment_ACM6 + sfap.OnProgPayment_ACM7 + sfap.OnProgPayment_ACM8 + sfap.OnProgPayment_ACM9 + sfap.OnProgPayment_ACM10 +
				 sfap.OnProgPayment_ACM11 + sfap.OnProgPayment_ACM12 + BalancePayment_ACM1 + BalancePayment_ACM2 + BalancePayment_ACM3 +
				 BalancePayment_ACM4 + BalancePayment_ACM5 + BalancePayment_ACM6 + BalancePayment_ACM7 + BalancePayment_ACM8 + BalancePayment_ACM9 +
				 BalancePayment_ACM10 + BalancePayment_ACM11 + BalancePayment_ACM12 + AchievePayment_ACM1 + AchievePayment_ACM2 +
				 AchievePayment_ACM3 + AchievePayment_ACM4 + AchievePayment_ACM5 + AchievePayment_ACM6 + AchievePayment_ACM7 + AchievePayment_ACM8 +
				 AchievePayment_ACM9 + AchievePayment_ACM10 + AchievePayment_ACM11 + AchievePayment_ACM12) 
			as TotalYear
				FROM(SELECT DISTINCT LearnRefNumber,AimSeqNumber FROM  Valid.LearningDeliveryDenorm WHERE FundModel IN (25, 35)OR([FundModel] = 99 AND LDFAM_ADL = 1))LD 
			    --INNER JOIN LearningDeliverySFAFund sfaf ON sfaf.LearnRefNumber = LD.LearnRefNumber AND sfaf.AimSeqNumber = [LD].AimSeqNumber
				INNER JOIN [Rulebase].SFA_LearningDelivery sfaf ON sfaf.LearnRefNumber = LD.LearnRefNumber AND sfaf.AimSeqNumber = [LD].AimSeqNumber
				--INNER JOIN LearningDelSFAFundPeriod sfap ON sfap.LearnRefNumber = sfaf.LearnRefNumber and sfap.AimSeqNumber = sfaf.AimSeqNumber
				INNER JOIN [Rulebase].SFA_LearningDeliveryPeriod sfap ON sfap.LearnRefNumber = sfaf.LearnRefNumber and sfap.AimSeqNumber = sfaf.AimSeqNumber
				WHERE sfaf.FundLine IN (SELECT * FROM ConvertCSVToTable(@learnerTypes))) as ReturnTable)
	return @retValue;
END
GO
