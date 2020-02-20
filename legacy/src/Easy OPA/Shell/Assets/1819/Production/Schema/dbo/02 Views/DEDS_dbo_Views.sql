if not exists(select schema_id from sys.schemas where name='DEDS_dbo')
	exec('create schema DEDS_dbo')
go

if object_id('DEDS_dbo.ValidationError', 'v') is not null
begin
       drop view DEDS_dbo.ValidationError
end
go

create view DEDS_dbo.ValidationError
as
	select	lp.UKPRN,
			[Source],
			LearnAimRef,
			AimSeqNum,
			SWSupAimID,
			ErrorMessage,
			FieldValues,
			LearnRefNumber,
			RuleName,
			Severity,
			FileLevelError
	from	Report.ValidationError
				cross join (select top 1 UKPRN from Invalid.LearningProvider) as lp
go
