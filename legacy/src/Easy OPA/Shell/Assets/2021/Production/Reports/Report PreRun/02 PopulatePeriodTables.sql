-- POPULATE PERIOD TABLES AFTER RULEBASE EXECUTION---
TRUNCATE TABLE [Rulebase].[ALB_LearningDeliveryPeriod]
;WITH SFA_Period_1 AS
(
	SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[Period]
      ,[AchievePayment] AS AchievePayment_ACM1
      ,[AchievePayPct] AS AchievePayPct_ACM1
      ,[AchievePayPctTrans] AS AchievePayPctTrans_ACM1
      ,[BalancePayment] AS BalancePayment_ACM1
      ,[BalancePaymentUncapped] AS BalancePaymentUncapped_ACM1
      ,[BalancePct] AS BalancePct_ACM1
      ,[BalancePctTrans] AS BalancePctTrans_ACM1
      ,[EmpOutcomePay] AS EmpOutcomePay_ACM1
      ,[EmpOutcomePct] AS EmpOutcomePct_ACM1
      ,[EmpOutcomePctTrans] AS EmpOutcomePctTrans_ACM1
      ,[InstPerPeriod] AS InstPerPeriod_ACM1
      ,[LearnSuppFund] AS LearnSuppFund_ACM1
      ,[LearnSuppFundCash] AS LearnSuppFundCash_ACM1
      ,[OnProgPayment] AS OnProgPayment_ACM1
      ,[OnProgPaymentUncapped] AS OnProgPaymentUncapped_ACM1
      ,[OnProgPayPct] AS OnProgPayPct_ACM1
      ,[OnProgPayPctTrans] AS OnProgPayPctTrans_ACM1
      ,[TransInstPerPeriod] AS TransInstPerPeriod_ACM1
  FROM [Rulebase].[SFA_LearningDelivery_Period]
  Where Period = 1 
)
,SFA_Period_2 AS
(
	SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[Period]
      ,[AchievePayment] AS AchievePayment_ACM2
      ,[AchievePayPct] AS AchievePayPct_ACM2
      ,[AchievePayPctTrans] AS AchievePayPctTrans_ACM2
      ,[BalancePayment] AS BalancePayment_ACM2
      ,[BalancePaymentUncapped] AS BalancePaymentUncapped_ACM2
      ,[BalancePct] AS BalancePct_ACM2
      ,[BalancePctTrans] AS BalancePctTrans_ACM2
      ,[EmpOutcomePay] AS EmpOutcomePay_ACM2
      ,[EmpOutcomePct] AS EmpOutcomePct_ACM2
      ,[EmpOutcomePctTrans] AS EmpOutcomePctTrans_ACM2
      ,[InstPerPeriod] AS InstPerPeriod_ACM2
      ,[LearnSuppFund] AS LearnSuppFund_ACM2
      ,[LearnSuppFundCash] AS LearnSuppFundCash_ACM2
      ,[OnProgPayment] AS OnProgPayment_ACM2
      ,[OnProgPaymentUncapped] AS OnProgPaymentUncapped_ACM2
      ,[OnProgPayPct] AS OnProgPayPct_ACM2
      ,[OnProgPayPctTrans] AS OnProgPayPctTrans_ACM2
      ,[TransInstPerPeriod] AS TransInstPerPeriod_ACM2
  FROM [Rulebase].[SFA_LearningDelivery_Period]
  Where Period = 2 
)
,SFA_Period_3 AS
(
	SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[Period]
      ,[AchievePayment] AS AchievePayment_ACM3
      ,[AchievePayPct] AS AchievePayPct_ACM3
      ,[AchievePayPctTrans] AS AchievePayPctTrans_ACM3
      ,[BalancePayment] AS BalancePayment_ACM3
      ,[BalancePaymentUncapped] AS BalancePaymentUncapped_ACM3
      ,[BalancePct] AS BalancePct_ACM3
      ,[BalancePctTrans] AS BalancePctTrans_ACM3
      ,[EmpOutcomePay] AS EmpOutcomePay_ACM3
      ,[EmpOutcomePct] AS EmpOutcomePct_ACM3
      ,[EmpOutcomePctTrans] AS EmpOutcomePctTrans_ACM3
      ,[InstPerPeriod] AS InstPerPeriod_ACM3
      ,[LearnSuppFund] AS LearnSuppFund_ACM3
      ,[LearnSuppFundCash] AS LearnSuppFundCash_ACM3
      ,[OnProgPayment] AS OnProgPayment_ACM3
      ,[OnProgPaymentUncapped] AS OnProgPaymentUncapped_ACM3
      ,[OnProgPayPct] AS OnProgPayPct_ACM3
      ,[OnProgPayPctTrans] AS OnProgPayPctTrans_ACM3
      ,[TransInstPerPeriod] AS TransInstPerPeriod_ACM3
  FROM [Rulebase].[SFA_LearningDelivery_Period]
  Where Period = 3 
)
,SFA_Period_4 AS
(
	SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[Period]
      ,[AchievePayment] AS AchievePayment_ACM4
      ,[AchievePayPct] AS AchievePayPct_ACM4
      ,[AchievePayPctTrans] AS AchievePayPctTrans_ACM4
      ,[BalancePayment] AS BalancePayment_ACM4
      ,[BalancePaymentUncapped] AS BalancePaymentUncapped_ACM4
      ,[BalancePct] AS BalancePct_ACM4
      ,[BalancePctTrans] AS BalancePctTrans_ACM4
      ,[EmpOutcomePay] AS EmpOutcomePay_ACM4
      ,[EmpOutcomePct] AS EmpOutcomePct_ACM4
      ,[EmpOutcomePctTrans] AS EmpOutcomePctTrans_ACM4
      ,[InstPerPeriod] AS InstPerPeriod_ACM4
      ,[LearnSuppFund] AS LearnSuppFund_ACM4
      ,[LearnSuppFundCash] AS LearnSuppFundCash_ACM4
      ,[OnProgPayment] AS OnProgPayment_ACM4
      ,[OnProgPaymentUncapped] AS OnProgPaymentUncapped_ACM4
      ,[OnProgPayPct] AS OnProgPayPct_ACM4
      ,[OnProgPayPctTrans] AS OnProgPayPctTrans_ACM4
      ,[TransInstPerPeriod] AS TransInstPerPeriod_ACM4
  FROM [Rulebase].[SFA_LearningDelivery_Period]
  Where Period = 4 
)
,SFA_Period_5 AS
(
	SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[Period]
      ,[AchievePayment] AS AchievePayment_ACM5
      ,[AchievePayPct] AS AchievePayPct_ACM5
      ,[AchievePayPctTrans] AS AchievePayPctTrans_ACM5
      ,[BalancePayment] AS BalancePayment_ACM5
      ,[BalancePaymentUncapped] AS BalancePaymentUncapped_ACM5
      ,[BalancePct] AS BalancePct_ACM5
      ,[BalancePctTrans] AS BalancePctTrans_ACM5
      ,[EmpOutcomePay] AS EmpOutcomePay_ACM5
      ,[EmpOutcomePct] AS EmpOutcomePct_ACM5
      ,[EmpOutcomePctTrans] AS EmpOutcomePctTrans_ACM5
      ,[InstPerPeriod] AS InstPerPeriod_ACM5
      ,[LearnSuppFund] AS LearnSuppFund_ACM5
      ,[LearnSuppFundCash] AS LearnSuppFundCash_ACM5
      ,[OnProgPayment] AS OnProgPayment_ACM5
      ,[OnProgPaymentUncapped] AS OnProgPaymentUncapped_ACM5
      ,[OnProgPayPct] AS OnProgPayPct_ACM5
      ,[OnProgPayPctTrans] AS OnProgPayPctTrans_ACM5
      ,[TransInstPerPeriod] AS TransInstPerPeriod_ACM5
  FROM [Rulebase].[SFA_LearningDelivery_Period]
  Where Period = 5 
)
,SFA_Period_6 AS
(
	SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[Period]
      ,[AchievePayment] AS AchievePayment_ACM6
      ,[AchievePayPct] AS AchievePayPct_ACM6
      ,[AchievePayPctTrans] AS AchievePayPctTrans_ACM6
      ,[BalancePayment] AS BalancePayment_ACM6
      ,[BalancePaymentUncapped] AS BalancePaymentUncapped_ACM6
      ,[BalancePct] AS BalancePct_ACM6
      ,[BalancePctTrans] AS BalancePctTrans_ACM6
      ,[EmpOutcomePay] AS EmpOutcomePay_ACM6
      ,[EmpOutcomePct] AS EmpOutcomePct_ACM6
      ,[EmpOutcomePctTrans] AS EmpOutcomePctTrans_ACM6
      ,[InstPerPeriod] AS InstPerPeriod_ACM6
      ,[LearnSuppFund] AS LearnSuppFund_ACM6
      ,[LearnSuppFundCash] AS LearnSuppFundCash_ACM6
      ,[OnProgPayment] AS OnProgPayment_ACM6
      ,[OnProgPaymentUncapped] AS OnProgPaymentUncapped_ACM6
      ,[OnProgPayPct] AS OnProgPayPct_ACM6
      ,[OnProgPayPctTrans] AS OnProgPayPctTrans_ACM6
      ,[TransInstPerPeriod] AS TransInstPerPeriod_ACM6
  FROM [Rulebase].[SFA_LearningDelivery_Period]
  Where Period = 6 
)
,SFA_Period_7 AS
(
	SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[Period]
      ,[AchievePayment] AS AchievePayment_ACM7
      ,[AchievePayPct] AS AchievePayPct_ACM7
      ,[AchievePayPctTrans] AS AchievePayPctTrans_ACM7
      ,[BalancePayment] AS BalancePayment_ACM7
      ,[BalancePaymentUncapped] AS BalancePaymentUncapped_ACM7
      ,[BalancePct] AS BalancePct_ACM7
      ,[BalancePctTrans] AS BalancePctTrans_ACM7
      ,[EmpOutcomePay] AS EmpOutcomePay_ACM7
      ,[EmpOutcomePct] AS EmpOutcomePct_ACM7
      ,[EmpOutcomePctTrans] AS EmpOutcomePctTrans_ACM7
      ,[InstPerPeriod] AS InstPerPeriod_ACM7
      ,[LearnSuppFund] AS LearnSuppFund_ACM7
      ,[LearnSuppFundCash] AS LearnSuppFundCash_ACM7
      ,[OnProgPayment] AS OnProgPayment_ACM7
      ,[OnProgPaymentUncapped] AS OnProgPaymentUncapped_ACM7
      ,[OnProgPayPct] AS OnProgPayPct_ACM7
      ,[OnProgPayPctTrans] AS OnProgPayPctTrans_ACM7
      ,[TransInstPerPeriod] AS TransInstPerPeriod_ACM7
  FROM [Rulebase].[SFA_LearningDelivery_Period]
  Where Period = 7 
)
,SFA_Period_8 AS
(
	SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[Period]
      ,[AchievePayment] AS AchievePayment_ACM8
      ,[AchievePayPct] AS AchievePayPct_ACM8
      ,[AchievePayPctTrans] AS AchievePayPctTrans_ACM8
      ,[BalancePayment] AS BalancePayment_ACM8
      ,[BalancePaymentUncapped] AS BalancePaymentUncapped_ACM8
      ,[BalancePct] AS BalancePct_ACM8
      ,[BalancePctTrans] AS BalancePctTrans_ACM8
      ,[EmpOutcomePay] AS EmpOutcomePay_ACM8
      ,[EmpOutcomePct] AS EmpOutcomePct_ACM8
      ,[EmpOutcomePctTrans] AS EmpOutcomePctTrans_ACM8
      ,[InstPerPeriod] AS InstPerPeriod_ACM8
      ,[LearnSuppFund] AS LearnSuppFund_ACM8
      ,[LearnSuppFundCash] AS LearnSuppFundCash_ACM8
      ,[OnProgPayment] AS OnProgPayment_ACM8
      ,[OnProgPaymentUncapped] AS OnProgPaymentUncapped_ACM8
      ,[OnProgPayPct] AS OnProgPayPct_ACM8
      ,[OnProgPayPctTrans] AS OnProgPayPctTrans_ACM8
      ,[TransInstPerPeriod] AS TransInstPerPeriod_ACM8
  FROM [Rulebase].[SFA_LearningDelivery_Period]
  Where Period = 8 
)
,SFA_Period_9 AS
(
	SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[Period]
      ,[AchievePayment] AS AchievePayment_ACM9
      ,[AchievePayPct] AS AchievePayPct_ACM9
      ,[AchievePayPctTrans] AS AchievePayPctTrans_ACM9
      ,[BalancePayment] AS BalancePayment_ACM9
      ,[BalancePaymentUncapped] AS BalancePaymentUncapped_ACM9
      ,[BalancePct] AS BalancePct_ACM9
      ,[BalancePctTrans] AS BalancePctTrans_ACM9
      ,[EmpOutcomePay] AS EmpOutcomePay_ACM9
      ,[EmpOutcomePct] AS EmpOutcomePct_ACM9
      ,[EmpOutcomePctTrans] AS EmpOutcomePctTrans_ACM9
      ,[InstPerPeriod] AS InstPerPeriod_ACM9
      ,[LearnSuppFund] AS LearnSuppFund_ACM9
      ,[LearnSuppFundCash] AS LearnSuppFundCash_ACM9
      ,[OnProgPayment] AS OnProgPayment_ACM9
      ,[OnProgPaymentUncapped] AS OnProgPaymentUncapped_ACM9
      ,[OnProgPayPct] AS OnProgPayPct_ACM9
      ,[OnProgPayPctTrans] AS OnProgPayPctTrans_ACM9
      ,[TransInstPerPeriod] AS TransInstPerPeriod_ACM9
  FROM [Rulebase].[SFA_LearningDelivery_Period]
  Where Period = 9 
)
,SFA_Period_10 AS
(
	SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[Period]
      ,[AchievePayment] AS AchievePayment_ACM10
      ,[AchievePayPct] AS AchievePayPct_ACM10
      ,[AchievePayPctTrans] AS AchievePayPctTrans_ACM10
      ,[BalancePayment] AS BalancePayment_ACM10
      ,[BalancePaymentUncapped] AS BalancePaymentUncapped_ACM10
      ,[BalancePct] AS BalancePct_ACM10
      ,[BalancePctTrans] AS BalancePctTrans_ACM10
      ,[EmpOutcomePay] AS EmpOutcomePay_ACM10
      ,[EmpOutcomePct] AS EmpOutcomePct_ACM10
      ,[EmpOutcomePctTrans] AS EmpOutcomePctTrans_ACM10
      ,[InstPerPeriod] AS InstPerPeriod_ACM10
      ,[LearnSuppFund] AS LearnSuppFund_ACM10
      ,[LearnSuppFundCash] AS LearnSuppFundCash_ACM10
      ,[OnProgPayment] AS OnProgPayment_ACM10
      ,[OnProgPaymentUncapped] AS OnProgPaymentUncapped_ACM10
      ,[OnProgPayPct] AS OnProgPayPct_ACM10
      ,[OnProgPayPctTrans] AS OnProgPayPctTrans_ACM10
      ,[TransInstPerPeriod] AS TransInstPerPeriod_ACM10
  FROM [Rulebase].[SFA_LearningDelivery_Period]
  Where Period = 10 
)
,SFA_Period_11 AS
(
	SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[Period]
      ,[AchievePayment] AS AchievePayment_ACM11
      ,[AchievePayPct] AS AchievePayPct_ACM11
      ,[AchievePayPctTrans] AS AchievePayPctTrans_ACM11
      ,[BalancePayment] AS BalancePayment_ACM11
      ,[BalancePaymentUncapped] AS BalancePaymentUncapped_ACM11
      ,[BalancePct] AS BalancePct_ACM11
      ,[BalancePctTrans] AS BalancePctTrans_ACM11
      ,[EmpOutcomePay] AS EmpOutcomePay_ACM11
      ,[EmpOutcomePct] AS EmpOutcomePct_ACM11
      ,[EmpOutcomePctTrans] AS EmpOutcomePctTrans_ACM11
      ,[InstPerPeriod] AS InstPerPeriod_ACM11
      ,[LearnSuppFund] AS LearnSuppFund_ACM11
      ,[LearnSuppFundCash] AS LearnSuppFundCash_ACM11
      ,[OnProgPayment] AS OnProgPayment_ACM11
      ,[OnProgPaymentUncapped] AS OnProgPaymentUncapped_ACM11
      ,[OnProgPayPct] AS OnProgPayPct_ACM11
      ,[OnProgPayPctTrans] AS OnProgPayPctTrans_ACM11
      ,[TransInstPerPeriod] AS TransInstPerPeriod_ACM11
  FROM [Rulebase].[SFA_LearningDelivery_Period]
  Where Period = 11 
)
,SFA_Period_12 AS
(
	SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[Period]
      ,[AchievePayment] AS AchievePayment_ACM12
      ,[AchievePayPct] AS AchievePayPct_ACM12
      ,[AchievePayPctTrans] AS AchievePayPctTrans_ACM12
      ,[BalancePayment] AS BalancePayment_ACM12
      ,[BalancePaymentUncapped] AS BalancePaymentUncapped_ACM12
      ,[BalancePct] AS BalancePct_ACM12
      ,[BalancePctTrans] AS BalancePctTrans_ACM12
      ,[EmpOutcomePay] AS EmpOutcomePay_ACM12
      ,[EmpOutcomePct] AS EmpOutcomePct_ACM12
      ,[EmpOutcomePctTrans] AS EmpOutcomePctTrans_ACM12
      ,[InstPerPeriod] AS InstPerPeriod_ACM12
      ,[LearnSuppFund] AS LearnSuppFund_ACM12
      ,[LearnSuppFundCash] AS LearnSuppFundCash_ACM12
      ,[OnProgPayment] AS OnProgPayment_ACM12
      ,[OnProgPaymentUncapped] AS OnProgPaymentUncapped_ACM12
      ,[OnProgPayPct] AS OnProgPayPct_ACM12
      ,[OnProgPayPctTrans] AS OnProgPayPctTrans_ACM12
      ,[TransInstPerPeriod] AS TransInstPerPeriod_ACM12
  FROM [Rulebase].[SFA_LearningDelivery_Period]
  Where Period = 12 
)
INSERT INTO Rulebase.SFA_LearningDeliveryPeriod
(
	   [LearnRefNumber]
      ,[AimSeqNumber]
     ,AchievePayment_ACM1
      ,AchievePayPct_ACM1
      ,AchievePayPctTrans_ACM1
      ,BalancePayment_ACM1
      ,BalancePaymentUncapped_ACM1
      ,BalancePct_ACM1
      ,BalancePctTrans_ACM1
      ,EmpOutcomePay_ACM1
      ,EmpOutcomePct_ACM1
      ,EmpOutcomePctTrans_ACM1
      ,InstPerPeriod_ACM1
      ,LearnSuppFund_ACM1
      ,LearnSuppFundCash_ACM1
      ,OnProgPayment_ACM1
      ,OnProgPaymentUncapped_ACM1
      ,OnProgPayPct_ACM1
      ,OnProgPayPctTrans_ACM1
      ,TransInstPerPeriod_ACM1
	  ,AchievePayment_ACM2
      ,AchievePayPct_ACM2
      ,AchievePayPctTrans_ACM2
      ,BalancePayment_ACM2
      ,BalancePaymentUncapped_ACM2
      ,BalancePct_ACM2
      ,BalancePctTrans_ACM2
      ,EmpOutcomePay_ACM2
      ,EmpOutcomePct_ACM2
      ,EmpOutcomePctTrans_ACM2
      ,InstPerPeriod_ACM2
      ,LearnSuppFund_ACM2
      ,LearnSuppFundCash_ACM2
      ,OnProgPayment_ACM2
      ,OnProgPaymentUncapped_ACM2
      ,OnProgPayPct_ACM2
      ,OnProgPayPctTrans_ACM2
      ,TransInstPerPeriod_ACM2
      ,AchievePayment_ACM3
      ,AchievePayPct_ACM3
      ,AchievePayPctTrans_ACM3
      ,BalancePayment_ACM3
      ,BalancePaymentUncapped_ACM3
      ,BalancePct_ACM3
      ,BalancePctTrans_ACM3
      ,EmpOutcomePay_ACM3
      ,EmpOutcomePct_ACM3
      ,EmpOutcomePctTrans_ACM3
      ,InstPerPeriod_ACM3
      ,LearnSuppFund_ACM3
      ,LearnSuppFundCash_ACM3
      ,OnProgPayment_ACM3
      ,OnProgPaymentUncapped_ACM3
      ,OnProgPayPct_ACM3
      ,OnProgPayPctTrans_ACM3
      ,TransInstPerPeriod_ACM3
      ,AchievePayment_ACM4
      ,AchievePayPct_ACM4
      ,AchievePayPctTrans_ACM4
      ,BalancePayment_ACM4
      ,BalancePaymentUncapped_ACM4
      ,BalancePct_ACM4
      ,BalancePctTrans_ACM4
      ,EmpOutcomePay_ACM4
      ,EmpOutcomePct_ACM4
      ,EmpOutcomePctTrans_ACM4
      ,InstPerPeriod_ACM4
      ,LearnSuppFund_ACM4
      ,LearnSuppFundCash_ACM4
      ,OnProgPayment_ACM4
      ,OnProgPaymentUncapped_ACM4
      ,OnProgPayPct_ACM4
      ,OnProgPayPctTrans_ACM4
      ,TransInstPerPeriod_ACM4
      ,AchievePayment_ACM5
      ,AchievePayPct_ACM5
      ,AchievePayPctTrans_ACM5
      ,BalancePayment_ACM5
      ,BalancePaymentUncapped_ACM5
      ,BalancePct_ACM5
      ,BalancePctTrans_ACM5
      ,EmpOutcomePay_ACM5
      ,EmpOutcomePct_ACM5
      ,EmpOutcomePctTrans_ACM5
      ,InstPerPeriod_ACM5
      ,LearnSuppFund_ACM5
      ,LearnSuppFundCash_ACM5
      ,OnProgPayment_ACM5
      ,OnProgPaymentUncapped_ACM5
      ,OnProgPayPct_ACM5
      ,OnProgPayPctTrans_ACM5
      ,TransInstPerPeriod_ACM5
      ,AchievePayment_ACM6
      ,AchievePayPct_ACM6
      ,AchievePayPctTrans_ACM6
      ,BalancePayment_ACM6
      ,BalancePaymentUncapped_ACM6
      ,BalancePct_ACM6
      ,BalancePctTrans_ACM6
      ,EmpOutcomePay_ACM6
      ,EmpOutcomePct_ACM6
      ,EmpOutcomePctTrans_ACM6
      ,InstPerPeriod_ACM6
      ,LearnSuppFund_ACM6
      ,LearnSuppFundCash_ACM6
      ,OnProgPayment_ACM6
      ,OnProgPaymentUncapped_ACM6
      ,OnProgPayPct_ACM6
      ,OnProgPayPctTrans_ACM6
      ,TransInstPerPeriod_ACM6
      ,AchievePayment_ACM7
      ,AchievePayPct_ACM7
      ,AchievePayPctTrans_ACM7
      ,BalancePayment_ACM7
      ,BalancePaymentUncapped_ACM7
      ,BalancePct_ACM7
      ,BalancePctTrans_ACM7
      ,EmpOutcomePay_ACM7
      ,EmpOutcomePct_ACM7
      ,EmpOutcomePctTrans_ACM7
      ,InstPerPeriod_ACM7
      ,LearnSuppFund_ACM7
      ,LearnSuppFundCash_ACM7
      ,OnProgPayment_ACM7
      ,OnProgPaymentUncapped_ACM7
      ,OnProgPayPct_ACM7
      ,OnProgPayPctTrans_ACM7
      ,TransInstPerPeriod_ACM7
      ,AchievePayment_ACM8
      ,AchievePayPct_ACM8
      ,AchievePayPctTrans_ACM8
      ,BalancePayment_ACM8
      ,BalancePaymentUncapped_ACM8
      ,BalancePct_ACM8
      ,BalancePctTrans_ACM8
      ,EmpOutcomePay_ACM8
      ,EmpOutcomePct_ACM8
      ,EmpOutcomePctTrans_ACM8
      ,InstPerPeriod_ACM8
      ,LearnSuppFund_ACM8
      ,LearnSuppFundCash_ACM8
      ,OnProgPayment_ACM8
      ,OnProgPaymentUncapped_ACM8
      ,OnProgPayPct_ACM8
      ,OnProgPayPctTrans_ACM8
      ,TransInstPerPeriod_ACM8
      ,AchievePayment_ACM9
      ,AchievePayPct_ACM9
      ,AchievePayPctTrans_ACM9
      ,BalancePayment_ACM9
      ,BalancePaymentUncapped_ACM9
      ,BalancePct_ACM9
      ,BalancePctTrans_ACM9
      ,EmpOutcomePay_ACM9
      ,EmpOutcomePct_ACM9
      ,EmpOutcomePctTrans_ACM9
      ,InstPerPeriod_ACM9
      ,LearnSuppFund_ACM9
      ,LearnSuppFundCash_ACM9
      ,OnProgPayment_ACM9
      ,OnProgPaymentUncapped_ACM9
      ,OnProgPayPct_ACM9
      ,OnProgPayPctTrans_ACM9
      ,TransInstPerPeriod_ACM9
      ,AchievePayment_ACM10
      ,AchievePayPct_ACM10
      ,AchievePayPctTrans_ACM10
      ,BalancePayment_ACM10
      ,BalancePaymentUncapped_ACM10
      ,BalancePct_ACM10
      ,BalancePctTrans_ACM10
      ,EmpOutcomePay_ACM10
      ,EmpOutcomePct_ACM10
      ,EmpOutcomePctTrans_ACM10
      ,InstPerPeriod_ACM10
      ,LearnSuppFund_ACM10
      ,LearnSuppFundCash_ACM10
      ,OnProgPayment_ACM10
      ,OnProgPaymentUncapped_ACM10
      ,OnProgPayPct_ACM10
      ,OnProgPayPctTrans_ACM10
      ,TransInstPerPeriod_ACM10
      ,AchievePayment_ACM11
      ,AchievePayPct_ACM11
      ,AchievePayPctTrans_ACM11
      ,BalancePayment_ACM11
      ,BalancePaymentUncapped_ACM11
      ,BalancePct_ACM11
      ,BalancePctTrans_ACM11
      ,EmpOutcomePay_ACM11
      ,EmpOutcomePct_ACM11
      ,EmpOutcomePctTrans_ACM11
      ,InstPerPeriod_ACM11
      ,LearnSuppFund_ACM11
      ,LearnSuppFundCash_ACM11
      ,OnProgPayment_ACM11
      ,OnProgPaymentUncapped_ACM11
      ,OnProgPayPct_ACM11
      ,OnProgPayPctTrans_ACM11
      ,TransInstPerPeriod_ACM11
      ,AchievePayment_ACM12
      ,AchievePayPct_ACM12
      ,AchievePayPctTrans_ACM12
      ,BalancePayment_ACM12
      ,BalancePaymentUncapped_ACM12
      ,BalancePct_ACM12
      ,BalancePctTrans_ACM12
      ,EmpOutcomePay_ACM12
      ,EmpOutcomePct_ACM12
      ,EmpOutcomePctTrans_ACM12
      ,InstPerPeriod_ACM12
      ,LearnSuppFund_ACM12
      ,LearnSuppFundCash_ACM12
      ,OnProgPayment_ACM12
      ,OnProgPaymentUncapped_ACM12
      ,OnProgPayPct_ACM12
      ,OnProgPayPctTrans_ACM12
      ,TransInstPerPeriod_ACM12
	   ,AchievePayment_EFY
      ,AchievePayPct_EFY
      ,AchievePayPctTrans_EFY
      ,BalancePayment_EFY
      ,BalancePaymentUncapped_EFY
      ,BalancePct_EFY
      ,BalancePctTrans_EFY
      ,EmpOutcomePay_EFY
      ,EmpOutcomePct_EFY
      ,EmpOutcomePctTrans_EFY
      ,InstPerPeriod_EFY
      ,LearnSuppFund_EFY
      ,LearnSuppFundCash_EFY
      ,OnProgPayment_EFY
      ,OnProgPaymentUncapped_EFY
      ,OnProgPayPct_EFY
      ,OnProgPayPctTrans_EFY
      ,TransInstPerPeriod_EFY
)
SELECT SFA_Period_1.[LearnRefNumber]
      ,SFA_Period_1.[AimSeqNumber]
     ,AchievePayment_ACM1
      ,AchievePayPct_ACM1
      ,AchievePayPctTrans_ACM1
      ,BalancePayment_ACM1
      ,BalancePaymentUncapped_ACM1
      ,BalancePct_ACM1
      ,BalancePctTrans_ACM1
      ,EmpOutcomePay_ACM1
      ,EmpOutcomePct_ACM1
      ,EmpOutcomePctTrans_ACM1
      ,InstPerPeriod_ACM1
      ,LearnSuppFund_ACM1
      ,LearnSuppFundCash_ACM1
      ,OnProgPayment_ACM1
      ,OnProgPaymentUncapped_ACM1
      ,OnProgPayPct_ACM1
      ,OnProgPayPctTrans_ACM1
      ,TransInstPerPeriod_ACM1
	  ,AchievePayment_ACM2
      ,AchievePayPct_ACM2
      ,AchievePayPctTrans_ACM2
      ,BalancePayment_ACM2
      ,BalancePaymentUncapped_ACM2
      ,BalancePct_ACM2
      ,BalancePctTrans_ACM2
      ,EmpOutcomePay_ACM2
      ,EmpOutcomePct_ACM2
      ,EmpOutcomePctTrans_ACM2
      ,InstPerPeriod_ACM2
      ,LearnSuppFund_ACM2
      ,LearnSuppFundCash_ACM2
      ,OnProgPayment_ACM2
      ,OnProgPaymentUncapped_ACM2
      ,OnProgPayPct_ACM2
      ,OnProgPayPctTrans_ACM2
      ,TransInstPerPeriod_ACM2
      ,AchievePayment_ACM3
      ,AchievePayPct_ACM3
      ,AchievePayPctTrans_ACM3
      ,BalancePayment_ACM3
      ,BalancePaymentUncapped_ACM3
      ,BalancePct_ACM3
      ,BalancePctTrans_ACM3
      ,EmpOutcomePay_ACM3
      ,EmpOutcomePct_ACM3
      ,EmpOutcomePctTrans_ACM3
      ,InstPerPeriod_ACM3
      ,LearnSuppFund_ACM3
      ,LearnSuppFundCash_ACM3
      ,OnProgPayment_ACM3
      ,OnProgPaymentUncapped_ACM3
      ,OnProgPayPct_ACM3
      ,OnProgPayPctTrans_ACM3
      ,TransInstPerPeriod_ACM3
      ,AchievePayment_ACM4
      ,AchievePayPct_ACM4
      ,AchievePayPctTrans_ACM4
      ,BalancePayment_ACM4
      ,BalancePaymentUncapped_ACM4
      ,BalancePct_ACM4
      ,BalancePctTrans_ACM4
      ,EmpOutcomePay_ACM4
      ,EmpOutcomePct_ACM4
      ,EmpOutcomePctTrans_ACM4
      ,InstPerPeriod_ACM4
      ,LearnSuppFund_ACM4
      ,LearnSuppFundCash_ACM4
      ,OnProgPayment_ACM4
      ,OnProgPaymentUncapped_ACM4
      ,OnProgPayPct_ACM4
      ,OnProgPayPctTrans_ACM4
      ,TransInstPerPeriod_ACM4
      ,AchievePayment_ACM5
      ,AchievePayPct_ACM5
      ,AchievePayPctTrans_ACM5
      ,BalancePayment_ACM5
      ,BalancePaymentUncapped_ACM5
      ,BalancePct_ACM5
      ,BalancePctTrans_ACM5
      ,EmpOutcomePay_ACM5
      ,EmpOutcomePct_ACM5
      ,EmpOutcomePctTrans_ACM5
      ,InstPerPeriod_ACM5
      ,LearnSuppFund_ACM5
      ,LearnSuppFundCash_ACM5
      ,OnProgPayment_ACM5
      ,OnProgPaymentUncapped_ACM5
      ,OnProgPayPct_ACM5
      ,OnProgPayPctTrans_ACM5
      ,TransInstPerPeriod_ACM5
      ,AchievePayment_ACM6
      ,AchievePayPct_ACM6
      ,AchievePayPctTrans_ACM6
      ,BalancePayment_ACM6
      ,BalancePaymentUncapped_ACM6
      ,BalancePct_ACM6
      ,BalancePctTrans_ACM6
      ,EmpOutcomePay_ACM6
      ,EmpOutcomePct_ACM6
      ,EmpOutcomePctTrans_ACM6
      ,InstPerPeriod_ACM6
      ,LearnSuppFund_ACM6
      ,LearnSuppFundCash_ACM6
      ,OnProgPayment_ACM6
      ,OnProgPaymentUncapped_ACM6
      ,OnProgPayPct_ACM6
      ,OnProgPayPctTrans_ACM6
      ,TransInstPerPeriod_ACM6
      ,AchievePayment_ACM7
      ,AchievePayPct_ACM7
      ,AchievePayPctTrans_ACM7
      ,BalancePayment_ACM7
      ,BalancePaymentUncapped_ACM7
      ,BalancePct_ACM7
      ,BalancePctTrans_ACM7
      ,EmpOutcomePay_ACM7
      ,EmpOutcomePct_ACM7
      ,EmpOutcomePctTrans_ACM7
      ,InstPerPeriod_ACM7
      ,LearnSuppFund_ACM7
      ,LearnSuppFundCash_ACM7
      ,OnProgPayment_ACM7
      ,OnProgPaymentUncapped_ACM7
      ,OnProgPayPct_ACM7
      ,OnProgPayPctTrans_ACM7
      ,TransInstPerPeriod_ACM7
      ,AchievePayment_ACM8
      ,AchievePayPct_ACM8
      ,AchievePayPctTrans_ACM8
      ,BalancePayment_ACM8
      ,BalancePaymentUncapped_ACM8
      ,BalancePct_ACM8
      ,BalancePctTrans_ACM8
      ,EmpOutcomePay_ACM8
      ,EmpOutcomePct_ACM8
      ,EmpOutcomePctTrans_ACM8
      ,InstPerPeriod_ACM8
      ,LearnSuppFund_ACM8
      ,LearnSuppFundCash_ACM8
      ,OnProgPayment_ACM8
      ,OnProgPaymentUncapped_ACM8
      ,OnProgPayPct_ACM8
      ,OnProgPayPctTrans_ACM8
      ,TransInstPerPeriod_ACM8
      ,AchievePayment_ACM9
      ,AchievePayPct_ACM9
      ,AchievePayPctTrans_ACM9
      ,BalancePayment_ACM9
      ,BalancePaymentUncapped_ACM9
      ,BalancePct_ACM9
      ,BalancePctTrans_ACM9
      ,EmpOutcomePay_ACM9
      ,EmpOutcomePct_ACM9
      ,EmpOutcomePctTrans_ACM9
      ,InstPerPeriod_ACM9
      ,LearnSuppFund_ACM9
      ,LearnSuppFundCash_ACM9
      ,OnProgPayment_ACM9
      ,OnProgPaymentUncapped_ACM9
      ,OnProgPayPct_ACM9
      ,OnProgPayPctTrans_ACM9
      ,TransInstPerPeriod_ACM9
      ,AchievePayment_ACM10
      ,AchievePayPct_ACM10
      ,AchievePayPctTrans_ACM10
      ,BalancePayment_ACM10
      ,BalancePaymentUncapped_ACM10
      ,BalancePct_ACM10
      ,BalancePctTrans_ACM10
      ,EmpOutcomePay_ACM10
      ,EmpOutcomePct_ACM10
      ,EmpOutcomePctTrans_ACM10
      ,InstPerPeriod_ACM10
      ,LearnSuppFund_ACM10
      ,LearnSuppFundCash_ACM10
      ,OnProgPayment_ACM10
      ,OnProgPaymentUncapped_ACM10
      ,OnProgPayPct_ACM10
      ,OnProgPayPctTrans_ACM10
      ,TransInstPerPeriod_ACM10
      ,AchievePayment_ACM11
      ,AchievePayPct_ACM11
      ,AchievePayPctTrans_ACM11
      ,BalancePayment_ACM11
      ,BalancePaymentUncapped_ACM11
      ,BalancePct_ACM11
      ,BalancePctTrans_ACM11
      ,EmpOutcomePay_ACM11
      ,EmpOutcomePct_ACM11
      ,EmpOutcomePctTrans_ACM11
      ,InstPerPeriod_ACM11
      ,LearnSuppFund_ACM11
      ,LearnSuppFundCash_ACM11
      ,OnProgPayment_ACM11
      ,OnProgPaymentUncapped_ACM11
      ,OnProgPayPct_ACM11
      ,OnProgPayPctTrans_ACM11
      ,TransInstPerPeriod_ACM11
      ,AchievePayment_ACM12
      ,AchievePayPct_ACM12
      ,AchievePayPctTrans_ACM12
      ,BalancePayment_ACM12
      ,BalancePaymentUncapped_ACM12
      ,BalancePct_ACM12
      ,BalancePctTrans_ACM12
      ,EmpOutcomePay_ACM12
      ,EmpOutcomePct_ACM12
      ,EmpOutcomePctTrans_ACM12
      ,InstPerPeriod_ACM12
      ,LearnSuppFund_ACM12
      ,LearnSuppFundCash_ACM12
      ,OnProgPayment_ACM12
      ,OnProgPaymentUncapped_ACM12
      ,OnProgPayPct_ACM12
      ,OnProgPayPctTrans_ACM12
      ,TransInstPerPeriod_ACM12
	  ,(AchievePayment_ACM1+AchievePayment_ACM2+AchievePayment_ACM3+AchievePayment_ACM4+AchievePayment_ACM5+AchievePayment_ACM6+AchievePayment_ACM7+AchievePayment_ACM8+AchievePayment_ACM9+AchievePayment_ACM10+AchievePayment_ACM11+AchievePayment_ACM12) AS AchievePayment_EFY
      ,(AchievePayPct_ACM12+AchievePayPct_ACM2+AchievePayPct_ACM3+AchievePayPct_ACM4+AchievePayPct_ACM5+AchievePayPct_ACM6+AchievePayPct_ACM7+AchievePayPct_ACM8+AchievePayPct_ACM9+AchievePayPct_ACM10+AchievePayPct_ACM11+AchievePayPct_ACM12) as AchievePayPct_EFY
      ,(AchievePayPctTrans_ACM1+AchievePayPctTrans_ACM2+AchievePayPctTrans_ACM3+AchievePayPctTrans_ACM4+AchievePayPctTrans_ACM5+AchievePayPctTrans_ACM6+AchievePayPctTrans_ACM7+AchievePayPctTrans_ACM8+AchievePayPctTrans_ACM9+AchievePayPctTrans_ACM10+AchievePayPctTrans_ACM11+AchievePayPctTrans_ACM12) as AchievePayPctTrans_EFY
      ,(BalancePayment_ACM1+BalancePayment_ACM2+BalancePayment_ACM3+BalancePayment_ACM4+BalancePayment_ACM5+BalancePayment_ACM6+BalancePayment_ACM7+BalancePayment_ACM8+BalancePayment_ACM9+BalancePayment_ACM10+BalancePayment_ACM11+BalancePayment_ACM12) as BalancePayment_EFY
      ,(BalancePaymentUncapped_ACM1+BalancePaymentUncapped_ACM2+BalancePaymentUncapped_ACM3+BalancePaymentUncapped_ACM4+BalancePaymentUncapped_ACM5+BalancePaymentUncapped_ACM6+BalancePaymentUncapped_ACM7+BalancePaymentUncapped_ACM8+BalancePaymentUncapped_ACM9+BalancePaymentUncapped_ACM10+BalancePaymentUncapped_ACM11+BalancePaymentUncapped_ACM12) as BalancePaymentUncapped_EFY
      ,(BalancePct_ACM1+BalancePct_ACM2+BalancePct_ACM3+BalancePct_ACM4+BalancePct_ACM5+BalancePct_ACM6+BalancePct_ACM7+BalancePct_ACM8+BalancePct_ACM9+BalancePct_ACM10+BalancePct_ACM11+BalancePct_ACM12) as BalancePct_EFY
      ,(BalancePctTrans_ACM1+BalancePctTrans_ACM2+BalancePctTrans_ACM3+BalancePctTrans_ACM4+BalancePctTrans_ACM5+BalancePctTrans_ACM6+BalancePctTrans_ACM7+BalancePctTrans_ACM8+BalancePctTrans_ACM9+BalancePctTrans_ACM10+BalancePctTrans_ACM11+BalancePctTrans_ACM12) AS BalancePctTrans_EFY
      ,(EmpOutcomePay_ACM1+EmpOutcomePay_ACM2+EmpOutcomePay_ACM3+EmpOutcomePay_ACM4+EmpOutcomePay_ACM5+EmpOutcomePay_ACM6+EmpOutcomePay_ACM7+EmpOutcomePay_ACM8+EmpOutcomePay_ACM9+EmpOutcomePay_ACM10+EmpOutcomePay_ACM11+EmpOutcomePay_ACM12) AS EmpOutcomePay_EFY
      ,(EmpOutcomePct_ACM1+EmpOutcomePct_ACM2+EmpOutcomePct_ACM3+EmpOutcomePct_ACM4+EmpOutcomePct_ACM5+EmpOutcomePct_ACM6+EmpOutcomePct_ACM7+EmpOutcomePct_ACM8+EmpOutcomePct_ACM9+EmpOutcomePct_ACM10+EmpOutcomePct_ACM11+EmpOutcomePct_ACM12) AS EmpOutcomePct_EFY
      ,(EmpOutcomePctTrans_ACM1+EmpOutcomePctTrans_ACM2+EmpOutcomePctTrans_ACM3+EmpOutcomePctTrans_ACM4+EmpOutcomePctTrans_ACM5+EmpOutcomePctTrans_ACM6+EmpOutcomePctTrans_ACM7+EmpOutcomePctTrans_ACM8+EmpOutcomePctTrans_ACM9+EmpOutcomePctTrans_ACM10+EmpOutcomePctTrans_ACM11+EmpOutcomePctTrans_ACM12) AS EmpOutcomePctTrans_EFY
      ,(InstPerPeriod_ACM1+InstPerPeriod_ACM2+InstPerPeriod_ACM3+InstPerPeriod_ACM4+InstPerPeriod_ACM5+InstPerPeriod_ACM6+InstPerPeriod_ACM7+InstPerPeriod_ACM8+InstPerPeriod_ACM9+InstPerPeriod_ACM10+InstPerPeriod_ACM11+InstPerPeriod_ACM12) AS InstPerPeriod_EFY
      --,--(LearnSuppFund_ACM1+LearnSuppFund_ACM2+LearnSuppFund_ACM3+LearnSuppFund_ACM4+LearnSuppFund_ACM5+LearnSuppFund_ACM6+LearnSuppFund_ACM7+LearnSuppFund_ACM8+LearnSuppFund_ACM9+LearnSuppFund_ACM10+LearnSuppFund_ACM11+LearnSuppFund_ACM12) 
	  ,0 AS LearnSuppFund_EFY
      ,(LearnSuppFundCash_ACM1+LearnSuppFundCash_ACM2+LearnSuppFundCash_ACM3+LearnSuppFundCash_ACM4+LearnSuppFundCash_ACM5+LearnSuppFundCash_ACM6+LearnSuppFundCash_ACM7+LearnSuppFundCash_ACM8+LearnSuppFundCash_ACM9+LearnSuppFundCash_ACM10+LearnSuppFundCash_ACM11+LearnSuppFundCash_ACM12) AS LearnSuppFundCash_EFY
      ,(OnProgPayment_ACM1+OnProgPayment_ACM2+OnProgPayment_ACM3+OnProgPayment_ACM4+OnProgPayment_ACM5+OnProgPayment_ACM6+OnProgPayment_ACM7+OnProgPayment_ACM8+OnProgPayment_ACM9+OnProgPayment_ACM10+OnProgPayment_ACM11+OnProgPayment_ACM12) AS OnProgPayment_EFY
      ,(OnProgPaymentUncapped_ACM1+OnProgPaymentUncapped_ACM2+OnProgPaymentUncapped_ACM3+OnProgPaymentUncapped_ACM4+OnProgPaymentUncapped_ACM5+OnProgPaymentUncapped_ACM6+OnProgPaymentUncapped_ACM7+OnProgPaymentUncapped_ACM8+OnProgPaymentUncapped_ACM9+OnProgPaymentUncapped_ACM10+OnProgPaymentUncapped_ACM11+OnProgPaymentUncapped_ACM12) AS OnProgPaymentUncapped_EFY
      ,(OnProgPayPct_ACM1+OnProgPayPct_ACM2+OnProgPayPct_ACM3+OnProgPayPct_ACM4+OnProgPayPct_ACM5+OnProgPayPct_ACM6+OnProgPayPct_ACM7+OnProgPayPct_ACM8+OnProgPayPct_ACM9+OnProgPayPct_ACM10+OnProgPayPct_ACM11+OnProgPayPct_ACM12) AS OnProgPayPct_EFY
      ,(OnProgPayPctTrans_ACM1+OnProgPayPctTrans_ACM2+OnProgPayPctTrans_ACM3+OnProgPayPctTrans_ACM4+OnProgPayPctTrans_ACM5+OnProgPayPctTrans_ACM6+OnProgPayPctTrans_ACM7+OnProgPayPctTrans_ACM8+OnProgPayPctTrans_ACM9+OnProgPayPctTrans_ACM10+OnProgPayPctTrans_ACM11+OnProgPayPctTrans_ACM12) AS OnProgPayPctTrans_EFY
      ,(TransInstPerPeriod_ACM1+TransInstPerPeriod_ACM2+TransInstPerPeriod_ACM3+TransInstPerPeriod_ACM4+TransInstPerPeriod_ACM5+TransInstPerPeriod_ACM6+TransInstPerPeriod_ACM7+TransInstPerPeriod_ACM8+TransInstPerPeriod_ACM9+TransInstPerPeriod_ACM10+TransInstPerPeriod_ACM11+TransInstPerPeriod_ACM12) AS TransInstPerPeriod_EFY
FROM  SFA_Period_1  
INNER JOIN SFA_Period_2 
ON SFA_Period_1.LearnRefNumber=SFA_Period_2.LearnRefNumber
AND SFA_Period_1.AimSeqNumber = SFA_Period_2.AimSeqNumber
INNER JOIN SFA_Period_3
ON SFA_Period_2.LearnRefNumber = SFA_Period_3.LearnRefNumber
AND SFA_Period_2.AimSeqNumber = SFA_Period_3.AimSeqNumber
INNER JOIN SFA_Period_4
ON SFA_Period_3.LearnRefNumber= SFA_Period_4.LearnRefNumber
AND SFA_Period_3.AimSeqNumber = SFA_Period_4.AimSeqNumber
INNER JOIN SFA_Period_5
ON SFA_Period_4.LearnRefNumber = SFA_Period_5.LearnRefNumber
AND SFA_Period_4.AimSeqNumber = SFA_Period_5.AimSeqNumber
INNER JOIN SFA_Period_6
ON SFA_Period_5.LearnRefNumber = SFA_Period_6.LearnRefNumber
AND SFA_Period_5.AimSeqNumber = SFA_Period_6.AimSeqNumber
INNER JOIN SFA_Period_7
ON SFA_Period_6.LearnRefNumber = SFA_Period_7.LearnRefNumber
AND SFA_Period_6.AimSeqNumber = SFA_Period_7.AimSeqNumber
INNER JOIN SFA_Period_8
ON SFA_Period_7.LearnRefNumber = SFA_Period_8.LearnRefNumber
AND SFA_Period_7.AimSeqNumber = SFA_Period_8.AimSeqNumber
INNER JOIN SFA_Period_9
ON SFA_Period_8.LearnRefNumber = SFA_Period_9.LearnRefNumber
AND SFA_Period_8.AimSeqNumber = SFA_Period_9.AimSeqNumber
INNER JOIN SFA_Period_10
ON SFA_Period_9.LearnRefNumber = SFA_Period_10.LearnRefNumber
AND SFA_Period_9.AimSeqNumber = SFA_Period_10.AimSeqNumber
INNER JOIN SFA_Period_11
ON SFA_Period_10.LearnRefNumber = SFA_Period_11.LearnRefNumber
AND SFA_Period_10.AimSeqNumber = SFA_Period_11.AimSeqNumber
INNER JOIN SFA_Period_12
ON SFA_Period_11.LearnRefNumber = SFA_Period_12.LearnRefNumber
AND SFA_Period_11.AimSeqNumber = SFA_Period_12.AimSeqNumber

--------ALB Periodised Table----------
/****** Script for SelectTopNRows command from SSMS  ******/
;WITH ALBCode_CTE AS 
(
SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[AttributeName]
      ,[Period_1] AS ALBCode_ACM1
      ,[Period_2] AS ALBCode_ACM2
      ,[Period_3] AS ALBCode_ACM3
      ,[Period_4] AS ALBCode_ACM4
      ,[Period_5] AS ALBCode_ACM5
      ,[Period_6] AS ALBCode_ACM6
      ,[Period_7] AS ALBCode_ACM7
      ,[Period_8] AS ALBCode_ACM8
      ,[Period_9] AS ALBCode_ACM9
      ,[Period_10] AS ALBCode_ACM10
      ,[Period_11] AS ALBCode_ACM11
      ,[Period_12] AS ALBCode_ACM12
  FROM [Rulebase].[ALB_LearningDelivery_PeriodisedValues]
  WHERE AttributeName ='ALBCode'
  )
,ALBSupportPayment_CTE AS 
(
SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[AttributeName]
      ,[Period_1] AS  ALBSupportPayment_ACM1
      ,[Period_2] AS  ALBSupportPayment_ACM2
      ,[Period_3] AS  ALBSupportPayment_ACM3
      ,[Period_4] AS  ALBSupportPayment_ACM4
      ,[Period_5] AS  ALBSupportPayment_ACM5
      ,[Period_6] AS  ALBSupportPayment_ACM6
      ,[Period_7] AS  ALBSupportPayment_ACM7
      ,[Period_8] AS  ALBSupportPayment_ACM8
      ,[Period_9] AS  ALBSupportPayment_ACM9
      ,[Period_10] AS  ALBSupportPayment_ACM10
      ,[Period_11] AS  ALBSupportPayment_ACM11
      ,[Period_12] AS  ALBSupportPayment_ACM12
  FROM [Rulebase].[ALB_LearningDelivery_PeriodisedValues]
  WHERE AttributeName ='ALBSupportPayment'
)
,AreaUpliftBalPayment_CTE AS 
(
SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[AttributeName]
      ,[Period_1] AS AreaUpliftBalPayment_ACM1				
	  ,[Period_2] AS AreaUpliftBalPayment_ACM2
      ,[Period_3] AS AreaUpliftBalPayment_ACM3
      ,[Period_4] AS AreaUpliftBalPayment_ACM4
      ,[Period_5] AS AreaUpliftBalPayment_ACM5
      ,[Period_6] AS AreaUpliftBalPayment_ACM6
      ,[Period_7] AS AreaUpliftBalPayment_ACM7
      ,[Period_8] AS AreaUpliftBalPayment_ACM8
      ,[Period_9] AS AreaUpliftBalPayment_ACM9
      ,[Period_10] AS AreaUpliftBalPayment_ACM10
      ,[Period_11] AS AreaUpliftBalPayment_ACM11
      ,[Period_12] AS AreaUpliftBalPayment_ACM12
  FROM [Rulebase].[ALB_LearningDelivery_PeriodisedValues]
  WHERE AttributeName ='AreaUpliftBalPayment'
)
,AreaUpliftOnProgPayment_CTE AS
(
SELECT [LearnRefNumber]
      ,[AimSeqNumber]
      ,[AttributeName]
      ,[Period_1] AS AreaUpliftOnProgPayment_ACM1				
      ,[Period_2] AS AreaUpliftOnProgPayment_ACM2
      ,[Period_3] AS AreaUpliftOnProgPayment_ACM3
      ,[Period_4] AS AreaUpliftOnProgPayment_ACM4
      ,[Period_5] AS AreaUpliftOnProgPayment_ACM5
      ,[Period_6] AS AreaUpliftOnProgPayment_ACM6
      ,[Period_7] AS AreaUpliftOnProgPayment_ACM7
      ,[Period_8] AS AreaUpliftOnProgPayment_ACM8
      ,[Period_9] AS AreaUpliftOnProgPayment_ACM9
      ,[Period_10] AS AreaUpliftOnProgPayment_ACM10
      ,[Period_11] AS AreaUpliftOnProgPayment_ACM11
      ,[Period_12] AS AreaUpliftOnProgPayment_ACM12
  FROM [Rulebase].[ALB_LearningDelivery_PeriodisedValues]
  WHERE AttributeName ='AreaUpliftOnProgPayment'
)

INSERT INTO [Rulebase].[ALB_LearningDeliveryPeriod]
(
LearnRefNumber
	,AimSeqNumber				
	,ALBCode_ACM1                              
	,ALBSupportPayment_ACM1					
	,AreaUpliftBalPayment_ACM1				
	,AreaUpliftOnProgPayment_ACM1			
	,ALBCode_ACM2                            
	,ALBSupportPayment_ACM2					
	,AreaUpliftBalPayment_ACM2				
	,AreaUpliftOnProgPayment_ACM2
	,ALBCode_ACM3                          
	,ALBSupportPayment_ACM3					
	,AreaUpliftBalPayment_ACM3				
	,AreaUpliftOnProgPayment_ACM3	
	,ALBCode_ACM4                            
	,ALBSupportPayment_ACM4					
	,AreaUpliftBalPayment_ACM4				
	,AreaUpliftOnProgPayment_ACM4				
	,ALBCode_ACM5                            
	,ALBSupportPayment_ACM5					
	,AreaUpliftBalPayment_ACM5				
	,AreaUpliftOnProgPayment_ACM5				
	,ALBCode_ACM6                            
	,ALBSupportPayment_ACM6					
	,AreaUpliftBalPayment_ACM6				
	,AreaUpliftOnProgPayment_ACM6				
	,ALBCode_ACM7                            
	,ALBSupportPayment_ACM7					
	,AreaUpliftBalPayment_ACM7				
	,AreaUpliftOnProgPayment_ACM7				
	,ALBCode_ACM8                            
	,ALBSupportPayment_ACM8					
	,AreaUpliftBalPayment_ACM8				
	,AreaUpliftOnProgPayment_ACM8				
	,ALBCode_ACM9                            
	,ALBSupportPayment_ACM9					
	,AreaUpliftBalPayment_ACM9				
	,AreaUpliftOnProgPayment_ACM9				
	,ALBCode_ACM10                            
	,ALBSupportPayment_ACM10					
	,AreaUpliftBalPayment_ACM10				
	,AreaUpliftOnProgPayment_ACM10				
	,ALBCode_ACM11                            
	,ALBSupportPayment_ACM11					
	,AreaUpliftBalPayment_ACM11				
	,AreaUpliftOnProgPayment_ACM11				
	,ALBCode_ACM12                            
	,ALBSupportPayment_ACM12					
	,AreaUpliftBalPayment_ACM12				
	,AreaUpliftOnProgPayment_ACM12			
)
SELECT 
	ALBCode_CTE.LearnRefNumber
	,ALBCode_CTE.AimSeqNumber				
	,ALBCode_ACM1                              
	,ALBSupportPayment_ACM1					
	,AreaUpliftBalPayment_ACM1				
	,AreaUpliftOnProgPayment_ACM1			
	,ALBCode_ACM2                            
	,ALBSupportPayment_ACM2					
	,AreaUpliftBalPayment_ACM2				
	,AreaUpliftOnProgPayment_ACM2				
	,ALBCode_ACM3                          
	,ALBSupportPayment_ACM3					
	,AreaUpliftBalPayment_ACM3				
	,AreaUpliftOnProgPayment_ACM3				
	,ALBCode_ACM4                            
	,ALBSupportPayment_ACM4					
	,AreaUpliftBalPayment_ACM4				
	,AreaUpliftOnProgPayment_ACM4				
	,ALBCode_ACM5                            
	,ALBSupportPayment_ACM5					
	,AreaUpliftBalPayment_ACM5				
	,AreaUpliftOnProgPayment_ACM5				
	,ALBCode_ACM6                            
	,ALBSupportPayment_ACM6					
	,AreaUpliftBalPayment_ACM6				
	,AreaUpliftOnProgPayment_ACM6				
	,ALBCode_ACM7                            
	,ALBSupportPayment_ACM7					
	,AreaUpliftBalPayment_ACM7				
	,AreaUpliftOnProgPayment_ACM7				
	,ALBCode_ACM8                            
	,ALBSupportPayment_ACM8					
	,AreaUpliftBalPayment_ACM8				
	,AreaUpliftOnProgPayment_ACM8				
	,ALBCode_ACM9                            
	,ALBSupportPayment_ACM9					
	,AreaUpliftBalPayment_ACM9				
	,AreaUpliftOnProgPayment_ACM9				
	,ALBCode_ACM10                            
	,ALBSupportPayment_ACM10					
	,AreaUpliftBalPayment_ACM10				
	,AreaUpliftOnProgPayment_ACM10				
	,ALBCode_ACM11                            
	,ALBSupportPayment_ACM11					
	,AreaUpliftBalPayment_ACM11				
	,AreaUpliftOnProgPayment_ACM11				
	,ALBCode_ACM12                            
	,ALBSupportPayment_ACM12					
	,AreaUpliftBalPayment_ACM12				
	,AreaUpliftOnProgPayment_ACM12		
FROM ALBCode_CTE 
INNER JOIN ALBSupportPayment_CTE 
ON ALBCode_CTE.LearnRefNumber = ALBSupportPayment_CTE.LearnRefNumber
AND ALBCode_CTE.AimSeqNumber = ALBSupportPayment_CTE.AimSeqNumber
INNER JOIN AreaUpliftBalPayment_CTE 
ON ALBSupportPayment_CTE.LearnRefNumber = AreaUpliftBalPayment_CTE.LearnRefNumber
AND ALBSupportPayment_CTE.AimSeqNumber = AreaUpliftBalPayment_CTE.AimSeqNumber
INNER JOIN AreaUpliftOnProgPayment_CTE		
ON 	AreaUpliftOnProgPayment_CTE.LearnRefNumber = AreaUpliftBalPayment_CTE.LearnRefNumber
AND AreaUpliftOnProgPayment_CTE.AimSeqNumber =  AreaUpliftBalPayment_CTE.AimSeqNumber

