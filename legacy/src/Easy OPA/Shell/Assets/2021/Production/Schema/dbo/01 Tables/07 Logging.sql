/****** Object:  Table [dbo].[CategoryLog]    Script Date: 08/09/2015 09:21:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[CategoryLog]','u') IS NOT NULL
	DROP TABLE [dbo].[CategoryLog]
CREATE TABLE [dbo].[CategoryLog](
	[CategoryLogID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[LogID] [int] NOT NULL,
 CONSTRAINT [PK_CategoryLog] PRIMARY KEY CLUSTERED 
(
	[CategoryLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Category]    Script Date: 08/09/2015 09:21:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[Category]','u') IS NOT NULL
	DROP TABLE [dbo].[Category]
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[Log]    Script Date: 08/09/2015 09:21:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[Log]','u') IS NOT NULL
	DROP TABLE [dbo].[Log]
CREATE TABLE [dbo].[Log](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[EventID] [int] NULL,
	[Priority] [int] NOT NULL,
	[Severity] [nvarchar](32) NOT NULL,
	[Title] [nvarchar](256) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[MachineName] [nvarchar](32) NOT NULL,
	[AppDomainName] [nvarchar](512) NOT NULL,
	[ProcessID] [nvarchar](256) NOT NULL,
	[ProcessName] [nvarchar](512) NOT NULL,
	[ThreadName] [nvarchar](512) NULL,
	[Win32ThreadId] [nvarchar](128) NULL,
	[Message] [nvarchar](1500) NULL,
	[FormattedMessage] [ntext] NULL,
 CONSTRAINT [PK_Log] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Log_Archive]    Script Date: 08/09/2015 09:21:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('[dbo].[Log_Archive]','u') IS NOT NULL
	DROP TABLE [dbo].[Log_Archive]
CREATE TABLE [dbo].[Log_Archive](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[EventID] [int] NULL,
	[Priority] [int] NOT NULL,
	[Severity] [nvarchar](32) NOT NULL,
	[Title] [nvarchar](256) NOT NULL,
	[Timestamp] [datetime] NOT NULL,
	[MachineName] [nvarchar](32) NOT NULL,
	[AppDomainName] [nvarchar](512) NOT NULL,
	[ProcessID] [nvarchar](256) NOT NULL,
	[ProcessName] [nvarchar](512) NOT NULL,
	[ThreadName] [nvarchar](512) NULL,
	[Win32ThreadId] [nvarchar](128) NULL,
	[Message] [nvarchar](1500) NULL,
	[FormattedMessage] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Index [ixCategoryLog]    Script Date: 08/09/2015 09:21:34 ******/
CREATE NONCLUSTERED INDEX [ixCategoryLog] ON [dbo].[CategoryLog]
(
	[LogID] ASC,
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CategoryLog]  WITH CHECK ADD  CONSTRAINT [FK_CategoryLog_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[CategoryLog] CHECK CONSTRAINT [FK_CategoryLog_Category]
GO
ALTER TABLE [dbo].[CategoryLog]  WITH CHECK ADD  CONSTRAINT [FK_CategoryLog_Log] FOREIGN KEY([LogID])
REFERENCES [dbo].[Log] ([LogID])
GO
ALTER TABLE [dbo].[CategoryLog] CHECK CONSTRAINT [FK_CategoryLog_Log]
GO

