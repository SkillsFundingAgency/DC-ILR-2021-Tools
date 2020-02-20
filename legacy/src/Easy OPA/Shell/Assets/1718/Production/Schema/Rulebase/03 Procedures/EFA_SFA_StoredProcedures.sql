if object_id('[Rulebase].[EFA_SFA_Get_Cases]','p') is not null
	drop procedure [Rulebase].[EFA_SFA_Get_Cases]
go

create procedure [Rulebase].[EFA_SFA_Get_Cases] as
	begin
		select
			CaseData
		from
			[Rulebase].[EFA_SFA_Cases]
	end
GO

if object_id('[Rulebase].[EFA_SFA_Insert_Cases]','p') is not null
begin
	drop procedure [Rulebase].[EFA_SFA_Insert_Cases]
end
GO

create procedure [Rulebase].[EFA_SFA_Insert_Cases] as
begin
	set nocount on
	insert into
		[Rulebase].[EFA_SFA_Cases]
		(
			[LearnRefNumber],
			CaseData
		)
	select
		ControllingTable.[LearnRefNumber],
		convert(xml,
			(
				select
					[LearningProvider].[UKPRN] as [@UKPRN],
					(
						select
							[EFA_Learner].[AcadMonthPayment] as [@AcadMonthPayment],
							[EFA_Learner].[FundLine] as [@FundLine],
							[EFA_Learner].[LearnerActEndDate] as [@LearnerActEndDate],
							[EFA_Learner].[LearnerPlanEndDate] as [@LearnerPlanEndDate],
							[EFA_Learner].[LearnerStartDate] as [@LearnerStartDate],
							[Learner].[LearnRefNumber] as [@LearnRefNumber],
							[EFA_Learner].[OnProgPayment] as [@OnProgPayment]
						from
							[Valid].[Learner]
							left join [Rulebase].[EFA_Learner]
								on [EFA_Learner].[LearnRefNumber]=[Learner].[LearnRefNumber]
						where
							[Learner].[LearnRefNumber] = [ControllingTable].[LearnRefNumber]
						for xml path ('Learner'), type
					)
				from
					[Valid].[LearningProvider]
					cross join [Reference].[LARS_Current_Version]					
				for xml path ('global'), type
			)
		)
		from
			[Valid].[Learner] ControllingTable
	end
go

if object_id('[Rulebase].[EFA_SFA_Insert_global]','p') is not null
begin
	drop procedure [Rulebase].[EFA_SFA_Insert_global]
end
GO

create procedure [Rulebase].[EFA_SFA_Insert_global]
(
	@RulebaseVersion varchar(10),
	@UKPRN int
)
as
begin
	insert into
		[Rulebase].[EFA_SFA_global]
	values (
		@UKPRN,
		@RulebaseVersion
		)
end
go

if object_id('[Rulebase].[EFA_SFA_Insert_Learner]','p') is not null
begin
	drop procedure [Rulebase].[EFA_SFA_Insert_Learner]
end
GO

create procedure [Rulebase].[EFA_SFA_Insert_Learner]
(
	@LearnRefNumber varchar(12),
	@LnrOnProgPay decimal(10,5)
)
as
begin
	set nocount on
end
go

if object_id('[Rulebase].[EFA_SFA_Insert_Learner_PeriodisedValues]','p') is not null
begin
	drop procedure [Rulebase].[EFA_SFA_Insert_Learner_PeriodisedValues]
end
GO

create procedure [Rulebase].[EFA_SFA_Insert_Learner_PeriodisedValues]
(
	@LearnRefNumber varchar(12),
	@AttributeName varchar(100),
	@Period_1 decimal(15,5),
	@Period_2 decimal(15,5),
	@Period_3 decimal(15,5),
	@Period_4 decimal(15,5),
	@Period_5 decimal(15,5),
	@Period_6 decimal(15,5),
	@Period_7 decimal(15,5),
	@Period_8 decimal(15,5),
	@Period_9 decimal(15,5),
	@Period_10 decimal(15,5),
	@Period_11 decimal(15,5),
	@Period_12 decimal(15,5)
)
as
begin
	insert into
		[Rulebase].[EFA_SFA_Learner_PeriodisedValues]
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
	values
		(
			@LearnRefNumber,
			@AttributeName,
			@Period_1,
			@Period_2,
			@Period_3,
			@Period_4,
			@Period_5,
			@Period_6,
			@Period_7,
			@Period_8,
			@Period_9,
			@Period_10,
			@Period_11,
			@Period_12
		)
end
go

if object_id('[Rulebase].[EFA_SFA_PivotTemporals_Learner]','p') is not null
begin
	drop procedure [Rulebase].[EFA_SFA_PivotTemporals_Learner]
end
GO


create procedure [Rulebase].[EFA_SFA_PivotTemporals_Learner] as
begin
	truncate table [Rulebase].[EFA_SFA_Learner_Period]
	insert into
		[Rulebase].[EFA_SFA_Learner_Period]
	select
		LearnRefNumber,
		Period,
		max(case AttributeName when 'LnrOnProgPay' then Value else null end) LnrOnProgPay
	from
		(
			select
				LearnRefNumber,
				AttributeName,
				cast(substring(PeriodValue.Period,8,2) as int) Period,
				PeriodValue.Value
			from
				[Rulebase].[EFA_SFA_Learner_PeriodisedValues]
				unpivot (Value for Period in (Period_1,Period_2,Period_3,Period_4,Period_5,Period_6,Period_7,Period_8,Period_9,Period_10,Period_11,Period_12)) as PeriodValue
		) Bob
	group by
		LearnRefNumber,
		Period
end
go
