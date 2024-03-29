-- CME 23 March 2019
-- this is a MANUAL run once script for the EFA multi provider source data DB
-- MB 04/06/2018 Included reference to USE [EFATest1819]
-- updated the using statement to ensure we target the right DB
use [EFATest1920]

-- the 'operating year' is incorrect and needs to be fixed for it to work in Easy OPA
update Valid.CollectionDetails set [Year] = '1920'
go

-- schema invalid data
update Valid.Learner set PrevLearnRefNumber = null where PrevLearnRefNumber = 'PrevLearnRefNumber'	
go
update Valid.Learner set TelNo = '012345678901234567' where TelNo = 'telNumber'
update Valid.Learner set TelNo = '012345678901234567' where TelNo = '0123 456 7890'	-- apparently this isn't schema valid either...
go
update Valid.Learner set PriorAttain = null where PriorAttain = -1
go
update Valid.Learner set Email = 'dummy@mail.address' where Email = 'Email'
go

update Valid.LearningDelivery set FworkCode = null where FworkCode = -1
go
update Valid.LearningDelivery set PwayCode = null where PwayCode = -1
go
update Valid.LearningDelivery set StdCode = null where StdCode = -1
go
update Valid.LearningDelivery set PartnerUKPRN = null where PartnerUKPRN = 0
update Valid.LearningDelivery set PartnerUKPRN = null where PartnerUKPRN = -1
go
update Valid.LearningDelivery set PriorLearnFundAdj = null where PriorLearnFundAdj = 100
update Valid.LearningDelivery set PriorLearnFundAdj = null where PriorLearnFundAdj = 99
go
update Valid.LearningDelivery set EmpOutcome = null where EmpOutcome = -1
update Valid.LearningDelivery set EmpOutcome = null where EmpOutcome = 99
go

-- source cannot be empty
delete from Valid.SourceFile
go
delete from Valid.[Source]
go

-- but we only need one
insert into Valid.[Source]
	select	'OFFICIAL-SENSITIVE-Personal',
			UKPRN,
			'The Striped Lawn Company Ltd',
			'EasyOPA',
			'16.00.009.14',
			'01',
			getdate(),
			NULL,
			NULL
	from	Valid.LearningProvider
go

-- table alteration for learning delivery 1920
alter table Valid.Learner drop OTJHours
alter table Valid.LearningDelivery add LSDPostcode varchar(8), PHours bigint
go

-- this is the raft of changes required for 18-19
-- assuming the first table is present we will assume they are all done
if not exists(select name from sys.tables where name = 'AppFinRecord')
begin
	-- this table needs to be present, even though it will remain empty
	create table Valid.AppFinRecord (
		PK_AppFinRecord int identity,
		UKPRN int not null,
		LearnRefNumber varchar(12) not null,
		AimSeqNumber int not null,
		AFinType varchar(3) not null,
		AFinCode int not null,
		AFinDate date not null,
		AFinAmount int not null
	)

	-- we need to 're apply' the identity columns that form part of internal keys used in the DPS node
	alter table Valid.CollectionDetails add PK_CollectionDetails int identity
	alter table Valid.Learner add PK_Learner int identity
	alter table Valid.ContactPreference add PK_ContactPreference int identity
	alter table Valid.DPOutcome add PK_DPOutcome int identity
	alter table Valid.LearnerDestinationandProgression add PK_LearnerDestinationandProgression int identity
	alter table Valid.EmploymentStatusMonitoring add PK_EmploymentStatusMonitoring int identity
	alter table Valid.LearnerEmploymentStatus add PK_LearnerEmploymentStatus int identity, AgreeId varchar(6)
	alter table Valid.Learner add CampId varchar(8), OTJHours bigint
	alter table Valid.LearnerFAM add PK_LearnerFAM int identity
	alter table Valid.LearnerHE add PK_LearnerHE int identity
	alter table Valid.LearnerHEFinancialSupport add PK_LearnerHEFinancialSupport int identity
	alter table Valid.LearningProvider add PK_LearningProvider int identity
	alter table Valid.LLDDandHealthProblem add PK_LLDDandHealthProblem int identity
	alter table Valid.LearningDelivery add PK_LearningDelivery int identity
	alter table Valid.LearningDeliveryFAM add PK_LearningDeliveryFAM int identity
	alter table Valid.LearningDeliveryHE add PK_LearningDeliveryHE int identity
	alter table Valid.LearningDeliveryWorkPlacement add PK_LearningDeliveryWorkPlacement int identity
	alter table Valid.ProviderSpecDeliveryMonitoring add PK_ProviderSpecDeliveryMonitoring int identity
	alter table Valid.ProviderSpecLearnerMonitoring add PK_ProviderSpecLearnerMonitoring int identity
	alter table Valid.[Source] add PK_Source int identity
	alter table Valid.SourceFile add PK_SourceFile int identity
end
go
