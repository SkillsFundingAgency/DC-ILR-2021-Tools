IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[GetPFRSummaryReportData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[GetPFRSummaryReportData]
GO

CREATE PROCEDURE [Report].[GetPFRSummaryReportData]
AS
BEGIN
	SELECT (
		(SELECT * FROM (
			--'LineTotals1618Apprenticeship'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			from Report.FundingSummary_1618 UNION
			SELECT 'ILR Total 16-18 Apprenticeship Frameworks' as SubGroupHeader,3 as SortOrder,'LineTotals1618Apprenticeship' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_1618 Where SubGroupHeader in ('ILR 16-18 Apprenticeship Frameworks Programme Funding','ILR 16-18 Apprenticeship Frameworks Learning Support') UNION
			SELECT 'EAS Total 16-18 Apprenticeship Frameworks Earnings Adjustment' as SubGroupHeader,8 as SortOrder,'LineTotals1618Apprenticeship' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_1618 Where SubGroupHeader NOT in ('ILR 16-18 Apprenticeship Frameworks Programme Funding','ILR 16-18 Apprenticeship Frameworks Learning Support') UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM Report.FundingSummary_Total1618
			UNION
			--'LineTotals1618Traineeships' 
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			from Report.FundingSummary_1618Traineeships UNION
			SELECT 'ILR Total 16-18 Traineeships' as SubGroupHeader,2 as SortOrder,'LineTotals1618Traineeships' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_1618Traineeships Where SubGroupHeader in ('ILR 16-18 Traineeships Programme Funding') UNION
			SELECT 'EAS Total 16-18 Traineeships Earnings Adjustment' as SubGroupHeader,9 as SortOrder,'LineTotals1618Traineeships' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_1618Traineeships Where SubGroupHeader NOT in ('ILR 16-18 Traineeships Programme Funding') UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM Report.FundingSummary_Total1618Traineeships
			UNION
			--'LineTotals1618TraineeshipsBudget'
			SELECT
				'Total 16-18 Traineeships Budget' as SubGroupHeader,1 as SortOrder,'LineTotals1618TraineeshipsBudget' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			FROM (
				select
					FundCalcAug,FundCalcSep,FundCalcOct,FundCalcNov,FundCalcDec,FundCalcJan,FundCalcFeb,FundCalcMar,FundCalcApr,FundCalcMay,
					FundCalcJun,FundCalcJul,YTDCalc, TotalCalc,AugToMar,AprToJul
				from Report.FundingSummary_Total1618Traineeships
			) as a
			UNION
			--'LineTotals1618TraineeshipsCumulative'
			SELECT
				'Total 16-18 Traineeships Budget Cumulative' as SubGroupHeader,1 as SortOrder,'LineTotals1618TraineeshipsCumulative' as DataSetName,YTDCalc, TotalCalc,AugToMar,AprToJul ,
				FundCalcAug,FundCalcAug+FundCalcSep as FundCalcSep,FundCalcAug+FundCalcSep+FundCalcOct as FundCalcOct,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov as FundCalcNov,
				FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec asFundCalcDec,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan as FundCalcJan,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb as FundCalcFeb,
				FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar as FundCalcMar,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr as FundCalcApr,
				FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay as FundCalcMay,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun as FundCalcJun,
				FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun+FundCalcJul as FundCalcJul
			FROM Report.FundingSummary_Total1618Traineeships
			UNION
			--'LineTotals1618Budget'
			select * from [Report].[FundingSummary_Total1618Budget]
			UNION
			--'LineTotals1618CummalativeBudget'
			SELECT 'Total 16-18 Apprenticeships Budget Cumulative' as SubGroupHeader,1 as SortOrder,'LineTotals1618Cummalative' as DataSetName,YTDCalc, TotalCalc,AugToMar,AprToJul ,
			FundCalcAug,FundCalcAug+FundCalcSep as FundCalcSep,FundCalcAug+FundCalcSep+FundCalcOct as FundCalcOct,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov as FundCalcNov,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec asFundCalcDec,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan as FundCalcJan,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb as FundCalcFeb,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar as FundCalcMar,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr as FundCalcApr
			,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay as FundCalcMay,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun as FundCalcJun,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun+FundCalcJul as FundCalcJul
			from [Report].[FundingSummary_Total1618Budget]
			UNION
			--'LineTotals1923Apprenticeship'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			from Report.FundingSummary_1923 UNION
			SELECT 'ILR Total 19-23 Apprenticeship Frameworks' as SubGroupHeader,3 as SortOrder,'LineTotals1923Apprenticeship' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_1923 Where SubGroupHeader in ('ILR 19-23 Apprenticeship Frameworks Programme Funding','ILR 19-23 Apprenticeship Frameworks Learning Support') UNION
			SELECT 'EAS Total 19-23 Apprenticeship Frameworks Earnings Adjustment' as SubGroupHeader,8 as SortOrder,'LineTotals1923Apprenticeship' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_1923 Where SubGroupHeader NOT in ('ILR 19-23 Apprenticeship Frameworks Programme Funding','ILR 19-23 Apprenticeship Frameworks Learning Support') UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM Report.FundingSummary_Total1923
			UNION
			--'LineTotals24pLUSApprenticeship'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			from Report.FundingSummary_24Plus UNION
			SELECT 'ILR Total 24+ Apprenticeship Frameworks' as SubGroupHeader,3 as SortOrder,'LineTotals24PlusApprenticeship' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_24Plus Where SubGroupHeader in ('ILR 24+ Apprenticeship Frameworks Programme Funding','ILR 24+ Apprenticeship Frameworks Learning Support') UNION
			SELECT 'EAS Total 24+ Apprenticeship Frameworks Earnings Adjustment' as SubGroupHeader,8 as SortOrder,'LineTotals24PlusApprenticeship' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_24Plus Where SubGroupHeader NOT in ('ILR 24+ Apprenticeship Frameworks Programme Funding','ILR 24+ Apprenticeship Frameworks Learning Support') UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM Report.FundingSummary_Total24Plus
			UNION
			--'LineTotalsAdultBudget'
			select * from [Report].[FundingSummary_TotalAdultAppBudget]
			UNION
			--'LineTotalsAdultCummalative'
			SELECT 'Total Adult Apprenticeships Budget Cumulative for starts before 1 May 2017' as SubGroupHeader,1 as SortOrder,'LineTotalsAdultCummalative' as DataSetName,YTDCalc, TotalCalc,AugToMar,AprToJul ,
			FundCalcAug,FundCalcAug+FundCalcSep as FundCalcSep,FundCalcAug+FundCalcSep+FundCalcOct as FundCalcOct,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov as FundCalcNov,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec asFundCalcDec,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan as FundCalcJan,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb as FundCalcFeb,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar as FundCalcMar,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr as FundCalcApr
			,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay as FundCalcMay,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun as FundCalcJun,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun+FundCalcJul as FundCalcJul
			from  [Report].[FundingSummary_TotalAdultAppBudget]
			UNION
			--'LineTotals1924Traineeships'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			from Report.FundingSummary_1924Traineeships WHERE [DataSetName] = 'LineTotals1924Traineeships' UNION
			SELECT 'ILR Total 19-24 Traineeships' as SubGroupHeader,4 as SortOrder,'LineTotals1924Traineeships' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_1924Traineeships Where [DataSetName] = 'LineTotals1924Traineeships' AND SubGroupHeader in ('ILR 19-24 Traineeships Programme Funding','ILR 19-24 Traineeships (16-19 Model) Programme Funding','ILR 19-24 Traineeships Learning Support') UNION
			SELECT 'EAS Total 19-24 Traineeships Earnings Adjustment' as SubGroupHeader,9 as SortOrder,'LineTotals1924Traineeships' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_1924Traineeships Where [DataSetName] = 'LineTotals1924Traineeships' AND SubGroupHeader NOT in ('ILR 19-24 Traineeships Programme Funding','ILR 19-24 Traineeships (16-19 Model) Programme Funding','ILR 19-24 Traineeships Learning Support') UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM Report.FundingSummary_Total1924Traineeships WHERE [DataSetName] = 'LineTotals1924Traineeships'

			--Adult Education Budget – Non-procured delivery
			UNION
			--'LineTotals1924Traineeships'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			from Report.FundingSummary_1924Traineeships WHERE [DataSetName] = 'LineTotals1924TraineeshipsFrmNov2017'  UNION
			SELECT 'ILR Total 19-24 Traineeships' as SubGroupHeader,3 as SortOrder,'LineTotals1924TraineeshipsFrmNov2017' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_1924Traineeships Where [DataSetName] = 'LineTotals1924TraineeshipsFrmNov2017' AND SubGroupHeader in ('ILR 19-24 Traineeships Programme Funding','ILR 19-24 Traineeships Learning Support') UNION
			SELECT 'EAS Total 19-24 Traineeships Earnings Adjustment' as SubGroupHeader,8 as SortOrder,'LineTotals1924TraineeshipsFrmNov2017' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_1924Traineeships Where [DataSetName] = 'LineTotals1924TraineeshipsFrmNov2017' AND SubGroupHeader NOT in ('ILR 19-24 Traineeships Programme Funding','ILR 19-24 Traineeships Learning Support') UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM Report.FundingSummary_Total1924Traineeships WHERE [DataSetName] = 'LineTotals1924TraineeshipsFrmNov2017'


			UNION
			--'LineTotalsAebOtherLearning'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			from Report.[FundingSummary_AebOther] WHERE [DataSetName] = 'LineTotalsAebOtherLearning' 
			UNION
			SELECT 'ILR Total AEB - Other Learning' as SubGroupHeader,5 as SortOrder,'LineTotalsAebOtherLearning' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.[FundingSummary_AebOther] Where [DataSetName] = 'LineTotalsAebOtherLearning' and SubGroupHeader in ('ILR AEB - Other Learning Programme Funding','ILR AEB - Other Learning Learning Support', 'ILR AEB - Other Learning (25+ High Needs Students) Programme Funding')
			UNION
			SELECT 'EAS Total AEB - Other Learning Earnings Adjustment' as SubGroupHeader,9 as SortOrder,'LineTotalsAebOtherLearning' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.[FundingSummary_AebOther] Where [DataSetName] = 'LineTotalsAebOtherLearning' and SubGroupHeader NOT in ('ILR AEB - Other Learning Programme Funding', 'ILR AEB - Other Learning Learning Support', 'ILR AEB - Other Learning (25+ High Needs Students) Programme Funding') UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM Report.[FundingSummary_TotalAebOther] WHERE [DataSetName] = 'LineTotalsAebOtherLearning'
			UNION 
			--'LineTotalsAebOtherLearning' Procured delivery  
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			from Report.[FundingSummary_AebOther] WHERE [DataSetName] = 'LineTotalsAebOtherLearningFrmNov2017'
			UNION
			SELECT 'ILR Total AEB - Other Learning' as SubGroupHeader,5 as SortOrder,'LineTotalsAebOtherLearningFrmNov2017' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.[FundingSummary_AebOther] Where [DataSetName] = 'LineTotalsAebOtherLearningFrmNov2017' and SubGroupHeader in ('ILR AEB - Other Learning Programme Funding','ILR AEB - Other Learning Learning Support')
			UNION
			SELECT 'EAS Total AEB - Other Learning Earnings Adjustment' as SubGroupHeader,9 as SortOrder,'LineTotalsAebOtherLearningFrmNov2017' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.[FundingSummary_AebOther] Where [DataSetName] = 'LineTotalsAebOtherLearningFrmNov2017' and SubGroupHeader NOT in ('ILR AEB - Other Learning Programme Funding', 'ILR AEB - Other Learning Learning Support') UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM Report.[FundingSummary_TotalAebOther] WHERE [DataSetName] = 'LineTotalsAebOtherLearningFrmNov2017'
			UNION 
			--LineTotalsAdultSkillsBudget
			SELECT [SubGroupHeader],[SortOrder] ,[DataSetName],	[YTDCalc] ,	[TotalCalc] ,	[AugToMar] ,[AprToJul] ,	[FundCalcAug],	[FundCalcSep],	[FundCalcOct],	[FundCalcNov],
	               [FundCalcDec],	[FundCalcJan],	[FundCalcFeb],	[FundCalcMar],	[FundCalcApr],	[FundCalcMay],	[FundCalcJun],	[FundCalcJul]
			FROM [Report].[FundingSummary_TotalAdultBudget]
			UNION
			--LineTotalsAdultCummalative
			 SELECT 'Total Adult Education Budget Cumulative – Non-procured delivery' as SubGroupHeader,1 as SortOrder,'LineTotalsAdultBudgetCummalative' as DataSetName,YTDCalc, TotalCalc,AugToMar,AprToJul ,
			FundCalcAug,FundCalcAug+FundCalcSep as FundCalcSep,FundCalcAug+FundCalcSep+FundCalcOct as FundCalcOct,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov as FundCalcNov,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec asFundCalcDec,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan as FundCalcJan,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb as FundCalcFeb,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar as FundCalcMar,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr as FundCalcApr
			,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay as FundCalcMay,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun as FundCalcJun,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun+FundCalcJul as FundCalcJul
			FROM [Report].[FundingSummary_TotalAdultBudget]  WHERE [DataSetName] = 'LineTotalsAdultSkillsBudget'
			UNION
			--LineTotalsAdultCummalative
			 SELECT 'Total Adult Education Budget Cumulative – Procured delivery from 1 Nov 2017' as SubGroupHeader,1 as SortOrder,'LineTotalsAdultBudgetCummalativeFrmNov2017' as DataSetName,YTDCalc, TotalCalc,AugToMar,AprToJul ,
			FundCalcAug,FundCalcAug+FundCalcSep as FundCalcSep,FundCalcAug+FundCalcSep+FundCalcOct as FundCalcOct,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov as FundCalcNov,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec asFundCalcDec,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan as FundCalcJan,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb as FundCalcFeb,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar as FundCalcMar,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr as FundCalcApr
			,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay as FundCalcMay,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun as FundCalcJun,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun+FundCalcJul as FundCalcJul
			FROM [Report].[FundingSummary_TotalAdultBudget]  WHERE [DataSetName] = 'LineTotalsAdultSkillsBudgetFrmNov2017'
			UNION
			--'LineTotals24PlusAdvLoansBursary'
			SELECT
				[SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
				[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			from Report.FundingSummary_24PlusAdvLoansBursary
			UNION
			SELECT
				'ILR Total Advanced Loans Bursary' as SubGroupHeader,3 as SortOrder,'LineTotals24PlusAdvLoansBursary' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_24PlusAdvLoansBursary
			Where SubGroupHeader in ('ILR Advanced Loans Bursary Funding','ILR Advanced Loans Bursary Area Costs')
			UNION
			SELECT
				'EAS Total Advanced Loans Bursary Earnings Adjustment' as SubGroupHeader,6 as SortOrder,'LineTotals24PlusAdvLoansBursary' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_24PlusAdvLoansBursary
			Where SubGroupHeader NOT in('ILR Advanced Loans Bursary Funding','ILR Advanced Loans Bursary Area Costs')
			UNION
			SELECT
				[SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
				[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM Report.FundingSummary_Total24PlusAdvLoansBursary
			UNION
			--LineTotals24PlusAdvLoansBudget
			SELECT
				'Total Advanced Loans Bursary Budget' as SubGroupHeader,1 as SortOrder,'LineTotals24PlusAdvLoansBudget' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			FROM (
				select
					FundCalcAug,FundCalcSep,FundCalcOct,FundCalcNov,FundCalcDec,FundCalcJan,FundCalcFeb,FundCalcMar,FundCalcApr,FundCalcMay,
					FundCalcJun,FundCalcJul,YTDCalc, TotalCalc,AugToMar,AprToJul
				from Report.FundingSummary_Total24PlusAdvLoansBursary
			) as a
			UNION
			--LineTotals24PlusAdvLoansCummalative
			SELECT
				'Total Advanced Loans Bursary Budget Cumulative' as SubGroupHeader,1 as SortOrder,'LineTotals24PlusAdvLoansCummalative' as DataSetName,YTDCalc, TotalCalc,AugToMar,AprToJul ,
				FundCalcAug,FundCalcAug+FundCalcSep as FundCalcSep,FundCalcAug+FundCalcSep+FundCalcOct as FundCalcOct,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov as FundCalcNov,
				FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec asFundCalcDec,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan as FundCalcJan,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb as FundCalcFeb,
				FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar as FundCalcMar,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr as FundCalcApr,
				FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay as FundCalcMay,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun as FundCalcJun,
				FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun+FundCalcJul as FundCalcJul
			FROM [Report].[FundingSummary_Total24PlusAdvLoansBursary]
			UNION
			--'LineTotalsAdultOLASS'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			from Report.FundingSummary_AdultOLASS UNION
			SELECT 'ILR Total Adult OLASS' as SubGroupHeader,3 as SortOrder,'LineTotalsAdultOLASS' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_AdultOLASS Where SubGroupHeader in ('ILR Adult OLASS Programme Funding','ILR Adult OLASS Learning Support') UNION
			SELECT 'EAS Total Adult OLASS Earnings Adjustment' as SubGroupHeader,7 as SortOrder,'LineTotalsAdultOLASS' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From Report.FundingSummary_AdultOLASS Where SubGroupHeader NOT in('ILR Adult OLASS Programme Funding','ILR Adult OLASS Learning Support')  UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM Report.FundingSummary_TotalAdultOLASS
			UNION
			--LineTotalsOLASSBudget
			SELECT 'Total OLASS Budget' as SubGroupHeader,1 as SortOrder,'LineTotalsOLASSBudget' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJull FROM (
			select FundCalcAug,FundCalcSep,FundCalcOct,FundCalcNov,FundCalcDec,FundCalcJan,FundCalcFeb,FundCalcMar,FundCalcApr,FundCalcMay,FundCalcJun,FundCalcJul,YTDCalc, TotalCalc,AugToMar,AprToJul from Report.FundingSummary_TotalAdultOLASS) as a
			UNION
			--LineTotalsOLASSCummalative
			 SELECT 'Total OLASS Budget Cumulative' as SubGroupHeader,1 as SortOrder,'LineTotalsOLASSCummalative' as DataSetName,
			YTDCalc, TotalCalc,AugToMar,AprToJul ,
			FundCalcAug,FundCalcAug+FundCalcSep as FundCalcSep,FundCalcAug+FundCalcSep+FundCalcOct as FundCalcOct,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov as FundCalcNov,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec asFundCalcDec,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan as FundCalcJan,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb as FundCalcFeb,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar as FundCalcMar,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr as FundCalcApr
			,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay as FundCalcMay,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun as FundCalcJun,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun+FundCalcJul as FundCalcJul
			FROM [Report].[FundingSummary_TotalAdultOLASS]
			UNION
			--'LineTotals1618Trailblazers'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
					from [Report].[FundingSummary_1618Trailblazers] UNION
			SELECT 'ILR Total 16-18 Trailblazer Apprenticeships' as SubGroupHeader,4 as SortOrder,'LineTotals1618Trailblazers' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_1618Trailblazers] Where SubGroupHeader in ('ILR 16-18 Trailblazer Apprenticeships Programme Funding (Core Government Contribution, Maths and English)'
			,'ILR 16-18 Trailblazer Apprenticeships Employer Incentive Payments (Achievement, Small Employer, 16-18)','ILR 16-18 Trailblazer Apprenticeships Learning Support') UNION
			SELECT 'EAS Total 16-18 Trailblazer Apprenticeships Earnings Adjustment' as SubGroupHeader,8 as SortOrder,'LineTotals1618Trailblazers' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_1618Trailblazers] Where SubGroupHeader NOT in ('ILR 16-18 Trailblazer Apprenticeships Programme Funding (Core Government Contribution, Maths and English)'
			,'ILR 16-18 Trailblazer Apprenticeships Employer Incentive Payments (Achievement, Small Employer, 16-18)','ILR 16-18 Trailblazer Apprenticeships Learning Support') UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
					 FROM [Report].[FundingSummary_Total1618Trailblazers]
			UNION
	   		--'LineTotals1923Trailblazers'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
					from [Report].[FundingSummary_1923Trailblazers] UNION
			SELECT 'ILR Total 19-23 Trailblazer Apprenticeships ' as SubGroupHeader,4 as SortOrder,'LineTotals1923Trailblazers' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_1923Trailblazers] Where SubGroupHeader in ('ILR 19-23 Trailblazer Apprenticeships Programme Funding (Core Government Contribution, Maths and English)'
			,'ILR 19-23 Trailblazer Apprenticeships Employer Incentive Payments (Achievement, Small Employer, 16-18)','ILR 19-23 Trailblazer Apprenticeships Learning Support') UNION
			SELECT 'EAS Total 19-23 Trailblazer Apprenticeships Earnings Adjustment' as SubGroupHeader,8 as SortOrder,'LineTotals1923Trailblazers' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_1923Trailblazers] Where SubGroupHeader NOT in ('ILR 19-23 Trailblazer Apprenticeships Programme Funding (Core Government Contribution, Maths and English)'
			,'ILR 19-23 Trailblazer Apprenticeships Employer Incentive Payments (Achievement, Small Employer, 16-18)','ILR 19-23 Trailblazer Apprenticeships Learning Support') UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
					 FROM [Report].[FundingSummary_Total1923Trailblazers]
			UNION
			--'LineTotals24PlusTrailblazers'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
					from [Report].[FundingSummary_24PlusTrailblazers] UNION
			SELECT 'ILR Total 24+ Trailblazer Apprenticeships' as SubGroupHeader,4 as SortOrder,'LineTotals24PlusTrailblazers' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_24PlusTrailblazers]Where SubGroupHeader in ('ILR 24+ Trailblazer Apprenticeships Programme Funding (Core Government Contribution, Maths and English)'
			,'ILR 24+ Trailblazer Apprenticeships Employer Incentive Payments (Achievement, Small Employer, 16-18)','ILR 24+ Trailblazer Apprenticeships Learning Support') UNION
			SELECT 'EAS Total 24+ Trailblazer Apprenticeships Earnings Adjustment' as SubGroupHeader,8 as SortOrder,'LineTotals24PlusTrailblazers' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_24PlusTrailblazers] Where SubGroupHeader NOT in ('ILR 24+ Trailblazer Apprenticeships Programme Funding (Core Government Contribution, Maths and English)'
			,'ILR 24+ Trailblazer Apprenticeships Employer Incentive Payments (Achievement, Small Employer, 16-18)','ILR 24+ Trailblazer Apprenticeships Learning Support') UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
					 FROM [Report].[FundingSummary_Total24PlusTrailblazers]

			UNION
			--'LineTotalsOLASSEASCancellationCosts'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
					from [Report].[FundingSummary_LineTotalsOLASSEASCancellationCosts] UNION
			SELECT 'Total Adult OLASS Cancellation Costs Earnings Adjustment' as SubGroupHeader,2 as SortOrder,'LineTotalsOLASSEASCancellationCosts' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_LineTotalsOLASSEASCancellationCosts]

			UNION
			--'LineTotalsExceptionalLearningSupport'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
					from [Report].[FundingSummary_ExceptionalLearningSupport] UNION
			SELECT 'Total Exceptional Learning Support Earnings Adjustment' as SubGroupHeader,20 as SortOrder,'LineTotalsExceptionalLearningSupport' as DataSetName,
			SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
			sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
			sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_ExceptionalLearningSupport]


			UNION

			/********************************************************************************************************************************************************************/
					--Levy Contracted Apprenticeships Budget for starts on or after 1 May 2017
			/********************************************************************************************************************************************************************/
			--'LineTotals1618LevyContractedApprenticeships'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			from [Report].[FundingSummary_1618LevyContractedApprenticeships] 
			UNION
			SELECT 'ILR Total 16-18 Levy Contracted Apprenticeships' as SubGroupHeader,8 as SortOrder,'LineTotals1618LevyContractedApprenticeships' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_1618LevyContractedApprenticeships] Where SubGroupHeader in ('ILR 16-18 Levy Contracted Apprenticeships Programme Aim Indicative Earnings', 'ILR 16-18 Levy Contracted Apprenticeships Maths and English Programme Funding', 'ILR 16-18 Levy Contracted Apprenticeships Framework Uplift', 'ILR 16-18 Levy Contracted Apprenticeships Disadvantage Payments', 'ILR 16-18 Levy Contracted Apprenticeships Additional Payments for Providers', 'ILR 16-18 Levy Contracted Apprenticeships Additional Payments for Employers', 'ILR 16-18 Levy Contracted Apprenticeships Learning Support') 
			UNION
			SELECT 'EAS Total 16-18 Levy Contracted Apprenticeships Earnings Adjustment' as SubGroupHeader,16 as SortOrder,'LineTotals1618LevyContractedApprenticeships' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_1618LevyContractedApprenticeships] Where SubGroupHeader NOT in ('ILR 16-18 Levy Contracted Apprenticeships Programme Aim Indicative Earnings', 'ILR 16-18 Levy Contracted Apprenticeships Maths and English Programme Funding', 'ILR 16-18 Levy Contracted Apprenticeships Framework Uplift', 'ILR 16-18 Levy Contracted Apprenticeships Disadvantage Payments', 'ILR 16-18 Levy Contracted Apprenticeships Additional Payments for Providers', 'ILR 16-18 Levy Contracted Apprenticeships Additional Payments for Employers', 'ILR 16-18 Levy Contracted Apprenticeships Learning Support') 
			UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM [Report].[FundingSummary_Total1618LevyContractedApprenticeships]
	
			UNION

			--'LineTotalsAdultLevyContractedApprenticeships'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			from [Report].[FundingSummary_AdultLevyContractedApprenticeships] 
			UNION
			SELECT 'ILR Total Adult Levy Contracted Apprenticeships' as SubGroupHeader,8 as SortOrder,'LineTotalsAdultLevyContractedApprenticeships' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_AdultLevyContractedApprenticeships] Where SubGroupHeader in ('ILR Adult Levy Contracted Apprenticeships Programme Aim Indicative Earnings', 'ILR Adult Levy Contracted Apprenticeships Maths and English Programme Funding', 'ILR Adult Levy Contracted Apprenticeships Framework Uplift', 'ILR Adult Levy Contracted Apprenticeships Disadvantage Payments', 'ILR Adult Levy Contracted Apprenticeships Additional Payments for Providers', 'ILR Adult Levy Contracted Apprenticeships Additional Payments for Employers', 'ILR Adult Levy Contracted Apprenticeships Learning Support') 
			UNION
			SELECT 'EAS Total Adult Levy Contracted Apprenticeships Earnings Adjustment' as SubGroupHeader,16 as SortOrder,'LineTotalsAdultLevyContractedApprenticeships' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_AdultLevyContractedApprenticeships] Where SubGroupHeader NOT in ('ILR Adult Levy Contracted Apprenticeships Programme Aim Indicative Earnings', 'ILR Adult Levy Contracted Apprenticeships Maths and English Programme Funding', 'ILR Adult Levy Contracted Apprenticeships Framework Uplift', 'ILR Adult Levy Contracted Apprenticeships Disadvantage Payments', 'ILR Adult Levy Contracted Apprenticeships Additional Payments for Providers', 'ILR Adult Levy Contracted Apprenticeships Additional Payments for Employers', 'ILR Adult Levy Contracted Apprenticeships Learning Support') 
			UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM [Report].[FundingSummary_TotalAdultLevyContractedApprenticeships]
		
			UNION 

			--LineTotalsLevyBudget
			SELECT * FROM [Report].[FundingSummary_TotalLevyBudget]
			UNION
			--LineTotalsLevyBudgetCummalative
				SELECT 'Total Levy Contracted Apprenticeships Budget Cumulative for starts on or after 1 May 2017' as SubGroupHeader,1 as SortOrder,'LineTotalsLevyBudgetCummalative' as DataSetName,YTDCalc, TotalCalc,AugToMar,AprToJul ,
			FundCalcAug,FundCalcAug+FundCalcSep as FundCalcSep,FundCalcAug+FundCalcSep+FundCalcOct as FundCalcOct,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov as FundCalcNov,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec asFundCalcDec,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan as FundCalcJan,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb as FundCalcFeb,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar as FundCalcMar,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr as FundCalcApr
			,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay as FundCalcMay,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun as FundCalcJun,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun+FundCalcJul as FundCalcJul
			FROM [Report].[FundingSummary_TotalLevyBudget]
			
			UNION
			/********************************************************************************************************************************************************************/
				--Non-Levy Contracted Apprenticeships Budget for starts on or after 1 May 2017
			/********************************************************************************************************************************************************************/
			--'LineTotals1618NonLevyContractedApprenticeships'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM [Report].[FundingSummary_1618NonLevyContractedApprenticeships] WHERE [DataSetName] = 'LineTotals1618NonLevyContractedApprenticeships' 
			UNION
			SELECT 'ILR Total 16-18 Non-Levy Contracted Apprenticeships' as SubGroupHeader,9 as SortOrder,'LineTotals1618NonLevyContractedApprenticeships' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			FROM [Report].[FundingSummary_1618NonLevyContractedApprenticeships] Where [DataSetName] = 'LineTotals1618NonLevyContractedApprenticeships'  AND SubGroupHeader in		('...of which Indicative Government Co-Investment Earnings', 'ILR 16-18 Non-Levy Contracted Apprenticeships Maths and English Programme Funding', 'ILR 16-18 Non-Levy Contracted Apprenticeships Framework Uplift', 'ILR 16-18 Non-Levy Contracted Apprenticeships Disadvantage Payments', 'ILR 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Providers', 'ILR 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Employers', 'ILR 16-18 Non-Levy Contracted Apprenticeships Learning Support')

			UNION
			SELECT 'EAS Total 16-18 Non-Levy Contracted Apprenticeships Earnings Adjustment' as SubGroupHeader,17 as SortOrder,'LineTotals1618NonLevyContractedApprenticeships' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			FROM [Report].[FundingSummary_1618NonLevyContractedApprenticeships] Where [DataSetName] = 'LineTotals1618NonLevyContractedApprenticeships'  AND SubGroupHeader NOT in ('ILR 16-18 Non-Levy Contracted Apprenticeships Programme Aim Indicative Earnings', 'ILR 16-18 Non-Levy Contracted Apprenticeships Maths and English Programme Funding', 'ILR 16-18 Non-Levy Contracted Apprenticeships Framework Uplift', 'ILR 16-18 Non-Levy Contracted Apprenticeships Disadvantage Payments', 'ILR 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Providers', 'ILR 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Employers', 'ILR 16-18 Non-Levy Contracted Apprenticeships Learning Support','...of which Indicative Government Co-Investment Earnings')	
			UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM [Report].[FundingSummary_Total1618NonLevyContractedApprenticeships] WHERE [DataSetName] = 'LineTotals1618NonLevyContractedApprenticeships' 
	
			UNION

			/********************************************************************************************************************************************************************/
				--Non-Levy Contracted Apprenticeships Budget for starts Jan 2018
			/********************************************************************************************************************************************************************/
			--'LineTotals1618NonLevyContractedApprenticeships'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM [Report].[FundingSummary_1618NonLevyContractedApprenticeships] WHERE   [DataSetName] = 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018'
			UNION
			SELECT 'ILR Total 16-18 Non-Levy Contracted Apprenticeships' as SubGroupHeader,9 as SortOrder,'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			FROM [Report].[FundingSummary_1618NonLevyContractedApprenticeships] Where [DataSetName] = 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AND SubGroupHeader in		('...of which Indicative Government Co-Investment Earnings', 'ILR 16-18 Non-Levy Contracted Apprenticeships Maths and English Programme Funding', 'ILR 16-18 Non-Levy Contracted Apprenticeships Framework Uplift', 'ILR 16-18 Non-Levy Contracted Apprenticeships Disadvantage Payments', 'ILR 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Providers', 'ILR 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Employers', 'ILR 16-18 Non-Levy Contracted Apprenticeships Learning Support')

			UNION
			SELECT 'EAS Total 16-18 Non-Levy Contracted Apprenticeships Earnings Adjustment' as SubGroupHeader,17 as SortOrder,'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			FROM [Report].[FundingSummary_1618NonLevyContractedApprenticeships] Where [DataSetName] = 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' AND SubGroupHeader NOT in ('ILR 16-18 Non-Levy Contracted Apprenticeships Programme Aim Indicative Earnings', 'ILR 16-18 Non-Levy Contracted Apprenticeships Maths and English Programme Funding', 'ILR 16-18 Non-Levy Contracted Apprenticeships Framework Uplift', 'ILR 16-18 Non-Levy Contracted Apprenticeships Disadvantage Payments', 'ILR 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Providers', 'ILR 16-18 Non-Levy Contracted Apprenticeships Additional Payments for Employers', 'ILR 16-18 Non-Levy Contracted Apprenticeships Learning Support','...of which Indicative Government Co-Investment Earnings')	
			UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM [Report].[FundingSummary_Total1618NonLevyContractedApprenticeships] WHERE [DataSetName] = 'LineTotals1618NonLevyContractedApprenticeshipsFrmJan2018' 
	
			UNION

			--'LineTotalsAdultNonLevyContractedApprenticeships'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			from [Report].[FundingSummary_AdultNonLevyContractedApprenticeships] WHERE [DataSetName] = 'LineTotalsAdultNonLevyContractedApprenticeships'
			UNION
			SELECT 'ILR Total Adult Non-Levy Contracted Apprenticeships' as SubGroupHeader,9 as SortOrder,'LineTotalsAdultNonLevyContractedApprenticeships' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_AdultNonLevyContractedApprenticeships] Where [DataSetName] = 'LineTotalsAdultNonLevyContractedApprenticeships' and SubGroupHeader IN	('...of which Indicative Government Co-Investment Earnings', 'ILR Adult Non-Levy Contracted Apprenticeships Maths and English Programme Funding', 'ILR Adult Non-Levy Contracted Apprenticeships Framework Uplift', 'ILR Adult Non-Levy Contracted Apprenticeships Disadvantage Payments', 'ILR Adult Non-Levy Contracted Apprenticeships Additional Payments for Providers','ILR Adult Non-Levy Contracted Apprenticeships Additional Payments for Employers', 'ILR Adult Non-Levy Contracted Apprenticeships Learning Support')
			UNION
			SELECT 'EAS Total Adult Non-Levy Contracted Apprenticeships Earnings Adjustment' as SubGroupHeader,17 as SortOrder,'LineTotalsAdultNonLevyContractedApprenticeships' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_AdultNonLevyContractedApprenticeships] Where [DataSetName] = 'LineTotalsAdultNonLevyContractedApprenticeships' and SubGroupHeader NOT IN ('ILR Adult Non-Levy Contracted Apprenticeships Programme Aim Indicative Earnings', 'ILR Adult Non-Levy Contracted Apprenticeships Maths and English Programme Funding', 'ILR Adult Non-Levy Contracted Apprenticeships Framework Uplift', 'ILR Adult Non-Levy Contracted Apprenticeships Disadvantage Payments', 'ILR Adult Non-Levy Contracted Apprenticeships Additional Payments for Providers','ILR Adult Non-Levy Contracted Apprenticeships Additional Payments for Employers', 'ILR Adult Non-Levy Contracted Apprenticeships Learning Support','...of which Indicative Government Co-Investment Earnings') 
			UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM [Report].[FundingSummary_TotalAdultNonLevyContractedApprenticeships] WHERE [DataSetName] = 'LineTotalsAdultNonLevyContractedApprenticeships'
		
			UNION 

			--LineTotalsNonLevyBudget  
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul],[FundCalcAug],[FundCalcSep],[FundCalcOct],[FundCalcNov],[FundCalcDec],[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr],[FundCalcMay],[FundCalcJun],[FundCalcJul]
			FROM [Report].[FundingSummary_TotalNonLevyBudget] WHERE [DataSetName] = 'LineTotalsNonLevyBudget'
			UNION
			--LineTotalsNonLevyBudgetCummalative
				SELECT 'Total Non-Levy Contracted Apprenticeships Budget Cumulative - Non-procured delivery' as SubGroupHeader,1 as SortOrder,'LineTotalsNonLevyBudgetCummalative' as DataSetName,YTDCalc, TotalCalc,AugToMar,AprToJul ,
			FundCalcAug,FundCalcAug+FundCalcSep as FundCalcSep,FundCalcAug+FundCalcSep+FundCalcOct as FundCalcOct,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov as FundCalcNov,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec asFundCalcDec,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan as FundCalcJan,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb as FundCalcFeb,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar as FundCalcMar,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr as FundCalcApr
			,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay as FundCalcMay,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun as FundCalcJun,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun+FundCalcJul as FundCalcJul
			FROM [Report].[FundingSummary_TotalNonLevyBudget] WHERE [DataSetName] = 'LineTotalsNonLevyBudget'




			/******************1 Jan 2008******************/

			UNION

			--'LineTotalsAdultNonLevyContractedApprenticeships'
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			from [Report].[FundingSummary_AdultNonLevyContractedApprenticeships] WHERE [DataSetName] = 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018'
			UNION
			SELECT 'ILR Total Adult Non-Levy Contracted Apprenticeships' as SubGroupHeader,9 as SortOrder,'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_AdultNonLevyContractedApprenticeships] Where [DataSetName] = 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' and SubGroupHeader IN	('...of which Indicative Government Co-Investment Earnings', 'ILR Adult Non-Levy Contracted Apprenticeships Maths and English Programme Funding', 'ILR Adult Non-Levy Contracted Apprenticeships Framework Uplift', 'ILR Adult Non-Levy Contracted Apprenticeships Disadvantage Payments', 'ILR Adult Non-Levy Contracted Apprenticeships Additional Payments for Providers','ILR Adult Non-Levy Contracted Apprenticeships Additional Payments for Employers', 'ILR Adult Non-Levy Contracted Apprenticeships Learning Support')
			UNION
			SELECT 'EAS Total Adult Non-Levy Contracted Apprenticeships Earnings Adjustment' as SubGroupHeader,17 as SortOrder,'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' as DataSetName,
				SUM(YTDCalc) AS YTDCalc, SUM (TotalCalc) AS TotalCalc,sum(AugToMar) AS AugToMar,sum(AprToJul) AS AprToJul,sum(FundCalcAug) AS FundCalcAug,sum(FundCalcSep) AS FundCalcSep,sum(FundCalcOct) AS FundCalcOct,
				sum(FundCalcNov) AS FundCalcNov,sum(FundCalcDec) AS FundCalcDec,
				sum(FundCalcJan) AS FundCalcJan,sum(FundCalcFeb) AS FundCalcFeb,sum(FundCalcMar) AS FundCalcMar,sum(FundCalcApr) AS FundCalcApr,sum(FundCalcMay) AS FundCalcMay,sum(FundCalcJun) AS FundCalcJun,sum(FundCalcJul) AS FundCalcJul
			From [Report].[FundingSummary_AdultNonLevyContractedApprenticeships] Where [DataSetName] = 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018' and SubGroupHeader NOT IN ('ILR Adult Non-Levy Contracted Apprenticeships Programme Aim Indicative Earnings', 'ILR Adult Non-Levy Contracted Apprenticeships Maths and English Programme Funding', 'ILR Adult Non-Levy Contracted Apprenticeships Framework Uplift', 'ILR Adult Non-Levy Contracted Apprenticeships Disadvantage Payments', 'ILR Adult Non-Levy Contracted Apprenticeships Additional Payments for Providers','ILR Adult Non-Levy Contracted Apprenticeships Additional Payments for Employers', 'ILR Adult Non-Levy Contracted Apprenticeships Learning Support','...of which Indicative Government Co-Investment Earnings') 
			UNION
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul] ,[FundCalcAug],[FundCalcSep],
					[FundCalcOct],[FundCalcNov],[FundCalcDec] ,[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr] ,[FundCalcMay] ,[FundCalcJun] ,[FundCalcJul]
			FROM [Report].[FundingSummary_TotalAdultNonLevyContractedApprenticeships] WHERE [DataSetName] = 'LineTotalsAdultNonLevyContractedApprenticeshipsFrmJan2018'
		
			UNION 

			--LineTotalsNonLevyBudget
			SELECT [SubGroupHeader],[SortOrder],[DataSetName],[YTDCalc],[TotalCalc],[AugToMar],[AprToJul],[FundCalcAug],[FundCalcSep],[FundCalcOct],[FundCalcNov],[FundCalcDec],[FundCalcJan],[FundCalcFeb],[FundCalcMar],[FundCalcApr],[FundCalcMay],[FundCalcJun],[FundCalcJul]
			FROM [Report].[FundingSummary_TotalNonLevyBudget] WHERE [DataSetName] = 'LineTotalsNonLevyBudgetFrmJan2018'
			UNION
			--LineTotalsNonLevyBudgetCummalative
				SELECT 'Total Non-Levy Contracted Apprenticeships Budget Cumulative - Procured delivery' as SubGroupHeader,1 as SortOrder,'LineTotalsNonLevyBudgetCummalativeFrmJan2018' as DataSetName,YTDCalc, TotalCalc,AugToMar,AprToJul ,
			FundCalcAug,FundCalcAug+FundCalcSep as FundCalcSep,FundCalcAug+FundCalcSep+FundCalcOct as FundCalcOct,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov as FundCalcNov,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec asFundCalcDec,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan as FundCalcJan,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb as FundCalcFeb,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar as FundCalcMar,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr as FundCalcApr
			,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay as FundCalcMay,FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun as FundCalcJun,
			FundCalcAug+FundCalcSep+FundCalcOct+FundCalcNov+FundCalcDec+FundCalcJan+FundCalcFeb+FundCalcMar+FundCalcApr+FundCalcMay+FundCalcJun+FundCalcJul as FundCalcJul
			FROM [Report].[FundingSummary_TotalNonLevyBudget] WHERE [DataSetName] = 'LineTotalsNonLevyBudgetFrmJan2018'







	
			/********************************************************************************************************************************************************************/
		)
		As UnionTable order by DataSetName, SortOrder, SubGroupHeader   FOR XML RAW('LineTotals'), TYPE))
	 FOR XML RAW('ILRCommonReportsReport_Object_GraphsPFR_Summary_Report')
END
GO