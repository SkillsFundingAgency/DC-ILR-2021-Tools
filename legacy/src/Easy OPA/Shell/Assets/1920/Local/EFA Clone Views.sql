-- CME 23 March 2019
-- re runnable clone view script

use [EFATest1920]

-- these views are part of the requirement to form a single/multi provider source synchronicity
if not exists(select schema_id from sys.schemas where name='Clone')	
begin
	exec('create schema Clone')
end
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_AppFinRecord'))
begin
	drop index idx_AppFinRecord on Clone.AppFinRecord
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.AppFinRecord'))
begin
	drop view Clone.AppFinRecord
end
go

create view Clone.AppFinRecord
with schemabinding
as
	select	afr.PK_AppFinRecord,
			ld.PK_LearningDelivery as FK_LearningDelivery,
			afr.UKPRN,
			afr.LearnRefNumber,
			afr.AimSeqNumber,
			afr.AFinType,
			afr.AFinCode,
			afr.AFinDate,
			afr.AFinAmount
	from	Valid.AppFinRecord as afr
				join Valid.LearningDelivery as ld 
					on	ld.UKPRN = afr.UKPRN
					and	ld.LearnRefNumber = afr.LearnRefNumber
go

create unique clustered index idx_AppFinRecord on Clone.AppFinRecord(PK_AppFinRecord, FK_LearningDelivery, UKPRN)
go

if exists(select 1 from sys.views where object_id = object_id('Clone.CollectionDetails'))
begin
	drop view Clone.CollectionDetails
end
go

create view Clone.CollectionDetails
as
	select	PK_CollectionDetails,
			UKPRN,
			[Year],
			FilePreparationDate,
			[Collection]
	from	Valid.CollectionDetails
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_ContactPreference'))
begin
	drop index idx_ContactPreference on Clone.ContactPreference
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.ContactPreference'))
begin
	drop view Clone.ContactPreference
end
go

create view Clone.ContactPreference
with schemabinding
as
	select	cp.PK_ContactPreference,
			l.PK_Learner as FK_Learner,
			cp.UKPRN,
			l.LearnRefNumber,
			cp.ContPrefType,
			cp.ContPrefCode
	from	Valid.ContactPreference as cp
				join Valid.Learner as l 
					on	l.UKPRN = cp.UKPRN
					and	l.LearnRefNumber = cp.LearnRefNumber
go

create unique clustered index idx_ContactPreference on Clone.ContactPreference(PK_ContactPreference, FK_Learner, UKPRN)
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_DPOutcome'))
begin
	drop index idx_DPOutcome on Clone.DPOutcome
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.DPOutcome'))
begin
	drop view Clone.DPOutcome
end
go

create view Clone.DPOutcome
with schemabinding
as
	select	dp.PK_DPOutcome,
			ldp.PK_LearnerDestinationandProgression  as FK_LearnerDestinationandProgression,
			dp.UKPRN,
			ldp.LearnRefNumber,
			dp.OutType,
			dp.OutCode,
			dp.OutStartDate,
			dp.OutEndDate,
			dp.OutCollDate
	from	Valid.DPOutcome as dp
				join Valid.LearnerDestinationandProgression as ldp 
					on	ldp.UKPRN = dp.UKPRN 
					and	ldp.LearnRefNumber = dp.LearnRefNumber
go

create unique clustered index idx_DPOutcome on Clone.DPOutcome(PK_DPOutcome, FK_LearnerDestinationandProgression, UKPRN)
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_EmploymentStatusMonitoring'))
begin
	drop index idx_EmploymentStatusMonitoring on Clone.EmploymentStatusMonitoring
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.EmploymentStatusMonitoring'))
begin
	drop view Clone.EmploymentStatusMonitoring
end
go

create view Clone.EmploymentStatusMonitoring
with schemabinding
as
	select	esm.PK_EmploymentStatusMonitoring,
			les.PK_LearnerEmploymentStatus  as FK_LearnerEmploymentStatus,
			esm.UKPRN,
			esm.LearnRefNumber,
			les.DateEmpStatApp,
			esm.ESMType,
			esm.ESMCode
	from	Valid.EmploymentStatusMonitoring as esm
				join Valid.LearnerEmploymentStatus as les 
					on	les.UKPRN = esm.UKPRN
					and	les.LearnRefNumber = esm.LearnRefNumber
go

create unique clustered index idx_EmploymentStatusMonitoring on Clone.EmploymentStatusMonitoring(PK_EmploymentStatusMonitoring, FK_LearnerEmploymentStatus, UKPRN)
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_Learner'))
begin
	drop index idx_Learner on Clone.Learner
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.Learner'))
begin
	drop view Clone.Learner
end
go

create view Clone.Learner
with schemabinding
as
	select	PK_Learner,
			LearnRefNumber,
			PrevLearnRefNumber,
			UKPRN,
			PrevUKPRN,
			PMUKPRN,
			ULN,
			CampId,
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
	from	Valid.Learner
go

create unique clustered index idx_Learner on Clone.Learner(PK_Learner, UKPRN)
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_LearnerDestinationandProgression'))
begin
	drop index idx_LearnerDestinationandProgression on Clone.LearnerDestinationandProgression
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.LearnerDestinationandProgression'))
begin
	drop view Clone.LearnerDestinationandProgression
end
go

create view Clone.LearnerDestinationandProgression
with schemabinding
as
	select	PK_LearnerDestinationandProgression,
			UKPRN,
			LearnRefNumber,
			ULN
	from	Valid.LearnerDestinationandProgression
go

create unique clustered index idx_LearnerDestinationandProgression on Clone.LearnerDestinationandProgression(PK_LearnerDestinationandProgression, UKPRN)
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_LearnerEmploymentStatus'))
begin
	drop index idx_LearnerEmploymentStatus on Clone.LearnerEmploymentStatus
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.LearnerEmploymentStatus'))
begin
	drop view Clone.LearnerEmploymentStatus
end
go

create view Clone.LearnerEmploymentStatus
with schemabinding
as
	select	les.PK_LearnerEmploymentStatus,
			l.PK_Learner as FK_Learner,
			les.UKPRN,
			les.LearnRefNumber,
			les.EmpStat,
			les.DateEmpStatApp,
			les.EmpId,
			les.AgreeId
	from	Valid.LearnerEmploymentStatus as les
				join Valid.Learner as l 
					on	l.UKPRN = les.UKPRN 
					and	l.LearnRefNumber = les.LearnRefNumber
go

create unique clustered index idx_LearnerEmploymentStatus on Clone.LearnerEmploymentStatus(PK_LearnerEmploymentStatus, FK_Learner, UKPRN)
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_LearnerFAM'))
begin
	drop index idx_LearnerFAM on Clone.LearnerFAM
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.LearnerFAM'))
begin
	drop view Clone.LearnerFAM
end
go

create view Clone.LearnerFAM
with schemabinding
as
	select	lf.PK_LearnerFAM,
			l.PK_Learner as FK_Learner,
			lf.UKPRN,
			lf.LearnRefNumber,
			lf.LearnFAMType,
			lf.LearnFAMCode
	from	Valid.LearnerFAM as lf
				join Valid.Learner as l 
					on	l.UKPRN = lf.UKPRN
					and	l.LearnRefNumber = lf.LearnRefNumber
go

create unique clustered index idx_LearnerFAM on Clone.LearnerFAM(PK_LearnerFAM, FK_Learner, UKPRN)
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_LearnerHE'))
begin
	drop index idx_LearnerHE on Clone.LearnerHE
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.LearnerHE'))
begin
	drop view Clone.LearnerHE
end
go

create view Clone.LearnerHE
with schemabinding
as
	select	lh.PK_LearnerHE,
			l.PK_Learner as FK_Learner,
			lh.UKPRN,
			lh.LearnRefNumber,
			lh.UCASPERID,
			lh.TTACCOM
	from	Valid.LearnerHE as lh
				join Valid.Learner as l 
					on	l.UKPRN = lh.UKPRN 
					and	l.LearnRefNumber = lh.LearnRefNumber
go

create unique clustered index idx_LearnerHE on Clone.LearnerHE(PK_LearnerHE, FK_Learner, UKPRN)
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_LearnerHEFinancialSupport'))
begin
	drop index idx_LearnerHEFinancialSupport on Clone.LearnerHEFinancialSupport
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.LearnerHEFinancialSupport'))
begin
	drop view Clone.LearnerHEFinancialSupport
end
go

create view Clone.LearnerHEFinancialSupport
with schemabinding
as
	select	lhfs.PK_LearnerHEFinancialSupport,
			lh.PK_LearnerHE as FK_LearnerHE,
			lhfs.UKPRN,
			lhfs.LearnRefNumber,
			lhfs.FINTYPE,
			lhfs.FINAMOUNT
	from	Valid.LearnerHEFinancialSupport as lhfs
				join Valid.LearnerHE as lh 
					on	lh.UKPRN = lhfs.UKPRN 
					and	lh.LearnRefNumber = lhfs.LearnRefNumber
go

create unique clustered index idx_LearnerHEFinancialSupport on Clone.LearnerHEFinancialSupport(PK_LearnerHEFinancialSupport, FK_LearnerHE, UKPRN)
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_LearningDelivery'))
begin
	drop index idx_LearningDelivery on Clone.LearningDelivery
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.LearningDelivery'))
begin
	drop view Clone.LearningDelivery
end
go

create view Clone.LearningDelivery
with schemabinding
as
	select	ld.PK_LearningDelivery,
			l.PK_Learner as FK_Learner,
			ld.UKPRN,
			ld.LearnRefNumber,
			ld.LearnAimRef,
			ld.AimType,
			ld.AimSeqNumber,
			ld.LearnStartDate,
			ld.OrigLearnStartDate,
			ld.LearnPlanEndDate,
			ld.FundModel,
			ld.PHours,
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
			ld.SWSupAimId
	from	Valid.LearningDelivery as ld
				join Valid.Learner as l 
					on	l.UKPRN = ld.UKPRN 
					and	l.LearnRefNumber = ld.LearnRefNumber
go

create unique clustered index idx_LearningDelivery on Clone.LearningDelivery(PK_LearningDelivery, FK_Learner, UKPRN)--, AimSeqNumber)
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_LearningDeliveryFAM'))
begin
	drop index idx_LearningDeliveryFAM on Clone.LearningDeliveryFAM
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.LearningDeliveryFAM'))
begin
	drop view Clone.LearningDeliveryFAM
end
go

create view Clone.LearningDeliveryFAM
with schemabinding
as
	select	ldf.PK_LearningDeliveryFAM,
			ld.PK_LearningDelivery as FK_LearningDelivery,
			ldf.UKPRN,
			ldf.LearnRefNumber,
			ldf.AimSeqNumber,
			ldf.LearnDelFAMType,
			ldf.LearnDelFAMCode,
			ldf.LearnDelFAMDateFrom,
			ldf.LearnDelFAMDateTo
	from	Valid.LearningDeliveryFAM as ldf
				join Valid.LearningDelivery as ld 
					on	ld.UKPRN = ldf.UKPRN 
					and	ld.LearnRefNumber = ldf.LearnRefNumber 
					and	ld.AimSeqNumber = ldf.AimSeqNumber
go

create unique clustered index idx_LearningDeliveryFAM on Clone.LearningDeliveryFAM(PK_LearningDeliveryFAM, FK_LearningDelivery, UKPRN)--, AimSeqNumber)
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_LearningDeliveryHE'))
begin
	drop index idx_LearningDeliveryHE on Clone.LearningDeliveryHE
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.LearningDeliveryHE'))
begin
	drop view Clone.LearningDeliveryHE
end
go

create view Clone.LearningDeliveryHE
with schemabinding
as
	select	ldh.PK_LearningDeliveryHE,
			ld.PK_LearningDelivery as FK_LearningDelivery,
			ldh.UKPRN,
			ldh.LearnRefNumber,
			ldh.AimSeqNumber,
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
	from	Valid.LearningDeliveryHE as ldh
				join Valid.LearningDelivery as ld 
					on	ld.UKPRN = ldh.UKPRN 
					and	ld.LearnRefNumber = ldh.LearnRefNumber 
					and	ld.AimSeqNumber = ldh.AimSeqNumber
go

create unique clustered index idx_LearningDeliveryHE on Clone.LearningDeliveryHE(PK_LearningDeliveryHE, FK_LearningDelivery, UKPRN)--, AimSeqNumber)
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_LearningDeliveryWorkPlacement'))
begin
	drop index idx_LearningDeliveryWorkPlacement on Clone.LearningDeliveryWorkPlacement
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.LearningDeliveryWorkPlacement'))
begin
	drop view Clone.LearningDeliveryWorkPlacement
end
go

create view Clone.LearningDeliveryWorkPlacement
with schemabinding
as
	select	ldwp.PK_LearningDeliveryWorkPlacement,
			ld.PK_LearningDelivery as FK_LearningDelivery,
			ldwp.UKPRN,
			ldwp.LearnRefNumber,
			ldwp.AimSeqNumber,
			ldwp.WorkPlaceStartDate,
			ldwp.WorkPlaceEndDate,
			ldwp.WorkPlaceHours,
			ldwp.WorkPlaceMode,
			ldwp.WorkPlaceEmpId
	from	Valid.LearningDeliveryWorkPlacement as ldwp
				join Valid.LearningDelivery as ld 
					on	ld.UKPRN = ldwp.UKPRN 
					and	ld.LearnRefNumber = ldwp.LearnRefNumber 
					and	ld.AimSeqNumber = ldwp.AimSeqNumber
go

create unique clustered index idx_LearningDeliveryWorkPlacement on Clone.LearningDeliveryWorkPlacement(PK_LearningDeliveryWorkPlacement, FK_LearningDelivery, UKPRN)--, AimSeqNumber)
go

if exists(select 1 from sys.views where object_id = object_id('Clone.LearningProvider'))
begin
	drop view Clone.LearningProvider
end
go

create view Clone.LearningProvider
as
	select	PK_LearningProvider,
			UKPRN
	from	Valid.LearningProvider
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_LLDDandHealthProblem'))
begin
	drop index idx_LLDDandHealthProblem on Clone.LLDDandHealthProblem
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.LLDDandHealthProblem'))
begin
	drop view Clone.LLDDandHealthProblem
end
go

create view Clone.LLDDandHealthProblem
with schemabinding
as
	select	lhp.PK_LLDDandHealthProblem,
			l.PK_Learner as FK_Learner,
			lhp.UKPRN,
			lhp.LearnRefNumber,
			lhp.LLDDCat,
			lhp.PrimaryLLDD
	from	Valid.LLDDandHealthProblem as lhp
				join Valid.Learner as l 
					on	l.UKPRN = lhp.UKPRN 
					and	l.LearnRefNumber = lhp.LearnRefNumber
go

create unique clustered index idx_LLDDandHealthProblem on Clone.LLDDandHealthProblem(PK_LLDDandHealthProblem, FK_Learner, UKPRN)
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_ProviderSpecDeliveryMonitoring'))
begin
	drop index idx_ProviderSpecDeliveryMonitoring on Clone.ProviderSpecDeliveryMonitoring
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.ProviderSpecDeliveryMonitoring'))
begin
	drop view Clone.ProviderSpecDeliveryMonitoring
end
go

create view Clone.ProviderSpecDeliveryMonitoring
with schemabinding
as
	select	psdm.PK_ProviderSpecDeliveryMonitoring,
			ld.PK_LearningDelivery as FK_LearningDelivery,
			psdm.UKPRN,
			psdm.LearnRefNumber,
			psdm.AimSeqNumber,
			psdm.ProvSpecDelMonOccur,
			psdm.ProvSpecDelMon
	from	Valid.ProviderSpecDeliveryMonitoring as psdm
				join Valid.LearningDelivery as ld 
					on	ld.UKPRN = psdm.UKPRN 
					and	ld.LearnRefNumber = psdm.LearnRefNumber 
					and	ld.AimSeqNumber = psdm.AimSeqNumber
go

create unique clustered index idx_ProviderSpecDeliveryMonitoring on Clone.ProviderSpecDeliveryMonitoring(PK_ProviderSpecDeliveryMonitoring, FK_LearningDelivery, UKPRN)--, AimSeqNumber)
go

if exists(select 1 from sys.indexes where object_id = object_id('idx_ProviderSpecLearnerMonitoring'))
begin
	drop index idx_ProviderSpecLearnerMonitoring on Clone.ProviderSpecLearnerMonitoring
end
go

if exists(select 1 from sys.views where object_id = object_id('Clone.ProviderSpecLearnerMonitoring'))
begin
	drop view Clone.ProviderSpecLearnerMonitoring
end
go

create view Clone.ProviderSpecLearnerMonitoring
with schemabinding
as
	select	pslm.PK_ProviderSpecLearnerMonitoring,
			l.PK_Learner as FK_Learner,
			pslm.UKPRN,
			pslm.LearnRefNumber,
			pslm.ProvSpecLearnMonOccur,
			pslm.ProvSpecLearnMon
	from	Valid.ProviderSpecLearnerMonitoring as pslm
				join Valid.Learner as l 
					on	l.UKPRN = pslm.UKPRN 
					and	l.LearnRefNumber = pslm.LearnRefNumber
go

create unique clustered index idx_ProviderSpecLearnerMonitoring on Clone.ProviderSpecLearnerMonitoring(PK_ProviderSpecLearnerMonitoring, FK_Learner, UKPRN)
go

if exists(select 1 from sys.views where object_id = object_id('Clone.[Source]'))
begin
	drop view Clone.[Source]
end
go

create view Clone.[Source]
as
	select	PK_Source,
			ProtectiveMarking,
			UKPRN,
			SoftwareSupplier,
			SoftwarePackage,
			Release,
			SerialNo,
			[DateTime],
			ReferenceData,
			ComponentSetVersion
	from	Valid.[Source]
go

if exists(select 1 from sys.views where object_id = object_id('Clone.SourceFile'))
begin
	drop view Clone.SourceFile
end
go

create view Clone.SourceFile
as
	select	PK_SourceFile,
			UKPRN,
			SourceFileName,
			FilePreparationDate,
			SoftwareSupplier,
			SoftwarePackage,
			Release,
			[DateTime],
			SerialNo
	from	Valid.SourceFile
go
