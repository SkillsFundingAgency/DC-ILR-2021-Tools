IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[TrailblazerEmployerIncentivesReportPopulateData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[TrailblazerEmployerIncentivesReportPopulateData]
GO

CREATE PROCEDURE [Report].[TrailblazerEmployerIncentivesReportPopulateData]	
AS
BEGIN	
	
	TRUNCATE TABLE [Report].[TrailblazerEmployerIncentives]

	DECLARE @SmallBusPayment NVARCHAR(30) = 'SmallBusPayment'
	DECLARE @YoungAppFirstPayment NVARCHAR(30) = 'YoungAppFirstPayment'
	DECLARE @YoungAppSecondPayment NVARCHAR(30) = 'YoungAppSecondPayment'
	DECLARE @AchPayment NVARCHAR(30) = 'AchPayment'
	
	CREATE TABLE #EmpId
	(
		EmployerIdentifier INT NOT NULL
	)

	INSERT INTO #EmpId
	SELECT EmployerIdentifier
	FROM
		(SELECT EmpIdSmallBusDate AS EmployerIdentifier FROM [Rulebase].[TBL_LearningDelivery]
		UNION
		SELECT EmpIdFirstYoungAppDate AS EmployerIdentifier FROM [Rulebase].[TBL_LearningDelivery]
		UNION
		SELECT EmpIdSecondYoungAppDate AS EmployerIdentifier FROM [Rulebase].[TBL_LearningDelivery]
		UNION
		SELECT EmpIdAchDate AS EmployerIdentifier FROM [Rulebase].[TBL_LearningDelivery]) TBL
	WHERE EmployerIdentifier IS NOT NULL

	INSERT INTO [Report].[TrailblazerEmployerIncentives](
		[RowNumber]
		,[Employer identifier]
		,[August small employer incentive]	
		,[August 16-18 year-old apprentice incentive]
		,[August achievement incentive]	
		,[August total]
		,[September small employer incentive]	
		,[September 16-18 year-old apprentice incentive]
		,[September achievement incentive]	
		,[September total]
		,[October small employer incentive]	
		,[October 16-18 year-old apprentice incentive]
		,[October achievement incentive]	
		,[October total]
		,[November small employer incentive]	
		,[November 16-18 year-old apprentice incentive]
		,[November achievement incentive]	
		,[November total]
		,[December small employer incentive]	
		,[December 16-18 year-old apprentice incentive]
		,[December achievement incentive]	
		,[December total]
		,[January small employer incentive]	
		,[January 16-18 year-old apprentice incentive]
		,[January achievement incentive]	
		,[January total]
		,[February small employer incentive]	
		,[February 16-18 year-old apprentice incentive]
		,[February achievement incentive]	
		,[February total]
		,[March small employer incentive]	
		,[March 16-18 year-old apprentice incentive]
		,[March achievement incentive]	
		,[March total]
		,[April small employer incentive]	
		,[April 16-18 year-old apprentice incentive]
		,[April achievement incentive]	
		,[April total]
		,[May small employer incentive]	
		,[May 16-18 year-old apprentice incentive]
		,[May achievement incentive]	
		,[May total]
		,[June small employer incentive]	
		,[June 16-18 year-old apprentice incentive]
		,[June achievement incentive]	
		,[June total]
		,[July small employer incentive]	
		,[July 16-18 year-old apprentice incentive]
		,[July achievement incentive]	
		,[July total]
		,[Total small employer incentive]	
		,[Total 16-18 year-old apprentice incentive]
		,[Total achievement incentive]	
		,[Grand total]	
		,[OFFICIAL - SENSITIVE]
		)
	
	SELECT 
		ROW_NUMBER() OVER (ORDER BY  EmployerIdentifier) AS [RowNumber],
		EmployerIdentifier AS 'Employer identifier'
		-- August Totals
		,ROUND(SUM(CASE WHEN AttributeName = @SmallBusPayment THEN Period_1 ELSE 0 END), 2) AS 'August small employer incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@YoungAppFirstPayment,@YoungAppSecondPayment) THEN Period_1 ELSE 0 END), 2) AS 'August 16-18 year-old apprentice incentive'
		,ROUND(SUM(CASE WHEN AttributeName = @AchPayment THEN Period_1 ELSE 0 END), 2) AS 'August achievement incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@SmallBusPayment,@YoungAppFirstPayment, @YoungAppSecondPayment, @AchPayment) THEN Period_1 ELSE 0 END), 2) AS 'August total'
	
		-- September Totals
		,ROUND(SUM(CASE WHEN AttributeName = @SmallBusPayment THEN Period_2 ELSE 0 END), 2) AS 'September small employer incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@YoungAppFirstPayment,@YoungAppSecondPayment) THEN Period_2 ELSE 0 END), 2) AS 'September 16-18 year-old apprentice incentive'
		,ROUND(SUM(CASE WHEN AttributeName = @AchPayment THEN Period_2 ELSE 0 END), 2) AS 'September achievement incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@SmallBusPayment,@YoungAppFirstPayment, @YoungAppSecondPayment, @AchPayment) THEN Period_2 ELSE 0 END), 2) AS 'September total'

		-- October Totals
		,ROUND(SUM(CASE WHEN AttributeName = @SmallBusPayment THEN Period_3 ELSE 0 END), 2) AS 'October small employer incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@YoungAppFirstPayment,@YoungAppSecondPayment) THEN Period_3 ELSE 0 END), 2) AS 'October 16-18 year-old apprentice incentive'
		,ROUND(SUM(CASE WHEN AttributeName = @AchPayment THEN Period_3 ELSE 0 END), 2) AS 'October achievement incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@SmallBusPayment,@YoungAppFirstPayment, @YoungAppSecondPayment, @AchPayment) THEN Period_3 ELSE 0 END), 2) AS 'October total'

		-- November Totals
		,ROUND(SUM(CASE WHEN AttributeName = @SmallBusPayment THEN Period_4 ELSE 0 END), 2) AS 'November small employer incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@YoungAppFirstPayment,@YoungAppSecondPayment) THEN Period_4 ELSE 0 END), 2) AS 'November 16-18 year-old apprentice incentive'
		,ROUND(SUM(CASE WHEN AttributeName = @AchPayment THEN Period_4 ELSE 0 END), 2) AS 'November achievement incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@SmallBusPayment,@YoungAppFirstPayment, @YoungAppSecondPayment, @AchPayment) THEN Period_4 ELSE 0 END), 2) AS 'November total'

		-- December Totals
		,ROUND(SUM(CASE WHEN AttributeName = @SmallBusPayment THEN Period_5 ELSE 0 END), 2) AS 'December small employer incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@YoungAppFirstPayment,@YoungAppSecondPayment) THEN Period_5 ELSE 0 END), 2) AS 'December 16-18 year-old apprentice incentive'
		,ROUND(SUM(CASE WHEN AttributeName = @AchPayment THEN Period_5 ELSE 0 END), 2) AS 'December achievement incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@SmallBusPayment,@YoungAppFirstPayment, @YoungAppSecondPayment, @AchPayment) THEN Period_5 ELSE 0 END), 2) AS 'December total'

		--January Totals
		,ROUND(SUM(CASE WHEN AttributeName = @SmallBusPayment THEN Period_6 ELSE 0 END), 2) AS 'January small employer incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@YoungAppFirstPayment,@YoungAppSecondPayment) THEN Period_6 ELSE 0 END), 2) AS 'January 16-18 year-old apprentice incentive'
		,ROUND(SUM(CASE WHEN AttributeName = @AchPayment THEN Period_6 ELSE 0 END), 2) AS 'January achievement incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@SmallBusPayment,@YoungAppFirstPayment, @YoungAppSecondPayment, @AchPayment) THEN Period_6 ELSE 0 END), 2) AS 'January total'

		-- February Totals
		,ROUND(SUM(CASE WHEN AttributeName = @SmallBusPayment THEN Period_7 ELSE 0 END), 2) AS 'February small employer incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@YoungAppFirstPayment,@YoungAppSecondPayment) THEN Period_7 ELSE 0 END), 2) AS 'February 16-18 year-old apprentice incentive'
		,ROUND(SUM(CASE WHEN AttributeName = @AchPayment THEN Period_7 ELSE 0 END), 2) AS 'February achievement incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@SmallBusPayment,@YoungAppFirstPayment, @YoungAppSecondPayment, @AchPayment) THEN Period_7 ELSE 0 END), 2) AS 'February total'

		-- March Totals
		,ROUND(SUM(CASE WHEN AttributeName = @SmallBusPayment THEN Period_8 ELSE 0 END), 2) AS 'March small employer incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@YoungAppFirstPayment,@YoungAppSecondPayment) THEN Period_8 ELSE 0 END), 2) AS 'March 16-18 year-old apprentice incentive'
		,ROUND(SUM(CASE WHEN AttributeName = @AchPayment THEN Period_8 ELSE 0 END), 2) AS 'March achievement incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@SmallBusPayment,@YoungAppFirstPayment, @YoungAppSecondPayment, @AchPayment) THEN Period_8 ELSE 0 END), 2) AS 'March total'

		-- April Totals
		,ROUND(SUM(CASE WHEN AttributeName = @SmallBusPayment THEN Period_9 ELSE 0 END), 2) AS 'April small employer incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@YoungAppFirstPayment,@YoungAppSecondPayment) THEN Period_9 ELSE 0 END), 2) AS 'April 16-18 year-old apprentice incentive'
		,ROUND(SUM(CASE WHEN AttributeName = @AchPayment THEN Period_9 ELSE 0 END), 2) AS 'April achievement incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@SmallBusPayment,@YoungAppFirstPayment, @YoungAppSecondPayment, @AchPayment) THEN Period_9 ELSE 0 END), 2) AS 'April total'

		-- May Totals
		,ROUND(SUM(CASE WHEN AttributeName = @SmallBusPayment THEN Period_10 ELSE 0 END), 2) AS 'May small employer incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@YoungAppFirstPayment,@YoungAppSecondPayment) THEN Period_10 ELSE 0 END), 2) AS 'May 16-18 year-old apprentice incentive'
		,ROUND(SUM(CASE WHEN AttributeName = @AchPayment THEN Period_10 ELSE 0 END), 2) AS 'May achievement incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@SmallBusPayment,@YoungAppFirstPayment, @YoungAppSecondPayment, @AchPayment) THEN Period_10 ELSE 0 END), 2) AS 'May total'

		-- June Totals
		,ROUND(SUM(CASE WHEN AttributeName = @SmallBusPayment THEN Period_11 ELSE 0 END), 2) AS 'June small employer incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@YoungAppFirstPayment,@YoungAppSecondPayment) THEN Period_11 ELSE 0 END), 2) AS 'June 16-18 year-old apprentice incentive'
		,ROUND(SUM(CASE WHEN AttributeName = @AchPayment THEN Period_11 ELSE 0 END), 2) AS 'June achievement incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@SmallBusPayment,@YoungAppFirstPayment, @YoungAppSecondPayment, @AchPayment) THEN Period_11 ELSE 0 END), 2) AS 'June total'

		-- July Totals
		,ROUND(SUM(CASE WHEN AttributeName = @SmallBusPayment THEN Period_12 ELSE 0 END), 2) AS 'July small employer incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@YoungAppFirstPayment,@YoungAppSecondPayment) THEN Period_12 ELSE 0 END), 2) AS 'July 16-18 year-old apprentice incentive'
		,ROUND(SUM(CASE WHEN AttributeName = @AchPayment THEN Period_12 ELSE 0 END), 2) AS 'July achievement incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@SmallBusPayment,@YoungAppFirstPayment, @YoungAppSecondPayment, @AchPayment) THEN Period_12 ELSE 0 END), 2) AS 'July total'

		-- Overall Totals
		,ROUND(SUM(CASE WHEN AttributeName = @SmallBusPayment THEN Period_1 + Period_2 + Period_3 + Period_4 + Period_5 + Period_6 + Period_7 + Period_8 + Period_9 + Period_10 + Period_11 + Period_12 ELSE 0 END), 2) AS 'Total small employer incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@YoungAppFirstPayment,@YoungAppSecondPayment) THEN Period_1 + Period_2 + Period_3 + Period_4 + Period_5 + Period_6 + Period_7 + Period_8 + Period_9 + Period_10 + Period_11 + Period_12 ELSE 0 END), 2) AS 'Total 16-18 year-old apprentice incentive'
		,ROUND(SUM(CASE WHEN AttributeName = @AchPayment THEN Period_1 + Period_2 + Period_3 + Period_4 + Period_5 + Period_6 + Period_7 + Period_8 + Period_9 + Period_10 + Period_11 + Period_12 ELSE 0 END), 2) AS 'Total achievement incentive'
		,ROUND(SUM(CASE WHEN AttributeName IN (@SmallBusPayment,@YoungAppFirstPayment, @YoungAppSecondPayment, @AchPayment) THEN Period_1 + Period_2 + Period_3 + Period_4 + Period_5 + Period_6 + Period_7 + Period_8 + Period_9 + Period_10 + Period_11 + Period_12 ELSE 0 END), 2) AS 'Grand total'

		,NULL
	FROM
	(
		SELECT 
			EmployerIdentifier,
			LDPVSBD.*
		FROM #EmpId EID
		LEFT JOIN [Rulebase].[TBL_LearningDelivery] LDSBD
			ON EID.EmployerIdentifier = LDSBD.EmpIdSmallBusDate
		LEFT JOIN [Rulebase].[TBL_LearningDelivery_PeriodisedValues] LDPVSBD
			ON LDSBD.LearnRefNumber = LDPVSBD.LearnRefNumber AND LDPVSBD.AttributeName = @SmallBusPayment
	UNION
		SELECT
			EmployerIdentifier,
			LDPVFY.*
		FROM #EmpId EID
		LEFT JOIN [Rulebase].[TBL_LearningDelivery] LDFY
			ON EID.EmployerIdentifier = LDFY.EmpIdFirstYoungAppDate
		LEFT JOIN [Rulebase].[TBL_LearningDelivery_PeriodisedValues] LDPVFY
			ON LDFY.LearnRefNumber = LDPVFY.LearnRefNumber AND LDPVFY.AttributeName = @YoungAppFirstPayment
	UNION
		SELECT
			EmployerIdentifier,
			LDPVSY.*
		FROM #EmpId EID
		LEFT JOIN [Rulebase].[TBL_LearningDelivery] LDSY
			ON EID.EmployerIdentifier = LDSY.EmpIdSecondYoungAppDate
		LEFT JOIN [Rulebase].[TBL_LearningDelivery_PeriodisedValues] LDPVSY
			ON LDSY.LearnRefNumber = LDPVSY.LearnRefNumber AND LDPVSY.AttributeName = @YoungAppSecondPayment
	UNION
		SELECT
			EmployerIdentifier,
			LDPVAD.*
		FROM #EmpId EID
		LEFT JOIN [Rulebase].[TBL_LearningDelivery] LDAD
			ON EID.EmployerIdentifier = LDAD.EmpIdAchDate
		LEFT JOIN [Rulebase].[TBL_LearningDelivery_PeriodisedValues] LDPVAD
			ON LDAD.LearnRefNumber = LDPVAD.LearnRefNumber AND LDPVAD.AttributeName = @AchPayment
		) tbl
	GROUP BY EmployerIdentifier
	
	
	ORDER BY [Employer identifier]

	DROP TABLE #EmpId		

END