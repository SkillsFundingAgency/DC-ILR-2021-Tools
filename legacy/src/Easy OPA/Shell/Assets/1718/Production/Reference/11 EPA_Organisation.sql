INSERT INTO  [Reference].[EPAOrganisation]
([EPAOrgId],[Name],[EffectiveFrom],[EffectiveTo])
SELECT DISTINCT [Id],[Name],[EffectiveFrom],[EffectiveTo]  
FROM ${EPAReferenceData.FQ}.[dbo].[Organisation]
WHERE ID IN
(
	SELECT [EPAOrgID] FROM [Input].[LearningDelivery]
)