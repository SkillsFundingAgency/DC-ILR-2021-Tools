insert into [Static].[ErrorMessageLookUp] (
	RuleName,
	Severity,
	ErrorMessage
)
select  RuleID,
        Severity,
        ErrorMessage
from	[${ValidationMessageReferenceData.databasename}].[dbo].[ErrorMessage]
where	CollectionType = 'ILR${year}'
and		[Version] =	(select	max([Version])
					from	[${ValidationMessageReferenceData.databasename}].[dbo].[ErrorMessage]
					where	CollectionType = 'ILR${year}')
go
