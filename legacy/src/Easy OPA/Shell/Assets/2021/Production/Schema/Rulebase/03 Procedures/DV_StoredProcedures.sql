if object_id('[Rulebase].[DV_Get_Cases]','p') is not null
begin
	drop procedure [Rulebase].[DV_Get_Cases]
end
go

create procedure [Rulebase].[DV_Get_Cases] as
begin
	set nocount on
	select	CaseData
	from	[Rulebase].[DV_Cases]
end
go

if object_id('[Rulebase].[DV_Insert_Cases]','p') is not null
begin
	drop procedure [Rulebase].[DV_Insert_Cases]
end
go

create procedure [Rulebase].[DV_Insert_Cases] as
begin
	set nocount on

	insert into [Rulebase].[DV_Cases] (
		[LearnRefNumber],
		CaseData
	)
	select	ControllingTable.[LearnRefNumber],
			convert(xml, (select	[Org_Details].[ThirdSector] as [@ThirdSector],
									[LearningProvider].[UKPRN] as [@UKPRN],
									(select	[Learner].[DateOfBirth] as [@DateOfBirth],
											[FM25_Learner].[FundLine] as [@EFA_CalcFundingLineType],
											[FM25_Learner].[StartFund] as [@EFA_CalcStartFunding],
											[FM25_Learner].[ThresholdDays] as [@EFA_CalcThresholdDays],
											[Learner].[Ethnicity] as [@Ethnicity],
											[Learner].[LearnRefNumber] as [@LearnRefNumber],
											[Learner].[LLDDHealthProb] as [@LLDDHealthProb],
											[Learner].[PlanEEPHours] as [@PlanEEPHours],
											[Learner].[PlanLearnHours] as [@PlanLearnHours],
											[Learner].[PrevLearnRefNumber] as [@PrevLearnRefNumber],
											[Learner].[PrevUKPRN] as [@PrevUKPRN],
											[Learner].[PriorAttain] as [@PriorAttain],
											[Learner].[ULN] as [@ULN],

											(select	[DateEmpStatApp] as [@DateEmpStatApp],
													[EmpId] as [@EmpId],
													[EmpStat] as [@EmpStat],
													[ESMCode_BSI] as [@EmpStatMon_BSI],
													[ESMCode_EII] as [@EmpStatMon_EII],
													[ESMCode_LOE] as [@EmpStatMon_LOE],
													[ESMCode_LOU] as [@EmpStatMon_LOU],
													[ESMCode_PEI] as [@EmpStatMon_PEI],
													[ESMCode_SEI] as [@EmpStatMon_SEI],
													[ESMCode_SEM] as [@EmpStatMon_SEM]
											from	Valid.LearnerEmploymentStatusDenormTbl les
											where	les.[LearnRefNumber] = [Learner].[LearnRefNumber]
											for xml path ('LearnerEmploymentStatus'), type),

											(select	[ContPrefCode] as [@ContPrefCode],
													[ContPrefType] as [@ContPrefType]
											from	[Valid].[ContactPreference]
											where	[LearnRefNumber] = [Learner].[LearnRefNumber]
											for xml path ('ContactPreference'), type),

											(select	ld.[AimSeqNumber] as [@AimSeqNumber],
													ld.[AimType] as [@AimType],
													[ALB_LearningDelivery].[FundLine] as [@ALB_CalcFundingLineType],
													[ALB_LearningDelivery].[FundStart] as [@ALB_CalcStartFunding],
													ld.[CompStatus] as [@CompStatus],
													[LARS_LearningDelivery].[CreditBasedFwkType] as [@CreditBasedFwkType],
													[LARS_LearningDelivery].[EnglandFEHEStatus] as [@EnglandFEHEStatus],
													[LARS_FrameworkAims].[FrameworkComponentType] as [@FrameworkComponentType],
													ld.[FundModel] as [@FundModel],
													ld.[FworkCode] as [@FworkCode],
													ld.[LearnActEndDate] as [@LearnActEndDate],
													ld.[LearnAimRef] as [@LearnAimRef],
													[LARS_LearningDelivery].[LearnAimRefType] as [@LearnAimRefType],
													ld.[LearnPlanEndDate] as [@LearnPlanEndDate],
													ld.[LearnStartDate] as [@LearnStartDate],
													ld.[LDFAM_ADL] as [@LrnDelFAM_ADL],
													ld.[LDFAM_EEF] as [@LrnDelFAM_EEF],
													ld.[LDFAM_FFI] as [@LrnDelFAM_FFI],
													ld.[LDM1] as [@LrnDelFAM_LDM1],
													ld.[LDM2] as [@LrnDelFAM_LDM2],
													ld.[LDM3] as [@LrnDelFAM_LDM3],
													ld.[LDM4] as [@LrnDelFAM_LDM4],
													ld.[LDFAM_RES] as [@LrnDelFAM_RES],
													ld.[LDFAM_SOF] as [@LrnDelFAM_SOF],
													ld.[LDFAM_WPP] as [@LrnDelFAM_SPP],
													[LARS_LearningDelivery].[NotionalNVQLevel] as [@NotionalNVQLevel],
													[LARS_LearningDelivery].[NotionalNVQLevelv2] as [@NotionalNVQLevelv2],
													ld.[OrigLearnStartDate] as [@OrigLearnStartDate],
													ld.[Outcome] as [@Outcome],
													ld.[OutGrade] as [@OutGrade],
													ld.[ProgType] as [@ProgType],
													ld.[PwayCode] as [@PwayCode],
													[LARS_LearningDelivery].[RegulatedCreditValue] as [@RegulatedCreditValue],
													[LARS_Section96].[Section96Valid16to18] as [@Section96Valid16to18],
													[LARS_LearningDelivery].[SectorSubjectAreaTier1] as [@SectorSubjectAreaTier1],
													[LARS_LearningDelivery].[SectorSubjectAreaTier2] as [@SectorSubjectAreaTier2],
													[FM35_LearningDelivery].[FundLine] as [@SFA_CalcFundingLineType],
													[FM35_LearningDelivery].[LargeEmployerFM35Fctr] as [@SFA_CalcLargeEmpFactor],
													[FM35_LearningDelivery].[FundStart] as [@SFA_CalcStartFunding],
													[FM35_LearningDelivery].[ThresholdDays] as [@SFA_CalcThresholdDays],
													ld.[WithdrawReason] as [@WithdrawReason],
													(select	[LearnDelFAMCode] as [@LearnDelFAMCode],
															[LearnDelFAMDateFrom] as [@LearnDelFAMDateFrom],
															[LearnDelFAMDateTo] as [@LearnDelFAMDateTo],
															[LearnDelFAMType] as [@LearnDelFAMType]
													from	[Valid].[LearningDeliveryFAM]
													where	[LearnRefNumber] = ld.LearnRefNumber
													and		[AimSeqNumber] = ld.AimSeqNumber
													for xml path ('LearningDeliveryFAM'), type),

											(select	[BasicSkills] as [@BasicSkills],
													[BasicSkillsParticipation] as [@BasicSkillsParticipation],
													[BasicSkillsType] as [@BasicSkillsType],
													[EffectiveFrom] as [@EffectiveFrom],
													[EffectiveTo] as [@EffectiveTo],
													[FullLevel2EntitlementCategory] as [@FullLevel2EntitlementCategory],
													[FullLevel2Percent] as [@FullLevel2Percent],
													[FullLevel3EntitlementCategory] as [@FullLevel3EntitlementCategory],
													[FullLevel3Percent] as [@FullLevel3Percent],
													[SfaApprovalStatus] as [@SFAApprovalStatus]
											from	[Reference].[LARS_AnnualValue]
											where	[LearnAimRef] = ld.[LearnAimRef]
											for xml path ('LARSAnnualValue'), type),

											(select	[TYPEYR] as [@TYPEYR]
											from	[Valid].[LearningDeliveryHE]
											where	[LearnRefNumber] = ld.[LearnRefNumber]
											and		[AimSeqNumber] = ld.[AimSeqNumber]
											for xml path ('LearningDeliveryHE'), type),

											(select	[ValidityCategory] as [@ValidityCategory],
													[EndDate] as [@ValidityEndDate],
													[LastNewStartDate] as [@ValidityLastNewStartDate],
													[StartDate] as [@ValidityStartDate]
											from	[Reference].[LARS_Validity]
											where	[LearnAimRef] = ld.[LearnAimRef]
											for xml path ('LearningDeliveryLARSValidity'), type)

									from	Valid.LearningDeliveryDenormTbl ld
												left join [Rulebase].[ALB_LearningDelivery] on [ALB_LearningDelivery].[LearnRefNumber] = ld.[LearnRefNumber]
													and	[ALB_LearningDelivery].[AimSeqNumber] = ld.[AimSeqNumber]
												left join [Reference].[LARS_LearningDelivery] on [LARS_LearningDelivery].[LearnAimRef] = ld.[LearnAimRef]
												left join [Reference].[LARS_FrameworkAims] on [LARS_FrameworkAims].[FworkCode] = ld.[FworkCode]
													and	[LARS_FrameworkAims].[ProgType] = ld.[ProgType]
													and	[LARS_FrameworkAims].[PwayCode] = ld.[PwayCode]
													and	[LARS_FrameworkAims].[LearnAimRef] = ld.[LearnAimRef]
												left join [Reference].[LARS_Section96] on [LARS_Section96].[LearnAimRef] = ld.[LearnAimRef]
												left join [Rulebase].[FM35_LearningDelivery] on [FM35_LearningDelivery].[LearnRefNumber] = ld.[LearnRefNumber]
													and [FM35_LearningDelivery].[AimSeqNumber] = ld.[AimSeqNumber]
									where	ld.[LearnRefNumber] = [Learner].[LearnRefNumber]
									for xml path ('LearningDelivery'), type),
									(select	[LLDDCat] as [@LLDDCat],
											[PrimaryLLDD] as [@PrimaryLLDD]
									from	[Valid].[LLDDandHealthProblem]
									where	[LearnRefNumber] = [Learner].[LearnRefNumber]
									for xml path ('LLDDandHealthProblem'), type)
						from	[Valid].[Learner]
									left join [Rulebase].[FM25_Learner] on [FM25_Learner].[LearnRefNumber]=[Learner].[LearnRefNumber]
						where	[Learner].[LearnRefNumber] = [ControllingTable].[LearnRefNumber]
						for xml path ('Learner'), type)
				from	[Valid].[LearningProvider]
							left join [Reference].[Org_Details] on [Org_Details].[UKPRN] = [LearningProvider].[UKPRN]
				for xml path ('global'), type))
		from	[Valid].[Learner] ControllingTable
end
go

if object_id('[Rulebase].[DV_Insert_global]','p') is not null
begin
	drop procedure [Rulebase].[DV_Insert_global]
end
go

create procedure [Rulebase].[DV_Insert_global] (
	@UKPRN int,
	@RulebaseVersion varchar(10)
)
as
begin
	set nocount on

	insert into [Rulebase].[DV_global] (
		UKPRN,
		RulebaseVersion
	) values (
		@UKPRN,
		@RulebaseVersion
	)
end
go

if object_id('[Rulebase].[DV_Insert_Learner]','p') is not null
begin
	drop procedure [Rulebase].[DV_Insert_Learner]
end
go

create procedure [Rulebase].[DV_Insert_Learner] (
	@LearnRefNumber varchar(12),
	@Learn_3rdSector int,
	@Learn_Active int,
	@Learn_ActiveJan int,
	@Learn_ActiveNov int,
	@Learn_ActiveOct int,
	@Learn_Age31Aug int,
	@Learn_BasicSkill int,
	@Learn_EmpStatFDL int,
	@Learn_EmpStatPrior int,
	@Learn_FirstFullLevel2 int,
	@Learn_FirstFullLevel2Ach int,
	@Learn_FirstFullLevel3 int,
	@Learn_FirstFullLevel3Ach int,
	@Learn_FullLevel2 int,
	@Learn_FullLevel2Ach int,
	@Learn_FullLevel3 int,
	@Learn_FullLevel3Ach int,
	@Learn_FundAgency int,
	@Learn_FundingSource int,
	@Learn_FundPrvYr int,
	@Learn_ILAcMonth1 int,
	@Learn_ILAcMonth10 int,
	@Learn_ILAcMonth11 int,
	@Learn_ILAcMonth12 int,
	@Learn_ILAcMonth2 int,
	@Learn_ILAcMonth3 int,
	@Learn_ILAcMonth4 int,
	@Learn_ILAcMonth5 int,
	@Learn_ILAcMonth6 int,
	@Learn_ILAcMonth7 int,
	@Learn_ILAcMonth8 int,
	@Learn_ILAcMonth9 int,
	@Learn_ILCurrAcYr int,
	@Learn_LargeEmployer int,
	@Learn_LenEmp int,
	@Learn_LenUnemp int,
	@Learn_LrnAimRecords int,
	@Learn_ModeAttPlanHrs int,
	@Learn_NotionLev int,
	@Learn_NotionLevV2 int,
	@Learn_OLASS int,
	@Learn_PrefMethContact int,
	@Learn_PrimaryLLDD int,
	@Learn_PriorEducationStatus int,
	@Learn_UnempBenFDL int,
	@Learn_UnempBenPrior int,
	@Learn_Uplift1516EFA decimal(6,5),
	@Learn_Uplift1516SFA decimal(6,5)
) as
begin
	set nocount on
	insert into [Rulebase].[DV_Learner]
	values (
		@LearnRefNumber,
		@Learn_3rdSector,
		@Learn_Active,
		@Learn_ActiveJan,
		@Learn_ActiveNov,
		@Learn_ActiveOct,
		@Learn_Age31Aug,
		@Learn_BasicSkill,
		@Learn_EmpStatFDL,
		@Learn_EmpStatPrior,
		@Learn_FirstFullLevel2,
		@Learn_FirstFullLevel2Ach,
		@Learn_FirstFullLevel3,
		@Learn_FirstFullLevel3Ach,
		@Learn_FullLevel2,
		@Learn_FullLevel2Ach,
		@Learn_FullLevel3,
		@Learn_FullLevel3Ach,
		@Learn_FundAgency,
		@Learn_FundingSource,
		@Learn_FundPrvYr,
		@Learn_ILAcMonth1,
		@Learn_ILAcMonth10,
		@Learn_ILAcMonth11,
		@Learn_ILAcMonth12,
		@Learn_ILAcMonth2,
		@Learn_ILAcMonth3,
		@Learn_ILAcMonth4,
		@Learn_ILAcMonth5,
		@Learn_ILAcMonth6,
		@Learn_ILAcMonth7,
		@Learn_ILAcMonth8,
		@Learn_ILAcMonth9,
		@Learn_ILCurrAcYr,
		@Learn_LargeEmployer,
		@Learn_LenEmp,
		@Learn_LenUnemp,
		@Learn_LrnAimRecords,
		@Learn_ModeAttPlanHrs,
		@Learn_NotionLev,
		@Learn_NotionLevV2,
		@Learn_OLASS,
		@Learn_PrefMethContact,
		@Learn_PrimaryLLDD,
		@Learn_PriorEducationStatus,
		@Learn_UnempBenFDL,
		@Learn_UnempBenPrior,
		@Learn_Uplift1516EFA,
		@Learn_Uplift1516SFA
	)
end
go

if object_id('[Rulebase].[DV_Insert_LearningDelivery]','p') is not null
begin
	drop procedure [Rulebase].[DV_Insert_LearningDelivery]
end
go

create procedure [Rulebase].[DV_Insert_LearningDelivery] (
	@LearnRefNumber varchar(12),
	@AimSeqNumber int,
	@LearnDel_AccToApp int,
	@LearnDel_AccToAppEmpDate date,
	@LearnDel_AccToAppEmpStat int,
	@LearnDel_AchFullLevel2Pct decimal(5,2),
	@LearnDel_AchFullLevel3Pct decimal(5,2),
	@LearnDel_Achieved int,
	@LearnDel_AchievedIY int,
	@LearnDel_AcMonthYTD varchar(2),
	@LearnDel_ActDaysILAfterCurrAcYr int,
	@LearnDel_ActDaysILCurrAcYr int,
	@LearnDel_ActEndDateOnAfterJan1 int,
	@LearnDel_ActEndDateOnAfterNov1 int,
	@LearnDel_ActEndDateOnAfterOct1 int,
	@LearnDel_ActiveIY int,
	@LearnDel_ActiveJan int,
	@LearnDel_ActiveNov int,
	@LearnDel_ActiveOct int,
	@LearnDel_ActTotalDaysIL int,
	@LearnDel_AdvLoan int,
	@LearnDel_AgeAimOrigStart int,
	@LearnDel_AgeAtStart int,
	@LearnDel_App int,
	@LearnDel_App1618Fund int,
	@LearnDel_App1925Fund int,
	@LearnDel_AppAimType int,
	@LearnDel_AppKnowl int,
	@LearnDel_AppMainAim int,
	@LearnDel_AppNonFund int,
	@LearnDel_BasicSkills int,
	@LearnDel_BasicSkillsParticipation int,
	@LearnDel_BasicSkillsType int,
	@LearnDel_CarryIn int,
	@LearnDel_ClassRm int,
	@LearnDel_CompAimApp int,
	@LearnDel_CompAimProg int,
	@LearnDel_Completed int,
	@LearnDel_CompletedIY int,
	@LearnDel_CompleteFullLevel2Pct decimal(5,2),
	@LearnDel_CompleteFullLevel3Pct decimal(5,2),
	@LearnDel_EFACoreAim int,
	@LearnDel_Emp6MonthAimStart int,
	@LearnDel_Emp6MonthProgStart int,
	@LearnDel_EmpDateBeforeFDL date,
	@LearnDel_EmpDatePriorFDL date,
	@LearnDel_EmpID int,
	@LearnDel_Employed int,
	@LearnDel_EmpStatFDL int,
	@LearnDel_EmpStatPrior int,
	@LearnDel_EmpStatPriorFDL int,
	@LearnDel_EnhanAppFund int,
	@LearnDel_FullLevel2AchPct decimal(5,2),
	@LearnDel_FullLevel2ContPct decimal(5,2),
	@LearnDel_FullLevel3AchPct decimal(5,2),
	@LearnDel_FullLevel3ContPct decimal(5,2),
	@LearnDel_FuncSkills int,
	@LearnDel_FundAgency int,
	@LearnDel_FundingLineType varchar(100),
	@LearnDel_FundingSource int,
	@LearnDel_FundPrvYr int,
	@LearnDel_FundStart int,
	@LearnDel_GCE int,
	@LearnDel_GCSE int,
	@LearnDel_ILAcMonth1 int,
	@LearnDel_ILAcMonth10 int,
	@LearnDel_ILAcMonth11 int,
	@LearnDel_ILAcMonth12 int,
	@LearnDel_ILAcMonth2 int,
	@LearnDel_ILAcMonth3 int,
	@LearnDel_ILAcMonth4 int,
	@LearnDel_ILAcMonth5 int,
	@LearnDel_ILAcMonth6 int,
	@LearnDel_ILAcMonth7 int,
	@LearnDel_ILAcMonth8 int,
	@LearnDel_ILAcMonth9 int,
	@LearnDel_ILCurrAcYr int,
	@LearnDel_IYActEndDate date,
	@LearnDel_IYPlanEndDate date,
	@LearnDel_IYStartDate date,
	@LearnDel_KeySkills int,
	@LearnDel_LargeEmpDiscountId int,
	@LearnDel_LargeEmployer int,
	@LearnDel_LastEmpDate date,
	@LearnDel_LeaveMonth int,
	@LearnDel_LenEmp int,
	@LearnDel_LenUnemp int,
	@LearnDel_LoanBursFund int,
	@LearnDel_NotionLevel int,
	@LearnDel_NotionLevelV2 int,
	@LearnDel_NumHEDatasets int,
	@LearnDel_OccupAim int,
	@LearnDel_OLASS int,
	@LearnDel_OLASSCom int,
	@LearnDel_OLASSCus int,
	@LearnDel_OrigStartDate date,
	@LearnDel_PlanDaysILAfterCurrAcYr int,
	@LearnDel_PlanDaysILCurrAcYr int,
	@LearnDel_PlanEndBeforeAug1 int,
	@LearnDel_PlanEndOnAfterJan1 int,
	@LearnDel_PlanEndOnAfterNov1 int,
	@LearnDel_PlanEndOnAfterOct1 int,
	@LearnDel_PlanTotalDaysIL int,
	@LearnDel_PriorEducationStatus int,
	@LearnDel_Prog int,
	@LearnDel_ProgAimAch int,
	@LearnDel_ProgAimApp int,
	@LearnDel_ProgCompleted int,
	@LearnDel_ProgCompletedIY int,
	@LearnDel_ProgStartDate date,
	@LearnDel_QCF int,
	@LearnDel_QCFCert int,
	@LearnDel_QCFDipl int,
	@LearnDel_QCFType int,
	@LearnDel_RegAim int,
	@LearnDel_SecSubAreaTier1 varchar(3),
	@LearnDel_SecSubAreaTier2 varchar(5),
	@LearnDel_SFAApproved int,
	@LearnDel_SourceFundEFA int,
	@LearnDel_SourceFundSFA int,
	@LearnDel_StartBeforeApr1 int,
	@LearnDel_StartBeforeAug1 int,
	@LearnDel_StartBeforeDec1 int,
	@LearnDel_StartBeforeFeb1 int,
	@LearnDel_StartBeforeJan1 int,
	@LearnDel_StartBeforeJun1 int,
	@LearnDel_StartBeforeMar1 int,
	@LearnDel_StartBeforeMay1 int,
	@LearnDel_StartBeforeNov1 int,
	@LearnDel_StartBeforeOct1 int,
	@LearnDel_StartBeforeSep1 int,
	@LearnDel_StartIY int,
	@LearnDel_StartJan1 int,
	@LearnDel_StartMonth int,
	@LearnDel_StartNov1 int,
	@LearnDel_StartOct1 int,
	@LearnDel_SuccRateStat int,
	@LearnDel_TrainAimType int,
	@LearnDel_TransferDiffProvider int,
	@LearnDel_TransferDiffProviderGovStrat int,
	@LearnDel_TransferProvider int,
	@LearnDel_UfIProv int,
	@LearnDel_UnempBenFDL int,
	@LearnDel_UnempBenPrior int,
	@LearnDel_Withdrawn int,
	@LearnDel_WorkplaceLocPostcode varchar(8),
	@Prog_AccToApp int,
	@Prog_Achieved int,
	@Prog_AchievedIY int,
	@Prog_ActEndDate date,
	@Prog_ActiveIY int,
	@Prog_AgeAtStart int,
	@Prog_EarliestAim int,
	@Prog_Employed int,
	@Prog_FundPrvYr int,
	@Prog_ILCurrAcYear int,
	@Prog_LatestAim int,
	@Prog_SourceFundEFA int,
	@Prog_SourceFundSFA int
) as
begin
	set nocount on

	insert into [Rulebase].[DV_LearningDelivery]
	values (
		@LearnRefNumber,
		@AimSeqNumber,
		@LearnDel_AccToApp,
		@LearnDel_AccToAppEmpDate,
		@LearnDel_AccToAppEmpStat,
		@LearnDel_AchFullLevel2Pct,
		@LearnDel_AchFullLevel3Pct,
		@LearnDel_Achieved,
		@LearnDel_AchievedIY,
		@LearnDel_AcMonthYTD,
		@LearnDel_ActDaysILAfterCurrAcYr,
		@LearnDel_ActDaysILCurrAcYr,
		@LearnDel_ActEndDateOnAfterJan1,
		@LearnDel_ActEndDateOnAfterNov1,
		@LearnDel_ActEndDateOnAfterOct1,
		@LearnDel_ActiveIY,
		@LearnDel_ActiveJan,
		@LearnDel_ActiveNov,
		@LearnDel_ActiveOct,
		@LearnDel_ActTotalDaysIL,
		@LearnDel_AdvLoan,
		@LearnDel_AgeAimOrigStart,
		@LearnDel_AgeAtStart,
		@LearnDel_App,
		@LearnDel_App1618Fund,
		@LearnDel_App1925Fund,
		@LearnDel_AppAimType,
		@LearnDel_AppKnowl,
		@LearnDel_AppMainAim,
		@LearnDel_AppNonFund,
		@LearnDel_BasicSkills,
		@LearnDel_BasicSkillsParticipation,
		@LearnDel_BasicSkillsType,
		@LearnDel_CarryIn,
		@LearnDel_ClassRm,
		@LearnDel_CompAimApp,
		@LearnDel_CompAimProg,
		@LearnDel_Completed,
		@LearnDel_CompletedIY,
		@LearnDel_CompleteFullLevel2Pct,
		@LearnDel_CompleteFullLevel3Pct,
		@LearnDel_EFACoreAim,
		@LearnDel_Emp6MonthAimStart,
		@LearnDel_Emp6MonthProgStart,
		@LearnDel_EmpDateBeforeFDL,
		@LearnDel_EmpDatePriorFDL,
		@LearnDel_EmpID,
		@LearnDel_Employed,
		@LearnDel_EmpStatFDL,
		@LearnDel_EmpStatPrior,
		@LearnDel_EmpStatPriorFDL,
		@LearnDel_EnhanAppFund,
		@LearnDel_FullLevel2AchPct,
		@LearnDel_FullLevel2ContPct,
		@LearnDel_FullLevel3AchPct,
		@LearnDel_FullLevel3ContPct,
		@LearnDel_FuncSkills,
		@LearnDel_FundAgency,
		@LearnDel_FundingLineType,
		@LearnDel_FundingSource,
		@LearnDel_FundPrvYr,
		@LearnDel_FundStart,
		@LearnDel_GCE,
		@LearnDel_GCSE,
		@LearnDel_ILAcMonth1,
		@LearnDel_ILAcMonth10,
		@LearnDel_ILAcMonth11,
		@LearnDel_ILAcMonth12,
		@LearnDel_ILAcMonth2,
		@LearnDel_ILAcMonth3,
		@LearnDel_ILAcMonth4,
		@LearnDel_ILAcMonth5,
		@LearnDel_ILAcMonth6,
		@LearnDel_ILAcMonth7,
		@LearnDel_ILAcMonth8,
		@LearnDel_ILAcMonth9,
		@LearnDel_ILCurrAcYr,
		@LearnDel_IYActEndDate,
		@LearnDel_IYPlanEndDate,
		@LearnDel_IYStartDate,
		@LearnDel_KeySkills,
		@LearnDel_LargeEmpDiscountId,
		@LearnDel_LargeEmployer,
		@LearnDel_LastEmpDate,
		@LearnDel_LeaveMonth,
		@LearnDel_LenEmp,
		@LearnDel_LenUnemp,
		@LearnDel_LoanBursFund,
		@LearnDel_NotionLevel,
		@LearnDel_NotionLevelV2,
		@LearnDel_NumHEDatasets,
		@LearnDel_OccupAim,
		@LearnDel_OLASS,
		@LearnDel_OLASSCom,
		@LearnDel_OLASSCus,
		@LearnDel_OrigStartDate,
		@LearnDel_PlanDaysILAfterCurrAcYr,
		@LearnDel_PlanDaysILCurrAcYr,
		@LearnDel_PlanEndBeforeAug1,
		@LearnDel_PlanEndOnAfterJan1,
		@LearnDel_PlanEndOnAfterNov1,
		@LearnDel_PlanEndOnAfterOct1,
		@LearnDel_PlanTotalDaysIL,
		@LearnDel_PriorEducationStatus,
		@LearnDel_Prog,
		@LearnDel_ProgAimAch,
		@LearnDel_ProgAimApp,
		@LearnDel_ProgCompleted,
		@LearnDel_ProgCompletedIY,
		@LearnDel_ProgStartDate,
		@LearnDel_QCF,
		@LearnDel_QCFCert,
		@LearnDel_QCFDipl,
		@LearnDel_QCFType,
		@LearnDel_RegAim,
		@LearnDel_SecSubAreaTier1,
		@LearnDel_SecSubAreaTier2,
		@LearnDel_SFAApproved,
		@LearnDel_SourceFundEFA,
		@LearnDel_SourceFundSFA,
		@LearnDel_StartBeforeApr1,
		@LearnDel_StartBeforeAug1,
		@LearnDel_StartBeforeDec1,
		@LearnDel_StartBeforeFeb1,
		@LearnDel_StartBeforeJan1,
		@LearnDel_StartBeforeJun1,
		@LearnDel_StartBeforeMar1,
		@LearnDel_StartBeforeMay1,
		@LearnDel_StartBeforeNov1,
		@LearnDel_StartBeforeOct1,
		@LearnDel_StartBeforeSep1,
		@LearnDel_StartIY,
		@LearnDel_StartJan1,
		@LearnDel_StartMonth,
		@LearnDel_StartNov1,
		@LearnDel_StartOct1,
		@LearnDel_SuccRateStat,
		@LearnDel_TrainAimType,
		@LearnDel_TransferDiffProvider,
		@LearnDel_TransferDiffProviderGovStrat,
		@LearnDel_TransferProvider,
		@LearnDel_UfIProv,
		@LearnDel_UnempBenFDL,
		@LearnDel_UnempBenPrior,
		@LearnDel_Withdrawn,
		@LearnDel_WorkplaceLocPostcode,
		@Prog_AccToApp,
		@Prog_Achieved,
		@Prog_AchievedIY,
		@Prog_ActEndDate,
		@Prog_ActiveIY,
		@Prog_AgeAtStart,
		@Prog_EarliestAim,
		@Prog_Employed,
		@Prog_FundPrvYr,
		@Prog_ILCurrAcYear,
		@Prog_LatestAim,
		@Prog_SourceFundEFA,
		@Prog_SourceFundSFA
	)
end
go
