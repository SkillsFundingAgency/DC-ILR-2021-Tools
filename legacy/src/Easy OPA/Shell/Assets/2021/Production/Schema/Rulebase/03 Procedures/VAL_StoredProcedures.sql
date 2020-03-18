if object_id('Rulebase.VAL_Get_Cases','p') is not null
begin
	drop procedure Rulebase.VAL_Get_Cases
end
go

create procedure Rulebase.VAL_Get_Cases as
begin
	set nocount on

	select	CaseData
	from	Rulebase.VAL_Cases
end
go

if object_id('Rulebase.VAL_Insert_Cases','p') is not null
begin
	drop procedure Rulebase.VAL_Insert_Cases
end
go

create procedure Rulebase.VAL_Insert_Cases as
begin
	set nocount on

	insert into Rulebase.VAL_Cases (
		Learner_Id,
		CaseData
	)
	select	ControllingTable.Learner_Id,
			convert(xml, (	select	cd.FilePreparationDate as [@FilePreparationDate],
									lp.UKPRN as [@UKPRN],
									ocv.CurrentVersion as [@OrgVersion],
									lv.CurrentVersion as [@LARSVersion],
									Org_Details.LegalOrgType as [@LegalOrgType],
									case when '${dcft.runmode}' = 'DS' 
										then 'true' 
										else 'false' 
									end as [@DesktopMode],
									case when Contract_ESF1420.UKPRN is not null 
										then 'true' 
										else 'false' 
									end as [@FCT_ESF1420],
									case when Contract_LEVY1799.UKPRN  is not null 
										then 'true' 
										else 'false' 
									end as [@FCT_LEVY1799],
									case when Contract_1618NLAP2018.UKPRN is not null 
										then 'true' 
										else 'false' 
									end as [@FCT_16-18NLAP2018],
									case when Contract_ALLBC1819.UKPRN is not null 
										then 'true' 
										else 'false' 
									end as [@FCT_ALLBC1819],
									case when Contract_AEBC1819.UKPRN is not null 
										then 'true' 
										else 'false' 
									end as [@FCT_AEBC1819],
									case when Contract_APPS1819.UKPRN is not null 
										then 'true' 
										else 'false' 
									end as [@FCT_APPS1819],
									case when Contract_ANLAP2018.UKPRN is not null 
										then 'true' 
										else 'false' 
									end as [@FCT_ANLAP2018],
									case when Contract_ALLB1819.UKPRN is not null 
										then 'true' 
										else 'false' 
									end as [@FCT_ALLB1819],
									case when Contract_AEB_TOL1819.UKPRN is not null 
										then 'true' 
										else 'false' 
									end as [@FCT_AEB-TOL1819],
									(select	l.PrevUKPRN as [@PrevUKPRN],
											l.LearnRefNumber as [@LearnRefNumber],
											l.DateOfBirth as [@DateOfBirth],
											l.Accom as [@Accom],
											l.FamilyName as [@FamilyName],
											l.GivenNames as [@GivenNames],
											l.LLDDHealthProb as [@LLDDHealthProb],
											l.NINumber as [@NINumber],
											l.PriorAttain as [@PriorAttain],
											l.Ethnicity as [@Ethnicity],
											l.PlanEEPHours as [@PlanEEPHours],
											l.PlanLearnHours as [@PlanLearnHours],
											l.ULN as [@ULN],
											l.Sex as [@Sex],
											l.EngGrade as [@EngGrade],
											l.MathGrade as [@MathGrade],
											l.ALSCost as [@ALSCost],
											l.PMUKPRN as [@PMUKPRN],
											l.PostcodePrior as [@PostcodePrior],
											l.Postcode as [@Postcode],
											l.AddLine1 as [@AddLine1],
											l.CampId as [@CampId],
											-- p539	MasterUKPRN, no key on the table so there may be duplicate rows...
											(select	top 1
													MasterUKPRN
											from	Reference.CampusIdentifier
											where	CampusIdentifier.CampusIdentifier = l.CampId) as [@MasterUKPRN],
											case when UniqueLearnerNumbers.ULN is not null 
												then 'true' 
												else 'false' 
											end as [@ULNLookup],
											case when Org_PartnerUKPRN.UKPRN is not null 
												then 'true' 
												else 'false' 
											end as [@PrevUKPRNLookup],
											case when PrevPCLookup.Postcode is not null 
												then 'true' 
												else 'false' 
											end as [@PostCodePriorLookup],
											case when PCLookup.Postcode is not null 
												then 'true' 
												else 'false' 
											end as [@PostcodeLookUp],
											case when PMUKPRNLookUp.UKPRN is not null 
												then 'true' 
												else 'false' 
											end as [@PMUKPRNLookUp],
											case when CampIdLookup.CampusIdentifier is not null
												then 'true'
												else 'false'
											end as [@CampIdLookup],
											(select	LearningDelivery.LearnActEndDate as [@LearnActEndDate],
													LearningDelivery_LARS_LearningDelivery.LearnAimRefType as [@LearnAimRefType],
													LearningDelivery.LearnPlanEndDate as [@LearnPlanEndDate],
													LearningDelivery.LearnStartDate as [@LearnStartDate],
													LearningDelivery.OtherFundAdj as [@OtherFundAdj],
													LearningDelivery.AimSeqNumber as [@AimSeqNumber],
													LearningDelivery.AimType as [@AimType],
													LearningDelivery.CompStatus as [@CompStatus],
													LearningDelivery.FundModel as [@FundModel],
													LearningDelivery.EmpOutcome as [@EmpOutcome],
													LearningDelivery.FworkCode as [@FworkCode],
													LearningDelivery.Outcome as [@Outcome],
													LearningDelivery.AchDate as [@AchDate],
													LARS_Section96.Section96ReviewDate as [@Section96ReviewDate],
													LARS_Section96.Section96ApprovalStatus as [@Section96ApprovalStatus],
													LearningDelivery.DelLocPostCode as [@DelLocPostcode],
													LearningDelivery.PwayCode as [@PwayCode],
													LearningDelivery.OutGrade as [@OutGrade],
													LearningDelivery.ProgType as [@ProgType],
													LearningDelivery.PartnerUKPRN as [@PartnerUKPRN],
													LearningDelivery_LARS_LearningDelivery.LearnDirectClassSystemCode2 as [@LDCS2Code],
													LARS_FrameworkAims.FrameworkComponentType as [@FrameworkComponentType],
													LearningDelivery_LARS_LearningDelivery.UnitType as [@UnitType],
													LearningDelivery.WithdrawReason as [@WithdrawReason],
													LearningDelivery.LearnAimRef as [@LearnAimRef],
													LearningDelivery_LARS_LearningDelivery.LearnDirectClassSystemCode3 as [@LDCS3Code],
													LearningDelivery_LARS_LearningDelivery.NotionalNVQLevelv2 as [@NotionalNVQLevelv2],
													LearningDelivery.PriorLearnFundAdj as [@PriorLearnFundAdj],
													LARS_FrameworkAims.EffectiveTo as [@FrameworkAimEffectiveTo],
													LearningDelivery_LARS_Framework_0_Pathway.EffectiveTo as [@FrameworkEffectiveTo],
													LearningDelivery.OrigLearnStartDate as [@OrigLearnStartDate],
													LearningDelivery_LARS_Framework.EffectiveTo as [@FrameworkPathwayEffectiveTo],
													LearningDelivery_LARS_LearningDelivery.LearnDirectClassSystemCode1 as [@LDCS1Code],
													LearningDelivery.SWSupAimId as [@SWSupAimId],
													LearningDelivery_LARS_LearningDelivery.AwardOrgAimRef as [@AwardOrgAimRef],
													LearningDelivery.AddHours as [@AddHours],
													LearningDelivery.ConRefNumber as [@ConRefNumber],
													LearningDelivery_LARS_LearningDelivery.FrameworkCommonComponent as [@FrameworkCommonComponent],
													LearningDelivery_LARS_LearningDelivery.EnglPrscID as [@LARS_EnglPrscID],
													LearningDelivery_LARS_LearningDelivery.LearningDeliveryGenre as [@LARS_LearningDeliveryGenre],
													LearningDelivery.StdCode as [@StdCode],
													LARS_Standard.EffectiveTo as [@StandardEffectiveTo],
													LearningDelivery.EPAOrgId as [@EPAOrgId],
													case when Org_PartnerUKPRN.UKPRN is not null 
														then 'true' 
														else 'false' 
													end as [@PartnerUKPRNLookup],
													case when LearningDelivery_LARS_LearningDelivery.LearnAimRef is not null 
														then 'true' 
														else 'false' 
													end as [@LearnAimRefLookup],
													case when LARS_FrameworkAims.FworkCode is not null 
														then 'true' 
														else 'false' 
													end as [@FrameworkAimLookup],
													case when LearningDelivery_LARS_Framework_No_Pathway.FworkCode is not null 
														then 'true' 
														else 'false' 
													end as [@FrameworkLookup],
													case when LearningDelivery_LARS_LearningDelivery_LARS_FrameworkCmnComp.LearnAimRef is not null 
														then 'true' 
														else 'false' 
													end as [@FrameworkCommonLookup],
													case when LearningDelivery_LARS_Framework.FworkCode is not null 
														then 'true' 
														else 'false' 
													end as [@FrameworkPathwayLookup],
													case when Postcodes.Postcode is not null 
														then 'true' 
														else 'false' 
													end as [@DelLocPostcodeLookup],
													case LearningDelivery_LARS_LearningDelivery.UnemployedOnly when 1 
														then 'true' 
														else 'false' 
													end as [@UnemployedOnly],
													case when vw_ContractAllocation.contractAllocationNumber is not null 
														then 'true' 
														else 'false' 
													end as [@ConRefNumberValidLookUP],
													case when LARS_LearningDeliveryCategory_TopMostCategory.CategoryRef is not null 
														then 'true' 
														else 'false' 
													end as [@LARS_CategoryRef9],
													case when LARS_Standard.StandardCode is not null 
														then 'true' 
														else 'false' 
													end as [@StandardCodeLookup],
													case when EPAOrganisation.EPAOrgId is not null 
														then 'true' 
														else 'false' 
													end as [@EPAIDLookup],
													(select	LearningDeliveryFAM.LearnDelFAMCode as [@LearnDelFAMCode],
															LearningDeliveryFAM.LearnDelFAMType as [@LearnDelFAMType],
															LearningDeliveryFAM.LearnDelFAMDateFrom as [@LearnDelFAMDateFrom],
															LearningDeliveryFAM.LearnDelFAMDateTo as [@LearnDelFAMDateTo]
													from	Input.LearningDeliveryFAM
													where	LearningDeliveryFAM.LearningDelivery_Id = LearningDelivery.LearningDelivery_Id
													for xml path ('LearningDeliveryFAM'), type),
													(select	LearningDeliveryHE.FUNDLEV as [@FUNDLEV],
															LearningDeliveryHE.QUALENT3 as [@QUALENT3],
															LearningDeliveryHE.PCFLDCS as [@PCFLDCS],
															LearningDeliveryHE.PCSLDCS as [@PCSLDCS],
															LearningDeliveryHE.TYPEYR as [@TYPEYR],
															LearningDeliveryHE.MODESTUD as [@MODESTUD],
															LearningDeliveryHE.STULOAD as [@STULOAD],
															LearningDeliveryHE.MSTUFEE as [@MSTUFEE],
															LearningDeliveryHE.NETFEE as [@NETFEE],
															LearningDeliveryHE.PCTLDCS as [@PCTLDCS],
															LearningDeliveryHE.[NUMHUS] as [@NUMHUS],
															LearningDeliveryHE.SPECFEE as [@SPECFEE],
															LearningDeliveryHE.SSN as [@SSN],
															LearningDeliveryHE.FUNDCOMP as [@FUNDCOMP],
															LearningDeliveryHE.SEC as [@SEC],
															LearningDeliveryHE.DOMICILE as [@DOMICILE],
															LearningDeliveryHE.UCASAPPID as [@UCASAPPID],
															LearningDeliveryHE.PCOLAB as [@PCOLAB],
															LearningDeliveryHE.SOC2000 as [@SOC2000],
															LearningDeliveryHE.ELQ as [@ELQ],
															LearningDeliveryHE.GROSSFEE as [@GROSSFEE],
															LearningDeliveryHE.HEPostCode as [@HEPostCode],
															case when Postcodes.Postcode is not null 
																then 'true' 
																else 'false' 
															end as [@HEPostCodeLookup]
													from	Input.LearningDeliveryHE
																left join Reference.Postcodes
																	on Postcodes.Postcode = LearningDeliveryHE.HEPostCode
													where	LearningDeliveryHE.LearningDelivery_Id = LearningDelivery.LearningDelivery_Id
													for xml path ('LearningDeliveryHE'), type),
													(select	ProvSpecDelMonOccur as [@ProvSpecDelMonOccur],
															ProvSpecDelMon as [@ProvSpecDelMon]
													from	Input.ProviderSpecDeliveryMonitoring
													where	LearningDelivery_Id = LearningDelivery.LearningDelivery_Id
													for xml path ('ProviderSpecDeliveryMonitoring'), type),
													(select	ValidityCategory as [@ValidityCategory],
															LastNewStartDate as [@ValidityLastNewStartDate],
															EndDate as [@ValidityEndDate],
															StartDate as [@ValidityStartDate]
													from	Reference.LARS_Validity
													where	LearnAimRef = LearningDelivery.LearnAimRef
													for xml path ('LearningDeliveryLARSValidity'), type),
													(select	LearningDeliveryWorkPlacement.WorkPlaceEmpId as [@WorkPlaceEmpId],
															LearningDeliveryWorkPlacement.WorkPlaceMode as [@WorkPlaceMode],
															LearningDeliveryWorkPlacement.WorkPlaceEndDate as [@WorkPlaceEndDate],
															LearningDeliveryWorkPlacement.WorkPlaceStartDate as [@WorkPlaceStartDate],
															LearningDeliveryWorkPlacement.WorkPlaceHours as [@WorkPlaceHours],
															case when Employers.URN is not null 
																then 'true' 
																else 'false' 
															end as [@WorkPlaceEmpIdLookup]
													from	Input.LearningDeliveryWorkPlacement
																left join Reference.Employers
																	on Employers.URN = LearningDeliveryWorkPlacement.WorkPlaceEmpId
													where	LearningDeliveryWorkPlacement.LearningDelivery_Id = LearningDelivery.LearningDelivery_Id
													for xml path ('LearningDeliveryWorkPlacement'), type),
													(select	AFinAmount as [@AFinAmount],
															AFinCode as [@AFinCode],
															AFinType as [@AFinType],
															AFinDate as [@AFinDate]
													from	Input.AppFinRecord
													where	LearningDelivery_Id = LearningDelivery.LearningDelivery_Id
													for xml path ('ApprenticeshipFinancialRecord'), type),
													(select	BasicSkillsType as [@LearnDelAnnValBasicSkillsTypeCode],
															EffectiveFrom as [@LearnDelAnnValDateFrom],
															EffectiveTo as [@LearnDelAnnValDateTo],
															FullLevel2EntitlementCategory as [@FullLevel2EntitlementCategory],
															FullLevel3EntitlementCategory as [@FullLevel3EntitlementCategory],
															FullLevel2Percent as [@FullLevel2Percent],
															FullLevel3Percent as [@FullLevel3Percent],
															case BasicSkills  when 1 
																then 'true' 
																else 'false' 
															end as [@BasicSkills]
													from	Reference.LARS_AnnualValue
													where	LearnAimRef = LearningDelivery.LearnAimRef
													for xml path ('LearningDeliveryAnnualValue'), type),
													(select	LearningDelivery_LARS_LearningDeliveryCategory_LARS_LearningDeliveryCategory_Children.CategoryRef as [@LARSCategoryRef],
															LearningDelivery_LARS_LearningDeliveryCategory_LARS_LearningDeliveryCategory_Children.RootCategoryRef as [@TopLevelLARSCategoryRef],
															LearningDelivery_LARS_LearningDeliveryCategory_LARS_LearningDeliveryCategory_Children.ParentCategoryRef as [@ParentLARSCategoryRef]
													from	(select	LARS_LearningDeliveryCategory.CategoryRef,
																	LARS_LearningDeliveryCategory_Children.ParentCategoryRef,
																	LARS_LearningDeliveryCategory_Children.RootCategoryRef,
																	LARS_LearningDeliveryCategory.LearnAimRef
															from	Reference.LARS_LearningDeliveryCategory_Children
																		inner join Reference.LARS_LearningDeliveryCategory
																			on LARS_LearningDeliveryCategory_Children.CategoryRef = LARS_LearningDeliveryCategory.CategoryRef
															) as LearningDelivery_LARS_LearningDeliveryCategory_LARS_LearningDeliveryCategory_Children
													where	LearningDelivery_LARS_LearningDeliveryCategory_LARS_LearningDeliveryCategory_Children.LearnAimRef = LearningDelivery.LearnAimRef
													for xml path ('LearningDeliveryLARSCategory'), type),
													(select	CoreGovContributionCap as [@CoreGovContributionCap],
															EffectiveFrom as [@LARSFundEffectiveFrom],
															--	p526	LARSFundEffectiveTo
															EffectiveTo as [@LARSFundEffectiveTo]
													from	Reference.LARS_StandardFunding
													where	StandardCode = LearningDelivery.StdCode
													for xml path('LearningDeliveryLARSStandardFunding'), type),
													(select	EffectiveFrom as [@EffectiveFrom]
													from	Reference.LARS_Standard
													where	StandardCode = LearningDelivery.StdCode
													for xml path('LearningDeliveryLARSStandard'), type)
											from	Input.LearningDelivery
														left join Reference.LARS_LearningDelivery as LearningDelivery_LARS_LearningDelivery
															on LearningDelivery_LARS_LearningDelivery.LearnAimRef = LearningDelivery.LearnAimRef
														left join Reference.vw_ContractAllocation
															on vw_ContractAllocation.contractAllocationNumber = LearningDelivery.ConRefNumber
														left join Reference.Postcodes
															on Postcodes.Postcode = LearningDelivery.DelLocPostCode
														left join Reference.Org_HMPP_PostCode
															on Org_HMPP_PostCode.HMPPPostCode = LearningDelivery.DelLocPostCode
														left join Reference.LARS_FrameworkAims
															on LARS_FrameworkAims.FworkCode = LearningDelivery.FworkCode
															and LARS_FrameworkAims.ProgType = LearningDelivery.ProgType
															and LARS_FrameworkAims.PwayCode = LearningDelivery.PwayCode
															and LARS_FrameworkAims.LearnAimRef = LearningDelivery.LearnAimRef
														left join Reference.LARS_Framework as LearningDelivery_LARS_Framework_0_Pathway
															on LearningDelivery_LARS_Framework_0_Pathway.FworkCode = LearningDelivery.FworkCode
															and LearningDelivery_LARS_Framework_0_Pathway.ProgType = LearningDelivery.ProgType
															and LearningDelivery_LARS_Framework_0_Pathway.PwayCode = 0
														left join (select	distinct
																			FworkCode,
																			ProgType
																	from	Reference.LARS_Framework
																) as LearningDelivery_LARS_Framework_No_Pathway
															on LearningDelivery_LARS_Framework_No_Pathway.FworkCode = LearningDelivery.FworkCode
															and LearningDelivery_LARS_Framework_No_Pathway.ProgType = LearningDelivery.ProgType
														left join Reference.LARS_Framework as LearningDelivery_LARS_Framework
															on LearningDelivery_LARS_Framework.FworkCode = LearningDelivery.FworkCode
															and LearningDelivery_LARS_Framework.ProgType = LearningDelivery.ProgType
															and LearningDelivery_LARS_Framework.PwayCode = LearningDelivery.PwayCode
														left join Reference.LARS_LearningDeliveryCategory_TopMostCategory
															on LARS_LearningDeliveryCategory_TopMostCategory.LearnAimRef = LearningDelivery.LearnAimRef
															and LARS_LearningDeliveryCategory_TopMostCategory.CategoryRef = 9
														left join Reference.Org_PartnerUKPRN
															on Org_PartnerUKPRN.UKPRN = LearningDelivery.PartnerUKPRN
														left join Reference.LARS_Section96
															on LARS_Section96.LearnAimRef = LearningDelivery.LearnAimRef
														left join Reference.LARS_Standard
															on LARS_Standard.StandardCode = LearningDelivery.StdCode
														left join (	select	LARS_LearningDelivery.LearnAimRef,
																			LARS_FrameworkCmnComp.FworkCode,
																			LARS_FrameworkCmnComp.ProgType,
																			LARS_FrameworkCmnComp.PwayCode,
																			LARS_FrameworkCmnComp.CommonComponent
																	from	Reference.LARS_FrameworkCmnComp
																				inner join Reference.LARS_LearningDelivery
																					on LARS_FrameworkCmnComp.CommonComponent = LARS_LearningDelivery.FrameworkCommonComponent
																)  as LearningDelivery_LARS_LearningDelivery_LARS_FrameworkCmnComp
															on LearningDelivery_LARS_LearningDelivery_LARS_FrameworkCmnComp.LearnAimRef = LearningDelivery.LearnAimRef
															and LearningDelivery_LARS_LearningDelivery_LARS_FrameworkCmnComp.FworkCode = LearningDelivery.FworkCode
															and LearningDelivery_LARS_LearningDelivery_LARS_FrameworkCmnComp.ProgType = LearningDelivery.ProgType
															and LearningDelivery_LARS_LearningDelivery_LARS_FrameworkCmnComp.PwayCode = LearningDelivery.PwayCode
														left join Reference.EPAOrganisation
															on EPAOrganisation.EPAOrgId = LearningDelivery.EPAOrgId
															and EPAOrganisation.StandardCode = cast(LearningDelivery.StdCode as varchar(10))
											where	LearningDelivery.Learner_Id = l.Learner_Id
											for xml path ('LearningDelivery'), type),
											(select	LearnFAMCode as [@LearnFAMCode],
													LearnFAMType as [@LearnFAMType]
											from	Input.LearnerFAM
											where	Learner_Id = l.Learner_Id
											for xml path ('LearnerFAM'), type),
											(select	LearnerEmploymentStatus.EmpStat as [@EmpStat],
													LearnerEmploymentStatus.EmpId as [@EmpId],
													LearnerEmploymentStatus.DateEmpStatApp as [@DateEmpStatApp],
													case when Employers.URN is not null 
														then 'true' 
														else 'false' 
													end as [@EmpIdLookup],
													-- b65	AgreeIdLookup boolean
													case when AccountLegalEntity.PublicHashedId is not null 
														then 'true' 
														else 'false' 
													end as [@AgreeIdLookup],
													(select	EmploymentStatusMonitoring.ESMType as [@ESMType],
															EmploymentStatusMonitoring.ESMCode as [@ESMCode]
													from	Input.EmploymentStatusMonitoring
													where	EmploymentStatusMonitoring.LearnerEmploymentStatus_Id = LearnerEmploymentStatus.LearnerEmploymentStatus_Id
													for xml path ('EmploymentStatusMonitoring'), type)
											from	Input.LearnerEmploymentStatus
														left join Reference.Employers
															on Employers.URN = LearnerEmploymentStatus.EmpId
														 left join Reference.AccountLegalEntity
														 	on AccountLegalEntity.PublicHashedId = ltrim(rtrim(LearnerEmploymentStatus.AgreeId))
											where	LearnerEmploymentStatus.Learner_Id = l.Learner_Id
											for xml path ('LearnerEmploymentStatus'), type),
											(select	ContPrefCode as [@ContPrefCode],
													ContPrefType as [@ContPrefType]
											from	Input.ContactPreference
											where	Learner_Id = l.Learner_Id
											for xml path ('ContactPreference'), type),
											(select	LLDDCat as [@LLDDCat],
													PrimaryLLDD as [@PrimaryLLDD]
											from	Input.LLDDandHealthProblem
											where	Learner_Id = l.Learner_Id
											for xml path ('LLDDandHealthProblem'), type),
											(select	LearnerHE.TTACCOM as [@TTACCOM],
													LearnerHE.UCASPERID as [@UCASPERID],
													(select	FINTYPE as [@FINTYPE]
													from	Input.LearnerHEFinancialSupport
													where	LearnerHE_Id = LearnerHE.LearnerHE_Id
													for xml path ('LearnerHEFinancialSupport'), type)
											from	Input.LearnerHE
											where	LearnerHE.Learner_Id = l.Learner_Id
											for xml path ('LearnerHE'), type),
											(select	ProvSpecLearnMonOccur as [@ProvSpecLearnMonOccur]
											from	Input.ProviderSpecLearnerMonitoring
											where	Learner_Id = l.Learner_Id
											for xml path ('ProviderSpecLearnerMonitoring'), type),
											(select	LearnRefNumber as [@DP_LearnRefNumber],
													ULN as [@DP_ULN],
													(select	OutCode as [@OutCode],
															OutStartDate as [@OutStartDate],
															OutType as [@OutType]
													from	Input.DPOutcome
													where	LearnerDestinationAndProgression_Id = LearnerDestinationandProgression.LearnerDestinationAndProgression_Id
													for xml path ('DPOutcome'), type)
											from	Input.LearnerDestinationandProgression
											where	LearnerDestinationandProgression.LearnRefNumber = l.LearnRefNumber
											for xml path ('LearnerDestinationAndProgression'), type),
											(select	contractAllocationNumber as [@ContractAllocationNumber],
													fundingStreamPeriodCode as [@FundingStreamPeriodCode],
													stopNewStartsFromDate as [@StopNewStartsFromDate]
											from	Reference.vw_ContractAllocation
														left join Input.LearningDelivery
															on vw_ContractAllocation.contractAllocationNumber = LearningDelivery.ConRefNumber
											where	LearningDelivery.LearnRefNumber = l.LearnRefNumber
											for xml path ('ContractAllocation'), type)
									from	Input.Learner as l
											left join Reference.Org_PartnerUKPRN
												on Org_PartnerUKPRN.UKPRN = l.PrevUKPRN
											left join Reference.UniqueLearnerNumbers
												on UniqueLearnerNumbers.ULN = l.ULN
											left join (	select	UKPRN
														from	Reference.Org_PMUKPRN
													) as PMUKPRNLookUp
												on PMUKPRNLookUp.UKPRN = l.PMUKPRN
											left join (	select	Postcode
														from	Reference.Postcodes
													) as PCLookup
												on PCLookup.Postcode = l.Postcode
											left join (	select	Postcode
														from	Reference.Postcodes
													) as PrevPCLookup
												on PrevPCLookup.Postcode = l.PostcodePrior
											left join ( select CampusIdentifier
														from Reference.CampusIdentifier
													) as CampIdLookup
												on CampIdLookup.CampusIdentifier = L.CampId
									where	l.LearnRefNumber = ControllingTable.LearnRefNumber
									for xml path ('Learner'), type)
							from	Input.LearningProvider as lp
										cross join Reference.LARS_Current_Version as lv
										cross join Input.CollectionDetails as cd
										cross join Reference.Org_Current_Version as ocv
										left join Reference.Org_Details
											on Org_Details.UKPRN = lp.UKPRN
										left join (	select	distinct
															UKPRN,
															fundingStreamPeriodCode
													from	Reference.vw_ContractValidation
												) as Contract_ESF1420
											on Contract_ESF1420.UKPRN = lp.UKPRN
											and Contract_ESF1420.fundingStreamPeriodCode = 'ESF1420'
										left join (	select	distinct
															UKPRN,
															fundingStreamPeriodCode
													from	Reference.vw_ContractValidation
												) as Contract_LEVY1799 
											on Contract_LEVY1799.UKPRN = lp.UKPRN
											and Contract_LEVY1799.fundingStreamPeriodCode = 'LEVY1799'
										left join (	select	distinct
															UKPRN,
															fundingStreamPeriodCode
													from	Reference.vw_ContractValidation
												) as Contract_1618NLAP2018
											on Contract_1618NLAP2018.UKPRN = lp.UKPRN
											and Contract_1618NLAP2018.fundingStreamPeriodCode = '16-18NLAP2018'
										left join (	select	distinct
															UKPRN,
															fundingStreamPeriodCode
													from	Reference.vw_ContractValidation
												) as Contract_ALLBC1819
											on Contract_ALLBC1819.UKPRN = lp.UKPRN
											and Contract_ALLBC1819.fundingStreamPeriodcode = 'ALLBC1819'
										left join (	select	distinct
															UKPRN,
															fundingStreamPeriodCode
													from	Reference.vw_ContractValidation
												) as Contract_AEBC1819
											on Contract_AEBC1819.UKPRN = lp.UKPRN
											and Contract_AEBC1819.fundingStreamPeriodCode = 'AEBC1819'
										left join (	select	distinct
															UKPRN,
															fundingStreamPeriodCode
													from	Reference.vw_ContractValidation
												) as Contract_APPS1819
											on Contract_APPS1819.UKPRN = lp.UKPRN
											and Contract_APPS1819.fundingStreamPeriodCode = 'APPS1819'
										left join (	select	distinct
															UKPRN,
															fundingStreamPeriodCode
													from	Reference.vw_ContractValidation
												) as Contract_ANLAP2018
											on Contract_ANLAP2018.UKPRN = lp.UKPRN
											and Contract_ANLAP2018.fundingStreamPeriodCode = 'ANLAP2018'
										left join (	select	distinct
															UKPRN,
															fundingStreamPeriodCode
													from	Reference.vw_ContractValidation
												) as Contract_ALLB1819
											on Contract_ALLB1819.UKPRN = lp.UKPRN
											and Contract_ALLB1819.fundingStreamPeriodCode = 'ALLB1819'
										left join (	select	distinct
															UKPRN,
															fundingStreamPeriodCode
													from	Reference.vw_ContractValidation
												) as Contract_AEB_TOL1819 
											on Contract_AEB_TOL1819.UKPRN = lp.UKPRN
											and Contract_AEB_TOL1819.fundingStreamPeriodCode = 'AEB-TOL1819'
									for xml path ('global'), type))
							from	Input.Learner as ControllingTable
							where	ControllingTable.Learner_Id in (select Learner_Id from dbo.ValidLearners)
end
go

if object_id('Rulebase.VAL_Insert_global','p') is not null
begin
	drop procedure Rulebase.VAL_Insert_global
end
go

create procedure Rulebase.VAL_Insert_global (
	@EmployerVersion varchar(50),
	@LARSVersion varchar(50),
	@OrgVersion varchar(50),
	@PostcodeVersion varchar(50),
	@RulebaseVersion varchar(10),
	@UKPRN int
) as
begin
	set nocount on

	insert into Rulebase.VAL_global (
		UKPRN,
		EmployerVersion,
		LARSVersion,
		OrgVersion,
		PostcodeVersion,
		RulebaseVersion
	) values (
		@UKPRN,
		@EmployerVersion,
		@LARSVersion,
		@OrgVersion,
		@PostcodeVersion,
		@RulebaseVersion
	)
end
go

if object_id('Rulebase.VAL_Insert_Learner','p') is not null
begin
	drop procedure Rulebase.VAL_Insert_Learner
end
go

create procedure Rulebase.VAL_Insert_Learner (
	@LearnRefNumber varchar(12)
) as
begin
	set nocount on
end
go

if object_id('Rulebase.VAL_Insert_LearningDelivery','p') is not null
begin
	drop procedure Rulebase.VAL_Insert_LearningDelivery
end
go

create procedure Rulebase.VAL_Insert_LearningDelivery (
	@LearnRefNumber varchar(12),
	@AimSeqNumber int
) as
begin
	set nocount on
end
go

if object_id('Rulebase.VAL_Insert_ValidationError','p') is not null
begin
	drop procedure Rulebase.VAL_Insert_ValidationError
end
go

create procedure Rulebase.VAL_Insert_ValidationError (
	@ErrorString varchar(2000)
) as
begin
	set nocount on

	declare @xml xml = convert(xml,'<Values><value>' + replace(replace(@ErrorString,'&','&amp;'),'|', '</value><value>') + '</value></Values>')
	declare @LearnRefNumber varchar(100) = @xml.value('/Values[1]/value[1]','varchar(100)')
	declare @AimSeqNumber varchar(18) = @xml.value('/Values[1]/value[2]','varchar(18)')
	declare @RuleId varchar(50) = @xml.value('/Values[1]/value[3]','varchar(50)')
	declare @FieldValues varchar(2000) = @xml.value('/Values[1]/value[4]','varchar(2000)')

	insert into Rulebase.VAL_ValidationError (
		AimSeqNumber,
		ErrorString,
		FieldValues,
		LearnRefNumber,
		RuleId
	) values (
		@AimSeqNumber,
		@ErrorString,
		@FieldValues,
		@LearnRefNumber,
		@RuleId
	)
end
go
