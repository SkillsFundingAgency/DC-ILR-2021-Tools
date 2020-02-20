IF OBJECT_ID('GetOLASSEASAuthorisedClaimsFunding') IS NOT NULL
BEGIN
    DROP FUNCTION  GetOLASSEASAuthorisedClaimsFunding
END
GO

CREATE FUNCTION GetOLASSEASAuthorisedClaimsFunding (@collectionPeriod int) 
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
	SELECT	(CASE WHEN Period = 1 THEN CAST(Value AS DECIMAL(15,5)) END) AS FundCalcAug,
		(CASE WHEN Period = 2 THEN CAST(Value AS DECIMAL(15,5)) END) AS FundCalcSep,
		(CASE WHEN Period = 3 THEN CAST(Value AS DECIMAL(15,5)) END) AS FundCalcOct,
		(CASE WHEN Period = 4 THEN CAST(Value AS DECIMAL(15,5)) END) AS FundCalcNov,
		(CASE WHEN Period = 5 THEN CAST(Value AS DECIMAL(15,5)) END) AS FundCalcDec,
		(CASE WHEN Period = 6 THEN CAST(Value AS DECIMAL(15,5)) END) AS FundCalcJan,
		(CASE WHEN Period = 7 THEN CAST(Value AS DECIMAL(15,5)) END) AS FundCalcFeb,
		(CASE WHEN Period = 8 THEN CAST(Value AS DECIMAL(15,5)) END) AS FundCalcMar,
		(CASE WHEN Period = 9 THEN CAST(Value AS DECIMAL(15,5)) END) AS FundCalcApr,
		(CASE WHEN Period = 10 THEN CAST(Value AS DECIMAL(15,5)) END) AS FundCalcMay,
		(CASE WHEN Period = 11 THEN CAST(Value AS DECIMAL(15,5)) END) AS FundCalcJun,
		(CASE WHEN Period = 12 THEN CAST(Value AS DECIMAL(15,5)) END) AS FundCalcJul
		FROM (SELECT val.CollectionPeriod as Period, SUM(val.AuthorisedClaims) AS Value 
		FROM [Valid].[LearningProvider] lp
		INNER JOIN [${OLASSEAS.FullyQualified}].[${OLASSEAS.schemaname}].[OLASS_Submission] sub(nolock) ON lp.UKPRN = sub.UKPRN
		INNER JOIN [${OLASSEAS.FullyQualified}].[${OLASSEAS.schemaname}].[OLASS_Submission_Values] val(nolock) ON val.Submission_Id = sub.Submission_Id AND val.CollectionPeriod = sub.CollectionPeriod
		GROUP BY val.CollectionPeriod) as SubQueryTable) as ReturnTable) As ReturnTableFinal
)
GO
