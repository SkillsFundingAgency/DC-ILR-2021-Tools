if not exists (select * from sys.schemas where name = 'DEDS_Rulebase')
begin
	exec ('create schema DEDS_Rulebase');
end
go

if object_id('DEDS_Rulebase.TBL_LearningDelivery_PeriodisedValues','v') is not null
begin
	drop view DEDS_Rulebase.TBL_LearningDelivery_PeriodisedValues
end
go

create view DEDS_Rulebase.TBL_LearningDelivery_PeriodisedValues
as
	select	g.UKPRN,
			ldpv.LearnRefNumber,
			ldpv.AimSeqNumber,
			ldpv.AttributeName,
			ldpv.Period_1,
			ldpv.Period_2,
			ldpv.Period_3,
			ldpv.Period_4,
			ldpv.Period_5,
			ldpv.Period_6,
			ldpv.Period_7,
			ldpv.Period_8,
			ldpv.Period_9,
			ldpv.Period_10,
			ldpv.Period_11,
			ldpv.Period_12
	from	Rulebase.TBL_LearningDelivery_PeriodisedValues as ldpv
				cross join (select top 1 UKPRN from Rulebase.TBL_global) as g
go

if object_id ('DEDS_Rulebase.TBL_LearningDelivery_Period', 'v') is not null
begin
	drop view DEDS_Rulebase.TBL_LearningDelivery_Period
end
go

create view DEDS_Rulebase.TBL_LearningDelivery_Period
as
	select	g.UKPRN,
			ldp.LearnRefNumber,
			ldp.AimSeqNumber,
			ldp.[Period],
			ldp.AchPayment,
			ldp.CoreGovContPayment,
			ldp.CoreGovContUncapped,
			ldp.InstPerPeriod,
			ldp.LearnSuppFund,
			ldp.LearnSuppFundCash,
			ldp.MathEngBalPayment,
			ldp.MathEngBalPct,
			ldp.MathEngOnProgPayment,
			ldp.MathEngOnProgPct,
			ldp.SmallBusPayment,
			ldp.YoungAppFirstPayment,
			ldp.YoungAppPayment,
			ldp.YoungAppSecondPayment
	from	Rulebase.TBL_LearningDelivery_Period as ldp
				cross join (select top 1 UKPRN from Rulebase.TBL_global) as g
go

if object_id('DEDS_Rulebase.TBL_LearningDelivery', 'v') is not null
begin
	drop view DEDS_Rulebase.TBL_LearningDelivery
end
go

create view DEDS_Rulebase.TBL_LearningDelivery
as
	select	g.UKPRN,
			ld.LearnRefNumber,
			ld.AimSeqNumber,
			ld.ProgStandardStartDate,
			ld.FundLine,
			ld.MathEngAimValue,
			ld.PlannedNumOnProgInstalm,
			ld.LearnSuppFundCash,
			ld.AdjProgStartDate,
			ld.LearnSuppFund,
			ld.MathEngOnProgPayment,
			ld.InstPerPeriod,
			ld.SmallBusPayment,
			ld.YoungAppSecondPayment,
			ld.CoreGovContPayment,
			ld.YoungAppEligible,
			ld.SmallBusEligible,
			ld.MathEngOnProgPct,
			ld.AgeStandardStart,
			ld.YoungAppSecondThresholdDate,
			ld.EmpIdFirstDayStandard,
			ld.EmpIdFirstYoungAppDate,
			ld.EmpIdSecondYoungAppDate,
			ld.EmpIdSmallBusDate,
			ld.YoungAppFirstThresholdDate,
			ld.AchApplicDate,
			ld.AchEligible,
			ld.Achieved,
			ld.AchievementApplicVal,
			ld.AchPayment,
			ld.ActualNumInstalm,
			ld.CombinedAdjProp,
			ld.EmpIdAchDate,
			ld.LearnDelDaysIL,
			ld.LearnDelStandardAccDaysIL,
			ld.LearnDelStandardPrevAccDaysIL,
			ld.LearnDelStandardTotalDaysIL,
			ld.ActualDaysIL,
			ld.MathEngBalPayment,
			ld.MathEngBalPct,
			ld.MathEngLSFFundStart,
			ld.PlannedTotalDaysIL,
			ld.MathEngLSFThresholdDays,
			ld.OutstandNumOnProgInstalm,
			ld.SmallBusApplicVal,
			ld.SmallBusStatusFirstDayStandard,
			ld.SmallBusStatusThreshold,
			ld.YoungAppApplicVal,
			ld.CoreGovContCapApplicVal,
			ld.CoreGovContUncapped,
			ld.ApplicFundValDate,
			ld.YoungAppFirstPayment,
			ld.YoungAppPayment	
	from	Rulebase.TBL_LearningDelivery as ld
				cross join (select top 1 UKPRN from Rulebase.TBL_global) as g
go

if object_id ('DEDS_Rulebase.TBL_global', 'v') is not null
begin
	drop view DEDS_Rulebase.TBL_global
end
go

create view DEDS_Rulebase.TBL_global
as
	select	UKPRN,
			CurFundYr,
			LARSVersion,
			RulebaseVersion
	from	Rulebase.TBL_global
go

if object_id ('DEDS_Rulebase.FM35_LearningDelivery_PeriodisedValues', 'v') is not null
begin
	drop view DEDS_Rulebase.FM35_LearningDelivery_PeriodisedValues
end
go

create view DEDS_Rulebase.FM35_LearningDelivery_PeriodisedValues
as
	select	g.UKPRN,
			spv.LearnRefNumber,
			spv.AimSeqNumber,
			spv.AttributeName,
			spv.Period_1,
			spv.Period_2,
			spv.Period_3,
			spv.Period_4,
			spv.Period_5, 
			spv.Period_6,
			spv.Period_7,
			spv.Period_8,
			spv.Period_9,
			spv.Period_10,
			spv.Period_11,
			spv.Period_12
	from	Rulebase.FM35_LearningDelivery_PeriodisedValues as spv
				cross join (select top 1 UKPRN from Rulebase.FM35_global) as g
go

if object_id('DEDS_Rulebase.FM35_LearningDelivery_Period', 'v') is not null
begin
	drop view DEDS_Rulebase.FM35_LearningDelivery_Period
end
go

create view DEDS_Rulebase.FM35_LearningDelivery_Period
as
	select	g.UKPRN,
			sp.LearnRefNumber,
			sp.AimSeqNumber,
			sp.[Period],
			sp.AchievePayment,
			sp.AchievePayPct,
			sp.AchievePayPctTrans,
			sp.BalancePayment,
			sp.BalancePaymentUncapped,
			sp.BalancePct,
			sp.BalancePctTrans,
			sp.EmpOutcomePay,
			sp.EmpOutcomePct,
			sp.EmpOutcomePctTrans,
			sp.InstPerPeriod,
			sp.LearnSuppFund,
			sp.LearnSuppFundCash,
			sp.OnProgPayment,
			sp.OnProgPaymentUncapped,
			sp.OnProgPayPct,
			sp.OnProgPayPctTrans,
			sp.TransInstPerPeriod
	from	Rulebase.FM35_LearningDelivery_Period as sp
				cross join (select top 1 UKPRN from Rulebase.FM35_global) as g
go

if object_id ('DEDS_Rulebase.FM35_LearningDelivery','v')is not null
begin
	drop view DEDS_Rulebase.FM35_LearningDelivery
end
go

create view DEDS_Rulebase.FM35_LearningDelivery
as 
	select	g.UKPRN,
			sld.LearnRefNumber,
			sld.AimSeqNumber,
			sld.AchApplicDate,
			sld.Achieved,
			sld.AchieveElement,
			sld.AchievePayElig,
			sld.AchievePayPctPreTrans,
			sld.AchPayTransHeldBack,
			sld.ActualDaysIL,
			sld.ActualNumInstalm,
			sld.ActualNumInstalmPreTrans,
			sld.ActualNumInstalmTrans,
			sld.AdjLearnStartDate,
			sld.AdltLearnResp,
			sld.AgeAimStart,
			sld.AimValue,
			sld.AppAdjLearnStartDate,
			sld.AppAgeFact,
			sld.AppATAGTA,
			sld.AppCompetency,
			sld.AppFuncSkill,
			sld.AppFuncSkill1618AdjFact,
			sld.AppKnowl,
			sld.AppLearnStartDate,
			sld.ApplicEmpFactDate,
			sld.ApplicFactDate,
			sld.ApplicFundRateDate,
			sld.ApplicProgWeightFact,
			sld.ApplicUnweightFundRate,
			sld.ApplicWeightFundRate,
			sld.AppNonFund,
			sld.AreaCostFactAdj,
			sld.BalInstalmPreTrans,
			sld.BaseValueUnweight,
			sld.CapFactor,
			sld.DisUpFactAdj,
			sld.EmpOutcomePayElig,
			sld.EmpOutcomePctHeldBackTrans,
			sld.EmpOutcomePctPreTrans,
			sld.EmpRespOth,
			sld.ESOL,
			sld.FullyFund,
			sld.FundLine,
			sld.FundStart,
			sld.LargeEmployerID,
			sld.LargeEmployerFM35Fctr,
			sld.LargeEmployerStatusDate,
			sld.LearnDelFundOrgCode,
			sld.LTRCUpliftFctr,
			sld.NonGovCont,
			sld.OLASSCustody,
			sld.OnProgPayPctPreTrans,
			sld.OutstndNumOnProgInstalm,
			sld.OutstndNumOnProgInstalmTrans,
			sld.PlannedNumOnProgInstalm,
			sld.PlannedNumOnProgInstalmTrans,
			sld.PlannedTotalDaysIL,
			sld.PlannedTotalDaysILPreTrans,
			sld.PropFundRemain,
			sld.PropFundRemainAch,
			sld.PrscHEAim,
			sld.Residential,
			sld.[Restart],
			sld.SpecResUplift,
			sld.StartPropTrans,
			sld.ThresholdDays,
			sld.Traineeship,
			sld.Trans,
			sld.TrnAdjLearnStartDate,
			sld.TrnWorkPlaceAim,
			sld.TrnWorkPrepAim,
			sld.UnWeightedRateFromESOL,
			sld.UnweightedRateFromLARS,
			sld.WeightedRateFromESOL,
			sld.WeightedRateFromLARS,
			sld.ReservedUpliftFactor1,
			sld.ReservedUpliftRate1
	from	Rulebase.FM35_LearningDelivery as sld
				cross join (select UKPRN from Rulebase.FM35_global) as g
go

if object_id ('DEDS_Rulebase.FM35_global','v') is not null
begin
	drop view DEDS_Rulebase.FM35_global
end
go

create view DEDS_Rulebase.FM35_global
as
	select	g.UKPRN,
			g.CurFundYr,
			g.LARSVersion,
			g.OrgVersion,
			g.PostcodeDisadvantageVersion,
			g.RulebaseVersion
	from	Rulebase.FM35_global g
go

if object_id ('DEDS_Rulebase.ALB_LearningDelivery_PeriodisedValues') is not null
begin
	drop view DEDS_Rulebase.ALB_LearningDelivery_PeriodisedValues
end
go

create view DEDS_Rulebase.ALB_LearningDelivery_PeriodisedValues
as
	select	g.UKPRN,
			apv.LearnRefNumber,
			apv.AimSeqNumber,
			apv.AttributeName,
			apv.Period_1,
			apv.Period_2,
			apv.Period_3,
			apv.Period_4,
			apv.Period_5,
			apv.Period_6,
			apv.Period_7,
			apv.Period_8,
			apv.Period_9,
			apv.Period_10,
			apv.Period_11,
			apv.Period_12
	from	Rulebase.ALB_LearningDelivery_PeriodisedValues as apv
				cross join (select top 1 UKPRN from Rulebase.ALB_global) as g
go

if object_id ('DEDS_Rulebase.ALB_LearningDelivery_Period','v') is not null
begin
	drop view DEDS_Rulebase.ALB_LearningDelivery_Period
end
go

create view DEDS_Rulebase.ALB_LearningDelivery_Period
as
	select	g.UKPRN,
			ldp.LearnRefNumber,
			ldp.AimSeqNumber,
			ldp.[Period],
			ldp.ALBCode,
			ldp.ALBSupportPayment,
			ldp.AreaUpliftBalPayment,
			ldp.AreaUpliftOnProgPayment
	from	Rulebase.ALB_LearningDelivery_Period as ldp
				cross join (select top 1 UKPRN from Rulebase.ALB_global) as g 
go

if object_id ('DEDS_Rulebase.ALB_LearningDelivery', 'v') is not null
begin
	drop view DEDS_Rulebase.ALB_LearningDelivery
end
go

create view DEDS_Rulebase.ALB_LearningDelivery
as
	select	g.UKPRN,
			ld.LearnRefNumber,
			ld.AimSeqNumber,
			ld.Achieved,
			ld.ActualNumInstalm,
			ld.AdvLoan,
			ld.ApplicFactDate,
			ld.ApplicProgWeightFact,
			ld.AreaCostFactAdj,
			ld.AreaCostInstalment,
			ld.FundLine,
			ld.FundStart,
			ld.LiabilityDate,
			ld.LoanBursAreaUplift,
			ld.LoanBursSupp,
			ld.OutstndNumOnProgInstalm,
			ld.PlannedNumOnProgInstalm,
			ld.WeightedRate
	from	Rulebase.ALB_LearningDelivery as ld
				cross join (select top 1 UKPRN from Rulebase.ALB_global) as g
go

if object_id ('DEDS_Rulebase.ALB_Learner_PeriodisedValues', 'v') is not null
begin
	drop view DEDS_Rulebase.ALB_Learner_PeriodisedValues
end
go

create view DEDS_Rulebase.ALB_Learner_PeriodisedValues
as
	select	g.UKPRN,
			lpv.LearnRefNumber,
			lpv.AttributeName,
			lpv.Period_1,
			lpv.Period_2,
			lpv.Period_3,
			lpv.Period_4,
			lpv.Period_5,
			lpv.Period_6,
			lpv.Period_7,
			lpv.Period_8,
			lpv.Period_9,
			lpv.Period_10,
			lpv.Period_11,
			lpv.Period_12
	from	Rulebase.ALB_Learner_PeriodisedValues as lpv
				cross join (select top 1 UKPRN from Rulebase.ALB_global) as g
go

if object_id ('DEDS_Rulebase.ALB_Learner_Period','v') is not null
begin
	drop view DEDS_Rulebase.ALB_Learner_Period
end
go

create view DEDS_Rulebase.ALB_Learner_Period
as
	select	g.UKPRN,
			lp.LearnRefNumber,
			lp.[Period],
			lp.ALBSeqNum
	from	Rulebase.ALB_Learner_Period as lp
				cross join (select top 1 UKPRN from Rulebase.ALB_global) as g
go


if object_id ('DEDS_Rulebase.ALB_global', 'v') is not null
begin
	drop view DEDS_Rulebase.ALB_global
end
go

create view DEDS_Rulebase.ALB_global
as
	select	UKPRN,
			LARSVersion,
			PostcodeAreaCostVersion,
			RulebaseVersion
	from	Rulebase.ALB_global
go

if object_id ('DEDS_Rulebase.FM25_Learner', 'v') is not null
begin
	drop view DEDS_Rulebase.FM25_Learner
end
go

create view DEDS_Rulebase.FM25_Learner 
as
	select	g.UKPRN,
			el.LearnRefNumber,
			el.AcadMonthPayment,
			el.AcadProg,
			el.ActualDaysILCurrYear,
			el.AreaCostFact1618Hist,
			el.Block1DisadvUpliftNew,
			el.Block2DisadvElementsNew,
			el.ConditionOfFundingEnglish,
			el.ConditionOfFundingMaths,
			el.CoreAimSeqNumber,
			el.FullTimeEquiv,
			el.FundLine,
			el.LearnerActEndDate,
			el.LearnerPlanEndDate,
			el.LearnerStartDate,
			el.NatRate,
			el.OnProgPayment,
			el.PlannedDaysILCurrYear,
			el.ProgWeightHist,
			el.ProgWeightNew,
			el.PrvDisadvPropnHist,
			el.PrvHistLrgProgPropn,
			el.PrvRetentFactHist,
			el.RateBand,
			el.RetentNew,
			el.StartFund,
			el.ThresholdDays,
			el.TLevelStudent,
			el.PrvHistL3ProgMathEngProp
	from	Rulebase.FM25_Learner as el
				cross join (select top 1 UKPRN from Rulebase.FM25_global) as g
go

if object_id ('DEDS_Rulebase.FM25_global', 'v') is not null
begin
	drop view DEDS_Rulebase.FM25_global
end
go

create view DEDS_Rulebase.FM25_global
as
	select	UKPRN,
			LARSVersion,
			OrgVersion,
			PostcodeDisadvantageVersion,
			RulebaseVersion
	from	Rulebase.FM25_global
go

if object_id ('DEDS_Rulebase.FM25_FM35_Learner_PeriodisedValues', 'v') is not null
begin
	drop view DEDS_Rulebase.FM25_FM35_Learner_PeriodisedValues
end
go

create view DEDS_Rulebase.FM25_FM35_Learner_PeriodisedValues
as
	select	g.UKPRN,
			espv.LearnRefNumber,
			espv.AttributeName,
			espv.Period_1,
			espv.Period_2,
			espv.Period_3,
			espv.Period_4,
			espv.Period_5,
			espv.Period_6,
			espv.Period_7,
			espv.Period_8,
			espv.Period_9,
			espv.Period_10,
			espv.Period_11,
			espv.Period_12
	from	Rulebase.FM25_FM35_Learner_PeriodisedValues as espv
				cross join (select top 1 UKPRN from Rulebase.FM25_FM35_global) as g
go

if object_id ('DEDS_Rulebase.FM25_FM35_Learner_Period', 'v') is not null
begin
	drop view DEDS_Rulebase.FM25_FM35_Learner_Period
end
go

create view DEDS_Rulebase.FM25_FM35_Learner_Period
as
	select	g.UKPRN,
			esp.LearnRefNumber,
			esp.[Period],
			esp.LnrOnProgPay
	from	Rulebase.FM25_FM35_Learner_Period as esp
				cross join (select top 1 UKPRN from Rulebase.FM25_FM35_global) as g
go

if object_id ('DEDS_Rulebase.FM25_FM35_global','v') is not null
begin
	drop view DEDS_Rulebase.FM25_FM35_global
end
go

create view DEDS_Rulebase.FM25_FM35_global
as
	select	UKPRN,
			RulebaseVersion
	from	Rulebase.FM25_FM35_global
go

if object_id ('DEDS_Rulebase.AEC_global', 'v') is not null
begin
	drop view DEDS_Rulebase.AEC_global
end
go

create view DEDS_Rulebase.AEC_global
as
	select	UKPRN,
			LARSVersion,
			RulebaseVersion,
			[Year]
	from	Rulebase.AEC_global
go

if object_id ('DEDS_Rulebase.AEC_LearningDelivery', 'v') is not null
begin
	drop view DEDS_Rulebase.AEC_LearningDelivery
end
go

create view DEDS_Rulebase.AEC_LearningDelivery
as
	select	g.UKPRN,
			ald.LearnRefNumber,
			ald.AimSeqNumber,
			ald.LearnAimRef,
			ald.ActualDaysIL,
			ald.ActualNumInstalm,
			ald.AdjStartDate,
			ald.AgeAtProgStart,
			ald.AppAdjLearnStartDate,
			ald.AppAdjLearnStartDateMatchPathway,
			ald.ApplicCompDate,
			ald.CombinedAdjProp,
			ald.Completed,
			ald.FirstIncentiveThresholdDate,
			ald.FundStart,
			ald.LDApplic1618FrameworkUpliftTotalActEarnings,
			ald.LearnDel1618AtStart,
			ald.LearnDelAccDaysILCareLeavers,
			ald.LearnDelAppAccDaysIL,
			ald.LearnDelApplicCareLeaverIncentive,
			ald.LearnDelApplicDisadvAmount,
			ald.LearnDelApplicEmp1618Incentive,
			ald.LearnDelApplicEmpDate,
			ald.LearnDelApplicProv1618FrameworkUplift,
			ald.LearnDelApplicProv1618Incentive,
			ald.LearnDelAppPrevAccDaysIL,
			ald.LearnDelDaysIL,
			ald.LearnDelDisadAmount,
			ald.LearnDelEligDisadvPayment,
			ald.LearnDelEmpIdFirstAdditionalPaymentThreshold,
			ald.LearnDelEmpIdSecondAdditionalPaymentThreshold,
			ald.LearnDelLearnerAddPayThresholdDate,
			ald.LearnDelHistDaysCareLeavers,
			ald.LearnDelHistDaysThisApp,
			ald.LearnDelHistProgEarnings,
			ald.LearnDelInitialFundLineType,
			ald.LearnDelMathEng,
			ald.LearnDelNonLevyProcured,
			ald.LearnDelPrevAccDaysILCareLeavers,
			ald.LearnDelProgEarliestACT2Date,
			ald.LearnDelRedCode,
			ald.LearnDelRedStartDate,
			ald.MathEngAimValue,
			ald.OutstandNumOnProgInstalm,
			ald.PlannedNumOnProgInstalm,
			ald.PlannedTotalDaysIL,
			ald.SecondIncentiveThresholdDate,
			ald.ThresholdDays
	from	Rulebase.AEC_LearningDelivery as ald
				cross join (select top 1 UKPRN from Rulebase.AEC_global) as g
go

if object_id ('DEDS_Rulebase.AEC_LearningDelivery_Period', 'v') is not null
begin
	drop view DEDS_Rulebase.AEC_LearningDelivery_Period
end
go

create view DEDS_Rulebase.AEC_LearningDelivery_Period
as
	select	g.UKPRN,
			aldp.LearnRefNumber,
			aldp.AimSeqNumber,
			aldp.[Period],
			aldp.DisadvFirstPayment,
			aldp.DisadvSecondPayment,
			aldp.FundLineType,
			aldp.InstPerPeriod,
			aldp.LDApplic1618FrameworkUpliftBalancingPayment,
			aldp.LDApplic1618FrameworkUpliftCompletionPayment,
			aldp.LDApplic1618FrameworkUpliftOnProgPayment,
			aldp.LearnDelContType,
			aldp.LearnDelFirstEmp1618Pay,
			aldp.LearnDelFirstProv1618Pay,
			aldp.LearnDelLearnAddPayment,
			aldp.LearnDelLevyNonPayInd,
			aldp.LearnDelSecondEmp1618Pay,
			aldp.LearnDelSecondProv1618Pay,
			aldp.LearnDelSEMContWaiver,
			aldp.LearnDelSFAContribPct,
			aldp.LearnDelESFAContribPct,
			aldp.LearnSuppFund,
			aldp.LearnSuppFundCash,
			aldp.MathEngBalPayment,
			aldp.MathEngOnProgPayment,
			aldp.ProgrammeAimBalPayment,
			aldp.ProgrammeAimCompletionPayment,
			aldp.ProgrammeAimOnProgPayment,
			aldp.ProgrammeAimProgFundIndMaxEmpCont,
			aldp.ProgrammeAimProgFundIndMinCoInvest,
			aldp.ProgrammeAimTotProgFund
	from	Rulebase.AEC_LearningDelivery_Period as aldp
				cross join (select top 1 UKPRN from Rulebase.AEC_global) as g
go

if object_id ('DEDS_Rulebase.AEC_LearningDelivery_PeriodisedValues') is not null
begin
	drop view DEDS_Rulebase.AEC_LearningDelivery_PeriodisedValues
end
go

create view DEDS_Rulebase.AEC_LearningDelivery_PeriodisedValues
as
	select	g.UKPRN,
			aldpv.LearnRefNumber,
			aldpv.AimSeqNumber,
			aldpv.AttributeName,
			aldpv.Period_1,
			aldpv.Period_2,
			aldpv.Period_3,
			aldpv.Period_4,
			aldpv.Period_5,
			aldpv.Period_6,
			aldpv.Period_7,
			aldpv.Period_8,
			aldpv.Period_9,
			aldpv.Period_10,
			aldpv.Period_11,
			aldpv.Period_12
	from	Rulebase.AEC_LearningDelivery_PeriodisedValues as aldpv
				cross join (select top 1 UKPRN from Rulebase.AEC_global) as g
go

if object_id ('DEDS_Rulebase.AEC_LearningDelivery_PeriodisedTextValues','v') is not null
begin
	drop view DEDS_Rulebase.AEC_LearningDelivery_PeriodisedTextValues
end
go

create view DEDS_Rulebase.AEC_LearningDelivery_PeriodisedTextValues
as
	select	g.UKPRN,
			ldptv.LearnRefNumber,
			ldptv.AimSeqNumber,
			ldptv.AttributeName,
			ldptv.Period_1,
			ldptv.Period_2,
			ldptv.Period_3,
			ldptv.Period_4,
			ldptv.Period_5,
			ldptv.Period_6,
			ldptv.Period_7,
			ldptv.Period_8,
			ldptv.Period_9,
			ldptv.Period_10,
			ldptv.Period_11,
			ldptv.Period_12
	from	Rulebase.AEC_LearningDelivery_PeriodisedTextValues as ldptv
				cross join (select top 1 UKPRN from Rulebase.AEC_global) as g
go

if object_id('DEDS_Rulebase.AEC_ApprenticeshipPriceEpisode','v') is not null
begin
	drop view DEDS_Rulebase.AEC_ApprenticeshipPriceEpisode
end
go

create view DEDS_Rulebase.AEC_ApprenticeshipPriceEpisode
as
	select	g.UKPRN,
			aape.LearnRefNumber,
			aape.PriceEpisodeIdentifier,
			aape.EpisodeStartDate,
			aape.EpisodeEffectiveTNPStartDate,
			aape.PriceEpisode1618FrameworkUpliftRemainingAmount,
			aape.PriceEpisode1618FrameworkUpliftTotPrevEarnings,
			aape.PriceEpisode1618FUBalValue,
			aape.PriceEpisode1618FUMonthInstValue,
			aape.PriceEpisode1618FUTotEarnings,
			aape.PriceEpisodeActualEndDateIncEPA,
			aape.PriceEpisodeActualEndDate,
			aape.PriceEpisodeAimSeqNumber,
			aape.PriceEpisodeActualInstalments,
			aape.PriceEpisodeApplic1618FrameworkUpliftCompElement,
			aape.PriceEpisodeCappedRemainingTNPAmount,
			aape.PriceEpisodeCompExemCode,
			aape.PriceEpisodeCompleted,
			aape.PriceEpisodeCompletionElement,
			aape.PriceEpisodeContractType,
			aape.PriceEpisodeCumulativePMRs,
			aape.PriceEpisodeExpectedTotalMonthlyValue,
			aape.PriceEpisodeFirstAdditionalPaymentThresholdDate,
			aape.PriceEpisodeFundLineType,
			aape.PriceEpisodeInstalmentValue,
			aape.PriceEpisodeLearnerAdditionalPaymentThresholdDate,
			aape.PriceEpisodePlannedEndDate,
			aape.PriceEpisodePlannedInstalments,
			aape.PriceEpisodePreviousEarnings,
			aape.PriceEpisodePreviousEarningsSameProvider,
			aape.PriceEpisodeRedStartDate,
			aape.PriceEpisodeRedStatusCode,
			aape.PriceEpisodeRemainingAmountWithinUpperLimit,
			aape.PriceEpisodeRemainingTNPAmount,
			aape.PriceEpisodeSecondAdditionalPaymentThresholdDate,
			aape.PriceEpisodeTotalEarnings,
			aape.PriceEpisodeTotalPMRs,
			aape.PriceEpisodeTotalTNPPrice,
			aape.PriceEpisodeUpperBandLimit,
			aape.PriceEpisodeUpperLimitAdjustment,
			aape.TNP1,
			aape.TNP2,
			aape.TNP3,
			aape.TNP4
	from	Rulebase.AEC_ApprenticeshipPriceEpisode as aape
				cross join (select top 1 UKPRN from Rulebase.AEC_global) as g
go

if object_id ('DEDS_Rulebase.AEC_ApprenticeshipPriceEpisode_Period', 'v') is not null
begin
	drop view DEDS_Rulebase.AEC_ApprenticeshipPriceEpisode_Period
end
go

create view DEDS_Rulebase.AEC_ApprenticeshipPriceEpisode_Period
as
	select	g.UKPRN,
			apep.LearnRefNumber,
			apep.PriceEpisodeIdentifier,
			apep.[Period],
			apep.PriceEpisodeApplic1618FrameworkUpliftBalancing,
			apep.PriceEpisodeApplic1618FrameworkUpliftCompletionPayment,
			apep.PriceEpisodeApplic1618FrameworkUpliftOnProgPayment,
			apep.PriceEpisodeBalancePayment,
			apep.PriceEpisodeBalanceValue,
			apep.PriceEpisodeCompletionPayment,
			apep.PriceEpisodeFirstDisadvantagePayment,
			apep.PriceEpisodeFirstEmp1618Pay,
			apep.PriceEpisodeFirstProv1618Pay,
			apep.PriceEpisodeInstalmentsThisPeriod,
			apep.PriceEpisodeLearnerAdditionalPayment,
			apep.PriceEpisodeLevyNonPayInd,
			apep.PriceEpisodeLSFCash,
			apep.PriceEpisodeOnProgPayment,
			apep.PriceEpisodeProgFundIndMinCoInvest,
			apep.PriceEpisodeProgFundIndMaxEmpCont,
			apep.PriceEpisodeSecondDisadvantagePayment,
			apep.PriceEpisodeSecondEmp1618Pay,
			apep.PriceEpisodeSecondProv1618Pay,
			apep.PriceEpisodeSFAContribPct,
			apep.PriceEpisodeESFAContribPct,
			apep.PriceEpisodeTotProgFunding
	from	Rulebase.AEC_ApprenticeshipPriceEpisode_Period as apep
				cross join (select top 1 UKPRN from Rulebase.AEC_global) as g
go

if object_id ('DEDS_Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues','v') is not null
begin
	drop view DEDS_Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues
end
go

create view DEDS_Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues
as
	select	g.UKPRN,
			apepv.LearnRefNumber,
			apepv.PriceEpisodeIdentifier,
			apepv.AttributeName,
			apepv.Period_1,
			apepv.Period_2,
			apepv.Period_3,
			apepv.Period_4,
			apepv.Period_5,
			apepv.Period_6,
			apepv.Period_7,
			apepv.Period_8,
			apepv.Period_9,
			apepv.Period_10,
			apepv.Period_11,
			apepv.Period_12
	from	Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues as apepv
				cross join (select top 1 UKPRN from Rulebase.AEC_global) as g
go

if object_id ('DEDS_Rulebase.AEC_HistoricEarningOutput','v') is not null
begin
	drop view DEDS_Rulebase.AEC_HistoricEarningOutput
end
go

create view DEDS_Rulebase.AEC_HistoricEarningOutput
as
	select	g.UKPRN,
			heo.LearnRefNumber,
			heo.AppIdentifierOutput,
			heo.AppProgCompletedInTheYearOutput,
			heo.HistoricDaysInYearOutput,
			heo.HistoricEffectiveTNPStartDateOutput,
			heo.HistoricEmpIdEndWithinYearOutput,
			heo.HistoricEmpIdStartWithinYearOutput,
			heo.HistoricFworkCodeOutput,
			heo.HistoricLearnDelProgEarliestACT2DateOutput,
			heo.HistoricLearner1618AtStartOutput,
			heo.HistoricPMRAmountOutput,
			heo.HistoricProgrammeStartDateIgnorePathwayOutput,
			heo.HistoricProgrammeStartDateMatchPathwayOutput,
			heo.HistoricProgTypeOutput,
			heo.HistoricPwayCodeOutput,
			heo.HistoricSTDCodeOutput,
			heo.HistoricTNP1Output,
			heo.HistoricTNP2Output,
			heo.HistoricTNP3Output,
			heo.HistoricTNP4Output,
			heo.HistoricTotal1618UpliftPaymentsInTheYear,
			heo.HistoricTotalProgAimPaymentsInTheYear,
			heo.HistoricULNOutput,
			heo.HistoricUptoEndDateOutput,
			heo.HistoricVirtualTNP3EndofThisYearOutput,
			heo.HistoricVirtualTNP4EndofThisYearOutput
	from	Rulebase.AEC_HistoricEarningOutput as heo
				cross join (select top 1 UKPRN from Rulebase.AEC_global) as g
go

if object_id ('DEDS_Rulebase.ESF_global','v') is not null
begin
	drop view DEDS_Rulebase.ESF_global
end
go

create view DEDS_Rulebase.ESF_global
as
	select	UKPRN,
			RulebaseVersion
	from	Rulebase.ESF_global
go

if object_id ('DEDS_Rulebase.ESF_DPOutcome','v') is not null
begin
	drop view DEDS_Rulebase.ESF_DPOutcome
end
go

create view DEDS_Rulebase.ESF_DPOutcome
as
	select	g.UKPRN,
			LearnRefNumber,
			OutCode,
			OutType,
			OutStartDate,
			OutcomeDateForProgression,
			PotentialESFProgressionType,
			ProgressionType,
			ReachedSixMonthPoint,
			ReachedThreeMonthPoint,
			ReachedTwelveMonthPoint
	from	Rulebase.ESF_DPOutcome
				cross join (select top 1 UKPRN from Rulebase.ESF_global) as g
go

if object_id ('DEDS_Rulebase.ESF_LearningDelivery','v') is not null
begin
	drop view DEDS_Rulebase.ESF_LearningDelivery
end
go

create view DEDS_Rulebase.ESF_LearningDelivery
as
	select	g.UKPRN,
			LearnRefNumber,
			AimSeqNumber,
			Achieved,
			AddProgCostElig,
			AdjustedAreaCostFactor,
			AdjustedPremiumFactor,
			AdjustedStartDate,
			AimClassification,
			AimValue,
			ApplicWeightFundRate,
			EligibleProgressionOutcomeCode,
			EligibleProgressionOutcomeType,
			EligibleProgressionOutomeStartDate,
			FundStart,
			LARSWeightedRate,
			LatestPossibleStartDate,
			LDESFEngagementStartDate,
			PotentiallyEligibleForProgression,
			ProgressionEndDate,
			[Restart],
			WeightedRateFromESOL,
			LearnDelLearnerEmpAtStart
	from	Rulebase.ESF_LearningDelivery
				cross join (select top 1 UKPRN from Rulebase.ESF_global) as g
go

if object_id ('DEDS_Rulebase.ESF_LearningDeliveryDeliverable','v') is not null
begin
	drop view DEDS_Rulebase.ESF_LearningDeliveryDeliverable
end
go

create view DEDS_Rulebase.ESF_LearningDeliveryDeliverable
as
	select	g.UKPRN,
			LearnRefNumber,
			AimSeqNumber,
			DeliverableCode,
			DeliverableUnitCost
	from	Rulebase.ESF_LearningDeliveryDeliverable
				cross join (select top 1 UKPRN from Rulebase.ESF_global) as g
go

if object_id ('DEDS_Rulebase.ESF_LearningDeliveryDeliverable_Period','v') is not null
begin
	drop view DEDS_Rulebase.ESF_LearningDeliveryDeliverable_Period
end
go

create view DEDS_Rulebase.ESF_LearningDeliveryDeliverable_Period
as
	select	g.UKPRN,
			LearnRefNumber,
			AimSeqNumber,
			DeliverableCode,
			[Period],
			AchievementEarnings,
			AdditionalProgCostEarnings,
			DeliverableVolume,
			ProgressionEarnings,
			ReportingVolume,
			StartEarnings
	from	Rulebase.ESF_LearningDeliveryDeliverable_Period
				cross join (select top 1 UKPRN from Rulebase.ESF_global) as g
go

if object_id ('DEDS_Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues','v') is not null
begin
	drop view DEDS_Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues
end
go

create view DEDS_Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues
as
	select	g.UKPRN,
			LearnRefNumber,
			AimSeqNumber,
			DeliverableCode,
			AttributeName,
			Period_1,
			Period_2,
			Period_3,
			Period_4,
			Period_5,
			Period_6,
			Period_7,
			Period_8,
			Period_9,
			Period_10,
			Period_11,
			Period_12
	from	Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues
				cross join (select top 1 UKPRN from Rulebase.ESF_global) as g
go

if object_id('DEDS_Rulebase.ESF_FundingData','v') is not null 
begin
       drop view DEDS_Rulebase.ESF_FundingData
end
go

create view DEDS_Rulebase.ESF_FundingData 
as
	select	'1920' as AcademicYear,
			(select UKPRN from Valid.LearningProvider) as UKPRN,
			ld.ConRefNumber,
			pv.LearnRefNumber,
			pv.AimSeqNumber,
			pv.DeliverableCode,
			pv.AttributeName,
			pv.Period_1,
			pv.Period_2,
			pv.Period_3,
			pv.Period_4,
			pv.Period_5,
			pv.Period_6,
			pv.Period_7,
			pv.Period_8,
			pv.Period_9,
			pv.Period_10,
			pv.Period_11,
			pv.Period_12
	from	Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues as pv
				inner join Valid.LearningDelivery as ld on ld.LearnRefNumber = pv.LearnRefNumber and ld.AimSeqNumber = pv.AimSeqNumber
	where	ld.ConRefNumber is not null
go
