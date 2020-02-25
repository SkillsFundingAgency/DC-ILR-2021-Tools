IF OBJECT_ID('Reference.Version') IS NOT NULL
BEGIN
	DROP TABLE [Reference].[Version]
END;
                
CREATE TABLE [Reference].[Version]
(	
	LARSVersion VARCHAR(100) NOT NULL,
	CCMVersion  VARCHAR(100) NOT NULL,
	OrgVersion  VARCHAR(100) NOT NULL,
	PostcodeAreaCostVersion  VARCHAR(100) NOT NULL,
	EmployerVersion VARCHAR(100) NOT NULL
)