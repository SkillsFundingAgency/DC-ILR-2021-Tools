INSERT INTO  [Reference].[DeliverableCodeMappings] ([ExternalDeliverableCode]  ,[FundingStreamPeriodCode],[DeliverableName],[FCSDeliverableCode]   )
SELECT DISTINCT [ExternalDeliverableCode]  ,[FundingStreamPeriodCode],[DeliverableName] ,[FCSDeliverableCode] 
FROM [${FCS-Contracts.FullyQualified}].dbo.DeliverableCodeMappings ;

