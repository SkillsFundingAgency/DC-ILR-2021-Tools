if object_id ('dbo.TransformInputToInvalid_AppFinRecord','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_AppFinRecord')
end
go
 
create procedure dbo.TransformInputToInvalid_AppFinRecord as
begin
	insert into Invalid.AppFinRecord (
		AppFinRecord_Id,
		LearningDelivery_Id,
		LearnRefNumber,
		AimSeqNumber,
		AFinType,
		AFinCode,
		AFinDate,
		AFinAmount
	)
	select	AFR.AppFinRecord_Id,
			AFR.LearningDelivery_Id,
			AFR.LearnRefNumber,
			AFR.AimSeqNumber,
			AFR.AFinType,
			AFR.AFinCode,
			AFR.AFinDate,
			AFR.AFinAmount
	from	Input.AppFinRecord as AFR
				join Input.LearningDelivery as ld
					on ld.LearningDelivery_Id = afr.LearningDelivery_Id
				join Input.Learner as l
					on ld.Learner_Id = l.Learner_Id
				left join dbo.ValidLearners as vl
					on vl.Learner_Id = l.Learner_Id
	where	vl.Learner_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_CollectionDetails','p') is not null
	exec ('drop procedure dbo.TransformInputToInvalid_CollectionDetails')
go
 
create procedure dbo.TransformInputToInvalid_CollectionDetails as
begin
	insert into Invalid.CollectionDetails (
		CollectionDetails_Id,
		[Collection],
		[Year],
		FilePreparationDate
	)
	select	CollectionDetails_Id,
			[Collection],
			[Year],
			FilePreparationDate
	from	Input.CollectionDetails
end
go
 
if object_id ('dbo.TransformInputToInvalid_ContactPreference','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_ContactPreference')
end
go
 
create procedure dbo.TransformInputToInvalid_ContactPreference as
begin
	insert into Invalid.ContactPreference (
		ContactPreference_Id,
		Learner_Id,
		LearnRefNumber,
		ContPrefType,
		ContPrefCode
	)
	select	CP.ContactPreference_Id,
			CP.Learner_Id,
			CP.LearnRefNumber,
			CP.ContPrefType,
			CP.ContPrefCode
	from	Input.ContactPreference as CP
				left join dbo.ValidLearners as vl on vl.Learner_Id = CP.Learner_Id
	where	vl.Learner_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_DPOutcome','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_DPOutcome')
end
go
 
create procedure dbo.TransformInputToInvalid_DPOutcome as
begin
	insert into Invalid.DPOutcome (
		DPOutcome_Id,
		LearnerDestinationandProgression_Id,
		LearnRefNumber,
		OutType,
		OutCode,
		OutStartDate,
		OutEndDate,
		OutCollDate
	)
	select	DPO.DPOutcome_Id,
			DPO.LearnerDestinationandProgression_Id,
			DPO.LearnRefNumber,
			DPO.OutType,
			DPO.OutCode,
			DPO.OutStartDate,
			DPO.OutEndDate,
			DPO.OutCollDate
	from	Input.DPOutcome as DPO
				left join dbo.ValidLearnerDestinationandProgressions as vl
					on DPO.LearnerDestinationandProgression_Id = vl.LearnerDestinationandProgression_Id
	where	vl.LearnerDestinationandProgression_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_EmploymentStatusMonitoring','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_EmploymentStatusMonitoring')
end
go
 
create procedure dbo.TransformInputToInvalid_EmploymentStatusMonitoring as
begin
	insert into Invalid.EmploymentStatusMonitoring (
		EmploymentStatusMonitoring_Id,
		LearnerEmploymentStatus_Id,
		LearnRefNumber,
		DateEmpStatApp,
		ESMType,
		ESMCode
	)
	selecT	distinct
			ESM.EmploymentStatusMonitoring_Id,
			ESM.LearnerEmploymentStatus_Id,
			ESM.LearnRefNumber,
			ESM.DateEmpStatApp,
			ESM.ESMType,
			ESM.ESMCode
	from	Input.EmploymentStatusMonitoring as ESM
				inner join Input.LearnerEmploymentStatus as LES
					on ESM.LearnerEmploymentStatus_Id = LES.LearnerEmploymentStatus_Id
				left join dbo.ValidLearners as VL
					on vl.Learner_Id = LES.Learner_Id
	where	vl.Learner_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_Learner','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_Learner')
end
go
 
create procedure dbo.TransformInputToInvalid_Learner as
begin
	insert into Invalid.Learner (
		Learner_Id,
		LearnRefNumber,
		PrevLearnRefNumber,
		PrevUKPRN,
		PMUKPRN,
		CampId,
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
	select	L.Learner_Id,
			L.LearnRefNumber,
			L.PrevLearnRefNumber,
			L.PrevUKPRN,
			L.PMUKPRN,
			L.CampId,
			L.ULN,
			L.FamilyName,
			L.GivenNames,
			L.DateOfBirth,
			L.Ethnicity,
			L.Sex,
			L.LLDDHealthProb,
			L.NINumber,
			L.PriorAttain,
			L.Accom,
			L.ALSCost,
			L.PlanLearnHours,
			L.PlanEEPHours,
			L.MathGrade,
			L.EngGrade,
			L.PostcodePrior,
			L.Postcode,
			L.AddLine1,
			L.AddLine2,
			L.AddLine3,
			L.AddLine4,
			L.TelNo,
			L.Email
	from	Input.Learner as L
				left join dbo.ValidLearners as vl on vl.Learner_Id = L.Learner_Id
	where	vl.Learner_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_LearnerDestinationandProgression','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_LearnerDestinationandProgression')
end
go
 
create procedure dbo.TransformInputToInvalid_LearnerDestinationandProgression as
begin
	insert into Invalid.LearnerDestinationandProgression (
		LearnerDestinationandProgression_Id,
		LearnRefNumber,
		ULN
	)
	select	ldp.LearnerDestinationandProgression_Id,
			ldp.LearnRefNumber,
			ldp.ULN
	from	Input.LearnerDestinationandProgression as ldp
				left join dbo.ValidLearnerDestinationandProgressions as vldp
					on vldp.LearnerDestinationandProgression_Id = ldp.LearnerDestinationandProgression_Id
	where	vldp.LearnerDestinationandProgression_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_LearnerEmploymentStatus','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_LearnerEmploymentStatus')
end
go
 
create procedure dbo.TransformInputToInvalid_LearnerEmploymentStatus as
begin
	insert into Invalid.LearnerEmploymentStatus (
		LearnerEmploymentStatus_Id,
		Learner_Id,
		LearnRefNumber,
		EmpStat,
		DateEmpStatApp,
		EmpId
	)
	select	LES.LearnerEmploymentStatus_Id,
			LES.Learner_Id,
			LES.LearnRefNumber,
			LES.EmpStat,
			LES.DateEmpStatApp,
			LES.EmpId
	from	Input.LearnerEmploymentStatus as LES
				left join dbo.ValidLearners as vl on vl.Learner_Id = LES.Learner_Id
	where	vl.Learner_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_LearnerFAM','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_LearnerFAM')
end
go
 
create procedure dbo.TransformInputToInvalid_LearnerFAM as
begin
	insert into Invalid.LearnerFAM (
		LearnerFAM_Id,
		Learner_Id,
		LearnRefNumber,
		LearnFAMType,
		LearnFAMCode
	)
	select	LFAM.LearnerFAM_Id,
			LFAM.Learner_Id,
			LFAM.LearnRefNumber,
			LFAM.LearnFAMType,
			LFAM.LearnFAMCode
	from	Input.LearnerFAM as LFAM
				left join dbo.ValidLearners as vl on vl.Learner_Id = LFAM.Learner_Id
	where	vl.Learner_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_LearnerHE','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_LearnerHE')
end
go
 
create procedure dbo.TransformInputToInvalid_LearnerHE as
begin
	insert into Invalid.LearnerHE (
		LearnerHE_Id,
		Learner_Id,
		LearnRefNumber,
		UCASPERID,
		TTACCOM
	)
	select	LHE.LearnerHE_Id,
			LHE.Learner_Id,
			LHE.LearnRefNumber,
			LHE.UCASPERID,
			LHE.TTACCOM
	from	Input.LearnerHE as LHE
				left join dbo.ValidLearners as vl on vl.Learner_Id = LHE.Learner_Id
	where	vl.Learner_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_LearnerHEFinancialSupport','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_LearnerHEFinancialSupport')
end
go
 
create procedure dbo.TransformInputToInvalid_LearnerHEFinancialSupport as
begin
	insert into Invalid.LearnerHEFinancialSupport (
		LearnerHEFinancialSupport_Id,
		LearnerHE_Id,
		LearnRefNumber,
		FINTYPE,
		FINAMOUNT
	)
	select	LHEFS.LearnerHEFinancialSupport_Id,
			LHEFS.LearnerHE_Id,
			LHEFS.LearnRefNumber,
			LHEFS.FINTYPE,
			LHEFS.FINAMOUNT
	from	Input.LearnerHEFinancialSupport as LHEFS
				inner join Input.LearnerHE as LHE on LHEFS.LearnerHE_Id = LHE.LearnerHE_Id
				left join dbo.ValidLearners as vl on vl.Learner_Id = LHE.Learner_Id
	where	vl.Learner_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_LearningDelivery','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_LearningDelivery')
end
go
 
create procedure dbo.TransformInputToInvalid_LearningDelivery as
begin
	insert into Invalid.LearningDelivery (
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
		LSDPostcode,
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
	select	LD.LearningDelivery_Id,
			LD.Learner_Id,
			LD.LearnRefNumber,
			LD.LearnAimRef,
			LD.AimType,
			LD.AimSeqNumber,
			LD.LearnStartDate,
			LD.OrigLearnStartDate,
			LD.LearnPlanEndDate,
			LD.FundModel,
			LD.ProgType,
			LD.FworkCode,
			LD.PwayCode,
			LD.StdCode,
			LD.PartnerUKPRN,
			LD.DelLocPostCode,
			LD.LSDPostcode,
			LD.AddHours,
			LD.PriorLearnFundAdj,
			LD.OtherFundAdj,
			LD.ConRefNumber,
			LD.EPAOrgID,
			LD.EmpOutcome,
			LD.CompStatus,
			LD.LearnActEndDate,
			LD.WithdrawReason,
			LD.Outcome,
			LD.AchDate,
			LD.OutGrade,
			LD.SWSupAimId
	from	Input.LearningDelivery as LD
				left join dbo.ValidLearners as vl on vl.Learner_Id = LD.Learner_Id
	where	vl.Learner_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_LearningDeliveryFAM','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_LearningDeliveryFAM')
end
go
 
create procedure dbo.TransformInputToInvalid_LearningDeliveryFAM as
begin
	insert into Invalid.LearningDeliveryFAM (
		LearningDeliveryFAM_Id,
		LearningDelivery_Id,
		LearnRefNumber,
		AimSeqNumber,
		LearnDelFAMType,
		LearnDelFAMCode,
		LearnDelFAMDateFrom,
		LearnDelFAMDateTo
	)
	select	distinct
			LDFAM.LearningDeliveryFAM_Id,
			LDFAM.LearningDelivery_Id,
			LDFAM.LearnRefNumber,
			LDFAM.AimSeqNumber,
			LDFAM.LearnDelFAMType,
			LDFAM.LearnDelFAMCode,
			LDFAM.LearnDelFAMDateFrom,
			LDFAM.LearnDelFAMDateTo
	from	Input.LearningDeliveryFAM as LDFAM
				inner join Input.LearningDelivery as LD on LDFAM.LearningDelivery_Id = LD.LearningDelivery_Id
				left join dbo.ValidLearners as VL on VL.Learner_Id = LD.Learner_Id
	where	vl.Learner_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_LearningDeliveryHE','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_LearningDeliveryHE')
end
go
 
create procedure dbo.TransformInputToInvalid_LearningDeliveryHE as
begin
	insert into Invalid.LearningDeliveryHE (
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
	select	LDHE.LearningDeliveryHE_Id,
			LDHE.LearningDelivery_Id,
			LDHE.LearnRefNumber,
			LDHE.AimSeqNumber,
			LDHE.NUMHUS,
			LDHE.SSN,
			LDHE.QUALENT3,
			LDHE.SOC2000,
			LDHE.SEC,
			LDHE.UCASAPPID,
			LDHE.TYPEYR,
			LDHE.MODESTUD,
			LDHE.FUNDLEV,
			LDHE.FUNDCOMP,
			LDHE.STULOAD,
			LDHE.YEARSTU,
			LDHE.MSTUFEE,
			LDHE.PCOLAB,
			LDHE.PCFLDCS,
			LDHE.PCSLDCS,
			LDHE.PCTLDCS,
			LDHE.SPECFEE,
			LDHE.NETFEE,
			LDHE.GROSSFEE,
			LDHE.DOMICILE,
			LDHE.ELQ,
			LDHE.HEPostCode
	from	Input.LearningDeliveryHE as LDHE
				inner join Input.LearningDelivery as LD on LDHE.LearningDelivery_Id = LD.LearningDelivery_Id
				left join dbo.ValidLearners as vl on vl.Learner_Id = LD.Learner_Id
	where	vl.Learner_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_LearningDeliveryWorkPlacement','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_LearningDeliveryWorkPlacement')
end
go
 
create procedure dbo.TransformInputToInvalid_LearningDeliveryWorkPlacement as
begin
	insert into Invalid.LearningDeliveryWorkPlacement (
		LearningDeliveryWorkPlacement_Id,
		LearningDelivery_Id,
		LearnRefNumber,
		AimSeqNumber,
		WorkPlaceStartDate,
		WorkPlaceEndDate,
		WorkPlaceHours,
		WorkPlaceMode,
		WorkPlaceEmpId
	)
	select	LDWP.LearningDeliveryWorkPlacement_Id,
			LDWP.LearningDelivery_Id,
			LDWP.LearnRefNumber,
			LDWP.AimSeqNumber,
			LDWP.WorkPlaceStartDate,
			LDWP.WorkPlaceEndDate,
			LDWP.WorkPlaceHours,
			LDWP.WorkPlaceMode,
			LDWP.WorkPlaceEmpId
	from	Input.LearningDeliveryWorkPlacement as LDWP
				inner join Input.LearningDelivery as LD on LDWP.LearningDelivery_Id = LD.LearningDelivery_Id
				left join dbo.ValidLearners as VL on VL.Learner_Id = LD.Learner_Id
	where	vl.Learner_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_LearningProvider','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_LearningProvider')
end
go
 
create procedure dbo.TransformInputToInvalid_LearningProvider as
begin
	insert into Invalid.LearningProvider (
		LearningProvider_Id,
		UKPRN
	)
	select	LearningProvider_Id,
			UKPRN
	from	Input.LearningProvider
end
go
 
if object_id ('dbo.TransformInputToInvalid_LLDDandHealthProblem','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_LLDDandHealthProblem')
end
go
 
create procedure dbo.TransformInputToInvalid_LLDDandHealthProblem as
begin
	insert into Invalid.LLDDandHealthProblem (
		LLDDandHealthProblem_Id,
		Learner_Id,
		LearnRefNumber,
		LLDDCat,
		PrimaryLLDD
	)
	select	LLDDHP.LLDDandHealthProblem_Id,
			LLDDHP.Learner_Id,
			LLDDHP.LearnRefNumber,
			LLDDHP.LLDDCat,
			LLDDHP.PrimaryLLDD
	from	Input.LLDDandHealthProblem as LLDDHP
				left join dbo.ValidLearners as vl on vl.Learner_Id = LLDDHP.Learner_Id
	where	vl.Learner_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_ProviderSpecDeliveryMonitoring','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_ProviderSpecDeliveryMonitoring')
end
go
 
create procedure dbo.TransformInputToInvalid_ProviderSpecDeliveryMonitoring as
begin
	insert into Invalid.ProviderSpecDeliveryMonitoring (
		ProviderSpecDeliveryMonitoring_Id,
		LearningDelivery_Id,
		LearnRefNumber,
		AimSeqNumber,
		ProvSpecDelMonOccur,
		ProvSpecDelMon
	)
	select	distinct
			PSDM.ProviderSpecDeliveryMonitoring_Id,
			PSDM.LearningDelivery_Id,
			PSDM.LearnRefNumber,
			PSDM.AimSeqNumber,
			PSDM.ProvSpecDelMonOccur,
			PSDM.ProvSpecDelMon
	from	Input.ProviderSpecDeliveryMonitoring as PSDM
				inner join Input.LearningDelivery as LD on LD.LearningDelivery_Id = PSDM.LearningDelivery_Id
				left join dbo.ValidLearners as VL on VL.Learner_Id = LD.Learner_Id
	where	vl.Learner_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_ProviderSpecLearnerMonitoring','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_ProviderSpecLearnerMonitoring')
end
go
 
create procedure dbo.TransformInputToInvalid_ProviderSpecLearnerMonitoring as
begin
	insert into Invalid.ProviderSpecLearnerMonitoring (
		ProviderSpecLearnerMonitoring_Id,
		Learner_Id,
		LearnRefNumber,
		ProvSpecLearnMonOccur,
		ProvSpecLearnMon
	)
	select	PSLM.ProviderSpecLearnerMonitoring_Id,
			PSLM.Learner_Id,
			PSLM.LearnRefNumber,
			PSLM.ProvSpecLearnMonOccur,
			PSLM.ProvSpecLearnMon
	from	Input.ProviderSpecLearnerMonitoring as PSLM
				left join dbo.ValidLearners as vl on vl.Learner_Id = PSLM.Learner_Id
	where	vl.Learner_Id is null
end
go
 
if object_id ('dbo.TransformInputToInvalid_Source','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid_Source')
end
go
 
create procedure dbo.TransformInputToInvalid_Source as
begin
	insert into Invalid.[Source] (
		Source_Id,
		ProtectiveMarking,
		UKPRN,
		SoftwareSupplier,
		SoftwarePackage,
		Release,
		SerialNo,
		[DateTime],
		ReferenceData,
		ComponentSetVersion
	)
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
	from	Input.[Source]
end
go
 
if object_id ('dbo.TransformInputToInvalid_SourceFile','p') is not null
	exec ('drop procedure dbo.TransformInputToInvalid_SourceFile')
go
 
create procedure dbo.TransformInputToInvalid_SourceFile as
begin
	insert into Invalid.SourceFile (
		SourceFile_Id,
		SourceFileName,
		FilePreparationDate,
		SoftwareSupplier,
		SoftwarePackage,
		Release,
		SerialNo,
		[DateTime]
	)
	select	SourceFile_Id,
			SourceFileName,
			FilePreparationDate,
			SoftwareSupplier,
			SoftwarePackage,
			Release,
			SerialNo,
			[DateTime]
	from	Input.SourceFile
end
go
 
if object_id (N'dbo.TransformInputToInvalid', 'p') is not null
begin
	exec ('drop procedure dbo.TransformInputToInvalid')
end
go
 
create procedure dbo.TransformInputToInvalid as
begin
	exec dbo.TransformInputToInvalid_AppFinRecord
	exec dbo.TransformInputToInvalid_CollectionDetails
	exec dbo.TransformInputToInvalid_ContactPreference
	exec dbo.TransformInputToInvalid_DPOutcome
	exec dbo.TransformInputToInvalid_EmploymentStatusMonitoring
	exec dbo.TransformInputToInvalid_Learner
	exec dbo.TransformInputToInvalid_LearnerDestinationandProgression
	exec dbo.TransformInputToInvalid_LearnerEmploymentStatus
	exec dbo.TransformInputToInvalid_LearnerFAM
	exec dbo.TransformInputToInvalid_LearnerHE
	exec dbo.TransformInputToInvalid_LearnerHEFinancialSupport
	exec dbo.TransformInputToInvalid_LearningDelivery
	exec dbo.TransformInputToInvalid_LearningDeliveryFAM
	exec dbo.TransformInputToInvalid_LearningDeliveryHE
	exec dbo.TransformInputToInvalid_LearningDeliveryWorkPlacement
	exec dbo.TransformInputToInvalid_LearningProvider
	exec dbo.TransformInputToInvalid_LLDDandHealthProblem
	exec dbo.TransformInputToInvalid_ProviderSpecDeliveryMonitoring
	exec dbo.TransformInputToInvalid_ProviderSpecLearnerMonitoring
	exec dbo.TransformInputToInvalid_Source
	exec dbo.TransformInputToInvalid_SourceFile
end 
go
