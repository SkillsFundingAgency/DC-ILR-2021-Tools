IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[SFAFundingModel35SummaryReportPopulateData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[SFAFundingModel35SummaryReportPopulateData]
GO

--In FIS Manifest - Make sure call to this appears after the html form(as filters need applying before aggregation)
CREATE PROCEDURE [Report].[SFAFundingModel35SummaryReportPopulateData]	
	@ProvSpecLearnMonA	VARCHAR(50) = NULL,
	@ProvSpecLearnMonB	VARCHAR(50) = NULL,
	@ProvSpecDelMonA	VARCHAR(50) = NULL,
	@ProvSpecDelMonB	VARCHAR(50) = NULL,
	@ProvSpecDelMonC	VARCHAR(50) = NULL,
	@ProvSpecDelMonD	VARCHAR(50) = NULL,
	@FundLineFilter		VARCHAR(50) =NULL
AS
BEGIN	
	-- This table is required to produce zero value funding lines on the report 
	-- where there are no learners with that funding (the rulebase does not generate zero values for funding categories where there are no learners in that category)
	DECLARE @SFAFundingModel35SummaryReport TABLE
	(
		 FundingLine			VARCHAR(100)   
		,Period					INT			 
		,OnProgPayment			DECIMAL(38, 5) 
		,Balancing				DECIMAL(38, 5) 
		,JobOutcomeAchievement	DECIMAL(38, 5) 
		,AimAchievement			DECIMAL(38, 5) 
		,TotalAchievement		DECIMAL(38, 5) 
		,LearningSupport		DECIMAL(38, 5) 
		,Total					DECIMAL(38, 5) 
		,SortOrder				INT			 
	)

	INSERT INTO @SFAFundingModel35SummaryReport 
			 (FundingLine			,							Period,	OnProgPayment,	Balancing,	JobOutcomeAchievement,	AimAchievement,		TotalAchievement,	LearningSupport,	Total,	SortOrder)
	VALUES 	 ('16-18 Apprenticeship',							1,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	1		 )
			,('16-18 Apprenticeship',							2,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	1		 )
			,('16-18 Apprenticeship',							3,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	1		 )
			,('16-18 Apprenticeship',							4,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	1		 )
			,('16-18 Apprenticeship',							5,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	1		 )
			,('16-18 Apprenticeship',							6,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	1		 )
			,('16-18 Apprenticeship',							7,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	1		 )
			,('16-18 Apprenticeship',							8,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	1		 )
			,('16-18 Apprenticeship',							9,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	1		 )
			,('16-18 Apprenticeship',							10,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	1		 )
			,('16-18 Apprenticeship',							11,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	1		 )
			,('16-18 Apprenticeship',							12,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	1		 )

			,('19-23 Apprenticeship',							1,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	2		 )
			,('19-23 Apprenticeship',							2,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	2		 )
			,('19-23 Apprenticeship',							3,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	2		 )
			,('19-23 Apprenticeship',							4,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	2		 )
			,('19-23 Apprenticeship',							5,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	2		 )
			,('19-23 Apprenticeship',							6,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	2		 )
			,('19-23 Apprenticeship',							7,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	2		 )
			,('19-23 Apprenticeship',							8,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	2		 )
			,('19-23 Apprenticeship',							9,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	2		 )
			,('19-23 Apprenticeship',							10,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	2		 )
			,('19-23 Apprenticeship',							11,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	2		 )
			,('19-23 Apprenticeship',							12,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	2		 )

			,('24+ Apprenticeship',								1,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	3		 )
			,('24+ Apprenticeship',								2,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	3		 )
			,('24+ Apprenticeship',								3,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	3		 )
			,('24+ Apprenticeship',								4,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	3		 )
			,('24+ Apprenticeship',								5,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	3		 )
			,('24+ Apprenticeship',								6,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	3		 )
			,('24+ Apprenticeship',								7,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	3		 )
			,('24+ Apprenticeship',								8,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	3		 )
			,('24+ Apprenticeship',								9,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	3		 )
			,('24+ Apprenticeship',								10,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	3		 )
			,('24+ Apprenticeship',								11,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	3		 )
			,('24+ Apprenticeship',								12,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	3		 )

			,('19-24 Traineeship (non-procured)',				1,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	4		 )
			,('19-24 Traineeship (non-procured)',				2,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	4		 )
			,('19-24 Traineeship (non-procured)',				3,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	4		 )
			,('19-24 Traineeship (non-procured)',				4,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	4		 )
			,('19-24 Traineeship (non-procured)',				5,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	4		 )
			,('19-24 Traineeship (non-procured)',				6,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	4		 )
			,('19-24 Traineeship (non-procured)',				7,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	4		 )
			,('19-24 Traineeship (non-procured)',				8,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	4		 )
			,('19-24 Traineeship (non-procured)',				9,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	4		 )
			,('19-24 Traineeship (non-procured)',				10,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	4		 )
			,('19-24 Traineeship (non-procured)',				11,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	4		 )
			,('19-24 Traineeship (non-procured)',				12,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	4		 )

			,('19-24 Traineeship (procured from Nov 2017)',		1,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	5		 )
			,('19-24 Traineeship (procured from Nov 2017)',		2,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	5		 )
			,('19-24 Traineeship (procured from Nov 2017)',		3,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	5		 )
			,('19-24 Traineeship (procured from Nov 2017)',		4,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	5		 )
			,('19-24 Traineeship (procured from Nov 2017)',		5,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	5		 )
			,('19-24 Traineeship (procured from Nov 2017)',		6,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	5		 )
			,('19-24 Traineeship (procured from Nov 2017)',		7,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	5		 )
			,('19-24 Traineeship (procured from Nov 2017)',		8,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	5		 )
			,('19-24 Traineeship (procured from Nov 2017)',		9,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	5		 )
			,('19-24 Traineeship (procured from Nov 2017)',		10,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	5		 )
			,('19-24 Traineeship (procured from Nov 2017)',		11,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	5		 )
			,('19-24 Traineeship (procured from Nov 2017)',		12,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	5		 )

			,('AEB - Other Learning (non-procured)',			1,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	6		 )
			,('AEB - Other Learning (non-procured)',			2,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	6		 )
			,('AEB - Other Learning (non-procured)',			3,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	6		 )
			,('AEB - Other Learning (non-procured)',			4,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	6		 )
			,('AEB - Other Learning (non-procured)',			5,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	6		 )
			,('AEB - Other Learning (non-procured)',			6,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	6		 )
			,('AEB - Other Learning (non-procured)',			7,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	6		 )
			,('AEB - Other Learning (non-procured)',			8,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	6		 )
			,('AEB - Other Learning (non-procured)',			9,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	6		 )
			,('AEB - Other Learning (non-procured)',			10,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	6		 )
			,('AEB - Other Learning (non-procured)',			11,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	6		 )
			,('AEB - Other Learning (non-procured)',			12,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	6		 )

			,('AEB - Other Learning (procured from Nov 2017)',	1,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	7		 )
			,('AEB - Other Learning (procured from Nov 2017)',	2,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	7		 )
			,('AEB - Other Learning (procured from Nov 2017)',	3,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	7		 )
			,('AEB - Other Learning (procured from Nov 2017)',	4,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	7		 )
			,('AEB - Other Learning (procured from Nov 2017)',	5,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	7		 )
			,('AEB - Other Learning (procured from Nov 2017)',	6,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	7		 )
			,('AEB - Other Learning (procured from Nov 2017)',	7,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	7		 )
			,('AEB - Other Learning (procured from Nov 2017)',	8,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	7		 )
			,('AEB - Other Learning (procured from Nov 2017)',	9,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	7		 )
			,('AEB - Other Learning (procured from Nov 2017)',	10,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	7		 )
			,('AEB - Other Learning (procured from Nov 2017)',	11,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	7		 )
			,('AEB - Other Learning (procured from Nov 2017)',	12,		0.0,			0.0,		0.0,					0.0,				0.0,				0.0,				0.0,	7		 )
	
	TRUNCATE TABLE [Report].[SFAFundingModel35SummaryReport]

	;WITH ProvSpecLearnMon_CTE AS 
	(
		SELECT ProvSpecLearnMon.* FROM [Valid].[ProviderSpecLearnerMonitoring] PIVOT (MAX(ProvSpecLearnMon) FOR ProvSpecLearnMonOccur IN ([A],[B]))AS ProvSpecLearnMon
	)
	,ProvSpecDelMon_CTE AS 
	(
		SELECT ProvSpecDelMon.* FROM [Valid].[ProviderSpecDeliveryMonitoring] PIVOT (MAX(ProvSpecDelMon) FOR ProvSpecDelMonOccur IN ([A],[B],[C],[D]))AS ProvSpecDelMon
	)

	INSERT INTO [Report].[SFAFundingModel35SummaryReport]
	(
		 [UKPRN]
		,[FundingLine]
		,[Period]
		,[OnProgPayment]
		,[Balancing]
		,[JobOutcomeAchievement]
		,[AimAchievement]
		,[TotalAchievement]
		,[LearningSupport]
		,[Total]
		,[SortOrder]
	) 
	SELECT	DISTINCT			 
			 (SELECT UKPRN FROM [Valid].LearningProvider)	AS 'UKPRN'
			,FundingLine									AS 'FundingLine'			
			,Period											AS 'Period'	

			,SUM(ISNULL(OnProgPayment,			0.0))		AS 'OnProgPayment'					
			,SUM(ISNULL(Balancing,				0.0))		AS 'Balancing'
			,SUM(ISNULL(JobOutcomeAchievement,	0.0))		AS 'JobOutcomeAchievement'
			,SUM(ISNULL(AimAchievement,			0.0))		AS 'AimAchievement'

			,SUM( ISNULL(JobOutcomeAchievement,	0.0) 
				+ ISNULL(AimAchievement,		0.0))		AS 'TotalAchievement'

			,SUM(ISNULL(LearningSupport,		0.0))		AS 'LearningSupport'

			,SUM( ISNULL(OnProgPayment,			0.0) 
				+ ISNULL(Balancing,				0.0) 
				+ ISNULL(JobOutcomeAchievement,	0.0) 
				+ ISNULL(AimAchievement,		0.0) 
				+ ISNULL(LearningSupport,		0.0))		AS 'Total'

			,SortOrder = CASE LTRIM(RTRIM(FundingLine))
							WHEN '16-18 Apprenticeship'								THEN 1
							WHEN '19-23 Apprenticeship'								THEN 2
							WHEN '24+ Apprenticeship'								THEN 3																
							WHEN '19-24 Traineeship (non-procured)'					THEN 4
							WHEN '19-24 Traineeship (procured from Nov 2017)'		THEN 5
							WHEN 'AEB - Other Learning (non-procured)'				THEN 6
							WHEN 'AEB - Other Learning (procured from Nov 2017)'	THEN 7
						 END
	FROM			
	(
		SELECT
						 RLD.LearnRefNumber
						,RLD.AimSeqNumber

						,LTRIM(RTRIM(RLD.FundLine))				AS 'FundingLine'			
						,RLDP.Period							AS 'Period'
						,(ISNULL(RLDP.OnProgPayment,	0.0)) 	AS 'OnProgPayment'					
						,(ISNULL(RLDP.BalancePayment,	0.0)) 	AS 'Balancing'
						,(ISNULL(RLDP.EmpOutcomePay,	0.0)) 	AS 'JobOutcomeAchievement'
						,(ISNULL(RLDP.AchievePayment,	0.0)) 	AS 'AimAchievement'
						,0.0									AS 'TotalAchievement'
						,(ISNULL(LearnSuppFundCash,		0.0)) 	AS 'LearningSupport'
						,0.0									AS Total
						,0										AS SortOrder
	
		FROM			[Rulebase].[SFA_LearningDelivery] RLD

		LEFT OUTER JOIN	[Rulebase].[SFA_LearningDelivery_Period] RLDP 
		ON				RLD.LearnRefNumber	= RLDP.LearnRefNumber
		AND				RLD.AimSeqNumber	= RLDP.AimSeqNumber

		UNION ALL

		-- This table included in the results to ensure we have a value of zero for any funding lines that are not output by the funding calc
		SELECT
					 ''													AS LearnRefNumber
					,''													AS AimSeqNumber
					,LTRIM(RTRIM(FundingLine))			
					,Period
					,OnProgPayment
					,Balancing
					,JobOutcomeAchievement
					,AimAchievement
					,TotalAchievement
					,LearningSupport
					,Total
					,SortOrder
		FROM		@SFAFundingModel35SummaryReport
	) AS Funding

	LEFT OUTER JOIN					[Valid].[Learner] L
	ON								Funding.LearnRefNumber = L.LearnRefNumber	
			
	LEFT JOIN ProvSpecLearnMon_CTE	[ProvSpecLearnMon] 
	ON								[ProvSpecLearnMon].[LearnRefNumber] = [Funding].[LearnRefNumber]

	LEFT JOIN ProvSpecDelMon_CTE	[ProvSpecDelMon] 
	ON								[ProvSpecDelMon].[LearnRefNumber] = [Funding].[LearnRefNumber] 
	AND								[ProvSpecDelMon].[AimSeqNumber]   = [Funding].[AimSeqNumber]

	WHERE	([ProvSpecLearnMon].[A] = @ProvSpecLearnMonA OR ISNULL(@ProvSpecLearnMonA, '') = '')
	AND		([ProvSpecLearnMon].[B] = @ProvSpecLearnMonB OR ISNULL(@ProvSpecLearnMonB, '') = '') 
	AND		([ProvSpecDelMon].[A]	= @ProvSpecDelMonA	 OR ISNULL(@ProvSpecDelMonA,   '') = '') 
	AND		([ProvSpecDelMon].[B]	= @ProvSpecDelMonB   OR ISNULL(@ProvSpecDelMonB,   '') = '') 
	AND		([ProvSpecDelMon].[C]	= @ProvSpecDelMonC   OR ISNULL(@ProvSpecDelMonC,   '') = '') 
	AND		([ProvSpecDelMon].[D]	= @ProvSpecDelMonD   OR ISNULL(@ProvSpecDelMonD,   '') = '')
	AND		(
				FundingLine		= '0' 
				OR FundingLine	= @FundLineFilter 
				OR COALESCE(@FundLineFilter, '') = ''
			)
	AND FundingLine <> 'Adult OLASS'

	GROUP BY 	FundingLine, Period
	ORDER BY 	FundingLine, Period

END