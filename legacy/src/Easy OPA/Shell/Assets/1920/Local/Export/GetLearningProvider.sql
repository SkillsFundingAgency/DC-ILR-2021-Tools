select cast((	
	select	UKPRN 
	from	Clone.LearningProvider 
	where	UKPRN = ${providerID}
	for	xml path('LearningProvider'), type, elements
) as varchar(max))