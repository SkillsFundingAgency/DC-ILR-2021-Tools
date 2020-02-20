IF OBJECT_ID('Report.GetSFAEFAFundingClaimForType') IS NOT NULL
BEGIN
    DROP FUNCTION  [Report].[GetSFAEFAFundingClaimForType]
END
GO

CREATE FUNCTION [Report].[GetSFAEFAFundingClaimForType] (@learnerTypes VARCHAR(MAX), @completeYear bit)
RETURNS decimal(15,5)
AS 
BEGIN
	DECLARE @retValue decimal(15,5);

	SELECT @retValue = (SELECT SUM(CASE @completeYear
				WHEN 0 THEN Total6Months
				WHEN 1 THEN TotalYear END) as ReturnTotal FROM (
		SELECT 0 as Total6Months, 0 as TotalYear
		UNION ALL
		SELECT SUM(Period_1 + Period_2 + Period_3 + Period_4 + Period_5 + Period_6) as Total6Months,
			SUM(Period_1 + Period_2 + Period_3 + Period_4 + Period_5 + Period_6 +
			Period_7 + Period_8 + Period_9 + Period_10 + Period_11 + Period_12)
			as TotalYear
				FROM (SELECT DISTINCT LearnRefNumber FROM  Valid.LearningDeliveryDenorm WHERE FundModel IN (25, 35)OR([FundModel] = 99 AND LDFAM_ADL = 1))LD 
				--INNER JOIN LearnerEFAFunding sfaf ON sfaf.LearnRefNumber = LD.LearnRefNumber
				INNER JOIN Rulebase.EFA_Learner sfaf ON sfaf.LearnRefNumber = LD.LearnRefNumber
				--INNER JOIN LearnerSFAEFAFundingPeriod sfap ON sfap.LearnRefNumber = sfaf.LearnRefNumber
				INNER JOIN Rulebase.EFA_SFA_Learner_PeriodisedValues sfap ON sfap.LearnRefNumber = sfaf.LearnRefNumber				
				WHERE sfap.AttributeName  = 'LnrOnProgPay' AND sfaf.FundLine IN (SELECT * FROM ConvertCSVToTable(@learnerTypes))) as ReturnTable)				
	return @retValue;
END
GO
