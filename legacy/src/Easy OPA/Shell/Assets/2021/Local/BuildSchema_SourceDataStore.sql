create schema [Clone]
go

create view Clone.AppFinRecord
as
	select	afr.PK_AppFinRecord,
			afr.FK_LearningDelivery,
			lp.UKPRN,
			l.LearnRefNumber,
			ld.AimSeqNumber,
			afr.AFinType,
			afr.AFinCode,
			afr.AFinDate,
			afr.AFinAmount
	from	dbo.AppFinRecord as afr
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
				join dbo.LearningDelivery as ld on ld.PK_LearningDelivery = afr.FK_LearningDelivery
				join dbo.Learner as l on l.PK_Learner = ld.FK_Learner
go

create view Clone.CollectionDetails
as
	select	PK_CollectionDetails,
			lp.UKPRN,
			[Year],
			FilePreparationDate,
			[Collection]
	from	dbo.CollectionDetails
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
go

create view Clone.ContactPreference
as
	select	cp.PK_ContactPreference,
			cp.FK_Learner,
			lp.UKPRN,
			l.LearnRefNumber,
			cp.ContPrefType,
			cp.ContPrefCode
	from	dbo.ContactPreference as cp
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
				join dbo.Learner as l on l.PK_Learner = cp.FK_Learner
go

create view Clone.DPOutcome
as
	select	dp.PK_DPOutcome,
			dp.FK_LearnerDestinationandProgression,
			lp.UKPRN,
			ldp.LearnRefNumber,
			dp.OutType,
			dp.OutCode,
			dp.OutStartDate,
			dp.OutEndDate,
			dp.OutCollDate
	from	dbo.DPOutcome as dp
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
				join dbo.LearnerDestinationandProgression as ldp on ldp.PK_LearnerDestinationandProgression = dp.FK_LearnerDestinationandProgression
go

create view Clone.EmploymentStatusMonitoring
as
	select	esm.PK_EmploymentStatusMonitoring,
			esm.FK_LearnerEmploymentStatus,
			lp.UKPRN,
			l.LearnRefNumber,
			les.DateEmpStatApp,
			esm.ESMType,
			esm.ESMCode
	from	dbo.EmploymentStatusMonitoring as esm
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
				join dbo.LearnerEmploymentStatus as les on les.PK_LearnerEmploymentStatus = esm.FK_LearnerEmploymentStatus
				join dbo.Learner as l on l.PK_Learner = les.FK_Learner
go

create view Clone.Learner
as
	select	PK_Learner,
			LearnRefNumber,
			PrevLearnRefNumber,
			lp.UKPRN,
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
	from	dbo.Learner
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
go

create view Clone.LearnerDestinationandProgression
as
	select	PK_LearnerDestinationandProgression,
			lp.UKPRN,
			LearnRefNumber,
			ULN
	from	dbo.LearnerDestinationandProgression
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
go

create view Clone.LearnerEmploymentStatus
as
	select	les.PK_LearnerEmploymentStatus,
			les.FK_Learner,
			lp.UKPRN,
			l.LearnRefNumber,
			les.EmpStat,
			les.DateEmpStatApp,
			les.EmpId
	from	dbo.LearnerEmploymentStatus as les
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
				join dbo.Learner as l on l.PK_Learner = les.FK_Learner
go

create view Clone.LearnerFAM
as
	select	lf.PK_LearnerFAM,
			lf.FK_Learner,
			lp.UKPRN,
			l.LearnRefNumber,
			lf.LearnFAMType,
			lf.LearnFAMCode
	from	dbo.LearnerFAM as lf
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
				join dbo.Learner as l on l.PK_Learner = lf.FK_Learner
go

create view Clone.LearnerHE
as
	select	lh.PK_LearnerHE,
			lh.FK_Learner,
			lp.UKPRN,
			l.LearnRefNumber,
			lh.UCASPERID,
			lh.TTACCOM
	from	dbo.LearnerHE as lh
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
				join dbo.Learner as l on l.PK_Learner = lh.FK_Learner
go

create view Clone.LearnerHEFinancialSupport
as
	select	lhfs.PK_LearnerHEFinancialSupport,
			lhfs.FK_LearnerHE,
			lp.UKPRN,
			l.LearnRefNumber,
			lhfs.FINTYPE,
			lhfs.FINAMOUNT
	from	dbo.LearnerHEFinancialSupport as lhfs
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
				join dbo.LearnerHE as lh on lh.PK_LearnerHE = lhfs.FK_LearnerHE
				join dbo.Learner as l on l.PK_Learner = lh.FK_Learner
go

create view Clone.LearningDelivery
as
	select	ld.PK_LearningDelivery,
			ld.FK_Learner,
			lp.UKPRN,
			l.LearnRefNumber,
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
	from	dbo.LearningDelivery as ld
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
				join dbo.Learner as l on l.PK_Learner = ld.FK_Learner
go

create view Clone.LearningDeliveryFAM
as
	select	ldf.PK_LearningDeliveryFAM,
			ldf.FK_LearningDelivery,
			lp.UKPRN,
			l.LearnRefNumber,
			ld.AimSeqNumber,
			ldf.LearnDelFAMType,
			ldf.LearnDelFAMCode,
			ldf.LearnDelFAMDateFrom,
			ldf.LearnDelFAMDateTo
	from	dbo.LearningDeliveryFAM as ldf
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
				join dbo.LearningDelivery as ld on ld.PK_LearningDelivery = ldf.FK_LearningDelivery
				join dbo.Learner as l on l.PK_Learner = ld.FK_Learner
go

create view Clone.LearningDeliveryHE
as
	select	ldh.PK_LearningDeliveryHE,
			ldh.FK_LearningDelivery,
			lp.UKPRN,
			l.LearnRefNumber,
			ld.AimSeqNumber,
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
	from	dbo.LearningDeliveryHE as ldh
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
				join dbo.LearningDelivery as ld on ld.PK_LearningDelivery = ldh.FK_LearningDelivery
				join dbo.Learner as l on l.PK_Learner = ld.FK_learner
go

create view Clone.LearningDeliveryWorkPlacement
as
	select	ldwp.PK_LearningDeliveryWorkPlacement,
			ldwp.FK_LearningDelivery,
			lp.UKPRN,
			l.LearnRefNumber,
			ld.AimSeqNumber,
			ldwp.WorkPlaceStartDate,
			ldwp.WorkPlaceEndDate,
			ldwp.WorkPlaceHours,
			ldwp.WorkPlaceMode,
			ldwp.WorkPlaceEmpId
	from	dbo.LearningDeliveryWorkPlacement as ldwp
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
				join dbo.LearningDelivery as ld on ld.PK_LearningDelivery = ldwp.FK_LearningDelivery
				join dbo.Learner as l on l.PK_Learner = ld.FK_Learner
go

create view Clone.LearningProvider
as
	select	PK_LearningProvider,
			UKPRN
	from	dbo.LearningProvider
go

create view Clone.LLDDandHealthProblem
as
	select	lhp.PK_LLDDandHealthProblem,
			lhp.FK_Learner,
			lp.UKPRN,
			l.LearnRefNumber,
			lhp.LLDDCat,
			lhp.PrimaryLLDD
	from	dbo.LLDDandHealthProblem as lhp
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
				join dbo.Learner as l on PK_Learner = lhp.FK_Learner
go

create view Clone.ProviderSpecDeliveryMonitoring
as
	select	psdm.PK_ProviderSpecDeliveryMonitoring,
			psdm.FK_LearningDelivery,
			lp.UKPRN,
			l.LearnRefNumber,
			ld.AimseqNumber,
			psdm.ProvSpecDelMonOccur,
			psdm.ProvSpecDelMon
	from	dbo.ProviderSpecDeliveryMonitoring as psdm
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
				join dbo.LearningDelivery as ld on ld.PK_LearningDelivery = psdm.FK_LearningDelivery
				join dbo.Learner as l on l.PK_Learner = ld.FK_Learner
go

create view Clone.ProviderSpecLearnerMonitoring
as
	select	pslm.PK_ProviderSpecLearnerMonitoring,
			pslm.FK_Learner,
			lp.UKPRN,
			l.LearnRefNumber,
			pslm.ProvSpecLearnMonOccur,
			pslm.ProvSpecLearnMon
	from	dbo.ProviderSpecLearnerMonitoring as pslm
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
				join dbo.Learner as l on l.PK_Learner = pslm.FK_Learner
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
	from	dbo.[Source]
go

create view Clone.SourceFile
as
	select	PK_SourceFile,
			lp.UKPRN,
			SourceFileName,
			FilePreparationDate,
			SoftwareSupplier,
			SoftwarePackage,
			Release,
			[DateTime],
			SerialNo
	from	dbo.SourceFile
 				cross join (select top 1 UKPRN from dbo.LearningProvider) as lp
go
