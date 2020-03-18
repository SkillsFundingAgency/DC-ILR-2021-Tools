IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[GetEFAFundingClaimReportData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[GetEFAFundingClaimReportData]
GO

CREATE PROCEDURE [Report].[GetEFAFundingClaimReportData]
AS
BEGIN
	SELECT
		( 
			SELECT
				[PrvRetentFactHist] AS 'RetentionFactor',
				[ProgWeightHist] AS 'ProgrammeCostWeightingFactor',
				[PrvDisadvPropnHist] AS 'DisadvantageProportion',
				[AreaCostFact1618Hist] AS 'AreaCost',
				[LargeProgrammeProportion] AS 'LargeProgrammeProportion'
			FROM [Report].[EFAFundingClaimReportSummary]
			FOR XML RAW('LearningProvider'), TYPE, ELEMENTS, XMLSCHEMA('LearningProviderSchema')
		),
		(
			SELECT
				[StudentNumbers_A_Band5],
				[StudentNumbers_A_Band4a],
				[StudentNumbers_A_Band4b],
				[StudentNumbers_A_Band3],
				[StudentNumbers_A_Band2],
				[StudentNumbers_A_Band1],
				[StudentNumbers_B_Band5],
				[TotalFunding_B_Band5],
				[StudentNumbers_B_Band4a],
				[TotalFunding_B_Band4a],
				[StudentNumbers_B_Band4b],
				[TotalFunding_B_Band4b],
				[StudentNumbers_B_Band3],
				[TotalFunding_B_Band3],
				[StudentNumbers_B_Band2],
				[TotalFunding_B_Band2],
				[StudentNumbers_B_Band1],
				[TotalFunding_B_Band1],
				[StudentNumbers_C_Band5],
				[TotalFunding_C_Band5],
				[StudentNumbers_C_Band4a],
				[TotalFunding_C_Band4a],
				[StudentNumbers_C_Band4b],
				[TotalFunding_C_Band4b],
				[StudentNumbers_C_Band3],
				[TotalFunding_C_Band3],
				[StudentNumbers_C_Band2],
				[TotalFunding_C_Band2],
				[StudentNumbers_C_Band1],
				[TotalFunding_C_Band1],
				[StudentNumbers_D_Band5],
				[TotalFunding_D_Band5],
				[StudentNumbers_D_Band4a],
				[TotalFunding_D_Band4a],
				[StudentNumbers_D_Band4b],
				[TotalFunding_D_Band4b],
				[StudentNumbers_D_Band3],
				[TotalFunding_D_Band3],
				[StudentNumbers_D_Band2],
				[TotalFunding_D_Band2],
				[StudentNumbers_D_Band1],
				[TotalFunding_D_Band1],			
				[CoFRemoval] AS 'CoFRemoval'
			FROM [Report].[EFAFundingClaimReportValues]
			FOR XML RAW('Totals'), TYPE, ELEMENTS, XMLSCHEMA('LearnerTotalSchema')
		)
	FOR XML RAW('ILR.Common.Reports.Report_Object_Graphs.FM25_Funding_Claim')
END
GO