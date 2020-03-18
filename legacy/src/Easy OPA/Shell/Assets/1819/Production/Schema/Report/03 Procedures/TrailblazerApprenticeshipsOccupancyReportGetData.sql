﻿ IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[TrailblazerApprenticeshipsOccupancyReportGetData]') AND type in (N'P', N'PC'))
	 DROP PROCEDURE [Report].[TrailblazerApprenticeshipsOccupancyReportGetData]
 GO

 CREATE PROCEDURE [Report].[TrailblazerApprenticeshipsOccupancyReportGetData]
	 @Page INT,
	 @PageSize INT
 AS
 BEGIN

	 SELECT [Learner reference number]
		     ,[Unique learner number]
			 ,[Date of birth]
			 ,[Pre-merger UKPRN]
			 ,[Provider specified learner monitoring (A)]
			 ,[Provider specified learner monitoring (B)]
			 ,[Aim sequence number]
			 ,[Learning aim reference]
			 ,[Learning aim title]
			 ,[Software supplier aim identifier]
			 ,[Notional NVQ level]
			 ,[Aim type]
			 ,[Apprenticeship standard code]
			 ,[Funding model]
			 ,[Funding adjustment for prior learning]
			 ,[Other funding adjustment]
			 ,CASE WHEN [Original learning start date] IS NULL THEN '' ELSE CONVERT(CHAR(19),[Original learning start date],103) END AS [Original learning start date]
			 ,CASE WHEN [Learning start date] IS NULL THEN '' ELSE CONVERT(CHAR(19),[Learning start date],103) END AS [Learning start date]
			 ,CASE WHEN [Learning planned end date] IS NULL THEN '' ELSE CONVERT(CHAR(19),[Learning planned end date],103) END AS [Learning planned end date]
			 ,[Completion status]
			 ,CASE WHEN [Learning actual end date] IS NULL THEN '' ELSE CONVERT(CHAR(19),[Learning actual end date],103) END AS [Learning actual end date]
			 ,[Outcome]
			 ,CASE WHEN [Achievement date] IS NULL THEN '' ELSE CONVERT(CHAR(19),[Achievement date],103) END AS [Achievement date]
			 ,[Learning delivery funding and monitoring type - source of funding]
			 ,[Learning delivery funding and monitoring type - eligibility for enhanced apprenticeship funding]
			 ,[Learning delivery funding and monitoring type - learning support funding (highest applicable)]
			 ,CASE WHEN [Learning delivery funding and monitoring - LSF date applies from (earliest)] IS NULL THEN '' ELSE CONVERT(CHAR(19),[Learning delivery funding and monitoring - LSF date applies from (earliest)],103) END AS [Learning delivery funding and monitoring - LSF date applies from (earliest)]
			 ,CASE WHEN [Learning delivery funding and monitoring - LSF date applies to (latest)] IS NULL THEN '' ELSE CONVERT(CHAR(19),[Learning delivery funding and monitoring - LSF date applies to (latest)],103) END AS [Learning delivery funding and monitoring - LSF date applies to (latest)]
			 ,[Learning delivery funding and monitoring type - learning delivery monitoring (A)]
			 ,[Learning delivery funding and monitoring type - learning delivery monitoring (B)]
			 ,[Learning delivery funding and monitoring type - learning delivery monitoring (C)]
			 ,[Learning delivery funding and monitoring type - learning delivery monitoring (D)]
			 ,[Learning delivery funding and monitoring type - restart indicator]
			 ,[Provider specified delivery monitoring (A)]
			 ,[Provider specified delivery monitoring (B)]
			 ,[Provider specified delivery monitoring (C)]
			 ,[Provider specified delivery monitoring (D)]
			 ,[End point assessment organisation]
			 ,[Sub contracted or partnership UKPRN]
			 ,[Delivery location postcode]
			 ,[LARS maximum core government contribution] AS   [LARS maximum core government contribution (£)]
			 ,[LARS small employer incentive] AS   [LARS small employer incentive (£)]
			 ,[LARS 16-18 year-old apprentice incentive] AS   [LARS 16-18 year-old apprentice incentive (£)]
			 ,[LARS achievement incentive] AS   [LARS achievement incentive (£)]
			 ,CASE WHEN [Applicable funding value date] IS NULL THEN '' ELSE CONVERT(CHAR(19),[Applicable funding value date],103) END AS [Applicable funding value date]
			 ,[Funding line type]
			 ,[Employer identifier on first day of standard]
			 ,[Employer identifier on small employer threshold date]
			 ,[Employer identifier on first 16-18 threshold date]
			 ,[Employer identifier on second 16-18 threshold date]
			 ,[Employer identifier on achievement date]
			 ,[Start indicator for maths, English and learning support]
			 ,[Age at start of standard]
			 ,[Eligible for 16-18 year-old apprentice incentive]
			 ,[Eligible for small employer incentive]
			 ,CASE WHEN [Applicable achievement date] IS NULL THEN '' ELSE CONVERT(CHAR(19),[Applicable achievement date],103) END AS [Applicable achievement date]
			 ,[Latest total negotiated price (TNP) 1] AS   [Latest total negotiated price (TNP) 1 (£)]
			 ,[Latest total negotiated price (TNP) 2] AS   [Latest total negotiated price (TNP) 2 (£)]
			 ,[Sum of PMRs before this funding year] AS   [Sum of PMRs before this funding year (£)]
			 ,[Sum of August payment records (PMRs)] AS   [Sum of August payment records (PMRs) (£)]
			 ,[August core government contribution] AS   [August core government contribution (£)]
			 ,[August maths and English on-programme earned cash] AS   [August maths and English on-programme earned cash (£)]
			 ,[August maths and English balancing earned cash] AS   [August maths and English balancing earned cash (£)]
			 ,[August learning support earned cash] AS   [August learning support earned cash (£)]
			 ,[August small employer incentive] AS   [August small employer incentive (£)]
			 ,[August 16-18 year-old apprentice incentive] AS   [August 16-18 year-old apprentice incentive (£)]
			 ,[August achievement incentive] AS   [August achievement incentive (£)]
			 ,[Sum of September payment records (PMRs)] AS   [Sum of September payment records (PMRs) (£)]
			 ,[September core government contribution] AS   [September core government contribution (£)]
			 ,[September maths and English on-programme earned cash] AS   [September maths and English on-programme earned cash (£)]
			 ,[September maths and English balancing earned cash] AS   [September maths and English balancing earned cash (£)]
			 ,[September learning support earned cash] AS   [September learning support earned cash (£)]
			 ,[September small employer incentive] AS   [September small employer incentive (£)]
			 ,[September 16-18 year-old apprentice incentive] AS   [September 16-18 year-old apprentice incentive (£)]
			 ,[September achievement incentive] AS   [September achievement incentive (£)]
			 ,[Sum of October payment records (PMRs)] AS   [Sum of October payment records (PMRs) (£)]
			 ,[October core government contribution] AS   [October core government contribution (£)]
			 ,[October maths and English on-programme earned cash] AS   [October maths and English on-programme earned cash (£)]
			 ,[October maths and English balancing earned cash] AS   [October maths and English balancing earned cash (£)]
			 ,[October learning support earned cash] AS   [October learning support earned cash (£)]
			 ,[October small employer incentive] AS   [October small employer incentive (£)]
			 ,[October 16-18 year-old apprentice incentive] AS   [October 16-18 year-old apprentice incentive (£)]
			 ,[October achievement incentive] AS   [October achievement incentive (£)]
			 ,[Sum of November payment records (PMRs)] AS   [Sum of November payment records (PMRs) (£)]
			 ,[November core government contribution] AS   [November core government contribution (£)]
			 ,[November maths and English on-programme earned cash] AS   [November maths and English on-programme earned cash (£)]
			 ,[November maths and English balancing earned cash] AS   [November maths and English balancing earned cash (£)]
			 ,[November learning support earned cash] AS   [November learning support earned cash (£)]
			 ,[November small employer incentive] AS   [November small employer incentive (£)]
			 ,[November 16-18 year-old apprentice incentive] AS   [November 16-18 year-old apprentice incentive (£)]
			 ,[November achievement incentive] AS   [November achievement incentive (£)]
			 ,[Sum of December payment records (PMRs)] AS   [Sum of December payment records (PMRs) (£)]
			 ,[December core government contribution] AS   [December core government contribution (£)]
			 ,[December maths and English on-programme earned cash] AS   [December maths and English on-programme earned cash (£)]
			 ,[December maths and English balancing earned cash] AS   [December maths and English balancing earned cash (£)]
			 ,[December learning support earned cash] AS   [December learning support earned cash (£)]
			 ,[December small employer incentive] AS   [December small employer incentive (£)]
			 ,[December 16-18 year-old apprentice incentive] AS   [December 16-18 year-old apprentice incentive (£)]
			 ,[December achievement incentive] AS   [December achievement incentive (£)]
			 ,[Sum of January payment records (PMRs)] AS   [Sum of January payment records (PMRs) (£)]
			 ,[January core government contribution] AS   [January core government contribution (£)]
			 ,[January maths and English on-programme earned cash] AS   [January maths and English on-programme earned cash (£)]
			 ,[January maths and English balancing earned cash] AS   [January maths and English balancing earned cash (£)]
			 ,[January learning support earned cash] AS   [January learning support earned cash (£)]
			 ,[January small employer incentive] AS   [January small employer incentive (£)]
			 ,[January 16-18 year-old apprentice incentive] AS   [January 16-18 year-old apprentice incentive (£)]
			 ,[January achievement incentive] AS   [January achievement incentive (£)]
			 ,[Sum of February payment records (PMRs)] AS   [Sum of February payment records (PMRs) (£)]
			 ,[February core government contribution] AS   [February core government contribution (£)]
			 ,[February maths and English on-programme earned cash] AS   [February maths and English on-programme earned cash (£)]
			 ,[February maths and English balancing earned cash] AS   [February maths and English balancing earned cash (£)]
			 ,[February learning support earned cash] AS   [February learning support earned cash (£)]
			 ,[February small employer incentive] AS   [February small employer incentive (£)]
			 ,[February 16-18 year-old apprentice incentive] AS   [February 16-18 year-old apprentice incentive (£)]
			 ,[February achievement incentive] AS   [February achievement incentive (£)]
			 ,[Sum of March payment records (PMRs)] AS   [Sum of March payment records (PMRs) (£)]
			 ,[March core government contribution] AS   [March core government contribution (£)]
			 ,[March maths and English on-programme earned cash] AS   [March maths and English on-programme earned cash (£)]
			 ,[March maths and English balancing earned cash] AS   [March maths and English balancing earned cash (£)]
			 ,[March learning support earned cash] AS   [March learning support earned cash (£)]
			 ,[March small employer incentive] AS   [March small employer incentive (£)]
			 ,[March 16-18 year-old apprentice incentive] AS   [March 16-18 year-old apprentice incentive (£)]
			 ,[March achievement incentive] AS   [March achievement incentive (£)]
			 ,[Sum of April payment records (PMRs)] AS   [Sum of April payment records (PMRs) (£)]
			 ,[April core government contribution] AS   [April core government contribution (£)]
			 ,[April maths and English on-programme earned cash] AS   [April maths and English on-programme earned cash (£)]
			 ,[April maths and English balancing earned cash] AS   [April maths and English balancing earned cash (£)]
			 ,[April learning support earned cash] AS   [April learning support earned cash (£)]
			 ,[April small employer incentive] AS   [April small employer incentive (£)]
			 ,[April 16-18 year-old apprentice incentive] AS   [April 16-18 year-old apprentice incentive (£)]
			 ,[April achievement incentive] AS   [April achievement incentive (£)]
			 ,[Sum of May payment records (PMRs)] AS   [Sum of May payment records (PMRs) (£)]
			 ,[May core government contribution] AS   [May core government contribution (£)]
			 ,[May maths and English on-programme earned cash] AS   [May maths and English on-programme earned cash (£)]
			 ,[May maths and English balancing earned cash] AS   [May maths and English balancing earned cash (£)]
			 ,[May learning support earned cash] AS   [May learning support earned cash (£)]
			 ,[May small employer incentive] AS   [May small employer incentive (£)]
			 ,[May 16-18 year-old apprentice incentive] AS   [May 16-18 year-old apprentice incentive (£)]
			 ,[May achievement incentive] AS   [May achievement incentive (£)]
			 ,[Sum of June payment records (PMRs)] AS   [Sum of June payment records (PMRs) (£)]
			 ,[June core government contribution] AS   [June core government contribution (£)]
			 ,[June maths and English on-programme earned cash] AS   [June maths and English on-programme earned cash (£)]
			 ,[June maths and English balancing earned cash] AS   [June maths and English balancing earned cash (£)]
			 ,[June learning support earned cash] AS   [June learning support earned cash (£)]
			 ,[June small employer incentive] AS   [June small employer incentive (£)]
			 ,[June 16-18 year-old apprentice incentive] AS   [June 16-18 year-old apprentice incentive (£)]
			 ,[June achievement incentive] AS   [June achievement incentive (£)]
			 ,[Sum of July payment records (PMRs)] AS   [Sum of July payment records (PMRs) (£)]
			 ,[July core government contribution] AS   [July core government contribution (£)]
			 ,[July maths and English on-programme earned cash] AS   [July maths and English on-programme earned cash (£)]
			 ,[July maths and English balancing earned cash] AS   [July maths and English balancing earned cash (£)]
			 ,[July learning support earned cash] AS   [July learning support earned cash (£)]
			 ,[July small employer incentive] AS   [July small employer incentive (£)]
			 ,[July 16-18 year-old apprentice incentive] AS   [July 16-18 year-old apprentice incentive (£)]
			 ,[July achievement incentive] AS   [July achievement incentive (£)]
			 ,[Total payment records (PMRs) for this funding year] AS   [Total payment records (PMRs) for this funding year (£)]
			 ,[Total core government contribution] AS   [Total core government contribution (£)]
			 ,[Total maths and English on-programme earned cash] AS   [Total maths and English on-programme earned cash (£)]
			 ,[Total maths and English balancing earned cash] AS   [Total maths and English balancing earned cash (£)]
			 ,[Total learning support earned cash] AS   [Total learning support earned cash (£)]
			 ,[Total small employer incentive] AS   [Total small employer incentive (£)]
			 ,[Total 16-18 year-old apprentice incentive] AS   [Total 16-18 year-old apprentice incentive (£)]
			 ,[Total achievement incentive] AS   [Total achievement incentive (£)]
			 ,[OFFICIAL - SENSITIVE]  
   FROM [Report].[TrailblazerApprenticeshipsOccupancyReport]	  
	 WHERE [RowNumber] BETWEEN ((@Page - 1) * @PageSize) AND (@Page * @PageSize - 1)
	 ORDER BY [RowNumber]
 END

 GO