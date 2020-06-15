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
				from	Valid.ContactPreference
				where	UKPRN = ${providerID} 
				and		LearnRefNumber = l.LearnRefNumber
				for xml path('ContactPreference'), type, elements),
			(	select	LLDDCat,
						PrimaryLLDD 
				from	Valid.LLDDandHealthProblem
				where	UKPRN = ${providerID} 
				and		LearnRefNumber = l.LearnRefNumber
				for xml path('LLDDandHealthProblem'), type, elements),
			(	select	LearnFAMType,
						LearnFAMCode 
				from	Valid.LearnerFAM
				where	UKPRN = ${providerID} 
				and		LearnRefNumber = l.LearnRefNumber
				for xml path('LearnerFAM'), type, elements),
			(	select	ProvSpecLearnMonOccur,
						ProvSpecLearnMon 
				from	Valid.ProviderSpecLearnerMonitoring
				where	UKPRN = ${providerID} 
				and		LearnRefNumber = l.LearnRefNumber
				for xml path('ProviderSpecLearnerMonitoring'), type, elements),
			(	select	EmpStat,
						cast(DateEmpStatApp as date) as DateEmpStatApp,
						EmpId,
						(	select	ESMType,
									ESMCode 
							from	Valid.EmploymentStatusMonitoring
							where	UKPRN = ${providerID} 
							and		FK_LearnerEmploymentStatus = PK_LearnerEmploymentStatus
							for xml path('EmploymentStatusMonitoring'), type, elements)
				from	Valid.LearnerEmploymentStatus
				where	UKPRN = ${providerID} 
				and		LearnRefNumber = l.LearnRefNumber
				for xml path('LearnerEmploymentStatus'), type, elements),
			(	select	UCASPERID,
						TTACCOM,
						(	select	FINTYPE,
									FINAMOUNT 
							from	Valid.LearnerHEFinancialSupport
							where	UKPRN = ${providerID} 
							and		FK_LearnerHE = PK_LearnerHE 
							for xml path('LearnerHEFinancialSupport'), type, elements)
				from	Valid.LearnerHE
				where	UKPRN = ${providerID} 
				and		LearnRefNumber = l.LearnRefNumber
				for xml path('LearnerHE'), type, elements),
			(	select	LearnAimRef,
						AimType,
						AimSeqNumber,
						cast(LearnStartDate as date) as LearnStartDate,
						cast(OrigLearnStartDate as date) as OrigLearnStartDate,
						cast(LearnPlanEndDate as date) as LearnPlanEndDate,
						FundModel,
						PHours,
						OTJActHours,
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
							from	Valid.LearningDeliveryFAM
							where	UKPRN = ${providerID} 
							and		FK_LearningDelivery = ld.PK_LearningDelivery 
							and		AimSeqNumber = ld.AimSeqNumber
							for xml path('LearningDeliveryFAM'), type, elements),
						(	select	cast(WorkPlaceStartDate as date) as WorkPlaceStartDate, 
									cast(WorkPlaceEndDate as date) as WorkPlaceEndDate, 
									WorkPlaceHours, 
									WorkPlaceMode, 
									WorkPlaceEmpId 
							from	Valid.LearningDeliveryWorkPlacement
							where	UKPRN = ${providerID} 
							and		FK_LearningDelivery = ld.PK_LearningDelivery 
							and		AimSeqNumber = ld.AimSeqNumber
							for xml path('LearningDeliveryWorkPlacement'), type, elements),
						(	select	AFinType,
									AFinCode,
									cast(AFinDate as date) as AFinDate,
									AFinAmount 
							from	Valid.AppFinRecord
							where	UKPRN = ${providerID} 
							and		FK_LearningDelivery = ld.PK_LearningDelivery 
							and		AimSeqNumber = ld.AimSeqNumber
							for xml path('AppFinRecord'), type, elements),
						(	select	ProvSpecDelMonOccur,
									ProvSpecDelMon 
							from	Valid.ProviderSpecDeliveryMonitoring
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
							from	Valid.LearningDeliveryHE
							where	UKPRN = ${providerID} 
							and		FK_LearningDelivery = ld.PK_LearningDelivery 
							and		AimSeqNumber = ld.AimSeqNumber
							for xml path('LearningDeliveryHE'), type, elements)
				from	Valid.LearningDelivery as ld
				where	ld.UKPRN = ${providerID} 
				and		ld.LearnRefNumber = l.LearnRefNumber
				for xml path('LearningDelivery'), type, elements)
	from	Valid.Learner l
	where	UKPRN = ${providerID}
	for xml path ('Learner')
) as varchar(max)),'')
