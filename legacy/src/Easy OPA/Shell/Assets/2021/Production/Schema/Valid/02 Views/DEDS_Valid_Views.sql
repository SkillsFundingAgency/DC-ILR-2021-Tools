if not exists (select * from sys.schemas where name = 'DEDS_Valid')
begin
	exec ('create schema DEDS_Valid')
end
go

if object_id('DEDS_Valid.LearningProvider', 'v') is not null
begin
	drop view DEDS_Valid.LearningProvider
end
go

create view DEDS_Valid.LearningProvider
as 
	select	UKPRN
	from	Valid.LearningProvider
go

if object_id('DEDS_Valid.LearningDeliveryHE', 'v') is not null
begin
	drop view DEDS_Valid.LearningDeliveryHE
end
go

create view DEDS_Valid.LearningDeliveryHE
as
	select	lp.UKPRN,
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
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id('DEDS_Valid.LearnerDestinationandProgression','v') is not null
begin
	drop view DEDS_Valid.LearnerDestinationandProgression
end
go

create view DEDS_Valid.LearnerDestinationandProgression
as
	select	lp.UKPRN,
			ldp.LearnRefNumber,
			ldp.ULN
	from	Valid.LearnerDestinationandProgression as ldp
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id('DEDS_Valid.DPOutcome','v') is not null
begin
	drop view DEDS_Valid.DPOutcome
end
go

create view DEDS_Valid.DPOutcome
as
	select	lp.UKPRN,
			dp.LearnRefNumber,
			dp.OutType,
			dp.OutCode,
			dp.OutStartDate,
			dp.OutEndDate,
			dp.OutCollDate
	from	Valid.DPOutcome as dp
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id('DEDS_Valid.ProviderSpecDeliveryMonitoring','v') is not null
begin
	drop view DEDS_Valid.ProviderSpecDeliveryMonitoring
end
go

create view DEDS_Valid.ProviderSpecDeliveryMonitoring
as
	select	lp.UKPRN,
			pdm.LearnRefNumber,
			pdm.AimSeqNumber,
			pdm.ProvSpecDelMonOccur, 
			pdm.ProvSpecDelMon
	from	Valid.ProviderSpecDeliveryMonitoring as pdm
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id ('DEDS_Valid.AppFinRecord', 'v') is not null
begin
	drop view DEDS_Valid.AppFinRecord
end
go

create view DEDS_Valid.AppFinRecord
as
	select	lp.UKPRN,
			afr.LearnRefNumber,
			afr.AimSeqNumber,
			afr.AFinType, 
			afr.AFinCode,
			afr.AFinDate,
			afr.AFinAmount
	from	Valid.AppFinRecord as afr
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id ('DEDS_Valid.LearningDeliveryWorkPlacement', 'v') is not null
begin
	drop view DEDS_Valid.LearningDeliveryWorkPlacement
end
go

create view DEDS_Valid.LearningDeliveryWorkPlacement
as
	select	lp.UKPRN,
			ldwp.LearnRefNumber,
			ldwp.AimSeqNumber,
			ldwp.WorkPlaceStartDate,
			ldwp.WorkPlaceEndDate,
			ldwp.WorkPlaceHours,
			ldwp.WorkPlaceMode,
			ldwp.WorkPlaceEmpId
	from	Valid.LearningDeliveryWorkPlacement as ldwp
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id ('DEDS_Valid.LearningDeliveryFAM', 'v') is not null
begin
	drop view DEDS_Valid.LearningDeliveryFAM
end
go

create view DEDS_Valid.LearningDeliveryFAM
as
	select	lp.UKPRN,
			ldf.LearnRefNumber,
			ldf.AimSeqNumber,
			ldf.LearnDelFAMType,
			ldf.LearnDelFAMCode,
			ldf.LearnDelFAMDateFrom,
			ldf.LearnDelFAMDateTo
	from	Valid.LearningDeliveryFAM as ldf
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id('DEDS_Valid.LearningDelivery','v') is not null
begin
	drop view DEDS_Valid.LearningDelivery
end
go

create view DEDS_Valid.LearningDelivery
as
	select	lp.UKPRN,
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
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id ('DEDS_Valid.LearnerHEFinancialSupport', 'v') is not null
begin
	drop view DEDS_Valid.LearnerHEFinancialSupport
end
go

create view DEDS_Valid.LearnerHEFinancialSupport
as
	select	lp.UKPRN,
			lhfs.LearnRefNumber,
			lhfs.FINTYPE,
			lhfs.FINAMOUNT
	from	Valid.LearnerHEFinancialSupport as lhfs
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id('DEDS_Valid.LearnerHE','v') is not null
begin
	drop view DEDS_Valid.LearnerHE
end
go

create view DEDS_Valid.LearnerHE
as
	select	lp.UKPRN,
			lh.LearnRefNumber,
			lh.UCASPERID,
			lh.TTACCOM
	from	Valid.LearnerHE as lh
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id('DEDS_Valid.EmploymentStatusMonitoring','v') is not null
begin
	drop view DEDS_Valid.EmploymentStatusMonitoring
end
go

create view DEDS_Valid.EmploymentStatusMonitoring 
as
	select	lp.UKPRN,
			esm.LearnRefNumber, 
			esm.DateEmpStatApp, 
			esm.ESMType, 
			esm.ESMCode
	from	Valid.EmploymentStatusMonitoring as esm
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id ('DEDS_Valid.LearnerEmploymentStatus','v') is not null
begin
	drop view DEDS_Valid.LearnerEmploymentStatus
end
go

create view DEDS_Valid.LearnerEmploymentStatus
as
	select	lp.UKPRN,
			les.LearnRefNumber, 
			les.EmpStat, 
			les.DateEmpStatApp, 
			les.EmpId
	from	Valid.LearnerEmploymentStatus as les
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id ('DEDS_Valid.ProviderSpecLearnerMonitoring','v') is not null
begin
	drop view DEDS_Valid.ProviderSpecLearnerMonitoring
end
go

create view DEDS_Valid.ProviderSpecLearnerMonitoring
as
	select	lp.UKPRN,
			pslm.LearnRefNumber,
			pslm.ProvSpecLearnMonOccur,
			pslm.ProvSpecLearnMon
	from	Valid.ProviderSpecLearnerMonitoring as pslm
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id('DEDS_Valid.LearnerFAM','v') is not null
begin
	drop view DEDS_Valid.LearnerFAM
end
go

create view DEDS_Valid.LearnerFAM
as
	select	lp.UKPRN,
			lf.LearnRefNumber,
			lf.LearnFAMType,
			lf.LearnFAMCode
	from	Valid.LearnerFAM as lf
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id('DEDS_Valid.LLDDandHealthProblem','v') is not null
begin
	drop view DEDS_Valid.LLDDandHealthProblem
end
go

create view DEDS_Valid.LLDDandHealthProblem
as 
	select	lp.UKPRN,
			lldd.LearnRefNumber,
			lldd.LLDDCat,
			lldd.PrimaryLLDD
	from	Valid.LLDDandHealthProblem as lldd
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id('DEDS_Valid.ContactPreference','v') is not null
begin
	drop view DEDS_Valid.ContactPreference
end
go

create view DEDS_Valid.ContactPreference 
as
	select	lp.UKPRN,
			cp.LearnRefNumber,
			cp.ContPrefType,
			cp.ContPrefCode
	from	Valid.ContactPreference as cp
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id ('DEDS_Valid.Learner','v') is not null
begin
	drop view DEDS_Valid.Learner
end
go

create view DEDS_Valid.Learner
as
	select	lp.UKPRN,
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
	from	Valid.Learner as l
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id ('DEDS_Valid.SourceFile','v') is not null
begin
	drop view DEDS_Valid.SourceFile
end
go

create view DEDS_Valid.SourceFile
as
	select	lp.UKPRN,
			sf.SourceFileName
			from	Valid.SourceFile as sf
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go

if object_id('DEDS_Valid.Source','v') is not null
begin
	drop view DEDS_Valid.[Source]
end
go

create view DEDS_Valid.[Source]
as 
	select	ProtectiveMarking,
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

if object_id ('DEDS_Valid.CollectionDetails','v') is not null
begin
	drop view DEDS_Valid.CollectionDetails
end
go

create view DEDS_Valid.CollectionDetails
as
	select	lp.UKPRN,
			cd.[Collection], 
			cd.[Year], 
			cd.FilePreparationDate
	from	Valid.CollectionDetails as cd
				cross join (select top 1 UKPRN from Valid.LearningProvider) as lp
go
