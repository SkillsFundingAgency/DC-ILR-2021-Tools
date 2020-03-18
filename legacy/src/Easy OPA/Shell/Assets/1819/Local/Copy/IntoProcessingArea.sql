--1718 Copy Script

truncate table Input.LearningProvider
insert into Input.LearningProvider
(
	LearningProvider_Id
	,UKPRN
)
select
	PK_LearningProvider
	,UKPRN
from
	[${SourceDataStore}].[dbo].LearningProvider
go

truncate table Input.CollectionDetails
insert into Input.CollectionDetails
(
	CollectionDetails_Id
	,[Year]
	,[FilePreparationDate]
	,[Collection]
)
select
	PK_CollectionDetails
	,[Year]
	,[FilePreparationDate]
	,[Collection]
from
	[${SourceDataStore}].[dbo].CollectionDetails
go

truncate table Input.[Source]
insert into [Input].[Source]
(
	Source_Id
	,ProtectiveMarking
	,UKPRN
	,SoftwareSupplier
	,SoftwarePackage
	,Release
	,SerialNo
	,[DateTime]
	,[ReferenceData]
	,[ComponentSetVersion]
)
select
	PK_Source
	,ProtectiveMarking
	,UKPRN
	,SoftwareSupplier
	,SoftwarePackage
	,Release
	,SerialNo
	,[DateTime]
	,[ReferenceData]
	,[ComponentSetVersion]
from
	[${SourceDataStore}].[dbo].[Source]
go

truncate table Input.SourceFile
insert into Input.SourceFile
(
	SourceFile_Id
	,SourceFileName
	,FilePreparationDate
	,SoftwareSupplier
	,SoftwarePackage
	,Release
	,[DateTime]
	,[SerialNo]
)
select
	PK_SourceFile
	,SourceFileName
	,FilePreparationDate
	,SoftwareSupplier
	,SoftwarePackage
	,Release
	,[DateTime]
	,[SerialNo]
from
	[${SourceDataStore}].[dbo].SourceFile
go

truncate table Input.AppFinRecord
insert into Input.AppFinRecord
(
	AppFinRecord_Id
	,LearningDelivery_Id
	,LearnRefNumber
	,AimSeqNumber
	,AFinType
	,AFinCode
	,AFinDate
	,AFinAmount
)
select
	afr.PK_AppFinRecord
	,afr.FK_LearningDelivery
	,l.LearnRefNumber
	,ld.AimSeqNumber
	,afr.AFinType
	,afr.AFinCode
	,afr.AFinDate
	,afr.AFinAmount
from
	[${SourceDataStore}].[dbo].AppFinRecord as afr
	join
		[${SourceDataStore}].[dbo].LearningDelivery as ld
			on ld.PK_LearningDelivery = afr.FK_LearningDelivery
	join
		[${SourceDataStore}].[dbo].Learner as l
			on l.PK_Learner = ld.FK_Learner
go

truncate table Input.ContactPreference
insert into Input.ContactPreference
(
	ContactPreference_Id
	,Learner_Id
	,LearnRefNumber
	,ContPrefType
	,ContPrefCode
)
select
	cp.PK_ContactPreference
	,cp.FK_Learner
	,l.LearnRefNumber
	,cp.ContPrefType
	,cp.ContPrefCode
from
	[${SourceDataStore}].[dbo].ContactPreference as cp
	join
		[${SourceDataStore}].[dbo].Learner as l
			on l.PK_Learner = cp.FK_Learner
go

truncate table Input.DPOutcome
insert into Input.DPOutcome
(
	DPOutcome_Id
	,LearnerDestinationandProgression_Id
	,LearnRefNumber
	,OutType
	,OutCode
	,OutStartDate
	,OutEndDate
	,OutCollDate
)
select
	dp.PK_DPOutcome
	,dp.FK_LearnerDestinationandProgression
	,ldp.LearnRefNumber
	,dp.OutType
	,dp.OutCode
	,dp.OutStartDate
	,dp.OutEndDate
	,dp.OutCollDate
from
	[${SourceDataStore}].[dbo].DPOutcome as dp
	join
		[${SourceDataStore}].[dbo].LearnerDestinationandProgression as ldp
			on ldp.PK_LearnerDestinationandProgression = dp.FK_LearnerDestinationandProgression
go

truncate table Input.EmploymentStatusMonitoring
insert into Input.EmploymentStatusMonitoring
(
	EmploymentStatusMonitoring_Id
	,LearnerEmploymentStatus_Id
	,LearnRefNumber
	,DateEmpStatApp
	,ESMType
	,ESMCode
)
select
	esm.PK_EmploymentStatusMonitoring
	,esm.FK_LearnerEmploymentStatus
	,l.LearnRefNumber
	,les.DateEmpStatApp
	,esm.ESMType
	,esm.ESMCode
from
	[${SourceDataStore}].[dbo].EmploymentStatusMonitoring as esm
	join
		[${SourceDataStore}].[dbo].LearnerEmploymentStatus as les
			on les.PK_LearnerEmploymentStatus = esm.FK_LearnerEmploymentStatus
	join
		[${SourceDataStore}].[dbo].Learner as l
			on l.PK_Learner = les.FK_Learner
go

truncate table Input.Learner
insert into Input.Learner
(
	Learner_Id, 
	LearnRefNumber, 
	PrevLearnRefNumber, 
	PrevUKPRN, 
	PMUKPRN, 
	ULN, 
	FamilyName, 
	GivenNames, 
	DateOfBirth, 
	Ethnicity, 
	Sex, 
	LLDDHealthProb, 
	NINumber, 
	PriorAttain, 
	Accom, 
	ALSCost, 
	PlanLearnHours, 
	PlanEEPHours, 
	MathGrade,
	EngGrade, 
	PostcodePrior, 
	Postcode, 
	AddLine1, 
	AddLine2, 
	AddLine3, 
	AddLine4, 
	TelNo, 
	Email
)
select
	PK_Learner, 
	LearnRefNumber, 
	PrevLearnRefNumber, 
	PrevUKPRN, 
	PMUKPRN, 
	ULN, 
	FamilyName, 
	GivenNames, 
	DateOfBirth, 
	Ethnicity, 
	Sex, 
	LLDDHealthProb, 
	NINumber, 
	PriorAttain, 
	Accom, 
	ALSCost, 
	PlanLearnHours, 
	PlanEEPHours, 
	MathGrade,
	EngGrade, 
	PostcodePrior, 
	Postcode, 
	AddLine1, 
	AddLine2, 
	AddLine3, 
	AddLine4, 
	TelNo, 
	Email
from
	[${SourceDataStore}].[dbo].Learner
go

truncate table Input.LearnerDestinationandProgression
insert into Input.LearnerDestinationandProgression
(
	LearnerDestinationandProgression_Id,
	LearnRefNumber,
	ULN
)
select
	PK_LearnerDestinationandProgression,
	LearnRefNumber,
	ULN
from
	[${SourceDataStore}].[dbo].LearnerDestinationandProgression
go

truncate table Input.LearnerEmploymentStatus
insert into Input.LearnerEmploymentStatus
(
	LearnerEmploymentStatus_Id
	,Learner_Id
	,LearnRefNumber
	,EmpStat
	,DateEmpStatApp
	,EmpId
)
select
	les.PK_LearnerEmploymentStatus
	,les.FK_Learner
	,l.LearnRefNumber
	,les.EmpStat
	,les.DateEmpStatApp
	,les.EmpId
from
	[${SourceDataStore}].[dbo].LearnerEmploymentStatus as les
	join
		[${SourceDataStore}].[dbo].Learner as l
			on l.PK_Learner = les.FK_Learner
go

truncate table Input.LearnerFAM
insert into Input.LearnerFAM
(
	LearnerFAM_Id
	,Learner_Id
	,LearnRefNumber
	,LearnFAMType
	,LearnFAMCode
)
select
	lf.PK_LearnerFAM
	,lf.FK_Learner
	,l.LearnRefNumber
	,lf.LearnFAMType
	,lf.LearnFAMCode
from
	[${SourceDataStore}].[dbo].LearnerFAM as lf
	join
		[${SourceDataStore}].[dbo].Learner as l
			on l.PK_Learner = lf.FK_Learner
go

truncate table Input.LearnerHE
insert into Input.LearnerHE
(
	LearnerHE_Id
	,Learner_Id
	,LearnRefNumber
	,UCASPERID
	,TTACCOM
)
select
	lh.PK_LearnerHE
	,lh.FK_Learner
	,l.LearnRefNumber
	,lh.UCASPERID
	,lh.TTACCOM
from
	[${SourceDataStore}].[dbo].LearnerHE as lh
	join
		[${SourceDataStore}].[dbo].Learner as l
			on l.PK_Learner = lh.FK_Learner
go

truncate table Input.LearnerHEFinancialSupport
insert into Input.LearnerHEFinancialSupport
(
	LearnerHEFinancialSupport_Id
	,LearnerHE_Id
	,LearnRefNumber
	,FINTYPE
	,FINAMOUNT
)
select
	lhfs.PK_LearnerHEFinancialSupport
	,lhfs.FK_LearnerHE
	,l.LearnRefNumber
	,lhfs.FINTYPE
	,lhfs.FINAMOUNT
from
	[${SourceDataStore}].[dbo].LearnerHEFinancialSupport as lhfs
	join
		[${SourceDataStore}].[dbo].LearnerHE as lh
			on lh.PK_LearnerHE = lhfs.FK_LearnerHE
	join
		[${SourceDataStore}].[dbo].Learner as l
			on l.PK_Learner = lh.FK_Learner
go

truncate table Input.LearningDelivery
insert into Input.LearningDelivery
(
	LearningDelivery_Id, 
	Learner_Id, 
	LearnRefNumber, 
	LearnAimRef, 
	AimType, 
	AimSeqNumber, 
	LearnStartDate, 
	OrigLearnStartDate, 
	LearnPlanEndDate, 
	FundModel,
	ProgType, 
	FworkCode, 
	PwayCode, 
	StdCode, 
	PartnerUKPRN, 
	DelLocPostCode, 
	AddHours, 
	PriorLearnFundAdj, 
	OtherFundAdj, 
	ConRefNumber, 
	EPAOrgID, 
	EmpOutcome, 
	CompStatus, 
	LearnActEndDate, 
	WithdrawReason, 
	Outcome, 
	AchDate, 
	OutGrade, 
	SWSupAimId
)
select
	ld.PK_LearningDelivery
	,ld.FK_Learner 
	,l.LearnRefNumber 
	,ld.LearnAimRef 
	,ld.AimType 
	,ld.AimSeqNumber 
	,ld.LearnStartDate 
	,ld.OrigLearnStartDate 
	,ld.LearnPlanEndDate 
	,ld.FundModel
	,ld.ProgType 
	,ld.FworkCode 
	,ld.PwayCode 
	,ld.StdCode 
	,ld.PartnerUKPRN 
	,ld.DelLocPostCode 
	,ld.AddHours 
	,ld.PriorLearnFundAdj 
	,ld.OtherFundAdj 
	,ld.ConRefNumber 
	,ld.EPAOrgID 
	,ld.EmpOutcome 
	,ld.CompStatus 
	,ld.LearnActEndDate 
	,ld.WithdrawReason 
	,ld.Outcome 
	,ld.AchDate 
	,ld.OutGrade 
	,ld.SWSupAimId
from
	[${SourceDataStore}].[dbo].LearningDelivery as ld
	join
		[${SourceDataStore}].[dbo].Learner as l
			on l.PK_Learner = ld.FK_Learner
go

truncate table Input.LearningDeliveryFAM
insert into Input.LearningDeliveryFAM
(
	LearningDeliveryFAM_Id
	,LearningDelivery_Id
	,LearnRefNumber
	,AimSeqNumber
	,LearnDelFAMType
	,LearnDelFAMCode
	,LearnDelFAMDateFrom
	,LearnDelFAMDateTo
)
select
	ldf.PK_LearningDeliveryFAM
	,ldf.FK_LearningDelivery
	,l.LearnRefNumber
	,ld.AimSeqNumber
	,ldf.LearnDelFAMType
	,ldf.LearnDelFAMCode
	,ldf.LearnDelFAMDateFrom
	,ldf.LearnDelFAMDateTo
from
	[${SourceDataStore}].[dbo].LearningDeliveryFAM as ldf
	join
		[${SourceDataStore}].[dbo].LearningDelivery as ld
			on ld.PK_LearningDelivery = ldf.FK_LearningDelivery
	join
		[${SourceDataStore}].[dbo].Learner as l
			on l.PK_Learner = ld.FK_Learner
go

truncate table Input.LearningDeliveryHE
insert into Input.LearningDeliveryHE
(
	LearningDeliveryHE_Id, 
	LearningDelivery_Id, 
	LearnRefNumber, 
	AimSeqNumber,
	NUMHUS, 
	SSN, 
	QUALENT3, 
	SOC2000, 
	SEC, 
	UCASAPPID, 
	TYPEYR, 
	MODESTUD, 
	FUNDLEV, 
	FUNDCOMP, 
	STULOAD, 
	YEARSTU, 
	MSTUFEE, 
	PCOLAB, 
	PCFLDCS, 
	PCSLDCS, 
	PCTLDCS, 
	SPECFEE, 
	NETFEE, 
	GROSSFEE, 
	DOMICILE, 
	ELQ, 
	HEPostCode
)
select
	ldh.PK_LearningDeliveryHE
	,ldh.FK_LearningDelivery
	,l.LearnRefNumber
	,ld.AimSeqNumber,
	ldh.NUMHUS, 
	ldh.SSN, 
	ldh.QUALENT3, 
	ldh.SOC2000, 
	ldh.SEC, 
	ldh.UCASAPPID, 
	ldh.TYPEYR, 
	ldh.MODESTUD, 
	ldh.FUNDLEV, 
	ldh.FUNDCOMP, 
	ldh.STULOAD, 
	ldh.YEARSTU, 
	ldh.MSTUFEE, 
	ldh.PCOLAB, 
	ldh.PCFLDCS, 
	ldh.PCSLDCS, 
	ldh.PCTLDCS, 
	ldh.SPECFEE, 
	ldh.NETFEE, 
	ldh.GROSSFEE, 
	ldh.DOMICILE, 
	ldh.ELQ, 
	ldh.HEPostCode
from
	[${SourceDataStore}].[dbo].LearningDeliveryHE as ldh
	join
		[${SourceDataStore}].[dbo].LearningDelivery as ld
			on ld.PK_LearningDelivery = ldh.FK_LearningDelivery
	join
		[${SourceDataStore}].[dbo].Learner as l
			on l.PK_Learner = ld.FK_learner
go

truncate table Input.LearningDeliveryWorkPlacement
insert into Input.LearningDeliveryWorkPlacement
(
	LearningDeliveryWorkPlacement_Id
	,LearningDelivery_Id
	,LearnRefNumber
	,AimSeqNumber
	,WorkPlaceStartDate
	,WorkPlaceEndDate
	,WorkPlaceHours
	,WorkPlaceMode
	,WorkPlaceEmpId
)
select
	ldwp.PK_LearningDeliveryWorkPlacement
	,ldwp.FK_LearningDelivery
	,l.LearnRefNumber
	,ld.AimSeqNumber
	,ldwp.WorkPlaceStartDate
	,ldwp.WorkPlaceEndDate
	,ldwp.WorkPlaceHours
	,ldwp.WorkPlaceMode
	,ldwp.WorkPlaceEmpId
from
	[${SourceDataStore}].[dbo].LearningDeliveryWorkPlacement as ldwp
	join
		[${SourceDataStore}].[dbo].LearningDelivery as ld
			on ld.PK_LearningDelivery = ldwp.FK_LearningDelivery
	join
		[${SourceDataStore}].[dbo].Learner as l
			on l.PK_Learner = ld.FK_Learner
go

truncate table Input.LLDDandHealthProblem
insert into Input.LLDDandHealthProblem
(
	LLDDandHealthProblem_Id
	,Learner_Id
	,LearnRefNumber
	,LLDDCat
	,PrimaryLLDD
)
select
	lhp.PK_LLDDandHealthProblem
	,lhp.FK_Learner
	,l.LearnRefNumber
	,lhp.LLDDCat
	,lhp.PrimaryLLDD
from
	[${SourceDataStore}].[dbo].LLDDandHealthProblem as lhp
	join
		[${SourceDataStore}].[dbo].Learner as l
			on PK_Learner = lhp.FK_Learner
go

truncate table Input.ProviderSpecDeliveryMonitoring
insert into Input.ProviderSpecDeliveryMonitoring
(
	ProviderSpecDeliveryMonitoring_Id
	,LearningDelivery_Id
	,LearnRefNumber
	,AimSeqNumber
	,ProvSpecDelMonOccur
	,ProvSpecDelMon
)
select
	psdm.PK_ProviderSpecDeliveryMonitoring
	,psdm.FK_LearningDelivery
	,l.LearnRefNumber
	,ld.AimseqNumber
	,psdm.ProvSpecDelMonOccur
	,psdm.ProvSpecDelMon
from
	[${SourceDataStore}].[dbo].ProviderSpecDeliveryMonitoring as psdm
	join
		[${SourceDataStore}].[dbo].LearningDelivery as ld
			on ld.PK_LearningDelivery = psdm.FK_LearningDelivery
	join
		[${SourceDataStore}].[dbo].Learner as l
			on l.PK_Learner = ld.FK_Learner
go

truncate table Input.ProviderSpecLearnerMonitoring
insert into Input.ProviderSpecLearnerMonitoring
(
	ProviderSpecLearnerMonitoring_Id
	,Learner_Id
	,LearnRefNumber
	,ProvSpecLearnMonOccur
	,ProvSpecLearnMon
)
select
	pslm.PK_ProviderSpecLearnerMonitoring
	,pslm.FK_Learner
	,l.LearnRefNumber
	,pslm.ProvSpecLearnMonOccur
	,pslm.ProvSpecLearnMon
from	
	[${SourceDataStore}].[dbo].ProviderSpecLearnerMonitoring as pslm
	join
		[${SourceDataStore}].[dbo].Learner as l
			on l.PK_Learner = pslm.FK_Learner
go