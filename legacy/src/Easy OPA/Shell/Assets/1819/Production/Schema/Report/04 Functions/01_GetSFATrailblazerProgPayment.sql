IF OBJECT_id('Report.GetSFATrailblazerProgPayment') IS NOT NULL
BEGIN 
	DROP FUNCTION [Report].[GetSFATrailblazerProgPayment]
END
GO

CREATE FUNCTION [Report].[GetSFATrailblazerProgPayment](@learnerTypes VARCHAR(MAX),@completeYear bit)
RETURNS decimal(15,5)
AS
BEGIN
DECLARE @retValue decimal(15,5);

SELECT @retValue = (SELECT SUM(CASE @completeYear WHEN 0 THEN Total6Months
												  WHEN 1 THEN TotalYear 
								END) as ReturnTotal
					FROM
					(SELECT 0 as Total6Months,0 as TotalYear
					UNION ALL
					--SELECT  
					--SUM(LdTfp.AchPayment_ACM1 + LdTfp.AchPayment_ACM2 + LdTfp.AchPayment_ACM3 +
					--LdTfp.AchPayment_ACM4 + LdTfp.AchPayment_ACM5 + LdTfp.AchPayment_ACM6 + CoreGovContPayment_ACM1 + CoreGovContPayment_ACM2 +
					--CoreGovContPayment_ACM3 + CoreGovContPayment_ACM4 + CoreGovContPayment_ACM5 + CoreGovContPayment_ACM6 + MathEngBalPayment_ACM1 +
					--MathEngBalPayment_ACM2 + MathEngBalPayment_ACM3 + MathEngBalPayment_ACM4 + MathEngBalPayment_ACM5 + MathEngBalPayment_ACM6 +
					--MathEngOnProgPayment_ACM1 + MathEngOnProgPayment_ACM2 + MathEngOnProgPayment_ACM3 + MathEngOnProgPayment_ACM4 + MathEngOnProgPayment_ACM5 + MathEngOnProgPayment_ACM6 +
					--SmallBusPayment_ACM1 + SmallBusPayment_ACM2 + SmallBusPayment_ACM3 + SmallBusPayment_ACM4 + SmallBusPayment_ACM5 + SmallBusPayment_ACM6+
					--YoungAppPayment_ACM1 + YoungAppPayment_ACM2 + YoungAppPayment_ACM3 + YoungAppPayment_ACM4 + YoungAppPayment_ACM5 + YoungAppPayment_ACM6 )  as Total6Months,
					--SUM(LdTfp.AchPayment_ACM1 + LdTfp.AchPayment_ACM2 + LdTfp.AchPayment_ACM3 + LdTfp.AchPayment_ACM4 + LdTfp.AchPayment_ACM5 +
					--LdTfp.AchPayment_ACM6 + LdTfp.AchPayment_ACM7 + LdTfp.AchPayment_ACM8 + LdTfp.AchPayment_ACM9 + LdTfp.AchPayment_ACM10 +
					--LdTfp.AchPayment_ACM11 + LdTfp.AchPayment_ACM12 + CoreGovContPayment_ACM1 + CoreGovContPayment_ACM2 + CoreGovContPayment_ACM3 +
					--CoreGovContPayment_ACM4 + CoreGovContPayment_ACM5 + CoreGovContPayment_ACM6 + CoreGovContPayment_ACM7 + CoreGovContPayment_ACM8 + CoreGovContPayment_ACM9 +
					--CoreGovContPayment_ACM10 + CoreGovContPayment_ACM11 + CoreGovContPayment_ACM12 + MathEngBalPayment_ACM1 + MathEngBalPayment_ACM2 +
					--MathEngBalPayment_ACM3 + MathEngBalPayment_ACM4 + MathEngBalPayment_ACM5 + MathEngBalPayment_ACM6 + MathEngBalPayment_ACM7 + MathEngBalPayment_ACM8 +
					--MathEngBalPayment_ACM9 + MathEngBalPayment_ACM10 + MathEngBalPayment_ACM11 + MathEngBalPayment_ACM12 + MathEngOnProgPayment_ACM1 + MathEngOnProgPayment_ACM2 + MathEngOnProgPayment_ACM3 
					--+ MathEngOnProgPayment_ACM4 + MathEngOnProgPayment_ACM5 + MathEngOnProgPayment_ACM6 + MathEngOnProgPayment_ACM7 + MathEngOnProgPayment_ACM8 +
					--MathEngOnProgPayment_ACM9 + MathEngOnProgPayment_ACM10 + MathEngOnProgPayment_ACM11 + MathEngOnProgPayment_ACM12+
					--SmallBusPayment_ACM1 + SmallBusPayment_ACM2 + SmallBusPayment_ACM3 + SmallBusPayment_ACM4 + SmallBusPayment_ACM5 + SmallBusPayment_ACM6 
					--+ SmallBusPayment_ACM7 + SmallBusPayment_ACM8 + SmallBusPayment_ACM9 + SmallBusPayment_ACM10 + SmallBusPayment_ACM11 + SmallBusPayment_ACM12+
					--YoungAppPayment_ACM1 + YoungAppPayment_ACM2 + YoungAppPayment_ACM3 + YoungAppPayment_ACM4 + YoungAppPayment_ACM5 + YoungAppPayment_ACM6 
					--+YoungAppPayment_ACM7 + YoungAppPayment_ACM8 + YoungAppPayment_ACM9 + YoungAppPayment_ACM10 + YoungAppPayment_ACM11 + YoungAppPayment_ACM12) 
					--as TotalYear
					--FROM(SELECT DISTINCT LearnRefNumber,AimSeqNumber FROM  LearningDelivery WHERE FundModel IN (81) AND ProgType = 25)LD 
					--INNER JOIN LearningDelTrailblazerFund LdTf ON LdTf.LearnRefNumber = LD.LearnRefNumber AND LdTf.AimSeqNumber = [LD].AimSeqNumber
					--INNER JOIN LearningDelTrailblazerFundPeriod LdTfp ON LdTfp.LearnRefNumber = LdTf.LearnRefNumber and LdTfp.AimSeqNumber = LdTf.AimSeqNumber
					--WHERE LdTf.FundLine IN (SELECT * FROM ConvertCSVToTable(@learnerTypes))) as ReturnTable)
					SELECT
					SUM(Period_1 + Period_2 + Period_3 + Period_4 + Period_5 + Period_6) AS Total6Months,
					SUM(Period_1 + Period_2 + Period_3 + Period_4 + Period_5 + Period_6 + Period_7 + Period_8 + Period_9 + Period_10 + Period_11 + Period_12) AS TotalYear
					FROM (SELECT DISTINCT LearnRefNumber, AimSeqNumber FROM [Rulebase].[TBL_LearningDelivery] WHERE FundLine IN (SELECT * FROM ConvertCSVToTable(@LearnerTypes))) LD
					INNER JOIN [Rulebase].[TBL_LearningDelivery_PeriodisedValues] LDPV ON LD.LearnRefNumber = LDPV.LearnRefNumber AND LD.AimSeqNumber = LDPV.AimSeqNumber
					WHERE AttributeName IN ('AchPayment', 'CoreGovContPayment', 'MathEngBalPayment', 'MathEngOnProgPayment', 'SmallBusPayment', 'YoungAppPayment'))
					AS ReturnTable)

			return @retvalue;
END
GO 