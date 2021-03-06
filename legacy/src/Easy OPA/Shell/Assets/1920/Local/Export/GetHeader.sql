select cast((
	select (	select	[Collection],
						[Year],
						cast(FilePreparationDate as date) as FilePreparationDate
				from	Clone.CollectionDetails
				where	UKPRN = ${providerID}
				for xml path('CollectionDetails'), type, elements),
			(	select	ProtectiveMarking,
						UKPRN,
						SoftwareSupplier,
						SoftwarePackage,
						Release,
						SerialNo,
						[DateTime],
						ReferenceData,
						ComponentSetVersion
				from	Clone.[Source]
				where	UKPRN = ${providerID}
				for xml path('Source'), type, elements)
	for xml path('Header'), type, elements
) as varchar(max))