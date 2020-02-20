INSERT INTO [Reference].PFR_EAS (Ukprn, PaymentName, PaymentValue, CollectionPeriod)
SELECT
	sub.Ukprn,
	pay.PaymentName,
	val.PaymentValue,
	sub.CollectionPeriod
FROM [Input].LearningProvider lp
	INNER JOIN [${EAS.FullyQualified}].dbo.EAS_Submission sub(nolock) ON lp.UKPRN = sub.UKPRN
	INNER JOIN [${EAS.FullyQualified}].dbo.EAS_Submission_Values val(nolock) ON val.Submission_Id = sub.Submission_Id
		AND val.CollectionPeriod = sub.CollectionPeriod
	INNER JOIN [${EAS.FullyQualified}].dbo.Payment_Types pay(nolock) ON pay.Payment_Id = val.Payment_Id