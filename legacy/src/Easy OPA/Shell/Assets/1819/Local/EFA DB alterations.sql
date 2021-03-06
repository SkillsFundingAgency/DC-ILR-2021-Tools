-- CME 22 May 2018
-- this is a MANUAL run once script for the EFA multi provider source data DB
-- MB 04/06/2018 Included reference to USE [EFATest1819]

--use [EFATest1819]

-- the 'operating year' is incorrect and needs to be fixed for it to work in Easy OPA
update Valid.CollectionDetails set [Year] = '1819'
go

-- schema invalid data
-- <PrevLearnRefNumber>PrevLearnRefNumber</PrevLearnRefNumber>
update Valid.Learner set PrevLearnRefNumber = null where PrevLearnRefNumber = 'PrevLearnRefNumber'	
go

-- <TelNo>telNumber</TelNo>
update Valid.Learner set TelNo = '012345678901234567' where TelNo = 'telNumber'
update Valid.Learner set TelNo = '012345678901234567' where TelNo = '0123 456 7890'	-- apparently this isn't schema valid either...
go

-- <PartnerUKPRN>0</PartnerUKPRN>
update Valid.LearningDelivery set PartnerUKPRN = null where PartnerUKPRN = 0						
go

-- <PriorLearnFundAdj>100</PriorLearnFundAdj>
update Valid.LearningDelivery set PriorLearnFundAdj = 99 where PriorLearnFundAdj = 100				
go

-- <EmpOutcome>99</EmpOutcome>
update Valid.LearningDelivery set EmpOutcome = 9 where EmpOutcome = 99								
go

-- <Email>Email</Email>
update Valid.Learner set Email = 'dummy@mail.address' where Email = 'Email'							
go

-- source cannot be empty
insert into Valid.[Source]
	select	'OFFICIAL-SENSITIVE-Personal',
			UKPRN,
			'The Striped Lawn Company Ltd',
			'EasyOPA',
			'15.00.005.00',
			'01',
			getdate(),
			NULL,
			NULL
	from	Valid.LearningProvider
go

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
go

-- we need to 're apply' the identity columns that form part of internal keys used in the DPS node
alter table Valid.CollectionDetails add PK_CollectionDetails int identity
go

alter table Valid.Learner add PK_Learner int identity
go

alter table Valid.ContactPreference add PK_ContactPreference int identity
go

alter table Valid.DPOutcome add PK_DPOutcome int identity
go

alter table Valid.LearnerDestinationandProgression add PK_LearnerDestinationandProgression int identity
go

alter table Valid.EmploymentStatusMonitoring add PK_EmploymentStatusMonitoring int identity
go

alter table Valid.LearnerEmploymentStatus add PK_LearnerEmploymentStatus int identity, AgreeId varchar(6)
go

alter table Valid.Learner add CampId varchar(8), OTJHours bigint
go

alter table Valid.LearnerFAM add PK_LearnerFAM int identity
go

alter table Valid.LearnerHE add PK_LearnerHE int identity
go

alter table Valid.LearnerHEFinancialSupport add PK_LearnerHEFinancialSupport int identity
go

alter table Valid.LearningProvider add PK_LearningProvider int identity
go

alter table Valid.LLDDandHealthProblem add PK_LLDDandHealthProblem int identity
go

alter table Valid.LearningDelivery add PK_LearningDelivery int identity
go

alter table Valid.LearningDeliveryFAM add PK_LearningDeliveryFAM int identity
go

alter table Valid.LearningDeliveryHE add PK_LearningDeliveryHE int identity
go

alter table Valid.LearningDeliveryWorkPlacement add PK_LearningDeliveryWorkPlacement int identity
go

alter table Valid.ProviderSpecDeliveryMonitoring add PK_ProviderSpecDeliveryMonitoring int identity
go

alter table Valid.ProviderSpecLearnerMonitoring add PK_ProviderSpecLearnerMonitoring int identity
go

alter table Valid.[Source] add PK_Source int identity
go

alter table Valid.SourceFile add PK_SourceFile int identity
go
