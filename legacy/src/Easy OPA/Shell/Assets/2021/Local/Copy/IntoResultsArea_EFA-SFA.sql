--EFA_SFA_Results_Copy
insert into [${TargetDataStore}].Rulebase.[EFA_SFA_Cases]
(
	LearnRefNumber
	,CaseData
)
select
	LearnRefNumber
	,CaseData
from
	Rulebase.[EFA_SFA_Cases]
go

insert into [${TargetDataStore}].Rulebase.[EFA_SFA_Learner_Period]
(
	LearnRefNumber
	,[Period]
	,LnrOnProgPay
)
select
	LearnRefNumber
	,[Period]
	,LnrOnProgPay
from
	Rulebase.[EFA_SFA_Learner_Period]
go

insert into [${TargetDataStore}].Rulebase.[EFA_SFA_Learner_PeriodisedValues]
(
	LearnRefNumber, 
	AttributeName, 
	Period_1, 
	Period_2, 
	Period_3, 
	Period_4, 
	Period_5, 
	Period_6, 
	Period_7, 
	Period_8, 
	Period_9, 
	Period_10, 
	Period_11, 
	Period_12
)
select
	LearnRefNumber, 
	AttributeName, 
	Period_1, 
	Period_2, 
	Period_3, 
	Period_4, 
	Period_5, 
	Period_6, 
	Period_7, 
	Period_8, 
	Period_9, 
	Period_10, 
	Period_11, 
	Period_12
from
	Rulebase.[EFA_SFA_Learner_PeriodisedValues]
go

insert into [${TargetDataStore}].Rulebase.[EFA_SFA_global]
(
	UKPRN
	,RulebaseVersion
)
select
	UKPRN
	,RulebaseVersion
from
	Rulebase.[EFA_SFA_global]
go