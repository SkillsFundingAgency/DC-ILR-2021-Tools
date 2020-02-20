IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[ESFFundingSummaryReportGetData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Report].[ESFFundingSummaryReportGetData]
GO


CREATE procedure [Report].[ESFFundingSummaryReportGetData]

AS
BEGIN
 

-- Only want subtotals on sections with more than one group
;WITH DataSetGroups AS (
	SELECT DataSetSortOrder, GroupSortOrder
	FROM [Report].[FundingSummary_ESF]
	GROUP BY DataSetSortOrder, GroupSortOrder
),
ShowSubTotals AS (
	SELECT DataSetSortOrder, CASE Count(*) WHEN 1 THEN 0 ELSE 1 END AS [DataSetShowSubTotals]
	FROM DataSetGroups
	GROUP BY DataSetSortOrder
)
SELECT(
	SELECT	GroupTable.[ContractRefNumber] ,
			GroupTable.[ContractSortOrder] , 
			GroupTable.[DataSetName] , 
			GroupTable.[DataSetSortOrder] , 
			ShowSubTotals.[DataSetShowSubTotals] , -- this is at Dataset level and applies to all groups
			GroupTable.[SuperGroupName] , 
			GroupTable.[SuperGroupSortOrder] , 
			GroupTable.[GroupName] , 
			GroupTable.[GroupSortOrder] ,
			GroupTable.[ShowGroupSubTotal] , --this is at group level and is useful when some of the ILR and SUPP data groups of (eg:'Job Search Progression')  in the dataset (eg:'Progression and Sustained Progression') donot need subtotals. Similarly the dataset : 'Learner Assessment and Plan' which doesnot need to show group subtotals for ILR and SUPP data
			GroupTable.[Name] , 
			GroupTable.[NameSortOrder] , 
			
			--GroupTable.[FundCalcJan16] , 
			--GroupTable.[FundCalcFeb16] , 
			--GroupTable.[FundCalcMar16] , 
			--GroupTable.[FundCalcApr16] , 
			--GroupTable.[FundCalcMay16] , 
			--GroupTable.[FundCalcJun16] , 
			--GroupTable.[FundCalcJul16] , 
			
			GroupTable.[FundCalcJan16], 
			GroupTable.[FundCalcFeb16], 
			GroupTable.[FundCalcMar16], 
			GroupTable.[FundCalcApr16], 
			GroupTable.[FundCalcMay16], 
			GroupTable.[FundCalcJun16], 
			GroupTable.[FundCalcJul16],
			GroupTable.[FundCalcAug16], 
			GroupTable.[FundCalcSep16], 
			GroupTable.[FundCalcOct16], 
			GroupTable.[FundCalcNov16], 
			GroupTable.[FundCalcDec16], 
			GroupTable.[FundCalcJan17], 
			GroupTable.[FundCalcFeb17], 
			GroupTable.[FundCalcMar17], 
			GroupTable.[FundCalcApr17], 
			GroupTable.[FundCalcMay17], 
			GroupTable.[FundCalcJun17], 
			GroupTable.[FundCalcJul17],

			GroupTable.[FundCalcAug17],
			GroupTable.[FundCalcSep17],
			GroupTable.[FundCalcOct17],
			GroupTable.[FundCalcNov17],
			GroupTable.[FundCalcDec17],
			GroupTable.[FundCalcJan18],
			GroupTable.[FundCalcFeb18],
			GroupTable.[FundCalcMar18],
			GroupTable.[FundCalcApr18],
			GroupTable.[FundCalcMay18],
			GroupTable.[FundCalcJun18],
			GroupTable.[FundCalcJul18],

			GroupTable.[FundCalcSubTotal_2015_2016],
            GroupTable.[FundCalcSubTotal_2016_2017],
			GroupTable.[FundCalcSubTotal_2017_2018],

			GroupTable.[FundCalcTotal] 

	FROM	[Report].[FundingSummary_ESF] AS GroupTable
	INNER JOIN ShowSubTotals ON ShowSubTotals.DataSetSortOrder = GroupTable.DataSetSortOrder

	WHERE	[Online] = 1

	ORDER BY [ContractSortOrder], [DataSetSortOrder],[SuperGroupSortOrder], [GroupSortOrder], [NameSortOrder] 
	
	FOR XML RAW('ReportDataItem'), TYPE

) FOR XML RAW('FundingData')


END

GO