--In FIS Manifest - Make sure this appears after the html form(as filters need applying before aggregation)
EXEC [Report].[SFAFundingModel35SummaryReportPopulateData] '${ProvSpecLearnMonA}' , '${ProvSpecLearnMonB}', '${ProvSpecDelMonA}' , '${ProvSpecDelMonB}' , '${ProvSpecDelMonC}' , '${ProvSpecDelMonD}' ,'${FundLineFilter}'
GO
