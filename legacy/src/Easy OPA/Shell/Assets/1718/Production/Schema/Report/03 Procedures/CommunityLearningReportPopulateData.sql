
IF  EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[CommunityLearningReportPopulateData]') AND type in (N'P',N'PC'))
BEGIN
DROP PROCEDURE [Report].[CommunityLearningReportPopulateData]
END

GO

CREATE Procedure [Report].[CommunityLearningReportPopulateData]
	@startDate Date,
	@endDate Date	
AS
BEGIN


	Declare @CL_TotalLearners int = 0,	 @CL_LearnersStartedThisYear int = 0, @CL_EnrollmentsThisYear int = 0,
	@CL_1618TotalLearners int = 0,@CL_1618LearnersStartedThisYear int = 0,@CL_1618EnrollmentsThisYear int = 0,
	@CL_AdultTotalLearners int = 0,@CL_AdultLearnersStartedThisYear int = 0,@CL_AdultEnrollmentsThisYear int = 0,
	@PCDL_TotalLearners int = 0,@PCDL_LearnersStartedThisYear int = 0,@PCDL_EnrollmentsThisYear int = 0,
	@NLDC_TotalLearners int = 0,@NLDC_LearnersStartedThisYear int = 0,@NLDC_EnrollmentsThisYear int = 0,
	@FEML_TotalLearners int = 0,@FEML_LearnersStartedThisYear int = 0,@FEML_EnrollmentsThisYear int = 0,
	@FEML_1618TotalLearners int = 0,@FEML_1618LearnersStartedThisYear int = 0,@FEML_1618EnrollmentsThisYear int = 0,
	@FEML_AdultTotalLearners int = 0,@FEML_AdultLearnersStartedThisYear int = 0,@FEML_AdultEnrollmentsThisYear int = 0,
	@WFL_TotalLearners int = 0,@WFL_LearnersStartedThisYear int = 0,@WFL_EnrollmentsThisYear int = 0,
	@WFL_1618TotalLearners int = 0,@WFL_1618LearnersStartedThisYear int = 0,@WFL_1618EnrollmentsThisYear int = 0,
	@WFL_AdultTotalLearners int = 0,@WFL_AdultLearnersStartedThisYear int = 0,@WFL_AdultEnrollmentsThisYear int = 0,
	@MHP_TotalLearners int = 0,@MHP_LearnersStartedThisYear int = 0,@MHP_EnrollmentsThisYear int = 0


select @CL_TotalLearners = count(distinct learnrefnumber) FROM  [Report].[CL_SummaryOfLearners_FAMS] Where FundModel = 10

Truncate Table [Report].[LearnersEarliestAim]
Truncate Table [Report].[LearnersStartedThisFundingYear]

INSERT INTO [Report].[LearnersEarliestAim]
	SELECT LearnRefNumber, min(LearnStartDate) as LearnStartDate FROM [Report].[CL_SummaryOfLearners_FAMS] group by LearnRefNumber,fundmodel having fundmodel =10

INSERT INTO [Report].[LearnersStartedThisFundingYear]
	SELECT le.LearnRefNumber,ld.AimSeqNumber, le.LearnStartDate FROM [Report].[LearnersEarliestAim] le
	INNER JOIN [Report].[CL_SummaryOfLearners_FAMS] ld on le.LearnRefNumber = ld.LearnRefNumber and le.LearnStartDate = ld.LearnStartDate
	WHERE le.LearnStartDate >= @startDate and le.LearnStartDate < @endDate and ld.FundModel = 10


select @CL_LearnersStartedThisYear = count(distinct LearnRefNumber) FROM  [Report].[LearnersStartedThisFundingYear] ld 

select @CL_EnrollmentsThisYear = count(ld.learnrefnumber) from [Report].[CL_SummaryOfLearners_FAMS] ld where ld.FundModel = 10 and ld.LearnStartDate >= @startDate and ld.LearnStartDate < @endDate 


select @CL_1618EnrollmentsThisYear = count(ld.learnrefnumber) from [Report].[CL_SummaryOfLearners_FAMS] ld
									inner join Rulebase.DV_LearningDelivery rld on ld.LearnRefNumber = rld.LearnRefNumber and ld.AimSeqNumber = rld.AimSeqNumber
									where ld.FundModel = 10 and ld.LearnStartDate >= @startDate and ld.LearnStartDate < @endDate and rld.LearnDel_AgeAtStart > 0 and rld.LearnDel_AgeAtStart < 19 


select @CL_1618TotalLearners = count(distinct ld.learnrefnumber) FROM [Report].[CL_SummaryOfLearners_FAMS] ld 
							INNER JOIN Rulebase.DV_LearningDelivery rld on rld.LearnRefNumber = ld.LearnRefNumber and rld.AimSeqNumber = ld.AimSeqNumber
							where ld.FundModel = 10 and rld.LearnDel_AgeAtStart > 0 and rld.LearnDel_AgeAtStart < 19


select @CL_1618LearnersStartedThisYear = count(distinct le.learnrefnumber) FROM [Report].[LearnersStartedThisFundingYear] le 
							INNER JOIN Rulebase.DV_LearningDelivery rld on rld.LearnRefNumber = le.LearnRefNumber and rld.AimSeqNumber = le.AimSeqNumber
							where rld.LearnDel_AgeAtStart > 0 and rld.LearnDel_AgeAtStart < 19


set @CL_AdultTotalLearners = (select count(distinct ld.learnrefnumber) FROM [Report].[CL_SummaryOfLearners_FAMS] ld 
							INNER JOIN Rulebase.DV_LearningDelivery rld on rld.LearnRefNumber = ld.LearnRefNumber and rld.AimSeqNumber = ld.AimSeqNumber
							where ld.FundModel = 10 and (rld.LearnDel_AgeAtStart >= 19 or rld.LearnDel_AgeAtStart = -1))


set @CL_AdultEnrollmentsThisYear = (select count(ld.learnrefnumber) from [Report].[CL_SummaryOfLearners_FAMS] ld
									inner join Rulebase.DV_LearningDelivery rld on ld.LearnRefNumber = rld.LearnRefNumber and ld.AimSeqNumber = rld.AimSeqNumber
									where ld.FundModel = 10 and ld.LearnStartDate >= @startDate and ld.LearnStartDate < @endDate and (rld.LearnDel_AgeAtStart >= 19 or rld.LearnDel_AgeAtStart = -1 ))


select @CL_AdultLearnersStartedThisYear = count(distinct le.learnrefnumber) FROM [Report].[LearnersStartedThisFundingYear] le 
							INNER JOIN Rulebase.DV_LearningDelivery rld on rld.LearnRefNumber = le.LearnRefNumber and rld.AimSeqNumber = le.AimSeqNumber
							where rld.LearnDel_AgeAtStart >= 19 or rld.LearnDel_AgeAtStart = -1



Truncate Table [Report].[LearnersEarliestAim]
Truncate Table [Report].[LearnersStartedThisFundingYear]
Select @PCDL_TotalLearners = count(distinct LearnRefNumber) from [Report].[CL_SummaryOfLearners_FAMS]  where ASL = 1 and FundModel = 10 


INSERT INTO [Report].[LearnersEarliestAim]
	SELECT 	LearnRefNumber, min(LearnStartDate) as LearnStartDate FROM [Report].[CL_SummaryOfLearners_FAMS]	 group by LearnRefNumber,fundmodel, ASL	having fundmodel =10 and ASL = 1


Select @PCDL_LearnersStartedThisYear = count(distinct LearnRefNumber) from [Report].[LearnersEarliestAim] where LearnStartDate >= @startDate and LearnStartDate < @endDate

Select @PCDL_EnrollmentsThisYear = count(LearnRefNumber) from [Report].[CL_SummaryOfLearners_FAMS] where ASL = 1 and FundModel = 10 and LearnStartDate >= @startDate and LearnStartDate < @endDate


Truncate Table [Report].[LearnersEarliestAim]
Truncate Table [Report].[LearnersStartedThisFundingYear]
Select @NLDC_TotalLearners = count(distinct LearnRefNumber) from [Report].[CL_SummaryOfLearners_FAMS] where FundModel = 10  and ASL = 2

INSERT INTO [Report].[LearnersEarliestAim]
	SELECT 	LearnRefNumber, min(LearnStartDate) as LearnStartDate	FROM [Report].[CL_SummaryOfLearners_FAMS]	 group by LearnRefNumber,fundmodel, ASL	having fundmodel =10 and ASL = 2


Select @NLDC_LearnersStartedThisYear = count(distinct LearnRefNumber) from [Report].[LearnersEarliestAim] where LearnStartDate >= @startDate and LearnStartDate < @endDate

Select @NLDC_EnrollmentsThisYear = count(LearnRefNumber) from [Report].[CL_SummaryOfLearners_FAMS] where  FundModel = 10 and ASL = 2 and LearnStartDate >= @startDate and LearnStartDate < @endDate


Truncate Table [Report].[LearnersEarliestAim]
Truncate Table [Report].[LearnersStartedThisFundingYear]

Select @FEML_TotalLearners = count(distinct LearnRefNumber) from [Report].[CL_SummaryOfLearners_FAMS] where FundModel = 10  and ASL = 3

INSERT INTO [Report].[LearnersEarliestAim]
	SELECT 	LearnRefNumber, min(LearnStartDate) as LearnStartDate	FROM [Report].[CL_SummaryOfLearners_FAMS]	 group by LearnRefNumber,fundmodel, ASL	having fundmodel =10 and ASL = 3


INSERT INTO [Report].[LearnersStartedThisFundingYear]
	SELECT le.LearnRefNumber,ld.AimSeqNumber, le.LearnStartDate FROM [Report].[LearnersEarliestAim] le
	INNER JOIN [Report].[CL_SummaryOfLearners_FAMS] ld on le.LearnRefNumber = ld.LearnRefNumber and le.LearnStartDate = ld.LearnStartDate
	WHERE le.LearnStartDate >= @startDate and le.LearnStartDate < @endDate and ld.FundModel = 10 AND ASL = 3


Select @FEML_LearnersStartedThisYear = count(distinct LearnRefNumber) from [Report].[LearnersStartedThisFundingYear]

Select @FEML_EnrollmentsThisYear = count(LearnRefNumber) from [Report].[CL_SummaryOfLearners_FAMS] where  FundModel = 10 and ASL = 3 and LearnStartDate >= @startDate and LearnStartDate < @endDate



select @FEML_1618TotalLearners = count(distinct ld.learnrefnumber) FROM [Report].[CL_SummaryOfLearners_FAMS] ld 
							INNER JOIN Rulebase.DV_LearningDelivery rld on rld.LearnRefNumber = ld.LearnRefNumber and rld.AimSeqNumber = ld.AimSeqNumber
							where ld.FundModel = 10 and ld.ASL=3 and rld.LearnDel_AgeAtStart > 0 and rld.LearnDel_AgeAtStart < 19

select @FEML_1618EnrollmentsThisYear = count(ld.learnrefnumber) from [Report].[CL_SummaryOfLearners_FAMS] ld
									inner join Rulebase.DV_LearningDelivery rld on ld.LearnRefNumber = rld.LearnRefNumber and ld.AimSeqNumber = rld.AimSeqNumber
									where ld.FundModel = 10 and ld.ASL=3 and ld.LearnStartDate >= @startDate and ld.LearnStartDate < @endDate 
									and rld.LearnDel_AgeAtStart > 0 and rld.LearnDel_AgeAtStart < 19 



select @FEML_1618LearnersStartedThisYear = count(distinct le.learnrefnumber) FROM [Report].[LearnersStartedThisFundingYear] le 
							INNER JOIN Rulebase.DV_LearningDelivery rld on rld.LearnRefNumber = le.LearnRefNumber and rld.AimSeqNumber = le.AimSeqNumber
							where rld.LearnDel_AgeAtStart > 0 and rld.LearnDel_AgeAtStart < 19

select @FEML_AdultTotalLearners=  count(distinct ld.learnrefnumber) FROM [Report].[CL_SummaryOfLearners_FAMS] ld 
							INNER JOIN Rulebase.DV_LearningDelivery rld on rld.LearnRefNumber = ld.LearnRefNumber and rld.AimSeqNumber = ld.AimSeqNumber
							where ld.FundModel = 10 and ld.ASL=3 and (rld.LearnDel_AgeAtStart >= 19 or rld.LearnDel_AgeAtStart = -1)

select @FEML_AdultEnrollmentsThisYear= count(ld.learnrefnumber) from [Report].[CL_SummaryOfLearners_FAMS] ld
									inner join Rulebase.DV_LearningDelivery rld on ld.LearnRefNumber = rld.LearnRefNumber and ld.AimSeqNumber = rld.AimSeqNumber
									where ld.FundModel = 10 and ld.ASL=3 and ld.LearnStartDate >= @startDate and ld.LearnStartDate < @endDate 
									and (rld.LearnDel_AgeAtStart >= 19 or rld.LearnDel_AgeAtStart = -1)



select @FEML_AdultLearnersStartedThisYear = count(distinct le.learnrefnumber) FROM [Report].[LearnersStartedThisFundingYear] le 
							INNER JOIN Rulebase.DV_LearningDelivery rld on rld.LearnRefNumber = le.LearnRefNumber and rld.AimSeqNumber = le.AimSeqNumber
							where rld.LearnDel_AgeAtStart >= 19 or rld.LearnDel_AgeAtStart = -1

Truncate Table [Report].[LearnersEarliestAim]
Truncate Table [Report].[LearnersStartedThisFundingYear]

Select @WFL_TotalLearners = count(distinct LearnRefNumber) from [Report].[CL_SummaryOfLearners_FAMS] where FundModel = 10  and ASL = 4

INSERT INTO [Report].[LearnersEarliestAim]
	SELECT 		LearnRefNumber, min(LearnStartDate) as LearnStartDate	FROM [Report].[CL_SummaryOfLearners_FAMS]	 group by LearnRefNumber,fundmodel, ASL	having fundmodel =10 and ASL = 4


INSERT INTO [Report].[LearnersStartedThisFundingYear]
	SELECT le.LearnRefNumber,ld.AimSeqNumber, le.LearnStartDate FROM [Report].[LearnersEarliestAim] le
	INNER JOIN [Report].[CL_SummaryOfLearners_FAMS] ld on le.LearnRefNumber = ld.LearnRefNumber and le.LearnStartDate = ld.LearnStartDate
	WHERE le.LearnStartDate >= @startDate and le.LearnStartDate < @endDate and ld.FundModel = 10 AND ld.ASL = 4


Select @WFL_LearnersStartedThisYear = count(distinct LearnRefNumber) from  [Report].[LearnersStartedThisFundingYear]

Select @WFL_EnrollmentsThisYear = count(LearnRefNumber) from [Report].[CL_SummaryOfLearners_FAMS] where  FundModel = 10 and ASL = 4 and LearnStartDate >= @startDate and LearnStartDate < @endDate



select @WFL_1618TotalLearners = count(distinct ld.learnrefnumber) FROM [Report].[CL_SummaryOfLearners_FAMS] ld 
							INNER JOIN Rulebase.DV_LearningDelivery rld on rld.LearnRefNumber = ld.LearnRefNumber and rld.AimSeqNumber = ld.AimSeqNumber
							where ld.FundModel = 10 and ld.ASL=4 and rld.LearnDel_AgeAtStart > 0 and rld.LearnDel_AgeAtStart < 19

select @WFL_1618EnrollmentsThisYear = count(ld.learnrefnumber) from [Report].[CL_SummaryOfLearners_FAMS] ld
									inner join Rulebase.DV_LearningDelivery rld on ld.LearnRefNumber = rld.LearnRefNumber and ld.AimSeqNumber = rld.AimSeqNumber
									where ld.FundModel = 10 and ld.ASL=4 and ld.LearnStartDate >= @startDate and ld.LearnStartDate < @endDate 
									and rld.LearnDel_AgeAtStart > 0 and rld.LearnDel_AgeAtStart < 19 



select @WFL_1618LearnersStartedThisYear = count(distinct le.learnrefnumber) FROM  [Report].[LearnersStartedThisFundingYear] le 
							INNER JOIN Rulebase.DV_LearningDelivery rld on rld.LearnRefNumber = le.LearnRefNumber and rld.AimSeqNumber = le.AimSeqNumber
							where rld.LearnDel_AgeAtStart > 0 and  rld.LearnDel_AgeAtStart < 19

select @WFL_AdultTotalLearners=  count(distinct ld.learnrefnumber) FROM [Report].[CL_SummaryOfLearners_FAMS] ld 
							INNER JOIN Rulebase.DV_LearningDelivery rld on rld.LearnRefNumber = ld.LearnRefNumber and rld.AimSeqNumber = ld.AimSeqNumber
							where ld.FundModel = 10 and ld.ASL=4 and (rld.LearnDel_AgeAtStart >= 19 or rld.LearnDel_AgeAtStart = -1)

select @WFL_AdultEnrollmentsThisYear= count(ld.learnrefnumber) from [Report].[CL_SummaryOfLearners_FAMS] ld
									inner join Rulebase.DV_LearningDelivery rld on ld.LearnRefNumber = rld.LearnRefNumber and ld.AimSeqNumber = rld.AimSeqNumber
									where ld.FundModel = 10 and ld.ASL=4 and ld.LearnStartDate >= @startDate and ld.LearnStartDate < @endDate 
									and (rld.LearnDel_AgeAtStart >= 19 or rld.LearnDel_AgeAtStart = -1)



select @WFL_AdultLearnersStartedThisYear = count(distinct le.learnrefnumber) FROM  [Report].[LearnersStartedThisFundingYear] le 
							INNER JOIN Rulebase.DV_LearningDelivery rld on rld.LearnRefNumber = le.LearnRefNumber and rld.AimSeqNumber = le.AimSeqNumber
							where rld.LearnDel_AgeAtStart >= 19 or rld.LearnDel_AgeAtStart = -1
							


Truncate Table [Report].[LearnersEarliestAim]
Truncate Table [Report].[LearnersStartedThisFundingYear]

Select @MHP_TotalLearners = count(distinct LearnRefNumber) from [Report].[CL_SummaryOfLearners_FAMS] where FundModel = 10  and (LDM1 = 340 or LDM2 = 340 or LDM3 = 340 or LDM4 = 340)

INSERT INTO [Report].[LearnersEarliestAim]
	SELECT 		LearnRefNumber, 		min(LearnStartDate) as LearnStartDate	FROM [Report].[CL_SummaryOfLearners_FAMS]
	 group by LearnRefNumber,fundmodel, LDM1,LDM2,LDM3,LDM4
	having fundmodel =10 and (LDM1 = 340 or LDM2 = 340 or LDM3 = 340 or LDM4 = 340)


Select @MHP_LearnersStartedThisYear = count(distinct LearnRefNumber) from [Report].[LearnersEarliestAim] where LearnStartDate >= @startDate and LearnStartDate < @endDate

Select @MHP_EnrollmentsThisYear = count(LearnRefNumber) from [Report].[CL_SummaryOfLearners_FAMS] where  FundModel = 10 and LearnStartDate >= @startDate and LearnStartDate < @endDate and (LDM1 = 340 or LDM2 = 340 or LDM3 = 340 or LDM4 = 340)

Truncate Table [Report].[LearnersEarliestAim]
Truncate Table [Report].[LearnersStartedThisFundingYear]

--Populate the result in to report table
INSERT INTO [Report].[CommunityLearningReport]
           ([CL_TotalLearners]
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
           ,[MHP_EnrollmentsThisYear])
     
select  @CL_TotalLearners AS CL_TotalLearners, @CL_LearnersStartedThisYear AS CL_LearnersStartedThisYear, @CL_EnrollmentsThisYear AS CL_EnrollmentsThisYear,
		@CL_1618TotalLearners AS CL_1618TotalLearners, @CL_1618LearnersStartedThisYear AS CL_1618LearnersStartedThisYear, @CL_1618EnrollmentsThisYear AS CL_1618EnrollmentsThisYear, 
		@CL_AdultTotalLearners AS CL_AdultTotalLearners, @CL_AdultEnrollmentsThisYear AS CL_AdultEnrollmentsThisYear, @CL_AdultLearnersStartedThisYear AS CL_AdultLearnersStartedThisYear,
		@PCDL_TotalLearners AS PCDL_TotalLearners, @PCDL_LearnersStartedThisYear AS PCDL_LearnersStartedThisYear,@PCDL_EnrollmentsThisYear AS PCDL_EnrollmentsThisYear,
		@NLDC_TotalLearners AS NLDC_TotalLearners ,@NLDC_LearnersStartedThisYear AS NLDC_LearnersStartedThisYear ,@NLDC_EnrollmentsThisYear AS NLDC_EnrollmentsThisYear ,
		@FEML_TotalLearners AS FEML_TotalLearners, @FEML_LearnersStartedThisYear AS FEML_LearnersStartedThisYear, @FEML_EnrollmentsThisYear AS FEML_EnrollmentsThisYear,
		@FEML_1618TotalLearners AS FEML_1618TotalLearners, @FEML_1618LearnersStartedThisYear AS FEML_1618LearnersStartedThisYear, @FEML_1618EnrollmentsThisYear AS FEML_1618EnrollmentsThisYear,
		@FEML_AdultTotalLearners AS FEML_AdultTotalLearners, @FEML_AdultLearnersStartedThisYear AS FEML_AdultLearnersStartedThisYear, @FEML_AdultEnrollmentsThisYear AS FEML_AdultEnrollmentsThisYear,
		@WFL_TotalLearners AS WFL_TotalLearners, @WFL_LearnersStartedThisYear AS WFL_LearnersStartedThisYear, @WFL_EnrollmentsThisYear AS WFL_EnrollmentsThisYear,
		@WFL_1618TotalLearners AS WFL_1618TotalLearners, @WFL_1618LearnersStartedThisYear AS WFL_1618LearnersStartedThisYear, @WFL_1618EnrollmentsThisYear AS WFL_1618EnrollmentsThisYear,
		@WFL_AdultTotalLearners AS WFL_AdultTotalLearners, @WFL_AdultLearnersStartedThisYear AS WFL_AdultLearnersStartedThisYear, @WFL_AdultEnrollmentsThisYear AS WFL_AdultEnrollmentsThisYear,
		@MHP_TotalLearners AS MHP_TotalLearners, @MHP_LearnersStartedThisYear AS MHP_LearnersStartedThisYear, @MHP_EnrollmentsThisYear AS MHP_EnrollmentsThisYear

END