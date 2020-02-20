INSERT INTO [Reference].[Version] ([LARSVersion],
									[CCMVersion],
									[OrgVersion],
									[PostcodeAreaCostVersion],
									[EmployerVersion])
SELECT 
	[LARSVersion]=(SELECT Top 1 [CurrentVersion] FROM [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_Current_Version]),
	[CCMVersion] = 'N/A',
	[OrgVersion] = 'N/A',
	[PostcodeAreaCostVersion] = 'N/A',
	[EmployerVersion] = 'N/A'