IF OBJECT_ID('Report.GetSFAEASForType') IS NOT NULL
BEGIN
    DROP FUNCTION  [Report].[GetSFAEASForType]
END
GO

CREATE FUNCTION [Report].[GetSFAEASForType] (@learnerTypes VARCHAR(MAX), @completeYear bit)
RETURNS decimal(15,5)
AS 
BEGIN

	DECLARE @retValue decimal(15,5);

	SELECT @retValue = (SELECT SUM(CASE @completeYear
				WHEN 0 THEN Total6Months
				WHEN 1 THEN TotalYear END) as ReturnTotal FROM (
		SELECT 0 as Total6Months, 0 as TotalYear
		UNION ALL
		SELECT (CASE WHEN pay.CollectionPeriod BETWEEN 1 AND 6 THEN SUM(PaymentValue) END) AS Total6Months,
			(CASE WHEN pay.CollectionPeriod BETWEEN 1 AND 12 THEN SUM(PaymentValue) END) AS TotalYear
			FROM Valid.LearningProvider lp
			INNER JOIN  [Reference].[PFR_EAS] pay(nolock) ON lp.UKPRN = pay.UKPRN			
			WHERE pay.PaymentName IN (SELECT * FROM ConvertCSVToTable(@learnerTypes))
			GROUP BY pay.CollectionPeriod
			) as ReturnTable)
	return @retValue;
END
GO

IF OBJECT_ID('Report.GetSFAClaimBursaryFunding') IS NOT NULL
BEGIN
    DROP FUNCTION  [Report].[GetSFAClaimBursaryFunding]
END
GO

CREATE FUNCTION [Report].[GetSFAClaimBursaryFunding]()
RETURNS TABLE
AS 
RETURN
(
	SELECT SUM(AlbTotal6Months) AS AlbTotal6Months, SUM(AlbTotalYear) as AlbTotalYear, SUM(AlbTotalSupp6Months) AS AlbTotalSupp6Months,
			 SUM(AlbTotalSuppYear) AS AlbTotalSuppYear,	SUM(AlbExcessSupport6Months) AS AlbExcessSupport6Months, 
			 SUM(AlbExcessSupportYear) AS AlbExcessSupportYear FROM (
		SELECT 0 AS AlbTotal6Months, 0 AS AlbTotalYear, 0 as AlbTotalSupp6Months, 0 AS AlbTotalSuppYear,
			   0 AS AlbExcessSupport6Months, 0 AS AlbExcessSupportYear
		UNION ALL
		SELECT SUM(sfap.AreaUpliftBalPayment_ACM1 + sfap.AreaUpliftBalPayment_ACM2 + sfap.AreaUpliftBalPayment_ACM3 +
					sfap.AreaUpliftBalPayment_ACM4 + sfap.AreaUpliftBalPayment_ACM5 + sfap.AreaUpliftBalPayment_ACM6 + 
					sfap.AreaUpliftOnProgPayment_ACM1 + sfap.AreaUpliftOnProgPayment_ACM2 + sfap.AreaUpliftOnProgPayment_ACM3 +
					sfap.AreaUpliftOnProgPayment_ACM4 + sfap.AreaUpliftOnProgPayment_ACM5 + sfap.AreaUpliftOnProgPayment_ACM6) AS AlbTotal6months,
			SUM(sfap.AreaUpliftBalPayment_ACM1 + sfap.AreaUpliftBalPayment_ACM2 + sfap.AreaUpliftBalPayment_ACM3 +
					sfap.AreaUpliftBalPayment_ACM4 + sfap.AreaUpliftBalPayment_ACM5 + sfap.AreaUpliftBalPayment_ACM6 +
					sfap.AreaUpliftBalPayment_ACM7 + sfap.AreaUpliftBalPayment_ACM8 + sfap.AreaUpliftBalPayment_ACM9 +
					sfap.AreaUpliftBalPayment_ACM10 + sfap.AreaUpliftBalPayment_ACM11 + sfap.AreaUpliftBalPayment_ACM12 +
					sfap.AreaUpliftOnProgPayment_ACM1 + sfap.AreaUpliftOnProgPayment_ACM2 + sfap.AreaUpliftOnProgPayment_ACM3 +
					sfap.AreaUpliftOnProgPayment_ACM4 + sfap.AreaUpliftOnProgPayment_ACM5 + sfap.AreaUpliftOnProgPayment_ACM6 +
					sfap.AreaUpliftOnProgPayment_ACM7 + sfap.AreaUpliftOnProgPayment_ACM8 + sfap.AreaUpliftOnProgPayment_ACM9 +
					sfap.AreaUpliftOnProgPayment_ACM10 + sfap.AreaUpliftOnProgPayment_ACM11 + sfap.AreaUpliftOnProgPayment_ACM12) AS AlbTotalYear,
			SUM(sfap.ALBSupportPayment_ACM1 + sfap.ALBSupportPayment_ACM2 + sfap.ALBSupportPayment_ACM3 +
					sfap.ALBSupportPayment_ACM4 + sfap.ALBSupportPayment_ACM5 + sfap.ALBSupportPayment_ACM6) AS AlbTotalSupp6Months,
			SUM(sfap.ALBSupportPayment_ACM1 + sfap.ALBSupportPayment_ACM2 + sfap.ALBSupportPayment_ACM3 +
					sfap.ALBSupportPayment_ACM4 + sfap.ALBSupportPayment_ACM5 + sfap.ALBSupportPayment_ACM6 +
					sfap.ALBSupportPayment_ACM7 + sfap.ALBSupportPayment_ACM8 + sfap.ALBSupportPayment_ACM9 +
					sfap.ALBSupportPayment_ACM10 + sfap.ALBSupportPayment_ACM11 + sfap.ALBSupportPayment_ACM12) AS AlbTotalSuppYear,
			0 AS AlbExcessSupport6Months,
	        0 AS AlbExcessSupportYear
			FROM (SELECT DISTINCT LearnRefNumber,AimSeqNumber FROM  [Valid].[LearningDeliveryDenorm] WHERE FundModel IN (25, 35)OR([FundModel] = 99 AND LDFAM_ADL = 1))LD 
			INNER JOIN [Rulebase].[ALB_LearningDelivery] sfaf ON LD.LearnRefNumber= sfaF.LearnRefNumber AND LD.AimSeqNumber=sfaf.AimSeqNumber
			INNER JOIN [Rulebase].[ALB_LearningDeliveryPeriod] sfap ON sfap.LearnRefNumber = sfaf.LearnRefNumber  and sfap.AimSeqNumber =sfaf.AimSeqNumber	
			WHERE sfaf.FundLine = 'Advanced Learner Loans Bursary'
			GROUP BY sfaf.FundLine
			UNION ALL
		SELECT (SELECT [Report].GetSFAEASForType('Audit Adjustments: Advanced Learner Loans Bursary', 0)) AS AlbTotal6months,
			   (SELECT [Report].GetSFAEASForType('Audit Adjustments: Advanced Learner Loans Bursary', 1)) AS AlbTotalYear,
			   0 AS AlbTotalSupp6Months,
			   0 AS AlbTotalSuppYear,
			   (SELECT [Report].GetSFAEASForType('Excess Support: Advanced Learner Loans Bursary', 0)) AS AlbExcessSupport6Months,
			   (SELECT [Report].GetSFAEASForType('Excess Support: Advanced Learner Loans Bursary', 1)) AS AlbExcessSupportYear
			) AS ReturnTable
)
GO
