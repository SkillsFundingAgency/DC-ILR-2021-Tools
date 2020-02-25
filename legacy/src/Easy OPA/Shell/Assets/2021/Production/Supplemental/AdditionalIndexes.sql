IF INDEXPROPERTY(OBJECT_ID('[Valid].[LearningDelivery]', 'u'), 'IX_ValidLearningDelivery_ConRefNumber_AimSeqNumber', 'IndexId') IS NOT NULL
DROP INDEX [IX_ValidLearningDelivery_ConRefNumber_AimSeqNumber] ON [Valid].[LearningDelivery]
GO

CREATE NONCLUSTERED INDEX [IX_ValidLearningDelivery_ConRefNumber_AimSeqNumber] ON [Valid].[LearningDelivery]
(
	[ConRefNumber] ASC
)
INCLUDE ( 	[AimSeqNumber]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO