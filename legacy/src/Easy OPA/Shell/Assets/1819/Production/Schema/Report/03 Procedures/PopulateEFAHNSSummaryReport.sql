IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[PopulateEFAHNSSummaryReport]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[PopulateEFAHNSSummaryReport]
GO

CREATE PROCEDURE [Report].[PopulateEFAHNSSummaryReport]
	@ReferenceDate VARCHAR(50) = NULL
AS
BEGIN
	DECLARE @ConvertedReferenceDate DATETIME = (SELECT CASE ISNULL(@ReferenceDate, '') WHEN '' THEN NULL WHEN '${ReferenceDate}' THEN NULL ELSE CONVERT(DATETIME, @ReferenceDate, 103) END) 

	-- Clear previous report data - needed by FIS
	TRUNCATE TABLE [Report].[EFAHNSSumaryReport]

	-- Populate [Report].[EFAHNSSumaryReport]
	INSERT INTO [Report].[EFAHNSSumaryReport]
		SELECT 
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport] 
			WHERE [Fund Line] = '14-16 Direct Funded Students' 
				AND [A - Students with an EHCP]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
   
			) AS StudentNumbers_A_A,
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '14-16 Direct Funded Students'
				AND [B - Students without an EHCP]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
   
			) AS StudentNumbers_A_B,
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '14-16 Direct Funded Students'
				AND [C - High Needs Students (HNS) without an EHCP]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
   
			) AS StudentNumbers_A_C,
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '14-16 Direct Funded Students'
				AND [D - Students with an EHCP and HNS]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
   
			) AS StudentNumbers_A_D,
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '14-16 Direct Funded Students'
				AND [E - Students with an EHCP but without HNS]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
   
			) AS StudentNumbers_A_E,
			( 
			0
   
			) AS StudentNumbers_A_F,
			
			--B
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '16-19 Students (including High Needs Students)' AND [A - Students with an EHCP]=1
			AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
   
			) AS StudentNumbers_B_A,

			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '16-19 Students (including High Needs Students)'
				AND [B - Students without an EHCP]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_B_B,
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '16-19 Students (including High Needs Students)'
				AND [C - High Needs Students (HNS) without an EHCP]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_B_C,
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '16-19 Students (including High Needs Students)'
				AND [D - Students with an EHCP and HNS]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_B_D,
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '16-19 Students (including High Needs Students)'
				AND [E - Students with an EHCP but without HNS]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_B_E,
			( 
			0
			) AS StudentNumbers_B_F,
			
			
			-- C
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '19-24 Students with an EHCP'
				AND [A - Students with an EHCP]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_C_A,
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '19-24 Students with an EHCP'
				AND [B - Students without an EHCP]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_C_B,
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '19-24 Students with an EHCP'
				AND [C - High Needs Students (HNS) without an EHCP]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_C_C,
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '19-24 Students with an EHCP'
				AND [D - Students with an EHCP and HNS]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_C_D,
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '19-24 Students with an EHCP'
				AND [E - Students with an EHCP but without HNS]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_C_E,
			( 
			0
			) AS StudentNumbers_C_F,
			

			-- D
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '19+ Continuing Students (excluding EHCP)'
				AND [A - Students with an EHCP]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_D_A,
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '19+ Continuing Students (excluding EHCP)'
				AND [B - Students without an EHCP]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_D_B,
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '19+ Continuing Students (excluding EHCP)'
				AND [C - High Needs Students (HNS) without an EHCP]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_D_C,
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '19+ Continuing Students (excluding EHCP)'
				AND [D - Students with an EHCP and HNS]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_D_D,
			( 
			SELECT
				COUNT(DISTINCT [Learner Reference])
			FROM [Report].[HighNeedsStudentsReport]
			WHERE [Fund Line] = '19+ Continuing Students (excluding EHCP)'
				AND [E - Students with an EHCP but without HNS]=1
				AND (@ConvertedReferenceDate IS NULL OR LearnerStartDate <= @ConvertedReferenceDate)
			) AS StudentNumbers_D_E,
			( 
			0
			) AS StudentNumbers_D_F,

			-- E
			( 
			0
			) AS StudentNumbers_E_A,
			( 
			0
			) AS StudentNumbers_E_B,
			( 
			0
			) AS StudentNumbers_E_C,
			( 
			0
			) AS StudentNumbers_E_D,
			( 
			0
			) AS StudentNumbers_E_E,
			( 
			0
			) AS StudentNumbers_E_F,
			( 
			SELECT 
				COUNT(DISTINCT L.LearnRefNumber)
			FROM [Valid].[Learner] L
				INNER JOIN [Rulebase].[FM25_Learner] LEFAF ON L.LearnRefNumber = LEFAF.LearnRefNumber
				INNER JOIN [Report].[HNSLearnerFAM] LFAM ON L.LearnRefNumber = LFAM.LearnRefNumber
			WHERE LEFAF.StartFund = 1
				AND LFAM.HNS = 1
				AND LEFAF.FundLine IN (	'14-16 Direct Funded Students', 
										'16-19 Students (excluding High Needs Students)',  
										'19-24 Students with an EHCP',
										'16-19 High Needs Students', 
										'19+ Continuing Students (excluding EHCP)'										
									)
				AND (@ConvertedReferenceDate IS NULL OR LEFAF.LearnerStartDate <= @ConvertedReferenceDate)
			) AS HNS_Students_1624
END

GO