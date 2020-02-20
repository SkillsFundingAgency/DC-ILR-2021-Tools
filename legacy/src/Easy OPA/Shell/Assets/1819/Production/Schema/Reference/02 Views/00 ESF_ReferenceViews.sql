--if object_id('[Reference].[vw_ContractDescription]','u') is not null
--begin
--	drop View [Reference].[vw_ContractDescription]
--end

--go
	
--create VIEW [Reference].[vw_ContractDescription]
--AS
--	SELECT 
--	esf.[ContractAllocationEndDate], 
--	esf.[ContractAllocationNumber] ,
--	esf.[ContractAllocationStartDate],
--	esf.[DeliverableCode] ,
--	esf.[LearningRatePremiumFactor] ,
--	esf.[UnitCost],
--	fcs.[fundingStreamPeriodCode]

--	FROM [Reference].[ESF_Data] esf INNER JOIN 
--	[Reference].[FCSContract] fcs ON fcs.contractAllocationNumber = esf.contractAllocationNumber
