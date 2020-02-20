IF OBJECT_ID('Report.ViolationSummaryReport') IS NOT NULL
BEGIN
    DROP TABLE  [Report].[ViolationSummaryReport]
END;

  CREATE TABLE [Report].[ViolationSummaryReport]
  (
	  TotalErrors						INT
	  ,TotalWarnings					INT
	  ,TotalLearners					INT
	  ,TotalLearnerWarnings				INT
	  ,TotalLearnerFullyValid			INT
	  ,TotalLearnerInvalid				INT	  
	  ,TotalLearners_DestinationAndProgression						INT
	  ,TotalLearnerWarnings_DestinationAndProgression				INT
	  ,TotalLearnerFullyValid_DestinationAndProgression				INT
	  ,TotalLearnerInvalid_DestinationAndProgression				INT
	  ,TotalLearnerAppsFunded			INT
	  ,TotalLearnerAppsFullyValid		INT
	  ,TotalLearnerAppsInvalid			INT
	  ,TotalLearner1619Funded			INT
	  ,TotalLearner1619FullyValid		INT
	  ,TotalLearner1619Invalid			INT
	  ,TotalLearnerASFunded				INT
	  ,TotalLearnerASFullyValid			INT
	  ,TotalLearnerASInvalid			INT
	  ,TotalLearnerCommunityFunded		INT
	  ,TotalLearnerCommunityFullyValid	INT
	  ,TotalLearnerCommunityInvalid		INT
	  ,TotalLearnerESFFunded			INT
	  ,TotalLearnerESFFullyValid		INT
	  ,TotalLearnerESFInvalid			INT
	  ,TotalLearnerEFAFullyValid		INT
	  ,TotalLearnerEFAInvalid			INT
	  ,TotalLearnerOtherFullyValid		INT
	  ,TotalLearnerOtherInvalid			INT
	  ,TotalLearnerNoFundingFullyValid	INT
	  ,TotalLearnerNoFundingInvalid		INT
	  ,TotalLearningDeliveries			INT
	  ,TotalAppsDeliveries				INT
	  ,TotalCommunityDeliveries			INT
	  ,Total1619Deliveries				INT
	  ,TotalESFDeliveries				INT
	  ,TotalASDeliveries				INT
	  ,TotalOtherDeliveries				INT
	  ,TotalOtherEFADeliveries			INT
	  ,TotalNoSkillsDeliveries			INT
	  ,TotalOther24ALLBDeliveries		INT
	  ,TotalImportedFiles				INT
  ) 






