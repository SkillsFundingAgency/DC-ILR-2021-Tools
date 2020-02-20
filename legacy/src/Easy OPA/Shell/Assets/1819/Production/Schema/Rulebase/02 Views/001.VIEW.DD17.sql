
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_DD17]'))
DROP VIEW [dbo].[vw_DD17]
GO

CREATE VIEW [dbo].[vw_DD17] 
-------------------------------------------------------------------------------------- 
-- Name:			dbo.vw_DD17.sql
-- 
-- Note:			
--
-- Author:			Peter Chamley
-- Date:			DD/MM/YYYY
-------------------------------------------------------------------------------------- 
-- History
-- Author			Version		   Date		Change Description		
--	Peter Chamley	 0.0		DD/MM/YYYY	Initial Write 
-------------------------------------------------------------------------------------- 
-- 
AS
	WITH CTE_LD_List([LearningDelivery_Id])
	AS
	(
		SELECT DISTINCT [LearningDelivery].[LearningDelivery_Id] 
		FROM [Input].[LearningDelivery]
		WHERE [LearningDelivery].[ProgType] = 25
		  AND [LearningDelivery].[FundModel] in (35,81)
	)
	-- SELECT * FROM CTE_LD_List
	,CTE_TBAFR_Latest
	AS
	(
		SELECT [AppFinRecord_Id]
			  ,[LearningDelivery_Id]
			  ,[AFinType]
			  ,[AFinCode]
			  ,[AFinDate]
			  ,CONVERT(DECIMAL(18,5),[AFinAmount]) as [AFinAmount]
		FROM 
		(
			SELECT [AppFinRecord].*, DENSE_RANK() OVER (PARTITION BY [AppFinRecord].[LearningDelivery_Id], [AppFinRecord].[AFinType], [AppFinRecord].[AFinCode]  ORDER BY [AFinDate] DESC) AS Rank 
			FROM CTE_LD_List
			INNER JOIN [Input].[AppFinRecord]
				ON [AppFinRecord].[LearningDelivery_Id] = CTE_LD_List.[LearningDelivery_Id]
		) as LatestRecs
		WHERE [AFinType] = 'TNP'
		  AND [RANK] = 1 
	)
	-- SELECT * FROM CTE_TBAFR_Latest
	, CTE_SUM_Latest_1and2 ([LearningDelivery_Id],[TotalAFinAmount],[TotalAFinAmount_2rds])
	AS
	(
	   SELECT [LearningDelivery_Id]
			 ,SUM([AFinAmount]) as TotalAFinAmount
			 ,((SUM([AFinAmount])/3)*2) as TotalAFinAmount_2rds
		FROM CTE_TBAFR_Latest
		WHERE [AFinCode] IN (1,2)
		GROUP BY [LearningDelivery_Id]
	)
	-- SELECT * FROM CTE_SUM_Latest_1and2
	, CTE_LD_TBS_Records ([LearningDelivery_Id], [StandardCode], [LearnDelFAMType], [LearnStartDate] )
	AS 
	(
		SELECT DISTINCT [LearningDelivery].[LearningDelivery_Id],  
						[LearningDeliveryFAM].[LearnDelFAMCode] as StandardCode, 
						[LearningDeliveryFAM].[LearnDelFAMType], 
						[LearningDelivery].[LearnStartDate] 
		FROM CTE_LD_List
		INNER JOIN [Input].[LearningDelivery]
			ON [LearningDelivery].[LearningDelivery_Id] = CTE_LD_List.[LearningDelivery_Id]
		INNER JOIN [Input].[LearningDeliveryFAM] 
			ON [LearningDeliveryFAM].[LearningDelivery_Id] = [LearningDelivery].[LearningDelivery_Id]	
		WHERE [LearningDeliveryFAM].[LearnDelFAMType] = 'TBS'
		  AND [LearningDelivery].[AimType] = 1
		  AND ISNUMERIC([LearningDeliveryFAM].[LearnDelFAMCode]) = 1
		  AND [LearningDelivery].[LearnStartDate] IS NOT NULL
	)
	-- SELECT * FROM CTE_LD_TBS_Records
	, CTE_DD17_WorkOut([LearningDelivery_Id],[StandardCode],[TotalAFinAmount],[TotalAFinAmount_2rds],[CoreGovContributionCap],Failed_DD17)
	AS
	(
		SELECT DISTINCT 
				CTE_LD_TBS_Records.[LearningDelivery_Id],
				CTE_LD_TBS_Records.[StandardCode],
				CTE_SUM_Latest_1and2.[TotalAFinAmount],
				CTE_SUM_Latest_1and2.[TotalAFinAmount_2rds] ,
				[LARS_StandardFunding].[CoreGovContributionCap],
				CASE WHEN [TotalAFinAmount_2rds] > [LARS_StandardFunding].[CoreGovContributionCap] THEN 'Y' ELSE 'N' END as Failed_DD17
		FROM CTE_LD_TBS_Records
		INNER JOIN CTE_SUM_Latest_1and2 
			 ON CTE_LD_TBS_Records.[LearningDelivery_Id] = CTE_SUM_Latest_1and2.[LearningDelivery_Id]
		INNER JOIN [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_StandardFunding] 
			 ON [LARS_StandardFunding].[StandardCode] = CTE_LD_TBS_Records.[StandardCode]
			--AND Z.[LearnStartDate] BETWEEN SF.[EffectiveFrom] AND (SF.[EffectiveTo],DATEADD(YEAR,1,GETDATE())
		WHERE [LARS_StandardFunding].[FundingCategory] = 'StandardTblazer'
	)
	 --SELECT * FROM CTE_DD17_WorkOut
	SELECT LD.[LearningDelivery_Id],LD.[AimSeqNumber],[StandardCode], [TotalAFinAmount],[TotalAFinAmount_2rds],[CoreGovContributionCap],ISNULL(Failed_DD17,'N') as Failed_DD17
	FROM [Input].[LearningDelivery] LD
	LEFT JOIN CTE_DD17_WorkOut
		ON LD.[LearningDelivery_Id] = CTE_DD17_WorkOut.[LearningDelivery_Id]

GO
-- SELECT * FROM vw_DD17 WHERE [StandardCode] IS NOT NULL
GO
