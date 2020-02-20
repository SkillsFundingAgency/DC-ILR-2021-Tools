IF OBJECT_ID('Report.ValidLearnerEmpStatsBeforeLearnStartDate') IS NOT NULL
BEGIN
	DROP VIEW Report.ValidLearnerEmpStatsBeforeLearnStartDate
END
GO


CREATE VIEW [Report].[ValidLearnerEmpStatsBeforeLearnStartDate] 
AS
SELECT 
	L.LearnRefNumber, L.EmpStat, L.DateEmpStatApp, L.EmpId, Denorm.ESMCode_BSI, 
	Denorm.ESMCode_EII, Denorm.ESMCode_LOE, Denorm.ESMCode_LOU, Denorm.ESMCode_PEI, Denorm.ESMCode_SEI, Denorm.ESMCode_SEM 
FROM valid.LearnerEmploymentStatus L
	INNER JOIN
		(
		SELECT 
				LearnRefNumber, MAX(DateEmpStatApp) "DateEmpStatApp"
			FROM
			(
			SELECT 
					L.LearnRefNumber, L2.EmpId, L.DateEmpStatApp, LD.LearnStartDate
					,CASE WHEN L.DateEmpStatApp <= LD.LearnStartDate THEN L.DateEmpStatApp ELSE NULL END AS ValidEmpStatDate
				 FROM valid.LearnerEmploymentStatusDenorm L
				 INNER JOIN Valid.LearnerEmploymentStatus L2 
					on l2.LearnRefNumber = L.LearnRefNumber
					and l2.DateEmpStatApp = L.DateEmpStatApp
					and l2.EmpStat = L.EmpStat
				 LEFT JOIN Valid.LearningDelivery LD 
				ON LD.LearnRefNumber = L.LearnRefNumber
			) a
		WHERE ValidEmpStatDate IS NOT NULL
		GROUP BY LearnRefNumber
	) LES
	ON  L.LearnRefNumber = LES.LearnRefNumber
	AND L.DateEmpStatApp = LES.DateEmpStatApp
INNER JOIN Valid.LearnerEmploymentStatusDenorm Denorm
ON Denorm.LearnRefNumber = L.LearnRefNumber
and Denorm.DateEmpStatApp = L.DateEmpStatApp
and Denorm.EmpStat = L.EmpStat