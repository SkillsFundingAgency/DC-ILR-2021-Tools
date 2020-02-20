-- [Report].[EFAHNSDetailReport] table
IF OBJECT_ID('[Report].[EFAHNSDetailReport]') IS NOT NULL
BEGIN
    DROP TABLE  [Report].[EFAHNSDetailReport]
END

CREATE TABLE [Report].[EFAHNSDetailReport] (
	[Fund Line] VARCHAR(100),          
	[Learner Reference] VARCHAR(12),
	[Surname] VARCHAR(100),
	[Forename] VARCHAR(100),
	[A - Students with an EHCP] VARCHAR(1),
	[B - Students without an EHCP] VARCHAR(1),
	[C - High Needs Students (HNS) without an EHCP] VARCHAR(1),
	[D - Students with an EHCP and HNS] VARCHAR(1),
	[E - Students with an EHCP but without HNS] VARCHAR(1),
	[F - Students with an LDA] VARCHAR(1),
	[Security Classification] VARCHAR(200),	
	[SortOrder] INT,
	[LearnerStartDate] DATETIME,
	[ProvSpecMon_A] VARCHAR(50),
	[ProvSpecMon_B] VARCHAR(50)
)
GO
