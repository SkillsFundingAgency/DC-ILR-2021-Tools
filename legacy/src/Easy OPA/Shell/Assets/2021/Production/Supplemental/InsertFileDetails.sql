
DECLARE @UKPRN INT,
        @Filename VARCHAR(50),
		@FileSizeKb BIGINT,
		@TotalLearnersSubmitted INT,
		@TotalValidLearnersSubmitted INT,
		@TotalInvalidLearnersSubmitted INT,
		@TotalErrorCount INT,
		@TotalWarningCount INT

SET @UKPRN= (SELECT TOP(1) UKPRN FROM [Valid].[LearningProvider])
SET @Filename=(SELECT '${submission.filename}')
SET @FileSizeKb=(SELECT '${FileSizeKb}')
SET @TotalLearnersSubmitted=(SELECT Count(*) FROM (SELECT DISTINCT(LearnRefNumber) FROM [Input].Learner
			                 UNION
			                 SELECT DISTINCT(LearnRefNumber) FROM [Input].LearnerDestinationandProgression ) S)
SET @TotalValidLearnersSubmitted=(SELECT Count(*) FROM (SELECT DISTINCT(LearnRefNumber) FROM [Valid].Learner
			                 UNION
			                 SELECT DISTINCT(LearnRefNumber) FROM [Valid].LearnerDestinationandProgression )S)
SET @TotalInvalidLearnersSubmitted=(SELECT Count(*) FROM (SELECT DISTINCT(LearnRefNumber) FROM [Invalid].Learner
			                 UNION
			                 SELECT DISTINCT(LearnRefNumber) FROM [Invalid].LearnerDestinationandProgression )S)
SET @TotalErrorCount=(SELECT COUNT(1) FROM [Report].[ValidationError] WHERE Severity='E')
SET @TotalWarningCount=(SELECT COUNT(1) FROM [Report].[ValidationError] WHERE Severity='W')

INSERT INTO [dbo].[FileDetails]
           ([UKPRN]
           ,[Filename]
           ,[FileSizeKb]
           ,[TotalLearnersSubmitted]
           ,[TotalValidLearnersSubmitted]
           ,[TotalInvalidLearnersSubmitted]
           ,[TotalErrorCount]
           ,[TotalWarningCount]
           ,[SubmittedTime]
           ,[Success])
     VALUES
           (@UKPRN
           ,@Filename
           ,@FileSizeKb
           ,@TotalLearnersSubmitted
           ,@TotalValidLearnersSubmitted
           ,@TotalInvalidLearnersSubmitted
           ,@TotalErrorCount
           ,@TotalWarningCount
           ,GETDATE()
           ,0)

