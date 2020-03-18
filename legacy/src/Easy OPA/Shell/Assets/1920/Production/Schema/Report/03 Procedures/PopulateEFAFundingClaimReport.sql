IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[PopulateEFAFundingClaimReport]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[PopulateEFAFundingClaimReport]
GO

CREATE PROCEDURE [Report].[PopulateEFAFundingClaimReport]
	@ReferenceDate VARCHAR(50) = NULL,
	@EFACoFRemoval DECIMAL(9,2)
AS
BEGIN
	DECLARE @ConvertedReferenceDate DATETIME = (SELECT CASE ISNULL(@ReferenceDate, '') WHEN '' THEN NULL WHEN '${ReferenceDate}' THEN NULL ELSE CONVERT(DATETIME, @ReferenceDate, 103) END) 

	-- Clear previous report data - needed by FIS
	TRUNCATE TABLE [Report].[EFAFundingClaimReportSummary]
	TRUNCATE TABLE [Report].[EFAFundingClaimReportValues]

	-- Populate [Report].[EFAFundingClaimReportSummary]
	INSERT INTO [Report].[EFAFundingClaimReportSummary]
		SELECT
			MIN(PrvRetentFactHist),
			MIN(ProgWeightHist),
			MIN(PrvDisadvPropnHist),
			MIN(AreaCostFact1618Hist),
			MIN(PrvHistLrgProgPropn) AS [LargeProgrammeProportion]
		FROM [Rulebase].[FM25_Learner]

	-- Populate [Report].[EFAFundingClaimReportValues]
	INSERT INTO [Report].[EFAFundingClaimReportValues]
		SELECT 
			( -- A Band 5 Student Numbers
			SELECT
				COUNT(DISTINCT L.LearnRefNumber)
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK)
			JOIN [Valid].[LearningDelivery] LD WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber 
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '14-16 Direct Funded Students' 
				AND L.RateBand = '540+ hours (Band 5)'
				AND L.StartFund = 1	  
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_A_Band5, 
			( -- A Band 4a Student Numbers
			SELECT
				COUNT(DISTINCT L.LearnRefNumber)
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK)
			JOIN [Valid].[LearningDelivery] LD WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '14-16 Direct Funded Students' 
				AND L.RateBand = '450+ hours (Band 4a)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_A_Band4a,
			( -- A Band 4b Student Numbers
			SELECT
				COUNT(DISTINCT L.LearnRefNumber)
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK)
			JOIN [Valid].[LearningDelivery] LD WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '14-16 Direct Funded Students' 
				AND L.RateBand = '450 to 539 hours (Band 4b)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_A_Band4b,
			( -- A Band 3 Student Numbers
			SELECT
				COUNT(DISTINCT L.LearnRefNumber)
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK)
			JOIN [Valid].[LearningDelivery] LD WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '14-16 Direct Funded Students' 
				AND L.RateBand = '360 to 449 hours (Band 3)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_A_Band3,
			( -- A Band 2 Student Numbers
			SELECT
				COUNT(DISTINCT L.LearnRefNumber)
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK)
			JOIN [Valid].[LearningDelivery] LD WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '14-16 Direct Funded Students' 
				AND L.RateBand = '280 to 359 hours (Band 2)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_A_Band2,
			( -- A Band 1 Student Numbers
			SELECT
				COUNT(DISTINCT L.LearnRefNumber)
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK)
			JOIN [Valid].[LearningDelivery] LD WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '14-16 Direct Funded Students' 
				AND L.RateBand = 'Up to 279 hours (Band 1)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_A_Band1,

			( -- B Band 5 Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND (L.FundLine = '16-19 High Needs Students' OR L.FundLine = '16-19 Students (excluding High Needs Students)')
				AND L.RateBand = '540+ hours (Band 5)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_B_Band5,
			( -- B Band 5 Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL (12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
						AND (L.FundLine = '16-19 High Needs Students' OR L.FundLine = '16-19 Students (excluding High Needs Students)')
						AND L.RateBand = '540+ hours (Band 5)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate))
			) AS TotalFunding_B_Band5,

			( -- B Band 4a Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND (L.FundLine = '16-19 High Needs Students' OR L.FundLine = '16-19 Students (excluding High Needs Students)')
				AND L.RateBand = '450+ hours (Band 4a)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_B_Band4a,
			( -- B Band 4a Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0)) AS DECIMAL (12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
						AND (L.FundLine = '16-19 High Needs Students' OR L.FundLine = '16-19 Students (excluding High Needs Students)') 
						AND L.RateBand = '450+ hours (Band 4a)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)) 
			) AS TotalFunding_B_Band4a,
			( -- B Band 4b Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND (L.FundLine = '16-19 High Needs Students' OR L.FundLine = '16-19 Students (excluding High Needs Students)')
				AND L.RateBand = '450 to 539 hours (Band 4b)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_B_Band4b,
			( -- B Band 4b Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL (12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
						AND (L.FundLine = '16-19 High Needs Students' OR L.FundLine = '16-19 Students (excluding High Needs Students)')
						AND L.RateBand = '450 to 539 hours (Band 4b)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)) 
			) AS TotalFunding_B_Band4b,
			( -- B Band 3 Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND (L.FundLine = '16-19 High Needs Students' OR L.FundLine = '16-19 Students (excluding High Needs Students)')
				AND L.RateBand = '360 to 449 hours (Band 3)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_B_Band3,
			( -- B Band 3 Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0)) AS DECIMAL (12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
							AND (L.FundLine = '16-19 High Needs Students' OR L.FundLine = '16-19 Students (excluding High Needs Students)')
						AND L.RateBand = '360 to 449 hours (Band 3)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)) 
			) AS TotalFunding_B_Band3,
			( -- B Band 2 Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND (L.FundLine = '16-19 High Needs Students' OR L.FundLine = '16-19 Students (excluding High Needs Students)')
				AND L.RateBand = '280 to 359 hours (Band 2)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_B_Band2,
			( -- B Band 2 Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL (12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
							AND (L.FundLine = '16-19 High Needs Students' OR L.FundLine = '16-19 Students (excluding High Needs Students)')
						AND L.RateBand = '280 to 359 hours (Band 2)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)) 
			) AS TotalFunding_B_Band2,
			( -- B Band 1 Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND (L.FundLine = '16-19 High Needs Students' OR L.FundLine = '16-19 Students (excluding High Needs Students)')
				AND L.RateBand = 'Up to 279 hours (Band 1)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_B_Band1,
			( -- B Band 1 Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL (12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
							AND (L.FundLine = '16-19 High Needs Students' OR L.FundLine = '16-19 Students (excluding High Needs Students)')
						AND L.RateBand = 'Up to 279 hours (Band 1)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)) 
			) AS TotalFunding_B_Band1,

			( -- C1 Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '19-24 Students with an EHCP' 
				AND L.RateBand = '540+ hours (Band 5)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_C_Band5,
			( -- C1 Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL(12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
						AND L.FundLine = '19-24 Students with an EHCP' 
						AND L.RateBand = '540+ hours (Band 5)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)) 
			) AS TotalFunding_C_Band5,
			( -- C2 Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '19-24 Students with an EHCP' 
				AND L.RateBand = '450+ hours (Band 4a)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_C_Band4a,
			( -- C2 Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL (12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
							AND L.FundLine = '19-24 Students with an EHCP'
						AND L.RateBand = '450+ hours (Band 4a)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate))          
			) AS TotalFunding_C_Band4a,
			( -- C3 Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '19-24 Students with an EHCP'
				AND L.RateBand = '450 to 539 hours (Band 4b)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_C_Band4b,
			( -- C3 Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL (12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
							AND L.FundLine = '19-24 Students with an EHCP'
						AND L.RateBand = '450 to 539 hours (Band 4b)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate))
			) AS TotalFunding_C_Band4b,
			( -- C4 Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '19-24 Students with an EHCP'
				AND L.RateBand = '360 to 449 hours (Band 3)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_C_Band3,
			( -- C4 Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL (12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
							AND L.FundLine = '19-24 Students with an EHCP'
						AND L.RateBand = '360 to 449 hours (Band 3)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)) 
			) AS TotalFunding_C_Band3,
			( -- C5 Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '19-24 Students with an EHCP'
				AND L.RateBand = '280 to 359 hours (Band 2)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_C_Band2,
			( -- C5 Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL (12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
							AND L.FundLine = '19-24 Students with an EHCP'
						AND L.RateBand = '280 to 359 hours (Band 2)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)) 
			) AS TotalFunding_C_Band2,
				( -- C5 Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '19-24 Students with an EHCP'
				AND L.RateBand = 'Up to 279 hours (Band 1)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_C_Band1,
			( -- C5 Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL (12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
							AND L.FundLine = '19-24 Students with an EHCP'
						AND L.RateBand = 'Up to 279 hours (Band 1)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)) 
			) AS TotalFunding_C_Band1,			

			( -- D_Band5 Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '19+ Continuing Students (excluding EHCP)' 
				AND L.RateBand = '540+ hours (Band 5)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_D_Band5,
			( -- D_Band5 Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL(12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
							AND L.FundLine = '19+ Continuing Students (excluding EHCP)' 
						AND L.RateBand = '540+ hours (Band 5)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)) 
			) AS TotalFunding_D_Band5,
			( -- D_Band4a Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '19+ Continuing Students (excluding EHCP)' 
				AND L.RateBand = '450+ hours (Band 4a)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_D_Band4a,
			( -- D_Band4a Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL(12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
							AND L.FundLine = '19+ Continuing Students (excluding EHCP)' 
						AND L.RateBand = '450+ hours (Band 4a)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)) 
			) AS TotalFunding_D_Band4a,
			( -- D_Band4b Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '19+ Continuing Students (excluding EHCP)' 
				AND L.RateBand = '450 to 539 hours (Band 4b)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_D_Band4b,
			( -- D_Band4b Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL(12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
							AND L.FundLine = '19+ Continuing Students (excluding EHCP)' 
						AND L.RateBand = '450 to 539 hours (Band 4b)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)) 
			) AS TotalFunding_D_Band4b,
			( -- D_Band3 Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '19+ Continuing Students (excluding EHCP)' 
				AND L.RateBand = '360 to 449 hours (Band 3)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_D_Band3,
			( -- D_Band3 Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL(12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
							AND L.FundLine = '19+ Continuing Students (excluding EHCP)' 
						AND L.RateBand = '360 to 449 hours (Band 3)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)) 	
			) AS TotalFunding_D_Band3,
			( -- D_Band2 Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '19+ Continuing Students (excluding EHCP)' 
				AND L.RateBand = '280 to 359 hours (Band 2)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_D_Band2,
			( -- D_Band2 Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL(12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
						AND L.FundLine = '19+ Continuing Students (excluding EHCP)' 
						AND L.RateBand = '280 to 359 hours (Band 2)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)) 
			) AS TotalFunding_D_Band2,
				( -- D_Band1 Student Numbers
			SELECT COUNT(DISTINCT L.LearnRefNumber) 
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			JOIN [Valid].[LearningDelivery] LD  WITH (NOLOCK) ON LD.LearnRefNumber = L.LearnRefNumber
			WHERE LD.FundModel = '25' 
				AND L.FundLine = '19+ Continuing Students (excluding EHCP)' 
				AND L.RateBand = 'Up to 279 hours (Band 1)'
				AND L.StartFund = 1
				AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_D_Band1,
			( -- D_Band1 Total Funding
			SELECT CAST(SUM(ISNULL(L.OnProgPayment,0))  AS DECIMAL(12,2))
			FROM [Rulebase].[FM25_Learner] L WITH (NOLOCK) 
			WHERE EXISTS(SELECT * FROM [Valid].[LearningDelivery] LD WITH (NOLOCK) 
							WHERE 	LD.LearnRefNumber = L.LearnRefNumber AND LD.FundModel = '25' 
						AND L.FundLine = '19+ Continuing Students (excluding EHCP)' 
						AND L.RateBand = 'Up to 279 hours (Band 1)'
						AND L.StartFund = 1
						AND (@ConvertedReferenceDate IS NULL OR L.LearnerStartDate <= @ConvertedReferenceDate)) 
			) AS TotalFunding_D_Band1,

			@EFACoFRemoval AS CoFRemoval

END

GO