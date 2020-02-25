IF OBJECT_ID('GetTrailblazerOnProgFundingForType') IS NOT NULL
BEGIN
    DROP FUNCTION  GetTrailblazerOnProgFundingForType
END
GO

CREATE FUNCTION GetTrailblazerOnProgFundingForType (@learnerType VARCHAR(MAX), @collectionPeriod int)
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
		SUM(tbfp.Period_1)  as FundCalcAug,
		SUM(tbfp.Period_2)  as FundCalcSep,
		SUM(tbfp.Period_3)  as FundCalcOct,
		SUM(tbfp.Period_4)  as FundCalcNov,
		SUM(tbfp.Period_5)  as FundCalcDec,
		SUM(tbfp.Period_6)  as FundCalcJan,
		SUM(tbfp.Period_7)  as FundCalcFeb,
		SUM(tbfp.Period_8)  as FundCalcMar,
		SUM(tbfp.Period_9)  as FundCalcApr,
		SUM(tbfp.Period_10) as FundCalcMay,
		SUM(tbfp.Period_11) as FundCalcJun,
		SUM(tbfp.Period_12) as FundCalcJul

		from [Rulebase].[TBL_LearningDelivery] tbf
		LEFT JOIN [Rulebase].[TBL_LearningDelivery_PeriodisedValues] tbfp ON tbf.LearnRefNumber = tbfp.LearnRefNumber and tbf.AimSeqNumber =tbfp.AimSeqNumber
		WHERE tbf.FundLine = @learnerType and tbfp.AttributeName in ('CoreGovContPayment','MathEngBalPayment','MathEngOnProgPayment')
		GROUP BY tbf.FundLine) AS ReturnTable) As ReturnTableFinal
)
GO


