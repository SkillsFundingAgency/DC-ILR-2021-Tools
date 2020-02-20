INSERT INTO  [Reference].ESF_SupplementaryData (ConRefNumber , DeliverableCode , CalendarYear , CalendarMonth , CostType , ReferenceType , Reference,Value)
SELECT SD.ConRefNumber, SD.DeliverableCode, SD.CalendarYear, SD.CalendarMonth, SD.CostType, SD.ReferenceType, SD.Reference, ISNULL(SD.VALUE,UC.VALUE)
FROM [${ESF_Supplementary_Data.FullyQualified}].dbo.SupplementaryData SD(nolock)
LEFT JOIN [${ESF_Supplementary_Data.FullyQualified}].dbo.SupplementaryDataUnitCost UC(nolock)ON 
		UC.ConRefNumber = SD.ConRefNumber AND 
		UC.DeliverableCode = SD.DeliverableCode AND
		UC.CalendarYear = SD.CalendarYear AND
		UC.CalendarMonth = SD.CalendarMonth AND
		UC.CostType = SD.CostType AND
		UC.ReferenceType = SD.ReferenceType AND
		UC.Reference = SD.Reference 
INNER JOIN [Reference].FCSContract FCS(nolock) ON SD.ConRefNumber = FCS.contractAllocationNumber; 

