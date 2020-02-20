--local table truncation script
if object_id ('CleanseProcessingArea','p') is not null
begin
	drop procedure CleanseProcessingArea
end
go

create procedure CleanseProcessingArea
as
begin
	if exists(select	t.name as [table],
						v.name as [schema]
				from	sys.tables as t 
							join sys.schemas as v on v.schema_id = t.schema_id
				where	t.name = 'CollectionDetails'
				and		v.name = 'Input')
	begin
		truncate table dbo.ProcessingData
		truncate table dbo.SQLValidationError
		truncate table dbo.SchemaValidationError
		truncate table Input.CollectionDetails
		truncate table Input.[Source]
		truncate table Input.SourceFile
		truncate table Input.LearningProvider
		truncate table Input.Learner
		truncate table Input.ContactPreference
		truncate table Input.LLDDandHealthProblem
		truncate table Input.LearnerFAM
		truncate table Input.ProviderSpecLearnerMonitoring
		truncate table Input.LearnerEmploymentStatus
		truncate table Input.EmploymentStatusMonitoring
		truncate table Input.LearnerHE
		truncate table Input.LearnerHEFinancialSupport
		truncate table Input.LearningDelivery
		truncate table Input.LearningDeliveryFAM
		truncate table Input.LearningDeliveryWorkPlacement
		truncate table Input.AppFinRecord
		truncate table Input.ProviderSpecDeliveryMonitoring
		truncate table Input.LearningDeliveryHE
		truncate table Input.LearnerDestinationandProgression
		truncate table Input.DPOutcome
		truncate table Invalid.ProviderSpecLearnerMonitoring
		truncate table Invalid.LearnerEmploymentStatus
		truncate table Invalid.EmploymentStatusMonitoring
		truncate table Invalid.LearnerHE
		truncate table Invalid.LearnerHEFinancialSupport
		truncate table Invalid.LearningDelivery
		truncate table Invalid.LearningDeliveryFAM
		truncate table Invalid.LearningDeliveryWorkPlacement
		truncate table Invalid.AppFinRecord
		truncate table Invalid.ProviderSpecDeliveryMonitoring
		truncate table Invalid.LearningDeliveryHE
		truncate table Invalid.LearnerDestinationandProgression
		truncate table Invalid.DPOutcome
		truncate table Invalid.CollectionDetails
		truncate table Invalid.Source
		truncate table Invalid.SourceFile
		truncate table Invalid.LearningProvider
		truncate table Invalid.Learner
		truncate table Invalid.ContactPreference
		truncate table Invalid.LLDDandHealthProblem
		truncate table Invalid.LearnerFAM
		truncate table Reference.UniqueLearnerNumbers
		truncate table Reference.FCSContract
		truncate table Reference.LARSLARS
		truncate table Reference.PFR_EAS
		truncate table Reference.CollectionCalendar
		truncate table Reference.vw_ContractDescription
		truncate table Reference.ESF_SupplementaryData
		truncate table Reference.FCS_Deliverable_Description
		truncate table Reference.DeliverableCodeMappings
		truncate table Reference.OLASSEASResult
		truncate table Reference.PFR_OLASS
		truncate table Rulebase.VAL_Learner
		truncate table Rulebase.VAL_LearningDelivery
		truncate table Rulebase.VALDP_Cases
		truncate table Rulebase.VALDP_global
		truncate table Rulebase.VALDP_ValidationError
		truncate table Rulebase.VAL_Cases
		truncate table Rulebase.VAL_global
		truncate table Rulebase.VAL_ValidationError
		truncate table Rulebase.VALFD_ValidationError
		truncate table Rulebase.DV_Cases
		truncate table Rulebase.DV_global
		truncate table Rulebase.DV_Learner
		truncate table Rulebase.DV_LearningDelivery
		truncate table Rulebase.ESFVAL_Cases
		truncate table Rulebase.ESFVAL_global
		truncate table Rulebase.ESFVAL_ValidationError
	end

	truncate table Reference.[Version]
	truncate table Reference.ContractAllocation
	truncate table Reference.EligibilityRule
	truncate table Reference.EligibilityRuleEmploymentStatus
	truncate table Reference.EligibilityRuleLocalAuthority
	truncate table Reference.EligibilityRuleLocalEnterprisePartnership
	truncate table Reference.EligibilityRuleSectorSubjectAreaLevel
	truncate table Reference.Employers
	truncate table Reference.LARS_ApprenticeshipFunding
	truncate table Reference.LARS_AnnualValue
	truncate table Reference.LARS_Current_Version
	truncate table Reference.LARS_Framework
	truncate table Reference.LARS_FrameworkAims
	truncate table Reference.LARS_FrameworkCmnComp
	truncate table Reference.LARS_LearningDelivery
	truncate table Reference.LARS_LearningDeliveryCategory
	truncate table Reference.LARS_LearningDeliveryCategory_Children
	truncate table Reference.LARS_LearningDeliveryCategory_TopMostCategory
	truncate table Reference.LARS_Section96
	truncate table Reference.LARS_Standard
	truncate table Reference.LARS_StandardFunding
	truncate table Reference.LARS_Validity
	truncate table Reference.ONS_Postcode
	truncate table Reference.Org_Current_Version
	truncate table Reference.Org_Details
	truncate table Reference.Org_HMPP_PostCode
	truncate table Reference.Org_PartnerUKPRN
	truncate table Reference.Org_PMUKPRN
	truncate table Reference.Postcodes
	truncate table Reference.vw_ContractAllocation
	truncate table Reference.vw_ContractValidation
	truncate table Reference.EFA_PostcodeDisadvantage
	truncate table Reference.LargeEmployers
	truncate table Reference.LARS_Funding
	truncate table Reference.LARS_StandardCommonComponent
	truncate table Reference.Lot
	truncate table Reference.Org_Funding
	truncate table Reference.SFA_PostcodeAreaCost
	truncate table Reference.SFA_PostcodeDisadvantage

	truncate table Reference.AEC_LatestInYearEarningHistory
	truncate table Reference.EPAOrganisation
	truncate table Reference.ESF_FundingData
	truncate table Reference.ESF_Processed_Providers

	truncate table Rulebase.EFA_SFA_Cases
	truncate table Rulebase.EFA_SFA_global
	truncate table Rulebase.EFA_SFA_Learner_Period
	truncate table Rulebase.EFA_SFA_Learner_PeriodisedValues
	truncate table Rulebase.EFA_Cases
	truncate table Rulebase.EFA_global
	truncate table Rulebase.EFA_Learner

	truncate table Rulebase.ALB_Cases
	truncate table Rulebase.ALB_global
	truncate table Rulebase.ALB_Learner_Period
	truncate table Rulebase.ALB_Learner_PeriodisedValues
	truncate table Rulebase.ALB_LearningDelivery
	truncate table Rulebase.ALB_LearningDelivery_Period
	truncate table Rulebase.ALB_LearningDelivery_PeriodisedValues

	truncate table Rulebase.SFA_Cases
	truncate table Rulebase.SFA_global
	truncate table Rulebase.SFA_LearningDelivery
	truncate table Rulebase.SFA_LearningDeliveryPeriod
	truncate table Rulebase.SFA_LearningDelivery_Period
	truncate table Rulebase.SFA_LearningDelivery_PeriodisedValues
	truncate table Rulebase.TBL_Cases
	truncate table Rulebase.TBL_global
	truncate table Rulebase.TBL_LearningDelivery
	truncate table Rulebase.TBL_LearningDelivery_Period
	truncate table Rulebase.TBL_LearningDelivery_PeriodisedValues
	truncate table Rulebase.AEC_Cases
	truncate table Rulebase.AEC_global
	truncate table Rulebase.AEC_LearningDelivery
	truncate table Rulebase.AEC_LearningDelivery_Period
	truncate table Rulebase.AEC_LearningDelivery_PeriodisedValues
	truncate table Rulebase.AEC_LearningDelivery_PeriodisedTextValues
	truncate table Rulebase.AEC_HistoricEarningOutput
	truncate table Rulebase.AEC_ApprenticeshipPriceEpisode
	truncate table Rulebase.AEC_ApprenticeshipPriceEpisode_Period
	truncate table Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues

	truncate table Rulebase.ALB_LearningDeliveryPeriod

	truncate table Rulebase.ESF_Cases
	truncate table Rulebase.ESF_global
	truncate table Rulebase.ESF_LearningDelivery
	truncate table Rulebase.ESF_LearningDeliveryDeliverable
	truncate table Rulebase.ESF_LearningDeliveryDeliverable_Period
	truncate table Rulebase.ESF_LearningDeliveryDeliverable_PeriodisedValues
	truncate table Rulebase.ESF_DPOutcome
	truncate table Valid.CollectionDetails
	truncate table Valid.[Source]
	truncate table Valid.SourceFile
	truncate table Valid.LearningProvider
	truncate table Valid.Learner
	truncate table Valid.ContactPreference
	truncate table Valid.LLDDandHealthProblem
	truncate table Valid.LearnerFAM
	truncate table Valid.ProviderSpecLearnerMonitoring
	truncate table Valid.LearnerEmploymentStatus
	truncate table Valid.LearnerEmploymentStatusDenormTbl
	truncate table Valid.EmploymentStatusMonitoring
	truncate table Valid.LearnerHE
	truncate table Valid.LearnerHEFinancialSupport
	truncate table Valid.LearningDelivery
	truncate table Valid.LearningDeliveryDenormTbl
	truncate table Valid.LearningDeliveryFAM
	truncate table Valid.LearningDeliveryWorkPlacement
	truncate table Valid.AppFinRecord
	truncate table Valid.ProviderSpecDeliveryMonitoring
	truncate table Valid.LearningDeliveryHE
	truncate table Valid.LearnerDestinationandProgression
	truncate table Valid.DPOutcome
end
go
