
IF  EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[CommunityLearningReportData]') AND type in (N'P',N'PC'))
BEGIN
DROP PROCEDURE [Report].[CommunityLearningReportData]
END

GO

CREATE Procedure [Report].[CommunityLearningReportData]
	
AS
BEGIN

SELECT  [CL_TotalLearners]
           ,[CL_LearnersStartedThisYear]
           ,[CL_EnrollmentsThisYear]
           ,[CL_1618TotalLearners]
           ,[CL_1618LearnersStartedThisYear]
           ,[CL_1618EnrollmentsThisYear]
           ,[CL_AdultTotalLearners]
           ,[CL_AdultEnrollmentsThisYear]
           ,[CL_AdultLearnersStartedThisYear]
           ,[PCDL_TotalLearners]
           ,[PCDL_LearnersStartedThisYear]
           ,[PCDL_EnrollmentsThisYear]
           ,[NLDC_TotalLearners]
           ,[NLDC_LearnersStartedThisYear]
           ,[NLDC_EnrollmentsThisYear]
           ,[FEML_TotalLearners]
           ,[FEML_LearnersStartedThisYear]
           ,[FEML_EnrollmentsThisYear]
           ,[FEML_1618TotalLearners]
           ,[FEML_1618LearnersStartedThisYear]
           ,[FEML_1618EnrollmentsThisYear]
           ,[FEML_AdultTotalLearners]
           ,[FEML_AdultLearnersStartedThisYear]
           ,[FEML_AdultEnrollmentsThisYear]
           ,[WFL_TotalLearners]
           ,[WFL_LearnersStartedThisYear]
           ,[WFL_EnrollmentsThisYear]
           ,[WFL_1618TotalLearners]
           ,[WFL_1618LearnersStartedThisYear]
           ,[WFL_1618EnrollmentsThisYear]
           ,[WFL_AdultTotalLearners]
           ,[WFL_AdultLearnersStartedThisYear]
           ,[WFL_AdultEnrollmentsThisYear]
           ,[MHP_TotalLearners]
           ,[MHP_LearnersStartedThisYear]
           ,[MHP_EnrollmentsThisYear]
		   FROM [Report].[CommunityLearningReport]
FOR XML PATH('LearnerTotals')



END