
IF OBJECT_ID('Report.TrailblazerEmployerIncentives') IS NOT NULL
BEGIN
    DROP TABLE  [Report].[TrailblazerEmployerIncentives]
END;

CREATE TABLE [Report].[TrailblazerEmployerIncentives](
	[RowNumber] INT NOT NULL,
	[Employer identifier] [int] NOT NULL,
	[August small employer incentive] [decimal](38, 5) NULL,
	[August 16-18 year-old apprentice incentive] [decimal](38, 5) NULL,
	[August achievement incentive] [decimal](38, 5) NULL,
	[August total] [decimal](38, 5) NULL,
	[September small employer incentive] [decimal](38, 5) NULL,
	[September 16-18 year-old apprentice incentive] [decimal](38, 5) NULL,
	[September achievement incentive] [decimal](38, 5) NULL,
	[September total] [decimal](38, 5) NULL,
	[October small employer incentive] [decimal](38, 5) NULL,
	[October 16-18 year-old apprentice incentive] [decimal](38, 5) NULL,
	[October achievement incentive] [decimal](38, 5) NULL,
	[October total] [decimal](38, 5) NULL,
	[November small employer incentive] [decimal](38, 5) NULL,
	[November 16-18 year-old apprentice incentive] [decimal](38, 5) NULL,
	[November achievement incentive] [decimal](38, 5) NULL,
	[November total] [decimal](38, 5) NULL,
	[December small employer incentive] [decimal](38, 5) NULL,
	[December 16-18 year-old apprentice incentive] [decimal](38, 5) NULL,
	[December achievement incentive] [decimal](38, 5) NULL,
	[December total] [decimal](38, 5) NULL,
	[January small employer incentive] [decimal](38, 5) NULL,
	[January 16-18 year-old apprentice incentive] [decimal](38, 5) NULL,
	[January achievement incentive] [decimal](38, 5) NULL,
	[January total] [decimal](38, 5) NULL,
	[February small employer incentive] [decimal](38, 5) NULL,
	[February 16-18 year-old apprentice incentive] [decimal](38, 5) NULL,
	[February achievement incentive] [decimal](38, 5) NULL,
	[February total] [decimal](38, 5) NULL,
	[March small employer incentive] [decimal](38, 5) NULL,
	[March 16-18 year-old apprentice incentive] [decimal](38, 5) NULL,
	[March achievement incentive] [decimal](38, 5) NULL,
	[March total] [decimal](38, 5) NULL,
	[April small employer incentive] [decimal](38, 5) NULL,
	[April 16-18 year-old apprentice incentive] [decimal](38, 5) NULL,
	[April achievement incentive] [decimal](38, 5) NULL,
	[April total] [decimal](38, 5) NULL,
	[May small employer incentive] [decimal](38, 5) NULL,
	[May 16-18 year-old apprentice incentive] [decimal](38, 5) NULL,
	[May achievement incentive] [decimal](38, 5) NULL,
	[May total] [decimal](38, 5) NULL,
	[June small employer incentive] [decimal](38, 5) NULL,
	[June 16-18 year-old apprentice incentive] [decimal](38, 5) NULL,
	[June achievement incentive] [decimal](38, 5) NULL,
	[June total] [decimal](38, 5) NULL,
	[July small employer incentive] [decimal](38, 5) NULL,
	[July 16-18 year-old apprentice incentive] [decimal](38, 5) NULL,
	[July achievement incentive] [decimal](38, 5) NULL,
	[July total] [decimal](38, 5) NULL,
	[Total small employer incentive] [decimal](38, 5) NULL,
	[Total 16-18 year-old apprentice incentive] [decimal](38, 5) NULL,
	[Total achievement incentive] [decimal](38, 5) NULL,
	[Grand total] [decimal](38, 5) NULL,
	[OFFICIAL - SENSITIVE] [varchar](20) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


