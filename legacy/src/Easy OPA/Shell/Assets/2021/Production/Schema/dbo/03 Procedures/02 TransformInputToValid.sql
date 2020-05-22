if object_id ('dbo.TransformInputToValid_AppFinRecord','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_AppFinRecord')
end
go
 
create procedure dbo.TransformInputToValid_AppFinRecord as
begin
	insert into Valid.AppFinRecord (
		UKPRN,
		LearnRefNumber,
		AimSeqNumber,
		AFinType,
		AFinCode,
		AFinDate,
		AFinAmount
	)
	select 	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
			Learner.LearnRefNumber,
			LearningDelivery.AimSeqNumber,
			AFR.AFinType,
			AFR.AFinCode,
			AFR.AFinDate,
			AFR.AFinAmount
	from	dbo.AppFinRecord as AFR
				inner join dbo.LearningDelivery
					on LearningDelivery.PK_LearningDelivery = AFR.FK_LearningDelivery
				inner join dbo.Learner
					on Learner.PK_Learner = LearningDelivery.FK_Learner
				--inner join dbo.ValidLearners
				--	on Learner.PK_Learner = ValidLearners.Learner_Id
	end
go
 
if object_id ('dbo.TransformInputToValid_CollectionDetails','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_CollectionDetails')
end
go
 
create procedure dbo.TransformInputToValid_CollectionDetails as
begin
	insert into Valid.CollectionDetails (
		UKPRN,
		[Collection],
		[Year],
		FilePreparationDate
	)
	select 	
		(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
	[Collection],
			[Year],
			FilePreparationDate
	from	dbo.CollectionDetails
end
go
 
if object_id ('dbo.TransformInputToValid_ContactPreference','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_ContactPreference')
end
go
 
create procedure dbo.TransformInputToValid_ContactPreference as
begin
	insert into Valid.ContactPreference (
	UKPRN,
		LearnRefNumber,
		ContPrefType,
		ContPrefCode
	)
	select 	
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
	Learner.LearnRefNumber,
			CP.ContPrefType,
			CP.ContPrefCode
	from	dbo.ContactPreference as CP
				--join dbo.ValidLearners as vl on vl.Learner_Id = CP.FK_Learner
				inner join dbo.Learner
					on Learner.PK_Learner = CP.FK_Learner

end
go
 
if object_id ('dbo.TransformInputToValid_DPOutcome','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_DPOutcome')
end
go
 
create procedure dbo.TransformInputToValid_DPOutcome as
begin
	insert into Valid.DPOutcome (
	UKPRN,
		LearnRefNumber,
		OutType,
		OutCode,
		OutStartDate,
		OutEndDate,
		OutCollDate
	)
	select 	
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
	dp.LearnRefNumber,
			DPO.OutType,
			DPO.OutCode,
			DPO.OutStartDate,
			DPO.OutEndDate,
			DPO.OutCollDate
	from	dbo.DPOutcome as DPO
				inner join dbo.LearnerDestinationandProgression as dp
					on dp.PK_LearnerDestinationandProgression = dpo.FK_LearnerDestinationandProgression
				--inner join dbo.ValidLearnerDestinationandProgressions as vdp
				--	on dpo.FK_LearnerDestinationandProgression = vdp.LearnerDestinationandProgression_Id

end
go
 
if object_id ('dbo.TransformInputToValid_EmploymentStatusMonitoring','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_EmploymentStatusMonitoring')
end
go
 
create procedure dbo.TransformInputToValid_EmploymentStatusMonitoring as
begin
	insert into Valid.EmploymentStatusMonitoring (
	UKPRN,
		LearnRefNumber,
		DateEmpStatApp,
		ESMType,
		ESMCode
	)
	select 	distinct
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
			Learner.LearnRefNumber,
			LES.DateEmpStatApp,
			ESM.ESMType,
			ESM.ESMCode
	from	dbo.EmploymentStatusMonitoring as ESM
				inner join dbo.LearnerEmploymentStatus LES
					on ESM.FK_LearnerEmploymentStatus = LES.PK_LearnerEmploymentStatus
				--inner join dbo.Learner as VL
				--	on VL.PK_Learner = LES.FK_Learner
				inner join dbo.Learner
					on Learner.PK_Learner = LES.FK_Learner
end
go
 
if object_id ('dbo.TransformInputToValid_Learner','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_Learner')
end
go
 
create procedure dbo.TransformInputToValid_Learner as
begin
	insert into Valid.Learner (
	UKPRN,
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
	select 	
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
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
	from	dbo.Learner as L
				--join dbo.ValidLearners as vl on vl.Learner_Id = L.PK_Learner
end
go
 
if object_id ('dbo.TransformInputToValid_LearnerDestinationandProgression','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_LearnerDestinationandProgression')
end
go
 
create procedure dbo.TransformInputToValid_LearnerDestinationandProgression as
begin
	insert into Valid.LearnerDestinationandProgression (
	UKPRN,
		LearnRefNumber,
		ULN
	)
	select 	distinct
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
			LDP.LearnRefNumber,
			LDP.ULN
	from	dbo.LearnerDestinationandProgression as LDP
				--join dbo.ValidLearnerDestinationandProgressions as vdp
				--	on LDP.PK_LearnerDestinationandProgression = vdp.LearnerDestinationandProgression_Id
end
go
 
if object_id ('dbo.TransformInputToValid_LearnerEmploymentStatus','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_LearnerEmploymentStatus')
end
go
 
create procedure dbo.TransformInputToValid_LearnerEmploymentStatus as
begin
	insert into Valid.LearnerEmploymentStatus (
	UKPRN,
		LearnRefNumber,
		EmpStat,
		DateEmpStatApp,
		EmpId
	)
	select 	distinct
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
			Learner.LearnRefNumber,
			LES.EmpStat,
			LES.DateEmpStatApp,
			LES.EmpId
	from	dbo.LearnerEmploymentStatus as LES
				--join dbo.ValidLearners as vl on vl.Learner_Id = LES.FK_Learner
				inner join dbo.Learner
					on Learner.PK_Learner = LES.FK_Learner

end
go
 
if object_id ('dbo.TransformInputToValid_LearnerFAM','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_LearnerFAM')
end
go
 
create procedure dbo.TransformInputToValid_LearnerFAM as
begin
	insert into Valid.LearnerFAM (
	UKPRN,
		LearnRefNumber,
		LearnFAMType,
		LearnFAMCode
	)
	select 	
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
	CAST(Learner.LearnRefNumber as varchar(12)),
			LFAM.LearnFAMType,
			LFAM.LearnFAMCode
	from	dbo.LearnerFAM as LFAM
				--join dbo.ValidLearners as vl on vl.Learner_Id = LFAM.FK_Learner
				inner join dbo.Learner
					on Learner.PK_Learner = LFAM.FK_Learner
end
go
 
if object_id ('dbo.TransformInputToValid_LearnerHE','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_LearnerHE')
end
go
 
create procedure dbo.TransformInputToValid_LearnerHE as
begin
	insert into Valid.LearnerHE (
	UKPRN,
		LearnRefNumber,
		UCASPERID,
		TTACCOM
	)
	select 	
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
	l.LearnRefNumber,
			lhe.UCASPERID,
			lhe.TTACCOM
	from	dbo.LearnerHE as lhe
				inner join dbo.Learner as l on lhe.FK_Learner = l.PK_Learner
				--inner join dbo.ValidLearners as vl on lhe.FK_Learner = vl.Learner_Id
end
go
 
if object_id ('dbo.TransformInputToValid_LearnerHEFinancialSupport','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_LearnerHEFinancialSupport')
end
go
 
create procedure dbo.TransformInputToValid_LearnerHEFinancialSupport as
begin
	insert into Valid.LearnerHEFinancialSupport (
	UKPRN,
		LearnRefNumber,
		FINTYPE,
		FINAMOUNT
	)
	select 	
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
	Learner.LearnRefNumber,
			LearnerHEFinancialSupport.FINTYPE,
			LearnerHEFinancialSupport.FINAMOUNT
	from	dbo.LearnerHEFinancialSupport
				inner join dbo.LearnerHE
					on LearnerHEFinancialSupport.FK_LearnerHE = LearnerHE.PK_LearnerHE
				inner join dbo.Learner
					on Learner.PK_Learner = LearnerHE.FK_Learner
				--inner join dbo.ValidLearners
				--	on LearnerHE.FK_Learner = ValidLearners.Learner_Id
end
go
 
if object_id ('dbo.TransformInputToValid_LearningDelivery','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_LearningDelivery')
end
go
 
create procedure dbo.TransformInputToValid_LearningDelivery as
begin
	insert into Valid.LearningDelivery (
	UKPRN,
		LearnRefNumber,
		LearnAimRef,
		AimType,
		AimSeqNumber,
		LearnStartDate,
		OrigLearnStartDate,
		LearnPlanEndDate,
		FundModel,
		PHours,
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
	select 	distinct
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
			Learner.LearnRefNumber,
			LD.LearnAimRef,
			LD.AimType,
			LD.AimSeqNumber,
			LD.LearnStartDate,
			LD.OrigLearnStartDate,
			LD.LearnPlanEndDate,
			LD.FundModel,
			LD.PHours,
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
	from	dbo.LearningDelivery as LD
				--join dbo.ValidLearners as vl on vl.Learner_Id = LD.FK_Learner
				inner join dbo.Learner
					on Learner.PK_Learner = LD.FK_Learner
end
go
 
if object_id ('dbo.TransformInputToValid_LearningDeliveryFAM','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_LearningDeliveryFAM')
end
go
 
create procedure dbo.TransformInputToValid_LearningDeliveryFAM as
begin
	insert into Valid.LearningDeliveryFAM (
	UKPRN,
		LearnRefNumber,
		AimSeqNumber,
		LearnDelFAMType,
		LearnDelFAMCode,
		LearnDelFAMDateFrom,
		LearnDelFAMDateTo
	)
	select 	
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
	Learner.LearnRefNumber,
			LearningDelivery.AimSeqNumber,
			LearningDeliveryFAM.LearnDelFAMType,
			LearningDeliveryFAM.LearnDelFAMCode,
			LearningDeliveryFAM.LearnDelFAMDateFrom,
			LearningDeliveryFAM.LearnDelFAMDateTo
	from	dbo.LearningDeliveryFAM
				inner join dbo.LearningDelivery
					on LearningDeliveryFAM.FK_LearningDelivery= LearningDelivery.PK_LearningDelivery
				inner join dbo.Learner
					on LearningDelivery.FK_Learner = Learner.PK_Learner
				--inner join dbo.ValidLearners
				--	on Learner.PK_Learner = ValidLearners.Learner_Id
end
go
 
if object_id ('dbo.TransformInputToValid_LearningDeliveryHE','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_LearningDeliveryHE')
end
go
 
create procedure dbo.TransformInputToValid_LearningDeliveryHE as
begin
	insert into Valid.LearningDeliveryHE (
	UKPRN,
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
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
	Learner.LearnRefNumber,
			LD.AimSeqNumber,
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
	from	dbo.LearningDeliveryHE as LDHE
				inner join dbo.LearningDelivery as LD
					on LDHE.FK_LearningDelivery = LD.PK_LearningDelivery
				inner join dbo.Learner
					on LD.FK_Learner = Learner.PK_Learner
				--inner join dbo.ValidLearners as VL
				--	on VL.Learner_Id = LD.FK_Learner
end
go
 
if object_id ('dbo.TransformInputToValid_LearningDeliveryWorkPlacement','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_LearningDeliveryWorkPlacement')
end
go
 
create procedure dbo.TransformInputToValid_LearningDeliveryWorkPlacement as
begin
	insert into Valid.LearningDeliveryWorkPlacement (
	UKPRN,
		LearnRefNumber,
		AimSeqNumber,
		WorkPlaceStartDate,
		WorkPlaceEndDate,
		WorkPlaceHours,
		WorkPlaceMode,
		WorkPlaceEmpId
	)
	select 	
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
	Learner.LearnRefNumber,
			LD.AimSeqNumber,
			LDWP.WorkPlaceStartDate,
			LDWP.WorkPlaceEndDate,
			LDWP.WorkPlaceHours,
			LDWP.WorkPlaceMode,
			LDWP.WorkPlaceEmpId
	from	dbo.LearningDeliveryWorkPlacement as LDWP
				inner join dbo.LearningDelivery as LD
					on LDWP.FK_LearningDelivery = LD.PK_LearningDelivery
				inner join dbo.Learner
					on LD.FK_Learner = Learner.PK_Learner
				--inner join dbo.ValidLearners as VL
				--	on VL.Learner_Id = LD.FK_Learner
	where LDWP.WorkPlaceEmpId is not null
end
go
 
if object_id ('dbo.TransformInputToValid_LearningProvider','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_LearningProvider')
end
go
 
create procedure dbo.TransformInputToValid_LearningProvider as
begin
	insert into Valid.LearningProvider (
		UKPRN
	)
	select 	UKPRN
	from	dbo.LearningProvider
end
go
 
if object_id ('dbo.TransformInputToValid_LLDDandHealthProblem','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_LLDDandHealthProblem')
end
go
 
create procedure dbo.TransformInputToValid_LLDDandHealthProblem as
begin
	insert into Valid.LLDDandHealthProblem (
	UKPRN,
		LearnRefNumber,
		LLDDCat,
		PrimaryLLDD
	)
	select 	
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
	Learner.LearnRefNumber,
			LLDDandHealthProblem.LLDDCat,
			LLDDandHealthProblem.PrimaryLLDD
	from	dbo.LLDDandHealthProblem
				inner join dbo.Learner
					on LLDDandHealthProblem.FK_Learner = Learner.PK_Learner
				--inner join dbo.ValidLearners
				--	on LLDDandHealthProblem.FK_Learner = ValidLearners.Learner_Id	
end
go
 
if object_id ('dbo.TransformInputToValid_ProviderSpecDeliveryMonitoring','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_ProviderSpecDeliveryMonitoring')
end
go
 
create procedure dbo.TransformInputToValid_ProviderSpecDeliveryMonitoring as
begin
	insert into Valid.ProviderSpecDeliveryMonitoring (
	UKPRN,
		LearnRefNumber,
		AimSeqNumber,
		ProvSpecDelMonOccur,
		ProvSpecDelMon
	)
	select 	distinct
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
			Learner.LearnRefNumber,
			LD.AimSeqNumber,
			PSDM.ProvSpecDelMonOccur,
			PSDM.ProvSpecDelMon
	from	dbo.ProviderSpecDeliveryMonitoring as PSDM
				inner join dbo.LearningDelivery as LD
					on PSDM.FK_LearningDelivery = LD.PK_LearningDelivery
				--inner join dbo.ValidLearners as VL
				--	on VL.Learner_Id = LD.FK_Learner
				inner join dbo.Learner
					on LD.FK_Learner = Learner.PK_Learner
end
go
 
if object_id ('dbo.TransformInputToValid_ProviderSpecLearnerMonitoring','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_ProviderSpecLearnerMonitoring')
end
go
 
create procedure dbo.TransformInputToValid_ProviderSpecLearnerMonitoring as
begin
	insert into Valid.ProviderSpecLearnerMonitoring (
	UKPRN,
		LearnRefNumber,
		ProvSpecLearnMonOccur,
		ProvSpecLearnMon
	)
	select 	distinct
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
			Learner.LearnRefNumber,
			PSLM.ProvSpecLearnMonOccur,
			PSLM.ProvSpecLearnMon
	from	dbo.ProviderSpecLearnerMonitoring as PSLM
				--join dbo.ValidLearners as vl on vl.Learner_Id = PSLM.FK_Learner
				inner join dbo.Learner
					on PSLM.FK_Learner = Learner.PK_Learner
end
go
 
if object_id ('dbo.TransformInputToValid_Source','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_Source')
end
go
 
create procedure dbo.TransformInputToValid_Source as
begin
	insert into Valid.[Source] (
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
	select 	ProtectiveMarking,
			UKPRN,
			SoftwareSupplier,
			SoftwarePackage,
			Release,
			SerialNo,
			[DateTime],
			ReferenceData,
			ComponentSetVersion
	from	dbo.[Source]
end
go
 
if object_id ('dbo.TransformInputToValid_SourceFile','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_SourceFile')
end
go
 
create procedure dbo.TransformInputToValid_SourceFile as
begin
	insert into Valid.SourceFile (
		[UKPRN],
	SourceFileName,
	FilePreparationDate,
	SoftwareSupplier,
	SoftwarePackage,
	Release,
	SerialNo,
	[DateTime]	
		)
	select 
	(SELECT TOP(1) UKPRN FROM dbo.LearningProvider) AS UKPRN,
	SourceFileName,
	FilePreparationDate,
	SoftwareSupplier,
	SoftwarePackage,
	Release,
	SerialNo,
	[DateTime]
				from	dbo.SourceFile
end
go

-- Materialisation of the Valid.LearningDeliveryDenorm view to a table added as an optimisation on the Insert Cases scripts
if object_id ('dbo.TransformInputToValid_LearningDeliveryDenormTbl','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_LearningDeliveryDenormTbl')
end
go
 
create procedure dbo.TransformInputToValid_LearningDeliveryDenormTbl as
begin
	insert Valid.LearningDeliveryDenormTbl (
	UKPRN,
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
		SWSupAimId,
		HEM1,
		HEM2,
		HEM3,
		HHS1,
		HHS2,
		LDFAM_SOF,
		LDFAM_EEF,
		LDFAM_RES,
		LDFAM_ADL,
		LDFAM_FFI,
		LDFAM_WPP,
		LDFAM_POD,
		LDFAM_ASL,
		LDFAM_FLN,
		LDFAM_NSA,
		ProvSpecDelMon_A,
		ProvSpecDelMon_B,
		ProvSpecDelMon_C,
		ProvSpecDelMon_D,
		LDM1,
		LDM2,
		LDM3,
		LDM4
	)
	select	
	UKPRN,
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
			SWSupAimId,
			HEM1,
			HEM2,
			HEM3,
			HHS1,
			HHS2,
			LDFAM_SOF,
			LDFAM_EEF,
			LDFAM_RES,
			LDFAM_ADL,
			LDFAM_FFI,
			LDFAM_WPP,
			LDFAM_POD,
			LDFAM_ASL,
			LDFAM_FLN,
			LDFAM_NSA,
			ProvSpecDelMon_A,
			ProvSpecDelMon_B,
			ProvSpecDelMon_C,
			ProvSpecDelMon_D,
			LDM1,
			LDM2,
			LDM3,
			LDM4
	from	Valid.LearningDeliveryDenorm 
end
go

 
 
-- Materialisation of the Valid.LearnerEmploymentStatusDenorm view to a table added as an optimisation on the Insert Cases scripts

if object_id ('dbo.TransformInputToValid_LearnerEmploymentStatusDenormTbl','p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid_LearnerEmploymentStatusDenormTbl')
end
go
 
create procedure dbo.TransformInputToValid_LearnerEmploymentStatusDenormTbl as
begin
	insert Valid.LearnerEmploymentStatusDenormTbl (
	UKPRN,
		LearnRefNumber,
		EmpStat,
		EmpId,
		DateEmpStatApp,
		ESMCode_BSI,
		ESMCode_EII,
		ESMCode_LOE,
		ESMCode_LOU,
		ESMCode_PEI,
		ESMCode_SEI,
		ESMCode_SEM
	)
	select	
	UKPRN,
	LearnRefNumber,
			EmpStat,
			EmpId,
			DateEmpStatApp,
			ESMCode_BSI,
			ESMCode_EII,
			ESMCode_LOE,
			ESMCode_LOU,
			ESMCode_PEI,
			ESMCode_SEI,
			ESMCode_SEM
	from	Valid.LearnerEmploymentStatusDenorm
end
go

if object_id (N'dbo.TransformInputToValid', 'p') is not null
begin
	exec ('drop procedure dbo.TransformInputToValid')
end
go
 
create procedure dbo.TransformInputToValid as
begin
	exec dbo.TransformInputToValid_AppFinRecord
	exec dbo.TransformInputToValid_CollectionDetails
	exec dbo.TransformInputToValid_ContactPreference
	exec dbo.TransformInputToValid_DPOutcome
	exec dbo.TransformInputToValid_EmploymentStatusMonitoring
	exec dbo.TransformInputToValid_Learner
	exec dbo.TransformInputToValid_LearnerDestinationandProgression
	exec dbo.TransformInputToValid_LearnerEmploymentStatus
	exec dbo.TransformInputToValid_LearnerFAM
	exec dbo.TransformInputToValid_LearnerHE
	exec dbo.TransformInputToValid_LearnerHEFinancialSupport
	exec dbo.TransformInputToValid_LearningDelivery
	exec dbo.TransformInputToValid_LearningDeliveryFAM
	exec dbo.TransformInputToValid_LearningDeliveryHE
	exec dbo.TransformInputToValid_LearningDeliveryWorkPlacement
	exec dbo.TransformInputToValid_LearningProvider
	exec dbo.TransformInputToValid_LLDDandHealthProblem
	exec dbo.TransformInputToValid_ProviderSpecDeliveryMonitoring
	exec dbo.TransformInputToValid_ProviderSpecLearnerMonitoring
	exec dbo.TransformInputToValid_Source
	exec dbo.TransformInputToValid_SourceFile

	--Insert to these tables at the end so that dependencies are in place.
	exec dbo.TransformInputToValid_LearningDeliveryDenormTbl
	exec dbo.TransformInputToValid_LearnerEmploymentStatusDenormTbl 

end 
go

