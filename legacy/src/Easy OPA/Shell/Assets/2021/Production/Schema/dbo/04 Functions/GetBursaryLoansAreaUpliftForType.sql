IF OBJECT_ID('GetBursaryLoansAreaUpliftForType') IS NOT NULL
BEGIN
    DROP FUNCTION  GetBursaryLoansAreaUpliftForType
END
GO
CREATE FUNCTION GetBursaryLoansAreaUpliftForType (@learnerType VARCHAR(MAX), @collectionPeriod int)
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
 as TotalCalc, (FundCalcAug + FundCalcSep + FundCalcOct + FundCalcNov + FundCalcDec + FundCalcJan + FundCalcFeb + FundCalcMar) as AugToMar,
 (FundCalcApr + FundCalcMay + FundCalcJun + FundCalcJul) as AprToJul,* FROM (
	SELECT SUM(FundCalcAug) as FundCalcAug, SUM(FundCalcSep) as FundCalcSep, SUM(FundCalcOct) as FundCalcOct, SUM(FundCalcNov) as FundCalcNov,
		SUM(FundCalcDec) as FundCalcDec, SUM(FundCalcJan) as FundCalcJan, SUM(FundCalcFeb) as FundCalcFeb, SUM(FundCalcMar) as FundCalcMar,
		SUM(FundCalcApr) as FundCalcApr, SUM(FundCalcMay) as FundCalcMay, SUM(FundCalcJun) as FundCalcJun, SUM(FundCalcJul) as FundCalcJul
	FROM
	(SELECT 0 as FundCalcAug, 0 as FundCalcSep, 0 as FundCalcOct, 0 as FundCalcNov, 0 as FundCalcDec, 0 as FundCalcJan,
		0 as FundCalcFeb, 0 as FundCalcMar, 0 as FundCalcApr, 0 as FundCalcMay, 0 as FundCalcJun, 0 as FundCalcJul
	UNION
	SELECT
		SUM(sfap.Period_1)  as FundCalcAug,
		SUM(sfap.Period_2)  as FundCalcSep,
		SUM(sfap.Period_3)  as FundCalcOct,
		SUM(sfap.Period_4)  as FundCalcNov,
		SUM(sfap.Period_5)  as FundCalcDec,
		SUM(sfap.Period_6)  as FundCalcJan,
		SUM(sfap.Period_7)  as FundCalcFeb,
		SUM(sfap.Period_8)  as FundCalcMar,
		SUM(sfap.Period_9)  as FundCalcApr,
		SUM(sfap.Period_10) as FundCalcMay,
		SUM(sfap.Period_11) as FundCalcJun,
		SUM(sfap.Period_12) as FundCalcJul

		from [Rulebase].[ALB_LearningDelivery] sfaf
		LEFT JOIN [Rulebase].[ALB_LearningDelivery_PeriodisedValues] sfap ON sfap.LearnRefNumber = sfaf.LearnRefNumber and sfap.AimSeqNumber =sfaf.AimSeqNumber
		WHERE sfaf.FundLine = @learnerType and sfap.AttributeName in ('AreaUpliftBalPayment','AreaUpliftOnProgPayment')
		GROUP BY sfaf.FundLine) AS ReturnTable) As ReturnTableFinal
)
GO
