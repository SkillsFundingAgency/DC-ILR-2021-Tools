IF OBJECT_ID('Report.LearnersEarliestAim') IS NOT NULL
BEGIN
    DROP TABLE  [Report].[LearnersEarliestAim]
END;

  CREATE TABLE [Report].[LearnersEarliestAim]
  (
	 LearnRefNumber varchar(12),
	 LearnStartDate date
)

GO

IF OBJECT_ID('Report.LearnersStartedThisFundingYear') IS NOT NULL
BEGIN
    DROP TABLE  [Report].[LearnersStartedThisFundingYear]
END;

  CREATE TABLE [Report].[LearnersStartedThisFundingYear]
  (
	 LearnRefNumber varchar(12),
	 AimSeqNumber int, 
	 LearnStartDate date
)

GO

IF OBJECT_ID('Report.CommunityLearningReport') IS NOT NULL
BEGIN
    DROP TABLE  [Report].[CommunityLearningReport]
END;

  CREATE TABLE [Report].[CommunityLearningReport]
  (
	[CL_TotalLearners] int,
	[CL_LearnersStartedThisYear] int,
	[CL_EnrollmentsThisYear] int,
	[CL_1618TotalLearners] int,
	[CL_1618LearnersStartedThisYear] int,
	[CL_1618EnrollmentsThisYear] int,
	[CL_AdultTotalLearners] int, 
	[CL_AdultEnrollmentsThisYear] int,
	[CL_AdultLearnersStartedThisYear] int,
	[PCDL_TotalLearners] int, 
	[PCDL_LearnersStartedThisYear] int,
	[PCDL_EnrollmentsThisYear] int,
	[NLDC_TotalLearners] int  ,
	[NLDC_LearnersStartedThisYear] int   ,
	[NLDC_EnrollmentsThisYear] int    ,
	[FEML_TotalLearners] int, 
	[FEML_LearnersStartedThisYear] int, 
	[FEML_EnrollmentsThisYear] int,
	[FEML_1618TotalLearners] int, 
	[FEML_1618LearnersStartedThisYear] int, 
	[FEML_1618EnrollmentsThisYear] int,
	[FEML_AdultTotalLearners] int, 
	[FEML_AdultLearnersStartedThisYear] int,
	[FEML_AdultEnrollmentsThisYear] int,
	[WFL_TotalLearners] int,
	[WFL_LearnersStartedThisYear] int,
	[WFL_EnrollmentsThisYear] int,
	[WFL_1618TotalLearners] int,
	[WFL_1618LearnersStartedThisYear] int,
	[WFL_1618EnrollmentsThisYear] int,
	[WFL_AdultTotalLearners] int,
	[WFL_AdultLearnersStartedThisYear] int,
	[WFL_AdultEnrollmentsThisYear] int,
	[MHP_TotalLearners] int, 
	[MHP_LearnersStartedThisYear] int,
	[MHP_EnrollmentsThisYear] int
	)

GO

