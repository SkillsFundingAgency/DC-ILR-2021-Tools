IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[GetRuleViolationSummaryReportData]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [Report].[GetRuleViolationSummaryReportData]
END
GO

CREATE PROCEDURE [Report].[GetRuleViolationSummaryReportData]
AS
BEGIN
	DECLARE @FieldDefinitionValidationSource VARCHAR(50) = 'FD Validation 17_18.zip';
	DECLARE @FieldDefinitionDPValidationSource VARCHAR(50) = 'FD Validation DP 17_18.zip';

	DECLARE @ILRValidationSource VARCHAR(50) = 'Validation 17_18.zip';
	DECLARE @ILRDPValidationSource VARCHAR(50) = 'Validation DP 17_18.zip';	
	DECLARE @ILRESFValidationSource VARCHAR(50) = 'ESF Validation 17_18.zip';	

	SELECT 
		(SELECT * FROM Report.ViolationSummaryReport WITH (NOLOCK) FOR XML RAW('Totals'), TYPE, XMLSCHEMA),
		(
			SELECT RuleName, Severity, ErrorMessage, Occurrences FROM
			(
				SELECT RuleName, [Source], Severity, ErrorMessage, Count(RuleName) AS Occurrences, 1 AS UnionOrder
					FROM Report.ViolationReport WITH (NOLOCK)
					WHERE [Source] IN (@FieldDefinitionValidationSource, @FieldDefinitionDPValidationSource)
					GROUP BY RuleName, Severity, ErrorMessage,  [Source]
				UNION
				SELECT RuleName, [Source], Severity, ErrorMessage, Count(RuleName) AS Occurrences, 2 AS UnionOrder
					FROM Report.ViolationReport WITH (NOLOCK)
					WHERE [Source] IN (@ILRValidationSource, @ILRDPValidationSource, @ILRESFValidationSource)
					AND RuleName NOT LIKE 'R%'
					GROUP BY RuleName, Severity, ErrorMessage,  [Source]
				UNION
				SELECT RuleName, [Source], Severity, ErrorMessage, Count(RuleName) AS Occurrences, 3 AS UnionOrder
					FROM Report.ViolationReport WITH (NOLOCK)
					WHERE ([Source] NOT IN (@FieldDefinitionValidationSource, @FieldDefinitionDPValidationSource, @ILRValidationSource, @ILRDPValidationSource,  @ILRESFValidationSource)
						OR [Source] IS NULL) OR ([Source] IN (@ILRValidationSource, @ILRDPValidationSource, @ILRESFValidationSource)
					AND RuleName LIKE 'R%')
				GROUP BY RuleName, Severity, ErrorMessage,  [Source]
			) AS UnionTable
			ORDER BY UnionTable.UnionOrder, UnionTable.RuleName
			FOR XML RAW('ValidationMessages'), TYPE, XMLSCHEMA
		),
		(
			SELECT 
				(SELECT COUNT(*) 
				 FROM Report.ViolationReport   WITH (NOLOCK) 
				 WHERE Severity = 'E' 
				) AS TotalErrorCountResult, 
				(SELECT COUNT(*) 
				 FROM Report.ViolationReport   WITH (NOLOCK) 
				 WHERE Severity = 'W' 
				) AS TotalWarningCountResult
			FOR XML RAW('Counts'), TYPE, XMLSCHEMA
		)
	FOR XML RAW('ValidationErrorData')
END
GO