IF OBJECT_ID('Reference.LARSLARS') IS NOT NULL
BEGIN
	DROP TABLE [Reference].[LARSLARS]
END;
                
CREATE TABLE [Reference].[LARSLARS]
(
	LearnAimRef							VARCHAR(8),
	BasicSkills							INT, 
	AwardOrgAimRef						VARCHAR(50),
	UnemployedOnly						INT,	
	LearnDirectClassSystemCode1			VARCHAR(12),
	LearnDirectClassSystemCode2			VARCHAR(12), 
	LearnDirectClassSystemCode3			VARCHAR(12), 
	LearnAimRefType						VARCHAR(4), 
	FullLevel2EntitlementCategory		INT, 
	FullLevel3EntitlementCategory		INT, 
	NotionalNVQLevelv2					VARCHAR(1), 
	RegulatedCreditValue                INT,
	UnitType							VARCHAR(50), 
	Section96ReviewDate					DATE, 
	Section96ApprovalStatus				INT,
	FrameworkCommonComponent			INT,
	BasicSkillsParticipation			INT,
	BasicSkillsType						INT,
	FullLevel2Percent					DECIMAL(5,2),
	FullLevel3Percent                   DECIMAL(5,2), 
	MI_FullLevel3Percent				DECIMAL(5,2),
	NotionalNVQLevel					VARCHAR(1),
	CreditBasedFwkType					INT,
	EnglandFEHEStatus					VARCHAR(1),
	LearnAimRefTitle					VARCHAR(254) null,
	SectorSubjectAreaTier2				DECIMAL(5, 2) null,
	EnglPrscID							INT,
	EffectiveFrom						Date,
	EffectiveTo							Date,
	SfaApprovalStatus					INT
)

-- TODO: Index

