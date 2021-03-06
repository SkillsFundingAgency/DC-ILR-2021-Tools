/****** Object:  Schema [Invalid]    Script Date: 01/12/2017 15:17:11 ******/
CREATE SCHEMA [Invalid]
GO
/****** Object:  Schema [Rulebase]    Script Date: 01/12/2017 15:17:11 ******/
CREATE SCHEMA [Rulebase]
GO
/****** Object:  Schema [Valid]    Script Date: 01/12/2017 15:17:11 ******/
CREATE SCHEMA [Valid]
GO

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

/****** Object:  Table [Valid].[Learner]    Script Date: 01/12/2017 15:17:11 ******/
CREATE TABLE [Valid].[Learner](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[PrevLearnRefNumber] [varchar](12) NULL,
	[PrevUKPRN] [int] NULL,
	[PMUKPRN] [int] NULL,
	[ULN] [bigint] NOT NULL,
	[FamilyName] [varchar](100) NULL,
	[GivenNames] [varchar](100) NULL,
	[DateOfBirth] [date] NULL,
	[Ethnicity] [int] NOT NULL,
	[Sex] [varchar](1) NOT NULL,
	[LLDDHealthProb] [int] NOT NULL,
	[NINumber] [varchar](9) NULL,
	[PriorAttain] [int] NULL,
	[Accom] [int] NULL,
	[ALSCost] [int] NULL,
	[PlanLearnHours] [int] NULL,
	[PlanEEPHours] [int] NULL,
	[MathGrade] [varchar](4) NULL,
	[EngGrade] [varchar](4) NULL,
	[PostcodePrior] [varchar](8) NULL,
	[Postcode] [varchar](8) NULL,
	[AddLine1] [varchar](50) NULL,
	[AddLine2] [varchar](50) NULL,
	[AddLine3] [varchar](50) NULL,
	[AddLine4] [varchar](50) NULL,
	[TelNo] [varchar](18) NULL,
	[Email] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[LearnerFAM]    Script Date: 01/12/2017 15:17:11 ******/
CREATE TABLE [Valid].[LearnerFAM](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[LearnFAMType] [varchar](3) NULL,
	[LearnFAMCode] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[ProviderSpecLearnerMonitoring]    Script Date: 01/12/2017 15:17:11 ******/
CREATE TABLE [Valid].[ProviderSpecLearnerMonitoring](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[ProvSpecLearnMonOccur] [varchar](1) NOT NULL,
	[ProvSpecLearnMon] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[ProvSpecLearnMonOccur] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Valid].[LearnerDenorm]    Script Date: 01/12/2017 15:17:12 ******/
create view [Valid].[LearnerDenorm]
as
	select
		l.[LearnRefNumber],
		l.[PrevLearnRefNumber],
		l.[PrevUKPRN],
		l.[PMUKPRN],
		l.[ULN],
		l.[FamilyName],
		l.[GivenNames],
		l.[DateOfBirth],
		l.[Ethnicity],
		l.[Sex],
		l.[LLDDHealthProb],
		l.[NINumber],
		l.[PriorAttain],
		l.[Accom],
		l.[ALSCost],
		l.[PlanLearnHours],
		l.[PlanEEPHours],
		l.[MathGrade],
		l.[EngGrade],
		l.[PostcodePrior],
		l.[Postcode],
		l.[AddLine1],
		l.[AddLine2],
		l.[AddLine3],
		l.[AddLine4],
		l.[TelNo],
		l.[Email]
		,LSR.LSR1
		,LSR.LSR2
		,LSR.LSR3
		,LSR.LSR4
		,NLM.NLM1
		,NLM.NLM2
		,PPE.PPE1
		,PPE.PPE2
		,EDF.EDF1
		,EDF.EDF2
		,ehc.LearnFAMCode as [EHC]
		,ecf.LearnFAMCode as [ECF]
		,hns.LearnFAMCode as [HNS]
		,lda.LearnFAMCode as [LDA]
		,mcf.LearnFAMCode as [MCF]
		,ProvSpecMon_A.ProvSpecLearnMon AS ProvSpecLearnMon_A	
		,ProvSpecMon_B.ProvSpecLearnMon AS ProvSpecLearnMon_B
	from
		Valid.Learner as l
		left join
		(
			select
				LearnRefNumber,
				UKPRN,
				max([LSR1]) as [LSR1],
				max([LSR2]) as [LSR2],
				max([LSR3]) as [LSR3],
				max([LSR4]) as [LSR4]
			from
				(
					select
						LearnRefNumber,
						UKPRN,
						case row_number() over (partition by [LearnRefNumber], UKPRN order by [LearnRefNumber], UKPRN) when 1 then LearnFAMCode else null end  as [LSR1],
						case row_number() over (partition by [LearnRefNumber], UKPRN order by [LearnRefNumber], UKPRN) when 2 then LearnFAMCode else null end  as [LSR2],
						case row_number() over (partition by [LearnRefNumber], UKPRN order by [LearnRefNumber], UKPRN) when 3 then LearnFAMCode else null end  as [LSR3],
						case row_number() over (partition by [LearnRefNumber], UKPRN order by [LearnRefNumber], UKPRN) when 4 then LearnFAMCode else null end  as [LSR4]
					from
						Valid.[LearnerFAM]
					where
						[LearnFAMType]='LSR'
				) as [LSRs]
			group by
				LearnRefNumber,
				UKPRN
		) as [LSR]
		on [LSR].LearnRefNumber = l.LearnRefNumber
		and LSR.UKPRN = l.UKPRN
		left join
		(
			select
				LearnRefNumber,
				UKPRN,
				max([NLM1]) as [NLM1],
				max([NLM2]) as [NLM2]
			from
				(
					select
						LearnRefNumber,
						UKPRN,
						case row_number() over (partition by [LearnRefNumber], UKPRN order by [LearnRefNumber], UKPRN) when 1 then LearnFAMCode else null end  as [NLM1],
						case row_number() over (partition by [LearnRefNumber], UKPRN order by [LearnRefNumber], UKPRN) when 2 then LearnFAMCode else null end  as [NLM2]
					from
						Valid.[LearnerFAM]
					where
						[LearnFAMType]='NLM'
				) as [NLMs]
			group by
				LearnRefNumber,
				UKPRN
		) as [NLM]
			on [NLM].LearnRefNumber = l.LearnRefNumber
			and NLM.UKPRN = l.UKPRN
		left join
		(
			select
				LearnRefNumber,
				UKPRN,
				max([PPE1]) as [PPE1],
				max([PPE2]) as [PPE2]
			from
				(
					select
						LearnRefNumber,
						UKPRN,
						case row_number() over (partition by [LearnRefNumber], UKPRN order by [LearnRefNumber], UKPRN) when 1 then LearnFAMCode else null end  as [PPE1],
						case row_number() over (partition by [LearnRefNumber], UKPRN order by [LearnRefNumber], UKPRN) when 2 then LearnFAMCode else null end  as [PPE2]
					from
						Valid.[LearnerFAM]
					where
						[LearnFAMType]='PPE'
				) as [PPEs]
			group by
				LearnRefNumber,
				UKPRN
		) as [PPE]
			on [PPE].LearnRefNumber = l.LearnRefNumber
			and PPE.UKPRN = l.UKPRN
		left join
		(
			select
				[LearnRefNumber],
				UKPRN,
				max([EDF1]) as [EDF1],
				max([EDF2]) as [EDF2]
			from
				(
					select
						[LearnRefNumber],
						UKPRN,
						case row_number() over (partition by [LearnRefNumber], UKPRN order by [LearnRefNumber], UKPRN) when 1 then LearnFAMCode else null end  as [EDF1],
						case row_number() over (partition by [LearnRefNumber], UKPRN order by [LearnRefNumber], UKPRN) when 2 then LearnFAMCode else null end  as [EDF2]
					from
						[Valid].[LearnerFAM]
					where
						[LearnFAMType]='EDF'
				) as [EDFs]
			group by
				UKPRN,
				[LearnRefNumber]
		) as [EDF]
			on [EDF].[LearnRefNumber]=l.LearnRefNumber
			and EDF.UKPRN = l.UKPRN
		left join
			Valid.LearnerFAM as ehc
				on ehc.LearnRefNumber = l.LearnRefNumber
				and ehc.LearnFAMType = 'EHC' 
				and ehc.UKPRN = l.UKPRN
		left join
			Valid.LearnerFAM as ecf
				on ecf.LearnRefNumber = l.LearnRefNumber
				and ecf.LearnFAMType = 'ECF'
				and ecf.UKPRN = l.UKPRN
		left join
			Valid.LearnerFAM as hns
				on hns.LearnRefNumber = l.LearnRefNumber
				and hns.LearnFAMType = 'HNS'
				and hns.UKPRN = l.UKPRN
		left join
			Valid.LearnerFAM as lda
				on lda.LearnRefNumber = l.LearnRefNumber
				and lda.LearnFAMType = 'LDA'
				and lda.UKPRN = l.UKPRN
		left join
			Valid.LearnerFAM as mcf
				on mcf.LearnRefNumber = l.LearnRefNumber
				and mcf.LearnFAMType = 'MCF'
				and mcf.UKPRN = l.UKPRN

		left join Valid.[ProviderSpecLearnerMonitoring] as [ProvSpecMon_A]
			on [ProvSpecMon_A].[LearnRefNumber] = l.LearnRefNumber
			and [ProvSpecMon_A].[ProvSpecLearnMonOccur]='A'
			and ProvSpecMon_A.UKPRN = l.UKPRN
		left join Valid.[ProviderSpecLearnerMonitoring] as [ProvSpecMon_B]
			on [ProvSpecMon_B].LearnRefNumber = l.[LearnRefNumber]
			and [ProvSpecMon_B].[ProvSpecLearnMonOccur]='B'
			and ProvSpecMon_B.UKPRN = l.UKPRN

GO
/****** Object:  Table [Valid].[LearnerEmploymentStatus]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Valid].[LearnerEmploymentStatus](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[EmpStat] [int] NULL,
	[DateEmpStatApp] [date] NOT NULL,
	[EmpId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[DateEmpStatApp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[EmploymentStatusMonitoring]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Valid].[EmploymentStatusMonitoring](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[DateEmpStatApp] [date] NOT NULL,
	[ESMType] [varchar](3) NOT NULL,
	[ESMCode] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[DateEmpStatApp] ASC,
	[ESMType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Valid].[LearnerEmploymentStatusDenorm]    Script Date: 01/12/2017 15:17:12 ******/
create view [Valid].[LearnerEmploymentStatusDenorm]
as
SELECT 
	les.UKPRN
	,les.[LearnRefNumber]
	,les.[EmpStat]
	,les.[DateEmpStatApp]
	,[EmpStatMon_BSI].ESMCode AS ESMCode_BSI
	,[EmpStatMon_EII].ESMCode AS ESMCode_EII
	,[EmpStatMon_LOE].ESMCode AS ESMCode_LOE
	,[EmpStatMon_LOU].ESMCode AS ESMCode_LOU
	,[EmpStatMon_PEI].ESMCode AS ESMCode_PEI
	,[EmpStatMon_SEI].ESMCode AS ESMCode_SEI
	,[EmpStatMon_SEM].ESMCode AS ESMCode_SEM
FROM 
	Valid.[LearnerEmploymentStatus] as les
	left join Valid.[EmploymentStatusMonitoring] as [EmpStatMon_BSI]
		on [EmpStatMon_BSI].LearnRefNumber=les.LearnRefNumber
		and EmpStatMon_BSI.UKPRN = les.UKPRN
		and [EmpStatMon_BSI].[ESMType]='BSI'
	left join Valid.[EmploymentStatusMonitoring] as [EmpStatMon_EII]
		on [EmpStatMon_EII].LearnRefNumber=les.LearnRefNumber
		and EmpStatMon_EII.UKPRN = les.UKPRN
		and [EmpStatMon_EII].[ESMType]='EII'
	left join Valid.[EmploymentStatusMonitoring] as [EmpStatMon_LOE]
		on [EmpStatMon_LOE].LearnRefNumber=les.LearnRefNumber
		and EmpStatMon_LOE.UKPRN = les.UKPRN
		and [EmpStatMon_LOE].[ESMType]='LOE'
	left join Valid.[EmploymentStatusMonitoring] as [EmpStatMon_LOU]
		on [EmpStatMon_LOU].LearnRefNumber=les.LearnRefNumber
		and EmpStatMon_LOU.UKPRN = les.UKPRN
		and [EmpStatMon_LOU].[ESMType]='LOU'
	left join Valid.[EmploymentStatusMonitoring] as [EmpStatMon_PEI]
		on [EmpStatMon_PEI].LearnRefNumber=les.LearnRefNumber
		and EmpStatMon_PEI.UKPRN = les.UKPRN
		and [EmpStatMon_PEI].[ESMType]='PEI'
	left join Valid.[EmploymentStatusMonitoring] as [EmpStatMon_SEI]
		on [EmpStatMon_SEI].LearnRefNumber=les.LearnRefNumber
		and EmpStatMon_SEI.UKPRN = les.UKPRN
		and [EmpStatMon_SEI].[ESMType]='SEI'
	left join Valid.[EmploymentStatusMonitoring] as [EmpStatMon_SEM]
		on [EmpStatMon_SEM].LearnRefNumber=les.LearnRefNumber
		and [EmpStatMon_SEM].[ESMType]='SEM'

GO
/****** Object:  Table [Valid].[LearningDelivery]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Valid].[LearningDelivery](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[LearnAimRef] [varchar](8) NOT NULL,
	[AimType] [int] NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[LearnStartDate] [date] NOT NULL,
	[OrigLearnStartDate] [date] NULL,
	[LearnPlanEndDate] [date] NOT NULL,
	[FundModel] [int] NOT NULL,
	[ProgType] [int] NULL,
	[FworkCode] [int] NULL,
	[PwayCode] [int] NULL,
	[StdCode] [int] NULL,
	[PartnerUKPRN] [int] NULL,
	[DelLocPostCode] [varchar](8) NULL,
	[AddHours] [int] NULL,
	[PriorLearnFundAdj] [int] NULL,
	[OtherFundAdj] [int] NULL,
	[ConRefNumber] [varchar](20) NULL,
	[EPAOrgID] [varchar](7) NULL,
	[EmpOutcome] [int] NULL,
	[CompStatus] [int] NOT NULL,
	[LearnActEndDate] [date] NULL,
	[WithdrawReason] [int] NULL,
	[Outcome] [int] NULL,
	[AchDate] [date] NULL,
	[OutGrade] [varchar](6) NULL,
	[SWSupAimId] [varchar](36) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[LearningDeliveryFAM]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Valid].[LearningDeliveryFAM](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[LearnDelFAMType] [varchar](3) NOT NULL,
	[LearnDelFAMCode] [varchar](5) NOT NULL,
	[LearnDelFAMDateFrom] [date] NULL,
	[LearnDelFAMDateTo] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[ProviderSpecDeliveryMonitoring]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Valid].[ProviderSpecDeliveryMonitoring](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[ProvSpecDelMonOccur] [varchar](1) NOT NULL,
	[ProvSpecDelMon] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC,
	[ProvSpecDelMonOccur] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [Valid].[LearningDeliveryDenorm]    Script Date: 01/12/2017 15:17:12 ******/
CREATE VIEW [Valid].[LearningDeliveryDenorm]
AS
SELECT
	ld.[LearnRefNumber]
	,ld.[LearnAimRef]
	,ld.[AimType]
	,ld.[AimSeqNumber]
	,ld.[LearnStartDate]
	,ld.[OrigLearnStartDate]
	,ld.[LearnPlanEndDate]
	,ld.[FundModel]
	,ld.[ProgType]
	,ld.[FworkCode]
	,ld.[PwayCode]
	,ld.[StdCode]
	,ld.[PartnerUKPRN]
	,ld.[DelLocPostCode]
	,ld.[AddHours]
	,ld.[PriorLearnFundAdj]
	,ld.[OtherFundAdj]
	,ld.[ConRefNumber]
	,ld.[EPAOrgID]
	,ld.[EmpOutcome]
	,ld.[CompStatus]
	,ld.[LearnActEndDate]
	,ld.[WithdrawReason]
	,ld.[Outcome]
	,ld.[AchDate]
	,ld.[OutGrade]
	,ld.[SWSupAimId]
	,HEM.HEM1
	,HEM.HEM2
	,HEM.HEM3
	,HHS.HHS1
	,HHS.HHS2
	,[LDFAM_SOF].LearnDelFAMCode AS [LDFAM_SOF]
	,[LDFAM_EEF].LearnDelFAMCode AS [LDFAM_EEF]
	,[LDFAM_RES].LearnDelFAMCode AS [LDFAM_RES]
	,[LDFAM_ADL].LearnDelFAMCode AS [LDFAM_ADL]
	,[LDFAM_FFI].LearnDelFAMCode AS [LDFAM_FFI]
	,[LDFAM_SPP].LearnDelFAMCode AS [LDFAM_SPP]
	,[ProvSpecMon_A].ProvSpecDelMon AS ProvSpecDelMon_A
	,[ProvSpecMon_B].ProvSpecDelMon	AS ProvSpecDelMon_B
	,[ProvSpecMon_C].ProvSpecDelMon	AS ProvSpecDelMon_C
	,[ProvSpecMon_D].ProvSpecDelMon	AS ProvSpecDelMon_D
	,LDM.LDM1
	,LDM.LDM2
	,LDM.LDM3
	,LDM.LDM4

FROM
	Valid.LearningDelivery as ld
	left join
	(
		select
			[UKPRN],
			[LearnRefNumber],
			[AimSeqNumber],
			max([HEM1]) as [HEM1],
			max([HEM2]) as [HEM2],
			max([HEM3]) as [HEM3]
		from
			(
				select
					[UKPRN],
					[LearnRefNumber],
					[AimSeqNumber],
					case row_number() over (partition by LearnRefNumber, AimSeqNumber order by LearnRefNumber, AimSeqNumber) when 1 then LearnDelFAMCode else null end  as [HEM1],
					case row_number() over (partition by LearnRefNumber, AimSeqNumber order by LearnRefNumber, AimSeqNumber) when 2 then LearnDelFAMCode else null end  as [HEM2],
					case row_number() over (partition by LearnRefNumber, AimSeqNumber order by LearnRefNumber, AimSeqNumber) when 3 then LearnDelFAMCode else null end  as [HEM3]
				from
					Valid.[LearningDeliveryFAM]
				where
					[LearnDelFAMType]='HEM'
			) as [HEMs]
		group by
			UKPRN,
			[LearnRefNumber]
			,[AimSeqNumber]
	) as [HEM]
	on [HEM].[LearnRefNumber]=ld.[LearnRefNumber]
	and [HEM].[AimSeqNumber]=ld.[AimSeqNumber]
	and HEM.UKPRN = ld.UKPRN
	left join
	(
		select
			UKPRN,
			LearnRefNumber, 
			AimSeqNumber,
			max([HHS1]) as [HHS1],
			max([HHS2]) as [HHS2]
		from
			(
				select
					UKPRN,
					LearnRefNumber,
					AimSeqNumber,
					case row_number() over (partition by [LearnRefNumber], AimSeqNumber, UKPRN order by [LearnRefNumber], AimSeqNumber, UKPRN) when 1 then LearnDelFAMCode else null end  as [HHS1],
					case row_number() over (partition by [LearnRefNumber], AimSeqNumber, UKPRN order by [LearnRefNumber], AimSeqNumber, UKPRN) when 2 then LearnDelFAMCode else null end  as [HHS2]
				from
					Valid.[LearningDeliveryFAM]
				where
					[LearnDelFAMType]='HHS'
			) as [HHSs]
		group by
			UKPRN,
			[LearnRefNumber]
			,[AimSeqNumber]
	) as [HHS]
	on [HHS].[LearnRefNumber]=ld.[LearnRefNumber]
	and [HHS].AimSeqNumber=ld.AimSeqNumber
	and HHS.UKPRN = ld.UKPRN

	LEFT JOIN
		[Valid].[LearningDeliveryFAM] AS [LDFAM_SOF] 
			ON ld.[LearnRefNumber] = [LDFAM_SOF].[LearnRefNumber]
			AND ld.[AimSeqNumber] = [LDFAM_SOF].[AimSeqNumber]
			and LDFAM_SOF.UKPRN = ld.UKPRN
			AND [LDFAM_SOF].[LearnDelFAMType] = 'SOF'
	LEFT JOIN
		[Valid].[LearningDeliveryFAM] AS [LDFAM_EEF] 
			ON ld.[LearnRefNumber] = [LDFAM_EEF].[LearnRefNumber]
			AND ld.[AimSeqNumber] = [LDFAM_EEF].[AimSeqNumber]
			and ld.UKPRN = LDFAM_EEF.UKPRN
			AND [LDFAM_EEF].[LearnDelFAMType] = 'EEF'
	LEFT JOIN
		[Valid].[LearningDeliveryFAM] AS [LDFAM_RES] 
			ON ld.[LearnRefNumber] = [LDFAM_RES].[LearnRefNumber]
			AND ld.[AimSeqNumber] = [LDFAM_RES].[AimSeqNumber]
			and ld.UKPRN = LDFAM_RES.UKPRN
			AND [LDFAM_RES].[LearnDelFAMType] = 'RES'
	LEFT JOIN            
		[Valid].[LearningDeliveryFAM] AS [LDFAM_ADL] 
			ON  ld.[LearnRefNumber] = [LDFAM_ADL].[LearnRefNumber]
			AND ld.[AimSeqNumber] = [LDFAM_ADL].[AimSeqNumber]
			and ld.UKPRN = LDFAM_ADL.UKPRN
			AND [LDFAM_ADL].[LearnDelFAMType] = 'ADL'
	LEFT JOIN
        [Valid].[LearningDeliveryFAM] AS [LDFAM_FFI] 
			ON  ld.[LearnRefNumber] = [LDFAM_FFI].[LearnRefNumber]
			AND ld.[AimSeqNumber] = [LDFAM_FFI].[AimSeqNumber]
			and [LDFAM_FFI].UKPRN = ld.UKPRN
			AND [LDFAM_FFI].[LearnDelFAMType] = 'FFI'
	LEFT JOIN 
		[Valid].[LearningDeliveryFAM] AS [LDFAM_SPP] 
			ON ld.[LearnRefNumber] = [LDFAM_SPP].[LearnRefNumber]
			AND ld.[AimSeqNumber] = [LDFAM_SPP].[AimSeqNumber]
			and [LDFAM_SPP].UKPRN = ld.UKPRN
			AND [LDFAM_SPP].[LearnDelFAMType] = 'SPP'

	left join Valid.[ProviderSpecDeliveryMonitoring] as [ProvSpecMon_A]
		on [ProvSpecMon_A].[LearnRefNumber]=ld.[LearnRefNumber]
		and [ProvSpecMon_A].[AimSeqNumber]=ld.[AimSeqNumber]
		and [ProvSpecMon_A].UKPRN = ld.UKPRN
		and [ProvSpecMon_A].[ProvSpecDelMonOccur]='A'

	left join Valid.[ProviderSpecDeliveryMonitoring] as [ProvSpecMon_B]
		on [ProvSpecMon_B].[LearnRefNumber]=ld.[LearnRefNumber]
		and [ProvSpecMon_B].[AimSeqNumber]=ld.[AimSeqNumber]
		and [ProvSpecMon_B].UKPRN = ld.UKPRN
		and [ProvSpecMon_B].[ProvSpecDelMonOccur]='B'

	left join Valid.[ProviderSpecDeliveryMonitoring] as [ProvSpecMon_C]
		on [ProvSpecMon_C].[LearnRefNumber]=ld.[LearnRefNumber]
		and [ProvSpecMon_C].[AimSeqNumber]=ld.[AimSeqNumber]
		and [ProvSpecMon_C].UKPRN = ld.UKPRN
		and [ProvSpecMon_C].[ProvSpecDelMonOccur]='C'

	left join Valid.[ProviderSpecDeliveryMonitoring] as [ProvSpecMon_D]
		on [ProvSpecMon_D].[LearnRefNumber]=ld.[LearnRefNumber]
		and [ProvSpecMon_D].[AimSeqNumber]=ld.[AimSeqNumber]
		and ProvSpecMon_D.UKPRN = ld.UKPRN
		and [ProvSpecMon_D].[ProvSpecDelMonOccur]='D' 
	left join
	(
		select
		[UKPRN],
			[LearnRefNumber],
			[AimSeqNumber],
			max([LDM1]) as [LDM1],
			max([LDM2]) as [LDM2],
			max([LDM3]) as [LDM3],
			max([LDM4]) as [LDM4]
		from
		(
			select
				UKPRN,
				[LearnRefNumber],
				[AimSeqNumber],
				case row_number() over (partition by [LearnRefNumber], AimSeqNumber, UKPRN order by [LearnRefNumber], AimSeqNumber, UKPRN) when 1 then LearnDelFAMCode else null end  as [LDM1],
				case row_number() over (partition by [LearnRefNumber], AimSeqNumber, UKPRN order by [LearnRefNumber], AimSeqNumber, UKPRN) when 2 then LearnDelFAMCode else null end  as [LDM2],
				case row_number() over (partition by [LearnRefNumber], AimSeqNumber, UKPRN order by [LearnRefNumber], AimSeqNumber, UKPRN) when 3 then LearnDelFAMCode else null end  as [LDM3],
				case row_number() over (partition by [LearnRefNumber], AimSeqNumber, UKPRN order by [LearnRefNumber], AimSeqNumber, UKPRN) when 4 then LearnDelFAMCode else null end  as [LDM4]
			from
				[Valid].[LearningDeliveryFAM]
			where
				[LearnDelFAMType]='LDM'
		) as [LDMs]
		group by
			UKPRN,
			[LearnRefNumber],
			[AimSeqNumber]
	) as [LDM]
	on [LDM].[LearnRefNumber]=ld.[LearnRefNumber]
	and LDM.UKPRN = ld.UKPRN
	and LDM.AimSeqNumber = ld.AimSeqNumber

GO
/****** Object:  Table [Valid].[AppFinRecord]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Valid].[AppFinRecord](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[AFinType] [varchar](3) NOT NULL,
	[AFinCode] [int] NOT NULL,
	[AFinDate] [date] NOT NULL,
	[AFinAmount] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [Valid].[TrailblazerApprenticeshipFinancialRecord]    Script Date: 01/12/2017 15:17:12 ******/
create view [Valid].[TrailblazerApprenticeshipFinancialRecord]
as
	select
		UKPRN
		,LearnRefNumber
		,AimSeqNumber
		,AFinType as TBFinType
		,AFinCode as TBFinCode
		,AFinAmount as TBFinAmount
		,AFinDate as TBFinDate
	from
		Valid.AppFinRecord

GO
/****** Object:  Table [dbo].[ValidationError]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [dbo].[ValidationError](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UKPRN] [int] NULL,
	[Source] [varchar](50) NULL,
	[LearnAimRef] [varchar](1000) NULL,
	[AimSeqNum] [bigint] NULL,
	[SWSupAimID] [varchar](1000) NULL,
	[ErrorMessage] [nvarchar](max) NULL,
	[FieldValues] [nvarchar](2000) NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[RuleName] [varchar](50) NULL,
	[Severity] [varchar](2) NULL,
	[FileLevelError] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[AppFinRecord]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[AppFinRecord](
	[AppFinRecord_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearningDelivery_Id] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[AimSeqNumber] [bigint] NULL,
	[AFinType] [varchar](100) NULL,
	[AFinCode] [bigint] NULL,
	[AFinDate] [date] NULL,
	[AFinAmount] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[CollectionDetails]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[CollectionDetails](
	[CollectionDetails_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[Collection] [varchar](3) NULL,
	[Year] [varchar](4) NULL,
	[FilePreparationDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[ContactPreference]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[ContactPreference](
	[ContactPreference_Id] [int] NULL,
	[Learner_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[ContPrefType] [varchar](100) NULL,
	[ContPrefCode] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[DPOutcome]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[DPOutcome](
	[DPOutcome_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearnerDestinationandProgression_Id] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[OutType] [varchar](100) NULL,
	[OutCode] [bigint] NULL,
	[OutStartDate] [date] NULL,
	[OutEndDate] [date] NULL,
	[OutCollDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[EmploymentStatusMonitoring]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[EmploymentStatusMonitoring](
	[EmploymentStatusMonitoring_Id] [int] NULL,
	[LearnerEmploymentStatus_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[DateEmpStatApp] [date] NULL,
	[ESMType] [varchar](100) NULL,
	[ESMCode] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[Learner]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[Learner](
	[Learner_Id] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[UKPRN] [int] NULL,
	[PrevLearnRefNumber] [varchar](1000) NULL,
	[PrevUKPRN] [bigint] NULL,
	[PMUKPRN] [bigint] NULL,
	[ULN] [bigint] NULL,
	[FamilyName] [varchar](1000) NULL,
	[GivenNames] [varchar](1000) NULL,
	[DateOfBirth] [date] NULL,
	[Ethnicity] [bigint] NULL,
	[Sex] [varchar](1000) NULL,
	[LLDDHealthProb] [bigint] NULL,
	[NINumber] [varchar](1000) NULL,
	[PriorAttain] [bigint] NULL,
	[Accom] [bigint] NULL,
	[ALSCost] [bigint] NULL,
	[PlanLearnHours] [bigint] NULL,
	[PlanEEPHours] [bigint] NULL,
	[MathGrade] [varchar](1000) NULL,
	[EngGrade] [varchar](1000) NULL,
	[PostcodePrior] [varchar](1000) NULL,
	[Postcode] [varchar](1000) NULL,
	[AddLine1] [varchar](1000) NULL,
	[AddLine2] [varchar](1000) NULL,
	[AddLine3] [varchar](1000) NULL,
	[AddLine4] [varchar](1000) NULL,
	[TelNo] [varchar](1000) NULL,
	[Email] [varchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[LearnerDestinationandProgression]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[LearnerDestinationandProgression](
	[LearnerDestinationandProgression_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[ULN] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[LearnerEmploymentStatus]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[LearnerEmploymentStatus](
	[LearnerEmploymentStatus_Id] [int] NULL,
	[Learner_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[EmpStat] [bigint] NULL,
	[DateEmpStatApp] [date] NULL,
	[EmpId] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[LearnerFAM]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[LearnerFAM](
	[LearnerFAM_Id] [int] NULL,
	[Learner_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[LearnFAMType] [varchar](1000) NULL,
	[LearnFAMCode] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[LearnerHE]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[LearnerHE](
	[LearnerHE_Id] [int] NULL,
	[Learner_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[UCASPERID] [varchar](1000) NULL,
	[TTACCOM] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[LearnerHEFinancialSupport]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[LearnerHEFinancialSupport](
	[LearnerHEFinancialSupport_Id] [int] NULL,
	[LearnerHE_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[FINTYPE] [bigint] NULL,
	[FINAMOUNT] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[LearningDelivery]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[LearningDelivery](
	[LearningDelivery_Id] [int] NULL,
	[Learner_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[LearnAimRef] [varchar](1000) NULL,
	[AimType] [bigint] NULL,
	[AimSeqNumber] [bigint] NULL,
	[LearnStartDate] [date] NULL,
	[OrigLearnStartDate] [date] NULL,
	[LearnPlanEndDate] [date] NULL,
	[FundModel] [bigint] NULL,
	[ProgType] [bigint] NULL,
	[FworkCode] [bigint] NULL,
	[PwayCode] [bigint] NULL,
	[StdCode] [bigint] NULL,
	[PartnerUKPRN] [bigint] NULL,
	[DelLocPostCode] [varchar](1000) NULL,
	[AddHours] [bigint] NULL,
	[PriorLearnFundAdj] [bigint] NULL,
	[OtherFundAdj] [bigint] NULL,
	[ConRefNumber] [varchar](1000) NULL,
	[EPAOrgID] [varchar](1000) NULL,
	[EmpOutcome] [bigint] NULL,
	[CompStatus] [bigint] NULL,
	[LearnActEndDate] [date] NULL,
	[WithdrawReason] [bigint] NULL,
	[Outcome] [bigint] NULL,
	[AchDate] [date] NULL,
	[OutGrade] [varchar](1000) NULL,
	[SWSupAimId] [varchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[LearningDeliveryFAM]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[LearningDeliveryFAM](
	[LearningDeliveryFAM_Id] [int] NULL,
	[LearningDelivery_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[AimSeqNumber] [bigint] NULL,
	[LearnDelFAMType] [varchar](100) NULL,
	[LearnDelFAMCode] [varchar](1000) NULL,
	[LearnDelFAMDateFrom] [date] NULL,
	[LearnDelFAMDateTo] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[LearningDeliveryHE]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[LearningDeliveryHE](
	[LearningDeliveryHE_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearningDelivery_Id] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[AimSeqNumber] [bigint] NULL,
	[NUMHUS] [varchar](1000) NULL,
	[SSN] [varchar](1000) NULL,
	[QUALENT3] [varchar](1000) NULL,
	[SOC2000] [bigint] NULL,
	[SEC] [bigint] NULL,
	[UCASAPPID] [varchar](1000) NULL,
	[TYPEYR] [bigint] NULL,
	[MODESTUD] [bigint] NULL,
	[FUNDLEV] [bigint] NULL,
	[FUNDCOMP] [bigint] NULL,
	[STULOAD] [float] NULL,
	[YEARSTU] [bigint] NULL,
	[MSTUFEE] [bigint] NULL,
	[PCOLAB] [float] NULL,
	[PCFLDCS] [float] NULL,
	[PCSLDCS] [float] NULL,
	[PCTLDCS] [float] NULL,
	[SPECFEE] [bigint] NULL,
	[NETFEE] [bigint] NULL,
	[GROSSFEE] [bigint] NULL,
	[DOMICILE] [varchar](1000) NULL,
	[ELQ] [bigint] NULL,
	[HEPostCode] [varchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[LearningDeliveryWorkPlacement]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[LearningDeliveryWorkPlacement](
	[LearningDeliveryWorkPlacement_Id] [int] NULL,
	[LearningDelivery_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[AimSeqNumber] [bigint] NULL,
	[WorkPlaceStartDate] [date] NULL,
	[WorkPlaceEndDate] [date] NULL,
	[WorkPlaceHours] [bigint] NULL,
	[WorkPlaceMode] [bigint] NULL,
	[WorkPlaceEmpId] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[LearningProvider]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[LearningProvider](
	[LearningProvider_Id] [int] NULL,
	[UKPRN] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[LLDDandHealthProblem]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[LLDDandHealthProblem](
	[LLDDandHealthProblem_Id] [int] NULL,
	[Learner_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[LLDDCat] [bigint] NULL,
	[PrimaryLLDD] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[ProviderSpecDeliveryMonitoring]    Script Date: 01/12/2017 15:17:12 ******/
CREATE TABLE [Invalid].[ProviderSpecDeliveryMonitoring](
	[ProviderSpecDeliveryMonitoring_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearningDelivery_Id] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[AimSeqNumber] [bigint] NULL,
	[ProvSpecDelMonOccur] [varchar](100) NULL,
	[ProvSpecDelMon] [varchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[ProviderSpecLearnerMonitoring]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Invalid].[ProviderSpecLearnerMonitoring](
	[ProviderSpecLearnerMonitoring_Id] [int] NULL,
	[Learner_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[ProvSpecLearnMonOccur] [varchar](100) NULL,
	[ProvSpecLearnMon] [varchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[Source]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Invalid].[Source](
	[Source_Id] [int] NULL,
	[ProtectiveMarking] [varchar](30) NULL,
	[UKPRN] [int] NULL,
	[SoftwareSupplier] [varchar](40) NULL,
	[SoftwarePackage] [varchar](30) NULL,
	[Release] [varchar](20) NULL,
	[SerialNo] [varchar](2) NULL,
	[DateTime] [datetime] NULL,
	[ReferenceData] [varchar](100) NULL,
	[ComponentSetVersion] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Invalid].[SourceFile]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Invalid].[SourceFile](
	[SourceFile_Id] [int] NULL,
	[UKPRN] [int] NULL,
	[SourceFileName] [varchar](50) NULL,
	[FilePreparationDate] [date] NULL,
	[SoftwareSupplier] [varchar](40) NULL,
	[SoftwarePackage] [varchar](30) NULL,
	[Release] [varchar](20) NULL,
	[SerialNo] [varchar](2) NULL,
	[DateTime] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[AEC_ApprenticeshipPriceEpisode]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[AEC_ApprenticeshipPriceEpisode](
	UKPRN int not null,
	LearnRefNumber varchar(12) not null,
    PriceEpisodeIdentifier varchar(25) not null,
    TNP4 decimal(12,5),
    TNP1 decimal(12,5),
    EpisodeStartDate date,
    TNP2 decimal(12, 5),
    TNP3 decimal(12, 5),
    PriceEpisodeUpperBandLimit decimal(12, 5),
    PriceEpisodePlannedEndDate date,
    PriceEpisodeActualEndDate date,
    PriceEpisodeTotalTNPPrice decimal(12, 5),
    PriceEpisodeUpperLimitAdjustment decimal(12, 5),
    PriceEpisodePlannedInstalments int,
    PriceEpisodeActualInstalments int,
    PriceEpisodeInstalmentsThisPeriod int,
    PriceEpisodeCompletionElement decimal(12, 5),
    PriceEpisodePreviousEarnings decimal(12, 5),
    PriceEpisodeInstalmentValue decimal(12, 5),
    PriceEpisodeOnProgPayment decimal(12, 5),
    PriceEpisodeTotalEarnings decimal(12, 5),
    PriceEpisodeBalanceValue decimal(12, 5),
    PriceEpisodeBalancePayment decimal(12, 5),
    PriceEpisodeCompleted bit,
    PriceEpisodeCompletionPayment decimal(12, 5),
    PriceEpisodeRemainingTNPAmount decimal(12, 5),
    PriceEpisodeRemainingAmountWithinUpperLimit decimal(12, 5),
    PriceEpisodeCappedRemainingTNPAmount decimal(12, 5),
    PriceEpisodeExpectedTotalMonthlyValue decimal(12, 5),
    PriceEpisodeAimSeqNumber bigint,
    PriceEpisodeFirstDisadvantagePayment decimal(12, 5),
    PriceEpisodeSecondDisadvantagePayment decimal(12, 5),
    PriceEpisodeApplic1618FrameworkUpliftBalancing decimal(12, 5),
    PriceEpisodeApplic1618FrameworkUpliftCompletionPayment decimal(12, 5),
    PriceEpisodeApplic1618FrameworkUpliftOnProgPayment decimal(12, 5),
    PriceEpisodeSecondProv1618Pay decimal(12, 5),
    PriceEpisodeFirstEmp1618Pay decimal(12, 5),
    PriceEpisodeSecondEmp1618Pay decimal(12, 5),
    PriceEpisodeFirstProv1618Pay decimal(12, 5),
    PriceEpisodeLSFCash decimal(12, 5),
    PriceEpisodeFundLineType varchar(100),
    PriceEpisodeSFAContribPct decimal(12, 5),
    PriceEpisodeLevyNonPayInd int,
    EpisodeEffectiveTNPStartDate date,
    PriceEpisodeFirstAdditionalPaymentThresholdDate date,
    PriceEpisodeSecondAdditionalPaymentThresholdDate date,
    PriceEpisodeContractType varchar(50),
    PriceEpisodePreviousEarningsSameProvider decimal(12, 5),
    PriceEpisodeTotProgFunding decimal(12, 5),
    PriceEpisodeProgFundIndMinCoInvest decimal(12, 5),
    PriceEpisodeProgFundIndMaxEmpCont decimal(12, 5),
    PriceEpisodeTotalPMRs decimal(12, 5),
    PriceEpisodeCumulativePMRs decimal(12, 5),
    PriceEpisodeCompExemCode int,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[PriceEpisodeIdentifier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[AEC_ApprenticeshipPriceEpisode_Period]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[AEC_ApprenticeshipPriceEpisode_Period](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[PriceEpisodeIdentifier] [varchar](25) NOT NULL,
	[Period] [int] NOT NULL,
	[PriceEpisodeApplic1618FrameworkUpliftBalancing] [decimal](12, 5) NULL,
	[PriceEpisodeApplic1618FrameworkUpliftCompletionPayment] [decimal](12, 5) NULL,
	[PriceEpisodeApplic1618FrameworkUpliftOnProgPayment] [decimal](12, 5) NULL,
	[PriceEpisodeBalancePayment] [decimal](12, 5) NULL,
	[PriceEpisodeBalanceValue] [decimal](12, 5) NULL,
	[PriceEpisodeCompletionPayment] [decimal](12, 5) NULL,
	[PriceEpisodeFirstDisadvantagePayment] [decimal](12, 5) NULL,
	[PriceEpisodeFirstEmp1618Pay] [decimal](12, 5) NULL,
	[PriceEpisodeFirstProv1618Pay] [decimal](12, 5) NULL,
	[PriceEpisodeInstalmentsThisPeriod] [int] NULL,
	[PriceEpisodeLevyNonPayInd] [int] NULL,
	[PriceEpisodeLSFCash] [decimal](12, 5) NULL,
	[PriceEpisodeOnProgPayment] [decimal](12, 5) NULL,
	[PriceEpisodeProgFundIndMaxEmpCont] [decimal](12, 5) NULL,
	[PriceEpisodeProgFundIndMinCoInvest] [decimal](12, 5) NULL,
	[PriceEpisodeSecondDisadvantagePayment] [decimal](12, 5) NULL,
	[PriceEpisodeSecondEmp1618Pay] [decimal](12, 5) NULL,
	[PriceEpisodeSecondProv1618Pay] [decimal](12, 5) NULL,
	[PriceEpisodeSFAContribPct] [decimal](10, 5) NULL,
	[PriceEpisodeTotProgFunding] [decimal](12, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[PriceEpisodeIdentifier] ASC,
	[Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[AEC_ApprenticeshipPriceEpisode_PeriodisedValues]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[AEC_ApprenticeshipPriceEpisode_PeriodisedValues](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[PriceEpisodeIdentifier] [varchar](25) NOT NULL,
	[AttributeName] [varchar](100) NOT NULL,
	[Period_1] [decimal](15, 5) NULL,
	[Period_2] [decimal](15, 5) NULL,
	[Period_3] [decimal](15, 5) NULL,
	[Period_4] [decimal](15, 5) NULL,
	[Period_5] [decimal](15, 5) NULL,
	[Period_6] [decimal](15, 5) NULL,
	[Period_7] [decimal](15, 5) NULL,
	[Period_8] [decimal](15, 5) NULL,
	[Period_9] [decimal](15, 5) NULL,
	[Period_10] [decimal](15, 5) NULL,
	[Period_11] [decimal](15, 5) NULL,
	[Period_12] [decimal](15, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[PriceEpisodeIdentifier] ASC,
	[AttributeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [Rulebase].[AEC_global]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[AEC_global](
	[UKPRN] [int] NULL,
	[LARSVersion] [varchar](100) NULL,
	[RulebaseVersion] [varchar](10) NULL,
	[Year] [varchar](4) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[AEC_HistoricEarningOutput]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[AEC_HistoricEarningOutput](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AppIdentifierOutput] [varchar](10) NOT NULL,
	[AppProgCompletedInTheYearOutput] [bit] NULL,
	[HistoricDaysInYearOutput] [int] NULL,
	[HistoricEffectiveTNPStartDateOutput] [date] NULL,
	[HistoricEmpIdEndWithinYearOutput] [int] NULL,
	[HistoricEmpIdStartWithinYearOutput] [int] NULL,
	[HistoricFworkCodeOutput] [int] NULL,
	[HistoricLearner1618AtStartOutput] [bit] NULL,
	[HistoricPMRAmountOutput] [decimal](12, 5) NULL,
	[HistoricProgrammeStartDateIgnorePathwayOutput] [date] NULL,
	[HistoricProgrammeStartDateMatchPathwayOutput] [date] NULL,
	[HistoricProgTypeOutput] [int] NULL,
	[HistoricPwayCodeOutput] [int] NULL,
	[HistoricSTDCodeOutput] [int] NULL,
	[HistoricTNP1Output] [decimal](12, 5) NULL,
	[HistoricTNP2Output] [decimal](12, 5) NULL,
	[HistoricTNP3Output] [decimal](12, 5) NULL,
	[HistoricTNP4Output] [decimal](12, 5) NULL,
	[HistoricTotal1618UpliftPaymentsInTheYear] [decimal](11, 5) NULL,
	[HistoricTotalProgAimPaymentsInTheYear] [decimal](11, 5) NULL,
	[HistoricULNOutput] [bigint] NULL,
	[HistoricUptoEndDateOutput] [date] NULL,
	[HistoricVirtualTNP3EndofThisYearOutput] [decimal](12, 5) NULL,
	[HistoricVirtualTNP4EndofThisYearOutput] [decimal](12, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AppIdentifierOutput] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[AEC_LearningDelivery]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[AEC_LearningDelivery](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] varchar(12),
	[AimSeqNumber] int,
	[ActualDaysIL] int,
	[ActualNumInstalm] int,
	[AdjStartDate] date,
	[AgeAtProgStart] int,
	[AppAdjLearnStartDate] date,
	[AppAdjLearnStartDateMatchPathway] date,
	[ApplicCompDate] date,
	[CombinedAdjProp] decimal(12,5),
	[Completed] bit,
	[FirstIncentiveThresholdDate] date,
	[FundStart] bit,
	[LDApplic1618FrameworkUpliftBalancingValue] decimal(12,5),
	[LDApplic1618FrameworkUpliftCompElement] decimal(12,5),
	[LDApplic1618FRameworkUpliftCompletionValue] decimal(12,5),
	[LDApplic1618FrameworkUpliftMonthInstalVal] decimal(12,5),
	[LDApplic1618FrameworkUpliftPrevEarnings] decimal(12,5),
	[LDApplic1618FrameworkUpliftPrevEarningsStage1] decimal(12,5),
	[LDApplic1618FrameworkUpliftRemainingAmount] decimal(12,5),
	[LDApplic1618FrameworkUpliftTotalActEarnings] decimal(12,5),
	[LearnAimRef] varchar(8),
	[LearnDel1618AtStart] bit,
	[LearnDelAppAccDaysIL] int,
	[LearnDelApplicDisadvAmount] decimal(12,5),
	[LearnDelApplicEmp1618Incentive] decimal(12,5),
	[LearnDelApplicEmpDate] date,
	[LearnDelApplicProv1618FrameworkUplift] decimal(12,5),
	[LearnDelApplicProv1618Incentive] decimal(12,5),
	[LearnDelAppPrevAccDaysIL] int,
	[LearnDelDaysIL] int,
	[LearnDelDisadAmount] decimal(12,5),
	[LearnDelEligDisadvPayment] bit,
	[LearnDelEmpIdFirstAdditionalPaymentThreshold] int,
	[LearnDelEmpIdSecondAdditionalPaymentThreshold] int,
	[LearnDelHistDaysThisApp] int,
	[LearnDelHistProgEarnings] decimal(12,5),
	[LearnDelInitialFundLineType] varchar(100),
	[LearnDelMathEng] bit,
	[LearnDelProgEarliestACT2Date] date,
	[LearnDelNonLevyProcured] bit,
	[MathEngAimValue] decimal(12,5),
	[OutstandNumOnProgInstalm] int,
	[PlannedNumOnProgInstalm] int,
	[PlannedTotalDaysIL] int,
	[SecondIncentiveThresholdDate] date,
	[ThresholdDays] int
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[AEC_LearningDelivery_Period]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[AEC_LearningDelivery_Period](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[Period] [int] NOT NULL,
	[DisadvFirstPayment] [decimal](10, 5) NULL,
	[DisadvSecondPayment] [decimal](10, 5) NULL,
	[FundLineType] [varchar](100) NULL,
	[InstPerPeriod] [int] NULL,
	[LDApplic1618FrameworkUpliftBalancingPayment] [decimal](10, 5) NULL,
	[LDApplic1618FrameworkUpliftCompletionPayment] [decimal](10, 5) NULL,
	[LDApplic1618FrameworkUpliftOnProgPayment] [decimal](10, 5) NULL,
	[LearnDelContType] [varchar](50) NULL,
	[LearnDelFirstEmp1618Pay] [decimal](10, 5) NULL,
	[LearnDelFirstProv1618Pay] [decimal](10, 5) NULL,
	[LearnDelLevyNonPayInd] [int] NULL,
	[LearnDelSecondEmp1618Pay] [decimal](10, 5) NULL,
	[LearnDelSecondProv1618Pay] [decimal](10, 5) NULL,
	[LearnDelSEMContWaiver] [bit] NULL,
	[LearnDelSFAContribPct] [decimal](10, 5) NULL,
	[LearnSuppFund] [bit] NULL,
	[LearnSuppFundCash] [decimal](10, 5) NULL,
	[MathEngBalPayment] [decimal](10, 5) NULL,
	[MathEngBalPct] [decimal](8, 5) NULL,
	[MathEngOnProgPayment] [decimal](10, 5) NULL,
	[MathEngOnProgPct] [decimal](8, 5) NULL,
	[ProgrammeAimBalPayment] [decimal](10, 5) NULL,
	[ProgrammeAimCompletionPayment] [decimal](10, 5) NULL,
	[ProgrammeAimOnProgPayment] [decimal](10, 5) NULL,
	[ProgrammeAimProgFundIndMaxEmpCont] [decimal](12, 5) NULL,
	[ProgrammeAimProgFundIndMinCoInvest] [decimal](12, 5) NULL,
	[ProgrammeAimTotProgFund] [decimal](12, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC,
	[Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[AEC_LearningDelivery_PeriodisedTextValues]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[AEC_LearningDelivery_PeriodisedTextValues](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[AttributeName] [varchar](100) NOT NULL,
	[Period_1] [varchar](255) NULL,
	[Period_2] [varchar](255) NULL,
	[Period_3] [varchar](255) NULL,
	[Period_4] [varchar](255) NULL,
	[Period_5] [varchar](255) NULL,
	[Period_6] [varchar](255) NULL,
	[Period_7] [varchar](255) NULL,
	[Period_8] [varchar](255) NULL,
	[Period_9] [varchar](255) NULL,
	[Period_10] [varchar](255) NULL,
	[Period_11] [varchar](255) NULL,
	[Period_12] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC,
	[AttributeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[AEC_LearningDelivery_PeriodisedValues]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[AEC_LearningDelivery_PeriodisedValues](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[AttributeName] [varchar](100) NOT NULL,
	[Period_1] [decimal](15, 5) NULL,
	[Period_2] [decimal](15, 5) NULL,
	[Period_3] [decimal](15, 5) NULL,
	[Period_4] [decimal](15, 5) NULL,
	[Period_5] [decimal](15, 5) NULL,
	[Period_6] [decimal](15, 5) NULL,
	[Period_7] [decimal](15, 5) NULL,
	[Period_8] [decimal](15, 5) NULL,
	[Period_9] [decimal](15, 5) NULL,
	[Period_10] [decimal](15, 5) NULL,
	[Period_11] [decimal](15, 5) NULL,
	[Period_12] [decimal](15, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC,
	[AttributeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[ALB_global]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[ALB_global](
	[UKPRN] [int] NOT NULL,
	[LARSVersion] [varchar](100) NULL,
	[PostcodeAreaCostVersion] [varchar](20) NULL,
	[RulebaseVersion] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[ALB_Learner_Period]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[ALB_Learner_Period](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[Period] [int] NOT NULL,
	[ALBSeqNum] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[ALB_Learner_PeriodisedValues]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[ALB_Learner_PeriodisedValues](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AttributeName] [varchar](100) NOT NULL,
	[Period_1] [decimal](15, 5) NULL,
	[Period_2] [decimal](15, 5) NULL,
	[Period_3] [decimal](15, 5) NULL,
	[Period_4] [decimal](15, 5) NULL,
	[Period_5] [decimal](15, 5) NULL,
	[Period_6] [decimal](15, 5) NULL,
	[Period_7] [decimal](15, 5) NULL,
	[Period_8] [decimal](15, 5) NULL,
	[Period_9] [decimal](15, 5) NULL,
	[Period_10] [decimal](15, 5) NULL,
	[Period_11] [decimal](15, 5) NULL,
	[Period_12] [decimal](15, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AttributeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[ALB_LearningDelivery]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[ALB_LearningDelivery](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[Achieved] [bit] NULL,
	[ActualNumInstalm] [int] NULL,
	[AdvLoan] [bit] NULL,
	[ApplicFactDate] [date] NULL,
	[ApplicProgWeightFact] [varchar](1) NULL,
	[AreaCostFactAdj] [decimal](10, 5) NULL,
	[AreaCostInstalment] [decimal](10, 5) NULL,
	[FundLine] [varchar](50) NULL,
	[FundStart] [bit] NULL,
	[LiabilityDate] [date] NULL,
	[LoanBursAreaUplift] [bit] NULL,
	[LoanBursSupp] [bit] NULL,
	[OutstndNumOnProgInstalm] [int] NULL,
	[PlannedNumOnProgInstalm] [int] NULL,
	[WeightedRate] [decimal](10, 4) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[ALB_LearningDelivery_Period]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[ALB_LearningDelivery_Period](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[Period] [int] NOT NULL,
	[ALBCode] [int] NULL,
	[ALBSupportPayment] [decimal](10, 5) NULL,
	[AreaUpliftBalPayment] [decimal](10, 5) NULL,
	[AreaUpliftOnProgPayment] [decimal](10, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC,
	[Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[ALB_LearningDelivery_PeriodisedValues]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[ALB_LearningDelivery_PeriodisedValues](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[AttributeName] [varchar](100) NOT NULL,
	[Period_1] [decimal](15, 5) NULL,
	[Period_2] [decimal](15, 5) NULL,
	[Period_3] [decimal](15, 5) NULL,
	[Period_4] [decimal](15, 5) NULL,
	[Period_5] [decimal](15, 5) NULL,
	[Period_6] [decimal](15, 5) NULL,
	[Period_7] [decimal](15, 5) NULL,
	[Period_8] [decimal](15, 5) NULL,
	[Period_9] [decimal](15, 5) NULL,
	[Period_10] [decimal](15, 5) NULL,
	[Period_11] [decimal](15, 5) NULL,
	[Period_12] [decimal](15, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC,
	[AttributeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[DV_global]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[DV_global](
	[UKPRN] [int] NULL,
	[RulebaseVersion] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[DV_Learner]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[DV_Learner](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[Learn_3rdSector] [int] NULL,
	[Learn_Active] [int] NULL,
	[Learn_ActiveJan] [int] NULL,
	[Learn_ActiveNov] [int] NULL,
	[Learn_ActiveOct] [int] NULL,
	[Learn_Age31Aug] [int] NULL,
	[Learn_BasicSkill] [int] NULL,
	[Learn_EmpStatFDL] [int] NULL,
	[Learn_EmpStatPrior] [int] NULL,
	[Learn_FirstFullLevel2] [int] NULL,
	[Learn_FirstFullLevel2Ach] [int] NULL,
	[Learn_FirstFullLevel3] [int] NULL,
	[Learn_FirstFullLevel3Ach] [int] NULL,
	[Learn_FullLevel2] [int] NULL,
	[Learn_FullLevel2Ach] [int] NULL,
	[Learn_FullLevel3] [int] NULL,
	[Learn_FullLevel3Ach] [int] NULL,
	[Learn_FundAgency] [int] NULL,
	[Learn_FundingSource] [int] NULL,
	[Learn_FundPrvYr] [int] NULL,
	[Learn_ILAcMonth1] [int] NULL,
	[Learn_ILAcMonth10] [int] NULL,
	[Learn_ILAcMonth11] [int] NULL,
	[Learn_ILAcMonth12] [int] NULL,
	[Learn_ILAcMonth2] [int] NULL,
	[Learn_ILAcMonth3] [int] NULL,
	[Learn_ILAcMonth4] [int] NULL,
	[Learn_ILAcMonth5] [int] NULL,
	[Learn_ILAcMonth6] [int] NULL,
	[Learn_ILAcMonth7] [int] NULL,
	[Learn_ILAcMonth8] [int] NULL,
	[Learn_ILAcMonth9] [int] NULL,
	[Learn_ILCurrAcYr] [int] NULL,
	[Learn_LargeEmployer] [int] NULL,
	[Learn_LenEmp] [int] NULL,
	[Learn_LenUnemp] [int] NULL,
	[Learn_LrnAimRecords] [int] NULL,
	[Learn_ModeAttPlanHrs] [int] NULL,
	[Learn_NotionLev] [int] NULL,
	[Learn_NotionLevV2] [int] NULL,
	[Learn_OLASS] [int] NULL,
	[Learn_PrefMethContact] [int] NULL,
	[Learn_PrimaryLLDD] [int] NULL,
	[Learn_PriorEducationStatus] [int] NULL,
	[Learn_UnempBenFDL] [int] NULL,
	[Learn_UnempBenPrior] [int] NULL,
	[Learn_Uplift1516EFA] [decimal](6, 5) NULL,
	[Learn_Uplift1516SFA] [decimal](6, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[DV_LearningDelivery]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[DV_LearningDelivery](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[LearnDel_AccToApp] [int] NULL,
	[LearnDel_AccToAppEmpDate] [date] NULL,
	[LearnDel_AccToAppEmpStat] [int] NULL,
	[LearnDel_AchFullLevel2Pct] [decimal](5, 2) NULL,
	[LearnDel_AchFullLevel3Pct] [decimal](5, 2) NULL,
	[LearnDel_Achieved] [int] NULL,
	[LearnDel_AchievedIY] [int] NULL,
	[LearnDel_AcMonthYTD] [varchar](2) NULL,
	[LearnDel_ActDaysILAfterCurrAcYr] [int] NULL,
	[LearnDel_ActDaysILCurrAcYr] [int] NULL,
	[LearnDel_ActEndDateOnAfterJan1] [int] NULL,
	[LearnDel_ActEndDateOnAfterNov1] [int] NULL,
	[LearnDel_ActEndDateOnAfterOct1] [int] NULL,
	[LearnDel_ActiveIY] [int] NULL,
	[LearnDel_ActiveJan] [int] NULL,
	[LearnDel_ActiveNov] [int] NULL,
	[LearnDel_ActiveOct] [int] NULL,
	[LearnDel_ActTotalDaysIL] [int] NULL,
	[LearnDel_AdvLoan] [int] NULL,
	[LearnDel_AgeAimOrigStart] [int] NULL,
	[LearnDel_AgeAtStart] [int] NULL,
	[LearnDel_App] [int] NULL,
	[LearnDel_App1618Fund] [int] NULL,
	[LearnDel_App1925Fund] [int] NULL,
	[LearnDel_AppAimType] [int] NULL,
	[LearnDel_AppKnowl] [int] NULL,
	[LearnDel_AppMainAim] [int] NULL,
	[LearnDel_AppNonFund] [int] NULL,
	[LearnDel_BasicSkills] [int] NULL,
	[LearnDel_BasicSkillsParticipation] [int] NULL,
	[LearnDel_BasicSkillsType] [int] NULL,
	[LearnDel_CarryIn] [int] NULL,
	[LearnDel_ClassRm] [int] NULL,
	[LearnDel_CompAimApp] [int] NULL,
	[LearnDel_CompAimProg] [int] NULL,
	[LearnDel_Completed] [int] NULL,
	[LearnDel_CompletedIY] [int] NULL,
	[LearnDel_CompleteFullLevel2Pct] [decimal](5, 2) NULL,
	[LearnDel_CompleteFullLevel3Pct] [decimal](5, 2) NULL,
	[LearnDel_EFACoreAim] [int] NULL,
	[LearnDel_Emp6MonthAimStart] [int] NULL,
	[LearnDel_Emp6MonthProgStart] [int] NULL,
	[LearnDel_EmpDateBeforeFDL] [date] NULL,
	[LearnDel_EmpDatePriorFDL] [date] NULL,
	[LearnDel_EmpID] [int] NULL,
	[LearnDel_Employed] [int] NULL,
	[LearnDel_EmpStatFDL] [int] NULL,
	[LearnDel_EmpStatPrior] [int] NULL,
	[LearnDel_EmpStatPriorFDL] [int] NULL,
	[LearnDel_EnhanAppFund] [int] NULL,
	[LearnDel_FullLevel2AchPct] [decimal](5, 2) NULL,
	[LearnDel_FullLevel2ContPct] [decimal](5, 2) NULL,
	[LearnDel_FullLevel3AchPct] [decimal](5, 2) NULL,
	[LearnDel_FullLevel3ContPct] [decimal](5, 2) NULL,
	[LearnDel_FuncSkills] [int] NULL,
	[LearnDel_FundAgency] [int] NULL,
	[LearnDel_FundingLineType] [varchar](100) NULL,
	[LearnDel_FundingSource] [int] NULL,
	[LearnDel_FundPrvYr] [int] NULL,
	[LearnDel_FundStart] [int] NULL,
	[LearnDel_GCE] [int] NULL,
	[LearnDel_GCSE] [int] NULL,
	[LearnDel_ILAcMonth1] [int] NULL,
	[LearnDel_ILAcMonth10] [int] NULL,
	[LearnDel_ILAcMonth11] [int] NULL,
	[LearnDel_ILAcMonth12] [int] NULL,
	[LearnDel_ILAcMonth2] [int] NULL,
	[LearnDel_ILAcMonth3] [int] NULL,
	[LearnDel_ILAcMonth4] [int] NULL,
	[LearnDel_ILAcMonth5] [int] NULL,
	[LearnDel_ILAcMonth6] [int] NULL,
	[LearnDel_ILAcMonth7] [int] NULL,
	[LearnDel_ILAcMonth8] [int] NULL,
	[LearnDel_ILAcMonth9] [int] NULL,
	[LearnDel_ILCurrAcYr] [int] NULL,
	[LearnDel_IYActEndDate] [date] NULL,
	[LearnDel_IYPlanEndDate] [date] NULL,
	[LearnDel_IYStartDate] [date] NULL,
	[LearnDel_KeySkills] [int] NULL,
	[LearnDel_LargeEmpDiscountId] [int] NULL,
	[LearnDel_LargeEmployer] [int] NULL,
	[LearnDel_LastEmpDate] [date] NULL,
	[LearnDel_LeaveMonth] [int] NULL,
	[LearnDel_LenEmp] [int] NULL,
	[LearnDel_LenUnemp] [int] NULL,
	[LearnDel_LoanBursFund] [int] NULL,
	[LearnDel_NotionLevel] [int] NULL,
	[LearnDel_NotionLevelV2] [int] NULL,
	[LearnDel_NumHEDatasets] [int] NULL,
	[LearnDel_OccupAim] [int] NULL,
	[LearnDel_OLASS] [int] NULL,
	[LearnDel_OLASSCom] [int] NULL,
	[LearnDel_OLASSCus] [int] NULL,
	[LearnDel_OrigStartDate] [date] NULL,
	[LearnDel_PlanDaysILAfterCurrAcYr] [int] NULL,
	[LearnDel_PlanDaysILCurrAcYr] [int] NULL,
	[LearnDel_PlanEndBeforeAug1] [int] NULL,
	[LearnDel_PlanEndOnAfterJan1] [int] NULL,
	[LearnDel_PlanEndOnAfterNov1] [int] NULL,
	[LearnDel_PlanEndOnAfterOct1] [int] NULL,
	[LearnDel_PlanTotalDaysIL] [int] NULL,
	[LearnDel_PriorEducationStatus] [int] NULL,
	[LearnDel_Prog] [int] NULL,
	[LearnDel_ProgAimAch] [int] NULL,
	[LearnDel_ProgAimApp] [int] NULL,
	[LearnDel_ProgCompleted] [int] NULL,
	[LearnDel_ProgCompletedIY] [int] NULL,
	[LearnDel_ProgStartDate] [date] NULL,
	[LearnDel_QCF] [int] NULL,
	[LearnDel_QCFCert] [int] NULL,
	[LearnDel_QCFDipl] [int] NULL,
	[LearnDel_QCFType] [int] NULL,
	[LearnDel_RegAim] [int] NULL,
	[LearnDel_SecSubAreaTier1] [varchar](3) NULL,
	[LearnDel_SecSubAreaTier2] [varchar](5) NULL,
	[LearnDel_SFAApproved] [int] NULL,
	[LearnDel_SourceFundEFA] [int] NULL,
	[LearnDel_SourceFundSFA] [int] NULL,
	[LearnDel_StartBeforeApr1] [int] NULL,
	[LearnDel_StartBeforeAug1] [int] NULL,
	[LearnDel_StartBeforeDec1] [int] NULL,
	[LearnDel_StartBeforeFeb1] [int] NULL,
	[LearnDel_StartBeforeJan1] [int] NULL,
	[LearnDel_StartBeforeJun1] [int] NULL,
	[LearnDel_StartBeforeMar1] [int] NULL,
	[LearnDel_StartBeforeMay1] [int] NULL,
	[LearnDel_StartBeforeNov1] [int] NULL,
	[LearnDel_StartBeforeOct1] [int] NULL,
	[LearnDel_StartBeforeSep1] [int] NULL,
	[LearnDel_StartIY] [int] NULL,
	[LearnDel_StartJan1] [int] NULL,
	[LearnDel_StartMonth] [int] NULL,
	[LearnDel_StartNov1] [int] NULL,
	[LearnDel_StartOct1] [int] NULL,
	[LearnDel_SuccRateStat] [int] NULL,
	[LearnDel_TrainAimType] [int] NULL,
	[LearnDel_TransferDiffProvider] [int] NULL,
	[LearnDel_TransferDiffProviderGovStrat] [int] NULL,
	[LearnDel_TransferProvider] [int] NULL,
	[LearnDel_UfIProv] [int] NULL,
	[LearnDel_UnempBenFDL] [int] NULL,
	[LearnDel_UnempBenPrior] [int] NULL,
	[LearnDel_Withdrawn] [int] NULL,
	[LearnDel_WorkplaceLocPostcode] [varchar](8) NULL,
	[Prog_AccToApp] [int] NULL,
	[Prog_Achieved] [int] NULL,
	[Prog_AchievedIY] [int] NULL,
	[Prog_ActEndDate] [date] NULL,
	[Prog_ActiveIY] [int] NULL,
	[Prog_AgeAtStart] [int] NULL,
	[Prog_EarliestAim] [int] NULL,
	[Prog_Employed] [int] NULL,
	[Prog_FundPrvYr] [int] NULL,
	[Prog_ILCurrAcYear] [int] NULL,
	[Prog_LatestAim] [int] NULL,
	[Prog_SourceFundEFA] [int] NULL,
	[Prog_SourceFundSFA] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[EFA_global]    Script Date: 01/12/2017 15:17:13 ******/
CREATE TABLE [Rulebase].[EFA_global](
	[UKPRN] [int] NOT NULL,
	[LARSVersion] [varchar](50) NULL,
	[OrgVersion] [varchar](50) NULL,
	[PostcodeDisadvantageVersion] [varchar](50) NULL,
	[RulebaseVersion] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[EFA_Learner]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[EFA_Learner](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AcadMonthPayment] [int] NULL,
	[AcadProg] [bit] NULL,
	[ActualDaysILCurrYear] [int] NULL,
	[AreaCostFact1618Hist] [decimal](10, 5) NULL,
	[Block1DisadvUpliftNew] [decimal](10, 5) NULL,
	[Block2DisadvElementsNew] [decimal](10, 5) NULL,
	[ConditionOfFundingEnglish] [varchar](100) NULL,
	[ConditionOfFundingMaths] [varchar](100) NULL,
	[CoreAimSeqNumber] [int] NULL,
	[FullTimeEquiv] [decimal](10, 5) NULL,
	[FundLine] [varchar](100) NULL,
	[LearnerActEndDate] [date] NULL,
	[LearnerPlanEndDate] [date] NULL,
	[LearnerStartDate] [date] NULL,
	[NatRate] [decimal](10, 5) NULL,
	[OnProgPayment] [decimal](10, 5) NULL,
	[PlannedDaysILCurrYear] [int] NULL,
	[ProgWeightHist] [decimal](10, 5) NULL,
	[ProgWeightNew] [decimal](10, 5) NULL,
	[PrvDisadvPropnHist] [decimal](10, 5) NULL,
	[PrvHistLrgProgPropn] [decimal](10, 5) NULL,
	[PrvRetentFactHist] [decimal](10, 5) NULL,
	[RateBand] [varchar](50) NULL,
	[RetentNew] [decimal](10, 5) NULL,
	[StartFund] [bit] NULL,
	[ThresholdDays] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[EFA_SFA_global]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[EFA_SFA_global](
	[UKPRN] [int] NOT NULL,
	[RulebaseVersion] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[EFA_SFA_Learner_Period]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[EFA_SFA_Learner_Period](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[Period] [int] NOT NULL,
	[LnrOnProgPay] [decimal](10, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[EFA_SFA_Learner_PeriodisedValues]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[EFA_SFA_Learner_PeriodisedValues](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AttributeName] [varchar](100) NOT NULL,
	[Period_1] [decimal](15, 5) NULL,
	[Period_2] [decimal](15, 5) NULL,
	[Period_3] [decimal](15, 5) NULL,
	[Period_4] [decimal](15, 5) NULL,
	[Period_5] [decimal](15, 5) NULL,
	[Period_6] [decimal](15, 5) NULL,
	[Period_7] [decimal](15, 5) NULL,
	[Period_8] [decimal](15, 5) NULL,
	[Period_9] [decimal](15, 5) NULL,
	[Period_10] [decimal](15, 5) NULL,
	[Period_11] [decimal](15, 5) NULL,
	[Period_12] [decimal](15, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AttributeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[ESFVAL_global]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[ESFVAL_global](
	[UKPRN] [int] NULL,
	[RulebaseVersion] [varchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[ESFVAL_ValidationError]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[ESFVAL_ValidationError](
	[UKPRN] [int] NULL,
	[AimSeqNumber] [bigint] NULL,
	[ErrorString] [varchar](2000) NULL,
	[FieldValues] [varchar](2000) NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[RuleId] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[SFA_global]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[SFA_global](
	[UKPRN] [varchar](8) NOT NULL,
	[CurFundYr] [varchar](9) NULL,
	[LARSVersion] [varchar](100) NULL,
	[OrgVersion] [varchar](100) NULL,
	[PostcodeDisadvantageVersion] [varchar](50) NULL,
	[RulebaseVersion] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[SFA_LearningDelivery]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[SFA_LearningDelivery](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[AchApplicDate] [date] NULL,
	[Achieved] [bit] NULL,
	[AchieveElement] [decimal](10, 5) NULL,
	[AchievePayElig] [bit] NULL,
	[AchievePayPctPreTrans] [decimal](10, 5) NULL,
	[AchPayTransHeldBack] [decimal](10, 5) NULL,
	[ActualDaysIL] [int] NULL,
	[ActualNumInstalm] [int] NULL,
	[ActualNumInstalmPreTrans] [int] NULL,
	[ActualNumInstalmTrans] [int] NULL,
	[AdjLearnStartDate] [date] NULL,
	[AdltLearnResp] [bit] NULL,
	[AgeAimStart] [int] NULL,
	[AimValue] [decimal](10, 5) NULL,
	[AppAdjLearnStartDate] [date] NULL,
	[AppAgeFact] [decimal](10, 5) NULL,
	[AppATAGTA] [bit] NULL,
	[AppCompetency] [bit] NULL,
	[AppFuncSkill] [bit] NULL,
	[AppFuncSkill1618AdjFact] [decimal](10, 5) NULL,
	[AppKnowl] [bit] NULL,
	[AppLearnStartDate] [date] NULL,
	[ApplicEmpFactDate] [date] NULL,
	[ApplicFactDate] [date] NULL,
	[ApplicFundRateDate] [date] NULL,
	[ApplicProgWeightFact] [varchar](1) NULL,
	[ApplicUnweightFundRate] [decimal](10, 5) NULL,
	[ApplicWeightFundRate] [decimal](10, 5) NULL,
	[AppNonFund] [bit] NULL,
	[AreaCostFactAdj] [decimal](10, 5) NULL,
	[BalInstalmPreTrans] [int] NULL,
	[BaseValueUnweight] [decimal](10, 5) NULL,
	[CapFactor] [decimal](10, 5) NULL,
	[DisUpFactAdj] [decimal](10, 4) NULL,
	[EmpOutcomePayElig] [bit] NULL,
	[EmpOutcomePctHeldBackTrans] [decimal](10, 5) NULL,
	[EmpOutcomePctPreTrans] [decimal](10, 5) NULL,
	[EmpRespOth] [bit] NULL,
	[ESOL] [bit] NULL,
	[FullyFund] [bit] NULL,
	[FundLine] [varchar](100) NULL,
	[FundStart] [bit] NULL,
	[LargeEmployerID] [int] NULL,
	[LargeEmployerSFAFctr] [decimal](10, 2) NULL,
	[LargeEmployerStatusDate] [date] NULL,
	[LTRCUpliftFctr] [decimal](10, 5) NULL,
	[NonGovCont] [decimal](10, 5) NULL,
	[OLASSCustody] [bit] NULL,
	[OnProgPayPctPreTrans] [decimal](10, 5) NULL,
	[OutstndNumOnProgInstalm] [int] NULL,
	[OutstndNumOnProgInstalmTrans] [int] NULL,
	[PlannedNumOnProgInstalm] [int] NULL,
	[PlannedNumOnProgInstalmTrans] [int] NULL,
	[PlannedTotalDaysIL] [int] NULL,
	[PlannedTotalDaysILPreTrans] [int] NULL,
	[PropFundRemain] [decimal](10, 2) NULL,
	[PropFundRemainAch] [decimal](10, 2) NULL,
	[PrscHEAim] [bit] NULL,
	[Residential] [bit] NULL,
	[Restart] [bit] NULL,
	[SpecResUplift] [decimal](10, 5) NULL,
	[StartPropTrans] [decimal](10, 5) NULL,
	[ThresholdDays] [int] NULL,
	[Traineeship] [bit] NULL,
	[Trans] [bit] NULL,
	[TrnAdjLearnStartDate] [date] NULL,
	[TrnWorkPlaceAim] [bit] NULL,
	[TrnWorkPrepAim] [bit] NULL,
	[UnWeightedRateFromESOL] [decimal](10, 5) NULL,
	[UnweightedRateFromLARS] [decimal](10, 5) NULL,
	[WeightedRateFromESOL] [decimal](10, 5) NULL,
	[WeightedRateFromLARS] [decimal](10, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[SFA_LearningDelivery_Period]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[SFA_LearningDelivery_Period](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[Period] [int] NOT NULL,
	[AchievePayment] [decimal](10, 5) NULL,
	[AchievePayPct] [decimal](10, 5) NULL,
	[AchievePayPctTrans] [decimal](10, 5) NULL,
	[BalancePayment] [decimal](10, 5) NULL,
	[BalancePaymentUncapped] [decimal](10, 5) NULL,
	[BalancePct] [decimal](10, 5) NULL,
	[BalancePctTrans] [decimal](10, 5) NULL,
	[EmpOutcomePay] [decimal](10, 5) NULL,
	[EmpOutcomePct] [decimal](10, 5) NULL,
	[EmpOutcomePctTrans] [decimal](10, 5) NULL,
	[InstPerPeriod] [int] NULL,
	[LearnSuppFund] [bit] NULL,
	[LearnSuppFundCash] [decimal](10, 5) NULL,
	[OnProgPayment] [decimal](10, 5) NULL,
	[OnProgPaymentUncapped] [decimal](10, 5) NULL,
	[OnProgPayPct] [decimal](10, 5) NULL,
	[OnProgPayPctTrans] [decimal](10, 5) NULL,
	[TransInstPerPeriod] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC,
	[Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[SFA_LearningDelivery_PeriodisedValues]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[SFA_LearningDelivery_PeriodisedValues](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[AttributeName] [varchar](100) NOT NULL,
	[Period_1] [decimal](15, 5) NULL,
	[Period_2] [decimal](15, 5) NULL,
	[Period_3] [decimal](15, 5) NULL,
	[Period_4] [decimal](15, 5) NULL,
	[Period_5] [decimal](15, 5) NULL,
	[Period_6] [decimal](15, 5) NULL,
	[Period_7] [decimal](15, 5) NULL,
	[Period_8] [decimal](15, 5) NULL,
	[Period_9] [decimal](15, 5) NULL,
	[Period_10] [decimal](15, 5) NULL,
	[Period_11] [decimal](15, 5) NULL,
	[Period_12] [decimal](15, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC,
	[AttributeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[TBL_global]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[TBL_global](
	[UKPRN] [int] NOT NULL,
	[CurFundYr] [varchar](10) NULL,
	[LARSVersion] [varchar](100) NULL,
	[RulebaseVersion] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[TBL_LearningDelivery]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[TBL_LearningDelivery](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[ProgStandardStartDate] [date] NULL,
	[FundLine] [varchar](50) NULL,
	[MathEngAimValue] [decimal](10, 5) NULL,
	[PlannedNumOnProgInstalm] [int] NULL,
	[LearnSuppFundCash] [decimal](10, 5) NULL,
	[AdjProgStartDate] [date] NULL,
	[LearnSuppFund] [bit] NULL,
	[MathEngOnProgPayment] [decimal](10, 5) NULL,
	[InstPerPeriod] [int] NULL,
	[SmallBusPayment] [decimal](10, 5) NULL,
	[YoungAppSecondPayment] [decimal](10, 5) NULL,
	[CoreGovContPayment] [decimal](10, 5) NULL,
	[YoungAppEligible] [bit] NULL,
	[SmallBusEligible] [bit] NULL,
	[MathEngOnProgPct] [int] NULL,
	[AgeStandardStart] [int] NULL,
	[YoungAppSecondThresholdDate] [date] NULL,
	[EmpIdFirstDayStandard] [int] NULL,
	[EmpIdFirstYoungAppDate] [int] NULL,
	[EmpIdSecondYoungAppDate] [int] NULL,
	[EmpIdSmallBusDate] [int] NULL,
	[YoungAppFirstThresholdDate] [date] NULL,
	[AchApplicDate] [date] NULL,
	[AchEligible] [bit] NULL,
	[Achieved] [bit] NULL,
	[AchievementApplicVal] [decimal](10, 5) NULL,
	[AchPayment] [decimal](10, 5) NULL,
	[ActualNumInstalm] [int] NULL,
	[CombinedAdjProp] [bigint] NULL,
	[EmpIdAchDate] [int] NULL,
	[LearnDelDaysIL] [int] NULL,
	[LearnDelStandardAccDaysIL] [int] NULL,
	[LearnDelStandardPrevAccDaysIL] [int] NULL,
	[LearnDelStandardTotalDaysIL] [int] NULL,
	[ActualDaysIL] [int] NULL,
	[MathEngBalPayment] [decimal](10, 5) NULL,
	[MathEngBalPct] [bigint] NULL,
	[MathEngLSFFundStart] [bit] NULL,
	[PlannedTotalDaysIL] [int] NULL,
	[MathEngLSFThresholdDays] [int] NULL,
	[OutstandNumOnProgInstalm] [int] NULL,
	[SmallBusApplicVal] [decimal](10, 5) NULL,
	[SmallBusStatusFirstDayStandard] [int] NULL,
	[SmallBusStatusThreshold] [int] NULL,
	[YoungAppApplicVal] [decimal](10, 5) NULL,
	[CoreGovContCapApplicVal] [bigint] NULL,
	[CoreGovContUncapped] [decimal](10, 5) NULL,
	[ApplicFundValDate] [date] NULL,
	[YoungAppFirstPayment] [decimal](10, 5) NULL,
	[YoungAppPayment] [decimal](10, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[TBL_LearningDelivery_Period]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[TBL_LearningDelivery_Period](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[Period] [int] NOT NULL,
	[AchPayment] [decimal](10, 5) NULL,
	[CoreGovContPayment] [decimal](10, 5) NULL,
	[CoreGovContUncapped] [decimal](10, 5) NULL,
	[InstPerPeriod] [int] NULL,
	[LearnSuppFund] [bit] NULL,
	[LearnSuppFundCash] [decimal](10, 5) NULL,
	[MathEngBalPayment] [decimal](10, 5) NULL,
	[MathEngBalPct] [decimal](8, 5) NULL,
	[MathEngOnProgPayment] [decimal](10, 5) NULL,
	[MathEngOnProgPct] [decimal](8, 5) NULL,
	[SmallBusPayment] [decimal](10, 5) NULL,
	[YoungAppFirstPayment] [decimal](10, 5) NULL,
	[YoungAppPayment] [decimal](10, 5) NULL,
	[YoungAppSecondPayment] [decimal](10, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC,
	[Period] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[TBL_LearningDelivery_PeriodisedValues]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[TBL_LearningDelivery_PeriodisedValues](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[AttributeName] [varchar](100) NOT NULL,
	[Period_1] [decimal](15, 5) NULL,
	[Period_2] [decimal](15, 5) NULL,
	[Period_3] [decimal](15, 5) NULL,
	[Period_4] [decimal](15, 5) NULL,
	[Period_5] [decimal](15, 5) NULL,
	[Period_6] [decimal](15, 5) NULL,
	[Period_7] [decimal](15, 5) NULL,
	[Period_8] [decimal](15, 5) NULL,
	[Period_9] [decimal](15, 5) NULL,
	[Period_10] [decimal](15, 5) NULL,
	[Period_11] [decimal](15, 5) NULL,
	[Period_12] [decimal](15, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC,
	[AttributeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[VAL_global]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[VAL_global](
	[UKPRN] [int] NOT NULL,
	[EmployerVersion] [varchar](50) NULL,
	[LARSVersion] [varchar](50) NULL,
	[OrgVersion] [varchar](50) NULL,
	[PostcodeVersion] [varchar](50) NULL,
	[RulebaseVersion] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[VAL_Learner]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[VAL_Learner](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[VAL_LearningDelivery]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[VAL_LearningDelivery](
	[UKPRN] [int] NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[AimSeqNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[VAL_ValidationError]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[VAL_ValidationError](
	[UKPRN] [int] NOT NULL,
	[AimSeqNumber] [bigint] NULL,
	[ErrorString] [varchar](2000) NULL,
	[FieldValues] [varchar](2000) NULL,
	[LearnRefNumber] [varchar](100) NULL,
	[RuleId] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Rulebase].[VALDP_global]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Rulebase].[VALDP_global](
	[UKPRN] [int] NOT NULL,
	[OrgVersion] [varchar](50) NULL,
	[RulebaseVersion] [varchar](10) NULL,
	[ULNVersion] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

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

/****** Object:  Table [Valid].[CollectionDetails]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Valid].[CollectionDetails](
	[UKPRN] [int] NOT NULL,
	[Collection] [varchar](3) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[FilePreparationDate] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[ContactPreference]    Script Date: 01/12/2017 15:17:14 ******/
CREATE TABLE [Valid].[ContactPreference](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[ContPrefType] [varchar](3) NOT NULL,
	[ContPrefCode] [int] NOT NULL,
 CONSTRAINT [PK_ContactPref] PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[ContPrefType] ASC,
	[ContPrefCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[DPOutcome]    Script Date: 01/12/2017 15:17:15 ******/
CREATE TABLE [Valid].[DPOutcome](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[OutType] [varchar](3) NOT NULL,
	[OutCode] [int] NOT NULL,
	[OutStartDate] [date] NOT NULL,
	[OutEndDate] [date] NULL,
	[OutCollDate] [date] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[LearnerDestinationandProgression]    Script Date: 01/12/2017 15:17:15 ******/
CREATE TABLE [Valid].[LearnerDestinationandProgression](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[ULN] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[LearnerHE]    Script Date: 01/12/2017 15:17:15 ******/
CREATE TABLE [Valid].[LearnerHE](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[UCASPERID] [varchar](10) NULL,
	[TTACCOM] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[LearnerHEFinancialSupport]    Script Date: 01/12/2017 15:17:15 ******/
CREATE TABLE [Valid].[LearnerHEFinancialSupport](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[FINTYPE] [int] NOT NULL,
	[FINAMOUNT] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[FINTYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[LearningDeliveryHE]    Script Date: 01/12/2017 15:17:15 ******/
CREATE TABLE [Valid].[LearningDeliveryHE](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[NUMHUS] [varchar](20) NULL,
	[SSN] [varchar](13) NULL,
	[QUALENT3] [varchar](3) NULL,
	[SOC2000] [int] NULL,
	[SEC] [int] NULL,
	[UCASAPPID] [varchar](9) NULL,
	[TYPEYR] [int] NOT NULL,
	[MODESTUD] [int] NOT NULL,
	[FUNDLEV] [int] NOT NULL,
	[FUNDCOMP] [int] NOT NULL,
	[STULOAD] [decimal](4, 1) NULL,
	[YEARSTU] [int] NOT NULL,
	[MSTUFEE] [int] NOT NULL,
	[PCOLAB] [decimal](4, 1) NULL,
	[PCFLDCS] [decimal](4, 1) NULL,
	[PCSLDCS] [decimal](4, 1) NULL,
	[PCTLDCS] [decimal](4, 1) NULL,
	[SPECFEE] [int] NOT NULL,
	[NETFEE] [int] NULL,
	[GROSSFEE] [int] NULL,
	[DOMICILE] [varchar](2) NULL,
	[ELQ] [int] NULL,
	[HEPostCode] [varchar](8) NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[LearningDeliveryWorkPlacement]    Script Date: 01/12/2017 15:17:15 ******/
CREATE TABLE [Valid].[LearningDeliveryWorkPlacement](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[WorkPlaceStartDate] [date] NOT NULL,
	[WorkPlaceEndDate] [date] NULL,
	[WorkPlaceHours] [int] NULL,
	[WorkPlaceMode] [int] NOT NULL,
	[WorkPlaceEmpId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[LearningProvider]    Script Date: 01/12/2017 15:17:15 ******/
CREATE TABLE [Valid].[LearningProvider](
	[UKPRN] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[LLDDandHealthProblem]    Script Date: 01/12/2017 15:17:15 ******/
CREATE TABLE [Valid].[LLDDandHealthProblem](
	[UKPRN] [int] NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[LLDDCat] [int] NOT NULL,
	[PrimaryLLDD] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UKPRN] ASC,
	[LearnRefNumber] ASC,
	[LLDDCat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[Source]    Script Date: 01/12/2017 15:17:15 ******/
CREATE TABLE [Valid].[Source](
	[ProtectiveMarking] [varchar](30) NULL,
	[UKPRN] [int] NOT NULL,
	[SoftwareSupplier] [varchar](40) NULL,
	[SoftwarePackage] [varchar](30) NULL,
	[Release] [varchar](20) NULL,
	[SerialNo] [varchar](2) NULL,
	[DateTime] [datetime] NULL,
	[ReferenceData] [varchar](100) NULL,
	[ComponentSetVersion] [varchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Valid].[SourceFile]    Script Date: 01/12/2017 15:17:15 ******/
CREATE TABLE [Valid].[SourceFile](
	[UKPRN] [int] NOT NULL,
	[SourceFileName] [varchar](50) NOT NULL,
	[FilePreparationDate] [date] NULL,
	[SoftwareSupplier] [varchar](40) NULL,
	[SoftwarePackage] [varchar](30) NULL,
	[Release] [varchar](20) NULL,
	[SerialNo] [varchar](2) NULL,
	[DateTime] [datetime] NULL
) ON [PRIMARY]
GO
