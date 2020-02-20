DECLARE @EFACoFRemoval DECIMAL(9,2) = NULL
DECLARE @LargeProgrammeProportion DECIMAL(10,5) = NULL

SET @EFACoFRemoval = (
	SELECT TOP 1 [CoFRemoval]
	FROM [${EFA_CoF_Removal_Reference_Data.FullyQualified}].[${CoFRemoval.schemaname}].[ConditionOfFundingRemoval] cof
		JOIN [Input].[LearningProvider] lp ON cof.UKPRN = lp.UKPRN
	WHERE cof.EffectiveFrom <= '2018-07-31'
		AND (cof.EffectiveTo IS NULL OR cof.EffectiveTo >= '2017-08-01')
	ORDER BY cof.EffectiveFrom DESC
)

EXEC [Report].[PopulateEFAFundingClaimReport] '${ReferenceDate}', @EFACoFRemoval