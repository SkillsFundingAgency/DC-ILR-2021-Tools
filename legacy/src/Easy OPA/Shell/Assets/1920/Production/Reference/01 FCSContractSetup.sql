INSERT INTO [Reference].[FCSContract] (UKPRN, OrganisationIdentifier, FundingStreamPeriodCode,Period,contractNumber,contractAllocationNumber)
SELECT DISTINCT 
	UKPRN,
	OrganisationIdentifier,
	FundingStreamPeriodCode,
	Period,
	contractNumber,
	contractAllocationNumber
FROM [${FCS-Contracts.servername}].[${FCS-Contracts.databasename}].[dbo].[vw_ContractValidation]

WHERE UKPRN = (SELECT TOP 1 UKPRN FROM ${runmode.inputsource}.LearningProvider) AND PERIOD in('${Contract.Period}','${ESF.Contract.Period}')