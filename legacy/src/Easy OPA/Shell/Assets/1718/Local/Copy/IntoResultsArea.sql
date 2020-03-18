delete from [DS_SILR_${YEAR}].[Invalid].Learner
where
	LearnRefNumber in (select LearnRefNumber from Invalid.Learner)
	and UKPRN = (select top 1 UKPRN from Invalid.LearningProvider)
go

insert into [DS_SILR_${YEAR}].Invalid.Learner
select
	*
from
	[DEDS_Invalid].Learner
go

delete from [DS_SILR_${YEAR}].Invalid.CollectionDetails
where
	UKPRN = (select top 1 UKPRN from Invalid.LearningProvider)
go

insert into [DS_SILR_${YEAR}].Invalid.CollectionDetails
select
	* 
from
	[DEDS_Invalid].CollectionDetails
go

delete from [DS_SILR_${YEAR}].Invalid.LearningProvider
where
	UKPRN = (select top 1 UKPRN from Invalid.LearningProvider)
go

insert into [DS_SILR_${YEAR}].Invalid.LearningProvider
select
	*
from
	[DEDS_Invalid].LearningProvider
go

delete from [DS_SILR_${YEAR}].Invalid.[Source]
where
	UKPRN = (select top 1 UKPRN from Invalid.[Source])
go

insert into [DS_SILR_${YEAR}].Invalid.[Source]
select
	*
from
	[DEDS_Invalid].[Source]