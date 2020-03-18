IF OBJECT_ID('Report.[CL_SummaryOfLearners_FAMS]') IS NOT NULL
BEGIN
	DROP VIEW [Report].[CL_SummaryOfLearners_FAMS]
END
GO

CREATE VIEW [Report].[CL_SummaryOfLearners_FAMS] 
AS
select ld.*, 
	[LearnDelFAMCode] AS ASL
	from Valid.LearningDeliveryDenorm ld
LEFT JOIN valid.LearningDeliveryFAM f ON 
F.learnrefnumber = ld.LearnRefNumber
and f.AimSeqNumber = ld.AimSeqNumber
and f.LearnDelFAMType = 'ASL'
where fundmodel=10
GO

