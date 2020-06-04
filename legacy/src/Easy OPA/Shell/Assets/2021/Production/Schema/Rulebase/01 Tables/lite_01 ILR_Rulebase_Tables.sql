--Rulebase schema
if not exists(select schema_id from sys.schemas where name='Rulebase')
begin
	exec('create schema Rulebase')
end
go

if object_id('Rulebase.FM25_FM35_Cases','u') is not null
begin
	drop table Rulebase.FM25_FM35_Cases
end
go

create table Rulebase.FM25_FM35_Cases (
	LearnRefNumber varchar(12),
	CaseData xml not null
)
go

if object_id('Rulebase.FM25_FM35_global','u') is not null
begin
	drop table Rulebase.FM25_FM35_global
end
go

create table Rulebase.FM25_FM35_global (
	UKPRN int,
	RulebaseVersion varchar(10),
)
go

if object_id('Rulebase.FM25_FM35_Learner_Period','u') is not null
begin
	drop table Rulebase.FM25_FM35_Learner_Period
end
go

create table Rulebase.FM25_FM35_Learner_Period (
	LearnRefNumber varchar(12),
	[Period] int,
	LnrOnProgPay decimal(10,5),
	primary key clustered (
		LearnRefNumber asc,
		[Period] asc
	)
)
go

if object_id('Rulebase.FM25_FM35_Learner_PeriodisedValues','u') is not null
begin
	drop table Rulebase.FM25_FM35_Learner_PeriodisedValues
end
go

create table Rulebase.FM25_FM35_Learner_PeriodisedValues (
	LearnRefNumber varchar(12),
	AttributeName varchar(100) not null,
	Period_1 decimal(15,5),
	Period_2 decimal(15,5),
	Period_3 decimal(15,5),
	Period_4 decimal(15,5),
	Period_5 decimal(15,5),
	Period_6 decimal(15,5),
	Period_7 decimal(15,5),
	Period_8 decimal(15,5),
	Period_9 decimal(15,5),
	Period_10 decimal(15,5),
	Period_11 decimal(15,5),
	Period_12 decimal(15,5),
	primary key clustered (
		LearnRefNumber asc,
		AttributeName asc
	)
)
go

if object_id('Rulebase.FM25_Cases','u') is not null
begin	
	drop table Rulebase.FM25_Cases
end
go

create table Rulebase.FM25_Cases (
	UKPRN int,
	LearnRefNumber varchar(12),
	CaseData xml not null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc
	)
)
go

if object_id('Rulebase.FM25_global','u') is not null
begin
	drop table Rulebase.FM25_global
end
go

create table Rulebase.FM25_global (
	UKPRN int,
	LARSVersion varchar(50),
	OrgVersion varchar(50),
	PostcodeDisadvantageVersion varchar(50),
	RulebaseVersion varchar(10),
)
go

if object_id('Rulebase.FM25_Learner','u') is not null
begin
	drop table Rulebase.FM25_Learner
end
go

create table Rulebase.FM25_Learner (
UKPRN int,
	LearnRefNumber varchar(12),
	AcadMonthPayment int,
	AcadProg bit,
	ActualDaysILCurrYear int,
	AreaCostFact1618Hist decimal(10,5),
	Block1DisadvUpliftNew decimal(10,5),
	Block2DisadvElementsNew decimal(10,5),
	ConditionOfFundingEnglish varchar(100),
	ConditionOfFundingMaths varchar(100),
	CoreAimSeqNumber int,
	FullTimeEquiv decimal(10,5),
	FundLine varchar(100),
	LearnerActEndDate date,
	LearnerPlanEndDate date,
	LearnerStartDate date,
	NatRate decimal(10,5),
	OnProgPayment decimal(10,5),
	PlannedDaysILCurrYear int,
	ProgWeightHist decimal(10,5),
	ProgWeightNew decimal(10,5),
	PrvDisadvPropnHist decimal(10,5),
	PrvHistLrgProgPropn decimal(10,5),
	PrvRetentFactHist decimal(10,5),
	RateBand varchar(50),
	RetentNew decimal(10,5),
	StartFund bit,
	ThresholdDays int,
	TLevelStudent bit,
	PrvHistL3ProgMathEngProp decimal(10, 5),
	primary key clustered (
	UKPRN asc,
		LearnRefNumber asc
	)
)
go

if object_id('Rulebase.ALB_Cases','u') is not null
begin
	drop table Rulebase.ALB_Cases
end
go

create table Rulebase.ALB_Cases (
	LearnRefNumber varchar(12),
	CaseData xml not null
)
go

if object_id('Rulebase.ALB_global','u') is not null
begin
	drop table Rulebase.ALB_global
end
go

create table Rulebase.ALB_global (
	UKPRN int,
	LARSVersion varchar(100),
	PostcodeAreaCostVersion varchar(20),
	RulebaseVersion varchar(10),
)
go

if object_id('Rulebase.ALB_Learner_Period','u') is not null
begin
	drop table Rulebase.ALB_Learner_Period
end
go

create table Rulebase.ALB_Learner_Period (
	LearnRefNumber varchar(12),
	[Period] int,
	ALBSeqNum int,
	primary key clustered (
		LearnRefNumber asc,
		[Period] asc
	)
)
go

if object_id('Rulebase.ALB_Learner_PeriodisedValues','u') is not null
begin
	drop table Rulebase.ALB_Learner_PeriodisedValues
end
go

create table Rulebase.ALB_Learner_PeriodisedValues (
	LearnRefNumber varchar(12),
	AttributeName varchar(100) not null,
	Period_1 decimal(15,5),
	Period_2 decimal(15,5),
	Period_3 decimal(15,5),
	Period_4 decimal(15,5),
	Period_5 decimal(15,5),
	Period_6 decimal(15,5),
	Period_7 decimal(15,5),
	Period_8 decimal(15,5),
	Period_9 decimal(15,5),
	Period_10 decimal(15,5),
	Period_11 decimal(15,5),
	Period_12 decimal(15,5),
	primary key clustered (
		LearnRefNumber asc,
		AttributeName asc
	)
)
go

if object_id('Rulebase.ALB_LearningDelivery','u') is not null
begin
	drop table Rulebase.ALB_LearningDelivery
end
go

create table Rulebase.ALB_LearningDelivery (
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	AreaCostFactAdj decimal(10,5),
	WeightedRate decimal(12,5),
	PlannedNumOnProgInstalm int,
	FundStart bit,
	Achieved bit,
	ActualNumInstalm int,
	OutstndNumOnProgInstalm int,
	AreaCostInstalment decimal(12,5),
	AdvLoan bit,
	LoanBursAreaUplift bit,
	LoanBursSupp bit,
	FundLine varchar(50),
	LiabilityDate date,
	ApplicProgWeightFact varchar(1),
	ApplicFactDate date
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

if object_id('Rulebase.ALB_LearningDelivery_Period','u') is not null
begin
	drop table Rulebase.ALB_LearningDelivery_Period
end
go

create table Rulebase.ALB_LearningDelivery_Period ( 
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	[Period] int,
	AreaUpliftOnProgPayment decimal(12,5),
	AreaUpliftBalPayment decimal(12,5),
	ALBCode int,
	ALBSupportPayment decimal(12,5)
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc,
		[Period] asc
	)
)
go

if object_id('Rulebase.ALB_LearningDelivery_PeriodisedValues','u') is not null
begin
	drop table Rulebase.ALB_LearningDelivery_PeriodisedValues
end
go

create table Rulebase.ALB_LearningDelivery_PeriodisedValues (
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	AttributeName varchar(100) not null,
	Period_1 decimal(15,5),
	Period_2 decimal(15,5),
	Period_3 decimal(15,5),
	Period_4 decimal(15,5),
	Period_5 decimal(15,5),
	Period_6 decimal(15,5),
	Period_7 decimal(15,5),
	Period_8 decimal(15,5),
	Period_9 decimal(15,5),
	Period_10 decimal(15,5),
	Period_11 decimal(15,5),
	Period_12 decimal(15,5),
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc,
		AttributeName asc
	)
)
go

if object_id('Rulebase.FM35_Cases','u') is not null
begin
	drop table Rulebase.FM35_Cases
end
go

create table Rulebase.FM35_Cases (
	LearnRefNumber varchar(12),
	CaseData xml not null
)
go

if object_id('Rulebase.FM35_global','u') is not null
begin
	drop table Rulebase.FM35_global
end
go

create table Rulebase.FM35_global (
	UKPRN varchar(8),
	CurFundYr varchar(9),
	LARSVersion varchar(100),
	OrgVersion varchar(100),
	PostcodeDisadvantageVersion varchar(50),
	RulebaseVersion varchar(10),
)
go

if object_id('Rulebase.FM35_LearningDelivery','u') is not null
begin
	drop table Rulebase.FM35_LearningDelivery
end
go

create table Rulebase.FM35_LearningDelivery (
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	AchApplicDate date,
	Achieved bit,
	AchieveElement decimal(10,5),
	AchievePayElig bit,
	AchievePayPctPreTrans decimal(10,5),
	AchPayTransHeldBack decimal(10,5),
	ActualDaysIL int,
	ActualNumInstalm int,
	ActualNumInstalmPreTrans int,
	ActualNumInstalmTrans int,
	AdjLearnStartDate date,
	AdltLearnResp bit,
	AgeAimStart int,
	AimValue decimal(10,5),
	AppAdjLearnStartDate date,
	AppAgeFact decimal(10,5),
	AppATAGTA bit,
	AppCompetency bit,
	AppFuncSkill bit,
	AppFuncSkill1618AdjFact decimal(10,5),
	AppKnowl bit,
	AppLearnStartDate date,
	ApplicEmpFactDate date,
	ApplicFactDate date,
	ApplicFundRateDate date,
	ApplicProgWeightFact varchar(1),
	ApplicUnweightFundRate decimal(10,5),
	ApplicWeightFundRate decimal(10,5),
	AppNonFund bit,
	AreaCostFactAdj decimal(10,5),
	BalInstalmPreTrans int,
	BaseValueUnweight decimal(10,5),
	CapFactor decimal(10,5),
	DisUpFactAdj decimal(10,5),
	EmpOutcomePayElig bit,
	EmpOutcomePctHeldBackTrans decimal(10,5),
	EmpOutcomePctPreTrans decimal(10,5),
	EmpRespOth bit,
	ESOL bit,
	FullyFund bit,
	FundLine varchar(100),
	FundStart bit,
	LargeEmployerID int,
	LargeEmployerFM35Fctr decimal(10,5),
	LargeEmployerStatusDate date,
	LearnDelFundOrgCode varchar(50),
	LTRCUpliftFctr decimal(10,5),
	NonGovCont decimal(10,5),
	OLASSCustody bit,
	OnProgPayPctPreTrans decimal(10,5),
	OutstndNumOnProgInstalm int,
	OutstndNumOnProgInstalmTrans int,
	PlannedNumOnProgInstalm int,
	PlannedNumOnProgInstalmTrans int,
	PlannedTotalDaysIL int,
	PlannedTotalDaysILPreTrans int,
	PropFundRemain decimal(10,5),
	PropFundRemainAch decimal(10,5),
	PrscHEAim bit,
	Residential bit,
	[Restart] bit,
	SpecResUplift decimal(10,5),
	StartPropTrans decimal(10,5),
	ThresholdDays int,
	Traineeship bit,
	Trans bit,
	TrnAdjLearnStartDate date,
	TrnWorkPlaceAim bit,
	TrnWorkPrepAim bit,
	UnWeightedRateFromESOL decimal(10,5),
	UnweightedRateFromLARS decimal(10,5),
	WeightedRateFromESOL decimal(10,5),
	WeightedRateFromLARS decimal(10,5),
	ReservedUpliftFactor1 decimal(10,5),
	ReservedUpliftRate1 decimal(10,5)
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

if object_id('Rulebase.FM35_LearningDelivery_Period','u') is not null
begin
	drop table Rulebase.FM35_LearningDelivery_Period
end
go

create table Rulebase.FM35_LearningDelivery_Period (
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	[Period] int,
	AchievePayment decimal(10,5),
	AchievePayPct decimal(10,5),
	AchievePayPctTrans decimal(10,5),
	BalancePayment decimal(10,5),
	BalancePaymentUncapped decimal(10,5),
	BalancePct decimal(10,5),
	BalancePctTrans decimal(10,5),
	EmpOutcomePay decimal(10,5),
	EmpOutcomePct decimal(10,5),
	EmpOutcomePctTrans decimal(10,5),
	InstPerPeriod int,
	LearnSuppFund bit,
	LearnSuppFundCash decimal(10,5),
	OnProgPayment decimal(10,5),
	OnProgPaymentUncapped decimal(10,5),
	OnProgPayPct decimal(10,5),
	OnProgPayPctTrans decimal(10,5),
	TransInstPerPeriod int,
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc,
		[Period] asc
	)
)
go

if object_id('Rulebase.FM35_LearningDelivery_PeriodisedValues','u') is not null
begin
	drop table Rulebase.FM35_LearningDelivery_PeriodisedValues
end
go

create table Rulebase.FM35_LearningDelivery_PeriodisedValues (
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	AttributeName varchar(100) not null,
	Period_1 decimal(15,5),
	Period_2 decimal(15,5),
	Period_3 decimal(15,5),
	Period_4 decimal(15,5),
	Period_5 decimal(15,5),
	Period_6 decimal(15,5),
	Period_7 decimal(15,5),
	Period_8 decimal(15,5),
	Period_9 decimal(15,5),
	Period_10 decimal(15,5),
	Period_11 decimal(15,5),
	Period_12 decimal(15,5),
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc,
		AttributeName asc
	)
)
go

if object_id('Rulebase.TBL_Cases','u') is not null
begin
	drop table Rulebase.TBL_Cases
end
go

create table Rulebase.TBL_Cases (
	LearnRefNumber varchar(12),
	CaseData xml not null
)
go

if object_id('Rulebase.TBL_global','u') is not null
begin
	drop table Rulebase.TBL_global
end
go

create table Rulebase.TBL_global (
	UKPRN int,
	CurFundYr varchar(10),
	LARSVersion varchar(100),
	RulebaseVersion varchar(10),
)
go

if object_id('Rulebase.TBL_LearningDelivery','u') is not null
begin
	drop table Rulebase.TBL_LearningDelivery
end
go

create table Rulebase.TBL_LearningDelivery (	
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	ProgStandardStartDate date,
	FundLine varchar(50),
	MathEngAimValue	decimal(10,5),
	PlannedNumOnProgInstalm int,
	LearnSuppFundCash decimal(10,5),
	AdjProgStartDate date,
	LearnSuppFund bit,
	MathEngOnProgPayment decimal(10,5),
	InstPerPeriod int,
	SmallBusPayment decimal(10,5),
	YoungAppSecondPayment decimal(10,5),
	CoreGovContPayment decimal(10,5),
	YoungAppEligible bit,
	SmallBusEligible bit,
	MathEngOnProgPct int,
	AgeStandardStart int,
	YoungAppSecondThresholdDate date,
	EmpIdFirstDayStandard int,
	EmpIdFirstYoungAppDate	int,
	EmpIdSecondYoungAppDate int,
	EmpIdSmallBusDate int,
	YoungAppFirstThresholdDate date,
	AchApplicDate date,
	AchEligible bit,
	Achieved bit,
	AchievementApplicVal decimal(10,5),
	AchPayment decimal(10,5),
	ActualNumInstalm int,
	CombinedAdjProp decimal(10,5),
	EmpIdAchDate int,
	LearnDelDaysIL int,
	LearnDelStandardAccDaysIL int,
	LearnDelStandardPrevAccDaysIL int,
	LearnDelStandardTotalDaysIL int,
	ActualDaysIL int,
	MathEngBalPayment decimal(10,5),
	MathEngBalPct bigint,
	MathEngLSFFundStart bit,
	PlannedTotalDaysIL int,
	MathEngLSFThresholdDays int,
	OutstandNumOnProgInstalm int,
	SmallBusApplicVal decimal(10,5),
	SmallBusStatusFirstDayStandard int,
	SmallBusStatusThreshold int,
	YoungAppApplicVal decimal(10,5),
	CoreGovContCapApplicVal bigint,
	CoreGovContUncapped decimal(10,5),
	ApplicFundValDate date,
	YoungAppFirstPayment decimal(10,5),
	YoungAppPayment decimal(10,5),
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

if object_id('Rulebase.TBL_LearningDelivery_Period','u') is not null
begin
	drop table Rulebase.TBL_LearningDelivery_Period
end
go

create table Rulebase.TBL_LearningDelivery_Period (
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	[Period] int,
	AchPayment decimal(10,5),
	CoreGovContPayment decimal(10,5),
	CoreGovContUncapped decimal(10,5),
	InstPerPeriod int,
	LearnSuppFund bit,
	LearnSuppFundCash decimal(10,5),
	MathEngBalPayment decimal(10,5),
	MathEngBalPct decimal(8,5),
	MathEngOnProgPayment decimal(10,5),
	MathEngOnProgPct decimal(8,5),
	SmallBusPayment decimal(10,5),
	YoungAppFirstPayment decimal(10,5),
	YoungAppPayment decimal(10,5),
	YoungAppSecondPayment decimal(10,5),
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc,
		[Period] asc
	)
)
go

if object_id('Rulebase.TBL_LearningDelivery_PeriodisedValues','u') is not null
begin
	drop table Rulebase.TBL_LearningDelivery_PeriodisedValues
end
go

create table Rulebase.TBL_LearningDelivery_PeriodisedValues (
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	AttributeName varchar(100) not null,
	Period_1 decimal(15,5),
	Period_2 decimal(15,5),
	Period_3 decimal(15,5),
	Period_4 decimal(15,5),
	Period_5 decimal(15,5),
	Period_6 decimal(15,5),
	Period_7 decimal(15,5),
	Period_8 decimal(15,5),
	Period_9 decimal(15,5),
	Period_10 decimal(15,5),
	Period_11 decimal(15,5),
	Period_12 decimal(15,5),
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc,
		AttributeName asc
	)
)
go

if object_id('Rulebase.AEC_Cases','u') is not null
begin
	drop table Rulebase.AEC_Cases
end
go

create table Rulebase.AEC_Cases (
	LearnRefNumber varchar(12),
	CaseData xml not null
)
go

if object_id('Rulebase.AEC_global','u') is not null
begin
	drop table Rulebase.AEC_global
end
go

create table Rulebase.AEC_global (
	UKPRN int,
	LARSVersion varchar(100),
	RulebaseVersion varchar(10),
	Year varchar(4)
)
go

if object_id('Rulebase.AEC_LearningDelivery','u') is not null
begin
	drop table Rulebase.AEC_LearningDelivery
end
go

create table Rulebase.AEC_LearningDelivery (
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	LearnAimRef varchar(8),
	ActualDaysIL int,
	ActualNumInstalm int,
	AdjStartDate date,
	AgeAtProgStart int,
	AppAdjLearnStartDate date,
	AppAdjLearnStartDateMatchPathway date,
	ApplicCompDate date,
	CombinedAdjProp decimal(12,5),
	Completed bit,
	FirstIncentiveThresholdDate date,
	FundStart bit,
	LDApplic1618FrameworkUpliftTotalActEarnings decimal(12,5),
	LearnDel1618AtStart bit,
	LearnDelAccDaysILCareLeavers int,
	LearnDelAppAccDaysIL int,
	LearnDelApplicCareLeaverIncentive decimal(12,5),
	LearnDelApplicDisadvAmount decimal(12,5),
	LearnDelApplicEmp1618Incentive decimal(12,5),
	LearnDelApplicEmpDate date,
	LearnDelApplicProv1618FrameworkUplift decimal(12,5),
	LearnDelApplicProv1618Incentive decimal(12,5),
	LearnDelAppPrevAccDaysIL int,
	LearnDelDaysIL int,
	LearnDelDisadAmount decimal(12,5),
	LearnDelEligDisadvPayment bit,
	LearnDelEmpIdFirstAdditionalPaymentThreshold int,
	LearnDelEmpIdSecondAdditionalPaymentThreshold int,
	LearnDelHistDaysCareLeavers int,
	LearnDelHistDaysThisApp int,
	LearnDelHistProgEarnings decimal(12,5),
	LearnDelInitialFundLineType varchar(100),
	LearnDelLearnerAddPayThresholdDate date,
	LearnDelMathEng bit,
	LearnDelNonLevyProcured bit,
	LearnDelPrevAccDaysILCareLeavers int,
	LearnDelProgEarliestACT2Date date,
	LearnDelRedCode int,
	LearnDelRedStartDate date,
	MathEngAimValue decimal(12,5),
	OutstandNumOnProgInstalm int,
	PlannedNumOnProgInstalm int,
	PlannedTotalDaysIL int,
	SecondIncentiveThresholdDate date,
	ThresholdDays int,
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

if object_id('Rulebase.AEC_LearningDelivery_Period','u') is not null
begin
	drop table Rulebase.AEC_LearningDelivery_Period
end
go

create table Rulebase.AEC_LearningDelivery_Period (
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	[Period] int,
	DisadvFirstPayment decimal(12,5),
	DisadvSecondPayment decimal(12,5),
	FundLineType varchar(100),
	InstPerPeriod int,
	LDApplic1618FrameworkUpliftBalancingPayment decimal(12,5),
	LDApplic1618FrameworkUpliftCompletionPayment decimal(12,5),
	LDApplic1618FrameworkUpliftOnProgPayment decimal(12,5),
	LearnDelContType varchar(50),
	LearnDelFirstEmp1618Pay decimal(12,5),
	LearnDelFirstProv1618Pay decimal(12,5),
	LearnDelLearnAddPayment decimal(12,5),
	LearnDelLevyNonPayInd int,
	LearnDelSecondEmp1618Pay decimal(12,5),
	LearnDelSecondProv1618Pay decimal(12,5),
	LearnDelSEMContWaiver bit,
	LearnDelSFAContribPct decimal(12,5),
	LearnSuppFund bit,
	LearnSuppFundCash decimal(12,5),
	MathEngBalPayment decimal(12,5),
	MathEngBalPct decimal(12,5),
	MathEngOnProgPayment decimal(12,5),
	MathEngOnProgPct decimal(12,5),
	ProgrammeAimBalPayment decimal(12,5),
	ProgrammeAimCompletionPayment decimal(12,5),
	ProgrammeAimOnProgPayment decimal(12,5),
	ProgrammeAimProgFundIndMaxEmpCont decimal(12,5),
	ProgrammeAimProgFundIndMinCoInvest decimal(12,5),
	ProgrammeAimTotProgFund decimal(12,5),
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc,
		[Period] asc
	)
)
go

if object_id('Rulebase.AEC_LearningDelivery_PeriodisedValues','u') is not null
begin
	drop table Rulebase.AEC_LearningDelivery_PeriodisedValues
end
go

create table Rulebase.AEC_LearningDelivery_PeriodisedValues (
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	AttributeName varchar(100) not null,
	Period_1 decimal(15,5),
	Period_2 decimal(15,5),
	Period_3 decimal(15,5),
	Period_4 decimal(15,5),
	Period_5 decimal(15,5),
	Period_6 decimal(15,5),
	Period_7 decimal(15,5),
	Period_8 decimal(15,5),
	Period_9 decimal(15,5),
	Period_10 decimal(15,5),
	Period_11 decimal(15,5),
	Period_12 decimal(15,5),
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc,
		AttributeName asc
	)
)
go

if object_id('Rulebase.AEC_LearningDelivery_PeriodisedTextValues','u') is not null
begin
	drop table Rulebase.AEC_LearningDelivery_PeriodisedTextValues
end
go

create table Rulebase.AEC_LearningDelivery_PeriodisedTextValues (
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	AttributeName varchar(100) not null,
	Period_1 varchar(255),
	Period_2 varchar(255),
	Period_3 varchar(255),
	Period_4 varchar(255),
	Period_5 varchar(255),
	Period_6 varchar(255),
	Period_7 varchar(255),
	Period_8 varchar(255),
	Period_9 varchar(255),
	Period_10 varchar(255),
	Period_11 varchar(255),
	Period_12 varchar(255),
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc,
		AttributeName asc
	)
)
go

if object_id('Rulebase.AEC_HistoricEarningOutput','u') is not null
begin
	drop table Rulebase.AEC_HistoricEarningOutput
end
go

create table Rulebase.AEC_HistoricEarningOutput (
	LearnRefNumber varchar(12),
	AppIdentifierOutput varchar(10),
	AppProgCompletedInTheYearOutput bit,
	HistoricDaysInYearOutput int,
	HistoricEffectiveTNPStartDateOutput date,
	HistoricEmpIdEndWithinYearOutput int,
	HistoricEmpIdStartWithinYearOutput int,
	HistoricFworkCodeOutput int,
	HistoricLearnDelProgEarliestACT2DateOutput date,
	HistoricLearner1618AtStartOutput bit,
	HistoricPMRAmountOutput decimal(12,5),
	HistoricProgrammeStartDateIgnorePathwayOutput date,
	HistoricProgrammeStartDateMatchPathwayOutput date,
	HistoricProgTypeOutput int,
	HistoricPwayCodeOutput int,
	HistoricSTDCodeOutput int,
	HistoricTNP1Output decimal(12,5),
	HistoricTNP2Output decimal(12,5),
	HistoricTNP3Output decimal(12,5),
	HistoricTNP4Output decimal(12,5),
	HistoricTotal1618UpliftPaymentsInTheYear decimal(12,5),
	HistoricTotalProgAimPaymentsInTheYear decimal(12,5),
	HistoricULNOutput bigint,
	HistoricUptoEndDateOutput date,
	HistoricVirtualTNP3EndofThisYearOutput decimal(12,5),
	HistoricVirtualTNP4EndofThisYearOutput decimal(12,5)
	primary key clustered (
		LearnRefNumber asc,
		AppIdentifierOutput asc
	)
)
go

if object_id('Rulebase.AEC_ApprenticeshipPriceEpisode','u') is not null
begin
	drop table Rulebase.AEC_ApprenticeshipPriceEpisode
end
go

create table Rulebase.AEC_ApprenticeshipPriceEpisode (
	LearnRefNumber varchar(12) not null,
    PriceEpisodeIdentifier varchar(25) not null,
	EpisodeStartDate date,
	EpisodeEffectiveTNPStartDate date,
	PriceEpisode1618FrameworkUpliftRemainingAmount decimal(12,5),
	PriceEpisode1618FrameworkUpliftTotPrevEarnings decimal(12,5),
	PriceEpisode1618FUBalValue decimal(12,5),
	PriceEpisode1618FUMonthInstValue decimal(12,5),
	PriceEpisode1618FUTotEarnings decimal(12,5),
	PriceEpisodeActualEndDate date,
	PriceEpisodeActualEndDateIncEPA date,
	PriceEpisodeAgreeId varchar(6),
	PriceEpisodeAimSeqNumber bigint,
	PriceEpisodeActualInstalments int,
	PriceEpisodeApplic1618FrameworkUpliftCompElement decimal(12,5),
	PriceEpisodeCappedRemainingTNPAmount decimal(12,5),
	PriceEpisodeCompExemCode int,
	PriceEpisodeCompleted bit,
	PriceEpisodeCompletionElement decimal(12,5),
	PriceEpisodeContractType varchar(50),
	PriceEpisodeCumulativePMRs decimal(12,5),
	PriceEpisodeExpectedTotalMonthlyValue decimal(12,5),
	PriceEpisodeFirstAdditionalPaymentThresholdDate date,
	PriceEpisodeFundLineType varchar(100),
	PriceEpisodeInstalmentValue decimal(12,5),
	PriceEpisodeLearnerAdditionalPaymentThresholdDate date,
	PriceEpisodePlannedEndDate date,
	PriceEpisodePlannedInstalments int,
	PriceEpisodePreviousEarnings decimal(12,5),
	PriceEpisodePreviousEarningsSameProvider decimal(12,5),
	PriceEpisodeRedStartDate date,
	PriceEpisodeRedStatusCode int,
	PriceEpisodeRemainingAmountWithinUpperLimit decimal(12,5),
	PriceEpisodeRemainingTNPAmount decimal(12,5),
	PriceEpisodeSecondAdditionalPaymentThresholdDate date,
	PriceEpisodeTotalEarnings decimal(12,5),
	PriceEpisodeTotalPMRs decimal(12,5),
	PriceEpisodeTotalTNPPrice decimal(12,5),
	PriceEpisodeUpperBandLimit decimal(12,5),
	PriceEpisodeUpperLimitAdjustment decimal(12,5),
	TNP1 decimal(12,5),
	TNP2 decimal(12,5),
	TNP3 decimal(12,5),
	TNP4 decimal(12,5),
	primary key (
		LearnRefNumber,
		PriceEpisodeIdentifier
	)
)
go

if object_id('Rulebase.AEC_ApprenticeshipPriceEpisode_Period','u') is not null
begin
	drop table Rulebase.AEC_ApprenticeshipPriceEpisode_Period
end
go

create table Rulebase.AEC_ApprenticeshipPriceEpisode_Period (
	LearnRefNumber varchar(12) not null,
	PriceEpisodeIdentifier varchar(25) not null,
	[Period] int not null,
	PriceEpisodeApplic1618FrameworkUpliftBalancing decimal(12,5),
	PriceEpisodeApplic1618FrameworkUpliftCompletionPayment decimal(12,5),
	PriceEpisodeApplic1618FrameworkUpliftOnProgPayment decimal(12,5),
	PriceEpisodeBalancePayment decimal(12,5),
	PriceEpisodeBalanceValue decimal(12,5),
	PriceEpisodeCompletionPayment decimal(12,5),
	PriceEpisodeFirstDisadvantagePayment decimal(12,5),
	PriceEpisodeFirstEmp1618Pay decimal(12,5),
	PriceEpisodeFirstProv1618Pay decimal(12,5),
	PriceEpisodeInstalmentsThisPeriod int,
	PriceEpisodeLearnerAdditionalPayment decimal(12,5),
	PriceEpisodeLevyNonPayInd int,
	PriceEpisodeLSFCash decimal(12,5),
	PriceEpisodeOnProgPayment decimal(12,5),
	PriceEpisodeProgFundIndMaxEmpCont decimal(12,5),
	PriceEpisodeProgFundIndMinCoInvest decimal(12,5),
	PriceEpisodeSecondDisadvantagePayment decimal(12,5),
	PriceEpisodeSecondEmp1618Pay decimal(12,5),
	PriceEpisodeSecondProv1618Pay decimal(12,5),
	PriceEpisodeSFAContribPct decimal(12,5),
	PriceEpisodeTotProgFunding decimal(12,5),
	primary key clustered (
		LearnRefNumber asc,
		PriceEpisodeIdentifier asc,
		[Period] asc
	)
)
go

if object_id('Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues','u') is not null
begin
	drop table Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues
end
go

create table Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues (
	LearnRefNumber varchar(12),
	PriceEpisodeIdentifier varchar(25),
	AttributeName varchar(100) not null,
	Period_1 decimal(15,5),
	Period_2 decimal(15,5),
	Period_3 decimal(15,5),
	Period_4 decimal(15,5),
	Period_5 decimal(15,5),
	Period_6 decimal(15,5),
	Period_7 decimal(15,5),
	Period_8 decimal(15,5),
	Period_9 decimal(15,5),
	Period_10 decimal(15,5),
	Period_11 decimal(15,5),
	Period_12 decimal(15,5),
	primary key clustered (
		LearnRefNumber asc,
		PriceEpisodeIdentifier asc,
		AttributeName asc
	)
)
go
