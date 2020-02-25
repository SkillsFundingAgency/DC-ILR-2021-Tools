IF OBJECT_ID('Report.GetSFAEmpPayment') IS NOT NULL
BEGIN
    DROP FUNCTION  [Report].[GetSFAEmpPayment]
END
GO

CREATE FUNCTION [Report].[GetSFAEmpPayment](@learnerTypes VARCHAR(MAX), @completeYear bit)
RETURNS decimal(15,5)
AS 
BEGIN
	DECLARE @retValue decimal(15,5);

	SELECT @retValue = (SELECT SUM(CASE @completeYear
				WHEN 0 THEN Total6Months
				WHEN 1 THEN TotalYear END) as ReturnTotal FROM (
		SELECT 0 as Total6Months, 0 as TotalYear
		UNION ALL
		SELECT  SUM(EmpOutcomePay_ACM1 +
					 EmpOutcomePay_ACM2 + EmpOutcomePay_ACM3 + EmpOutcomePay_ACM4 + EmpOutcomePay_ACM5 + EmpOutcomePay_ACM6)  as Total6Months,
			 SUM(EmpOutcomePay_ACM1 +
					 EmpOutcomePay_ACM2 + EmpOutcomePay_ACM3 + EmpOutcomePay_ACM4 + EmpOutcomePay_ACM5 + EmpOutcomePay_ACM6 +
					 EmpOutcomePay_ACM7 + EmpOutcomePay_ACM8 + EmpOutcomePay_ACM9 + EmpOutcomePay_ACM10 + EmpOutcomePay_ACM11 + EmpOutcomePay_ACM12) 
			as TotalYear
				FROM (SELECT DISTINCT LearnRefNumber,AimSeqNumber FROM  Valid.LearningDeliveryDenorm WHERE FundModel IN (25, 35)OR([FundModel] = 99 AND LDFAM_ADL = 1))LD 
			    --INNER JOIN LearningDeliverySFAFund sfaf ON sfaf.LearnRefNumber = LD.LearnRefNumber AND sfaf.AimSeqNumber = [LD].AimSeqNumber
				INNER JOIN [Rulebase].[SFA_LearningDelivery] sfaf ON sfaf.LearnRefNumber = LD.LearnRefNumber AND sfaf.AimSeqNumber = [LD].AimSeqNumber
				--INNER JOIN LearningDelSFAFundPeriod sfap ON sfap.LearnRefNumber = sfaf.LearnRefNumber and sfap.AimSeqNumber = sfaf.AimSeqNumber
				INNER JOIN [Rulebase].[SFA_LearningDeliveryPeriod] sfap ON sfap.LearnRefNumber = sfaf.LearnRefNumber and sfap.AimSeqNumber = sfaf.AimSeqNumber
				WHERE sfaf.FundLine IN (SELECT * FROM ConvertCSVToTable(@learnerTypes))
				) as ReturnTable)
	return @retValue;
END
GO
