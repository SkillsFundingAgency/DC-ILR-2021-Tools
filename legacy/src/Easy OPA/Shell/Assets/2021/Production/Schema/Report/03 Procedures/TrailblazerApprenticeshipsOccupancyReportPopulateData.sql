 IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[TrailblazerApprenticeshipsOccupancyReportPopulateData]') AND type in (N'P', N'PC'))
	 DROP PROCEDURE [Report].[TrailblazerApprenticeshipsOccupancyReportPopulateData]
 GO

 CREATE PROCEDURE [Report].[TrailblazerApprenticeshipsOccupancyReportPopulateData]	
 AS
 BEGIN	
	
	 TRUNCATE TABLE [Report].[TrailblazerApprenticeshipsOccupancyReport]

	 INSERT INTO [Report].[TrailblazerApprenticeshipsOccupancyReport]
            ([RowNumber]
		    ,[Learner reference number]
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
            ,[Original learning start date]
            ,[Learning start date]
            ,[Learning planned end date]
            ,[Completion status]
            ,[Learning actual end date]
            ,[Outcome]
            ,[Achievement date]
            ,[Learning delivery funding and monitoring type - source of funding]
            ,[Learning delivery funding and monitoring type - eligibility for enhanced apprenticeship funding]
            ,[Learning delivery funding and monitoring type - learning support funding (highest applicable)]
            ,[Learning delivery funding and monitoring - LSF date applies from (earliest)]
            ,[Learning delivery funding and monitoring - LSF date applies to (latest)]
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
            ,[LARS maximum core government contribution]
            ,[LARS small employer incentive]
            ,[LARS 16-18 year-old apprentice incentive]
            ,[LARS achievement incentive]
            ,[Applicable funding value date]
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
            ,[Applicable achievement date]
            ,[Latest total negotiated price (TNP) 1]
            ,[Latest total negotiated price (TNP) 2]
            ,[Sum of PMRs before this funding year]
            ,[Sum of August payment records (PMRs)]
            ,[August core government contribution]
            ,[August maths and English on-programme earned cash]
            ,[August maths and English balancing earned cash]
            ,[August learning support earned cash]
            ,[August small employer incentive]
            ,[August 16-18 year-old apprentice incentive]
            ,[August achievement incentive]
            ,[Sum of September payment records (PMRs)]
            ,[September core government contribution]
            ,[September maths and English on-programme earned cash]
            ,[September maths and English balancing earned cash]
            ,[September learning support earned cash]
            ,[September small employer incentive]
            ,[September 16-18 year-old apprentice incentive]
            ,[September achievement incentive]
            ,[Sum of October payment records (PMRs)]
            ,[October core government contribution]
            ,[October maths and English on-programme earned cash]
            ,[October maths and English balancing earned cash]
            ,[October learning support earned cash]
            ,[October small employer incentive]
            ,[October 16-18 year-old apprentice incentive]
            ,[October achievement incentive]
            ,[Sum of November payment records (PMRs)]
            ,[November core government contribution]
            ,[November maths and English on-programme earned cash]
            ,[November maths and English balancing earned cash]
            ,[November learning support earned cash]
            ,[November small employer incentive]
            ,[November 16-18 year-old apprentice incentive]
            ,[November achievement incentive]
            ,[Sum of December payment records (PMRs)]
            ,[December core government contribution]
            ,[December maths and English on-programme earned cash]
            ,[December maths and English balancing earned cash]
            ,[December learning support earned cash]
            ,[December small employer incentive]
            ,[December 16-18 year-old apprentice incentive]
            ,[December achievement incentive]
            ,[Sum of January payment records (PMRs)]
            ,[January core government contribution]
            ,[January maths and English on-programme earned cash]
            ,[January maths and English balancing earned cash]
            ,[January learning support earned cash]
            ,[January small employer incentive]
            ,[January 16-18 year-old apprentice incentive]
            ,[January achievement incentive]
            ,[Sum of February payment records (PMRs)]
            ,[February core government contribution]
            ,[February maths and English on-programme earned cash]
            ,[February maths and English balancing earned cash]
            ,[February learning support earned cash]
            ,[February small employer incentive]
            ,[February 16-18 year-old apprentice incentive]
            ,[February achievement incentive]
            ,[Sum of March payment records (PMRs)]
            ,[March core government contribution]
            ,[March maths and English on-programme earned cash]
            ,[March maths and English balancing earned cash]
            ,[March learning support earned cash]
            ,[March small employer incentive]
            ,[March 16-18 year-old apprentice incentive]
            ,[March achievement incentive]
            ,[Sum of April payment records (PMRs)]
            ,[April core government contribution]
            ,[April maths and English on-programme earned cash]
            ,[April maths and English balancing earned cash]
            ,[April learning support earned cash]
            ,[April small employer incentive]
            ,[April 16-18 year-old apprentice incentive]
            ,[April achievement incentive]
            ,[Sum of May payment records (PMRs)]
            ,[May core government contribution]
            ,[May maths and English on-programme earned cash]
            ,[May maths and English balancing earned cash]
            ,[May learning support earned cash]
            ,[May small employer incentive]
            ,[May 16-18 year-old apprentice incentive]
            ,[May achievement incentive]
            ,[Sum of June payment records (PMRs)]
            ,[June core government contribution]
            ,[June maths and English on-programme earned cash]
            ,[June maths and English balancing earned cash]
            ,[June learning support earned cash]
            ,[June small employer incentive]
            ,[June 16-18 year-old apprentice incentive]
            ,[June achievement incentive]
            ,[Sum of July payment records (PMRs)]
            ,[July core government contribution]
            ,[July maths and English on-programme earned cash]
            ,[July maths and English balancing earned cash]
            ,[July learning support earned cash]
            ,[July small employer incentive]
            ,[July 16-18 year-old apprentice incentive]
            ,[July achievement incentive]
            ,[Total payment records (PMRs) for this funding year]
            ,[Total core government contribution]
            ,[Total maths and English on-programme earned cash]
            ,[Total maths and English balancing earned cash]
            ,[Total learning support earned cash]
            ,[Total small employer incentive]
            ,[Total 16-18 year-old apprentice incentive]
            ,[Total achievement incentive]
            ,[OFFICIAL - SENSITIVE])
	 SELECT 
		  [RowNumber] 
		 ,[Learner reference number]
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
		 ,[Original learning start date]
		 ,[Learning start date]
		 ,[Learning planned end date]
		 ,[Completion status]
		 ,[Learning actual end date]
		 ,[Outcome]
		 ,[Achievement date]
		 ,[Learning delivery funding and monitoring type - source of funding]
		 ,[Learning delivery funding and monitoring type - eligibility for enhanced apprenticeship funding]

		 ,[Learning delivery funding and monitoring type - learning support funding (highest applicable)]
		 ,[Learning delivery funding and monitoring - LSF date applies from (earliest)]
		 ,[Learning delivery funding and monitoring - LSF date applies to (latest)]

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

		 ,ROUND([LARS maximum core government contribution], 2)				AS [LARS maximum core government contribution]
		 ,ROUND([LARS small employer incentive], 2)							AS [LARS small employer incentive]
		 ,ROUND([LARS 16-18 year-old apprentice incentive], 2)				AS [LARS 16-18 year-old apprentice incentive]
		 ,ROUND([LARS achievement incentive], 2)								AS [LARS achievement incentive]

		 ,[Applicable funding value date]
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
		 ,[Applicable achievement date]

	 -------------------------------------------------------------------------------
	 -- Latest  Totals
	 -------------------------------------------------------------------------------

		 ,ROUND([Latest total negotiated price (TNP) 1], 2)		AS [Latest total negotiated price (TNP) 1]
		 ,ROUND([Latest total negotiated price (TNP) 2], 2)		AS [Latest total negotiated price (TNP) 2]

	 -------------------------------------------------------------------------------
	 -- Previous Year Totals
	 -------------------------------------------------------------------------------

		 ,ROUND([Sum of PMRs before this funding year], 2)					AS [Sum of PMRs before this funding year]

	 -------------------------------------------------------------------------------
	 -- August
	 -------------------------------------------------------------------------------

		 ,ROUND([Sum of August payment records (PMRs)], 2)					AS [Sum of August payment records (PMRs)]

		 ,ROUND([August core government contribution], 2)					AS [August core government contribution]
		 ,ROUND([August maths and English on-programme earned cash], 2)		AS [August maths and English on-programme earned cash]
		 ,ROUND([August maths and English balancing earned cash], 2)			AS [August maths and English balancing earned cash]
		 ,ROUND([August learning support earned cash], 2)					AS [August learning support earned cash]
		 ,ROUND([August small employer incentive], 2)						AS [August small employer incentive]
		 ,ROUND([August 16-18 year-old apprentice incentive], 2)				AS [August 16-18 year-old apprentice incentive]
		 ,ROUND([August achievement incentive], 2)							AS [August achievement incentive]

	 -------------------------------------------------------------------------------
	 -- September
	 -------------------------------------------------------------------------------

		 ,ROUND([Sum of September payment records (PMRs)], 2)				AS [Sum of September payment records (PMRs)]

		 ,ROUND([September core government contribution], 2)					AS [September core government contribution]
		 ,ROUND([September maths and English on-programme earned cash], 2)	AS [September maths and English on-programme earned cash]
		 ,ROUND([September maths and English balancing earned cash], 2)		AS [September maths and English balancing earned cash]
		 ,ROUND([September learning support earned cash], 2)					AS [September learning support earned cash]
		 ,ROUND([September small employer incentive], 2)						AS [September small employer incentive]
		 ,ROUND([September 16-18 year-old apprentice incentive], 2)			AS [September 16-18 year-old apprentice incentive]
		 ,ROUND([September achievement incentive], 2)						AS [September achievement incentive]

	 -------------------------------------------------------------------------------
	 -- October
	 -------------------------------------------------------------------------------

		 ,ROUND([Sum of October payment records (PMRs)], 2)					AS [Sum of October payment records (PMRs)]

		 ,ROUND([October core government contribution], 2)					AS [October core government contribution]
		 ,ROUND([October maths and English on-programme earned cash], 2)		AS [October maths and English on-programme earned cash]
		 ,ROUND([October maths and English balancing earned cash], 2)		AS [October maths and English balancing earned cash]
		 ,ROUND([October learning support earned cash], 2)					AS [October learning support earned cash]
		 ,ROUND([October small employer incentive], 2)						AS [October small employer incentive]
		 ,ROUND([October 16-18 year-old apprentice incentive], 2)			AS [October 16-18 year-old apprentice incentive]
		 ,ROUND([October achievement incentive], 2)							AS [October achievement incentive]

	 -------------------------------------------------------------------------------
	 -- November
	 -------------------------------------------------------------------------------

		 ,ROUND([Sum of November payment records (PMRs)], 2)					AS [Sum of November payment records (PMRs)]

		 ,ROUND([November core government contribution], 2)					AS [November core government contribution]
		 ,ROUND([November maths and English on-programme earned cash], 2)	AS [November maths and English on-programme earned cash]
		 ,ROUND([November maths and English balancing earned cash], 2)		AS [November maths and English balancing earned cash]
		 ,ROUND([November learning support earned cash], 2)					AS [November learning support earned cash]
		 ,ROUND([November small employer incentive], 2)						AS [November small employer incentive]
		 ,ROUND([November 16-18 year-old apprentice incentive], 2)			AS [November 16-18 year-old apprentice incentive]
		 ,ROUND([November achievement incentive], 2)							AS [November achievement incentive]

	 -------------------------------------------------------------------------------
	 -- December
	 -------------------------------------------------------------------------------

		 ,ROUND([Sum of December payment records (PMRs)], 2)					AS [Sum of December payment records (PMRs)]

		 ,ROUND([December core government contribution], 2)					AS [December core government contribution]
		 ,ROUND([December maths and English on-programme earned cash], 2)	AS [December maths and English on-programme earned cash]
		 ,ROUND([December maths and English balancing earned cash], 2)		AS [December maths and English balancing earned cash]
		 ,ROUND([December learning support earned cash], 2)					AS [December learning support earned cash]
		 ,ROUND([December small employer incentive], 2)						AS [December small employer incentive]
		 ,ROUND([December 16-18 year-old apprentice incentive], 2)			AS [December 16-18 year-old apprentice incentive]
		 ,ROUND([December achievement incentive], 2)							AS [December achievement incentive]

	 -------------------------------------------------------------------------------
	 -- January
	 -------------------------------------------------------------------------------

		 ,ROUND([Sum of January payment records (PMRs)], 2)					AS [Sum of January payment records (PMRs)]

		 ,ROUND([January core government contribution], 2)					AS [January core government contribution]
		 ,ROUND([January maths and English on-programme earned cash], 2)		AS [January maths and English on-programme earned cash]
		 ,ROUND([January maths and English balancing earned cash], 2)		AS [January maths and English balancing earned cash]
		 ,ROUND([January learning support earned cash], 2)					AS [January learning support earned cash]
		 ,ROUND([January small employer incentive], 2)						AS [January small employer incentive]
		 ,ROUND([January 16-18 year-old apprentice incentive], 2)			AS [January 16-18 year-old apprentice incentive]
		 ,ROUND([January achievement incentive], 2)							AS [January achievement incentive]

	 -------------------------------------------------------------------------------
	 -- February
	 -------------------------------------------------------------------------------

		 ,ROUND([Sum of February payment records (PMRs)], 2)					AS [Sum of February payment records (PMRs)]

		 ,ROUND([February core government contribution], 2)					AS [February core government contribution]
		 ,ROUND([February maths and English on-programme earned cash], 2)	AS [February maths and English on-programme earned cash]
		 ,ROUND([February maths and English balancing earned cash], 2)		AS [February maths and English balancing earned cash]
		 ,ROUND([February learning support earned cash], 2)					AS [February learning support earned cash]
		 ,ROUND([February small employer incentive], 2)						AS [February small employer incentive]
		 ,ROUND([February 16-18 year-old apprentice incentive], 2)			AS [February 16-18 year-old apprentice incentive]
		 ,ROUND([February achievement incentive], 2)							AS [February achievement incentive]

	 -------------------------------------------------------------------------------
	 -- March
	 -------------------------------------------------------------------------------

		 ,ROUND([Sum of March payment records (PMRs)], 2)					AS [Sum of March payment records (PMRs)]

		 ,ROUND([March core government contribution], 2)						AS [March core government contribution]
		 ,ROUND([March maths and English on-programme earned cash], 2)		AS [March maths and English on-programme earned cash]
		 ,ROUND([March maths and English balancing earned cash], 2)			AS [March maths and English balancing earned cash]
		 ,ROUND([March learning support earned cash], 2)						AS [March learning support earned cash]
		 ,ROUND([March small employer incentive], 2)							AS [March small employer incentive]
		 ,ROUND([March 16-18 year-old apprentice incentive], 2)				AS [March 16-18 year-old apprentice incentive]
		 ,ROUND([March achievement incentive], 2)							AS [March achievement incentive]

	 -------------------------------------------------------------------------------
	 -- April
	 -------------------------------------------------------------------------------

		 ,ROUND([Sum of April payment records (PMRs)], 2)					AS [Sum of April payment records (PMRs)]

		 ,ROUND([April core government contribution], 2)						AS [April core government contribution]
		 ,ROUND([April maths and English on-programme earned cash], 2)		AS [April maths and English on-programme earned cash]
		 ,ROUND([April maths and English balancing earned cash], 2)			AS [April maths and English balancing earned cash]
		 ,ROUND([April learning support earned cash], 2)						AS [April learning support earned cash]
		 ,ROUND([April small employer incentive], 2)							AS [April small employer incentive]
		 ,ROUND([April 16-18 year-old apprentice incentive], 2)				AS [April 16-18 year-old apprentice incentive]
		 ,ROUND([April achievement incentive], 2)							AS [April achievement incentive]

	 -------------------------------------------------------------------------------
	 -- May
	 -------------------------------------------------------------------------------

		 ,ROUND([Sum of May payment records (PMRs)], 2)						AS [Sum of May payment records (PMRs)]

		 ,ROUND([May core government contribution], 2)						AS [May core government contribution]
		 ,ROUND([May maths and English on-programme earned cash], 2)			AS [May maths and English on-programme earned cash]
		 ,ROUND([May maths and English balancing earned cash], 2)			AS [May maths and English balancing earned cash]
		 ,ROUND([May learning support earned cash], 2)						AS [May learning support earned cash]
		 ,ROUND([May small employer incentive], 2)							AS [May small employer incentive]
		 ,ROUND([May 16-18 year-old apprentice incentive], 2)				AS [May 16-18 year-old apprentice incentive]
		 ,ROUND([May achievement incentive], 2)								AS [May achievement incentive]

	 -------------------------------------------------------------------------------
	 -- June
	 -------------------------------------------------------------------------------

		 ,ROUND([Sum of June payment records (PMRs)], 2)						AS [Sum of June payment records (PMRs)]

		 ,ROUND([June core government contribution], 2)						AS [June core government contribution]
		 ,ROUND([June maths and English on-programme earned cash], 2)		AS [June maths and English on-programme earned cash]
		 ,ROUND([June maths and English balancing earned cash], 2)			AS [June maths and English balancing earned cash]
		 ,ROUND([June learning support earned cash], 2)						AS [June learning support earned cash]
		 ,ROUND([June small employer incentive], 2)							AS [June small employer incentive]
		 ,ROUND([June 16-18 year-old apprentice incentive], 2)				AS [June 16-18 year-old apprentice incentive]
		 ,ROUND([June achievement incentive], 2)								AS [June achievement incentive]

	 -------------------------------------------------------------------------------
	 -- July
	 -------------------------------------------------------------------------------

		 ,ROUND([Sum of July payment records (PMRs)], 2)						AS [Sum of July payment records (PMRs)]

		 ,ROUND([July core government contribution], 2)						AS [July core government contribution]
		 ,ROUND([July maths and English on-programme earned cash], 2)		AS [July maths and English on-programme earned cash]
		 ,ROUND([July maths and English balancing earned cash], 2)			AS [July maths and English balancing earned cash]
		 ,ROUND([July learning support earned cash], 2)						AS [July learning support earned cash]
		 ,ROUND([July small employer incentive], 2)							AS [July small employer incentive]
		 ,ROUND([July 16-18 year-old apprentice incentive], 2)				AS [July 16-18 year-old apprentice incentive]
		 ,ROUND([July achievement incentive], 2)								AS [July achievement incentive]

	 -------------------------------------------------------------------------------
	 -- This Year Totals
	 -------------------------------------------------------------------------------

		 ,ROUND([Total payment records (PMRs) for this funding year], 2)		AS [Total payment records (PMRs) for this funding year]

		 ,ROUND([Total core government contribution], 2)						AS [Total core government contribution]
		 ,ROUND([Total maths and English on-programme earned cash], 2)		AS [Total maths and English on-programme earned cash]
		 ,ROUND([Total maths and English balancing earned cash], 2)			AS [Total maths and English balancing earned cash]
		 ,ROUND([Total learning support earned cash], 2)						AS [Total learning support earned cash]
		 ,ROUND([Total small employer incentive], 2)							AS [Total small employer incentive]
		 ,ROUND([Total 16-18 year-old apprentice incentive], 2)				AS [Total 16-18 year-old apprentice incentive]
		 ,ROUND([Total achievement incentive], 2)							AS [Total achievement incentive]

		 ,NULL

	 FROM [Report].[PFRTrailblazerApprenticeshipsOccupancyReportView] 
	 ORDER BY [RowNumber]			

 END