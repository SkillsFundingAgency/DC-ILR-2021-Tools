
INSERT INTO [Valid].[File]
           ([UKPRN]
           ,[FileName])
     SELECT UKPRN
		, 'ILR-'+cast(UKPRN as varchar(8))+'-2021-20210521-000000-01' as [FileName]
	 FROM Valid.LearningProvider
GO
