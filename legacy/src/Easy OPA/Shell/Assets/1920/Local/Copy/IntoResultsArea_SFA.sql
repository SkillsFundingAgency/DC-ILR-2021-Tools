--SFA_Results_Copy
insert into [${TargetDataStore}].Rulebase.[SFA_Cases]
(
	LearnRefNumber
	,CaseData
)
select
	LearnRefNumber
	,CaseData
from
	Rulebase.[SFA_Cases]
go

insert into [${TargetDataStore}].Rulebase.[SFA_global]
(
	UKPRN, 
	CurFundYr, 
	LARSVersion, 
	OrgVersion, 
	PostcodeDisadvantageVersion,
	RulebaseVersion
)
select
	UKPRN, 
	CurFundYr, 
	LARSVersion, 
	OrgVersion, 
	PostcodeDisadvantageVersion,
	RulebaseVersion
from
	Rulebase.[SFA_global]
go

insert into [${TargetDataStore}].Rulebase.[SFA_LearningDelivery]
(
	LearnRefNumber, 
	AimSeqNumber, 
	AchApplicDate, 
	Achieved, 
	AchieveElement, 
	AchievePayElig, 
	AchievePayPctPreTrans,
	AchPayTransHeldBack, 
	ActualDaysIL, 
	ActualNumInstalm, 
	ActualNumInstalmPreTrans, 
	ActualNumInstalmTrans, 
	AdjLearnStartDate, 
	AdltLearnResp, 
	AgeAimStart, 
	AimValue, 
	AppAdjLearnStartDate, 
	AppAgeFact, 
	AppATAGTA, 
	AppCompetency, 
	AppFuncSkill, 
	AppFuncSkill1618AdjFact, 
	AppKnowl, 
	AppLearnStartDate, 
	ApplicEmpFactDate, 
	ApplicFactDate, 
	ApplicFundRateDate, 
	ApplicProgWeightFact, 
	ApplicUnweightFundRate, 
	ApplicWeightFundRate, 
	AppNonFund, 
	AreaCostFactAdj, 
	BalInstalmPreTrans, 
	BaseValueUnweight, 
	CapFactor, 
	DisUpFactAdj, 
	EmpOutcomePayElig, 
	EmpOutcomePctHeldBackTrans,
	EmpOutcomePctPreTrans, 
	EmpRespOth, 
	ESOL, 
	FullyFund, 
	FundLine, 
	FundStart, 
	LargeEmployerID, 
	LargeEmployerSFAFctr, 
	LargeEmployerStatusDate, 
	LTRCUpliftFctr, 
	NonGovCont, 
	OLASSCustody, 
	OnProgPayPctPreTrans, 
	OutstndNumOnProgInstalm, 
	OutstndNumOnProgInstalmTrans, 
	PlannedNumOnProgInstalm, 
	PlannedNumOnProgInstalmTrans, 
	PlannedTotalDaysIL, 
	PlannedTotalDaysILPreTrans, 
	PropFundRemain, 
	PropFundRemainAch, 
	PrscHEAim, 
	Residential, 
	[Restart], 
	SpecResUplift, 
	StartPropTrans, 
	ThresholdDays, 
	Traineeship, 
	Trans, 
	TrnAdjLearnStartDate, 
	TrnWorkPlaceAim, 
	TrnWorkPrepAim, 
	UnWeightedRateFromESOL, 
	UnweightedRateFromLARS, 
	WeightedRateFromESOL, 
	WeightedRateFromLARS
)
select
	LearnRefNumber, 
	AimSeqNumber, 
	AchApplicDate, 
	Achieved, 
	AchieveElement, 
	AchievePayElig, 
	AchievePayPctPreTrans,
	AchPayTransHeldBack, 
	ActualDaysIL, 
	ActualNumInstalm, 
	ActualNumInstalmPreTrans, 
	ActualNumInstalmTrans, 
	AdjLearnStartDate, 
	AdltLearnResp, 
	AgeAimStart, 
	AimValue, 
	AppAdjLearnStartDate, 
	AppAgeFact, 
	AppATAGTA, 
	AppCompetency, 
	AppFuncSkill, 
	AppFuncSkill1618AdjFact, 
	AppKnowl, 
	AppLearnStartDate, 
	ApplicEmpFactDate, 
	ApplicFactDate, 
	ApplicFundRateDate, 
	ApplicProgWeightFact, 
	ApplicUnweightFundRate, 
	ApplicWeightFundRate, 
	AppNonFund, 
	AreaCostFactAdj, 
	BalInstalmPreTrans, 
	BaseValueUnweight, 
	CapFactor, 
	DisUpFactAdj, 
	EmpOutcomePayElig, 
	EmpOutcomePctHeldBackTrans,
	EmpOutcomePctPreTrans, 
	EmpRespOth, 
	ESOL, 
	FullyFund, 
	FundLine, 
	FundStart, 
	LargeEmployerID, 
	LargeEmployerSFAFctr, 
	LargeEmployerStatusDate, 
	LTRCUpliftFctr, 
	NonGovCont, 
	OLASSCustody, 
	OnProgPayPctPreTrans, 
	OutstndNumOnProgInstalm, 
	OutstndNumOnProgInstalmTrans, 
	PlannedNumOnProgInstalm, 
	PlannedNumOnProgInstalmTrans, 
	PlannedTotalDaysIL, 
	PlannedTotalDaysILPreTrans, 
	PropFundRemain, 
	PropFundRemainAch, 
	PrscHEAim, 
	Residential, 
	[Restart], 
	SpecResUplift, 
	StartPropTrans, 
	ThresholdDays, 
	Traineeship, 
	Trans, 
	TrnAdjLearnStartDate, 
	TrnWorkPlaceAim, 
	TrnWorkPrepAim, 
	UnWeightedRateFromESOL, 
	UnweightedRateFromLARS, 
	WeightedRateFromESOL, 
	WeightedRateFromLARS
from
	Rulebase.[SFA_LearningDelivery]
go

insert into [${TargetDataStore}].Rulebase.[SFA_LearningDelivery_Period]
(
	LearnRefNumber, 
	AimSeqNumber, 
	[Period], 
	AchievePayment, 
	AchievePayPct,
	AchievePayPctTrans, 
	BalancePayment, 
	BalancePaymentUncapped, 
	BalancePct, 
	BalancePctTrans, 
	EmpOutcomePay, 
	EmpOutcomePct, 
	EmpOutcomePctTrans, 
	InstPerPeriod, 
	LearnSuppFund, 
	LearnSuppFundCash, 
	OnProgPayment, 
	OnProgPaymentUncapped, 
	OnProgPayPct, 
	OnProgPayPctTrans, 
	TransInstPerPeriod
)
select
	LearnRefNumber, 
	AimSeqNumber, 
	[Period], 
	AchievePayment, 
	AchievePayPct,
	AchievePayPctTrans, 
	BalancePayment, 
	BalancePaymentUncapped, 
	BalancePct, 
	BalancePctTrans, 
	EmpOutcomePay, 
	EmpOutcomePct, 
	EmpOutcomePctTrans, 
	InstPerPeriod, 
	LearnSuppFund, 
	LearnSuppFundCash, 
	OnProgPayment, 
	OnProgPaymentUncapped, 
	OnProgPayPct, 
	OnProgPayPctTrans, 
	TransInstPerPeriod
from
	Rulebase.[SFA_LearningDelivery_Period]
go

insert into [${TargetDataStore}].Rulebase.[SFA_LearningDelivery_PeriodisedValues]
(
	LearnRefNumber, 
	AimSeqNumber, 
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
)
select
	LearnRefNumber, 
	AimSeqNumber, 
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
from
	Rulebase.[SFA_LearningDelivery_PeriodisedValues]
go