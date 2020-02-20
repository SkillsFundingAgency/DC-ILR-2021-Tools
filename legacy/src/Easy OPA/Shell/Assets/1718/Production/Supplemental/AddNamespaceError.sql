INSERT INTO [dbo].[SchemaValidationError] (
	[ErrorMessage],
	[FieldValues],
	[LearnRefNumber],
	[RuleName],
	[Severity]
) VALUES (
	'2017-18 ILR submissions must use the namespace "SFA/ILR/2017-18".',
	'',
	NULL,
	'Namespace Mismatch',
	cast('E' AS NVARCHAR)
)