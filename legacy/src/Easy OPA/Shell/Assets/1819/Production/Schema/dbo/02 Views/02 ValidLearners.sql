IF OBJECT_ID('ValidLearners') IS NOT NULL
BEGIN
	DROP VIEW ValidLearners
END
GO
CREATE VIEW ValidLearners 
AS
SELECT L.Learner_Id
FROM [Input].[Learner] L
WHERE NOT EXISTS ( SELECT * FROM [Report].[ValidationError] WHERE LearnRefNumber=L.LearnRefNumber AND Severity='E'  AND Source NOT IN ('Validation DP 17_18.zip','FD Validation DP 17_18.zip','SQL DP'))
AND L.LearnRefNumber IS NOT NULL
