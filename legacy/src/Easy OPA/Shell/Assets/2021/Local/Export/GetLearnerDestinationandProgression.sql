select	coalesce(cast((	
	select	LearnRefNumber, 
			ULN,
			(	select	OutType,
						OutCode,
						cast(OutStartDate as date) OutStartDate,
						cast(OutEndDate as date) OutEndDate,
						cast(OutCollDate as date) OutCollDate 
				from	Valid.DPOutcome 
				where	UKPRN = ${providerID} 
				and		FK_LearnerDestinationandProgression = PK_LearnerDestinationandProgression 
				for xml path('DPOutcome'), type, elements) 
	from	Valid.LearnerDestinationandProgression
	where	UKPRN = ${providerID}
	for xml path('LearnerDestinationandProgression'), type, elements
) as varchar(max)), '')
