--VAL Results
insert into [${TargetDataStore}].Rulebase.[VAL_ValidationError]
(
	AimSeqNumber,
	ErrorString,
	FieldValues,
	LearnRefNumber,
	RuleId
)
select
	AimSeqNumber,
	ErrorString,
	FieldValues,
	LearnRefNumber,
	RuleId
from	
	Rulebase.[VAL_ValidationError]
go

insert into [${TargetDataStore}].Rulebase.[VAL_LearningDelivery]
(
	AimSeqNumber
)
select
	AimSeqNumber
from
	Rulebase.[VAL_LearningDelivery]
go

insert into [${TargetDataStore}].Rulebase.[VAL_Learner]
(
	LearnRefNumber
)
select
	LearnRefNumber
from
	Rulebase.[VAL_Learner]
go

insert into [${TargetDataStore}].Rulebase.[VAL_global]
(
	UKPRN, 
	EmployerVersion, 
	LARSVersion, 
	OrgVersion, 
	PostcodeVersion, 
	RulebaseVersion
)
select
	UKPRN, 
	EmployerVersion, 
	LARSVersion, 
	OrgVersion, 
	PostcodeVersion, 
	RulebaseVersion
from
	Rulebase.[VAL_global]
go

insert into [${TargetDataStore}].Rulebase.[VAL_Cases]
(
	Learner_Id,
	CaseData
)
select
	Learner_Id,
	CaseData
from
	Rulebase.[VAL_Cases]
go