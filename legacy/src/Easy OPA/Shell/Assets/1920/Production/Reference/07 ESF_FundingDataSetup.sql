
	TRUNCATE TABLE [Reference].[ESF_FundingData]

	INSERT INTO [Reference].[ESF_FundingData]
			   ([AcademicYear]
			   ,[UKPRN]
			   ,[ConRefNumber]
			   ,[LearnRefNumber]
			   ,[AimSeqNumber]
			   ,[DeliverableCode]
			   ,[AttributeName]
			   ,[Period_1]
			   ,[Period_2]
			   ,[Period_3]
			   ,[Period_4]
			   ,[Period_5]
			   ,[Period_6]
			   ,[Period_7]
			   ,[Period_8]
			   ,[Period_9]
			   ,[Period_10]
			   ,[Period_11]
			   ,[Period_12])
	SELECT  [AcademicYear]
		  ,[UKPRN]
		  ,[ConRefNumber]
		  ,[LearnRefNumber]
		  ,[AimSeqNumber]
		  ,[DeliverableCode]
		  ,[AttributeName]
		  ,[Period_1]
		  ,[Period_2]
		  ,[Period_3]
		  ,[Period_4]
		  ,[Period_5]
		  ,[Period_6]
		  ,[Period_7]
		  ,[Period_8]
		  ,[Period_9]
		  ,[Period_10]
		  ,[Period_11]
		  ,[Period_12]
	  FROM [${ESF_Funding_Data.FullyQualified}].[dbo].[ESFFundingData]
	  WHERE  [AcademicYear] IN ( '2015/16' ,'2016/17')
	  AND  [UKPRN] IN 
		(SELECT [UKPRN] FROM [${runmode.inputsource}].[LearningProvider])
  
GO

	---------------------------------------------------------------------------------------------------------

	TRUNCATE TABLE [Reference].[ESF_Processed_Providers]

	INSERT INTO [Reference].[ESF_Processed_Providers]
           ([UKPRN]
           ,[OrganisationId]
           ,[ProcessedTime]
           ,[SourceFileName]
           ,[FilePreparationDate]
           ,[FileUploadDate]
           ,[AcademicYear])
	SELECT [UKPRN]
		  ,[OrganisationId]
		  ,[ProcessedTime]
		  ,[SourceFileName]
		  ,[FilePreparationDate]
		  ,[FileUploadDate]
		  ,[AcademicYear]		  
	  FROM [${ESF_Funding_Data.FullyQualified}].[dbo].[Processed_Providers]
	  WHERE  
	  [AcademicYear] IN ( '2015/16' ,'2016/17') AND  
	  [UKPRN] IN 
		(SELECT [UKPRN] FROM [${runmode.inputsource}].[LearningProvider])
	
GO