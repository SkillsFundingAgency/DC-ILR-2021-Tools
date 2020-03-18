
IF OBJECT_ID('FileDetails') IS NOT NULL
BEGIN
    DROP TABLE [dbo].[FileDetails]
END;


CREATE TABLE [dbo].[FileDetails](
    [ID] [int] IDENTITY(1,1),
	[UKPRN] [int] NOT NULL,
	[Filename] [nvarchar](50) NULL,
	[FileSizeKb] [bigint] NULL,
	[TotalLearnersSubmitted] [int] NULL,
	[TotalValidLearnersSubmitted] [int] NULL,
	[TotalInvalidLearnersSubmitted] [int] NULL,
	[TotalErrorCount] [int] NULL,
	[TotalWarningCount] [int] NULL,
	[SubmittedTime] [datetime] NULL,
	[Success] [bit]
 CONSTRAINT [PK_dbo.FileDetails] UNIQUE
(
	[UKPRN],[Filename],[Success] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]





