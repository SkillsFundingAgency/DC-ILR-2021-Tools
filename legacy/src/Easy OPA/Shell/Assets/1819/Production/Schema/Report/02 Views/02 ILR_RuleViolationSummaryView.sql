IF OBJECT_ID('Report.ILR_RuleViolationSummaryView') IS NOT NULL
BEGIN
	DROP VIEW [Report].ILR_RuleViolationSummaryView
END
GO

CREATE VIEW [Report].[ILR_RuleViolationSummaryView]
AS
SELECT 
		(SELECT COUNT(*) FROM Report.ValidationError WHERE Severity = 'E') 'totalErrors',
		(SELECT COUNT(*) FROM Report.ValidationError WHERE Severity = 'W') 'totalWarnings',
		(SELECT COUNT(LearnersUnionTable.LearnRefNumber) FROM
			(
				SELECT DISTINCT(LearnRefNumber) FROM [Input].Learner			
			) As LearnersUnionTable
		) 'totalLearners',
			
	    -- learners with warnings and no errors

		(SELECT count(distinct VE_warnings.LearnRefNumber)
			FROM Report.ValidationError VE_warnings
			WHERE NOT EXISTS (
				SELECT * FROM Report.ValidationError VE_errors 
				WHERE VE_errors.LearnRefNumber = VE_warnings.LearnRefNumber
				AND VE_errors.Severity = 'E'				
				) 
				AND Source NOT IN ('Validation DP 17_18.zip','FD Validation DP 17_18.zip','SQL DP','SQL FL') 
		) 'totalLearnerWarnings',

		(SELECT COUNT(*) FROM Valid.Learner ) 'totalLearnerFullyValid',
		(SELECT COUNT(LearnerInvalidUnionTable.LearnRefNumber) FROM
			(
			SELECT DISTINCT(LearnRefNumber) FROM Invalid.Learner 
			UNION
			SELECT DISTINCT(LearnRefNumber) FROM Report.ValidationError WHERE LearnRefNumber IS NOT NULL AND Severity = 'E' 
				AND Source NOT IN ('Validation DP 17_18.zip','FD Validation DP 17_18.zip','SQL DP','SQL FL')						
			) As LearnerInvalidUnionTable
		) 'totalLearnerInvalid',


		/******************Destination and Progression *****************/

		(SELECT COUNT(DISTINCT(LearnRefNumber)) FROM [Input].[LearnerDestinationandProgression]
		) 'totalLearners_DestinationAndProgression',

		(SELECT count(distinct VE_warnings.LearnRefNumber)	FROM Report.ValidationError VE_warnings
			WHERE NOT Exists (SELECT * FROM Report.ValidationError VE_errors	WHERE VE_errors.LearnRefNumber = VE_warnings.LearnRefNumber	AND VE_errors.Severity = 'E') 
				AND Source IN ('Validation DP 17_18.zip','FD Validation DP 17_18.zip')
		) 'totalLearnerWarnings_DestinationAndProgression',
		(
		SELECT COUNT(DISTINCT LearnRefNumber) FROM  [Input].[LearnerDestinationandProgression]  WHERE LearnRefNumber NOT IN
			(
				SELECT LearnRefNumber FROM Report.ValidationError VE_errors WHERE Source IN ('Validation DP 17_18.zip','FD Validation DP 17_18.zip','SQL DP','SQL FL')
			) 
		) 'totalLearnerFullyValid_DestinationAndProgression',
		(SELECT COUNT(LearnerInvalidUnionTable.LearnRefNumber) FROM
			(			
			 SELECT DISTINCT(LearnRefNumber) FROM Report.ValidationError where LearnRefNumber IS NOT NULL AND Severity = 'E'  AND Source IN ('Validation DP 17_18.zip','FD Validation DP 17_18.zip','SQL DP')
			) As LearnerInvalidUnionTable
		) 'totalLearnerInvalid_DestinationAndProgression',

		
		/*************************************************/

		--LearnerAppsFunded
		(SELECT COUNT(DISTINCT Learner.Learner_Id) FROM [Input].Learner 
			JOIN [Input].LearningDelivery LD on LD.Learner_Id = Learner.Learner_Id AND LD.FundModel = 36)
			'totalLearnerAppsFunded',

		(SELECT COUNT(DISTINCT Learner.LearnRefNumber) FROM Valid.Learner 
						JOIN Valid.LearningDelivery LD on LD.LearnRefNumber = Learner.LearnRefNumber AND LD.FundModel = 36 ) 
			'totalLearnerAppsFullyValid',

		(SELECT COUNT(DISTINCT Learner.Learner_Id)  FROM Invalid.Learner 
			JOIN [Input].LearningDelivery LD on LD.Learner_Id = Learner.Learner_Id AND LD.FundModel = 36 )
			'totalLearnerAppsInvalid',

		--Learner1619Funded
		(SELECT COUNT(DISTINCT Learner.Learner_Id) FROM [Input].Learner 
			JOIN [Input].LearningDelivery LD on LD.Learner_Id = Learner.Learner_Id AND LD.FundModel = 25)
			'totalLearner1619Funded',

		(SELECT COUNT(DISTINCT Learner.LearnRefNumber) FROM Valid.Learner 
						JOIN Valid.LearningDelivery LD on LD.LearnRefNumber = Learner.LearnRefNumber AND LD.FundModel = 25 ) 
			'totalLearner1619FullyValid',

		(SELECT COUNT(DISTINCT Learner.Learner_Id)  FROM Invalid.Learner 
			JOIN [Input].LearningDelivery LD on LD.Learner_Id = Learner.Learner_Id AND LD.FundModel = 25 )
			'totalLearner1619Invalid',

		--LearnerASFunded
		(SELECT COUNT(DISTINCT Learner.Learner_Id) FROM [Input].Learner 
			JOIN [Input].LearningDelivery LD on LD.Learner_Id = Learner.Learner_Id AND LD.FundModel = 35)
			'totalLearnerASFunded',

		(SELECT COUNT(DISTINCT Learner.LearnRefNumber ) FROM Valid.Learner 
			JOIN Valid.LearningDelivery LD on LD.LearnRefNumber = Learner.LearnRefNumber AND LD.FundModel = 35 )
			'totalLearnerASFullyValid',

		(SELECT COUNT(DISTINCT Learner.Learner_Id) FROM Invalid.Learner 
			JOIN [Input].LearningDelivery LD on LD.Learner_Id = Learner.Learner_Id AND LD.FundModel = 35 )
			'totalLearnerASInvalid',

		--LearnerCommunityFullyValid
		(SELECT COUNT(DISTINCT Learner.Learner_Id) FROM [Input].Learner 
			JOIN [Input].LearningDelivery LD on LD.Learner_Id = Learner.Learner_Id AND LD.FundModel = 10)
			'totalLearnerCommunityFunded',


		(SELECT COUNT(DISTINCT Learner.LearnRefNumber ) FROM Valid.Learner 
			JOIN Valid.LearningDelivery LD on LD.LearnRefNumber = Learner.LearnRefNumber AND LD.FundModel = 10 )
			'totalLearnerCommunityFullyValid',

		(SELECT COUNT(DISTINCT Learner.Learner_Id) FROM Invalid.Learner 
			JOIN [Input].LearningDelivery LD on LD.Learner_Id = Learner.Learner_Id AND LD.FundModel = 10 )
			'totalLearnerCommunityInvalid',


		--LearnerESFFunded
		(SELECT COUNT(DISTINCT Learner.Learner_Id) FROM [Input].Learner 
			JOIN [Input].LearningDelivery LD on LD.Learner_Id = Learner.Learner_Id AND LD.FundModel = 70)
			'totalLearnerESFFunded',

		(SELECT COUNT(DISTINCT Learner.LearnRefNumber ) FROM Valid.Learner 
			JOIN Valid.LearningDelivery LD on LD.LearnRefNumber = Learner.LearnRefNumber AND LD.FundModel = 70 )
			'totalLearnerESFFullyValid',

		(SELECT COUNT(DISTINCT Learner.Learner_Id) as 'totalLearnerESFInvalid' FROM Invalid.Learner 
			JOIN [Input].LearningDelivery LD on LD.Learner_Id = Learner.Learner_Id AND LD.FundModel = 70 )
			'totalLearnerESFInvalid',

		--EFA Funded
		(SELECT COUNT(DISTINCT Learner.LearnRefNumber) FROM Valid.Learner 
			JOIN Valid.LearningDelivery LD on LD.LearnRefNumber = Learner.LearnRefNumber AND LD.FundModel = 82 )
			'totalLearnerEFAFullyValid',

		(SELECT COUNT(DISTINCT Learner.Learner_Id) FROM Invalid.Learner 
			JOIN [Input].LearningDelivery LD on LD.Learner_Id = Learner.Learner_Id AND LD.FundModel = 82 )
			'totalLearnerEFAInvalid',

		--LearnerOtherFullyValid
		(SELECT COUNT(DISTINCT Learner.LearnRefNumber) FROM Valid.Learner 
			JOIN Valid.LearningDelivery LD on LD.LearnRefNumber = Learner.LearnRefNumber AND LD.FundModel = 81 )
			'totalLearnerOtherFullyValid',

		(SELECT COUNT(DISTINCT Learner.Learner_Id) FROM Invalid.Learner 
			JOIN [Input].LearningDelivery LD on LD.Learner_Id = Learner.Learner_Id AND LD.FundModel = 81 )
			'totalLearnerOtherInvalid',

		--LearnerNoFundingFullyValid
		(SELECT COUNT(DISTINCT Learner.LearnRefNumber ) FROM Valid.Learner 
			JOIN Valid.LearningDelivery LD on LD.LearnRefNumber = Learner.LearnRefNumber AND LD.FundModel = 99 )
			'totalLearnerNoFundingFullyValid',

		(SELECT COUNT(DISTINCT Learner.Learner_Id) FROM Invalid.Learner 
			JOIN [Input].LearningDelivery LD on LD.Learner_Id = Learner.Learner_Id AND LD.FundModel = 99 )
			'totalLearnerNoFundingInvalid',

		(SELECT COUNT(DISTINCT LearningDelivery_Id) FROM [Input].LearningDelivery)
			'totalLearningDeliveries',

		(SELECT COUNT(DISTINCT LearningDelivery_Id) FROM [Input].LearningDelivery WHERE FundModel = 36)
			'totalAppsDeliveries',

		(SELECT COUNT(DISTINCT LearningDelivery_Id) FROM [Input].LearningDelivery WHERE FundModel = 10)
			'totalCommunityDeliveries',

		(SELECT COUNT(DISTINCT LearningDelivery_Id) FROM [Input].LearningDelivery WHERE FundModel = 25)
			'total1619Deliveries',

		(SELECT COUNT(DISTINCT LearningDelivery_Id) FROM [Input].LearningDelivery WHERE FundModel = 70)
			'totalESFDeliveries',
	
		(SELECT COUNT(DISTINCT LearningDelivery_Id) FROM [Input].LearningDelivery WHERE FundModel = 35)
			'totalASDeliveries',

		(SELECT COUNT(DISTINCT LearningDelivery_Id) FROM [Input].LearningDelivery WHERE FundModel = 81)
			'totalOtherDeliveries',

		(SELECT COUNT(DISTINCT LearningDelivery_Id) FROM [Input].LearningDelivery WHERE FundModel = 82)
			'totalOtherEFADeliveries',

		(SELECT COUNT(DISTINCT LearningDelivery_Id) FROM [Input].LearningDelivery WHERE FundModel = 99)
			'totalNoSkillsDeliveries',

		(SELECT COUNT(DISTINCT LearningDelivery.LearningDelivery_Id) 
		FROM [Input].LearningDelivery 
		INNER JOIN [Input].LearningDeliveryFAM ON LearningDelivery.LearningDelivery_Id = LearningDeliveryFAM.LearningDelivery_Id AND LearnDelFAMType = 'ADL'
		WHERE FundModel = 99) 'totalOther24ALLBDeliveries',

		(SELECT COUNT(*) FROM dbo.XML_FileNames)
			'totalImportedFiles'
