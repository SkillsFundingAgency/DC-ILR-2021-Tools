select cast((	
	select( select	SourceFileName,
					cast(FilePreparationDate as date) as FilePreparationDate,
					SoftwareSupplier,
					SoftwarePackage,
					Release,
					SerialNo,
					[DateTime]
			from	Clone.SourceFile
			where	UKPRN = ${providerID}
			for xml path('SourceFile'), type, elements) 
	for xml path('SourceFiles'), type, elements
) as varchar(max))