if not exists (select * from sys.schemas where name = 'DEDS_Invalid')
begin
	exec ('create schema DEDS_Invalid')
end
go

if object_id ('DEDS_Invalid.LearningProvider', 'v') is not null
begin
	drop view DEDS_Invalid.LearningProvider
end
go

create view DEDS_Invalid.LearningProvider
as 
	select	LearningProvider_Id,
			UKPRN
	from	Invalid.LearningProvider
go

if object_id('DEDS_Invalid.LearningDeliveryHE', 'v') is not null
begin
	drop view DEDS_Invalid.LearningDeliveryHE
end
go

create view DEDS_Invalid.LearningDeliveryHE
as
	select	LearningDeliveryHE_Id,
			lp.UKPRN,
			ldh.LearningDelivery_Id,
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
	from	Invalid.LearningDeliveryHE as ldh
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id('DEDS_Invalid.LearnerDestinationandProgression','v') is not null
begin
	drop view DEDS_Invalid.LearnerDestinationandProgression
end
go

create view DEDS_Invalid.LearnerDestinationandProgression
as
	select	lp.UKPRN,
			ldp.LearnerDestinationandProgression_Id,
			ldp.LearnRefNumber,
			ldp.ULN
	from	Invalid.LearnerDestinationandProgression as ldp
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id('DEDS_Invalid.DPOutcome','v') is not null
begin
	drop view DEDS_Invalid.DPOutcome
end
go

create view DEDS_Invalid.DPOutcome
as
	select	lp.UKPRN,
			dp.DPOutcome_Id,
			dp.LearnerDestinationandProgression_Id,
			dp.LearnRefNumber,
			dp.OutType,
			dp.OutCode,
			dp.OutStartDate,
			dp.OutEndDate,
			dp.OutCollDate
	from	Invalid.DPOutcome as dp
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id('DEDS_Invalid.ProviderSpecDeliveryMonitoring','v') is not null
begin
	drop view DEDS_Invalid.ProviderSpecDeliveryMonitoring
end
go

create view DEDS_Invalid.ProviderSpecDeliveryMonitoring
as
	select	lp.UKPRN,
			pdm.ProviderSpecDeliveryMonitoring_Id,
			pdm.LearningDelivery_Id,
			pdm.LearnRefNumber,
			pdm.AimSeqNumber,
			pdm.ProvSpecDelMonOccur,
			pdm.ProvSpecDelMon
	from	Invalid.ProviderSpecDeliveryMonitoring as pdm
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id ('DEDS_Invalid.AppFinRecord','v') is not null 
begin
	drop view DEDS_Invalid.AppFinRecord
end
go

create view DEDS_Invalid.AppFinRecord
as
	select	lp.UKPRN,
			afr.AppFinRecord_Id,
			afr.LearningDelivery_Id,
			afr.LearnRefNumber,
			afr.AimSeqNumber,
			afr.AFinType,
			afr.AFinCode,
			afr.AFinDate,
			afr.AFinAmount
	from	Invalid.AppFinRecord as afr
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id ('DEDS_Invalid.LearningDeliveryWorkPlacement','v') is not null
begin
	drop view DEDS_Invalid.LearningDeliveryWorkPlacement
end
go

create view DEDS_Invalid.LearningDeliveryWorkPlacement
as
	select	lp.UKPRN,
			ldwp.LearningDeliveryWorkPlacement_Id,
			ldwp.LearningDelivery_Id,
			ldwp.LearnRefNumber,
			ldwp.AimSeqNumber,
			ldwp.WorkPlaceStartDate,
			ldwp.WorkPlaceEndDate,
			ldwp.WorkPlaceHours,
			ldwp.WorkPlaceMode,
			ldwp.WorkPlaceEmpId
	from	Invalid.LearningDeliveryWorkPlacement as ldwp
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id('DEDS_Invalid.LearningDeliveryFAM','v') is not null
begin
	drop view DEDS_Invalid.LearningDeliveryFAM
end
go

create view DEDS_Invalid.LearningDeliveryFAM
as
	select	lp.UKPRN,
			ldf.LearningDeliveryFAM_Id,
			ldf.LearningDelivery_Id,
			ldf.LearnRefNumber,
			ldf.AimSeqNumber,
			ldf.LearnDelFAMType,
			ldf.LearnDelFAMCode,
			ldf.LearnDelFAMDateFrom,
			ldf.LearnDelFAMDateTo
	from	Invalid.LearningDeliveryFAM as ldf
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id ('DEDS_Invalid.LearningDelivery','v') is not null
begin
	drop view DEDS_Invalid.LearningDelivery
end
go

create view DEDS_Invalid.LearningDelivery
as
	select	lp.UKPRN,
			ld.LearningDelivery_Id,
			ld.Learner_Id,
			ld.LearnRefNumber,
			ld.LearnAimRef,
			ld.AimType,
			ld.AimSeqNumber,
			ld.LearnStartDate,
			ld.OrigLearnStartDate,
			ld.LearnPlanEndDate,
			ld.FundModel,
			ld.PHours,
			ld.OTJActHours,
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
	from	Invalid.LearningDelivery as ld
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id('DEDS_Invalid.LearnerHEFinancialSupport','v') is not null
begin
	drop view DEDS_Invalid.LearnerHEFinancialSupport
end
go

create view DEDS_Invalid.LearnerHEFinancialSupport
as
	select	lp.UKPRN,
			lhfs.LearnerHEFinancialSupport_Id,
			lhfs.LearnerHE_Id,
			lhfs.LearnRefNumber,
			lhfs.FINTYPE,
			lhfs.FINAMOUNT
	from	Invalid.LearnerHEFinancialSupport as lhfs
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id ('DEDS_Invalid.LearnerHE','v') is not null
begin
	drop view DEDS_Invalid.LearnerHE
end
go

create view DEDS_Invalid.LearnerHE
as
	select	lp.UKPRN,
			lh.LearnerHE_Id,
			lh.Learner_Id,
			lh.LearnRefNumber,
			lh.UCASPERID,
			lh.TTACCOM
	from	Invalid.LearnerHE as lh
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id('DEDS_Invalid.EmploymentStatusMonitoring','v') is not null
begin
	drop view DEDS_Invalid.EmploymentStatusMonitoring
end
go

create view DEDS_Invalid.EmploymentStatusMonitoring 
as
	select	lp.UKPRN,
			esm.EmploymentStatusMonitoring_Id,
			esm.LearnerEmploymentStatus_Id,
			esm.LearnRefNumber,
			esm.DateEmpStatApp,
			esm.ESMType,
			esm.ESMCode
	from	Invalid.EmploymentStatusMonitoring as esm
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id ('DEDS_Invalid.LearnerEmploymentStatus','v') is not null
begin
	drop view DEDS_Invalid.LearnerEmploymentStatus
end
go

create view DEDS_Invalid.LearnerEmploymentStatus
as
	select	lp.UKPRN,
			les.LearnerEmploymentStatus_Id,
			les.Learner_Id,
			les.LearnRefNumber,
			les.EmpStat,
			les.DateEmpStatApp,
			les.EmpId
	from	Invalid.LearnerEmploymentStatus as les
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id('DEDS_Invalid.ProviderSpecLearnerMonitoring','v') is not null 
begin
	drop view DEDS_Invalid.ProviderSpecLearnerMonitoring
end
go

create view DEDS_Invalid.ProviderSpecLearnerMonitoring
as
	select	lp.UKPRN,
			pslm.ProviderSpecLearnerMonitoring_Id,
			pslm.Learner_Id,
			pslm.LearnRefNumber,
			pslm.ProvSpecLearnMonOccur,
			pslm.ProvSpecLearnMon
	from	Invalid.ProviderSpecLearnerMonitoring as pslm
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id ('DEDS_Invalid.LearnerFAM', 'v') is not null
begin
	drop view DEDS_Invalid.LearnerFAM
end
go

create view DEDS_Invalid.LearnerFAM
as
	select	lp.UKPRN,
			lf.LearnerFAM_Id,
			lf.Learner_Id,
			lf.LearnRefNumber,
			lf.LearnFAMType,
			lf.LearnFAMCode
	from	Invalid.LearnerFAM as lf
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id ('DEDS_Invalid.LLDDandHealthProblem','v') is not null 
begin
	drop view DEDS_Invalid.LLDDandHealthProblem
end
go

create view DEDS_Invalid.LLDDandHealthProblem
as 
	select	lp.UKPRN,
			lldd.LLDDandHealthProblem_Id,
			lldd.Learner_Id,
			lldd.LearnRefNumber,
			lldd.LLDDCat,
			lldd.PrimaryLLDD
	from	Invalid.LLDDandHealthProblem as lldd
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id('DEDS_Invalid.ContactPreference','v')is not null
begin
	drop view DEDS_Invalid.ContactPreference
end
go

create view DEDS_Invalid.ContactPreference 
as
	select	lp.UKPRN,
			cp.ContactPreference_Id,
			cp.Learner_Id,
			cp.LearnRefNumber,
			cp.ContPrefType,
			cp.ContPrefCode
	from	Invalid.ContactPreference as cp
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id('DEDS_Invalid.Learner', 'v') is not null
begin
	drop view DEDS_Invalid.Learner
end
go

create view DEDS_Invalid.Learner
as
	select	lp.UKPRN,
			l.Learner_Id,
			l.LearnRefNumber,
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
			l.Email
	from	Invalid.Learner as l
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id('DEDS_Invalid.SourceFile','v') is not null
begin
	drop view DEDS_Invalid.SourceFile
end
go

create view DEDS_Invalid.SourceFile
as
	select	lp.UKPRN,
			sf.SourceFile_Id,
			sf.SourceFileName
			from	Invalid.SourceFile as sf
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go

if object_id('DEDS_Invalid.Source','v') is not null
begin
	drop view DEDS_Invalid.[Source]
end
go

create view DEDS_Invalid.[Source]
as 
	select	Source_Id,
			ProtectiveMarking,
			UKPRN,
			SoftwareSupplier,
			SoftwarePackage,
			Release,
			SerialNo,
			[DateTime],
			ReferenceData,
			ComponentSetVersion
	from	Invalid.[Source]
go

if object_id('DEDS_Invalid.CollectionDetails','v') is not null
begin
	drop view DEDS_Invalid.CollectionDetails
end
go

create view DEDS_Invalid.CollectionDetails
as
	select	lp.UKPRN,
			cd.CollectionDetails_Id,
			cd.[Collection],
			cd.[Year],
			cd.FilePreparationDate
	from	Invalid.CollectionDetails as cd
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go
