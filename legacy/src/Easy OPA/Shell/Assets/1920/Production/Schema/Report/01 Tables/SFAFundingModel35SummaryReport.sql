IF OBJECT_ID('[Report].[SFAFundingModel35SummaryReport]') IS NOT NULL
BEGIN
    DROP TABLE [Report].[SFAFundingModel35SummaryReport]
END
GO

CREATE TABLE  [Report].[SFAFundingModel35SummaryReport]([UKPRN]  INT
													   ,[FundingLine]  VARCHAR(100)
													   ,[Period]  INT
													   ,[OnProgPayment]  DECIMAL(38,5)
													   ,[Balancing]  DECIMAL(38,5)
													   ,[JobOutcomeAchievement]  DECIMAL(38,5)
													   ,[AimAchievement]  DECIMAL(38,5)
													   ,[TotalAchievement]  DECIMAL(38,5)
													   ,[LearningSupport]  DECIMAL(38,5)
													   ,[Total]  DECIMAL(38,5)
													   ,[SortOrder] INT
													   )
GO
