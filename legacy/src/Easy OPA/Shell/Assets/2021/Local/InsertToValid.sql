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
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[AppFinRecord] ([UKPRN],[LearnRefNumber],[AimSeqNumber],[AFinType],[AFinCode],[AFinDate],[AFinAmount]) SELECT [UKPRN],[LearnRefNumber],[AimSeqNumber],[AFinType],[AFinCode],[AFinDate],[AFinAmount] FROM ['+@schema+'].[AppFinRecord];'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[CollectionDetails] ([UKPRN],[Collection],[Year],[FilePreparationDate]) SELECT [UKPRN],[Collection],[Year],[FilePreparationDate] FROM ['+@schema+'].[CollectionDetails];'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[ContactPreference] ([UKPRN],[LearnRefNumber],[ContPrefType],[ContPrefCode]) SELECT [UKPRN],[LearnRefNumber],[ContPrefType],[ContPrefCode] FROM ['+@schema+'].[ContactPreference];'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[DPOutcome] ([UKPRN],[LearnRefNumber],[OutType],[OutCode],[OutStartDate],[OutEndDate],[OutCollDate]) SELECT [UKPRN],[LearnRefNumber],[OutType],[OutCode],[OutStartDate],[OutEndDate],[OutCollDate] FROM ['+@schema+'].[DPOutcome];'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[EmploymentStatusMonitoring] ([UKPRN],[LearnRefNumber],[DateEmpStatApp],[ESMType],[ESMCode]) SELECT [UKPRN],[LearnRefNumber],[DateEmpStatApp],[ESMType],[ESMCode] FROM ['+@schema+'].[EmploymentStatusMonitoring];'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[Learner] ([UKPRN],[LearnRefNumber],[PrevLearnRefNumber],[PrevUKPRN],[PMUKPRN],[CampId],[ULN],[FamilyName],[GivenNames],[DateOfBirth],[Ethnicity],[Sex],[LLDDHealthProb],[NINumber],[PriorAttain],[Accom],[ALSCost],[PlanLearnHours],[PlanEEPHours],[MathGrade],[EngGrade],[PostcodePrior],[Postcode],[AddLine1],[AddLine2],[AddLine3],[AddLine4],[TelNo],[Email]) SELECT [UKPRN],[LearnRefNumber],[PrevLearnRefNumber],[PrevUKPRN],[PMUKPRN],[CampId],[ULN],[FamilyName],[GivenNames],[DateOfBirth],[Ethnicity],[Sex],[LLDDHealthProb],[NINumber],[PriorAttain],[Accom],[ALSCost],[PlanLearnHours],[PlanEEPHours],[MathGrade],[EngGrade],[PostcodePrior],[Postcode],[AddLine1],[AddLine2],[AddLine3],[AddLine4],[TelNo],[Email] FROM ['+@schema+'].[Learner];'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[LearnerDestinationandProgression] ([UKPRN],[LearnRefNumber],[ULN]) SELECT [UKPRN],[LearnRefNumber],[ULN] FROM ['+@schema+'].[LearnerDestinationandProgression]'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[LearnerEmploymentStatus] ([UKPRN],[LearnRefNumber],[EmpStat],[DateEmpStatApp],[EmpId]) SELECT [UKPRN],[LearnRefNumber],[EmpStat],[DateEmpStatApp],[EmpId] FROM ['+@schema+'].[LearnerEmploymentStatus]'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[LearnerFAM] ([UKPRN],[LearnRefNumber],[LearnFAMType],[LearnFAMCode]) SELECT [UKPRN],[LearnRefNumber],[LearnFAMType],[LearnFAMCode] FROM ['+@schema+'].[LearnerFAM]'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[LearnerHE] ([UKPRN],[LearnRefNumber],[UCASPERID],[TTACCOM]) SELECT [UKPRN],[LearnRefNumber],[UCASPERID],[TTACCOM] FROM ['+@schema+'].[LearnerHE]'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[LearnerHEFinancialSupport] ([UKPRN],[LearnRefNumber],[FINTYPE],[FINAMOUNT]) SELECT [UKPRN],[LearnRefNumber],[FINTYPE],[FINAMOUNT] FROM ['+@schema+'].[LearnerHEFinancialSupport]'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[LearningDelivery] ([UKPRN],[LearnRefNumber],[LearnAimRef],[AimType],[AimSeqNumber],[LearnStartDate],[OrigLearnStartDate],[LearnPlanEndDate],[FundModel],[PHours],[OTJActHours],[ProgType],[FworkCode],[PwayCode],[StdCode],[PartnerUKPRN],[DelLocPostCode],[LSDPostcode],[AddHours],[PriorLearnFundAdj],[OtherFundAdj],[ConRefNumber],[EPAOrgID],[EmpOutcome],[CompStatus],[LearnActEndDate],[WithdrawReason],[Outcome],[AchDate],[OutGrade],[SWSupAimId]) SELECT [UKPRN],[LearnRefNumber],[LearnAimRef],[AimType],[AimSeqNumber],[LearnStartDate],[OrigLearnStartDate],[LearnPlanEndDate],[FundModel],[PHours],null as [OTJActHours],[ProgType],[FworkCode],[PwayCode],[StdCode],[PartnerUKPRN],[DelLocPostCode],[LSDPostcode],[AddHours],[PriorLearnFundAdj],[OtherFundAdj],[ConRefNumber],[EPAOrgID],[EmpOutcome],[CompStatus],[LearnActEndDate],[WithdrawReason],[Outcome],[AchDate],[OutGrade],[SWSupAimId] FROM ['+@schema+'].[LearningDelivery]'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + 'INSERT INTO [Valid].[LearningDeliveryFAM] ([UKPRN],[LearnRefNumber],[AimSeqNumber],[LearnDelFAMType],[LearnDelFAMCode],[LearnDelFAMDateFrom],[LearnDelFAMDateTo]) SELECT [UKPRN],[LearnRefNumber],[AimSeqNumber],[LearnDelFAMType],[LearnDelFAMCode],[LearnDelFAMDateFrom],[LearnDelFAMDateTo] FROM ['+@schema+'].[LearningDeliveryFAM]'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[LearningDeliveryHE] ([UKPRN],[LearnRefNumber],[AimSeqNumber],[NUMHUS],[SSN],[QUALENT3],[SOC2000],[SEC],[UCASAPPID],[TYPEYR],[MODESTUD],[FUNDLEV],[FUNDCOMP],[STULOAD],[YEARSTU],[MSTUFEE],[PCOLAB],[PCFLDCS],[PCSLDCS],[PCTLDCS],[SPECFEE],[NETFEE],[GROSSFEE],[DOMICILE],[ELQ],[HEPostCode]) SELECT [UKPRN],[LearnRefNumber],[AimSeqNumber],[NUMHUS],[SSN],[QUALENT3],[SOC2000],[SEC],[UCASAPPID],[TYPEYR],[MODESTUD],[FUNDLEV],[FUNDCOMP],[STULOAD],[YEARSTU],[MSTUFEE],[PCOLAB],[PCFLDCS],[PCSLDCS],[PCTLDCS],[SPECFEE],[NETFEE],[GROSSFEE],[DOMICILE],[ELQ],[HEPostCode] FROM ['+@schema+'].[LearningDeliveryHE]'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[LearningDeliveryWorkPlacement] ([UKPRN],[LearnRefNumber],[AimSeqNumber],[WorkPlaceStartDate],[WorkPlaceEndDate],[WorkPlaceHours],[WorkPlaceMode],[WorkPlaceEmpId]) SELECT [UKPRN],[LearnRefNumber],[AimSeqNumber],[WorkPlaceStartDate],[WorkPlaceEndDate],[WorkPlaceHours],[WorkPlaceMode],[WorkPlaceEmpId] FROM ['+@schema+'].[LearningDeliveryWorkPlacement]'+ CHAR(13)
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
	@schema varchar(20)
)
AS
BEGIN
	 SET NOCOUNT ON
	DECLARE @output nvarchar(max)
	--LearningProvider
	SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[LearningProvider] ([UKPRN]) SELECT [UKPRN] FROM ['+@schema+'].[LearningProvider]'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[LLDDandHealthProblem] ([UKPRN],[LearnRefNumber],[LLDDCat],[PrimaryLLDD]) SELECT [UKPRN],[LearnRefNumber],[LLDDCat],[PrimaryLLDD] FROM ['+@schema+'].[LLDDandHealthProblem]'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[ProviderSpecDeliveryMonitoring] ([UKPRN],[LearnRefNumber],[AimSeqNumber],[ProvSpecDelMonOccur],[ProvSpecDelMon]) SELECT [UKPRN],[LearnRefNumber],[AimSeqNumber],[ProvSpecDelMonOccur],[ProvSpecDelMon] FROM ['+@schema+'].[ProviderSpecDeliveryMonitoring]'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[ProviderSpecLearnerMonitoring] ([UKPRN],[LearnRefNumber],[ProvSpecLearnMonOccur],[ProvSpecLearnMon]) SELECT [UKPRN],[LearnRefNumber],[ProvSpecLearnMonOccur],[ProvSpecLearnMon] FROM ['+@schema+'].[ProviderSpecLearnerMonitoring]'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[Source] ([ProtectiveMarking],[UKPRN],[SoftwareSupplier],[SoftwarePackage],[Release],[SerialNo],[DateTime],[ReferenceData],[ComponentSetVersion]) SELECT [ProtectiveMarking],[UKPRN],[SoftwareSupplier],[SoftwarePackage],[Release],[SerialNo],[DateTime],[ReferenceData],[ComponentSetVersion] FROM ['+@schema+'].[Source]'+ CHAR(13)
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
	SELECT @output = COALESCE(@output,'') + N'INSERT INTO [Valid].[SourceFile] ([UKPRN],[SourceFileName],[FilePreparationDate],[SoftwareSupplier],[SoftwarePackage],[Release],[SerialNo],[DateTime]) SELECT [UKPRN],[SourceFileName],[FilePreparationDate],[SoftwareSupplier],[SoftwarePackage],[Release],[SerialNo],[DateTime] FROM ['+@schema+'].[SourceFile]'+ CHAR(13)
	exec(@output)
END
GO

-- SPROC to Execute All
if object_id('[Valid].[InsertIntoValid]','p') is not null
begin
	drop procedure [Valid].[InsertIntoValid]
end
go


CREATE PROCEDURE [Valid].[InsertIntoValid]
(
	@sche varchar(20)
)
AS
BEGIN
	exec [Valid].[InsertIntoValidAppFinRecord] @schema = @sche
	print('Finised Inserting into AppFinRecord')
	exec [Valid].[InsertIntoValidCollectionDetails] @schema = @sche
	print('Finised Inserting into CollectionDetails')
	exec [Valid].[InsertIntoValidContactPreference] @schema = @sche
	print('Finised Inserting into ContactPreference')
	exec [Valid].[InsertIntoValidDPOutcome] @schema = @sche
	print('Finised Inserting into DPOutcome`')
	exec [Valid].[InsertIntoValidEmploymentStatusMonitoring] @schema = @sche
	print('Finised Inserting into EmploymentStatusMonitoring`')
	exec [Valid].[InsertIntoValidLearner] @schema = @sche
	print('Finised Inserting into Learner')
	exec [Valid].[InsertIntoValidLearnerDestinationandProgression] @schema = @sche
	print('Finised Inserting into LearnerDestinationandProgression')
	exec [Valid].[InsertIntoValidLearnerEmploymentStatus] @schema = @sche
	print('Finised Inserting into LearnerEmploymentStatus')
	exec [Valid].[InsertIntoValidLearnerFAM] @schema = @sche
	print('Finised Inserting into LearnerFAM')
	exec [Valid].[InsertIntoValidLearnerHE] @schema = @sche
	print('Finised Inserting into LearnerHE')
	exec [Valid].[InsertIntoValidLearnerHEFinancialSupport] @schema = @sche
	print('Finised Inserting into LearnerHEFinancialSupport')
	exec [Valid].[InsertIntoValidLearningDelivery] @schema = @sche
	print('Finised Inserting into LearningDelivery')
	exec [Valid].[InsertIntoValidLearningDeliveryFAM] @schema = @sche
	print('Finised Inserting into LearningDeliveryFAM')
	exec [Valid].[InsertIntoValidLearningDeliveryHE] @schema = @sche
	print('Finised Inserting into LearningDeliveryHE')
	exec [Valid].[InsertIntoValidLearningDeliveryWorkPlacement] @schema = @sche
	print('Finised Inserting into LearningDeliveryWorkPlacement')
	exec [Valid].[InsertIntoValidLearningProvider] @schema = @sche
	print('Finised Inserting into LearningProvider')
	exec [Valid].[InsertIntoValidLLDandHealtProblem] @schema = @sche
	print('Finised Inserting into LLDandHealdthProblem')
	exec [Valid].[InsertIntoValidProviderSpecDeliveryMonitoring] @schema = @sche
	print('Finised Inserting into ProviderSpecDeliveryMonitoring')
	exec [Valid].[InsertIntoValidProviderSpecLearnerMonitoring] @schema = @sche
	print('Finised Inserting into ProviderSpecLearnerMonitoring')
	exec [Valid].[InsertIntoValidSource] @schema = @sche
	print('Finised Inserting into Source')
	exec [Valid].[InsertIntoValidSourceFile] @schema = @sche
	print('Finised Inserting into SourceFile')
	EXEC [dbo].[TransformInputToValid_LearnerEmploymentStatusDenormTbl]
	print('Finised Inserting into LearnerEmploymentStatusDenormTbl')
	EXEC [dbo].[TransformInputToValid_LearningDeliveryDenormTbl]
	print('Finised Inserting into LearningDeliveryDenormTbl')
END
GO