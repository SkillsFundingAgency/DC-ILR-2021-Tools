﻿
if object_id('Invalid.LearnerDenorm','V') is not null
begin
	drop VIEW Invalid.LearnerDenorm
end
go

create view Invalid.LearnerDenorm
as
	select	l.LearnRefNumber,
			l.PrevLearnRefNumber,
			l.PrevUKPRN,
			l.PMUKPRN,
			l.CampId,
			l.ULN,
			l.FamilyName,
			l.GivenNames,
			l.DateOfBirth,
			l.Ethnicity,
			l.Sex,
			l.LLDDHealthProb,
			l.NINumber,
			l.PriorAttain,
			l.Accom,
			l.ALSCost,
			l.PlanLearnHours,
			l.PlanEEPHours,
			l.MathGrade,
			l.EngGrade,
			l.PostcodePrior,
			l.Postcode,
			l.AddLine1,
			l.AddLine2,
			l.AddLine3,
			l.AddLine4,
			l.TelNo,
			l.Email,
			LSR.LSR1,
			LSR.LSR2,
			LSR.LSR3,
			LSR.LSR4,
			NLM.NLM1,
			NLM.NLM2,
			PPE.PPE1,
			PPE.PPE2,
			EDF.EDF1,
			EDF.EDF2,
			ehc.LearnFAMCode as EHC,
			ecf.LearnFAMCode as ECF,
			hns.LearnFAMCode as HNS,
			dla.LearnFAMCode as DLA,
			mcf.LearnFAMCode as MCF,
			sen.LearnFAMCode as SEN,
			fme.LearnFAMCode as FME,
			ProvSpecMon_A.ProvSpecLearnMon as ProvSpecLearnMon_A,
			ProvSpecMon_B.ProvSpecLearnMon as ProvSpecLearnMon_B
	from	Invalid.Learner as l
				left join (	select	LearnRefNumber,
									max(LSR1) as LSR1,
									max(LSR2) as LSR2,
									max(LSR3) as LSR3,
									max(LSR4) as LSR4
							from (	select	LearnRefNumber,
											case row_number() over (partition by LearnRefNumber order by LearnRefNumber) when 1 then LearnFAMCode else null end  as LSR1,
											case row_number() over (partition by LearnRefNumber order by LearnRefNumber) when 2 then LearnFAMCode else null end  as LSR2,
											case row_number() over (partition by LearnRefNumber order by LearnRefNumber) when 3 then LearnFAMCode else null end  as LSR3,
											case row_number() over (partition by LearnRefNumber order by LearnRefNumber) when 4 then LearnFAMCode else null end  as LSR4
									from	Invalid.LearnerFAM
									where	LearnFAMType = 'LSR') as LSRs
							group by
									LearnRefNumber) as LSR
				on LSR.LearnRefNumber = l.LearnRefNumber
				left join (	select	LearnRefNumber,
									max(NLM1) as NLM1,
									max(NLM2) as NLM2
							from	(	select	LearnRefNumber,
												case row_number() over (partition by LearnRefNumber order by LearnRefNumber) when 1 then LearnFAMCode else null end  as NLM1,
												case row_number() over (partition by LearnRefNumber order by LearnRefNumber) when 2 then LearnFAMCode else null end  as NLM2
										from	Invalid.LearnerFAM
										where	LearnFAMType = 'NLM') as NLMs
							group by
									LearnRefNumber) as NLM
				on NLM.LearnRefNumber = l.LearnRefNumber
				left join (	select	LearnRefNumber,
									max(PPE1) as PPE1,
									max(PPE2) as PPE2
							from	(	select	LearnRefNumber,
												case row_number() over (partition by LearnRefNumber order by LearnRefNumber) when 1 then LearnFAMCode else null end  as PPE1,
												case row_number() over (partition by LearnRefNumber order by LearnRefNumber) when 2 then LearnFAMCode else null end  as PPE2
										from	Invalid.LearnerFAM
										where	LearnFAMType = 'PPE') as PPEs
							group by
									LearnRefNumber) as PPE
					on PPE.LearnRefNumber = l.LearnRefNumber
				left join (	select	LearnRefNumber,
									max(EDF1) as EDF1,
									max(EDF2) as EDF2
							from	(	select	LearnRefNumber,
												case row_number() over (partition by LearnRefNumber order by LearnRefNumber) when 1 then LearnFAMCode else null end  as EDF1,
												case row_number() over (partition by LearnRefNumber order by LearnRefNumber) when 2 then LearnFAMCode else null end  as EDF2
										from	Invalid.LearnerFAM
										where	LearnFAMType = 'EDF') as EDFs
							group by
									LearnRefNumber) as EDF
					on EDF.LearnRefNumber=l.LearnRefNumber
				left join Invalid.LearnerFAM as ehc
					on ehc.LearnRefNumber = l.LearnRefNumber
					and ehc.LearnFAMType = 'EHC' 
				left join Invalid.LearnerFAM as ecf
					on ecf.LearnRefNumber = l.LearnRefNumber
					and ecf.LearnFAMType = 'ECF'
				left join Invalid.LearnerFAM as hns
					on hns.LearnRefNumber = l.LearnRefNumber
					and hns.LearnFAMType = 'HNS'
				left join Invalid.LearnerFAM as dla
					on dla.LearnRefNumber = l.LearnRefNumber
					and dla.LearnFAMType = 'DLA'
				left join Invalid.LearnerFAM as mcf
					on mcf.LearnRefNumber = l.LearnRefNumber
					and mcf.LearnFAMType = 'MCF'
				left join Invalid.LearnerFAM as sen
					on sen.LearnRefNumber = l.LearnRefNumber
					and sen.LearnFAMType = 'SEN'
				left join Invalid.LearnerFAM as fme
					on fme.LearnRefNumber = l.LearnRefNumber
					and fme.LearnFAMType = 'FME'
				left join Invalid.ProviderSpecLearnerMonitoring as ProvSpecMon_A
					on ProvSpecMon_A.LearnRefNumber = l.LearnRefNumber
					and ProvSpecMon_A.ProvSpecLearnMonOccur = 'A'
				left join Invalid.ProviderSpecLearnerMonitoring as ProvSpecMon_B
					on ProvSpecMon_B.LearnRefNumber = l.LearnRefNumber
					and ProvSpecMon_B.ProvSpecLearnMonOccur = 'B'
go

if object_id('Invalid.LearnerEmploymentStatusDenorm','V') is not null
begin
	drop VIEW Invalid.LearnerEmploymentStatusDenorm
end
go

create view Invalid.LearnerEmploymentStatusDenorm
as
	select	les.LearnRefNumber,
			les.EmpStat,
			les.DateEmpStatApp,
			EmpStatMon_BSI.ESMCode as ESMCode_BSI,
			EmpStatMon_EII.ESMCode as ESMCode_EII,
			EmpStatMon_LOE.ESMCode as ESMCode_LOE,
			EmpStatMon_LOU.ESMCode as ESMCode_LOU,
			EmpStatMon_PEI.ESMCode as ESMCode_PEI,
			EmpStatMon_SEI.ESMCode as ESMCode_SEI,
			EmpStatMon_SEM.ESMCode as ESMCode_SEM
	from	Invalid.LearnerEmploymentStatus as les
				left join Invalid.EmploymentStatusMonitoring as EmpStatMon_BSI
					on EmpStatMon_BSI.LearnRefNumber=les.LearnRefNumber
					and EmpStatMon_BSI.DateEmpStatApp = les.DateEmpStatApp
					and EmpStatMon_BSI.ESMType = 'BSI'
				left join Invalid.EmploymentStatusMonitoring as EmpStatMon_EII
					on EmpStatMon_EII.LearnRefNumber=les.LearnRefNumber
					and EmpStatMon_EII.DateEmpStatApp = les.DateEmpStatApp
					and EmpStatMon_EII.ESMType = 'EII'
				left join Invalid.EmploymentStatusMonitoring as EmpStatMon_LOE
					on EmpStatMon_LOE.LearnRefNumber=les.LearnRefNumber
					and EmpStatMon_LOE.DateEmpStatApp = les.DateEmpStatApp
					and EmpStatMon_LOE.ESMType = 'LOE'
				left join Invalid.EmploymentStatusMonitoring as EmpStatMon_LOU
					on EmpStatMon_LOU.LearnRefNumber=les.LearnRefNumber
					and EmpStatMon_LOU.DateEmpStatApp = les.DateEmpStatApp
					and EmpStatMon_LOU.ESMType = 'LOU'
				left join Invalid.EmploymentStatusMonitoring as EmpStatMon_PEI
					on EmpStatMon_PEI.LearnRefNumber=les.LearnRefNumber
					and EmpStatMon_PEI.DateEmpStatApp = les.DateEmpStatApp
					and EmpStatMon_PEI.ESMType = 'PEI'
				left join Invalid.EmploymentStatusMonitoring as EmpStatMon_SEI
					on EmpStatMon_SEI.LearnRefNumber=les.LearnRefNumber
					and EmpStatMon_SEI.DateEmpStatApp = les.DateEmpStatApp
					and EmpStatMon_SEI.ESMType = 'SEI'
				left join Invalid.EmploymentStatusMonitoring as EmpStatMon_SEM
					on EmpStatMon_SEM.LearnRefNumber=les.LearnRefNumber
					and EmpStatMon_SEM.DateEmpStatApp = les.DateEmpStatApp
					and EmpStatMon_SEM.ESMType = 'SEM'
go

if object_id('Invalid.LearningDeliveryDenorm','V') is not null
begin
	drop VIEW Invalid.LearningDeliveryDenorm
end
go

create view Invalid.LearningDeliveryDenorm
as
	select	ld.LearnRefNumber,
			ld.LearnAimRef,
			ld.AimType,
			ld.AimSeqNumber,
			ld.LearnStartDate,
			ld.OrigLearnStartDate,
			ld.LearnPlanEndDate,
			ld.FundModel,
			ld.ProgType,
			ld.FworkCode,
			ld.PwayCode,
			ld.StdCode,
			ld.PartnerUKPRN,
			ld.DelLocPostCode,
			ld.LSDPostcode,
			ld.AddHours,
			ld.PriorLearnFundAdj,
			ld.OtherFundAdj,
			ld.ConRefNumber,
			ld.EPAOrgID,
			ld.EmpOutcome,
			ld.CompStatus,
			ld.LearnActEndDate,
			ld.WithdrawReason,
			ld.Outcome,
			ld.AchDate,
			ld.OutGrade,
			ld.SWSupAimId,
			HEM.HEM1,
			HEM.HEM2,
			HEM.HEM3,
			HHS.HHS1,
			HHS.HHS2,
			LDFAM_SOF.LearnDelFAMCode as LDFAM_SOF,
			LDFAM_EEF.LearnDelFAMCode as LDFAM_EEF,
			LDFAM_RES.LearnDelFAMCode as LDFAM_RES,
			LDFAM_ADL.LearnDelFAMCode as LDFAM_ADL,
			LDFAM_FFI.LearnDelFAMCode as LDFAM_FFI,
			LDFAM_WPP.LearnDelFAMCode as LDFAM_WPP,
			LDFAM_POD.LearnDelFAMCode as LDFAM_POD,
			LDFAM_ASL.LearnDelFAMCode as LDFAM_ASL,
			LDFAM_FLN.LearnDelFAMCode as LDFAM_FLN,
			LDFAM_NSA.LearnDelFAMCode as LDFAM_NSA,
			ProvSpecMon_A.ProvSpecDelMon as ProvSpecDelMon_A,
			ProvSpecMon_B.ProvSpecDelMon	as ProvSpecDelMon_B,
			ProvSpecMon_C.ProvSpecDelMon	as ProvSpecDelMon_C,
			ProvSpecMon_D.ProvSpecDelMon	as ProvSpecDelMon_D,
			LDM.LDM1,
			LDM.LDM2,
			LDM.LDM3,
			LDM.LDM4
	from	Invalid.LearningDelivery as ld
				left join (	select	LearnRefNumber,
									AimSeqNumber,
									max(HEM1) as HEM1,
									max(HEM2) as HEM2,
									max(HEM3) as HEM3
							from	(	select	LearnRefNumber,
												AimSeqNumber,
												case row_number() over (partition by LearnRefNumber, AimSeqNumber order by LearnRefNumber, AimSeqNumber) when 1 then LearnDelFAMCode else null end  as HEM1,
												case row_number() over (partition by LearnRefNumber, AimSeqNumber order by LearnRefNumber, AimSeqNumber) when 2 then LearnDelFAMCode else null end  as HEM2,
												case row_number() over (partition by LearnRefNumber, AimSeqNumber order by LearnRefNumber, AimSeqNumber) when 3 then LearnDelFAMCode else null end  as HEM3
										from	Invalid.LearningDeliveryFAM
										where	LearnDelFAMType = 'HEM') as HEMs
							group by
									LearnRefNumber,
									AimSeqNumber) as HEM
					on HEM.LearnRefNumber = ld.LearnRefNumber
					and HEM.AimSeqNumber = ld.AimSeqNumber
				left join (	select	LearnRefNumber, 
									AimSeqNumber,
									max(HHS1) as HHS1,
									max(HHS2) as HHS2
							from	(	select	LearnRefNumber,
												AimSeqNumber,
												case row_number() over (partition by LearnRefNumber, AimSeqNumber order by LearnRefNumber, AimSeqNumber) when 1 then LearnDelFAMCode else null end  as HHS1,
												case row_number() over (partition by LearnRefNumber, AimSeqNumber order by LearnRefNumber, AimSeqNumber) when 2 then LearnDelFAMCode else null end  as HHS2
										from	Invalid.LearningDeliveryFAM
										where	LearnDelFAMType = 'HHS') as HHSs
							group by
									LearnRefNumber,
									AimSeqNumber) as HHS
					on HHS.LearnRefNumber = ld.LearnRefNumber
					and HHS.AimSeqNumber = ld.AimSeqNumber
				left join Invalid.LearningDeliveryFAM as LDFAM_SOF 
					on ld.LearnRefNumber = LDFAM_SOF.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_SOF.AimSeqNumber
					and LDFAM_SOF.LearnDelFAMType = 'SOF'
				left join Invalid.LearningDeliveryFAM as LDFAM_EEF 
					on ld.LearnRefNumber = LDFAM_EEF.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_EEF.AimSeqNumber
					and LDFAM_EEF.LearnDelFAMType = 'EEF'
				left join Invalid.LearningDeliveryFAM as LDFAM_RES 
					on ld.LearnRefNumber = LDFAM_RES.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_RES.AimSeqNumber
					and LDFAM_RES.LearnDelFAMType = 'RES'
				left join Invalid.LearningDeliveryFAM as LDFAM_ADL 
					on  ld.LearnRefNumber = LDFAM_ADL.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_ADL.AimSeqNumber
					and LDFAM_ADL.LearnDelFAMType = 'ADL'
				left join Invalid.LearningDeliveryFAM as LDFAM_FFI 
					on  ld.LearnRefNumber = LDFAM_FFI.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_FFI.AimSeqNumber
					and LDFAM_FFI.LearnDelFAMType = 'FFI'
				left join Invalid.LearningDeliveryFAM as LDFAM_WPP 
					on ld.LearnRefNumber = LDFAM_WPP.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_WPP.AimSeqNumber
					and LDFAM_WPP.LearnDelFAMType = 'WPP'
				left join Invalid.LearningDeliveryFAM as LDFAM_POD 
					on ld.LearnRefNumber = LDFAM_POD.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_POD.AimSeqNumber
					and LDFAM_POD.LearnDelFAMType = 'POD'
				left join Invalid.LearningDeliveryFAM as LDFAM_ASL 
					on ld.LearnRefNumber = LDFAM_ASL.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_ASL.AimSeqNumber
					and LDFAM_ASL.LearnDelFAMType = 'ASL'
			left join Invalid.LearningDeliveryFAM as LDFAM_FLN 
					on ld.LearnRefNumber = LDFAM_FLN.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_FLN.AimSeqNumber
					and LDFAM_FLN.LearnDelFAMType = 'FLN'
				left join Invalid.LearningDeliveryFAM as LDFAM_NSA 
					on ld.LearnRefNumber = LDFAM_NSA.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_NSA.AimSeqNumber
					and LDFAM_NSA.LearnDelFAMType = 'NSA'
				left join Invalid.ProviderSpecDeliveryMonitoring as ProvSpecMon_A
					on ProvSpecMon_A.LearnRefNumber=ld.LearnRefNumber
					and ProvSpecMon_A.AimSeqNumber=ld.AimSeqNumber
					and ProvSpecMon_A.ProvSpecDelMonOccur = 'A'
				left join Invalid.ProviderSpecDeliveryMonitoring as ProvSpecMon_B
					on ProvSpecMon_B.LearnRefNumber=ld.LearnRefNumber
					and ProvSpecMon_B.AimSeqNumber=ld.AimSeqNumber
					and ProvSpecMon_B.ProvSpecDelMonOccur = 'B'
				left join Invalid.ProviderSpecDeliveryMonitoring as ProvSpecMon_C
					on ProvSpecMon_C.LearnRefNumber=ld.LearnRefNumber
					and ProvSpecMon_C.AimSeqNumber=ld.AimSeqNumber
					and ProvSpecMon_C.ProvSpecDelMonOccur = 'C'
				left join Invalid.ProviderSpecDeliveryMonitoring as ProvSpecMon_D
					on ProvSpecMon_D.LearnRefNumber=ld.LearnRefNumber
					and ProvSpecMon_D.AimSeqNumber=ld.AimSeqNumber
					and ProvSpecMon_D.ProvSpecDelMonOccur = 'D' 
				left join (	select	LearnRefNumber,
									AimSeqNumber,
									max(LDM1) as LDM1,
									max(LDM2) as LDM2,
									max(LDM3) as LDM3,
									max(LDM4) as LDM4
							from	(	select	LearnRefNumber,
												AimSeqNumber,
												case row_number() over (partition by LearnRefNumber, AimSeqNumber order by LearnRefNumber) when 1 then LearnDelFAMCode else null end  as LDM1,
												case row_number() over (partition by LearnRefNumber, AimSeqNumber order by LearnRefNumber) when 2 then LearnDelFAMCode else null end  as LDM2,
												case row_number() over (partition by LearnRefNumber, AimSeqNumber order by LearnRefNumber) when 3 then LearnDelFAMCode else null end  as LDM3,
												case row_number() over (partition by LearnRefNumber, AimSeqNumber order by LearnRefNumber) when 4 then LearnDelFAMCode else null end  as LDM4
										from	Invalid.LearningDeliveryFAM
										where	LearnDelFAMType = 'LDM') as LDMs
							group by
									LearnRefNumber,
									AimSeqNumber) as LDM
					on LDM.LearnRefNumber=ld.LearnRefNumber
					and LDM.AimSeqNumber = ld.AimSeqNumber
go
