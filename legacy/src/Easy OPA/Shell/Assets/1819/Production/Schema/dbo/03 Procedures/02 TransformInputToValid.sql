﻿if object_id ('[dbo].[TransformInputToValid_AppFinRecord]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_AppFinRecord]')
go
 
create procedure [dbo].[TransformInputToValid_AppFinRecord] as
begin
insert into [Valid].[AppFinRecord]
(
	[LearnRefNumber],
	[AimSeqNumber],
	[AFinType],
	[AFinCode],
	[AFinDate],
	[AFinAmount]
)
select
	AFR.LearnRefNumber,
	AFR.AimSeqNumber,
	AFR.AFinType,
	AFR.AFinCode,
	AFR.AFinDate,
	AFR.AFinAmount
from
	[Input].[AppFinRecord] as AFR
	inner join [Input].[LearningDelivery]
		on [LearningDelivery].[LearningDelivery_Id]=AFR.[LearningDelivery_Id]
	inner join [Input].[Learner]
		on [Learner].[Learner_Id]=[LearningDelivery].[Learner_Id]
	inner join [dbo].[ValidLearners]
		on [Learner].[Learner_Id]=[ValidLearners].[Learner_Id]
end
go
 
if object_id ('[dbo].[TransformInputToValid_CollectionDetails]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_CollectionDetails]')
go
 
create procedure [dbo].[TransformInputToValid_CollectionDetails] as
begin
insert into [Valid].[CollectionDetails]
(
	[Collection],
	[Year],
	[FilePreparationDate]
)
select
	CD.Collection,
	CD.Year,
	CD.FilePreparationDate
from
	[Input].[CollectionDetails] as CD
end
go
 
if object_id ('[dbo].[TransformInputToValid_ContactPreference]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_ContactPreference]')
go
 
create procedure [dbo].[TransformInputToValid_ContactPreference] as
begin
insert into [Valid].[ContactPreference]
(
	[LearnRefNumber],
	[ContPrefType],
	[ContPrefCode]
)
select
	CP.LearnRefNumber,
	CP.ContPrefType,
	CP.ContPrefCode
from
	[Input].[ContactPreference] as CP
	join dbo.ValidLearners as vl
	on vl.Learner_Id = CP.Learner_Id
end
go
 
if object_id ('[dbo].[TransformInputToValid_DPOutcome]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_DPOutcome]')
go
 
create procedure [dbo].[TransformInputToValid_DPOutcome] as
begin
insert into [Valid].[DPOutcome]
(
	[LearnRefNumber],
	[OutType],
	[OutCode],
	[OutStartDate],
	[OutEndDate],
	[OutCollDate]
)
select
	DPO.LearnRefNumber,
	DPO.OutType,
	DPO.OutCode,
	DPO.OutStartDate,
	DPO.OutEndDate,
	DPO.OutCollDate
from
	[Input].[DPOutcome] as DPO
	inner join [Input].[LearnerDestinationandProgression] as dp
		on dp.[LearnerDestinationandProgression_Id]=dpo.[LearnerDestinationandProgression_Id]
	inner join [dbo].[ValidLearnerDestinationandProgressions] as vdp
		on dpo.[LearnerDestinationandProgression_Id]=vdp.[LearnerDestinationandProgression_Id]

end
go
 
if object_id ('[dbo].[TransformInputToValid_EmploymentStatusMonitoring]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_EmploymentStatusMonitoring]')
go
 
create procedure [dbo].[TransformInputToValid_EmploymentStatusMonitoring] as
begin
insert into [Valid].[EmploymentStatusMonitoring]
(
	[LearnRefNumber],
	[DateEmpStatApp],
	[ESMType],
	[ESMCode]
)
select Distinct
	ESM.LearnRefNumber,
	ESM.DateEmpStatApp,
	ESM.ESMType,
	ESM.ESMCode
from
	[Input].[EmploymentStatusMonitoring] AS ESM
	INNER JOIN Input.LearnerEmploymentStatus LES
		ON ESM.LearnerEmploymentStatus_Id = LES.LearnerEmploymentStatus_Id
	INNER JOIN dbo.ValidLearners AS VL
		on VL.Learner_Id = LES.Learner_Id
end
go
 
if object_id ('[dbo].[TransformInputToValid_Learner]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_Learner]')
go
 
create procedure [dbo].[TransformInputToValid_Learner] as
begin
insert into [Valid].[Learner]
(
	[LearnRefNumber],
	[PrevLearnRefNumber],
	[PrevUKPRN],
	[PMUKPRN],
	CampId,
	[ULN],
	[FamilyName],
	[GivenNames],
	[DateOfBirth],
	[Ethnicity],
	[Sex],
	[LLDDHealthProb],
	[NINumber],
	[PriorAttain],
	[Accom],
	[ALSCost],
	[PlanLearnHours],
	[PlanEEPHours],
	[MathGrade],
	[EngGrade],
	[PostcodePrior],
	[Postcode],
	[AddLine1],
	[AddLine2],
	[AddLine3],
	[AddLine4],
	[TelNo],
	[Email],
	OTJHours
)
select
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
	L.Email,
	L.OTJHours
from
	[Input].[Learner] as L
	join dbo.ValidLearners as vl
	on vl.Learner_Id = L.Learner_Id
end
go
 
if object_id ('[dbo].[TransformInputToValid_LearnerDestinationandProgression]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_LearnerDestinationandProgression]')
go
 
create procedure [dbo].[TransformInputToValid_LearnerDestinationandProgression] as
begin
insert into [Valid].[LearnerDestinationandProgression]
(
	[LearnRefNumber],
	[ULN]
)
select distinct
	LDP.LearnRefNumber,
	LDP.ULN
from
	[Input].[LearnerDestinationandProgression] as LDP
	join [dbo].[ValidLearnerDestinationandProgressions] as vdp
		on LDP.[LearnerDestinationandProgression_Id] = vdp.[LearnerDestinationandProgression_Id]
end
go
 
if object_id ('[dbo].[TransformInputToValid_LearnerEmploymentStatus]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_LearnerEmploymentStatus]')
go
 
create procedure [dbo].[TransformInputToValid_LearnerEmploymentStatus] as
begin
insert into [Valid].[LearnerEmploymentStatus]
(
	[LearnRefNumber],
	[EmpStat],
	[DateEmpStatApp],
	[EmpId],
	[AgreeId]
)
select Distinct
	LES.LearnRefNumber,
	LES.EmpStat,
	LES.DateEmpStatApp,
	LES.EmpId,
	LES.AgreeId
from
	[Input].[LearnerEmploymentStatus] as LES
	join dbo.ValidLearners as vl
	on vl.Learner_Id = LES.Learner_Id
END
GO
 
if object_id ('[dbo].[TransformInputToValid_LearnerFAM]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_LearnerFAM]')
go
 
create procedure [dbo].[TransformInputToValid_LearnerFAM] as
begin
insert into [Valid].[LearnerFAM]
(
	[LearnRefNumber],
	[LearnFAMType],
	[LearnFAMCode]
)
select
	CAST(LFAM.LearnRefNumber AS varchar(12)),
	LFAM.LearnFAMType,
	LFAM.LearnFAMCode
from
	[Input].[LearnerFAM] as LFAM
	join dbo.ValidLearners as vl
	on vl.Learner_Id = LFAM.Learner_Id
end
go
 
if object_id ('[dbo].[TransformInputToValid_LearnerHE]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_LearnerHE]')
go
 
create procedure [dbo].[TransformInputToValid_LearnerHE] as
begin
insert into [Valid].[LearnerHE]
(
	[LearnRefNumber],
	[UCASPERID],
	[TTACCOM]
)
select
	l.LearnRefNumber,
	lhe.UCASPERID,
	lhe.TTACCOM
from
	[Input].[LearnerHE] as lhe
	inner join [Input].[Learner] as l
		on lhe.[Learner_Id]=l.[Learner_Id]
	inner join [dbo].[ValidLearners] as vl
		on lhe.[Learner_Id]=vl.[Learner_Id]
end
go
 
if object_id ('[dbo].[TransformInputToValid_LearnerHEFinancialSupport]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_LearnerHEFinancialSupport]')
go
 
create procedure [dbo].[TransformInputToValid_LearnerHEFinancialSupport] as
begin
insert into [Valid].[LearnerHEFinancialSupport]
(
	[LearnRefNumber],
	[FINTYPE],
	[FINAMOUNT]
)
select
	LearnerHEFinancialSupport.LearnRefNumber,
	LearnerHEFinancialSupport.FINTYPE,
	LearnerHEFinancialSupport.FINAMOUNT
from
	[Input].[LearnerHEFinancialSupport]
	inner join [Input].[LearnerHE]
		on [LearnerHEFinancialSupport].[LearnerHE_Id]=[LearnerHE].[LearnerHE_Id]
	inner join [Input].[Learner]
		on [Learner].[Learner_Id]=[LearnerHE].[Learner_Id]
	inner join [dbo].[ValidLearners]
		on [LearnerHE].[Learner_Id]=[ValidLearners].[Learner_Id]
end
go
 
if object_id ('[dbo].[TransformInputToValid_LearningDelivery]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_LearningDelivery]')
go
 
create procedure [dbo].[TransformInputToValid_LearningDelivery] as
begin
insert into [Valid].[LearningDelivery]
(
	[LearnRefNumber],
	[LearnAimRef],
	[AimType],
	[AimSeqNumber],
	[LearnStartDate],
	[OrigLearnStartDate],
	[LearnPlanEndDate],
	[FundModel],
	[ProgType],
	[FworkCode],
	[PwayCode],
	[StdCode],
	[PartnerUKPRN],
	[DelLocPostCode],
	[AddHours],
	[PriorLearnFundAdj],
	[OtherFundAdj],
	[ConRefNumber],
	[EPAOrgID],
	[EmpOutcome],
	[CompStatus],
	[LearnActEndDate],
	[WithdrawReason],
	[Outcome],
	[AchDate],
	[OutGrade],
	[SWSupAimId]
)
select Distinct
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
from
	[Input].[LearningDelivery] as LD
	join dbo.ValidLearners as vl
	on vl.Learner_Id = LD.Learner_Id
END
GO
 
if object_id ('[dbo].[TransformInputToValid_LearningDeliveryFAM]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_LearningDeliveryFAM]')
go
 
create procedure [dbo].[TransformInputToValid_LearningDeliveryFAM] as
begin
insert into [Valid].[LearningDeliveryFAM]
(
	[LearnRefNumber],
	[AimSeqNumber],
	[LearnDelFAMType],
	[LearnDelFAMCode],
	[LearnDelFAMDateFrom],
	[LearnDelFAMDateTo]
)
select
	LearningDeliveryFAM.LearnRefNumber,
	LearningDeliveryFAM.AimSeqNumber,
	LearningDeliveryFAM.LearnDelFAMType,
	LearningDeliveryFAM.LearnDelFAMCode,
	LearningDeliveryFAM.LearnDelFAMDateFrom,
	LearningDeliveryFAM.LearnDelFAMDateTo
from
	[Input].[LearningDeliveryFAM]
	inner join [Input].[LearningDelivery]
		on [LearningDeliveryFAM].[LearningDelivery_Id]=[LearningDelivery].[LearningDelivery_Id]
	inner join [Input].[Learner]
		on [LearningDelivery].[Learner_Id]=[Learner].[Learner_Id]
	inner join [dbo].[ValidLearners]
		on [Learner].[Learner_Id]=[ValidLearners].[Learner_Id]
end
go
 
if object_id ('[dbo].[TransformInputToValid_LearningDeliveryHE]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_LearningDeliveryHE]')
go
 
create procedure [dbo].[TransformInputToValid_LearningDeliveryHE] as
begin
insert into [Valid].[LearningDeliveryHE]
(
	[LearnRefNumber],
	[AimSeqNumber],
	[NUMHUS],
	[SSN],
	[QUALENT3],
	[SOC2000],
	[SEC],
	[UCASAPPID],
	[TYPEYR],
	[MODESTUD],
	[FUNDLEV],
	[FUNDCOMP],
	[STULOAD],
	[YEARSTU],
	[MSTUFEE],
	[PCOLAB],
	[PCFLDCS],
	[PCSLDCS],
	[PCTLDCS],
	[SPECFEE],
	[NETFEE],
	[GROSSFEE],
	[DOMICILE],
	[ELQ],
	[HEPostCode]
)
select
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
from
	[Input].[LearningDeliveryHE] AS LDHE
	INNER JOIN Input.LearningDelivery AS LD
		ON LDHE.LearningDelivery_Id = LD.LearningDelivery_Id
	INNER JOIN dbo.ValidLearners AS VL
		ON VL.Learner_Id = LD.Learner_Id
end
go
 
if object_id ('[dbo].[TransformInputToValid_LearningDeliveryWorkPlacement]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_LearningDeliveryWorkPlacement]')
go
 
create procedure [dbo].[TransformInputToValid_LearningDeliveryWorkPlacement] as
begin
insert into [Valid].[LearningDeliveryWorkPlacement]
(
	[LearnRefNumber],
	[AimSeqNumber],
	[WorkPlaceStartDate],
	[WorkPlaceEndDate],
	[WorkPlaceHours],
	[WorkPlaceMode],
	[WorkPlaceEmpId]
)
select
	LDWP.LearnRefNumber,
	LDWP.AimSeqNumber,
	LDWP.WorkPlaceStartDate,
	LDWP.WorkPlaceEndDate,
	LDWP.WorkPlaceHours,
	LDWP.WorkPlaceMode,
	LDWP.WorkPlaceEmpId
from
	[Input].[LearningDeliveryWorkPlacement] AS LDWP
	INNER JOIN Input.LearningDelivery AS LD
		ON LDWP.LearningDelivery_Id = LD.LearningDelivery_Id
	INNER JOIN dbo.ValidLearners AS VL
		on VL.Learner_Id = LD.Learner_Id
	where LDWP.WorkPlaceEmpId is not null
end
go
 
if object_id ('[dbo].[TransformInputToValid_LearningProvider]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_LearningProvider]')
go
 
create procedure [dbo].[TransformInputToValid_LearningProvider] as
begin
insert into [Valid].[LearningProvider]
(
	[UKPRN]
)
select
	LP.UKPRN
from
	[Input].[LearningProvider] as LP
	--join Input.Learner as l
	--on l.LearnRefNumber = LP.LearnRefNumber
	--join dbo.ValidLearners as vl
	--on vl.Learner_Id = l.Learner_Id
end
go
 
if object_id ('[dbo].[TransformInputToValid_LLDDandHealthProblem]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_LLDDandHealthProblem]')
go
 
create procedure [dbo].[TransformInputToValid_LLDDandHealthProblem] as
begin
insert into [Valid].[LLDDandHealthProblem]
(
	[LearnRefNumber],
	[LLDDCat],
	[PrimaryLLDD]
)
select
	[LLDDandHealthProblem].LearnRefNumber,
	[LLDDandHealthProblem].LLDDCat,
	[LLDDandHealthProblem].PrimaryLLDD
from
	[Input].[LLDDandHealthProblem]
	inner join [Input].[Learner]
		on [LLDDandHealthProblem].[Learner_Id]=[Learner].[Learner_Id]
	inner join [dbo].[ValidLearners]
		on [LLDDandHealthProblem].[Learner_Id]=[ValidLearners].[Learner_Id]	
end
go
 
if object_id ('[dbo].[TransformInputToValid_ProviderSpecDeliveryMonitoring]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_ProviderSpecDeliveryMonitoring]')
go
 
create procedure [dbo].[TransformInputToValid_ProviderSpecDeliveryMonitoring] as
begin
insert into [Valid].[ProviderSpecDeliveryMonitoring]
(
	[LearnRefNumber],
	[AimSeqNumber],
	[ProvSpecDelMonOccur],
	[ProvSpecDelMon]
)
select Distinct
	PSDM.LearnRefNumber,
	PSDM.AimSeqNumber,
	PSDM.ProvSpecDelMonOccur,
	PSDM.ProvSpecDelMon
from
	[Input].[ProviderSpecDeliveryMonitoring] AS PSDM
	INNER JOIN Input.LearningDelivery AS LD
		ON PSDM.LearningDelivery_Id = LD.LearningDelivery_Id
	INNER JOIN dbo.ValidLearners AS VL
		ON VL.Learner_Id = LD.Learner_Id
end
go
 
if object_id ('[dbo].[TransformInputToValid_ProviderSpecLearnerMonitoring]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_ProviderSpecLearnerMonitoring]')
go
 
create procedure [dbo].[TransformInputToValid_ProviderSpecLearnerMonitoring] as
begin
insert into [Valid].[ProviderSpecLearnerMonitoring]
(
	[LearnRefNumber],
	[ProvSpecLearnMonOccur],
	[ProvSpecLearnMon]
)
select Distinct
	PSLM.LearnRefNumber,
	PSLM.ProvSpecLearnMonOccur,
	PSLM.ProvSpecLearnMon
from
	[Input].[ProviderSpecLearnerMonitoring] as PSLM
	join dbo.ValidLearners as vl
	on vl.Learner_Id = PSLM.Learner_Id
end
go
 
if object_id ('[dbo].[TransformInputToValid_Source]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_Source]')
go
 
create procedure [dbo].[TransformInputToValid_Source] as
begin
insert into [Valid].[Source]
(
	[ProtectiveMarking],
	[UKPRN],
	[SoftwareSupplier],
	[SoftwarePackage],
	[Release],
	[SerialNo],
	[DateTime],
	[ReferenceData],
	[ComponentSetVersion]
)
select
	S.ProtectiveMarking,
	S.UKPRN,
	S.SoftwareSupplier,
	S.SoftwarePackage,
	S.Release,
	S.SerialNo,
	S.DateTime,
	S.ReferenceData,
	S.ComponentSetVersion
from
	[Input].[Source] as S
end
go
 
if object_id ('[dbo].[TransformInputToValid_SourceFile]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_SourceFile]')
go
 
create procedure [dbo].[TransformInputToValid_SourceFile] as
begin
insert into [Valid].[SourceFile]
(
	[SourceFileName],
	[FilePreparationDate],
	[SoftwareSupplier],
	[SoftwarePackage],
	[Release],
	[SerialNo],
	[DateTime]
)
select
	SF.SourceFileName,
	SF.FilePreparationDate,
	SF.SoftwareSupplier,
	SF.SoftwarePackage,
	SF.Release,
	SF.SerialNo,
	SF.DateTime
from
	[Input].[SourceFile] as SF
end
go


-- Materialisation of the [Valid].[LearningDeliveryDenorm] view to a table added as an optimisation on the Insert Cases scripts

if object_id ('[dbo].[TransformInputToValid_LearningDeliveryDenormTbl]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_LearningDeliveryDenormTbl]')
go
 
create procedure [dbo].[TransformInputToValid_LearningDeliveryDenormTbl] as
begin
INSERT [Valid].[LearningDeliveryDenormTbl]
(
	 [LearnRefNumber]		
	,[LearnAimRef]			
	,[AimType]				
	,[AimSeqNumber]			
	,[LearnStartDate]		
	,[OrigLearnStartDate]	
	,[LearnPlanEndDate]		
	,[FundModel]			
	,[ProgType]				
	,[FworkCode]			
	,[PwayCode]				
	,[StdCode]				
	,[PartnerUKPRN]			
	,[DelLocPostCode]		
	,[AddHours]				
	,[PriorLearnFundAdj]	
	,[OtherFundAdj]			
	,[ConRefNumber]			
	,[EPAOrgID]				
	,[EmpOutcome]			
	,[CompStatus]			
	,[LearnActEndDate]		
	,[WithdrawReason]		
	,[Outcome]				
	,[AchDate]				
	,[OutGrade]				
	,[SWSupAimId]			
	,[HEM1]					
	,[HEM2]					
	,[HEM3]					
	,[HHS1]					
	,[HHS2]					
	,[LDFAM_SOF]			
	,[LDFAM_EEF]			
	,[LDFAM_RES]			
	,[LDFAM_ADL]			
	,[LDFAM_FFI]			
	,[LDFAM_WPP]			
	,[LDFAM_POD]			
	,[LDFAM_ASL]			
	,[LDFAM_FLN]			
	,[LDFAM_NSA]			
	,[ProvSpecDelMon_A]		
	,[ProvSpecDelMon_B]		
	,[ProvSpecDelMon_C]		
	,[ProvSpecDelMon_D]		
	,[LDM1]					
	,[LDM2]					
	,[LDM3]					
	,[LDM4]					
)
SELECT
	 [LearnRefNumber]		
	,[LearnAimRef]			
	,[AimType]				
	,[AimSeqNumber]			
	,[LearnStartDate]		
	,[OrigLearnStartDate]	
	,[LearnPlanEndDate]		
	,[FundModel]			
	,[ProgType]				
	,[FworkCode]			
	,[PwayCode]				
	,[StdCode]				
	,[PartnerUKPRN]			
	,[DelLocPostCode]		
	,[AddHours]				
	,[PriorLearnFundAdj]	
	,[OtherFundAdj]			
	,[ConRefNumber]			
	,[EPAOrgID]				
	,[EmpOutcome]			
	,[CompStatus]			
	,[LearnActEndDate]		
	,[WithdrawReason]		
	,[Outcome]				
	,[AchDate]				
	,[OutGrade]				
	,[SWSupAimId]			
	,[HEM1]					
	,[HEM2]					
	,[HEM3]					
	,[HHS1]					
	,[HHS2]					
	,[LDFAM_SOF]			
	,[LDFAM_EEF]			
	,[LDFAM_RES]			
	,[LDFAM_ADL]			
	,[LDFAM_FFI]			
	,[LDFAM_WPP]			
	,[LDFAM_POD]			
	,[LDFAM_ASL]			
	,[LDFAM_FLN]			
	,[LDFAM_NSA]			
	,[ProvSpecDelMon_A]		
	,[ProvSpecDelMon_B]		
	,[ProvSpecDelMon_C]		
	,[ProvSpecDelMon_D]		
	,[LDM1]					
	,[LDM2]					
	,[LDM3]					
	,[LDM4]		
FROM	Valid.LearningDeliveryDenorm 
END
go

 
 
-- Materialisation of the [Valid].[LearnerEmploymentStatusDenorm] view to a table added as an optimisation on the Insert Cases scripts

if object_id ('[dbo].[TransformInputToValid_LearnerEmploymentStatusDenormTbl]','p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid_LearnerEmploymentStatusDenormTbl]')
go
 
create procedure [dbo].[TransformInputToValid_LearnerEmploymentStatusDenormTbl] as
begin
INSERT [Valid].[LearnerEmploymentStatusDenormTbl]
(
	 [LearnRefNumber]
	,[EmpStat]
	,[EmpId]
	,[DateEmpStatApp]
	,[ESMCode_BSI]
	,[ESMCode_EII]
	,[ESMCode_LOE]
	,[ESMCode_LOU]
	,[ESMCode_PEI]
	,[ESMCode_SEI]
	,[ESMCode_SEM]
)
SELECT
	 [LearnRefNumber]
	,[EmpStat]
	,[EmpId]
	,[DateEmpStatApp]
	,[ESMCode_BSI]
	,[ESMCode_EII]
	,[ESMCode_LOE]
	,[ESMCode_LOU]
	,[ESMCode_PEI]
	,[ESMCode_SEI]
	,[ESMCode_SEM]
FROM [Valid].[LearnerEmploymentStatusDenorm]
END
go

if object_id (N'[dbo].[TransformInputToValid]', 'p') is not null
	exec ('drop procedure [dbo].[TransformInputToValid]')
go
 
create procedure [dbo].[TransformInputToValid] as
begin
	exec [dbo].[TransformInputToValid_AppFinRecord]
	exec [dbo].[TransformInputToValid_CollectionDetails]
	exec [dbo].[TransformInputToValid_ContactPreference]
	exec [dbo].[TransformInputToValid_DPOutcome]
	exec [dbo].[TransformInputToValid_EmploymentStatusMonitoring]
	exec [dbo].[TransformInputToValid_Learner]
	exec [dbo].[TransformInputToValid_LearnerDestinationandProgression]
	exec [dbo].[TransformInputToValid_LearnerEmploymentStatus]
	exec [dbo].[TransformInputToValid_LearnerFAM]
	exec [dbo].[TransformInputToValid_LearnerHE]
	exec [dbo].[TransformInputToValid_LearnerHEFinancialSupport]
	exec [dbo].[TransformInputToValid_LearningDelivery]
	exec [dbo].[TransformInputToValid_LearningDeliveryFAM]
	exec [dbo].[TransformInputToValid_LearningDeliveryHE]
	exec [dbo].[TransformInputToValid_LearningDeliveryWorkPlacement]
	exec [dbo].[TransformInputToValid_LearningProvider]
	exec [dbo].[TransformInputToValid_LLDDandHealthProblem]
	exec [dbo].[TransformInputToValid_ProviderSpecDeliveryMonitoring]
	exec [dbo].[TransformInputToValid_ProviderSpecLearnerMonitoring]
	exec [dbo].[TransformInputToValid_Source]
	exec [dbo].[TransformInputToValid_SourceFile]

	--Insert to these tables at the end so that dependencies are in place.
	exec [dbo].[TransformInputToValid_LearningDeliveryDenormTbl]
	exec [dbo].[TransformInputToValid_LearnerEmploymentStatusDenormTbl] 

end 
go

