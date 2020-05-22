if object_id('[Valid].[AcademicYearUplift]','p') is not null
begin
	drop procedure [Valid].[AcademicYearUplift]
end
go

CREATE PROCEDURE [Valid].[AcademicYearUplift]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

	UPDATE Valid.AppFinRecord
		SET AFinDate = DATEADD(YEAR,1,AFinDate);
	PRINT('Updated date AppFinRecord');

	UPDATE Valid.Learner
		SET DateOfBirth = DATEADD(YEAR,1,DateOfBirth);
	PRINT ('Updated date Learner');
	
	UPDATE Valid.LearnerEmploymentStatus
		SET DateEmpStatApp = DATEADD(YEAR,1,DateEmpStatApp);
	PRINT('Updated dates LearnerEmploymentStatus');
	
	UPDATE [Valid].[DPOutcome]
		SET OutCollDate = DATEADD(YEAR,1,OutCollDate)
			,OutEndDate = DATEADD(YEAR,1,OutEndDate)
			,OutStartDate = DATEADD(YEAR,1,OutStartDate);
    PRINT('Updated dates DPOutcome');

	UPDATE [Valid].EmploymentStatusMonitoring
		SET DateEmpStatApp = DATEADD(YEAR,1,DateEmpStatApp);
	PRINT('Updated dates EmploymentStatusMontoring');

	UPDATE [Valid].LearningDelivery
		SET [LearnStartDate]	   = DATEADD(YEAR,1,[LearnStartDate])
			,[OrigLearnStartDate]  = DATEADD(YEAR,1,[OrigLearnStartDate])
			,[LearnPlanEndDate]	   = DATEADD(YEAR,1,[LearnPlanEndDate])
			,[LearnActEndDate]	   = DATEADD(YEAR,1,[LearnActEndDate])
			,[AchDate]			   = DATEADD(YEAR,1,[AchDate]);
	PRINT('Updated dates LearningDelivery');

	UPDATE [Valid].LearningDeliveryFAM
		SET LearnDelFAMDateFrom = DATEADD(YEAR,1,LearnDelFAMDateFrom)
			,LearnDelFAMDateTo	 = DATEADD(YEAR,1,LearnDelFAMDateTo);
	PRINT('Updated dates LearningDeliveryFam');

	UPDATE [Valid].LearningDeliveryWorkPlacement
		SET WorkPlaceStartDate = DATEADD(YEAR,1,WorkPlaceStartDate)
			,WorkPlaceEndDate = DATEADD(YEAR,1,WorkPlaceEndDate);
	PRINT('Updated dates LearningDeliveryWorkPlacement');


END
GO