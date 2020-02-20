IF OBJECT_ID('GetSFAFundingForType') IS NOT NULL
BEGIN
    DROP FUNCTION  GetSFAFundingForType
END
GO
CREATE FUNCTION GetSFAFundingForType (@learnerType VARCHAR(MAX), @collectionPeriod int)
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
 as TotalCalc,(FundCalcAug + FundCalcSep + FundCalcOct + FundCalcNov + FundCalcDec + FundCalcJan + FundCalcFeb + FundCalcMar) as AugToMar,
 (FundCalcApr + FundCalcMay + FundCalcJun + FundCalcJul) as AprToJul, * FROM (
	SELECT SUM(FundCalcAug) as FundCalcAug, SUM(FundCalcSep) as FundCalcSep, SUM(FundCalcOct) as FundCalcOct, SUM(FundCalcNov) as FundCalcNov,
		SUM(FundCalcDec) as FundCalcDec, SUM(FundCalcJan) as FundCalcJan, SUM(FundCalcFeb) as FundCalcFeb, SUM(FundCalcMar) as FundCalcMar,
		SUM(FundCalcApr) as FundCalcApr, SUM(FundCalcMay) as FundCalcMay, SUM(FundCalcJun) as FundCalcJun, SUM(FundCalcJul) as FundCalcJul
	FROM
	(SELECT 0 as FundCalcAug, 0 as FundCalcSep, 0 as FundCalcOct, 0 as FundCalcNov, 0 as FundCalcDec, 0 as FundCalcJan,
		0 as FundCalcFeb, 0 as FundCalcMar, 0 as FundCalcApr, 0 as FundCalcMay, 0 as FundCalcJun, 0 as FundCalcJul
	UNION
	SELECT
		SUM(Period_1)  as FundCalcAug,
		SUM(Period_2)  as FundCalcSep,
		SUM(Period_3)  as FundCalcOct,
		SUM(Period_4)  as FundCalcNov,
		SUM(Period_5)  as FundCalcDec,
		SUM(Period_6)  as FundCalcJan,
		SUM(Period_7)  as FundCalcFeb,
		SUM(Period_8)  as FundCalcMar,
		SUM(Period_9)  as FundCalcApr,
		SUM(Period_10) as FundCalcMay,
		SUM(Period_11) as FundCalcJun,
		SUM(Period_12) as FundCalcJul

		from [Rulebase].[FM35_LearningDelivery]sfaf
		LEFT JOIN [Rulebase].[FM35_LearningDelivery_PeriodisedValues] sfap 
		ON sfap.LearnRefNumber = sfaf.LearnRefNumber 
		and sfap.AimSeqNumber = sfaf.AimSeqNumber
		WHERE sfaf.FundLine IN (SELECT * FROM ConvertCSVToTable(@learnerType)) and sfap.AttributeName in ('OnProgPayment','AchievePayment','BalancePayment','EmpOutcomePay')
		GROUP BY sfaf.FundLine) AS ReturnTable) As ReturnTableFinal
)
GO