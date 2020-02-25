if not exists(select schema_id from sys.schemas where name='Rulebase')
begin
	exec('create schema Rulebase')
end
go

if object_id('Rulebase.ESFVAL_Cases','u') is not null
begin
	drop table Rulebase.ESFVAL_Cases
end
go

create table Rulebase.ESFVAL_Cases (
	Learner_Id int primary key clustered,
	CaseData xml not null
)
go

if object_id('Rulebase.ESFVAL_global','u') is not null
begin
	drop table Rulebase.ESFVAL_global
end
go

create table Rulebase.ESFVAL_global (
	UKPRN int,
	RulebaseVersion varchar(10),
)
go

if object_id('Rulebase.ESFVAL_ValidationError','u') is not null
begin
	drop table Rulebase.ESFVAL_ValidationError
end
go

create table Rulebase.ESFVAL_ValidationError (
	AimSeqNumber bigint,
	ErrorString varchar(2000),
	FieldValues varchar(2000),
	LearnRefNumber varchar(100),
	RuleId varchar(50)
)
go
