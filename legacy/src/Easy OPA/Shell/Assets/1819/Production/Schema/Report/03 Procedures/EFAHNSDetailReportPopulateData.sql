IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[EFAHNSDetailReportPopulateData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[EFAHNSDetailReportPopulateData]
GO

CREATE PROCEDURE [Report].[EFAHNSDetailReportPopulateData]
AS
BEGIN
	-- Clear previous report data - needed by FIS
	TRUNCATE TABLE [Report].[EFAHNSDetailReport]

	-- Populate Report Data
	INSERT INTO [Report].[EFAHNSDetailReport]
								([Fund Line]
								,[Learner Reference]
								,[Surname]
								,[Forename]
								,[A - Students with an EHCP]
								,[B - Students without an EHCP]
								,[C - High Needs Students (HNS) without an EHCP]
								,[D - Students with an EHCP and HNS]
								,[E - Students with an EHCP but without HNS]
								,[F - Students with an LDA]
								,[Security Classification]
								,[SortOrder]
								,[LearnerStartDate]
								,[ProvSpecMon_A]
								,[ProvSpecMon_B])
	
	SELECT		[Fund Line],
				[Learner Reference],
				[Surname],
				[Forename],
				Case [A - Students with an EHCP] when 1 then 'Y' Else 'N' End as [A - Students with an EHCP],
				Case [B - Students without an EHCP] when 1 then 'Y' Else 'N' End as [B - Students without an EHCP],
				Case [C - High Needs Students (HNS) without an EHCP] when 1 then 'Y' Else 'N' End as [C - High Needs Students (HNS) without an EHCP],
				Case [D - Students with an EHCP and HNS] when 1 then 'Y' Else 'N' End as [D - Students with an EHCP and HNS],
				Case [E - Students with an EHCP but without HNS] when 1 then 'Y' Else 'N' End as [E - Students with an EHCP but without HNS],
				'' as [F - Students with an LDA],				
				'' AS [Security Classification],
				SortOrder = CASE	WHEN [Fund Line]= '14-16 Direct Funded Students' THEN 1			
									WHEN [Fund Line]= '16-19 Students (including High Needs Students)' THEN 2
									WHEN [Fund Line]= '19-24 Students with an EHCP' THEN 3
									--WHEN [Fund Line]= '19-24 Students with an LDA' THEN 4
									WHEN [Fund Line]= '19+ Continuing Students (excluding EHCP)' THEN 5
							ELSE 5 END,
				[LearnerStartDate],
				[ProvSpecMon_A],
				[ProvSpecMon_B] 		 		 
	FROM [Report].[HighNeedsStudentsReport]
		
END

GO

