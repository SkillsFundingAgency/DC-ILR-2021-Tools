IF OBJECT_ID('Report.GetSFAFundingForType') IS NOT NULL
BEGIN
    DROP FUNCTION  [Report].[GetSFAFundingForType]
END
GO
CREATE FUNCTION [Report].[GetSFAFundingForType] (@learnerType VARCHAR(MAX), @collectionPeriod int)
RETURNS TABLE
AS 
RETURN
(
	SELECT (
	CASE @collectionPeriod
		WHEN 1 THEN FundCalcAug
		WHEN 2 THEN FundCalcAug + FundCalcSep
		WHEN 3 THEN FundCalcAug + FundCalcSep + FundCalcOct
		WHEN 4 THEN FundCalcAug + FundCalcSep + FundCalcOct + FundCalcNov
		WHEN 5 THEN FundCalcAug + FundCalcSep + FundCalcOct + FundCalcNov + FundCalcDec
		WHEN 6 THEN FundCalcAug + FundCalcSep + FundCalcOct + FundCalcNov + FundCalcDec + FundCalcJan
		WHEN 7 THEN FundCalcAug + FundCalcSep + FundCalcOct + FundCalcNov + FundCalcDec + FundCalcJan + FundCalcFeb
		WHEN 8 THEN FundCalcAug + FundCalcSep + FundCalcOct + FundCalcNov + FundCalcDec + FundCalcJan + FundCalcFeb + FundCalcMar
		WHEN 9 THEN FundCalcAug + FundCalcSep + FundCalcOct + FundCalcNov + FundCalcDec + FundCalcJan + FundCalcFeb + FundCalcMar + FundCalcApr
		WHEN 10 THEN FundCalcAug + FundCalcSep + FundCalcOct + FundCalcNov + FundCalcDec + FundCalcJan + FundCalcFeb + FundCalcMar + FundCalcApr + FundCalcMay
		WHEN 11 THEN FundCalcAug + FundCalcSep + FundCalcOct + FundCalcNov + FundCalcDec + FundCalcJan + FundCalcFeb + FundCalcMar + FundCalcApr + FundCalcMay + FundCalcJun
		ELSE FundCalcAug + FundCalcSep + FundCalcOct + FundCalcNov + FundCalcDec + FundCalcJan + FundCalcFeb + FundCalcMar + FundCalcApr + FundCalcMay + FundCalcJun + FundCalcJul
	END
) as YTDCalc, (FundCalcAug + FundCalcSep + FundCalcOct + FundCalcNov + FundCalcDec + FundCalcJan + FundCalcFeb + FundCalcMar + FundCalcApr + FundCalcMay + FundCalcJun + FundCalcJul)
 as TotalCalc, * FROM (
	SELECT SUM(FundCalcAug) as FundCalcAug, SUM(FundCalcSep) as FundCalcSep, SUM(FundCalcOct) as FundCalcOct, SUM(FundCalcNov) as FundCalcNov,
		SUM(FundCalcDec) as FundCalcDec, SUM(FundCalcJan) as FundCalcJan, SUM(FundCalcFeb) as FundCalcFeb, SUM(FundCalcMar) as FundCalcMar,
		SUM(FundCalcApr) as FundCalcApr, SUM(FundCalcMay) as FundCalcMay, SUM(FundCalcJun) as FundCalcJun, SUM(FundCalcJul) as FundCalcJul
	FROM
	(SELECT 0 as FundCalcAug, 0 as FundCalcSep, 0 as FundCalcOct, 0 as FundCalcNov, 0 as FundCalcDec, 0 as FundCalcJan,
		0 as FundCalcFeb, 0 as FundCalcMar, 0 as FundCalcApr, 0 as FundCalcMay, 0 as FundCalcJun, 0 as FundCalcJul
	UNION
	SELECT SUM(sfap.AchievePayment_ACM1 + sfap.OnProgPayment_ACM1 + sfap.BalancePayment_ACM1) as FundCalcAug,
		SUM(sfap.AchievePayment_ACM2 + sfap.OnProgPayment_ACM2 + sfap.BalancePayment_ACM2) as FundCalcSep,
		SUM(sfap.AchievePayment_ACM3 + sfap.OnProgPayment_ACM3 + sfap.BalancePayment_ACM3) as FundCalcOct,
		SUM(sfap.AchievePayment_ACM4 + sfap.OnProgPayment_ACM4 + sfap.BalancePayment_ACM4) as FundCalcNov,
		SUM(sfap.AchievePayment_ACM5 + sfap.OnProgPayment_ACM5 + sfap.BalancePayment_ACM5) as FundCalcDec,
		SUM(sfap.AchievePayment_ACM6 + sfap.OnProgPayment_ACM6 + sfap.BalancePayment_ACM6) as FundCalcJan,
		SUM(sfap.AchievePayment_ACM7 + sfap.OnProgPayment_ACM7 + sfap.BalancePayment_ACM7) as FundCalcFeb,
		SUM(sfap.AchievePayment_ACM8 + sfap.OnProgPayment_ACM8 + sfap.BalancePayment_ACM8) as FundCalcMar,
		SUM(sfap.AchievePayment_ACM9 + sfap.OnProgPayment_ACM9 + sfap.BalancePayment_ACM9) as FundCalcApr,
		SUM(sfap.AchievePayment_ACM10 + sfap.OnProgPayment_ACM10 + sfap.BalancePayment_ACM10) as FundCalcMay,
		SUM(sfap.AchievePayment_ACM11 + sfap.OnProgPayment_ACM11 + sfap.BalancePayment_ACM11) as FundCalcJun,
		SUM(sfap.AchievePayment_ACM12 + sfap.OnProgPayment_ACM12 + sfap.BalancePayment_ACM12) as FundCalcJul
		--from LearningDeliverySFAFund sfaf
		--LEFT JOIN LearningDelSFAFundPeriod sfap 
		--ON sfap.LearnRefNumber = sfaf.LearnRefNumber 
		--and sfap.AimSeqNumber = sfaf.AimSeqNumber
		FROM [Rulebase].[SFA_LearningDelivery] sfaf
		LEFT JOIN [Rulebase].[SFA_LearningDeliveryPeriod] sfap ON sfap.LearnRefNumber = sfaf.LearnRefNumber and sfap.AimSeqNumber = sfaf.AimSeqNumber
		WHERE sfaf.FundLine  IN (SELECT * FROM ConvertCSVToTable(@learnerType))
		GROUP BY sfaf.FundLine) AS ReturnTable) As ReturnTableFinal
)
GO
