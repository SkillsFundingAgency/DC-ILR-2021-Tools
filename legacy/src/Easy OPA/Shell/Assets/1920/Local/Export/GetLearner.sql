select coalesce(cast((	
	select	LearnRefNumber,
			PrevLearnRefNumber,
			PrevUKPRN,
			PMUKPRN,
			CampId,
			ULN,
			FamilyName,
			GivenNames,
			cast(DateOfBirth as date) as DateOfBirth,
			Ethnicity,
			Sex,
			LLDDHealthProb,
			NINumber,
			PriorAttain,
			Accom,
			ALSCost,
			PlanLearnHours,
			PlanEEPHours,
			MathGrade ,
			EngGrade ,
			PostcodePrior,
			Postcode,
			AddLine1,
			AddLine2,
			AddLine3,
			AddLine4,
			TelNo,
			Email,
			(	select	ContPrefType,
						ContPrefCode 
				from	Clone.ContactPreference
				where	UKPRN = ${providerID} 
				and		FK_Learner = PK_Learner 
				for xml path('ContactPreference'), type, elements),
			(	select	LLDDCat,
						PrimaryLLDD 
				from	Clone.LLDDandHealthProblem
				where	UKPRN = ${providerID} 
				and		FK_Learner = PK_Learner 
				for xml path('LLDDandHealthProblem'), type, elements),
			(	select	LearnFAMType,
						LearnFAMCode 
				from	Clone.LearnerFAM
				where	UKPRN = ${providerID} 
				and		FK_Learner = PK_Learner 
				for xml path('LearnerFAM'), type, elements),
			(	select	ProvSpecLearnMonOccur,
						ProvSpecLearnMon 
				from	Clone.ProviderSpecLearnerMonitoring
				where	UKPRN = ${providerID} 
				and		FK_Learner = PK_Learner 
				for xml path('ProviderSpecLearnerMonitoring'), type, elements),
			(	select	EmpStat,
						cast(DateEmpStatApp as date) as DateEmpStatApp,
						EmpId,
						AgreeId,
						(	select	ESMType,
									ESMCode 
							from	Clone.EmploymentStatusMonitoring
							where	UKPRN = ${providerID} 
							and		FK_LearnerEmploymentStatus = PK_LearnerEmploymentStatus
							for xml path('EmploymentStatusMonitoring'), type, elements)
				from	Clone.LearnerEmploymentStatus
				where	UKPRN = ${providerID} 
				and		FK_Learner = PK_Learner 
				for xml path('LearnerEmploymentStatus'), type, elements),
			(	select	UCASPERID,
						TTACCOM,
						(	select	FINTYPE,
									FINAMOUNT 
							from	Clone.LearnerHEFinancialSupport
							where	UKPRN = ${providerID} 
							and		FK_LearnerHE = PK_LearnerHE 
							for xml path('LearnerHEFinancialSupport'), type, elements)
				from	Clone.LearnerHE
				where	UKPRN = ${providerID} 
				and		FK_Learner = PK_Learner 
				for xml path('LearnerHE'), type, elements),
			(	select	LearnAimRef,
						AimType,
						AimSeqNumber,
						cast(LearnStartDate as date) as LearnStartDate,
						cast(OrigLearnStartDate as date) as OrigLearnStartDate,
						cast(LearnPlanEndDate as date) as LearnPlanEndDate,
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
						cast(LearnActEndDate as date) as LearnActEndDate,
						WithdrawReason,
						Outcome,
						cast(AchDate as date) as AchDate,
						OutGrade,
						SWSupAimId,
						(	select	LearnDelFAMType,
									LearnDelFAMCode,
									cast(LearnDelFAMDateFrom as date) as LearnDelFAMDateFrom,
									cast(LearnDelFAMDateTo as date) as LearnDelFAMDateTo 
							from	Clone.LearningDeliveryFAM
							where	UKPRN = ${providerID} 
							and		FK_LearningDelivery = ld.PK_LearningDelivery 
							and		AimSeqNumber = ld.AimSeqNumber
							for xml path('LearningDeliveryFAM'), type, elements),
						(	select	cast(WorkPlaceStartDate as date) as WorkPlaceStartDate, 
									cast(WorkPlaceEndDate as date) as WorkPlaceEndDate, 
									WorkPlaceHours, 
									WorkPlaceMode, 
									WorkPlaceEmpId 
							from	Clone.LearningDeliveryWorkPlacement
							where	UKPRN = ${providerID} 
							and		FK_LearningDelivery = ld.PK_LearningDelivery 
							and		AimSeqNumber = ld.AimSeqNumber
							for xml path('LearningDeliveryWorkPlacement'), type, elements),
						(	select	AFinType,
									AFinCode,
									cast(AFinDate as date) as AFinDate,
									AFinAmount 
							from	Clone.AppFinRecord
							where	UKPRN = ${providerID} 
							and		FK_LearningDelivery = ld.PK_LearningDelivery 
							and		AimSeqNumber = ld.AimSeqNumber
							for xml path('AppFinRecord'), type, elements),
						(	select	ProvSpecDelMonOccur,
									ProvSpecDelMon 
							from	Clone.ProviderSpecDeliveryMonitoring
							where	UKPRN = ${providerID} 
							and		FK_LearningDelivery = ld.PK_LearningDelivery 
							and		AimSeqNumber = ld.AimSeqNumber
							for xml path('ProviderSpecDeliveryMonitoring'), type, elements),
						(	select	NUMHUS,
									SSN,
									QUALENT3,
									SOC2000,
									SEC,
									UCASAPPID,
									TYPEYR,
									MODESTUD,
									FUNDLEV,
									FUNDCOMP,
									cast(STULOAD as varchar) as STULOAD,
									YEARSTU,
									MSTUFEE,
									cast(PCOLAB as varchar) as PCOLAB,
									cast(PCFLDCS as varchar) as PCFLDCS,
									cast(PCSLDCS as varchar) as PCSLDCS,
									cast(PCTLDCS as varchar) as PCTLDCS,
									SPECFEE,
									NETFEE,
									GROSSFEE,
									DOMICILE,
									ELQ,
									HEPostCode 
							from	Clone.LearningDeliveryHE
							where	UKPRN = ${providerID} 
							and		FK_LearningDelivery = ld.PK_LearningDelivery 
							and		AimSeqNumber = ld.AimSeqNumber
							for xml path('LearningDeliveryHE'), type, elements)
				from	Clone.LearningDelivery as ld
				where	ld.UKPRN = ${providerID} 
				and		ld.FK_Learner = PK_Learner
				for xml path('LearningDelivery'), type, elements)
	from	Clone.Learner
	where	UKPRN = ${providerID}
	for xml path ('Learner')
) as varchar(max)),'')
