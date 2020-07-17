 if object_id('dbo.AEC_PrepareForNewData', 'p') is not null begin drop procedure dbo.AEC_PrepareForNewData
end
go
 CREATE PROCEDURE [dbo].[AEC_PrepareForNewData] 
(   
	@pCollectionReturnCode varchar(3)
)
AS 
BEGIN
  DELETE
  FROM ReferenceInput.AppsEarningHistory_ApprenticeshipEarningsHistory
  WHERE [CollectionYear] = '2021'
    AND [CollectionReturnCode]=@pCollectionReturnCode
    AND [UKPRN] in (select distinct UKPRN from Rulebase.AEC_HistoricEarningOutput)
  UPDATE ReferenceInput.AppsEarningHistory_ApprenticeshipEarningsHistory
    SET [LatestInYear]=0 WHERE [LatestInYear]=1
    AND [CollectionYear] = '2021'
	AND [UKPRN] in (select distinct UKPRN from Rulebase.AEC_HistoricEarningOutput)
END 