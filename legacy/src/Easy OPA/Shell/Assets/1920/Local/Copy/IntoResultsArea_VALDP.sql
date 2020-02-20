--VALDP results copy
insert into [${TargetDataStore}].Rulebase.[VALDP_Cases]
(
	[LearnerDestinationandProgression_Id]
	,CaseData
)
select
	[LearnerDestinationandProgression_Id]
	,CaseData
from
	Rulebase.[VALDP_Cases]
go

insert into [${TargetDataStore}].Rulebase.[VALDP_global]
(
	UKPRN, 
	OrgVersion, 
	RulebaseVersion, 
	ULNVersion	
)
select
	UKPRN, 
	OrgVersion, 
	RulebaseVersion, 
	ULNVersion
from
	Rulebase.[VALDP_global]
go

insert into [${TargetDataStore}].Rulebase.[VALDP_ValidationError]
(
	ErrorString
	,FieldValues
	,LearnRefNumber
	,RuleId
)
select
	ErrorString
	,FieldValues
	,LearnRefNumber
	,RuleId
from
	Rulebase.[VALDP_ValidationError]
go