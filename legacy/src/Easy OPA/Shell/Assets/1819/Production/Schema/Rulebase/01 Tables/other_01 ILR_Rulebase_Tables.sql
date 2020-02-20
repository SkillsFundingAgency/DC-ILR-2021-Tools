--Rulebase schema
if not exists(select schema_id from sys.schemas where name='Rulebase')
begin
	exec('create schema Rulebase')
end
go

if object_id('Rulebase.VAL_Cases','u') is not null
begin
	drop table Rulebase.VAL_Cases
end
go

create table Rulebase.VAL_Cases
(
	Learner_Id int primary key,
	CaseData xml not null
)
go

if object_id('Rulebase.VAL_global','u') is not null
begin
	drop table Rulebase.VAL_global
end
go

create table Rulebase.VAL_global (
	UKPRN int,
	EmployerVersion varchar(50),
	LARSVersion varchar(50),
	OrgVersion varchar(50),
	PostcodeVersion varchar(50),
	RulebaseVersion varchar(10),
)
go

if object_id('Rulebase.VAL_Learner', 'u') is not null
begin
	drop table Rulebase.VAL_Learner
end
go

create table Rulebase.VAL_Learner (
	LearnRefNumber varchar(12)
)
go

if object_id('Rulebase.VAL_LearningDelivery', 'u') is not null
begin
	drop table Rulebase.VAL_LearningDelivery
end
go

create table Rulebase.VAL_LearningDelivery (
	AimSeqNumber int
)
go

if object_id('Rulebase.VAL_ValidationError','u') is not null
begin
	drop table Rulebase.VAL_ValidationError
end
go

create table Rulebase.VAL_ValidationError (
	AimSeqNumber bigint,
	ErrorString varchar(2000),
	FieldValues varchar(2000),
	LearnRefNumber varchar(100),
	RuleId varchar(50)
)
go

if object_id('Rulebase.VALDP_Cases','u') is not null
begin
	drop table Rulebase.VALDP_Cases
end
go

create table Rulebase.VALDP_Cases
(
	LearnerDestinationAndProgression_Id int primary key,
	CaseData xml not null
)
go

if object_id('Rulebase.VALDP_global','u') is not null
begin
	drop table Rulebase.VALDP_global
end
go

create table Rulebase.VALDP_global (
	UKPRN int,
	OrgVersion varchar(50),
	RulebaseVersion varchar(10),
	ULNVersion varchar(50)
)
go

if object_id('Rulebase.VALDP_ValidationError','u') is not null
begin
	drop table Rulebase.VALDP_ValidationError
end
go

create table Rulebase.VALDP_ValidationError (
	ErrorString varchar(2000),
	FieldValues varchar(2000),
	LearnRefNumber varchar(100),
	RuleId varchar(50)
)
go

if object_id('Rulebase.ESFVAL_Cases','u') is not null
begin
	drop table Rulebase.ESFVAL_Cases
end
go

create table Rulebase.ESFVAL_Cases (
	Learner_Id int primary key,
	CaseData xml not null
)
go

if object_id('Rulebase.ESFVAL_global','u') is not null
begin
	drop table Rulebase.ESFVAL_global
end
go

create table Rulebase.ESFVAL_global (
	UKPRN int,
	RulebaseVersion varchar(10),
)
go

if object_id('Rulebase.ESFVAL_ValidationError','u') is not null
begin
	drop table Rulebase.ESFVAL_ValidationError
end
go

create table Rulebase.ESFVAL_ValidationError (
	AimSeqNumber bigint,
	ErrorString varchar(2000),
	FieldValues varchar(2000),
	LearnRefNumber varchar(100),
	RuleId varchar(50)
)
go

if object_id('Rulebase.VALFD_ValidationError','u') is not null
begin
	drop table Rulebase.VALFD_ValidationError
end
go

create table Rulebase.VALFD_ValidationError (
	AimSeqNumber bigint null,
	ErrorString varchar(2000) null,
	FieldValues varchar(2000) null,
	LearnRefNumber varchar(100) null,
	RuleId varchar(50) null
)
go

if object_id('Rulebase.DV_Cases','u') is not null
begin
	drop table Rulebase.DV_Cases
end
go

create table Rulebase.DV_Cases (
	LearnRefNumber varchar(12),
	CaseData xml not null
)
go

if object_id('Rulebase.DV_global','u') is not null
begin
	drop table Rulebase.DV_global
end
go

create table Rulebase.DV_global (
	UKPRN int,
	RulebaseVersion varchar(10),
)
go

if object_id('Rulebase.DV_Learner','u') is not null
begin
	drop table Rulebase.DV_Learner
end
go

create table Rulebase.DV_Learner (
	LearnRefNumber varchar(12),
	Learn_3rdSector int,
	Learn_Active int,
	Learn_ActiveJan int,
	Learn_ActiveNov int,
	Learn_ActiveOct int,
	Learn_Age31Aug int,
	Learn_BasicSkill int,
	Learn_EmpStatFDL int,
	Learn_EmpStatPrior int,
	Learn_FirstFullLevel2 int,
	Learn_FirstFullLevel2Ach int,
	Learn_FirstFullLevel3 int,
	Learn_FirstFullLevel3Ach int,
	Learn_FullLevel2 int,
	Learn_FullLevel2Ach int,
	Learn_FullLevel3 int,
	Learn_FullLevel3Ach int,
	Learn_FundAgency int,
	Learn_FundingSource int,
	Learn_FundPrvYr int,
	Learn_ILAcMonth1 int,
	Learn_ILAcMonth10 int,
	Learn_ILAcMonth11 int,
	Learn_ILAcMonth12 int,
	Learn_ILAcMonth2 int,
	Learn_ILAcMonth3 int,
	Learn_ILAcMonth4 int,
	Learn_ILAcMonth5 int,
	Learn_ILAcMonth6 int,
	Learn_ILAcMonth7 int,
	Learn_ILAcMonth8 int,
	Learn_ILAcMonth9 int,
	Learn_ILCurrAcYr int,
	Learn_LargeEmployer int,
	Learn_LenEmp int,
	Learn_LenUnemp int,
	Learn_LrnAimRecords int,
	Learn_ModeAttPlanHrs int,
	Learn_NotionLev int,
	Learn_NotionLevV2 int,
	Learn_OLASS int,
	Learn_PrefMethContact int,
	Learn_PrimaryLLDD int,
	Learn_PriorEducationStatus int,
	Learn_UnempBenFDL int,
	Learn_UnempBenPrior int,
	Learn_Uplift1516EFA decimal(6,5),
	Learn_Uplift1516SFA decimal(6,5),
	primary key clustered (
		LearnRefNumber asc
	)
)
go

if object_id('Rulebase.DV_LearningDelivery','u') is not null
begin
	drop table Rulebase.DV_LearningDelivery
end
go

create table Rulebase.DV_LearningDelivery (
	LearnRefNumber varchar(12),
	AimSeqNumber int,
	LearnDel_AccToApp int,
	LearnDel_AccToAppEmpDate date,
	LearnDel_AccToAppEmpStat int,
	LearnDel_AchFullLevel2Pct decimal(5,2),
	LearnDel_AchFullLevel3Pct decimal(5,2),
	LearnDel_Achieved int,
	LearnDel_AchievedIY int,
	LearnDel_AcMonthYTD varchar(2),
	LearnDel_ActDaysILAfterCurrAcYr int,
	LearnDel_ActDaysILCurrAcYr int,
	LearnDel_ActEndDateOnAfterJan1 int,
	LearnDel_ActEndDateOnAfterNov1 int,
	LearnDel_ActEndDateOnAfterOct1 int,
	LearnDel_ActiveIY int,
	LearnDel_ActiveJan int,
	LearnDel_ActiveNov int,
	LearnDel_ActiveOct int,
	LearnDel_ActTotalDaysIL int,
	LearnDel_AdvLoan int,
	LearnDel_AgeAimOrigStart int,
	LearnDel_AgeAtStart int,
	LearnDel_App int,
	LearnDel_App1618Fund int,
	LearnDel_App1925Fund int,
	LearnDel_AppAimType int,
	LearnDel_AppKnowl int,
	LearnDel_AppMainAim int,
	LearnDel_AppNonFund int,
	LearnDel_BasicSkills int,
	LearnDel_BasicSkillsParticipation int,
	LearnDel_BasicSkillsType int,
	LearnDel_CarryIn int,
	LearnDel_ClassRm int,
	LearnDel_CompAimApp int,
	LearnDel_CompAimProg int,
	LearnDel_Completed int,
	LearnDel_CompletedIY int,
	LearnDel_CompleteFullLevel2Pct decimal(5,2),
	LearnDel_CompleteFullLevel3Pct decimal(5,2),
	LearnDel_EFACoreAim int,
	LearnDel_Emp6MonthAimStart int,
	LearnDel_Emp6MonthProgStart int,
	LearnDel_EmpDateBeforeFDL date,
	LearnDel_EmpDatePriorFDL date,
	LearnDel_EmpID int,
	LearnDel_Employed int,
	LearnDel_EmpStatFDL int,
	LearnDel_EmpStatPrior int,
	LearnDel_EmpStatPriorFDL int,
	LearnDel_EnhanAppFund int,
	LearnDel_FullLevel2AchPct decimal(5,2),
	LearnDel_FullLevel2ContPct decimal(5,2),
	LearnDel_FullLevel3AchPct decimal(5,2),
	LearnDel_FullLevel3ContPct decimal(5,2),
	LearnDel_FuncSkills int,
	LearnDel_FundAgency int,
	LearnDel_FundingLineType varchar(100),
	LearnDel_FundingSource int,
	LearnDel_FundPrvYr int,
	LearnDel_FundStart int,
	LearnDel_GCE int,
	LearnDel_GCSE int,
	LearnDel_ILAcMonth1 int,
	LearnDel_ILAcMonth10 int,
	LearnDel_ILAcMonth11 int,
	LearnDel_ILAcMonth12 int,
	LearnDel_ILAcMonth2 int,
	LearnDel_ILAcMonth3 int,
	LearnDel_ILAcMonth4 int,
	LearnDel_ILAcMonth5 int,
	LearnDel_ILAcMonth6 int,
	LearnDel_ILAcMonth7 int,
	LearnDel_ILAcMonth8 int,
	LearnDel_ILAcMonth9 int,
	LearnDel_ILCurrAcYr int,
	LearnDel_IYActEndDate date,
	LearnDel_IYPlanEndDate date,
	LearnDel_IYStartDate date,
	LearnDel_KeySkills int,
	LearnDel_LargeEmpDiscountId int,
	LearnDel_LargeEmployer int,
	LearnDel_LastEmpDate date,
	LearnDel_LeaveMonth int,
	LearnDel_LenEmp int,
	LearnDel_LenUnemp int,
	LearnDel_LoanBursFund int,
	LearnDel_NotionLevel int,
	LearnDel_NotionLevelV2 int,
	LearnDel_NumHEDatasets int,
	LearnDel_OccupAim int,
	LearnDel_OLASS int,
	LearnDel_OLASSCom int,
	LearnDel_OLASSCus int,
	LearnDel_OrigStartDate date,
	LearnDel_PlanDaysILAfterCurrAcYr int,
	LearnDel_PlanDaysILCurrAcYr int,
	LearnDel_PlanEndBeforeAug1 int,
	LearnDel_PlanEndOnAfterJan1 int,
	LearnDel_PlanEndOnAfterNov1 int,
	LearnDel_PlanEndOnAfterOct1 int,
	LearnDel_PlanTotalDaysIL int,
	LearnDel_PriorEducationStatus int,
	LearnDel_Prog int,
	LearnDel_ProgAimAch int,
	LearnDel_ProgAimApp int,
	LearnDel_ProgCompleted int,
	LearnDel_ProgCompletedIY int,
	LearnDel_ProgStartDate date,
	LearnDel_QCF int,
	LearnDel_QCFCert int,
	LearnDel_QCFDipl int,
	LearnDel_QCFType int,
	LearnDel_RegAim int,
	LearnDel_SecSubAreaTier1 varchar(3),
	LearnDel_SecSubAreaTier2 varchar(5),
	LearnDel_SFAApproved int,
	LearnDel_SourceFundEFA int,
	LearnDel_SourceFundSFA int,
	LearnDel_StartBeforeApr1 int,
	LearnDel_StartBeforeAug1 int,
	LearnDel_StartBeforeDec1 int,
	LearnDel_StartBeforeFeb1 int,
	LearnDel_StartBeforeJan1 int,
	LearnDel_StartBeforeJun1 int,
	LearnDel_StartBeforeMar1 int,
	LearnDel_StartBeforeMay1 int,
	LearnDel_StartBeforeNov1 int,
	LearnDel_StartBeforeOct1 int,
	LearnDel_StartBeforeSep1 int,
	LearnDel_StartIY int,
	LearnDel_StartJan1 int,
	LearnDel_StartMonth int,
	LearnDel_StartNov1 int,
	LearnDel_StartOct1 int,
	LearnDel_SuccRateStat int,
	LearnDel_TrainAimType int,
	LearnDel_TransferDiffProvider int,
	LearnDel_TransferDiffProviderGovStrat int,
	LearnDel_TransferProvider int,
	LearnDel_UfIProv int,
	LearnDel_UnempBenFDL int,
	LearnDel_UnempBenPrior int,
	LearnDel_Withdrawn int,
	LearnDel_WorkplaceLocPostcode varchar(8),
	Prog_AccToApp int,
	Prog_Achieved int,
	Prog_AchievedIY int,
	Prog_ActEndDate date,
	Prog_ActiveIY int,
	Prog_AgeAtStart int,
	Prog_EarliestAim int,
	Prog_Employed int,
	Prog_FundPrvYr int,
	Prog_ILCurrAcYear int,
	Prog_LatestAim int,
	Prog_SourceFundEFA int,
	Prog_SourceFundSFA int
	primary key clustered (
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go
