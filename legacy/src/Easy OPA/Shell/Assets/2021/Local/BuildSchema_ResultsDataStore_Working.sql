create schema Invalid
go

create schema Rulebase
go

create schema Valid
go

create table FileDetails (
    ID int identity,
	UKPRN int not null,
	[Filename] varchar(50) null,
	FileSizeKb bigint null,
	TotalLearnersSubmitted int null,
	TotalValidLearnersSubmitted int null,
	TotalInvalidLearnersSubmitted int null,
	TotalErrorCount int null,
	TotalWarningCount int null,
	SubmittedTime datetime null,
	Success bit
	constraint [PK_dbo.FileDetails] unique (
		UKPRN, 
		[Filename], 
		Success asc
	)
)
go

create table ProcessingData (
    ID int identity,
	UKPRN int not null,
	FileDetailsID int null,
	ProcessingStep varchar(100) null,
	ExecutionTime varchar(20) null
)
go

create table Valid.Learner (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	PrevLearnRefNumber varchar(12) null,
	PrevUKPRN int null,
	CampId varchar(8) null,
	PMUKPRN int null,
	ULN bigint not null,
	FamilyName varchar(100) null,
	GivenNames varchar(100) null,
	DateOfBirth date null,
	Ethnicity int not null,
	Sex varchar(1) not null,
	LLDDHealthProb int not null,
	NINumber varchar(9) null,
	PriorAttain int null,
	Accom int null,
	ALSCost int null,
	PlanLearnHours int null,
	PlanEEPHours int null,
	MathGrade varchar(4) null,
	EngGrade varchar(4) null,
	PostcodePrior varchar(8) null,
	Postcode varchar(8) null,
	AddLine1 varchar(50) null,
	AddLine2 varchar(50) null,
	AddLine3 varchar(50) null,
	AddLine4 varchar(50) null,
	TelNo varchar(18) null,
	Email varchar(100) null
	primary key clustered (
		UKPRN asc, 
		LearnRefNumber asc
	)
)
go

create table Valid.LearnerFAM (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	LearnFAMType varchar(3) null,
	LearnFAMCode int not null
) 
go

create table Valid.ProviderSpecLearnerMonitoring (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	ProvSpecLearnMonOccur varchar(1) not null,
	ProvSpecLearnMon varchar(20) not null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		ProvSpecLearnMonOccur asc
	)
)
go

create view Valid.LearnerDenorm
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
			lda.LearnFAMCode as LDA,
			mcf.LearnFAMCode as MCF,
			ProvSpecMon_A.ProvSpecLearnMon AS ProvSpecLearnMon_A,
			ProvSpecMon_B.ProvSpecLearnMon AS ProvSpecLearnMon_B
	from	Valid.Learner as l
				left join (	select	LearnRefNumber,
									UKPRN,
									max(LSR1) as LSR1,
									max(LSR2) as LSR2,
									max(LSR3) as LSR3,
									max(LSR4) as LSR4
							from	(select	LearnRefNumber,
											UKPRN,
											case row_number() over (partition by LearnRefNumber, UKPRN order by LearnRefNumber, UKPRN) when 1 
												then LearnFAMCode 
												else null 
											end as LSR1,
											case row_number() over (partition by LearnRefNumber, UKPRN order by LearnRefNumber, UKPRN) when 2 
												then LearnFAMCode 
												else null 
											end as LSR2,
											case row_number() over (partition by LearnRefNumber, UKPRN order by LearnRefNumber, UKPRN) when 3 
												then LearnFAMCode 
												else null 
											end as LSR3,
											case row_number() over (partition by LearnRefNumber, UKPRN order by LearnRefNumber, UKPRN) when 4 
												then LearnFAMCode 
												else null 
											end as LSR4
									from	Valid.LearnerFAM
									where	LearnFAMType='LSR'
									) as LSRs
							group by
									LearnRefNumber,
									UKPRN
							) as LSR on LSR.LearnRefNumber = l.LearnRefNumber and LSR.UKPRN = l.UKPRN
				left join ( select LearnRefNumber,
									UKPRN,
									max(NLM1) as NLM1,
									max(NLM2) as NLM2
							from	(select	LearnRefNumber,
											UKPRN,
											case row_number() over (partition by LearnRefNumber, UKPRN order by LearnRefNumber, UKPRN) when 1 
												then LearnFAMCode 
												else null 
											end as NLM1,
											case row_number() over (partition by LearnRefNumber, UKPRN order by LearnRefNumber, UKPRN) when 2 
												then LearnFAMCode 
												else null 
											end as NLM2
									from	Valid.LearnerFAM
									where	LearnFAMType='NLM'
									) as NLMs
							group by
									LearnRefNumber,
									UKPRN
							) as NLM on NLM.LearnRefNumber = l.LearnRefNumber and NLM.UKPRN = l.UKPRN
				left join (select	LearnRefNumber,
									UKPRN,
									max(PPE1) as PPE1,
									max(PPE2) as PPE2
							from	(select	LearnRefNumber,
											UKPRN,
											case row_number() over (partition by LearnRefNumber, UKPRN order by LearnRefNumber, UKPRN) when 1 
												then LearnFAMCode 
												else null 
											end as PPE1,
											case row_number() over (partition by LearnRefNumber, UKPRN order by LearnRefNumber, UKPRN) when 2 
												then LearnFAMCode 
												else null 
											end as PPE2
									from	Valid.LearnerFAM
									where	LearnFAMType='PPE'
									) as PPEs
							group by
									LearnRefNumber,
									UKPRN
							) as PPE on PPE.LearnRefNumber = l.LearnRefNumber and PPE.UKPRN = l.UKPRN
				left join (	select	LearnRefNumber,
									UKPRN,
									max(EDF1) as EDF1,
									max(EDF2) as EDF2
							from	(select	LearnRefNumber,
											UKPRN,
											case row_number() over (partition by LearnRefNumber, UKPRN order by LearnRefNumber, UKPRN) when 1 
												then LearnFAMCode 
												else null 
											end as EDF1,
											case row_number() over (partition by LearnRefNumber, UKPRN order by LearnRefNumber, UKPRN) when 2 
												then LearnFAMCode 
												else null 
											end as EDF2
									from	Valid.LearnerFAM
									where	LearnFAMType='EDF'
									) as EDFs
							group by
									UKPRN,
									LearnRefNumber
							) as EDF on EDF.LearnRefNumber=l.LearnRefNumber and EDF.UKPRN = l.UKPRN
				left join Valid.LearnerFAM as ehc 
					on ehc.LearnRefNumber = l.LearnRefNumber
						and ehc.LearnFAMType = 'EHC' 
						and ehc.UKPRN = l.UKPRN
				left join Valid.LearnerFAM as ecf 
					on ecf.LearnRefNumber = l.LearnRefNumber
						and ecf.LearnFAMType = 'ECF'
						and ecf.UKPRN = l.UKPRN
				left join Valid.LearnerFAM as hns 
					on hns.LearnRefNumber = l.LearnRefNumber
						and hns.LearnFAMType = 'HNS'
						and hns.UKPRN = l.UKPRN
				left join Valid.LearnerFAM as lda 
					on lda.LearnRefNumber = l.LearnRefNumber
						and lda.LearnFAMType = 'LDA'
						and lda.UKPRN = l.UKPRN
				left join Valid.LearnerFAM as mcf 
					on mcf.LearnRefNumber = l.LearnRefNumber
						and mcf.LearnFAMType = 'MCF'
						and mcf.UKPRN = l.UKPRN
				left join Valid.ProviderSpecLearnerMonitoring as ProvSpecMon_A 
					on ProvSpecMon_A.LearnRefNumber = l.LearnRefNumber
						and ProvSpecMon_A.ProvSpecLearnMonOccur='A'
						and ProvSpecMon_A.UKPRN = l.UKPRN
				left join Valid.ProviderSpecLearnerMonitoring as ProvSpecMon_B 
					on ProvSpecMon_B.LearnRefNumber = l.LearnRefNumber
						and ProvSpecMon_B.ProvSpecLearnMonOccur='B'
						and ProvSpecMon_B.UKPRN = l.UKPRN
go

create table Valid.LearnerEmploymentStatus (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	EmpStat int null,
	DateEmpStatApp date not null,
	EmpId int null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		DateEmpStatApp asc
	)
)
go

create table Valid.EmploymentStatusMonitoring (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	DateEmpStatApp date not null,
	ESMType varchar(3) not null,
	ESMCode int null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		DateEmpStatApp asc,
		ESMType asc
	)
) 
go

create view Valid.LearnerEmploymentStatusDenorm
as
	select	les.UKPRN,
			les.LearnRefNumber,
			les.EmpStat,
			les.DateEmpStatApp,
			EmpStatMon_BSI.ESMCode AS ESMCode_BSI,
			EmpStatMon_EII.ESMCode AS ESMCode_EII,
			EmpStatMon_LOE.ESMCode AS ESMCode_LOE,
			EmpStatMon_LOU.ESMCode AS ESMCode_LOU,
			EmpStatMon_PEI.ESMCode AS ESMCode_PEI,
			EmpStatMon_SEI.ESMCode AS ESMCode_SEI,
			EmpStatMon_SEM.ESMCode AS ESMCode_SEM
	from	Valid.LearnerEmploymentStatus as les
				left join Valid.EmploymentStatusMonitoring as EmpStatMon_BSI
					on EmpStatMon_BSI.LearnRefNumber=les.LearnRefNumber
						and EmpStatMon_BSI.UKPRN = les.UKPRN
						and EmpStatMon_BSI.ESMType='BSI'
				left join Valid.EmploymentStatusMonitoring as EmpStatMon_EII
					on EmpStatMon_EII.LearnRefNumber=les.LearnRefNumber
						and EmpStatMon_EII.UKPRN = les.UKPRN
						and EmpStatMon_EII.ESMType='EII'
				left join Valid.EmploymentStatusMonitoring as EmpStatMon_LOE
					on EmpStatMon_LOE.LearnRefNumber=les.LearnRefNumber
						and EmpStatMon_LOE.UKPRN = les.UKPRN
						and EmpStatMon_LOE.ESMType='LOE'
				left join Valid.EmploymentStatusMonitoring as EmpStatMon_LOU
					on EmpStatMon_LOU.LearnRefNumber=les.LearnRefNumber
						and EmpStatMon_LOU.UKPRN = les.UKPRN
						and EmpStatMon_LOU.ESMType='LOU'
				left join Valid.EmploymentStatusMonitoring as EmpStatMon_PEI
					on EmpStatMon_PEI.LearnRefNumber=les.LearnRefNumber
						and EmpStatMon_PEI.UKPRN = les.UKPRN
						and EmpStatMon_PEI.ESMType='PEI'
				left join Valid.EmploymentStatusMonitoring as EmpStatMon_SEI
					on EmpStatMon_SEI.LearnRefNumber=les.LearnRefNumber
						and EmpStatMon_SEI.UKPRN = les.UKPRN
						and EmpStatMon_SEI.ESMType='SEI'
				left join Valid.EmploymentStatusMonitoring as EmpStatMon_SEM
					on EmpStatMon_SEM.LearnRefNumber=les.LearnRefNumber
						and EmpStatMon_SEM.ESMType='SEM'
go

create table Valid.LearningDelivery (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	LearnAimRef varchar(8) not null,
	AimType int not null,
	AimSeqNumber int not null,
	LearnStartDate date not null,
	OrigLearnStartDate date null,
	LearnPlanEndDate date not null,
	FundModel int not null,
	PHours bigint null,
	OTJActHours bigint null,
	ProgType int null,
	FworkCode int null,
	PwayCode int null,
	StdCode int null,
	PartnerUKPRN int null,
	DelLocPostCode varchar(8) null,
	LSDPostcode varchar(8) null,
	AddHours int null,
	PriorLearnFundAdj int null,
	OtherFundAdj int null,
	ConRefNumber varchar(20) null,
	EPAOrgID varchar(7) null,
	EmpOutcome int null,
	CompStatus int not null,
	LearnActEndDate date null,
	WithdrawReason int null,
	Outcome int null,
	AchDate date null,
	OutGrade varchar(6) null,
	SWSupAimId varchar(36) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

create table Valid.LearningDeliveryFAM (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	LearnDelFAMType varchar(3) not null,
	LearnDelFAMCode varchar(5) not null,
	LearnDelFAMDateFrom date null,
	LearnDelFAMDateTo date null
)
go

create table Valid.ProviderSpecDeliveryMonitoring (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	ProvSpecDelMonOccur varchar(1) not null,
	ProvSpecDelMon varchar(20) not null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		ProvSpecDelMonOccur asc
	)
) 
go

create view Valid.LearningDeliveryDenorm
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
		ld.PHours,
		ld.OTJActHours,
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
		LDFAM_SOF.LearnDelFAMCode AS LDFAM_SOF,
		LDFAM_EEF.LearnDelFAMCode AS LDFAM_EEF,
		LDFAM_RES.LearnDelFAMCode AS LDFAM_RES,
		LDFAM_ADL.LearnDelFAMCode AS LDFAM_ADL,
		LDFAM_FFI.LearnDelFAMCode AS LDFAM_FFI,
		LDFAM_SPP.LearnDelFAMCode AS LDFAM_SPP,
		ProvSpecMon_A.ProvSpecDelMon AS ProvSpecDelMon_A,
		ProvSpecMon_B.ProvSpecDelMon	AS ProvSpecDelMon_B,
		ProvSpecMon_C.ProvSpecDelMon	AS ProvSpecDelMon_C,
		ProvSpecMon_D.ProvSpecDelMon	AS ProvSpecDelMon_D,
		LDM.LDM1,
		LDM.LDM2,
		LDM.LDM3,
		LDM.LDM4
from	Valid.LearningDelivery as ld
			left join (select	UKPRN,
								LearnRefNumber,
								AimSeqNumber,
								max(HEM1) as HEM1,
								max(HEM2) as HEM2,
								max(HEM3) as HEM3
						from	(	select	UKPRN,
											LearnRefNumber,
											AimSeqNumber,
											case row_number() over (partition by LearnRefNumber, AimSeqNumber order by LearnRefNumber, AimSeqNumber) when 1 
												then LearnDelFAMCode 
												else null 
											end as HEM1,
											case row_number() over (partition by LearnRefNumber, AimSeqNumber order by LearnRefNumber, AimSeqNumber) when 2 
												then LearnDelFAMCode 
												else null 
											end as HEM2,
											case row_number() over (partition by LearnRefNumber, AimSeqNumber order by LearnRefNumber, AimSeqNumber) when 3 
												then LearnDelFAMCode 
												else null 
											end as HEM3
									from	Valid.LearningDeliveryFAM
									where	LearnDelFAMType='HEM'
								) as HEMs
						group by
								UKPRN,
								LearnRefNumber,
								AimSeqNumber
					) as HEM on HEM.LearnRefNumber=ld.LearnRefNumber
						and HEM.AimSeqNumber=ld.AimSeqNumber
						and HEM.UKPRN = ld.UKPRN
			left join (	select	UKPRN,
								LearnRefNumber, 
								AimSeqNumber,
								max(HHS1) as HHS1,
								max(HHS2) as HHS2
						from	(select	UKPRN,
										LearnRefNumber,
										AimSeqNumber,
										case row_number() over (partition by LearnRefNumber, AimSeqNumber, UKPRN order by LearnRefNumber, AimSeqNumber, UKPRN) when 1 
											then LearnDelFAMCode 
											else null 
										end as HHS1,
										case row_number() over (partition by LearnRefNumber, AimSeqNumber, UKPRN order by LearnRefNumber, AimSeqNumber, UKPRN) when 2 
											then LearnDelFAMCode 
											else null 
										end as HHS2
								from	Valid.LearningDeliveryFAM
								where	LearnDelFAMType='HHS'
								) as HHSs
						group by
								UKPRN,
								LearnRefNumber,
								AimSeqNumber
					) as HHS on HHS.LearnRefNumber=ld.LearnRefNumber
						and HHS.AimSeqNumber=ld.AimSeqNumber
						and HHS.UKPRN = ld.UKPRN

			left join Valid.LearningDeliveryFAM AS LDFAM_SOF 
				on ld.LearnRefNumber = LDFAM_SOF.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_SOF.AimSeqNumber
					and LDFAM_SOF.UKPRN = ld.UKPRN
					and LDFAM_SOF.LearnDelFAMType = 'SOF'
			left join Valid.LearningDeliveryFAM AS LDFAM_EEF 
				on ld.LearnRefNumber = LDFAM_EEF.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_EEF.AimSeqNumber
					and ld.UKPRN = LDFAM_EEF.UKPRN
					and LDFAM_EEF.LearnDelFAMType = 'EEF'
			left join Valid.LearningDeliveryFAM AS LDFAM_RES 
				on ld.LearnRefNumber = LDFAM_RES.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_RES.AimSeqNumber
					and ld.UKPRN = LDFAM_RES.UKPRN
					and LDFAM_RES.LearnDelFAMType = 'RES'
			left join Valid.LearningDeliveryFAM AS LDFAM_ADL 
				on ld.LearnRefNumber = LDFAM_ADL.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_ADL.AimSeqNumber
					and ld.UKPRN = LDFAM_ADL.UKPRN
					and LDFAM_ADL.LearnDelFAMType = 'ADL'
			left join Valid.LearningDeliveryFAM AS LDFAM_FFI 
				on ld.LearnRefNumber = LDFAM_FFI.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_FFI.AimSeqNumber
					and LDFAM_FFI.UKPRN = ld.UKPRN
					and LDFAM_FFI.LearnDelFAMType = 'FFI'
			left join Valid.LearningDeliveryFAM AS LDFAM_SPP 
				on ld.LearnRefNumber = LDFAM_SPP.LearnRefNumber
					and ld.AimSeqNumber = LDFAM_SPP.AimSeqNumber
					and LDFAM_SPP.UKPRN = ld.UKPRN
					and LDFAM_SPP.LearnDelFAMType = 'SPP'

			left join Valid.ProviderSpecDeliveryMonitoring as ProvSpecMon_A
				on ProvSpecMon_A.LearnRefNumber=ld.LearnRefNumber
					and ProvSpecMon_A.AimSeqNumber=ld.AimSeqNumber
					and ProvSpecMon_A.UKPRN = ld.UKPRN
					and ProvSpecMon_A.ProvSpecDelMonOccur='A'
			left join Valid.ProviderSpecDeliveryMonitoring as ProvSpecMon_B
				on ProvSpecMon_B.LearnRefNumber=ld.LearnRefNumber
					and ProvSpecMon_B.AimSeqNumber=ld.AimSeqNumber
					and ProvSpecMon_B.UKPRN = ld.UKPRN
					and ProvSpecMon_B.ProvSpecDelMonOccur='B'
			left join Valid.ProviderSpecDeliveryMonitoring as ProvSpecMon_C
				on ProvSpecMon_C.LearnRefNumber=ld.LearnRefNumber
					and ProvSpecMon_C.AimSeqNumber=ld.AimSeqNumber
					and ProvSpecMon_C.UKPRN = ld.UKPRN
					and ProvSpecMon_C.ProvSpecDelMonOccur='C'
			left join Valid.ProviderSpecDeliveryMonitoring as ProvSpecMon_D
				on ProvSpecMon_D.LearnRefNumber=ld.LearnRefNumber
					and ProvSpecMon_D.AimSeqNumber=ld.AimSeqNumber
					and ProvSpecMon_D.UKPRN = ld.UKPRN
					and ProvSpecMon_D.ProvSpecDelMonOccur='D' 
			left join (	select	UKPRN,
								LearnRefNumber,
								AimSeqNumber,
								max(LDM1) as LDM1,
								max(LDM2) as LDM2,
								max(LDM3) as LDM3,
								max(LDM4) as LDM4
						from	(	select	UKPRN,
											LearnRefNumber,
											AimSeqNumber,
											case row_number() over (partition by LearnRefNumber, AimSeqNumber, UKPRN order by LearnRefNumber, AimSeqNumber, UKPRN) when 1 
												then LearnDelFAMCode 
												else null 
											end as LDM1,
											case row_number() over (partition by LearnRefNumber, AimSeqNumber, UKPRN order by LearnRefNumber, AimSeqNumber, UKPRN) when 2 
												then LearnDelFAMCode 
												else null 
											end as LDM2,
											case row_number() over (partition by LearnRefNumber, AimSeqNumber, UKPRN order by LearnRefNumber, AimSeqNumber, UKPRN) when 3 
												then LearnDelFAMCode 
												else null 
											end as LDM3,
											case row_number() over (partition by LearnRefNumber, AimSeqNumber, UKPRN order by LearnRefNumber, AimSeqNumber, UKPRN) when 4 
												then LearnDelFAMCode 
												else null 
											end as LDM4
									from	Valid.LearningDeliveryFAM
									where	LearnDelFAMType='LDM'
								) as LDMs
						group by
								UKPRN,
								LearnRefNumber,
								AimSeqNumber
					) as LDM on LDM.LearnRefNumber=ld.LearnRefNumber
							and LDM.UKPRN = ld.UKPRN
							and LDM.AimSeqNumber = ld.AimSeqNumber
go

create table Valid.AppFinRecord (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AFinType varchar(3) not null,
	AFinCode int not null,
	AFinDate date not null,
	AFinAmount int not null
)
go

create view Valid.TrailblazerApprenticeshipFinancialRecord
as
	select	UKPRN,
			LearnRefNumber,
			AimSeqNumber,
			AFinType as TBFinType,
			AFinCode as TBFinCode,
			AFinAmount as TBFinAmount,
			AFinDate as TBFinDate
	from	Valid.AppFinRecord
go

create table dbo.ValidationError (
	Id int identity(1,1) not null,
	UKPRN int null,
	[Source] varchar(50) null,
	LearnAimRef varchar(1000) null,
	AimSeqNum bigint null,
	SWSupAimID varchar(1000) null,
	ErrorMessage nvarchar(max) null,
	FieldValues nvarchar(2000) null,
	LearnRefNumber varchar(100) null,
	RuleName varchar(50) null,
	Severity varchar(2) null,
	FileLevelError int null
) 
go

create table Invalid.AppFinRecord (
	AppFinRecord_Id int null,
	UKPRN int null,
	LearningDelivery_Id int null,
	LearnRefNumber varchar(100) null,
	AimSeqNumber bigint null,
	AFinType varchar(100) null,
	AFinCode bigint null,
	AFinDate date null,
	AFinAmount bigint null
)
go

create table Invalid.CollectionDetails (
	CollectionDetails_Id int null,
	UKPRN int null,
	[Collection] varchar(3) null,
	[Year] varchar(4) null,
	FilePreparationDate date null
)
go

create table Invalid.ContactPreference (
	ContactPreference_Id int null,
	Learner_Id int null,
	UKPRN int null,
	LearnRefNumber varchar(100) null,
	ContPrefType varchar(100) null,
	ContPrefCode bigint null
)
go

create table Invalid.DPOutcome (
	DPOutcome_Id int null,
	UKPRN int null,
	LearnerDestinationandProgression_Id int null,
	LearnRefNumber varchar(100) null,
	OutType varchar(100) null,
	OutCode bigint null,
	OutStartDate date null,
	OutEndDate date null,
	OutCollDate date null
)
go

create table Invalid.EmploymentStatusMonitoring (
	EmploymentStatusMonitoring_Id int null,
	LearnerEmploymentStatus_Id int null,
	UKPRN int null,
	LearnRefNumber varchar(100) null,
	DateEmpStatApp date null,
	ESMType varchar(100) null,
	ESMCode bigint null
)
go

create table Invalid.Learner (
	Learner_Id int null,
	LearnRefNumber varchar(100) null,
	UKPRN int null,
	PrevLearnRefNumber varchar(1000) null,
	PrevUKPRN bigint null,
	PMUKPRN bigint null,
	CampId varchar(1000) null,
	ULN bigint null,
	FamilyName varchar(1000) null,
	GivenNames varchar(1000) null,
	DateOfBirth date null,
	Ethnicity bigint null,
	Sex varchar(1000) null,
	LLDDHealthProb bigint null,
	NINumber varchar(1000) null,
	PriorAttain bigint null,
	Accom bigint null,
	ALSCost bigint null,
	PlanLearnHours bigint null,
	PlanEEPHours bigint null,
	MathGrade varchar(1000) null,
	EngGrade varchar(1000) null,
	PostcodePrior varchar(1000) null,
	Postcode varchar(1000) null,
	AddLine1 varchar(1000) null,
	AddLine2 varchar(1000) null,
	AddLine3 varchar(1000) null,
	AddLine4 varchar(1000) null,
	TelNo varchar(1000) null,
	Email varchar(1000) null
)
go

create table Invalid.LearnerDestinationandProgression (
	LearnerDestinationandProgression_Id int null,
	UKPRN int null,
	LearnRefNumber varchar(100) null,
	ULN bigint null
)
go

create table Invalid.LearnerEmploymentStatus (
	LearnerEmploymentStatus_Id int null,
	Learner_Id int null,
	UKPRN int null,
	LearnRefNumber varchar(100) null,
	EmpStat bigint null,
	DateEmpStatApp date null,
	EmpId bigint null
)
go

create table Invalid.LearnerFAM (
	LearnerFAM_Id int null,
	Learner_Id int null,
	UKPRN int null,
	LearnRefNumber varchar(100) null,
	LearnFAMType varchar(1000) null,
	LearnFAMCode bigint null
)
go

create table Invalid.LearnerHE (
	LearnerHE_Id int null,
	Learner_Id int null,
	UKPRN int null,
	LearnRefNumber varchar(100) null,
	UCASPERID varchar(1000) null,
	TTACCOM bigint null
)
go

create table Invalid.LearnerHEFinancialSupport (
	LearnerHEFinancialSupport_Id int null,
	LearnerHE_Id int null,
	UKPRN int null,
	LearnRefNumber varchar(100) null,
	FINTYPE bigint null,
	FINAMOUNT bigint null
)
go

create table Invalid.LearningDelivery (
	LearningDelivery_Id int null,
	Learner_Id int null,
	UKPRN int null,
	LearnRefNumber varchar(100) null,
	LearnAimRef varchar(1000) null,
	AimType bigint null,
	AimSeqNumber bigint null,
	LearnStartDate date null,
	OrigLearnStartDate date null,
	LearnPlanEndDate date null,
	FundModel bigint null,
	PHours bigint null,
	OTJActHours bigint null,
	ProgType bigint null,
	FworkCode bigint null,
	PwayCode bigint null,
	StdCode bigint null,
	PartnerUKPRN bigint null,
	DelLocPostCode varchar(1000) null,
	LSDPostcode varchar(1000) null,
	AddHours bigint null,
	PriorLearnFundAdj bigint null,
	OtherFundAdj bigint null,
	ConRefNumber varchar(1000) null,
	EPAOrgID varchar(1000) null,
	EmpOutcome bigint null,
	CompStatus bigint null,
	LearnActEndDate date null,
	WithdrawReason bigint null,
	Outcome bigint null,
	AchDate date null,
	OutGrade varchar(1000) null,
	SWSupAimId varchar(1000) null
)
go

create table Invalid.LearningDeliveryFAM (
	LearningDeliveryFAM_Id int null,
	LearningDelivery_Id int null,
	UKPRN int null,
	LearnRefNumber varchar(100) null,
	AimSeqNumber bigint null,
	LearnDelFAMType varchar(100) null,
	LearnDelFAMCode varchar(1000) null,
	LearnDelFAMDateFrom date null,
	LearnDelFAMDateTo date null
)
go

create table Invalid.LearningDeliveryHE (
	LearningDeliveryHE_Id int null,
	UKPRN int null,
	LearningDelivery_Id int null,
	LearnRefNumber varchar(100) null,
	AimSeqNumber bigint null,
	NUMHUS varchar(1000) null,
	SSN varchar(1000) null,
	QUALENT3 varchar(1000) null,
	SOC2000 bigint null,
	SEC bigint null,
	UCASAPPID varchar(1000) null,
	TYPEYR bigint null,
	MODESTUD bigint null,
	FUNDLEV bigint null,
	FUNDCOMP bigint null,
	STULOAD float null,
	YEARSTU bigint null,
	MSTUFEE bigint null,
	PCOLAB float null,
	PCFLDCS float null,
	PCSLDCS float null,
	PCTLDCS float null,
	SPECFEE bigint null,
	NETFEE bigint null,
	GROSSFEE bigint null,
	DOMICILE varchar(1000) null,
	ELQ bigint null,
	HEPostCode varchar(1000) null
)
go

create table Invalid.LearningDeliveryWorkPlacement (
	LearningDeliveryWorkPlacement_Id int null,
	LearningDelivery_Id int null,
	UKPRN int null,
	LearnRefNumber varchar(100) null,
	AimSeqNumber bigint null,
	WorkPlaceStartDate date null,
	WorkPlaceEndDate date null,
	WorkPlaceHours bigint null,
	WorkPlaceMode bigint null,
	WorkPlaceEmpId bigint null
)
go

create table Invalid.LearningProvider (
	LearningProvider_Id int null,
	UKPRN int null
)
go

create table Invalid.LLDDandHealthProblem (
	LLDDandHealthProblem_Id int null,
	Learner_Id int null,
	UKPRN int null,
	LearnRefNumber varchar(100) null,
	LLDDCat bigint null,
	PrimaryLLDD bigint null
)
go

create table Invalid.ProviderSpecDeliveryMonitoring (
	ProviderSpecDeliveryMonitoring_Id int null,
	UKPRN int null,
	LearningDelivery_Id int null,
	LearnRefNumber varchar(100) null,
	AimSeqNumber bigint null,
	ProvSpecDelMonOccur varchar(100) null,
	ProvSpecDelMon varchar(1000) null
)
go

create table Invalid.ProviderSpecLearnerMonitoring (
	ProviderSpecLearnerMonitoring_Id int null,
	Learner_Id int null,
	UKPRN int null,
	LearnRefNumber varchar(100) null,
	ProvSpecLearnMonOccur varchar(100) null,
	ProvSpecLearnMon varchar(1000) null
)
go

create table Invalid.[Source] (
	Source_Id int null,
	ProtectiveMarking varchar(30) null,
	UKPRN int null,
	SoftwareSupplier varchar(40) null,
	SoftwarePackage varchar(30) null,
	Release varchar(20) null,
	SerialNo varchar(2) null,
	[DateTime] datetime null,
	ReferenceData varchar(100) null,
	ComponentSetVersion varchar(20) null
)
go

create table Invalid.SourceFile (
	SourceFile_Id int null,
	UKPRN int null,
	SourceFileName varchar(50) null,
	FilePreparationDate date null,
	SoftwareSupplier varchar(40) null,
	SoftwarePackage varchar(30) null,
	Release varchar(20) null,
	SerialNo varchar(2) null,
	[DateTime] datetime null
)
go

create table Rulebase.AEC_ApprenticeshipPriceEpisode (
	UKPRN int not null,
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
		UKPRN asc,
		LearnRefNumber asc,
		PriceEpisodeIdentifier asc
	)
)
go

create table Rulebase.AEC_ApprenticeshipPriceEpisode_Period (
	UKPRN int not null,
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
	PriceEpisodeESFAContribPct decimal(12,5),
	PriceEpisodeTotProgFunding decimal(12,5),
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		PriceEpisodeIdentifier asc,
		[Period] asc
	)
)
go

create table Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	PriceEpisodeIdentifier varchar(25) not null,
	AttributeName varchar(100) not null,
	Period_1 decimal(15, 5),
	Period_2 decimal(15, 5),
	Period_3 decimal(15, 5),
	Period_4 decimal(15, 5),
	Period_5 decimal(15, 5),
	Period_6 decimal(15, 5),
	Period_7 decimal(15, 5),
	Period_8 decimal(15, 5),
	Period_9 decimal(15, 5),
	Period_10 decimal(15, 5),
	Period_11 decimal(15, 5),
	Period_12 decimal(15, 5),
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		PriceEpisodeIdentifier asc,
		AttributeName asc
	)
)
go

create table Rulebase.AEC_global (
	UKPRN int not null,
	LARSVersion varchar(100) not null,
	RulebaseVersion varchar(10) not null,
	[Year] varchar(4) not null,
	primary key clustered (
		UKPRN asc
	)
)
go

create table Rulebase.AEC_HistoricEarningOutput (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AppIdentifierOutput varchar(10) not null,
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
		UKPRN asc,
		LearnRefNumber asc,
		AppIdentifierOutput asc
	)
)
go

create table Rulebase.AEC_LearningDelivery (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
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
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

create table Rulebase.AEC_LearningDelivery_Period (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	[Period] int not null,
	DisadvFirstPayment decimal(10, 5) null,
	DisadvSecondPayment decimal(10, 5) null,
	FundLineType varchar(100) null,
	InstPerPeriod int null,
	LDApplic1618FrameworkUpliftBalancingPayment decimal(10, 5) null,
	LDApplic1618FrameworkUpliftCompletionPayment decimal(10, 5) null,
	LDApplic1618FrameworkUpliftOnProgPayment decimal(10, 5) null,
	LearnDelContType varchar(50) null,
	LearnDelFirstEmp1618Pay decimal(10, 5) null,
	LearnDelFirstProv1618Pay decimal(10, 5) null,
	LearnDelLevyNonPayInd int null,
	LearnDelSecondEmp1618Pay decimal(10, 5) null,
	LearnDelSecondProv1618Pay decimal(10, 5) null,
	LearnDelSEMContWaiver bit null,
	LearnDelSFAContribPct decimal(10, 5) null,
	LearnDelESFAContribPct decimal(10, 5) null,
	LearnSuppFund bit null,
	LearnSuppFundCash decimal(10, 5) null,
	MathEngBalPayment decimal(10, 5) null,
	MathEngOnProgPayment decimal(10, 5) null,
	ProgrammeAimBalPayment decimal(10, 5) null,
	ProgrammeAimCompletionPayment decimal(10, 5) null,
	ProgrammeAimOnProgPayment decimal(10, 5) null,
	ProgrammeAimProgFundIndMaxEmpCont decimal(12, 5) null,
	ProgrammeAimProgFundIndMinCoInvest decimal(12, 5) null,
	ProgrammeAimTotProgFund decimal(12, 5) null,
	LearnDelLearnAddPayment decimal(12,5),
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		[Period] asc
	)
)
go

create table Rulebase.AEC_LearningDelivery_PeriodisedTextValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AttributeName varchar(100) not null,
	Period_1 varchar(255) null,
	Period_2 varchar(255) null,
	Period_3 varchar(255) null,
	Period_4 varchar(255) null,
	Period_5 varchar(255) null,
	Period_6 varchar(255) null,
	Period_7 varchar(255) null,
	Period_8 varchar(255) null,
	Period_9 varchar(255) null,
	Period_10 varchar(255) null,
	Period_11 varchar(255) null,
	Period_12 varchar(255) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		AttributeName asc
	)
)
go

create table Rulebase.AEC_LearningDelivery_PeriodisedValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AttributeName varchar(100) not null,
	Period_1 decimal(15, 5) null,
	Period_2 decimal(15, 5) null,
	Period_3 decimal(15, 5) null,
	Period_4 decimal(15, 5) null,
	Period_5 decimal(15, 5) null,
	Period_6 decimal(15, 5) null,
	Period_7 decimal(15, 5) null,
	Period_8 decimal(15, 5) null,
	Period_9 decimal(15, 5) null,
	Period_10 decimal(15, 5) null,
	Period_11 decimal(15, 5) null,
	Period_12 decimal(15, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		AttributeName asc
	)
)
go

create table Rulebase.ALB_global (
	UKPRN int not null,
	LARSVersion varchar(100) null,
	PostcodeAreaCostVersion varchar(20) null,
	RulebaseVersion varchar(10) null,
	primary key clustered (
		UKPRN asc
	)
)
go

create table Rulebase.ALB_Learner_Period (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	[Period] int not null,
	ALBSeqNum int null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		[Period] asc
	)
)
go

create table Rulebase.ALB_Learner_PeriodisedValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AttributeName varchar(100) not null,
	Period_1 decimal(15, 5) null,
	Period_2 decimal(15, 5) null,
	Period_3 decimal(15, 5) null,
	Period_4 decimal(15, 5) null,
	Period_5 decimal(15, 5) null,
	Period_6 decimal(15, 5) null,
	Period_7 decimal(15, 5) null,
	Period_8 decimal(15, 5) null,
	Period_9 decimal(15, 5) null,
	Period_10 decimal(15, 5) null,
	Period_11 decimal(15, 5) null,
	Period_12 decimal(15, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AttributeName asc
	)
)
go

create table Rulebase.ALB_LearningDelivery (
	UKPRN bigint not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AreaCostFactAdj decimal(10, 5) null,
	WeightedRate decimal(12, 5) null,
	PlannedNumOnProgInstalm int null,
	FundStart bit null,
	Achieved bit null,
	ActualNumInstalm int null,
	OutstndNumOnProgInstalm int null,
	AreaCostInstalment decimal(12, 5) null,
	AdvLoan bit null,
	LoanBursAreaUplift bit null,
	LoanBursSupp bit null,
	FundLine varchar(50) null,
	LiabilityDate date null,
	ApplicProgWeightFact varchar(1) null,
	ApplicFactDate date null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

create table Rulebase.ALB_LearningDelivery_Period (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	[Period] int not null,
	ALBCode int null,
	ALBSupportPayment decimal(10, 5) null,
	AreaUpliftBalPayment decimal(10, 5) null,
	AreaUpliftOnProgPayment decimal(10, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		[Period] asc
	)
)
go

create table Rulebase.ALB_LearningDelivery_PeriodisedValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AttributeName varchar(100) not null,
	Period_1 decimal(15, 5) null,
	Period_2 decimal(15, 5) null,
	Period_3 decimal(15, 5) null,
	Period_4 decimal(15, 5) null,
	Period_5 decimal(15, 5) null,
	Period_6 decimal(15, 5) null,
	Period_7 decimal(15, 5) null,
	Period_8 decimal(15, 5) null,
	Period_9 decimal(15, 5) null,
	Period_10 decimal(15, 5) null,
	Period_11 decimal(15, 5) null,
	Period_12 decimal(15, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		AttributeName asc
	)
)
go

create table Rulebase.DV_global (
	UKPRN int null,
	RulebaseVersion varchar(10) null
)
go

create table Rulebase.DV_Learner (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	Learn_3rdSector int null,
	Learn_Active int null,
	Learn_ActiveJan int null,
	Learn_ActiveNov int null,
	Learn_ActiveOct int null,
	Learn_Age31Aug int null,
	Learn_BasicSkill int null,
	Learn_EmpStatFDL int null,
	Learn_EmpStatPrior int null,
	Learn_FirstFullLevel2 int null,
	Learn_FirstFullLevel2Ach int null,
	Learn_FirstFullLevel3 int null,
	Learn_FirstFullLevel3Ach int null,
	Learn_FullLevel2 int null,
	Learn_FullLevel2Ach int null,
	Learn_FullLevel3 int null,
	Learn_FullLevel3Ach int null,
	Learn_FundAgency int null,
	Learn_FundingSource int null,
	Learn_FundPrvYr int null,
	Learn_ILAcMonth1 int null,
	Learn_ILAcMonth10 int null,
	Learn_ILAcMonth11 int null,
	Learn_ILAcMonth12 int null,
	Learn_ILAcMonth2 int null,
	Learn_ILAcMonth3 int null,
	Learn_ILAcMonth4 int null,
	Learn_ILAcMonth5 int null,
	Learn_ILAcMonth6 int null,
	Learn_ILAcMonth7 int null,
	Learn_ILAcMonth8 int null,
	Learn_ILAcMonth9 int null,
	Learn_ILCurrAcYr int null,
	Learn_LargeEmployer int null,
	Learn_LenEmp int null,
	Learn_LenUnemp int null,
	Learn_LrnAimRecords int null,
	Learn_ModeAttPlanHrs int null,
	Learn_NotionLev int null,
	Learn_NotionLevV2 int null,
	Learn_OLASS int null,
	Learn_PrefMethContact int null,
	Learn_PrimaryLLDD int null,
	Learn_PriorEducationStatus int null,
	Learn_UnempBenFDL int null,
	Learn_UnempBenPrior int null,
	Learn_Uplift1516EFA decimal(6, 5) null,
	Learn_Uplift1516SFA decimal(6, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc
	)
)
go

create table Rulebase.DV_LearningDelivery (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	LearnDel_AccToApp int null,
	LearnDel_AccToAppEmpDate date null,
	LearnDel_AccToAppEmpStat int null,
	LearnDel_AchFullLevel2Pct decimal(5, 2) null,
	LearnDel_AchFullLevel3Pct decimal(5, 2) null,
	LearnDel_Achieved int null,
	LearnDel_AchievedIY int null,
	LearnDel_AcMonthYTD varchar(2) null,
	LearnDel_ActDaysILAfterCurrAcYr int null,
	LearnDel_ActDaysILCurrAcYr int null,
	LearnDel_ActEndDateOnAfterJan1 int null,
	LearnDel_ActEndDateOnAfterNov1 int null,
	LearnDel_ActEndDateOnAfterOct1 int null,
	LearnDel_ActiveIY int null,
	LearnDel_ActiveJan int null,
	LearnDel_ActiveNov int null,
	LearnDel_ActiveOct int null,
	LearnDel_ActTotalDaysIL int null,
	LearnDel_AdvLoan int null,
	LearnDel_AgeAimOrigStart int null,
	LearnDel_AgeAtStart int null,
	LearnDel_App int null,
	LearnDel_App1618Fund int null,
	LearnDel_App1925Fund int null,
	LearnDel_AppAimType int null,
	LearnDel_AppKnowl int null,
	LearnDel_AppMainAim int null,
	LearnDel_AppNonFund int null,
	LearnDel_BasicSkills int null,
	LearnDel_BasicSkillsParticipation int null,
	LearnDel_BasicSkillsType int null,
	LearnDel_CarryIn int null,
	LearnDel_ClassRm int null,
	LearnDel_CompAimApp int null,
	LearnDel_CompAimProg int null,
	LearnDel_Completed int null,
	LearnDel_CompletedIY int null,
	LearnDel_CompleteFullLevel2Pct decimal(5, 2) null,
	LearnDel_CompleteFullLevel3Pct decimal(5, 2) null,
	LearnDel_EFACoreAim int null,
	LearnDel_Emp6MonthAimStart int null,
	LearnDel_Emp6MonthProgStart int null,
	LearnDel_EmpDateBeforeFDL date null,
	LearnDel_EmpDatePriorFDL date null,
	LearnDel_EmpID int null,
	LearnDel_Employed int null,
	LearnDel_EmpStatFDL int null,
	LearnDel_EmpStatPrior int null,
	LearnDel_EmpStatPriorFDL int null,
	LearnDel_EnhanAppFund int null,
	LearnDel_FullLevel2AchPct decimal(5, 2) null,
	LearnDel_FullLevel2ContPct decimal(5, 2) null,
	LearnDel_FullLevel3AchPct decimal(5, 2) null,
	LearnDel_FullLevel3ContPct decimal(5, 2) null,
	LearnDel_FuncSkills int null,
	LearnDel_FundAgency int null,
	LearnDel_FundingLineType varchar(100) null,
	LearnDel_FundingSource int null,
	LearnDel_FundPrvYr int null,
	LearnDel_FundStart int null,
	LearnDel_GCE int null,
	LearnDel_GCSE int null,
	LearnDel_ILAcMonth1 int null,
	LearnDel_ILAcMonth10 int null,
	LearnDel_ILAcMonth11 int null,
	LearnDel_ILAcMonth12 int null,
	LearnDel_ILAcMonth2 int null,
	LearnDel_ILAcMonth3 int null,
	LearnDel_ILAcMonth4 int null,
	LearnDel_ILAcMonth5 int null,
	LearnDel_ILAcMonth6 int null,
	LearnDel_ILAcMonth7 int null,
	LearnDel_ILAcMonth8 int null,
	LearnDel_ILAcMonth9 int null,
	LearnDel_ILCurrAcYr int null,
	LearnDel_IYActEndDate date null,
	LearnDel_IYPlanEndDate date null,
	LearnDel_IYStartDate date null,
	LearnDel_KeySkills int null,
	LearnDel_LargeEmpDiscountId int null,
	LearnDel_LargeEmployer int null,
	LearnDel_LastEmpDate date null,
	LearnDel_LeaveMonth int null,
	LearnDel_LenEmp int null,
	LearnDel_LenUnemp int null,
	LearnDel_LoanBursFund int null,
	LearnDel_NotionLevel int null,
	LearnDel_NotionLevelV2 int null,
	LearnDel_NumHEDatasets int null,
	LearnDel_OccupAim int null,
	LearnDel_OLASS int null,
	LearnDel_OLASSCom int null,
	LearnDel_OLASSCus int null,
	LearnDel_OrigStartDate date null,
	LearnDel_PlanDaysILAfterCurrAcYr int null,
	LearnDel_PlanDaysILCurrAcYr int null,
	LearnDel_PlanEndBeforeAug1 int null,
	LearnDel_PlanEndOnAfterJan1 int null,
	LearnDel_PlanEndOnAfterNov1 int null,
	LearnDel_PlanEndOnAfterOct1 int null,
	LearnDel_PlanTotalDaysIL int null,
	LearnDel_PriorEducationStatus int null,
	LearnDel_Prog int null,
	LearnDel_ProgAimAch int null,
	LearnDel_ProgAimApp int null,
	LearnDel_ProgCompleted int null,
	LearnDel_ProgCompletedIY int null,
	LearnDel_ProgStartDate date null,
	LearnDel_QCF int null,
	LearnDel_QCFCert int null,
	LearnDel_QCFDipl int null,
	LearnDel_QCFType int null,
	LearnDel_RegAim int null,
	LearnDel_SecSubAreaTier1 varchar(3) null,
	LearnDel_SecSubAreaTier2 varchar(5) null,
	LearnDel_SFAApproved int null,
	LearnDel_SourceFundEFA int null,
	LearnDel_SourceFundSFA int null,
	LearnDel_StartBeforeApr1 int null,
	LearnDel_StartBeforeAug1 int null,
	LearnDel_StartBeforeDec1 int null,
	LearnDel_StartBeforeFeb1 int null,
	LearnDel_StartBeforeJan1 int null,
	LearnDel_StartBeforeJun1 int null,
	LearnDel_StartBeforeMar1 int null,
	LearnDel_StartBeforeMay1 int null,
	LearnDel_StartBeforeNov1 int null,
	LearnDel_StartBeforeOct1 int null,
	LearnDel_StartBeforeSep1 int null,
	LearnDel_StartIY int null,
	LearnDel_StartJan1 int null,
	LearnDel_StartMonth int null,
	LearnDel_StartNov1 int null,
	LearnDel_StartOct1 int null,
	LearnDel_SuccRateStat int null,
	LearnDel_TrainAimType int null,
	LearnDel_TransferDiffProvider int null,
	LearnDel_TransferDiffProviderGovStrat int null,
	LearnDel_TransferProvider int null,
	LearnDel_UfIProv int null,
	LearnDel_UnempBenFDL int null,
	LearnDel_UnempBenPrior int null,
	LearnDel_Withdrawn int null,
	LearnDel_WorkplaceLocPostcode varchar(8) null,
	Prog_AccToApp int null,
	Prog_Achieved int null,
	Prog_AchievedIY int null,
	Prog_ActEndDate date null,
	Prog_ActiveIY int null,
	Prog_AgeAtStart int null,
	Prog_EarliestAim int null,
	Prog_Employed int null,
	Prog_FundPrvYr int null,
	Prog_ILCurrAcYear int null,
	Prog_LatestAim int null,
	Prog_SourceFundEFA int null,
	Prog_SourceFundSFA int null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

create table Rulebase.FM25_global (
	UKPRN int not null,
	LARSVersion varchar(50) null,
	OrgVersion varchar(50) null,
	PostcodeDisadvantageVersion varchar(50) null,
	RulebaseVersion varchar(10) null,
	primary key clustered (
		UKPRN asc
	)
)
go

create table Rulebase.FM25_Learner (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AcadMonthPayment int null,
	AcadProg bit null,
	ActualDaysILCurrYear int null,
	AreaCostFact1618Hist decimal(10, 5) null,
	Block1DisadvUpliftNew decimal(10, 5) null,
	Block2DisadvElementsNew decimal(10, 5) null,
	ConditionOfFundingEnglish varchar(100) null,
	ConditionOfFundingMaths varchar(100) null,
	CoreAimSeqNumber int null,
	FullTimeEquiv decimal(10, 5) null,
	FundLine varchar(100) null,
	LearnerActEndDate date null,
	LearnerPlanEndDate date null,
	LearnerStartDate date null,
	NatRate decimal(10, 5) null,
	OnProgPayment decimal(10, 5) null,
	PlannedDaysILCurrYear int null,
	ProgWeightHist decimal(10, 5) null,
	ProgWeightNew decimal(10, 5) null,
	PrvDisadvPropnHist decimal(10, 5) null,
	PrvHistLrgProgPropn decimal(10, 5) null,
	PrvRetentFactHist decimal(10, 5) null,
	RateBand varchar(50) null,
	RetentNew decimal(10, 5) null,
	StartFund bit null,
	ThresholdDays int null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc
	)
)
go

create table Rulebase.FM25_FM35_global (
	UKPRN int not null,
	RulebaseVersion varchar(10) null,
	primary key clustered (
		UKPRN asc
	)
)
go

create table Rulebase.FM25_FM35_Learner_Period (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	[Period] int not null,
	LnrOnProgPay decimal(10, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		[Period] asc
	)
)
go

create table Rulebase.FM25_FM35_Learner_PeriodisedValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AttributeName varchar(100) not null,
	Period_1 decimal(15, 5) null,
	Period_2 decimal(15, 5) null,
	Period_3 decimal(15, 5) null,
	Period_4 decimal(15, 5) null,
	Period_5 decimal(15, 5) null,
	Period_6 decimal(15, 5) null,
	Period_7 decimal(15, 5) null,
	Period_8 decimal(15, 5) null,
	Period_9 decimal(15, 5) null,
	Period_10 decimal(15, 5) null,
	Period_11 decimal(15, 5) null,
	Period_12 decimal(15, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AttributeName asc
	)
)
go

create table Rulebase.ESF_global (
	UKPRN int,
	RulebaseVersion varchar(10),
)
go

create table Rulebase.ESF_LearningDelivery (
	LearnRefNumber varchar(12),
	UKPRN int not null,
	AimSeqNumber int,
	Achieved bit,
	AddProgCostElig bit,
	AdjustedAreaCostFactor decimal(9,5),
	AdjustedPremiumFactor decimal(9,5),
	AdjustedStartDate date,
	AimClassification varchar(50),
	AimValue decimal(10,5),
	ApplicWeightFundRate decimal(10,5),
	EligibleProgressionOutcomeCode bigint,
	EligibleProgressionOutcomeType varchar(4),
	EligibleProgressionOutomeStartDate date,
	FundStart bit,
	LARSWeightedRate decimal(10,5),
	LatestPossibleStartDate date,
	LDESFEngagementStartDate date,
	PotentiallyEligibleForProgression bit,
	ProgressionEndDate date,
	[Restart] bit,
	WeightedRateFromESOL decimal(10,5),
	LearnDelLearnerEmpAtStart bit
	primary key clustered (
		LearnRefNumber asc,
		UKPRN asc,
		AimSeqNumber asc
	)
)
go

create table Rulebase.ESF_LearningDeliveryDeliverable (
	LearnRefNumber varchar(12),
	UKPRN int not null,
	AimSeqNumber int,
	DeliverableCode varchar(5),
	DeliverableUnitCost decimal(10,5),
	primary key clustered (
		LearnRefNumber asc,
		UKPRN asc,
		AimSeqNumber asc,
		DeliverableCode asc
	)
)
go

create table Rulebase.ESF_LearningDeliveryDeliverable_Period (
	LearnRefNumber varchar(12),
	UKPRN int not null,
	AimSeqNumber int,
	DeliverableCode varchar(5),
	[Period] int,
	AchievementEarnings decimal(10,5),
	AdditionalProgCostEarnings decimal(10,5),
	DeliverableVolume bigint,
	ProgressionEarnings decimal(10,5),
	ReportingVolume int,
	StartEarnings decimal(10,5),
	primary key clustered (
		LearnRefNumber asc,
		UKPRN asc,
		AimSeqNumber asc,
		DeliverableCode asc,
		[Period] asc
	)
)
go

create table Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues (
	LearnRefNumber varchar(12) not null,
	UKPRN int not null,
	AimSeqNumber int not null,
	DeliverableCode varchar(5) not null,
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
		UKPRN asc,
		AimSeqNumber asc,
		DeliverableCode asc,
		AttributeName asc
	)
)
go

create table Rulebase.ESF_DPOutcome (
	LearnRefNumber varchar(12) not null,
	UKPRN int not null,
	OutCode int not null,
	OutType varchar(30) not null,
	OutStartDate date not null,
	OutcomeDateForProgression date,
	PotentialESFProgressionType bit,
	ProgressionType varchar(50),
	ReachedSixMonthPoint bit,
	ReachedThreeMonthPoint bit,
	ReachedTwelveMonthPoint bit
	primary key clustered (
		LearnRefNumber asc,
		UKPRN asc,
		OutCode asc,
		OutType asc,
		OutStartDate asc
	)
)
go

create table Rulebase.ESFVAL_global (
	UKPRN int null,
	RulebaseVersion varchar(10) null
)
go

create table Rulebase.ESFVAL_ValidationError (
	LearnRefNumber varchar(100) not null,
	UKPRN int not null,
	AimSeqNumber bigint not null,
	RuleId varchar(50) not null,
	ErrorString varchar(2000) null,
	FieldValues varchar(2000) null
	primary key clustered (
		LearnRefNumber asc,
		UKPRN asc,
		AimSeqNumber asc,
		RuleId asc
	)
)
go

create table Rulebase.FM35_global (
	UKPRN varchar(8) not null,
	CurFundYr varchar(9) null,
	LARSVersion varchar(100) null,
	OrgVersion varchar(100) null,
	PostcodeDisadvantageVersion varchar(50) null,
	RulebaseVersion varchar(10) null,
	primary key clustered (
		UKPRN asc
	)
)
go

create table Rulebase.FM35_LearningDelivery (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AchApplicDate date null,
	Achieved bit null,
	AchieveElement decimal(10, 5) null,
	AchievePayElig bit null,
	AchievePayPctPreTrans decimal(10, 5) null,
	AchPayTransHeldBack decimal(10, 5) null,
	ActualDaysIL int null,
	ActualNumInstalm int null,
	ActualNumInstalmPreTrans int null,
	ActualNumInstalmTrans int null,
	AdjLearnStartDate date null,
	AdltLearnResp bit null,
	AgeAimStart int null,
	AimValue decimal(10, 5) null,
	AppAdjLearnStartDate date null,
	AppAgeFact decimal(10, 5) null,
	AppATAGTA bit null,
	AppCompetency bit null,
	AppFuncSkill bit null,
	AppFuncSkill1618AdjFact decimal(10, 5) null,
	AppKnowl bit null,
	AppLearnStartDate date null,
	ApplicEmpFactDate date null,
	ApplicFactDate date null,
	ApplicFundRateDate date null,
	ApplicProgWeightFact varchar(1) null,
	ApplicUnweightFundRate decimal(10, 5) null,
	ApplicWeightFundRate decimal(10, 5) null,
	AppNonFund bit null,
	AreaCostFactAdj decimal(10, 5) null,
	BalInstalmPreTrans int null,
	BaseValueUnweight decimal(10, 5) null,
	CapFactor decimal(10, 5) null,
	DisUpFactAdj decimal(10, 4) null,
	EmpOutcomePayElig bit null,
	EmpOutcomePctHeldBackTrans decimal(10, 5) null,
	EmpOutcomePctPreTrans decimal(10, 5) null,
	EmpRespOth bit null,
	ESOL bit null,
	FullyFund bit null,
	FundLine varchar(100) null,
	FundStart bit null,
	LargeEmployerID int null,
	LargeEmployerFM35Fctr decimal(10, 2) null,
	LargeEmployerStatusDate date null,
	LearnDelFundOrgCode varchar(50),
	LTRCUpliftFctr decimal(10, 5) null,
	NonGovCont decimal(10, 5) null,
	OLASSCustody bit null,
	OnProgPayPctPreTrans decimal(10, 5) null,
	OutstndNumOnProgInstalm int null,
	OutstndNumOnProgInstalmTrans int null,
	PlannedNumOnProgInstalm int null,
	PlannedNumOnProgInstalmTrans int null,
	PlannedTotalDaysIL int null,
	PlannedTotalDaysILPreTrans int null,
	PropFundRemain decimal(10, 2) null,
	PropFundRemainAch decimal(10, 2) null,
	PrscHEAim bit null,
	Residential bit null,
	Restart bit null,
	SpecResUplift decimal(10, 5) null,
	StartPropTrans decimal(10, 5) null,
	ThresholdDays int null,
	Traineeship bit null,
	Trans bit null,
	TrnAdjLearnStartDate date null,
	TrnWorkPlaceAim bit null,
	TrnWorkPrepAim bit null,
	UnWeightedRateFromESOL decimal(10, 5) null,
	UnweightedRateFromLARS decimal(10, 5) null,
	WeightedRateFromESOL decimal(10, 5) null,
	WeightedRateFromLARS decimal(10, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

create table Rulebase.FM35_LearningDelivery_Period (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	[Period] int not null,
	AchievePayment decimal(10, 5) null,
	AchievePayPct decimal(10, 5) null,
	AchievePayPctTrans decimal(10, 5) null,
	BalancePayment decimal(10, 5) null,
	BalancePaymentUncapped decimal(10, 5) null,
	BalancePct decimal(10, 5) null,
	BalancePctTrans decimal(10, 5) null,
	EmpOutcomePay decimal(10, 5) null,
	EmpOutcomePct decimal(10, 5) null,
	EmpOutcomePctTrans decimal(10, 5) null,
	InstPerPeriod int null,
	LearnSuppFund bit null,
	LearnSuppFundCash decimal(10, 5) null,
	OnProgPayment decimal(10, 5) null,
	OnProgPaymentUncapped decimal(10, 5) null,
	OnProgPayPct decimal(10, 5) null,
	OnProgPayPctTrans decimal(10, 5) null,
	TransInstPerPeriod int null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		[Period] asc
	)
)
go

create table Rulebase.FM35_LearningDelivery_PeriodisedValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AttributeName varchar(100) not null,
	Period_1 decimal(15, 5) null,
	Period_2 decimal(15, 5) null,
	Period_3 decimal(15, 5) null,
	Period_4 decimal(15, 5) null,
	Period_5 decimal(15, 5) null,
	Period_6 decimal(15, 5) null,
	Period_7 decimal(15, 5) null,
	Period_8 decimal(15, 5) null,
	Period_9 decimal(15, 5) null,
	Period_10 decimal(15, 5) null,
	Period_11 decimal(15, 5) null,
	Period_12 decimal(15, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		AttributeName asc
	)
)
go

create table Rulebase.TBL_global (
	UKPRN int not null,
	CurFundYr varchar(10) null,
	LARSVersion varchar(100) null,
	RulebaseVersion varchar(10) null,
	primary key clustered (
		UKPRN asc
	)
)
go

create table Rulebase.TBL_LearningDelivery (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	ProgStandardStartDate date null,
	FundLine varchar(50) null,
	MathEngAimValue decimal(10, 5) null,
	PlannedNumOnProgInstalm int null,
	LearnSuppFundCash decimal(10, 5) null,
	AdjProgStartDate date null,
	LearnSuppFund bit null,
	MathEngOnProgPayment decimal(10, 5) null,
	InstPerPeriod int null,
	SmallBusPayment decimal(10, 5) null,
	YoungAppSecondPayment decimal(10, 5) null,
	CoreGovContPayment decimal(10, 5) null,
	YoungAppEligible bit null,
	SmallBusEligible bit null,
	MathEngOnProgPct int null,
	AgeStandardStart int null,
	YoungAppSecondThresholdDate date null,
	EmpIdFirstDayStandard int null,
	EmpIdFirstYoungAppDate int null,
	EmpIdSecondYoungAppDate int null,
	EmpIdSmallBusDate int null,
	YoungAppFirstThresholdDate date null,
	AchApplicDate date null,
	AchEligible bit null,
	Achieved bit null,
	AchievementApplicVal decimal(10, 5) null,
	AchPayment decimal(10, 5) null,
	ActualNumInstalm int null,
	CombinedAdjProp bigint null,
	EmpIdAchDate int null,
	LearnDelDaysIL int null,
	LearnDelStandardAccDaysIL int null,
	LearnDelStandardPrevAccDaysIL int null,
	LearnDelStandardTotalDaysIL int null,
	ActualDaysIL int null,
	MathEngBalPayment decimal(10, 5) null,
	MathEngBalPct bigint null,
	MathEngLSFFundStart bit null,
	PlannedTotalDaysIL int null,
	MathEngLSFThresholdDays int null,
	OutstandNumOnProgInstalm int null,
	SmallBusApplicVal decimal(10, 5) null,
	SmallBusStatusFirstDayStandard int null,
	SmallBusStatusThreshold int null,
	YoungAppApplicVal decimal(10, 5) null,
	CoreGovContCapApplicVal bigint null,
	CoreGovContUncapped decimal(10, 5) null,
	ApplicFundValDate date null,
	YoungAppFirstPayment decimal(10, 5) null,
	YoungAppPayment decimal(10, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

create table Rulebase.TBL_LearningDelivery_Period (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	[Period] int not null,
	AchPayment decimal(10, 5) null,
	CoreGovContPayment decimal(10, 5) null,
	CoreGovContUncapped decimal(10, 5) null,
	InstPerPeriod int null,
	LearnSuppFund bit null,
	LearnSuppFundCash decimal(10, 5) null,
	MathEngBalPayment decimal(10, 5) null,
	MathEngBalPct decimal(8, 5) null,
	MathEngOnProgPayment decimal(10, 5) null,
	MathEngOnProgPct decimal(8, 5) null,
	SmallBusPayment decimal(10, 5) null,
	YoungAppFirstPayment decimal(10, 5) null,
	YoungAppPayment decimal(10, 5) null,
	YoungAppSecondPayment decimal(10, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		[Period] asc
	)
)
go

create table Rulebase.TBL_LearningDelivery_PeriodisedValues (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	AttributeName varchar(100) not null,
	Period_1 decimal(15, 5) null,
	Period_2 decimal(15, 5) null,
	Period_3 decimal(15, 5) null,
	Period_4 decimal(15, 5) null,
	Period_5 decimal(15, 5) null,
	Period_6 decimal(15, 5) null,
	Period_7 decimal(15, 5) null,
	Period_8 decimal(15, 5) null,
	Period_9 decimal(15, 5) null,
	Period_10 decimal(15, 5) null,
	Period_11 decimal(15, 5) null,
	Period_12 decimal(15, 5) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc,
		AttributeName asc
	)
)
go

create table Rulebase.VAL_global (
	UKPRN int not null,
	EmployerVersion varchar(50) null,
	LARSVersion varchar(50) null,
	OrgVersion varchar(50) null,
	PostcodeVersion varchar(50) null,
	RulebaseVersion varchar(10) null,
	primary key clustered (
		UKPRN asc
	)
)
go

create table Rulebase.VAL_Learner (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc
	)
)
go

create table Rulebase.VAL_LearningDelivery (
	UKPRN int not null,
	AimSeqNumber int not null,
	primary key clustered (
		UKPRN asc,
		AimSeqNumber asc
	)
)
go

create table Rulebase.VAL_ValidationError (
	UKPRN int not null,
	AimSeqNumber bigint null,
	ErrorString varchar(2000) null,
	FieldValues varchar(2000) null,
	LearnRefNumber varchar(100) null,
	RuleId varchar(50) null
)
go

create table Rulebase.VALDP_global (
	UKPRN int not null,
	OrgVersion varchar(50) null,
	RulebaseVersion varchar(10) null,
	ULNVersion varchar(50) null,
	primary key clustered (
		UKPRN asc
	)
)
go

create table Rulebase.VALDP_ValidationError (
	UKPRN int not null,
	ErrorString varchar(2000) null,
	FieldValues varchar(2000) null,
	LearnRefNumber varchar(100) null,
	RuleId varchar(50) null
)
go

create table [Rulebase].[VALFD_ValidationError] (
	UKPRN int not null,
	AimSeqNumber bigint null,
	ErrorString varchar(2000) null,
	FieldValues varchar(2000) null,
	LearnRefNumber varchar(100) null,
	RuleId varchar(50) null
)
go


create table Valid.CollectionDetails (
	UKPRN int not null,
	[Collection] varchar(3) not null,
	[Year] varchar(4) not null,
	FilePreparationDate date null
)
go

create table Valid.ContactPreference (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	ContPrefType varchar(3) not null,
	ContPrefCode int not null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		ContPrefType asc,
		ContPrefCode asc
	)
)
go

create table Valid.DPOutcome (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	OutType varchar(3) not null,
	OutCode int not null,
	OutStartDate date not null,
	OutEndDate date null,
	OutCollDate date not null
)
go

create table Valid.LearnerDestinationandProgression (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	ULN bigint not null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc
	)
)
go

create table Valid.LearnerHE (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	UCASPERID varchar(10) null,
	TTACCOM int null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc
	)
)
go

create table Valid.LearnerHEFinancialSupport (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	FINTYPE int not null,
	FINAMOUNT int not null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		FINTYPE asc
	)
)
go

create table Valid.LearningDeliveryHE (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	NUMHUS varchar(20) null,
	SSN varchar(13) null,
	QUALENT3 varchar(3) null,
	SOC2000 int null,
	SEC int null,
	UCASAPPID varchar(9) null,
	TYPEYR int not null,
	MODESTUD int not null,
	FUNDLEV int not null,
	FUNDCOMP int not null,
	STULOAD decimal(4, 1) null,
	YEARSTU int not null,
	MSTUFEE int not null,
	PCOLAB decimal(4, 1) null,
	PCFLDCS decimal(4, 1) null,
	PCSLDCS decimal(4, 1) null,
	PCTLDCS decimal(4, 1) null,
	SPECFEE int not null,
	NETFEE int null,
	GROSSFEE int null,
	DOMICILE varchar(2) null,
	ELQ int null,
	HEPostCode varchar(8) null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		AimSeqNumber asc
	)
)
go

create table Valid.LearningDeliveryWorkPlacement (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	AimSeqNumber int not null,
	WorkPlaceStartDate date not null,
	WorkPlaceEndDate date null,
	WorkPlaceHours int null,
	WorkPlaceMode int not null,
	WorkPlaceEmpId int not null
)
go

create table Valid.LearningProvider (
	UKPRN int not null,
	primary key clustered (
		UKPRN asc
	)
)
go

create table Valid.LLDDandHealthProblem (
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
	LLDDCat int not null,
	PrimaryLLDD int null,
	primary key clustered (
		UKPRN asc,
		LearnRefNumber asc,
		LLDDCat asc
	)
)
go

create table Valid.[Source] (
	ProtectiveMarking varchar(30) null,
	UKPRN int not null,
	SoftwareSupplier varchar(40) null,
	SoftwarePackage varchar(30) null,
	Release varchar(20) null,
	SerialNo varchar(2) null,
	[DateTime] datetime null,
	ReferenceData varchar(100) null,
	ComponentSetVersion varchar(20) null
)
go

create table Valid.SourceFile (
	UKPRN int not null,
	SourceFileName varchar(50) not null
	)
go
