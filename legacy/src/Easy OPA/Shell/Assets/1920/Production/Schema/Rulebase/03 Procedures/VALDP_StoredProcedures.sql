﻿if object_id('[Rulebase].[VALDP_Get_Cases]','p') is not null
	drop procedure [Rulebase].[VALDP_Get_Cases]
GO
-- =====================================================================================================
-- Generated by Data Dictionary Version 1.0.0.0
-- Date: 11 May 2016 12:18
-- Profile: 1516 Test Harness Validation
-- Rulebase Version: DCSS Validation DP 1617, Drop 000, Version 1617.01
-- =====================================================================================================
create procedure [Rulebase].[VALDP_Get_Cases] as

	begin
		set nocount on
		select
			CaseData
		from
			[Rulebase].[VALDP_Cases]
	end
GO
if object_id('[Rulebase].[VALDP_Insert_Cases]','p') is not null
	drop procedure [Rulebase].[VALDP_Insert_Cases]
GO
-- =====================================================================================================
-- Generated by Data Dictionary Version 1.0.0.0
-- Date: 11 May 2016 12:18
-- Profile: 1516 Test Harness Validation
-- Rulebase Version: DCSS Validation DP 1617, Drop 000, Version 1617.01
-- =====================================================================================================
create procedure [Rulebase].[VALDP_Insert_Cases] as

	begin
		set nocount on

		insert into
			[Rulebase].[VALDP_Cases]
			(
				[LearnerDestinationandProgression_Id],
				CaseData
			)
		select
			ControllingTable.[LearnerDestinationandProgression_Id],
			convert(xml,
				(
					select
						case when '${dcft.runmode}' = 'DS' then 'true' else 'false' end as [@DesktopMode],
						[CollectionDetails].[FilePreparationDate] as [@FilePreparationDate],
						[Org_Current_Version].[CurrentVersion] as [@OrgVersion],
						[LearningProvider].[UKPRN] as [@UKPRN],
						(
							select
								[LearnerDestinationandProgression].[LearnRefNumber] as [@LearnRefNumber],
								[LearnerDestinationandProgression].[ULN] as [@ULN],
								case when [UniqueLearnerNumbers].[ULN] is not null then 'true' else 'false' end as [@ULNLookup],
								(
									select
										[DPOutcome].[OutCode] as [@OutCode],
										[DPOutcome].[OutCollDate] as [@OutCollDate],
										[DPOutcome].[OutEndDate] as [@OutEndDate],
										[DPOutcome].[OutStartDate] as [@OutStartDate],
										[DPOutcome].[OutType] as [@OutType]
									from
										[Input].[DPOutcome]
									where
										[DPOutcome].[LearnerDestinationAndProgression_Id] = [LearnerDestinationandProgression].[LearnerDestinationAndProgression_Id]
									for xml path ('DPOutcome'), type
								)
							from
								[Input].[LearnerDestinationandProgression]
								left join [Reference].[UniqueLearnerNumbers]
									on [UniqueLearnerNumbers].[ULN]=[LearnerDestinationandProgression].[ULN]
							where
								[LearnerDestinationandProgression].[LearnRefNumber] = [ControllingTable].[LearnRefNumber]
							for xml path ('LearnerDestinationAndProgression'), type
						)
					from
						[Input].[LearningProvider]
						cross join [Input].[CollectionDetails]
						cross join [Reference].[Org_Current_Version]
					for xml path ('global'), type
				)
			)
		from
			[Input].[LearnerDestinationandProgression] ControllingTable
		where
			[ControllingTable].[LearnerDestinationandProgression_Id] in (select LearnerDestinationandProgression_Id from dbo.ValidLearnerDestinationandProgressions)
	end
GO
if object_id('[Rulebase].[VALDP_Insert_global]','p') is not null
	drop procedure [Rulebase].[VALDP_Insert_global]
GO
-- =====================================================================================================
-- Generated by Data Dictionary Version 1.0.0.0
-- Date: 11 May 2016 12:18
-- Profile: 1516 Test Harness Validation
-- Rulebase Version: DCSS Validation DP 1617, Drop 000, Version 1617.01
-- =====================================================================================================
create procedure [Rulebase].[VALDP_Insert_global]
	(
		@UKPRN int,
		@OrgVersion varchar(50),
		@RulebaseVersion varchar(10),
		@ULNVersion varchar(50)
	)
as
	begin
		set nocount on
		insert into
			[Rulebase].[VALDP_global]
		values (
			@UKPRN,
			@OrgVersion,
			@RulebaseVersion,
			@ULNVersion
		)
	end
GO
if object_id('[Rulebase].[VALDP_Insert_ValidationError]','p') is not null
	drop procedure [Rulebase].[VALDP_Insert_ValidationError]
GO
-- =====================================================================================================
-- Generated by Data Dictionary Version 1.0.0.0
-- Date: 11 May 2016 12:18
-- Profile: 1516 Test Harness Validation
-- Rulebase Version: DCSS Validation DP 1617, Drop 000, Version 1617.01
-- =====================================================================================================
create procedure [Rulebase].[VALDP_Insert_ValidationError]
	(
		@ErrorString varchar(2000)
	)
as
	begin
		set nocount on
		declare @xml xml = convert(xml,'<Values><value>' + replace(replace(@ErrorString,'&','&amp;'),'|', '</value><value>') + '</value></Values>')
		declare @LearnRefNumber varchar(100) = @xml.value('/Values[1]/value[1]','varchar(100)')
		declare @RuleId varchar(50) = @xml.value('/Values[1]/value[2]','varchar(50)')
		declare @FieldValues varchar(2000) = @xml.value('/Values[1]/value[3]','varchar(2000)')
		insert into
			[Rulebase].[VALDP_ValidationError]
		values (
			@ErrorString,
			@FieldValues,
			@LearnRefNumber,
			@RuleId
		)
	end
GO
