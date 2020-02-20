-- [Report].[EFAFundingClaimReportSummary] table
IF OBJECT_ID('[Report].[EFAFundingClaimReportSummary]') IS NOT NULL
BEGIN
    DROP TABLE  [Report].[EFAFundingClaimReportSummary]
END

CREATE TABLE [Report].[EFAFundingClaimReportSummary] (
	[PrvRetentFactHist] DECIMAL(10,5),
	[ProgWeightHist] DECIMAL(10,5),
	[PrvDisadvPropnHist] DECIMAL(10,5),
	[AreaCostFact1618Hist] DECIMAL(10,5),
	[LargeProgrammeProportion] DECIMAL(10,5)
)
GO

-- [Report].[EFAFundingClaimReportValues] table
IF OBJECT_ID('[Report].[EFAFundingClaimReportValues]') IS NOT NULL
BEGIN
    DROP TABLE  [Report].[EFAFundingClaimReportValues]
END

CREATE TABLE [Report].[EFAFundingClaimReportValues] (
	[StudentNumbers_A_Band5] INT NULL,
	[StudentNumbers_A_Band4a] INT NULL,
	[StudentNumbers_A_Band4b] INT NULL,
	[StudentNumbers_A_Band3] INT NULL,
	[StudentNumbers_A_Band2] INT NULL,
	[StudentNumbers_A_Band1] INT NULL,
	[StudentNumbers_B_Band5] INT NULL,
	[TotalFunding_B_Band5] DECIMAL(12,2) NULL,
	[StudentNumbers_B_Band4a] INT NULL,
	[TotalFunding_B_Band4a] DECIMAL(12,2) NULL,
	[StudentNumbers_B_Band4b] INT NULL,
	[TotalFunding_B_Band4b] DECIMAL(12,2) NULL,
	[StudentNumbers_B_Band3] INT NULL,
	[TotalFunding_B_Band3] DECIMAL(12,2) NULL,
	[StudentNumbers_B_Band2] INT NULL,
	[TotalFunding_B_Band2] DECIMAL(12,2) NULL,
	[StudentNumbers_B_Band1] INT NULL,
	[TotalFunding_B_Band1] DECIMAL(12,2) NULL,
	[StudentNumbers_C_Band5] INT NULL,
	[TotalFunding_C_Band5] DECIMAL(12,2) NULL,
	[StudentNumbers_C_Band4a] INT NULL,
	[TotalFunding_C_Band4a] DECIMAL(12,2) NULL,
	[StudentNumbers_C_Band4b] INT NULL,
	[TotalFunding_C_Band4b] DECIMAL(12,2) NULL,
	[StudentNumbers_C_Band3] INT NULL,
	[TotalFunding_C_Band3] DECIMAL(12,2) NULL,
	[StudentNumbers_C_Band2] INT NULL,
	[TotalFunding_C_Band2] DECIMAL(12,2) NULL,
	[StudentNumbers_C_Band1] INT NULL,
	[TotalFunding_C_Band1] DECIMAL(12,2) NULL,
	[StudentNumbers_D_Band5] INT NULL,
	[TotalFunding_D_Band5] DECIMAL(12,2) NULL,
	[StudentNumbers_D_Band4a] INT NULL,
	[TotalFunding_D_Band4a] DECIMAL(12,2) NULL,
	[StudentNumbers_D_Band4b] INT NULL,
	[TotalFunding_D_Band4b] DECIMAL(12,2) NULL,
	[StudentNumbers_D_Band3] INT NULL,
	[TotalFunding_D_Band3] DECIMAL(12,2) NULL,
	[StudentNumbers_D_Band2] INT NULL,
	[TotalFunding_D_Band2] DECIMAL(12,2) NULL,
	[StudentNumbers_D_Band1] INT NULL,
	[TotalFunding_D_Band1] DECIMAL(12,2) NULL,	
	[CoFRemoval] DECIMAL(9,2) NULL
)
GO
