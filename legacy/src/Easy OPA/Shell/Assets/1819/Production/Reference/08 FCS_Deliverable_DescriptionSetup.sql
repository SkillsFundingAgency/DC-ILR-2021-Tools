INSERT INTO  [Reference].FCS_Deliverable_Description (ContractAllocationNumber , DeliverableCode , DeliverableDescription)
SELECT DISTINCT SD.ConRefNumber, SD.DeliverableCode, ISNULL(DC.DeliverableDescription,'')
FROM [Reference].ESF_SupplementaryData SD
INNER JOIN [${FCS-Contracts.FullyQualified}].dbo.DeliverableCodeMappings DCM(nolock) ON SD.DeliverableCode = DCM.ExternalDeliverableCode
INNER JOIN [${FCS-Contracts.FullyQualified}].dbo.vw_ContractDeliverable DC(nolock) ON  DC.deliverableCode = DCM.FCSDeliverableCode
	AND SD.ConRefNumber = DC.contractAllocationNumber ; 

