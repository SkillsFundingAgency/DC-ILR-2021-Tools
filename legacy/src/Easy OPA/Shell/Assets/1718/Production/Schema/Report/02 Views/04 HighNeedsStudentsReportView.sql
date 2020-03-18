IF OBJECT_ID('Report.HNSLearnerFAM') IS NOT NULL
BEGIN
	DROP VIEW Report.HNSLearnerFAM
END
GO


CREATE VIEW [Report].[HNSLearnerFAM] 
AS

	SELECT LearnRefNumber, EHC, HNS
	FROM (
	SELECT LearnRefNumber, LearnFAMType,	LearnFAMCode
	from [Valid].[LearnerFAM]  where [LearnFAMType] in ('EHC','HNS')
	 ) up
	 PIVOT (sum(LearnFAMCode) FOR LearnFAMType IN (EHC,HNS)) AS pvt
	
GO




IF OBJECT_ID('Report.HighNeedsStudentsReport') IS NOT NULL
BEGIN
	DROP VIEW Report.HighNeedsStudentsReport
END
GO


CREATE VIEW [Report].[HighNeedsStudentsReport] 
AS

--DECLARE @ValidFunding NVARCHAR = '';
--DECLARE @Page int = 1;
--DECLARE @PageSize int = 1000;

--WITH LearnerFAM_CTE AS
--(
--	SELECT LearnRefNumber, EHC, HNS
--	FROM (
--	SELECT LearnRefNumber, LearnFAMType,	LearnFAMCode
--	from [Valid].[LearnerFAM]  where [LearnFAMType] in ('EHC','HNS')
--	 ) up
--	 PIVOT (sum(LearnFAMCode) FOR LearnFAMType IN (EHC,HNS)) AS pvt
	
--),
WITH HighNeedsStudentsLearnersCTE AS
(
	SELECT 
		LEFAF.FundLine AS 'Fund Line',
		L.LearnRefNumber AS 'Learner Reference',
		L.FamilyName 'Surname',
		L.GivenNames AS 'Forename',
		LEFAF.LearnerStartDate,
		A.ProvSpecLearnMon as ProvSpecMon_A,
		B.ProvSpecLearnMon as ProvSpecMon_B,		
		CASE 
			WHEN  FAM_CTE.EHC = 1 
			THEN 1 ELSE 0 END 
														AS 'A - Students with an EHCP',
		CASE
			WHEN (FAM_CTE.EHC IS NULL OR FAM_CTE.EHC != 1)
			THEN 1 ELSE 0 END
														AS 'B - Students without an EHCP',
		CASE
			WHEN FAM_CTE.HNS = 1 AND (FAM_CTE.EHC IS NULL OR FAM_CTE.EHC != 1)
			THEN 1 ELSE 0 END
														AS 'C - High Needs Students (HNS) without an EHCP',
		CASE
			WHEN FAM_CTE.EHC = 1 AND FAM_CTE.HNS = 1
			THEN 1 ELSE 0 END
														AS 'D - Students with an EHCP and HNS',
		CASE
			WHEN (FAM_CTE.EHC = 1) AND (FAM_CTE.HNS IS NULL)
			THEN 1 ELSE 0 END
														AS 'E - Students with an EHCP but without HNS',
		0 AS 'F - Students with an LDA'
	FROM [Valid].[Learner] L
	INNER JOIN [Rulebase].[EFA_Learner] LEFAF	ON L.LearnRefNumber = LEFAF.LearnRefNumber
	LEFT JOIN [Report].[HNSLearnerFAM]  FAM_CTE ON FAM_CTE.LearnRefNumber = L.LearnRefNumber
	LEFT JOIN [Valid].[ProviderSpecLearnerMonitoring] A ON L.LearnRefNumber = A.LearnRefNumber and A.ProvSpecLearnMonOccur = 'A'
	LEFT JOIN [Valid].[ProviderSpecLearnerMonitoring] B ON L.LearnRefNumber = B.LearnRefNumber and B.ProvSpecLearnMonOccur = 'B'
	WHERE LEFAF.StartFund = 1
		AND EXISTS (
			SELECT 1
			FROM [Valid].[LearningDelivery] ld
			inner join [Valid].[LearningDeliveryFAM] ldfam on ld.LearnRefNumber = ldfam.LearnRefNumber and ld.AimSeqNumber = ldfam.AimSeqNumber
			WHERE ld.[LearnRefNumber] = l.[LearnRefNumber]
				AND ld.[FundModel] = 25
				AND ldfam.LearnDelFAMType = 'SOF' and ldfam.LearnDelFAMCode = '107'
		)
)

SELECT *
	FROM HighNeedsStudentsLearnersCTE
	WHERE [Fund Line] = '14-16 Direct Funded Students'
UNION ALL
SELECT
		'16-19 Students (including High Needs Students)' AS 'Fund Line',
		[Learner Reference],
		[Surname],
		[Forename],
		LearnerStartDate,
		ProvSpecMon_A,
		ProvSpecMon_B,
		[A - Students with an EHCP],
		[B - Students without an EHCP],
		[C - High Needs Students (HNS) without an EHCP],
		[D - Students with an EHCP and HNS],
		[E - Students with an EHCP but without HNS],
		[F - Students with an LDA]
	FROM HighNeedsStudentsLearnersCTE
	WHERE ([Fund Line] = '16-19 High Needs Students' OR [Fund Line] = '16-19 Students (excluding High Needs Students)')
UNION ALL
SELECT *
	FROM HighNeedsStudentsLearnersCTE
	WHERE [Fund Line] = '19-24 Students with an EHCP'
UNION ALL
--SELECT *
--	FROM HighNeedsStudentsLearnersCTE
--	WHERE [Fund Line] = '19-24 Students with an LDA'
--UNION ALL
SELECT *
	FROM HighNeedsStudentsLearnersCTE
	WHERE [Fund Line] = '19+ Continuing Students (excluding EHCP)'


--"A - Students with LDA or EHCP  =  students where LrnFAMtype=LDA and LrnFAMcode=1 or LrnFAMtype=EHC and LrnFAMcode=1   
--B - Students without an LDA or EHCP  =students where LrnFAMtype does not equal LDA and LrnFAMcode does not equal 1 and LrnFAMtype does not equal EHC and LrnFAMcode does not equal 1
--C - High Needs Students (HNS) without an LDA or EHCP =  students where  LrnFAMtype=HNS and LrnFAMCode=1 and LrnFAMtype does not equal LDA and LrnFAMcode does not equal 1 and LrnFAMtype does not equal EHC and LrnFAMcode does not equal 1   
--D - Students with LDA or EHCP and HNS = students where (LrnFAMtype=LDA and LrnFAMcode=1 or LrnFAMtype=EHC and LrnFAMcode=1) AND LrnFAMType=HNS and LrnFAMCode=1
--E - Students with LDA or EHCP but without HNS = students where (LrnFAMtype=LDA and LrnFAMcode=1 or LrnFAMtype=EHC and LrnFAMcode=1) AND LrnFAMType does not equal HNS

--All 14-16 Direct Funded Students = the sum of all students in this funding line type where startfund=1

--All 16-19 Students (Including High Needs Students) = the sum of all students in this funding line type where startfund=1

--All 19-24 Students with an LDA or EHCP= the sum of all students in this funding line type where startfund=1

--All 19+ Continuing Students (excluding High Needs Students)= the sum of all students in this funding line type where startfund=1

--"					


