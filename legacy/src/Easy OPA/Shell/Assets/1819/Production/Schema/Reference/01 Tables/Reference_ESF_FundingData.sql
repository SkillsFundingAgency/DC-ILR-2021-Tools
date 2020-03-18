
 IF OBJECT_ID('Reference.ESF_FundingData') IS NOT NULL
BEGIN
    DROP TABLE  [Reference].[ESF_FundingData]
END;

CREATE TABLE [Reference].[ESF_FundingData](
	[AcademicYear] [varchar](10) NOT NULL,
	[UKPRN] [int] NOT NULL,
	[ConRefNumber] [varchar](20) NOT NULL,
	[LearnRefNumber] [varchar](12) NOT NULL,
	[AimSeqNumber] [int] NOT NULL,
	[DeliverableCode] [varchar](5) NOT NULL,
	[AttributeName] [varchar](100) NOT NULL,
	[Period_1] [decimal](15, 5) NULL,
	[Period_2] [decimal](15, 5) NULL,
	[Period_3] [decimal](15, 5) NULL,
	[Period_4] [decimal](15, 5) NULL,
	[Period_5] [decimal](15, 5) NULL,
	[Period_6] [decimal](15, 5) NULL,
	[Period_7] [decimal](15, 5) NULL,
	[Period_8] [decimal](15, 5) NULL,
	[Period_9] [decimal](15, 5) NULL,
	[Period_10] [decimal](15, 5) NULL,
	[Period_11] [decimal](15, 5) NULL,
	[Period_12] [decimal](15, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[AcademicYear] ASC,
	[UKPRN] ASC,
	[ConRefNumber] ASC,
	[LearnRefNumber] ASC,
	[AimSeqNumber] ASC,
	[DeliverableCode] ASC,
	[AttributeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
	


IF OBJECT_ID('Reference.ESF_Processed_Providers') IS NOT NULL
BEGIN
    DROP TABLE  [Reference].[ESF_Processed_Providers]
END;

CREATE TABLE [Reference].[ESF_Processed_Providers](
	[UKPRN] [int] NOT NULL,
	[OrganisationId] [varchar](10) NOT NULL,
	[ProcessedTime] [datetime] NOT NULL,
	[SourceFileName] [nvarchar](50) NULL,
	[FilePreparationDate] [date] NULL,
	[FileUploadDate] [datetime] NULL,
	[AcademicYear] [varchar](10) NULL
) ON [PRIMARY]

GO 
  GO

