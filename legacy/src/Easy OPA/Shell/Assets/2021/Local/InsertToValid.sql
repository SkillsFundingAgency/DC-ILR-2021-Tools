if object_id('[Valid].[InsertIntoValidAppFinRecord]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidAppFinRecord]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidAppFinRecord]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	-- AppFinRecord
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[AppFinRecord] ([UKPRN],[LearnRefNumber],[AimSeqNumber],[AFinType],[AFinCode],[AFinDate],[AFinAmount]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[AimSeqNumber],l.[AFinType],l.[AFinCode],l.[AFinDate],l.[AFinAmount] FROM ['+@schema+'].[AppFinRecord] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN;'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidCollectionDetails]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidCollectionDetails]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidCollectionDetails]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	-- CollectionDetails
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[CollectionDetails] ([UKPRN],[Collection],[Year],[FilePreparationDate]) SELECT l.[UKPRN],l.[Collection],l.[Year],l.[FilePreparationDate] FROM ['+@schema+'].[CollectionDetails] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN;'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidContactPreference]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidContactPreference]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidContactPreference]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	-- ContactPreference
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[ContactPreference] ([UKPRN],[LearnRefNumber],[ContPrefType],[ContPrefCode]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[ContPrefType],l.[ContPrefCode] FROM ['+@schema+'].[ContactPreference] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN;'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidDPOutcome]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidDPOutcome]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidDPOutcome]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	-- DPOutcome
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[DPOutcome] ([UKPRN],[LearnRefNumber],[OutType],[OutCode],[OutStartDate],[OutEndDate],[OutCollDate]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[OutType],l.[OutCode],l.[OutStartDate],l.[OutEndDate],l.[OutCollDate] FROM ['+@schema+'].[DPOutcome] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN;'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidEmploymentStatusMonitoring]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidEmploymentStatusMonitoring]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidEmploymentStatusMonitoring]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	-- EmploymentStatusMonitoring
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[EmploymentStatusMonitoring] ([UKPRN],[LearnRefNumber],[DateEmpStatApp],[ESMType],[ESMCode]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[DateEmpStatApp],l.[ESMType],l.[ESMCode] FROM ['+@schema+'].[EmploymentStatusMonitoring] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN;'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidLearner]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidLearner]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidLearner]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	-- Learner
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[Learner] ([UKPRN],[LearnRefNumber],[PrevLearnRefNumber],[PrevUKPRN],[PMUKPRN],[CampId],[ULN],[FamilyName],[GivenNames],[DateOfBirth],[Ethnicity],[Sex],[LLDDHealthProb],[NINumber],[PriorAttain],[Accom],[ALSCost],[PlanLearnHours],[PlanEEPHours],[MathGrade],[EngGrade],[PostcodePrior],[Postcode],[AddLine1],[AddLine2],[AddLine3],[AddLine4],[TelNo],[Email]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[PrevLearnRefNumber],l.[PrevUKPRN],l.[PMUKPRN],l.[CampId],l.[ULN],l.[FamilyName],l.[GivenNames],l.[DateOfBirth],l.[Ethnicity],l.[Sex],l.[LLDDHealthProb],l.[NINumber],l.[PriorAttain],l.[Accom],l.[ALSCost],l.[PlanLearnHours],l.[PlanEEPHours],l.[MathGrade],l.[EngGrade],l.[PostcodePrior],l.[Postcode],l.[AddLine1],l.[AddLine2],l.[AddLine3],l.[AddLine4],l.[TelNo],l.[Email] FROM ['+@schema+'].[Learner] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN;'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidLearnerDestinationandProgression]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidLearnerDestinationandProgression]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidLearnerDestinationandProgression]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--LearnerDestinationandProgression
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[LearnerDestinationandProgression] ([UKPRN],[LearnRefNumber],[ULN]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[ULN] FROM ['+@schema+'].[LearnerDestinationandProgression] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidLearnerEmploymentStatus]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidLearnerEmploymentStatus]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidLearnerEmploymentStatus]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--LearnerEmploymentStatus
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[LearnerEmploymentStatus] ([UKPRN],[LearnRefNumber],[EmpStat],[DateEmpStatApp],[EmpId]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[EmpStat],l.[DateEmpStatApp],l.[EmpId] FROM ['+@schema+'].[LearnerEmploymentStatus] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN;'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidLearnerFAM]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidLearnerFAM]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidLearnerFAM]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--LearnerFAM
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[LearnerFAM] ([UKPRN],[LearnRefNumber],[LearnFAMType],[LearnFAMCode]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[LearnFAMType],l.[LearnFAMCode] FROM ['+@schema+'].[LearnerFAM] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN;'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidLearnerHE]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidLearnerHE]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidLearnerHE]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--LearnerHE
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[LearnerHE] ([UKPRN],[LearnRefNumber],[UCASPERID],[TTACCOM]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[UCASPERID],l.[TTACCOM] FROM ['+@schema+'].[LearnerHE] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidLearnerHEFinancialSupport]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidLearnerHEFinancialSupport]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidLearnerHEFinancialSupport]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--LearnerHEFinancialSupport
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[LearnerHEFinancialSupport] ([UKPRN],[LearnRefNumber],[FINTYPE],[FINAMOUNT]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[FINTYPE],l.[FINAMOUNT] FROM ['+@schema+'].[LearnerHEFinancialSupport] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidLearningDelivery]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidLearningDelivery]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidLearningDelivery]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--LearningDelivery
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[LearningDelivery] ([UKPRN],[LearnRefNumber],[LearnAimRef],[AimType],[AimSeqNumber],[LearnStartDate],[OrigLearnStartDate],[LearnPlanEndDate],[FundModel],[PHours],[OTJActHours],[ProgType],[FworkCode],[PwayCode],[StdCode],[PartnerUKPRN],[DelLocPostCode],[LSDPostcode],[AddHours],[PriorLearnFundAdj],[OtherFundAdj],[ConRefNumber],[EPAOrgID],[EmpOutcome],[CompStatus],[LearnActEndDate],[WithdrawReason],[Outcome],[AchDate],[OutGrade],[SWSupAimId]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[LearnAimRef],l.[AimType],l.[AimSeqNumber],l.[LearnStartDate],l.[OrigLearnStartDate],l.[LearnPlanEndDate],l.[FundModel],l.[PHours],null as [OTJActHours],l.[ProgType],l.[FworkCode],l.[PwayCode],l.[StdCode],l.[PartnerUKPRN],l.[DelLocPostCode],l.[LSDPostcode],l.[AddHours],l.[PriorLearnFundAdj],l.[OtherFundAdj],l.[ConRefNumber],l.[EPAOrgID],l.[EmpOutcome],l.[CompStatus],l.[LearnActEndDate],l.[WithdrawReason],l.[Outcome],l.[AchDate],l.[OutGrade],l.[SWSupAimId] FROM ['+@schema+'].[LearningDelivery] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN;'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidLearningDeliveryFAM]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidLearningDeliveryFAM]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidLearningDeliveryFAM]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--LearningDeliveryFAM
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[LearningDeliveryFAM] ([UKPRN],[LearnRefNumber],[AimSeqNumber],[LearnDelFAMType],[LearnDelFAMCode],[LearnDelFAMDateFrom],[LearnDelFAMDateTo]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[AimSeqNumber],l.[LearnDelFAMType],l.[LearnDelFAMCode],l.[LearnDelFAMDateFrom],l.[LearnDelFAMDateTo] FROM ['+@schema+'].[LearningDeliveryFAM] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidLearningDeliveryHE]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidLearningDeliveryHE]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidLearningDeliveryHE]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--LearningDeliveryHE
	SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[LearningDeliveryHE] ([UKPRN],[LearnRefNumber],[AimSeqNumber],[NUMHUS],[SSN],[QUALENT3],[SOC2000],[SEC],[UCASAPPID],[TYPEYR],[MODESTUD],[FUNDLEV],[FUNDCOMP],[STULOAD],[YEARSTU],[MSTUFEE],[PCOLAB],[PCFLDCS],[PCSLDCS],[PCTLDCS],[SPECFEE],[NETFEE],[GROSSFEE],[DOMICILE],[ELQ],[HEPostCode]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[AimSeqNumber],l.[NUMHUS],l.[SSN],l.[QUALENT3],l.[SOC2000],l.[SEC],l.[UCASAPPID],l.[TYPEYR],l.[MODESTUD],l.[FUNDLEV],l.[FUNDCOMP],l.[STULOAD],l.[YEARSTU],l.[MSTUFEE],l.[PCOLAB],l.[PCFLDCS],l.[PCSLDCS],l.[PCTLDCS],l.[SPECFEE],l.[NETFEE],l.[GROSSFEE],l.[DOMICILE],l.[ELQ],l.[HEPostCode] FROM ['+@schema+'].[LearningDeliveryHE] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidLearningDeliveryWorkPlacement]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidLearningDeliveryWorkPlacement]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidLearningDeliveryWorkPlacement]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--LearningDeliveryWorkPlacement
	SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[LearningDeliveryWorkPlacement] ([UKPRN],[LearnRefNumber],[AimSeqNumber],[WorkPlaceStartDate],[WorkPlaceEndDate],[WorkPlaceHours],[WorkPlaceMode],[WorkPlaceEmpId]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[AimSeqNumber],l.[WorkPlaceStartDate],l.[WorkPlaceEndDate],l.[WorkPlaceHours],l.[WorkPlaceMode],l.[WorkPlaceEmpId] FROM ['+@schema+'].[LearningDeliveryWorkPlacement] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidLearningProvider]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidLearningProvider]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidLearningProvider]
(
	@schema varchar(20),
	@FModel varchar(2) = NULL
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--LearningProvider
	IF @FModel = NULL
		SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[LearningProvider] ([UKPRN]) SELECT [UKPRN] FROM ['+@schema+'].[LearningProvider]' + CHAR(13)
	ELSE
		SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[LearningProvider] ([UKPRN]) SELECT DISTINCT lp.[UKPRN] FROM ['+@schema+'].[LearningProvider] lp join ['+@schema+'].LearningDelivery ld on ld.[UKPRN] = lp.[UKPRN] WHERE ld.FundModel = '+ @FModel + CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidLLDandHealtProblem]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidLLDandHealtProblem]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidLLDandHealtProblem]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--LearningProvider
	SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[LLDDandHealthProblem] ([UKPRN],[LearnRefNumber],[LLDDCat],[PrimaryLLDD]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[LLDDCat],l.[PrimaryLLDD] FROM ['+@schema+'].[LLDDandHealthProblem] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidProviderSpecDeliveryMonitoring]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidProviderSpecDeliveryMonitoring]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidProviderSpecDeliveryMonitoring]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--ProviderSpecDeliveryMonitoring
	SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[ProviderSpecDeliveryMonitoring] ([UKPRN],[LearnRefNumber],[AimSeqNumber],[ProvSpecDelMonOccur],[ProvSpecDelMon]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[AimSeqNumber],l.[ProvSpecDelMonOccur],l.[ProvSpecDelMon] FROM ['+@schema+'].[ProviderSpecDeliveryMonitoring] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidProviderSpecLearnerMonitoring]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidProviderSpecLearnerMonitoring]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidProviderSpecLearnerMonitoring]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--ProviderSpecLearnerMonitoring
	SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[ProviderSpecLearnerMonitoring] ([UKPRN],[LearnRefNumber],[ProvSpecLearnMonOccur],[ProvSpecLearnMon]) SELECT l.[UKPRN],l.[LearnRefNumber],l.[ProvSpecLearnMonOccur],l.[ProvSpecLearnMon] FROM ['+@schema+'].[ProviderSpecLearnerMonitoring] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidSource]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidSource]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidSource]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--Source
	SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[Source] ([ProtectiveMarking],[UKPRN],[SoftwareSupplier],[SoftwarePackage],[Release],[SerialNo],[DateTime],[ReferenceData],[ComponentSetVersion]) SELECT l.[ProtectiveMarking],l.[UKPRN],l.[SoftwareSupplier],l.[SoftwarePackage],l.[Release],l.[SerialNo],l.[DateTime],l.[ReferenceData],l.[ComponentSetVersion] FROM ['+@schema+'].[Source] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN'+ CHAR(13)
	exec(@output)
END
GO

if object_id('[Valid].[InsertIntoValidSourceFile]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValidSourceFile]
end
go

CREATE PROCEDURE [Valid].[InsertIntoValidSourceFile]
(
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--SourceFile
	SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[SourceFile] ([UKPRN],[SourceFileName],[FilePreparationDate],[SoftwareSupplier],[SoftwarePackage],[Release],[SerialNo],[DateTime]) SELECT l.[UKPRN],l.[SourceFileName],l.[FilePreparationDate],l.[SoftwareSupplier],l.[SoftwarePackage],l.[Release],l.[SerialNo],l.[DateTime] FROM ['+@schema+'].[SourceFile] l inner join Valid.LearningProvider lp on lp.UKPRN = l.UKPRN'+ CHAR(13)
	exec(@output)
END 
GO 

if object_id('[Valid].[InsertIntoValid]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValid]
end
go


CREATE PROCEDURE [Valid].[InsertIntoValid]
(
	@sche varchar(20),
	@FundingModel varchar(2) = NULL
)
AS
BEGIN
	exec [Valid].[InsertIntoValidLearningProvider] @schema = @sche, @FModel = @FundingModel
	select 'Finised Inserting into LearningProvider'
	exec [Valid].[InsertIntoValidAppFinRecord] @schema = @sche
	select 'Finised Inserting into AppFinRecord'
	exec [Valid].[InsertIntoValidCollectionDetails] @schema = @sche
	select 'Finised Inserting into CollectionDetails'
	exec [Valid].[InsertIntoValidContactPreference] @schema = @sche
	select 'Finised Inserting into ContactPreference'
	exec [Valid].[InsertIntoValidDPOutcome] @schema = @sche
	select 'Finised Inserting into DPOutcome'
	exec [Valid].[InsertIntoValidEmploymentStatusMonitoring] @schema = @sche
	select 'Finised Inserting into EmploymentStatusMonitoring'
	exec [Valid].[InsertIntoValidLearner] @schema = @sche
	select 'Finised Inserting into Learner'
	exec [Valid].[InsertIntoValidLearnerDestinationandProgression] @schema = @sche
	select 'Finised Inserting into LearnerDestinationandProgression'
	exec [Valid].[InsertIntoValidLearnerEmploymentStatus] @schema = @sche
	select 'Finised Inserting into LearnerEmploymentStatus'
	exec [Valid].[InsertIntoValidLearnerFAM] @schema = @sche
	select 'Finised Inserting into LearnerFAM'
	exec [Valid].[InsertIntoValidLearnerHE] @schema = @sche
	select 'Finised Inserting into LearnerHE'
	exec [Valid].[InsertIntoValidLearnerHEFinancialSupport] @schema = @sche
	select 'Finised Inserting into LearnerHEFinancialSupport'
	exec [Valid].[InsertIntoValidLearningDelivery] @schema = @sche
	select 'Finised Inserting into LearningDelivery'
	exec [Valid].[InsertIntoValidLearningDeliveryFAM] @schema = @sche
	select 'Finised Inserting into LearningDeliveryFAM'
	exec [Valid].[InsertIntoValidLearningDeliveryHE] @schema = @sche
	select 'Finised Inserting into LearningDeliveryHE'
	exec [Valid].[InsertIntoValidLearningDeliveryWorkPlacement] @schema = @sche
	select 'Finised Inserting into LearningDeliveryWorkPlacement'
	exec [Valid].[InsertIntoValidLLDandHealtProblem] @schema = @sche
	select 'Finised Inserting into LLDandHealdthProblem'
	exec [Valid].[InsertIntoValidProviderSpecDeliveryMonitoring] @schema = @sche
	select 'Finised Inserting into ProviderSpecDeliveryMonitoring'
	exec [Valid].[InsertIntoValidProviderSpecLearnerMonitoring] @schema = @sche
	select 'Finised Inserting into ProviderSpecLearnerMonitoring'
	exec [Valid].[InsertIntoValidSource] @schema = @sche
	select 'Finised Inserting into Source'
	exec [Valid].[InsertIntoValidSourceFile] @schema = @sche
	select 'Finised Inserting into SourceFile'
	EXEC [dbo].[TransformInputToValid_LearnerEmploymentStatusDenormTbl]
	select 'Finised Inserting into LearnerEmploymentStatusDenormTbl'
	EXEC [dbo].[TransformInputToValid_LearningDeliveryDenormTbl]
	select 'Finised Inserting into LearningDeliveryDenormTbl'
	EXEC [dbo].[TransformInputToValid_LearnerDenormTbl]
	select 'Finised Inserting into LearnerDenormTbl'
END
GO