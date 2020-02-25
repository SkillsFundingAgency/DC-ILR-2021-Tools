IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Reference].[CollectionCalendar]') AND type in (N'U'))
DROP TABLE  [Reference].[CollectionCalendar]
GO

CREATE TABLE [Reference].[CollectionCalendar](
	[CollectionType] [varchar](20) NOT NULL,
	[CollectionReturnCode] [varchar](10) NOT NULL,
	[ProposedOpenDate] [datetime] NULL,
	[ProposedClosedDate] [datetime] NULL,
	[ActualClosedDate] [datetime] NULL,
	CONSTRAINT [PK_CollectionCalendar] PRIMARY KEY CLUSTERED 
(
	[CollectionType] ASC,
	[CollectionReturnCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

	
GO
