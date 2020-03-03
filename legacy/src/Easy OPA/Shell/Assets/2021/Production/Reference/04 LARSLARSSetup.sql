INSERT INTO [Reference].[LARSLARS] (
	LearnAimRef,
	BasicSkills,
	--AwardOrgAimRef,
	--UnemployedOnly,
	LearnDirectClassSystemCode1,
	LearnDirectClassSystemCode2,
	LearnDirectClassSystemCode3,
	LearnAimRefType,
	FullLevel2EntitlementCategory, 
	FullLevel3EntitlementCategory, 
	NotionalNVQLevelv2, 
	RegulatedCreditValue,
	--UnitType, 
	--Section96ReviewDate, 
	--Section96ApprovalStatus,
	FrameworkCommonComponent,
	--BasicSkillsParticipation,
	BasicSkillsType,
	FullLevel2Percent,
	FullLevel3Percent,
	--MI_FullLevel3Percent,
	NotionalNVQLevel,
	--CreditBasedFwkType,
	EnglandFEHEStatus,
	LearnAimRefTitle,
	SectorSubjectAreaTier2,
	EnglPrscID,
	EffectiveFrom,
	EffectiveTo
	--SfaApprovalStatus	
	)
SELECT DISTINCT 
	L.LearnAimRef,
	AV.BasicSkills,
	--L.AwardOrgAimRef,
	--L.UnemployedOnly,
	L.LearnDirectClassSystemCode1,
	L.LearnDirectClassSystemCode2,
	L.LearnDirectClassSystemCode3,
	L.LearnAimRefType,
	AV.FullLevel2EntitlementCategory, 
	AV.FullLevel3EntitlementCategory, 
	L.NotionalNVQLevelv2, 
	L.RegulatedCreditValue,
	--L.UnitType, 
	--S96.Section96ReviewDate, 
	--S96.Section96ApprovalStatus,
	L.FrameworkCommonComponent,
	--AV.BasicSkillsParticipation,
	AV.BasicSkillsType,
	AV.FullLevel2Percent,
	AV.FullLevel3Percent,
	--AV.MI_FullLevel3Percent,
	L.NotionalNVQLevel,
	--L.CreditBasedFwkType,
	L.EnglandFEHEStatus,
	L.LearnAimRefTitle,
	L.SectorSubjectAreaTier2,
	L.EnglPrscID,
	AV.EffectiveFrom,
	AV.EffectiveTo
	--AV.SfaApprovalStatus

--FROM [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_LearningDelivery] L
FROM ReferenceInput.ReferenceInput.[LARS_LARSLearningDelivery] L
INNER JOIN (SELECT DISTINCT LearnAimRef FROM Input.LearningDelivery) LD ON L.LearnAimRef = LD.LearnAimRef
--INNER JOIN  [${UoD.FullyQualified}].[${LARS.schemaname}].LARS_LARSAnnualValue AV on L.LearnAimRef = AV.LearnAimRef
INNER JOIN  ReferenceInput.ReferenceInput.LARS_LARSAnnualValue AV on L.LearnAimRef = AV.LearnAimRef
--INNER JOIN  [${UoD.FullyQualified}].[${LARS.schemaname}].[LARS_LARSSection96] S96 ON L.LearnAimRef=S96.LearnAimRef
where '1-Aug-2016' between AV.[EffectiveFrom] and coalesce(AV.[EffectiveTo],dateadd(yy,10,getdate()))

