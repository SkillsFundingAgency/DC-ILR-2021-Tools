select cast((	
	select	UKPRN 
	from	Valid.LearningProvider 
	where	UKPRN = ${providerID}
	for	xml path('LearningProvider'), type, elements
) as varchar(max))