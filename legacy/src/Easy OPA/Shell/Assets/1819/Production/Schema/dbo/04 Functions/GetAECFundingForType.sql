IF OBJECT_ID('GetAECFundingForType') IS NOT NULL
BEGIN
    DROP FUNCTION  GetAECFundingForType
END
GO

CREATE FUNCTION [dbo].[GetAECFundingForType] (@fundLineType VARCHAR(MAX), @collectionPeriod int, @attributeNamesCommaSeparatedList NVARCHAR(MAX))
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
		SUM(CASE WHEN AecLdP.[1] IS NULL THEN 0 ELSE Period_1 END)  as FundCalcAug,
		SUM(CASE WHEN AecLdP.[2] IS NULL THEN 0 ELSE Period_2 END)  as FundCalcSep,
		SUM(CASE WHEN AecLdP.[3] IS NULL THEN 0 ELSE Period_3 END)  as FundCalcOct,
		SUM(CASE WHEN AecLdP.[4] IS NULL THEN 0 ELSE Period_4 END)  as FundCalcNov,
		SUM(CASE WHEN AecLdP.[5] IS NULL THEN 0 ELSE Period_5 END)  as FundCalcDec,
		SUM(CASE WHEN AecLdP.[6] IS NULL THEN 0 ELSE Period_6 END)  as FundCalcJan,
		SUM(CASE WHEN AecLdP.[7] IS NULL THEN 0 ELSE Period_7 END)  as FundCalcFeb,
		SUM(CASE WHEN AecLdP.[8] IS NULL THEN 0 ELSE Period_8 END)  as FundCalcMar,
		SUM(CASE WHEN AecLdP.[9] IS NULL THEN 0 ELSE Period_9 END)  as FundCalcApr,
		SUM(CASE WHEN AecLdP.[10] IS NULL THEN 0 ELSE Period_10 END)  as FundCalcMay,
		SUM(CASE WHEN AecLdP.[11] IS NULL THEN 0 ELSE Period_11 END)  as FundCalcJun,
		SUM(CASE WHEN AecLdP.[12] IS NULL THEN 0 ELSE Period_12 END)  as FundCalcJul

		FROM [Rulebase].[AEC_LearningDelivery] AecLd 
		LEFT JOIN [Rulebase].[AEC_LearningDelivery_PeriodisedValues] AecLdPv  ON AecLdPv.LearnRefNumber = AecLd.LearnRefNumber AND AecLdPv.AimSeqNumber = AecLd.AimSeqNumber
		LEFT JOIN
		(
			--FundingSymmaryReport Spec : Note that in the Apprenticeships Earnings Calculation (AEC), the FundLine can change from period to period, hence is stored at LearningDelivery_Period level.  This means the report needs to output values against the correct FundLine for the appropriate period.
			SELECT * FROM 
				(
					SELECT Distinct [LearnRefNumber],[AimSeqNumber],[Period],[FundLineType]	FROM [Rulebase].[AEC_LearningDelivery_Period] AecLdP WHERE FundlineType IN (SELECT * FROM ConvertCSVToTable(@fundLineType)) 
				) AecLdp
				PIVOT
				(
					MIN([FundLineType]) FOR  Period in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
				)Pivt
		)AecLdP ON AecLdP.LearnRefNumber = AecLd.LearnRefNumber AND AecLdP.AimSeqNumber = AecLd.AimSeqNumber
		WHERE AecLdPv.AttributeName IN 
		(			
			SELECT Split.Attribute.value('.', 'VARCHAR(100)') AS Attribute 
				--FROM  (SELECT CAST ('<Attribute>' + REPLACE('ProgrammeAimOnProgPayment,ProgrammeAimBalPayment,ProgrammeAimCompletionPayment', ',', '</Attribute><Attribute>') + '</Attribute>' AS XML) AS String) AS A 
				FROM  (SELECT CAST ('<Attribute>' + REPLACE(@attributeNamesCommaSeparatedList, ',', '</Attribute><Attribute>') + '</Attribute>' AS XML) AS String) AS A 				
				CROSS APPLY String.nodes ('/Attribute') AS Split(Attribute)
		)
		) AS ReturnTable) As ReturnTableFinal
)

GO
