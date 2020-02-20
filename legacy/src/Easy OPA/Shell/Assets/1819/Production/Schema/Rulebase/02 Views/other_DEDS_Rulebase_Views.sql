if not exists (select * from sys.schemas where name = 'DEDS_Rulebase')
begin
	exec ('create schema DEDS_Rulebase');
end
go

if object_id ('DEDS_Rulebase.VAL_ValidationError', 'v') is not null
begin
	drop view DEDS_Rulebase.VAL_ValidationError
end
go

create view DEDS_Rulebase.VAL_ValidationError
as
	select	g.UKPRN,
			ve.AimSeqNumber,
			ve.ErrorString,
			ve.FieldValues,
			ve.LearnRefNumber,
			ve.RuleId
	from	Rulebase.VAL_ValidationError as ve
				cross join (select top 1 UKPRN from Rulebase.VAL_global) as g
go

if object_id ('DEDS_Rulebase.VAL_global','v') is not null
begin
	drop view DEDS_Rulebase.VAL_global
end
go

create view DEDS_Rulebase.VAL_global
as
	select	UKPRN,
			EmployerVersion,
			LARSVersion,
			OrgVersion,
			PostcodeVersion,
			RulebaseVersion
	from	Rulebase.VAL_global
go

if object_id ('DEDS_Rulebase.VAL_LearningDelivery', 'v') is not null
begin 
	drop view DEDS_Rulebase.VAL_LearningDelivery
end
go

create view DEDS_Rulebase.VAL_LearningDelivery
as
	select	g.UKPRN,
			vld.AimSeqNumber
	from	Rulebase.VAL_LearningDelivery as vld
				cross join (select top 1 UKPRN from Rulebase.VAL_global) as g
go

if object_id ('DEDS_Rulebase.VAL_Learner', 'v') is not null
begin
	drop view DEDS_Rulebase.VAL_Learner
end
go

create view DEDS_Rulebase.VAL_Learner
as
	select	g.UKPRN,
			vl.LearnRefNumber
	from	Rulebase.VAL_Learner as vl
				cross join (select top 1 UKPRN from Rulebase.VAL_global) as g
go

if object_id ('DEDS_Rulebase.VALFD_ValidationError', 'v') is not null
begin
	drop view DEDS_Rulebase.VALFD_ValidationError
end
go

create view DEDS_Rulebase.VALFD_ValidationError
as
	select	g.UKPRN,
			ve.AimSeqNumber,
			ve.ErrorString,
			ve.FieldValues,
			ve.LearnRefNumber,
			ve.RuleId
	from	Rulebase.VALFD_ValidationError as ve
				cross join (SELECT TOP(1) UKPRN FROM Valid.LearningProvider) as g
go

if object_id ('DEDS_Rulebase.VALDP_ValidationError', 'v') is not null
begin
	drop view DEDS_Rulebase.VALDP_ValidationError
end
go

create view DEDS_Rulebase.VALDP_ValidationError
as
	select	g.UKPRN,
			ve.ErrorString,
			ve.FieldValues,
			ve.LearnRefNumber,
			ve.RuleId
	from	Rulebase.VALDP_ValidationError as ve
				cross join (SELECT TOP(1) UKPRN FROM Valid.LearningProvider) as g
go

if object_id ('DEDS_Rulebase.VALDP_global', 'v') is not null
begin
	drop view DEDS_Rulebase.VALDP_global
end
go

create view DEDS_Rulebase.VALDP_global
as
	select	UKPRN,
			OrgVersion,
			RulebaseVersion,
			ULNVersion
	from	Rulebase.VALDP_global
go

-- ESF validation views
if object_id ('DEDS_Rulebase.ESFVAL_global','v') is not null
begin
	drop view DEDS_Rulebase.ESFVAL_global
end
go

create view DEDS_Rulebase.ESFVAL_global
as
	select	UKPRN,
			RulebaseVersion
	from	Rulebase.ESFVAL_global
go

if object_id ('DEDS_Rulebase.ESFVAL_ValidationError', 'v') is not null
begin
	drop view DEDS_Rulebase.ESFVAL_ValidationError
end
go

create view DEDS_Rulebase.ESFVAL_ValidationError
as
	select	g.UKPRN,
			ve.AimSeqNumber,
			ve.ErrorString,
			ve.FieldValues,
			ve.LearnRefNumber,
			ve.RuleId
	from	Rulebase.ESFVAL_ValidationError as ve
				cross join (SELECT TOP(1) UKPRN FROM Rulebase.ESFVAL_global) as g
go

if object_id('DEDS_Rulebase.DV_global','v') is not null
begin
	drop view DEDS_Rulebase.DV_global
end
go

create view DEDS_Rulebase.DV_global
as
	select	UKPRN,
			RulebaseVersion
	from	Rulebase.DV_global
go

if object_id('DEDS_Rulebase.DV_Learner','v') is not null
begin
	drop view DEDS_Rulebase.DV_Learner
end
go

create view DEDS_Rulebase.DV_Learner
as
	select	g.UKPRN,
			l.LearnRefNumber,
			l.Learn_3rdSector,
			l.Learn_Active,
			l.Learn_ActiveJan,
			l.Learn_ActiveNov,
			l.Learn_ActiveOct,
			l.Learn_Age31Aug,
			l.Learn_BasicSkill,
			l.Learn_EmpStatFDL,
			l.Learn_EmpStatPrior,
			l.Learn_FirstFullLevel2,
			l.Learn_FirstFullLevel2Ach,
			l.Learn_FirstFullLevel3,
			l.Learn_FirstFullLevel3Ach,
			l.Learn_FullLevel2,
			l.Learn_FullLevel2Ach,
			l.Learn_FullLevel3,
			l.Learn_FullLevel3Ach,
			l.Learn_FundAgency,
			l.Learn_FundingSource,
			l.Learn_FundPrvYr,
			l.Learn_ILAcMonth1,
			l.Learn_ILAcMonth10,
			l.Learn_ILAcMonth11,
			l.Learn_ILAcMonth12,
			l.Learn_ILAcMonth2,
			l.Learn_ILAcMonth3,
			l.Learn_ILAcMonth4,
			l.Learn_ILAcMonth5,
			l.Learn_ILAcMonth6,
			l.Learn_ILAcMonth7,
			l.Learn_ILAcMonth8,
			l.Learn_ILAcMonth9,
			l.Learn_ILCurrAcYr,
			l.Learn_LargeEmployer,
			l.Learn_LenEmp,
			l.Learn_LenUnemp,
			l.Learn_LrnAimRecords,
			l.Learn_ModeAttPlanHrs,
			l.Learn_NotionLev,
			l.Learn_NotionLevV2,
			l.Learn_OLASS,
			l.Learn_PrefMethContact,
			l.Learn_PrimaryLLDD,
			l.Learn_PriorEducationStatus,
			l.Learn_UnempBenFDL,
			l.Learn_UnempBenPrior,
			l.Learn_Uplift1516EFA,
			l.Learn_Uplift1516SFA
	from	Rulebase.DV_Learner as l
				cross join (select top 1 UKPRN from Rulebase.DV_global) as g
go

if object_id('DEDS_Rulebase.DV_LearningDelivery','v') is not null
begin
	drop view DEDS_Rulebase.DV_LearningDelivery
end
go

create view DEDS_Rulebase.DV_LearningDelivery
as
	select	g.UKPRN,
			ld.LearnRefNumber,
			ld.AimSeqNumber,
			ld.LearnDel_AccToApp,
			ld.LearnDel_AccToAppEmpDate,
			ld.LearnDel_AccToAppEmpStat,
			ld.LearnDel_AchFullLevel2Pct,
			ld.LearnDel_AchFullLevel3Pct,
			ld.LearnDel_Achieved,
			ld.LearnDel_AchievedIY,
			ld.LearnDel_AcMonthYTD,
			ld.LearnDel_ActDaysILAfterCurrAcYr,
			ld.LearnDel_ActDaysILCurrAcYr,
			ld.LearnDel_ActEndDateOnAfterJan1,
			ld.LearnDel_ActEndDateOnAfterNov1,
			ld.LearnDel_ActEndDateOnAfterOct1,
			ld.LearnDel_ActiveIY,
			ld.LearnDel_ActiveJan,
			ld.LearnDel_ActiveNov,
			ld.LearnDel_ActiveOct,
			ld.LearnDel_ActTotalDaysIL,
			ld.LearnDel_AdvLoan,
			ld.LearnDel_AgeAimOrigStart,
			ld.LearnDel_AgeAtStart,
			ld.LearnDel_App,
			ld.LearnDel_App1618Fund,
			ld.LearnDel_App1925Fund,
			ld.LearnDel_AppAimType,
			ld.LearnDel_AppKnowl,
			ld.LearnDel_AppMainAim,
			ld.LearnDel_AppNonFund,
			ld.LearnDel_BasicSkills,
			ld.LearnDel_BasicSkillsParticipation,
			ld.LearnDel_BasicSkillsType,
			ld.LearnDel_CarryIn,
			ld.LearnDel_ClassRm,
			ld.LearnDel_CompAimApp,
			ld.LearnDel_CompAimProg,
			ld.LearnDel_Completed,
			ld.LearnDel_CompletedIY,
			ld.LearnDel_CompleteFullLevel2Pct,
			ld.LearnDel_CompleteFullLevel3Pct,
			ld.LearnDel_EFACoreAim,
			ld.LearnDel_Emp6MonthAimStart,
			ld.LearnDel_Emp6MonthProgStart,
			ld.LearnDel_EmpDateBeforeFDL,
			ld.LearnDel_EmpDatePriorFDL,
			ld.LearnDel_EmpID,
			ld.LearnDel_Employed,
			ld.LearnDel_EmpStatFDL,
			ld.LearnDel_EmpStatPrior,
			ld.LearnDel_EmpStatPriorFDL,
			ld.LearnDel_EnhanAppFund,
			ld.LearnDel_FullLevel2AchPct,
			ld.LearnDel_FullLevel2ContPct,
			ld.LearnDel_FullLevel3AchPct,
			ld.LearnDel_FullLevel3ContPct,
			ld.LearnDel_FuncSkills,
			ld.LearnDel_FundAgency,
			ld.LearnDel_FundingLineType,
			ld.LearnDel_FundingSource,
			ld.LearnDel_FundPrvYr,
			ld.LearnDel_FundStart,
			ld.LearnDel_GCE,
			ld.LearnDel_GCSE,
			ld.LearnDel_ILAcMonth1,
			ld.LearnDel_ILAcMonth10,
			ld.LearnDel_ILAcMonth11,
			ld.LearnDel_ILAcMonth12,
			ld.LearnDel_ILAcMonth2,
			ld.LearnDel_ILAcMonth3,
			ld.LearnDel_ILAcMonth4,
			ld.LearnDel_ILAcMonth5,
			ld.LearnDel_ILAcMonth6,
			ld.LearnDel_ILAcMonth7,
			ld.LearnDel_ILAcMonth8,
			ld.LearnDel_ILAcMonth9,
			ld.LearnDel_ILCurrAcYr,
			ld.LearnDel_IYActEndDate,
			ld.LearnDel_IYPlanEndDate,
			ld.LearnDel_IYStartDate,
			ld.LearnDel_KeySkills,
			ld.LearnDel_LargeEmpDiscountId,
			ld.LearnDel_LargeEmployer,
			ld.LearnDel_LastEmpDate,
			ld.LearnDel_LeaveMonth,
			ld.LearnDel_LenEmp,
			ld.LearnDel_LenUnemp,
			ld.LearnDel_LoanBursFund,
			ld.LearnDel_NotionLevel,
			ld.LearnDel_NotionLevelV2,
			ld.LearnDel_NumHEDatasets,
			ld.LearnDel_OccupAim,
			ld.LearnDel_OLASS,
			ld.LearnDel_OLASSCom,
			ld.LearnDel_OLASSCus,
			ld.LearnDel_OrigStartDate,
			ld.LearnDel_PlanDaysILAfterCurrAcYr,
			ld.LearnDel_PlanDaysILCurrAcYr,
			ld.LearnDel_PlanEndBeforeAug1,
			ld.LearnDel_PlanEndOnAfterJan1,
			ld.LearnDel_PlanEndOnAfterNov1,
			ld.LearnDel_PlanEndOnAfterOct1,
			ld.LearnDel_PlanTotalDaysIL,
			ld.LearnDel_PriorEducationStatus,
			ld.LearnDel_Prog,
			ld.LearnDel_ProgAimAch,
			ld.LearnDel_ProgAimApp,
			ld.LearnDel_ProgCompleted,
			ld.LearnDel_ProgCompletedIY,
			ld.LearnDel_ProgStartDate,
			ld.LearnDel_QCF,
			ld.LearnDel_QCFCert,
			ld.LearnDel_QCFDipl,
			ld.LearnDel_QCFType,
			ld.LearnDel_RegAim,
			ld.LearnDel_SecSubAreaTier1,
			ld.LearnDel_SecSubAreaTier2,
			ld.LearnDel_SFAApproved,
			ld.LearnDel_SourceFundEFA,
			ld.LearnDel_SourceFundSFA,
			ld.LearnDel_StartBeforeApr1,
			ld.LearnDel_StartBeforeAug1,
			ld.LearnDel_StartBeforeDec1,
			ld.LearnDel_StartBeforeFeb1,
			ld.LearnDel_StartBeforeJan1,
			ld.LearnDel_StartBeforeJun1,
			ld.LearnDel_StartBeforeMar1,
			ld.LearnDel_StartBeforeMay1,
			ld.LearnDel_StartBeforeNov1,
			ld.LearnDel_StartBeforeOct1,
			ld.LearnDel_StartBeforeSep1,
			ld.LearnDel_StartIY,
			ld.LearnDel_StartJan1,
			ld.LearnDel_StartMonth,
			ld.LearnDel_StartNov1,
			ld.LearnDel_StartOct1,
			ld.LearnDel_SuccRateStat,
			ld.LearnDel_TrainAimType,
			ld.LearnDel_TransferDiffProvider,
			ld.LearnDel_TransferDiffProviderGovStrat,
			ld.LearnDel_TransferProvider,
			ld.LearnDel_UfIProv,
			ld.LearnDel_UnempBenFDL,
			ld.LearnDel_UnempBenPrior,
			ld.LearnDel_Withdrawn,
			ld.LearnDel_WorkplaceLocPostcode,
			ld.Prog_AccToApp,
			ld.Prog_Achieved,
			ld.Prog_AchievedIY,
			ld.Prog_ActEndDate,
			ld.Prog_ActiveIY,
			ld.Prog_AgeAtStart,
			ld.Prog_EarliestAim,
			ld.Prog_Employed,
			ld.Prog_FundPrvYr,
			ld.Prog_ILCurrAcYear,
			ld.Prog_LatestAim,
			ld.Prog_SourceFundEFA,
			ld.Prog_SourceFundSFA
	from	Rulebase.DV_LearningDelivery as ld
				cross join (select top 1 UKPRN from Rulebase.DV_global) as g
go
