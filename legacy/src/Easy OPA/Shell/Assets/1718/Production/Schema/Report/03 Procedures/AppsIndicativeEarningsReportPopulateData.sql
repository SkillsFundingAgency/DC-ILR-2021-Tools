IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[AppsIndicativeEarningsReportPopulateData]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [Report].[AppsIndicativeEarningsReportPopulateData]
GO

CREATE PROCEDURE [Report].[AppsIndicativeEarningsReportPopulateData]	
AS
BEGIN	


IF NOT EXISTS (SELECT TOP 1 * FROM [Valid].[LearningDelivery] where FundModel=36)
	RETURN;
	
--Variables

DECLARE @YearStart Datetime = '${YearStartDate}';
DECLARE @YearEnd Datetime = '${YearEndDate}';


----Main Body	

	TRUNCATE TABLE [Report].[AppsIndicativeEarningsReport]
	
	INSERT INTO [Report].[AppsIndicativeEarningsReport]
           ([RowNumber]
		   ,[Learner reference number]
		   ,[Unique learner number]
		   ,[Date of birth] 
		   ,[Postcode prior to enrolment] 
		   ,[Provider specified learner monitoring (A)] 
		   ,[Provider specified learner monitoring (B)] 
		   ,[Aim sequence number]
		   ,[Learning aim reference]
		   ,[Learning aim title] 
		   ,[Software supplier aim identifier] 
		   ,[LARS 16-18 additional payments - employer] 
		   ,[LARS 16-18 additional payments - provider] 
		   ,[LARS 16-18 framework uplift]				
		   ,[Notional NVQ level] 
		   ,[Standard notional end level]
		   ,[Tier 2 sector subject area] 
           ,[Programme type]
           ,[Standard code]
           ,[Framework code]
           ,[Apprenticeship pathway]
           ,[Aim type]
           ,[Common component code]
           ,[Funding model]
           ,[Original learning start date]
           ,[Learning start date]
           ,[Learning planned end date]
           ,[Completion status]
           ,[Learning actual end date]
           ,[Outcome]
           ,[Learning delivery funding and monitoring type – source of funding]
           ,[Learning delivery funding and monitoring type – learning support funding (highest applicable)]
           ,[Learning delivery funding and monitoring type - LSF date applies from (earliest)]
           ,[Learning delivery funding and monitoring type - LSF date applies to (latest)]
           ,[Learning delivery funding and monitoring type – learning delivery monitoring (A)]
           ,[Learning delivery funding and monitoring type – learning delivery monitoring (B)]
           ,[Learning delivery funding and monitoring type – learning delivery monitoring (C)]
           ,[Learning delivery funding and monitoring type – learning delivery monitoring (D)]
           ,[Learning delivery funding and monitoring type – restart indicator]
           ,[Provider specified delivery monitoring (A)]
           ,[Provider specified delivery monitoring (B)]
           ,[Provider specified delivery monitoring (C)]
           ,[Provider specified delivery monitoring (D)]
		   ,[Endpoint assessment organisation]
           ,[Planned number of on programme instalments for aim]
           ,[Sub contracted or partnership UKPRN]
           ,[Delivery location postcode]
           ,[Employer identifier]           
           ,[Employment status]
           ,[Employment status date]
           ,[Employment status monitoring - small employer]
		   ,[Price episode start date] 
		   ,[Price episode actual end date]
		   ,[Funding line type]
		   ,[Total price applicable to this episode]	   
		   ,[Funding band upper limit]
		   ,[Price amount above funding band limit] 
		   ,[Price amount remaining (with upper limit applied) at start of this episode]
		   ,[Completion element (potential or actual earned cash)]
		   ,[Total employer contribution collected (PMR) in previous funding years]
		   ,[Total employer contribution collected (PMR) in this funding year]
		   ,[Learning delivery funding and monitoring type – apprenticeship contract type]
		   ,[Learning delivery funding and monitoring type – ACT date applies from]
		   ,[Learning delivery funding and monitoring type – ACT date applies to]
           ,[August on programme earned cash]
           ,[August balancing payment earned cash]
           ,[August aim completion earned cash]
           ,[August total training and assessment earned]      
           ,[August learning support earned cash]
		   ,[August English and maths on programme earned cash]
           ,[August English and maths balancing payment earned cash]
		   ,[August disadvantage earned cash]
		   ,[August 16-18 additional payments for employers]
		   ,[August 16-18 additional payments for providers]
		   ,[August 16-18 framework uplift on programme payment]
		   ,[August 16-18 framework uplift balancing payment] 
		   ,[August 16-18 framework uplift completion payment]
           ,[September on programme earned cash]
           ,[September balancing payment earned cash]
           ,[September aim completion earned cash]
           ,[September total training and assessment earned]      
           ,[September learning support earned cash]
		   ,[September English and maths on programme earned cash]
           ,[September English and maths balancing payment earned cash]
		   ,[September disadvantage earned cash]
		   ,[September 16-18 additional payments for employers]
		   ,[September 16-18 additional payments for providers]
		   ,[September 16-18 framework uplift on programme payment]
		   ,[September 16-18 framework uplift balancing payment] 
		   ,[September 16-18 framework uplift completion payment]
		   ,[October on programme earned cash]
           ,[October balancing payment earned cash]
           ,[October aim completion earned cash]
           ,[October total training and assessment earned]      
           ,[October learning support earned cash]
		   ,[October English and maths on programme earned cash]
           ,[October English and maths balancing payment earned cash]
		   ,[October disadvantage earned cash]
		   ,[October 16-18 additional payments for employers]
		   ,[October 16-18 additional payments for providers]
		   ,[October 16-18 framework uplift on programme payment]
		   ,[October 16-18 framework uplift balancing payment] 
		   ,[October 16-18 framework uplift completion payment]
           ,[November on programme earned cash]
           ,[November balancing payment earned cash]
           ,[November aim completion earned cash]
           ,[November total training and assessment earned]      
           ,[November learning support earned cash]
		   ,[November English and maths on programme earned cash]
           ,[November English and maths balancing payment earned cash]
		   ,[November disadvantage earned cash]
		   ,[November 16-18 additional payments for employers]
		   ,[November 16-18 additional payments for providers]
		   ,[November 16-18 framework uplift on programme payment]
		   ,[November 16-18 framework uplift balancing payment] 
		   ,[November 16-18 framework uplift completion payment]
           ,[December on programme earned cash]
           ,[December balancing payment earned cash]
           ,[December aim completion earned cash]
           ,[December total training and assessment earned]      
           ,[December learning support earned cash]
		   ,[December English and maths on programme earned cash]
           ,[December English and maths balancing payment earned cash]
		   ,[December disadvantage earned cash]
		   ,[December 16-18 additional payments for employers]
		   ,[December 16-18 additional payments for providers]
		   ,[December 16-18 framework uplift on programme payment]
		   ,[December 16-18 framework uplift balancing payment] 
		   ,[December 16-18 framework uplift completion payment]
		   ,[January on programme earned cash]
           ,[January balancing payment earned cash]
           ,[January aim completion earned cash]
           ,[January total training and assessment earned]      
           ,[January learning support earned cash]
		   ,[January English and maths on programme earned cash]
           ,[January English and maths balancing payment earned cash]
		   ,[January disadvantage earned cash]
		   ,[January 16-18 additional payments for employers]
		   ,[January 16-18 additional payments for providers]
		   ,[January 16-18 framework uplift on programme payment]
		   ,[January 16-18 framework uplift balancing payment] 
		   ,[January 16-18 framework uplift completion payment]
           ,[February on programme earned cash]
           ,[February balancing payment earned cash]
           ,[February aim completion earned cash]
           ,[February total training and assessment earned]      
           ,[February learning support earned cash]
		   ,[February English and maths on programme earned cash]
           ,[February English and maths balancing payment earned cash]
		   ,[February disadvantage earned cash]
		   ,[February 16-18 additional payments for employers]
		   ,[February 16-18 additional payments for providers]
		   ,[February 16-18 framework uplift on programme payment]
		   ,[February 16-18 framework uplift balancing payment] 
		   ,[February 16-18 framework uplift completion payment]
           ,[March on programme earned cash]
           ,[March balancing payment earned cash]
           ,[March aim completion earned cash]
           ,[March total training and assessment earned]      
           ,[March learning support earned cash]
		   ,[March English and maths on programme earned cash]
           ,[March English and maths balancing payment earned cash]
		   ,[March disadvantage earned cash]
		   ,[March 16-18 additional payments for employers]
		   ,[March 16-18 additional payments for providers]
		   ,[March 16-18 framework uplift on programme payment]
		   ,[March 16-18 framework uplift balancing payment] 
		   ,[March 16-18 framework uplift completion payment]
           ,[April on programme earned cash]
           ,[April balancing payment earned cash]
           ,[April aim completion earned cash]
           ,[April total training and assessment earned]      
           ,[April learning support earned cash]
		   ,[April English and maths on programme earned cash]
           ,[April English and maths balancing payment earned cash]
		   ,[April disadvantage earned cash]
		   ,[April 16-18 additional payments for employers]
		   ,[April 16-18 additional payments for providers]
		   ,[April 16-18 framework uplift on programme payment]
		   ,[April 16-18 framework uplift balancing payment] 
		   ,[April 16-18 framework uplift completion payment]
           ,[May on programme earned cash]
           ,[May balancing payment earned cash]
           ,[May aim completion earned cash]
           ,[May total training and assessment earned]      
           ,[May learning support earned cash]
		   ,[May English and maths on programme earned cash]
           ,[May English and maths balancing payment earned cash]
		   ,[May disadvantage earned cash]
		   ,[May 16-18 additional payments for employers]
		   ,[May 16-18 additional payments for providers]
		   ,[May 16-18 framework uplift on programme payment]
		   ,[May 16-18 framework uplift balancing payment] 
		   ,[May 16-18 framework uplift completion payment]
           ,[June on programme earned cash]
           ,[June balancing payment earned cash]
           ,[June aim completion earned cash]
           ,[June total training and assessment earned]      
           ,[June learning support earned cash]
		   ,[June English and maths on programme earned cash]
           ,[June English and maths balancing payment earned cash]
		   ,[June disadvantage earned cash]
		   ,[June 16-18 additional payments for employers]
		   ,[June 16-18 additional payments for providers]
		   ,[June 16-18 framework uplift on programme payment]
		   ,[June 16-18 framework uplift balancing payment] 
		   ,[June 16-18 framework uplift completion payment]
           ,[July on programme earned cash]
           ,[July balancing payment earned cash]
           ,[July aim completion earned cash]
           ,[July total training and assessment earned]      
           ,[July learning support earned cash]
		   ,[July English and maths on programme earned cash]
           ,[July English and maths balancing payment earned cash]
		   ,[July disadvantage earned cash]
		   ,[July 16-18 additional payments for employers]
		   ,[July 16-18 additional payments for providers]
		   ,[July 16-18 framework uplift on programme payment]
		   ,[July 16-18 framework uplift balancing payment] 
		   ,[July 16-18 framework uplift completion payment]
           ,[Total on programme earned cash]
           ,[Total balancing payment earned cash]
           ,[Total aim completion earned cash]
           ,[Total training and assessment earned]
           ,[Total learning support earned cash]
		   ,[Total English and Maths on programme earned cash]
		   ,[Total English and Maths balancing payment earned cash]
		   ,[Total disadvantage earned cash]
		   ,[Total 16-18 additional payments for employers]
           ,[Total 16-18 additional payments for providers]
		   ,[Total 16-18 framework uplift on programme payment] 
		   ,[Total 16-18 framework uplift balancing payment]
		   ,[Total 16-18 framework uplift completion payment]
           ,[OFFICIAL - SENSITIVE])	
		   

	SELECT ROW_NUMBER() OVER (ORDER BY [Learner reference number], [Aim sequence number]) AS [RowNumber]
	,*
	FROM
	(
			SELECT 		
				DISTINCT		
				[Learner reference number] = L.LearnRefNumber,
				[Unique learner number] = L.ULN,
				[Date of birth] = L.DateOfBirth,
				[Postcode prior to enrolment] = L.PostcodePrior,
				[Provider specified learner monitoring (A)] = L.ProvSpecLearnMon_A,
				[Provider specified learner monitoring (B)] = L.ProvSpecLearnMon_B,

				[Aim sequence number] = LD.AimSeqNumber,
				[Learning aim reference] = LD.LearnAimRef,
				[Learning aim title] = LARS_LD.LearnAimRefTitle,
				[Software supplier aim identifier] = LD.SWSupAimId,
		
				[LARS 16-18 additional payments - employer] = AELD.LearnDelApplicEmp1618Incentive,	
				[LARS 16-18 additional payments - provider] = AELD.LearnDelApplicProv1618Incentive,	
				[LARS 16-18 framework uplift] = AELD.LearnDelApplicProv1618FrameworkUplift,	
					
				[Notional NVQ level] = LARS_LD.NotionalNVQLevelv2,
				[Standard notional end level] = LARS_STD.NotionalEndLevel,
				[Tier 2 sector subject area] = LARS_LD.SectorSubjectAreaTier2,

				[Programme type] = LD.ProgType,
				[Standard code] = LD.StdCode,
				[Framework code] = LD.FworkCode,
				[Apprenticeship pathway] = LD.PwayCode,
				[Aim type] = LD.AimType,

				[Common component code] = LARS_LD.FrameworkCommonComponent,

				[Funding model] = LD.FundModel,
				[Original learning start date] = LD.OrigLearnStartDate,
				[Learning start date] = LD.LearnStartDate,
				[Learning planned end date] = LD.LearnPlanEndDate,
				[Completion status] = LD.CompStatus,
				[Learning actual end date] = LD.LearnActEndDate,
				[Outcome] = LD.Outcome,
				[Learning delivery funding and monitoring type – source of funding] = LD.LDFAM_SOF,

		
				[Learning delivery funding and monitoring type – learning support funding (highest applicable)] = FAM_LSF.LearnDelFAMCode ,
				[Learning delivery funding and monitoring type - LSF date applies from (earliest)] = FAM_LSF.LearnDelFamDateFrom_Earliest,	
				[Learning delivery funding and monitoring type - LSF date applies to (latest)] = FAM_LSF.LearnDelFamDateTo_Latest,

				[Learning delivery funding and monitoring type – learning delivery monitoring (A)  ] = LD.LDM1,
				[Learning delivery funding and monitoring type – learning delivery monitoring (B)  ] = LD.LDM2,
				[Learning delivery funding and monitoring type – learning delivery monitoring (C)  ] = LD.LDM3,
				[Learning delivery funding and monitoring type – learning delivery monitoring (D)  ] = LD.LDM4,
				[Learning delivery funding and monitoring type – restart indicator  ] = LD.LDFAM_RES,
				[Provider specified delivery monitoring (A)] = LD.ProvSpecDelMon_A,
				[Provider specified delivery monitoring (B)] = LD.ProvSpecDelMon_B,
				[Provider specified delivery monitoring (C)] = LD.ProvSpecDelMon_C,
				[Provider specified delivery monitoring (D)] = LD.ProvSpecDelMon_D,
				[Endpoint assessment organisation] = LD.EPAOrgID,
		
				[Planned number of on programme instalments for aim] = AELD.PlannedNumOnProgInstalm,								
		
				[Sub contracted or partnership UKPRN] = LD.PartnerUKPRN,
				[Delivery location postcode] = LD.DelLocPostCode,

				[Employer identifier] = LEmpSts.EmpId,
				[Employment status] = LEmpSts.EmpStat,
				[Employment status date] = LEmpSts.DateEmpStatApp,
				[Employment status monitoring - small employer] = LEmpSts.ESMCode_SEM,

				[Price episode start date] = AEPE.EpisodeStartDate,
				[Price episode actual end date] = AEPE.PriceEpisodeActualEndDate,
				[Funding line type] = 
		
				CASE WHEN AELD.LearnDelMathEng = 1 THEN AELD.LearnDelInitialFundLineType ELSE AEPE.PriceEpisodeFundLineType END,
				[Total price applicable to this episode] = AEPE.PriceEpisodeTotalTNPPrice,
				[Funding band upper limit] = AEPE.PriceEpisodeUpperBandLimit,
				[Price amount above funding band limit] = AEPE.PriceEpisodeUpperLimitAdjustment,
				[Price amount remaining (with upper limit applied) at start of this episode] = AEPE.PriceEpisodeCappedRemainingTNPAmount,
				[Completion element (potential or actual earned cash)] = AEPE.PriceEpisodeCompletionElement,

				-- Also add the total from any contributions made where there isn't a price episode
				[Total employer contribution collected (PMR) in previous funding years] = ISNULL(pmrPrev.TNPTotal, 0) + ISNULL(pmrPrevNoPriceEp.PMRTotal, 0),		
	
				[Total employer contribution collected (PMR) in this funding year] = ISNULL(pmr.TNPTotal, 0) + ISNULL(pmrNoPriceEp.PMRTotal, 0),
		
		

				-- USe dates from learning delivery if it's not a matheng aim and there is no price episode
				[Learning delivery funding and monitoring type – apprenticeship contract type ] = 
					CASE WHEN AELD.learndelmatheng = 1 THEN FAM_ACT_AELD.LearnDelFAMCode 
						WHEN AELD.learndelmatheng = 0 AND FAM_ACT_PE.LearnDelFAMCode IS NOT NULL THEN FAM_ACT_PE.LearnDelFAMCode 
						WHEN AELD.learndelmatheng = 0 AND FAM_ACT_PE.LearnDelFAMCode IS NULL THEN FAM_ACT_AELD.LearnDelFAMCode 
					ELSE NULL END,
				[Learning delivery funding and monitoring type – ACT date applies from (earliest)] =
					CASE WHEN AELD.learndelmatheng = 1 THEN FAM_ACT_AELD.LearnDelFamDateFrom 
						 WHEN AELD.learndelmatheng = 0 AND FAM_ACT_PE.LearnDelFAMCode IS NOT NULL THEN FAM_ACT_PE.LearnDelFamDateFrom 
						 WHEN AELD.learndelmatheng = 0 AND FAM_ACT_PE.LearnDelFAMCode IS NULL THEN FAM_ACT_AELD.LearnDelFamDateFrom 
					ELSE NULL END,
				[Learning delivery funding and monitoring type – ACT date applies to (latest)] =
					CASE WHEN AELD.learndelmatheng = 1 AND FAM_ACT_AELD.LearnDelFamDateTo = '9999-12-31' THEN NULL 
						 WHEN AELD.learndelmatheng = 1 AND FAM_ACT_AELD.LearnDelFamDateTo != '9999-12-31' THEN FAM_ACT_AELD.LearnDelFamDateTo 
						 WHEN AELD.learndelmatheng = 0 AND FAM_ACT_PE.LearnDelFAMCode IS NOT NULL AND FAM_ACT_PE.LearnDelFamDateTo = '9999-12-31' THEN NULL
				         WHEN AELD.learndelmatheng = 0 AND FAM_ACT_PE.LearnDelFAMCode IS NOT NULL AND FAM_ACT_PE.LearnDelFamDateTo != '9999-12-31' THEN FAM_ACT_PE.LearnDelFamDateTo 
						 WHEN AELD.learndelmatheng = 0 AND FAM_ACT_PE.LearnDelFAMCode IS NULL AND FAM_ACT_AELD.LearnDelFamDateTo = '9999-12-31' THEN NULL
						 WHEN AELD.learndelmatheng = 0 AND FAM_ACT_PE.LearnDelFAMCode IS NULL AND FAM_ACT_AELD.LearnDelFamDateTo != '9999-12-31' THEN FAM_ACT_AELD.LearnDelFamDateTo 
					ELSE NULL END,
					
				-- August 2016
				[August on programme earned cash] = ISNULL(AEPEPV_paopp.Period_1,0),
				[August balancing payment earned cash] = ISNULL(AEPEPV_pabp.Period_1,0),
				[August aim completion earned cash] = ISNULL(AEPEPV_pacp.Period_1,0),
				[August total training and assessment earned] = ISNULL(AEPEPV_paopp.Period_1,0)+ISNULL(AEPEPV_pabp.Period_1,0)+ISNULL(AEPEPV_pacp.Period_1,0),
				[August learning support earned cash] = ISNULL(LSF.Period_1, 0),
				[August English and maths on programme earned cash] = ISNULL(AELDPV_meopp.Period_1,0), 
				[August English and maths balancing payment earned cash] = ISNULL(AELDPV_mebp.Period_1,0), 
				[August disadvantage earned cash] = ISNULL(AEPEPV_dfp.Period_1,0)+ISNULL(AEPEPV_dsp.Period_1,0),
				[August 16-18 additional payments for employers] = ISNULL(AEPEPV_pefep.Period_1,0)+ISNULL(AEPEPV_pesep.Period_1,0),		
				[August 16-18 additional payments for providers] = ISNULL(AEPEPV_pefpp.Period_1,0)+ISNULL(AEPEPV_pespp.Period_1,0),
				[August 16-18 framework uplift on programme payment] = ISNULL(AEPEPV_pefuop.Period_1,0),
				[August 16-18 framework uplift balancing payment] = ISNULL(AEPEPV_pefub.Period_1,0),
				[August 16-18 framework uplift completion payment] =  ISNULL(AEPEPV_pefucp.Period_1,0),
		
				-- September 2016
				[September on programme earned cash] =  ISNULL(AEPEPV_paopp.Period_2,0),
				[September balancing payment earned cash] =  ISNULL(AEPEPV_pabp.Period_2,0),
				[September aim completion earned cash] =  ISNULL(AEPEPV_pacp.Period_2,0),
				[September total training and assessment earned] = ISNULL(AEPEPV_paopp.Period_2,0)+ISNULL(AEPEPV_pabp.Period_2,0)+ISNULL(AEPEPV_pacp.Period_2,0),
				[September learning support earned cash] =  ISNULL(LSF.Period_2,0),
				[September English and maths on programme earned cash] =  ISNULL(AELDPV_meopp.Period_2, 0),
				[September English and maths balancing payment earned cash] =  ISNULL(AELDPV_mebp.Period_2,0), 
				[September disadvantage earned cash] = ISNULL(AEPEPV_dfp.Period_2,0)+ISNULL(AEPEPV_dsp.Period_2,0),
				[September 16-18 additional payments for employers] = ISNULL(AEPEPV_pefep.Period_2,0)+ISNULL(AEPEPV_pesep.Period_2,0),		
				[September 16-18 additional payments for providers] = ISNULL(AEPEPV_pefpp.Period_2,0)+ISNULL(AEPEPV_pespp.Period_2,0),
				[September 16-18 framework uplift on programme payment] =  ISNULL(AEPEPV_pefuop.Period_2,0),
				[September 16-18 framework uplift balancing payment] =  ISNULL(AEPEPV_pefub.Period_2,0),
				[September 16-18 framework uplift completion payment] =   ISNULL(AEPEPV_pefucp.Period_2,0),

				-- October 2016
				[October on programme earned cash] = ISNULL(AEPEPV_paopp.Period_3,0),
				[October balancing payment earned cash] = ISNULL(AEPEPV_pabp.Period_3,0),
				[October aim completion earned cash] = ISNULL(AEPEPV_pacp.Period_3,0),
				[October total training and assessment earned] = ISNULL(AEPEPV_paopp.Period_3,0)+ISNULL(AEPEPV_pabp.Period_3,0)+ISNULL(AEPEPV_pacp.Period_3,0),
				[October learning support earned cash] = ISNULL(LSF.Period_3, 0),
				[October English and maths on programme earned cash] =ISNULL( AELDPV_meopp.Period_3, 0),
				[October English and maths balancing payment earned cash] = ISNULL(AELDPV_mebp.Period_3,0), 
				[October disadvantage earned cash] = ISNULL(AEPEPV_dfp.Period_3,0)+ISNULL(AEPEPV_dsp.Period_3,0),
				[October 16-18 additional payments for employers] = ISNULL(AEPEPV_pefep.Period_3,0)+ISNULL(AEPEPV_pesep.Period_3,0),		
				[October 16-18 additional payments for providers] = ISNULL(AEPEPV_pefpp.Period_3,0)+ISNULL(AEPEPV_pespp.Period_3,0),
				[October 16-18 framework uplift on programme payment] = ISNULL(AEPEPV_pefuop.Period_3,0),
				[October 16-18 framework uplift balancing payment] = ISNULL(AEPEPV_pefub.Period_3,0),
				[October 16-18 framework uplift completion payment] =  ISNULL(AEPEPV_pefucp.Period_3,0),
		
				-- November 2016
				[November on programme earned cash] = ISNULL(AEPEPV_paopp.Period_4,0),
				[November balancing payment earned cash] = ISNULL(AEPEPV_pabp.Period_4,0),
				[November aim completion earned cash] = ISNULL(AEPEPV_pacp.Period_4,0),
				[November total training and assessment earned] = ISNULL(AEPEPV_paopp.Period_4,0)+ISNULL(AEPEPV_pabp.Period_4,0)+ISNULL(AEPEPV_pacp.Period_4,0),
				[November learning support earned cash] = ISNULL(LSF.Period_4,0),
				[November English and maths on programme earned cash] = ISNULL(AELDPV_meopp.Period_4, 0),
				[November English and maths balancing payment earned cash] = ISNULL(AELDPV_mebp.Period_4, 0),
				[November disadvantage earned cash] = ISNULL(AEPEPV_dfp.Period_4,0)+ISNULL(AEPEPV_dsp.Period_4,0),
				[November 16-18 additional payments for employers] = ISNULL(AEPEPV_pefep.Period_4,0)+ISNULL(AEPEPV_pesep.Period_4,0),		
				[November 16-18 additional payments for providers] = ISNULL(AEPEPV_pefpp.Period_4,0)+ISNULL(AEPEPV_pespp.Period_4,0),
				[November 16-18 framework uplift on programme payment] = ISNULL(AEPEPV_pefuop.Period_4,0),
				[November 16-18 framework uplift balancing payment] = ISNULL(AEPEPV_pefub.Period_4,0),
				[November 16-18 framework uplift completion payment] =  ISNULL(AEPEPV_pefucp.Period_4,0),
		
				-- December 2016
				[December on programme earned cash] = ISNULL(AEPEPV_paopp.Period_5,0),
				[December balancing payment earned cash] = ISNULL(AEPEPV_pabp.Period_5,0),
				[December aim completion earned cash] = ISNULL(AEPEPV_pacp.Period_5,0),
				[December total training and assessment earned] = ISNULL(AEPEPV_paopp.Period_5,0)+ISNULL(AEPEPV_pabp.Period_5,0)+ISNULL(AEPEPV_pacp.Period_5,0),
				[December learning support earned cash] = ISNULL(LSF.Period_5,0),
				[December English and maths on programme earned cash] = ISNULL(AELDPV_meopp.Period_5, 0),
				[December English and maths balancing payment earned cash] = ISNULL(AELDPV_mebp.Period_5,0), 
				[December disadvantage earned cash] = ISNULL(AEPEPV_dfp.Period_5,0)+ISNULL(AEPEPV_dsp.Period_5,0),
				[December 16-18 additional payments for employers] = ISNULL(AEPEPV_pefep.Period_5,0)+ISNULL(AEPEPV_pesep.Period_5,0),		
				[December 16-18 additional payments for providers] = ISNULL(AEPEPV_pefpp.Period_5,0)+ISNULL(AEPEPV_pespp.Period_5,0),
				[December 16-18 framework uplift on programme payment] = ISNULL(AEPEPV_pefuop.Period_5,0),
				[December 16-18 framework uplift balancing payment] = ISNULL(AEPEPV_pefub.Period_5,0),
				[December 16-18 framework uplift completion payment] =  ISNULL(AEPEPV_pefucp.Period_5,0),

				-- January 2017
				[January on programme earned cash] = ISNULL(AEPEPV_paopp.Period_6,0),
				[January balancing payment earned cash] = ISNULL(AEPEPV_pabp.Period_6,0),
				[January aim completion earned cash] = ISNULL(AEPEPV_pacp.Period_6,0),
				[January total training and assessment earned] = ISNULL(AEPEPV_paopp.Period_6,0)+ISNULL(AEPEPV_pabp.Period_6,0)+ISNULL(AEPEPV_pacp.Period_6,0),
				[January learning support earned cash] = ISNULL(LSF.Period_6,0),
				[January English and maths on programme earned cash] = ISNULL(AELDPV_meopp.Period_6, 0),
				[January English and maths balancing payment earned cash] = ISNULL(AELDPV_mebp.Period_6, 0),
				[January disadvantage earned cash] = ISNULL(AEPEPV_dfp.Period_6,0)+ISNULL(AEPEPV_dsp.Period_6,0),
				[January 16-18 additional payments for employers] = ISNULL(AEPEPV_pefep.Period_6,0)+ISNULL(AEPEPV_pesep.Period_6,0),		
				[January 16-18 additional payments for providers] = ISNULL(AEPEPV_pefpp.Period_6,0)+ISNULL(AEPEPV_pespp.Period_6,0),
				[January 16-18 framework uplift on programme payment] = ISNULL(AEPEPV_pefuop.Period_6,0),
				[January 16-18 framework uplift balancing payment] = ISNULL(AEPEPV_pefub.Period_6,0),
				[January 16-18 framework uplift completion payment] =  ISNULL(AEPEPV_pefucp.Period_6,0),

				-- February 2017
				[February on programme earned cash] = ISNULL(AEPEPV_paopp.Period_7,0),
				[February balancing payment earned cash] = ISNULL(AEPEPV_pabp.Period_7,0),
				[February aim completion earned cash] = ISNULL(AEPEPV_pacp.Period_7,0),
				[February total training and assessment earned] = ISNULL(AEPEPV_paopp.Period_7,0)+ISNULL(AEPEPV_pabp.Period_7,0)+ISNULL(AEPEPV_pacp.Period_7,0),
				[February learning support earned cash] = ISNULL(LSF.Period_7,0),
				[February English and maths on programme earned cash] = ISNULL(AELDPV_meopp.Period_7, 0),
				[February English and maths balancing payment earned cash] = ISNULL(AELDPV_mebp.Period_7, 0),
				[February disadvantage earned cash] = ISNULL(AEPEPV_dfp.Period_7,0)+ISNULL(AEPEPV_dsp.Period_7,0),
				[February 16-18 additional payments for employers] = ISNULL(AEPEPV_pefep.Period_7,0)+ISNULL(AEPEPV_pesep.Period_7,0),		
				[February 16-18 additional payments for providers] = ISNULL(AEPEPV_pefpp.Period_7,0)+ISNULL(AEPEPV_pespp.Period_7,0),
				[February 16-18 framework uplift on programme payment] = ISNULL(AEPEPV_pefuop.Period_7,0),
				[February 16-18 framework uplift balancing payment] = ISNULL(AEPEPV_pefub.Period_7,0),
				[February 16-18 framework uplift completion payment] =  ISNULL(AEPEPV_pefucp.Period_7,0),
		
				-- March 2017
				[March on programme earned cash] = ISNULL(AEPEPV_paopp.Period_8,0),
				[March balancing payment earned cash] = ISNULL(AEPEPV_pabp.Period_8,0),
				[March aim completion earned cash] = ISNULL(AEPEPV_pacp.Period_8,0),
				[March total training and assessment earned] = ISNULL(AEPEPV_paopp.Period_8,0)+ISNULL(AEPEPV_pabp.Period_8,0)+ISNULL(AEPEPV_pacp.Period_8,0),
				[March learning support earned cash] = ISNULL(LSF.Period_8,0),
				[March English and maths on programme earned cash] = ISNULL(AELDPV_meopp.Period_8, 0),
				[March English and maths balancing payment earned cash] = ISNULL(AELDPV_mebp.Period_8, 0),
				[March disadvantage earned cash] = ISNULL(AEPEPV_dfp.Period_8,0)+ISNULL(AEPEPV_dsp.Period_8,0),
				[March 16-18 additional payments for employers] = ISNULL(AEPEPV_pefep.Period_8,0)+ISNULL(AEPEPV_pesep.Period_8,0),		
				[March 16-18 additional payments for providers] = ISNULL(AEPEPV_pefpp.Period_8,0)+ISNULL(AEPEPV_pespp.Period_8,0),
				[March 16-18 framework uplift on programme payment] = ISNULL(AEPEPV_pefuop.Period_8,0),
				[March 16-18 framework uplift balancing payment] = ISNULL(AEPEPV_pefub.Period_8,0),
				[March 16-18 framework uplift completion payment] =  ISNULL(AEPEPV_pefucp.Period_8,0),
		
				-- April 2017
				[April on programme earned cash] = ISNULL(AEPEPV_paopp.Period_9,0),
				[April balancing payment earned cash] = ISNULL(AEPEPV_pabp.Period_9,0),
				[April aim completion earned cash] = ISNULL(AEPEPV_pacp.Period_9,0),
				[April total training and assessment earned] = ISNULL(AEPEPV_paopp.Period_9,0)+ISNULL(AEPEPV_pabp.Period_9,0)+ISNULL(AEPEPV_pacp.Period_9,0),
				[April learning support earned cash] = ISNULL(LSF.Period_9,0),
				[April English and maths on programme earned cash] = ISNULL(AELDPV_meopp.Period_9, 0),
				[April English and maths balancing payment earned cash] = ISNULL(AELDPV_mebp.Period_9, 0),
				[April disadvantage earned cash] = ISNULL(AEPEPV_dfp.Period_9,0)+ISNULL(AEPEPV_dsp.Period_9,0),
				[April 16-18 additional payments for employers] = ISNULL(AEPEPV_pefep.Period_9,0)+ISNULL(AEPEPV_pesep.Period_9,0),		
				[April 16-18 additional payments for providers] = ISNULL(AEPEPV_pefpp.Period_9,0)+ISNULL(AEPEPV_pespp.Period_9,0),
				[April 16-18 framework uplift on programme payment] = ISNULL(AEPEPV_pefuop.Period_9,0),
				[April 16-18 framework uplift balancing payment] = ISNULL(AEPEPV_pefub.Period_9,0),
				[April 16-18 framework uplift completion payment] =  ISNULL(AEPEPV_pefucp.Period_9,0),

				-- May 2017
				[May on programme earned cash] = ISNULL(AEPEPV_paopp.Period_10,0),
				[May balancing payment earned cash] = ISNULL(AEPEPV_pabp.Period_10,0),
				[May aim completion earned cash] =ISNULL( AEPEPV_pacp.Period_10,0),
				[May total training and assessment earned] = ISNULL(AEPEPV_paopp.Period_10,0)+ISNULL(AEPEPV_pabp.Period_10,0)+ISNULL(AEPEPV_pacp.Period_10,0),
				[May learning support earned cash] = ISNULL(LSF.Period_10,0),
				[May English and maths on programme earned cash] = ISNULL(AELDPV_meopp.Period_10, 0),
				[May English and maths balancing payment earned cash] = ISNULL(AELDPV_mebp.Period_10, 0),
				[May disadvantage earned cash] = ISNULL(AEPEPV_dfp.Period_10,0)+ISNULL(AEPEPV_dsp.Period_10,0),
				[May 16-18 additional payments for employers] = ISNULL(AEPEPV_pefep.Period_10,0)+ISNULL(AEPEPV_pesep.Period_10,0),		
				[May 16-18 additional payments for providers] = ISNULL(AEPEPV_pefpp.Period_10,0)+ISNULL(AEPEPV_pespp.Period_10,0),
				[May 16-18 framework uplift on programme payment] = ISNULL(AEPEPV_pefuop.Period_10,0),
				[May 16-18 framework uplift balancing payment] = ISNULL(AEPEPV_pefub.Period_10,0),
				[May 16-18 framework uplift completion payment] =  ISNULL(AEPEPV_pefucp.Period_10,0),
		
				-- June 2017
				[June on programme earned cash] = ISNULL(AEPEPV_paopp.Period_11,0),
				[June balancing payment earned cash] = ISNULL(AEPEPV_pabp.Period_11,0),
				[June aim completion earned cash] = ISNULL(AEPEPV_pacp.Period_11,0),
				[June total training and assessment earned] = ISNULL(AEPEPV_paopp.Period_11,0)+ISNULL(AEPEPV_pabp.Period_11,0)+ISNULL(AEPEPV_pacp.Period_11,0),
				[June learning support earned cash] = ISNULL(LSF.Period_11,0),
				[June English and maths on programme earned cash] = ISNULL(AELDPV_meopp.Period_11, 0),
				[June English and maths balancing payment earned cash] = ISNULL(AELDPV_mebp.Period_11, 0),
				[June disadvantage earned cash] = ISNULL(AEPEPV_dfp.Period_11,0)+ISNULL(AEPEPV_dsp.Period_11,0),
				[June 16-18 additional payments for employers] = ISNULL(AEPEPV_pefep.Period_11,0)+ISNULL(AEPEPV_pesep.Period_11,0),		
				[June 16-18 additional payments for providers] = ISNULL(AEPEPV_pefpp.Period_11,0)+ISNULL(AEPEPV_pespp.Period_11,0),
				[June 16-18 framework uplift on programme payment] = ISNULL(AEPEPV_pefuop.Period_11,0),
				[June 16-18 framework uplift balancing payment] = ISNULL(AEPEPV_pefub.Period_11,0),
				[June 16-18 framework uplift completion payment] =  ISNULL(AEPEPV_pefucp.Period_11,0),
		
				-- July 2017
				[July on programme earned cash] = ISNULL(AEPEPV_paopp.Period_12,0),
				[July balancing payment earned cash] = ISNULL(AEPEPV_pabp.Period_12,0),
				[July aim completion earned cash] = ISNULL(AEPEPV_pacp.Period_12,0),
				[July total training and assessment earned] = ISNULL(AEPEPV_paopp.Period_12,0)+ISNULL(AEPEPV_pabp.Period_12,0)+ISNULL(AEPEPV_pacp.Period_12,0),
				[July learning support earned cash] = ISNULL(LSF.Period_12,0),
				[July English and maths on programme earned cash] = ISNULL(AELDPV_meopp.Period_12, 0),
				[July English and maths balancing payment earned cash] = ISNULL(AELDPV_mebp.Period_12, 0),
				[July disadvantage earned cash] = ISNULL(AEPEPV_dfp.Period_12,0)+ISNULL(AEPEPV_dsp.Period_12,0),
				[July 16-18 additional payments for employers] = ISNULL(AEPEPV_pefep.Period_12,0)+ISNULL(AEPEPV_pesep.Period_12,0),		
				[July 16-18 additional payments for providers] = ISNULL(AEPEPV_pefpp.Period_12,0)+ISNULL(AEPEPV_pespp.Period_12,0),
				[July 16-18 framework uplift on programme payment] = ISNULL(AEPEPV_pefuop.Period_12,0),
				[July 16-18 framework uplift balancing payment] = ISNULL(AEPEPV_pefub.Period_12,0),
				[July 16-18 framework uplift completion payment] =  ISNULL(AEPEPV_pefucp.Period_12,0),


				--Total of 'programme earned cash' from August 2016 to July 2017
				[Total on programme earned cash]			=ISNULL(AEPEPV_paopp.Period_1,0)
															+ISNULL(AEPEPV_paopp.Period_2,0)
															+ISNULL(AEPEPV_paopp.Period_3,0)
															+ISNULL(AEPEPV_paopp.Period_4,0)
															+ISNULL(AEPEPV_paopp.Period_5,0)
															+ISNULL(AEPEPV_paopp.Period_6,0)
															+ISNULL(AEPEPV_paopp.Period_7,0)
															+ISNULL(AEPEPV_paopp.Period_8,0)
															+ISNULL(AEPEPV_paopp.Period_9,0)
															+ISNULL(AEPEPV_paopp.Period_10,0)
															+ISNULL(AEPEPV_paopp.Period_11,0)
															+ISNULL(AEPEPV_paopp.Period_12,0),										
		

				--Total of 'balancing payment earned cash' from August 2016 to July 2017
				[Total balancing payment earned cash]		=ISNULL(AEPEPV_pabp.Period_1,0)
															+ISNULL(AEPEPV_pabp.Period_2,0)
															+ISNULL(AEPEPV_pabp.Period_3,0)
															+ISNULL(AEPEPV_pabp.Period_4,0)
															+ISNULL(AEPEPV_pabp.Period_5,0)
															+ISNULL(AEPEPV_pabp.Period_6,0)
															+ISNULL(AEPEPV_pabp.Period_7,0)
															+ISNULL(AEPEPV_pabp.Period_8,0)
															+ISNULL(AEPEPV_pabp.Period_9,0)
															+ISNULL(AEPEPV_pabp.Period_10,0)
															+ISNULL(AEPEPV_pabp.Period_11,0)
															+ISNULL(AEPEPV_pabp.Period_12,0),			

				--Total of 'aim completion earned cash' from August 2016 to July 2017
				[Total aim completion earned cash]			=ISNULL(AEPEPV_pacp.Period_1,0)
															+ISNULL(AEPEPV_pacp.Period_2,0)
															+ISNULL(AEPEPV_pacp.Period_3,0)
															+ISNULL(AEPEPV_pacp.Period_4,0)
															+ISNULL(AEPEPV_pacp.Period_5,0)
															+ISNULL(AEPEPV_pacp.Period_6,0)
															+ISNULL(AEPEPV_pacp.Period_7,0)
															+ISNULL(AEPEPV_pacp.Period_8,0)
															+ISNULL(AEPEPV_pacp.Period_9,0)
															+ISNULL(AEPEPV_pacp.Period_10,0)
															+ISNULL(AEPEPV_pacp.Period_11,0)
															+ISNULL(AEPEPV_pacp.Period_12,0),	

				--Sum of the above three totals
				[Total training and assessment earned]		=ISNULL(AEPEPV_paopp.Period_1,0)
															+ISNULL(AEPEPV_paopp.Period_2,0)
															+ISNULL(AEPEPV_paopp.Period_3,0)
															+ISNULL(AEPEPV_paopp.Period_4,0)
															+ISNULL(AEPEPV_paopp.Period_5,0)
															+ISNULL(AEPEPV_paopp.Period_6,0)
															+ISNULL(AEPEPV_paopp.Period_7,0)
															+ISNULL(AEPEPV_paopp.Period_8,0)
															+ISNULL(AEPEPV_paopp.Period_9,0)
															+ISNULL(AEPEPV_paopp.Period_10,0)
															+ISNULL(AEPEPV_paopp.Period_11,0)
															+ISNULL(AEPEPV_paopp.Period_12,0)		

															+ISNULL(AEPEPV_pabp.Period_1,0)
															+ISNULL(AEPEPV_pabp.Period_2,0)
															+ISNULL(AEPEPV_pabp.Period_3,0)
															+ISNULL(AEPEPV_pabp.Period_4,0)
															+ISNULL(AEPEPV_pabp.Period_5,0)
															+ISNULL(AEPEPV_pabp.Period_6,0)
															+ISNULL(AEPEPV_pabp.Period_7,0)
															+ISNULL(AEPEPV_pabp.Period_8,0)
															+ISNULL(AEPEPV_pabp.Period_9,0)
															+ISNULL(AEPEPV_pabp.Period_10,0)
															+ISNULL(AEPEPV_pabp.Period_11,0)
															+ISNULL(AEPEPV_pabp.Period_12,0)

															+ ISNULL(AEPEPV_pacp.Period_1,0)
															+ISNULL(AEPEPV_pacp.Period_2,0)
															+ISNULL(AEPEPV_pacp.Period_3,0)
															+ISNULL(AEPEPV_pacp.Period_4,0)
															+ISNULL(AEPEPV_pacp.Period_5,0)
															+ISNULL(AEPEPV_pacp.Period_6,0)
															+ISNULL(AEPEPV_pacp.Period_7,0)
															+ISNULL(AEPEPV_pacp.Period_8,0)
															+ISNULL(AEPEPV_pacp.Period_9,0)
															+ISNULL(AEPEPV_pacp.Period_10,0)
															+ISNULL(AEPEPV_pacp.Period_11,0)
															+ISNULL(AEPEPV_pacp.Period_12,0),	



				[Total learning support earned cash]		=ISNULL(LSF.Period_1,0)
															+ISNULL(LSF.Period_2,0)
															+ISNULL(LSF.Period_3,0)
															+ISNULL(LSF.Period_4,0)
															+ISNULL(LSF.Period_5,0)
															+ISNULL(LSF.Period_6,0)
															+ISNULL(LSF.Period_7,0)
															+ISNULL(LSF.Period_8,0)
															+ISNULL(LSF.Period_9,0)
															+ISNULL(LSF.Period_10,0)
															+ISNULL(LSF.Period_11,0)
															+ISNULL(LSF.Period_12,0),
														
		
														
				[Total English and maths on programme earned cash]		=ISNULL(AELDPV_meopp.Period_1,0)
																		+ISNULL(AELDPV_meopp.Period_2,0)
																		+ISNULL(AELDPV_meopp.Period_3,0)
																		+ISNULL(AELDPV_meopp.Period_4,0)
																		+ISNULL(AELDPV_meopp.Period_5,0)
																		+ISNULL(AELDPV_meopp.Period_6,0)
																		+ISNULL(AELDPV_meopp.Period_7,0)
																		+ISNULL(AELDPV_meopp.Period_8,0)
																		+ISNULL(AELDPV_meopp.Period_9,0)
																		+ISNULL(AELDPV_meopp.Period_10,0)
																		+ISNULL(AELDPV_meopp.Period_11,0)
																		+ISNULL(AELDPV_meopp.Period_12,0),
														

				[Total English and maths balancing payment earned cash]	=ISNULL(AELDPV_mebp.Period_1,0)
																		+ISNULL(AELDPV_mebp.Period_2,0)
																		+ISNULL(AELDPV_mebp.Period_3,0)
																		+ISNULL(AELDPV_mebp.Period_4,0)
																		+ISNULL(AELDPV_mebp.Period_5,0)
																		+ISNULL(AELDPV_mebp.Period_6,0)
																		+ISNULL(AELDPV_mebp.Period_7,0)
																		+ISNULL(AELDPV_mebp.Period_8,0)
																		+ISNULL(AELDPV_mebp.Period_9,0)
																		+ISNULL(AELDPV_mebp.Period_10,0)
																		+ISNULL(AELDPV_mebp.Period_11,0)
																		+ISNULL(AELDPV_mebp.Period_12,0),


				[Total disadvantage earned cash]			=ISNULL(AEPEPV_dfp.Period_1,0)+ISNULL(AEPEPV_dsp.Period_1,0)
															+ISNULL(AEPEPV_dfp.Period_2,0)+ISNULL(AEPEPV_dsp.Period_2,0)
															+ISNULL(AEPEPV_dfp.Period_3,0)+ISNULL(AEPEPV_dsp.Period_3,0)
															+ISNULL(AEPEPV_dfp.Period_4,0)+ISNULL(AEPEPV_dsp.Period_4,0)
															+ISNULL(AEPEPV_dfp.Period_5,0)+ISNULL(AEPEPV_dsp.Period_5,0)
															+ISNULL(AEPEPV_dfp.Period_6,0)+ISNULL(AEPEPV_dsp.Period_6,0)
															+ISNULL(AEPEPV_dfp.Period_7,0)+ISNULL(AEPEPV_dsp.Period_7,0)
															+ISNULL(AEPEPV_dfp.Period_8,0)+ISNULL(AEPEPV_dsp.Period_8,0)
															+ISNULL(AEPEPV_dfp.Period_9,0)+ISNULL(AEPEPV_dsp.Period_9,0)
															+ISNULL(AEPEPV_dfp.Period_10,0)+ISNULL(AEPEPV_dsp.Period_10,0)
															+ISNULL(AEPEPV_dfp.Period_11,0)+ISNULL(AEPEPV_dsp.Period_11,0)
															+ISNULL(AEPEPV_dfp.Period_12,0)+ISNULL(AEPEPV_dsp.Period_12,0),												


		

				[Total 16-18 additional payments for employers]		=ISNULL(AEPEPV_pefep.Period_1,0)+ISNULL(AEPEPV_pesep.Period_1,0)
																	+ISNULL(AEPEPV_pefep.Period_2,0)+ISNULL(AEPEPV_pesep.Period_2,0)
																	+ISNULL(AEPEPV_pefep.Period_3,0)+ISNULL(AEPEPV_pesep.Period_3,0)
																	+ISNULL(AEPEPV_pefep.Period_4,0)+ISNULL(AEPEPV_pesep.Period_4,0)
																	+ISNULL(AEPEPV_pefep.Period_5,0)+ISNULL(AEPEPV_pesep.Period_5,0)
																	+ISNULL(AEPEPV_pefep.Period_6,0)+ISNULL(AEPEPV_pesep.Period_6,0)
																	+ISNULL(AEPEPV_pefep.Period_7,0)+ISNULL(AEPEPV_pesep.Period_7,0)
																	+ISNULL(AEPEPV_pefep.Period_8,0)+ISNULL(AEPEPV_pesep.Period_8,0)
																	+ISNULL(AEPEPV_pefep.Period_9,0)+ISNULL(AEPEPV_pesep.Period_9,0)
																	+ISNULL(AEPEPV_pefep.Period_10,0)+ISNULL(AEPEPV_pesep.Period_10,0)
																	+ISNULL(AEPEPV_pefep.Period_11,0)+ISNULL(AEPEPV_pesep.Period_11,0)
																	+ISNULL(AEPEPV_pefep.Period_12,0)+ISNULL(AEPEPV_pesep.Period_12,0),
														
				[Total 16-18 additional payments for providers]		=ISNULL(AEPEPV_pefpp.Period_1,0)+ISNULL(AEPEPV_pespp.Period_1,0)
																	+ISNULL(AEPEPV_pefpp.Period_2,0)+ISNULL(AEPEPV_pespp.Period_2,0)
																	+ISNULL(AEPEPV_pefpp.Period_3,0)+ISNULL(AEPEPV_pespp.Period_3,0)
																	+ISNULL(AEPEPV_pefpp.Period_4,0)+ISNULL(AEPEPV_pespp.Period_4,0)
																	+ISNULL(AEPEPV_pefpp.Period_5,0)+ISNULL(AEPEPV_pespp.Period_5,0)
																	+ISNULL(AEPEPV_pefpp.Period_6,0)+ISNULL(AEPEPV_pespp.Period_6,0)
																	+ISNULL(AEPEPV_pefpp.Period_7,0)+ISNULL(AEPEPV_pespp.Period_7,0)
																	+ISNULL(AEPEPV_pefpp.Period_8,0)+ISNULL(AEPEPV_pespp.Period_8,0)
																	+ISNULL(AEPEPV_pefpp.Period_9,0)+ISNULL(AEPEPV_pespp.Period_9,0)
																	+ISNULL(AEPEPV_pefpp.Period_10,0)+ISNULL(AEPEPV_pespp.Period_10,0)
																	+ISNULL(AEPEPV_pefpp.Period_11,0)+ISNULL(AEPEPV_pespp.Period_11,0)
																	+ISNULL(AEPEPV_pefpp.Period_12,0)+ISNULL(AEPEPV_pespp.Period_12,0),


				[Total 16-18 framework uplift on programme payment] 	=ISNULL(AEPEPV_pefuop.Period_1,0)
																		+ISNULL(AEPEPV_pefuop.Period_2,0)
																		+ISNULL(AEPEPV_pefuop.Period_3,0)
																		+ISNULL(AEPEPV_pefuop.Period_4,0)
																		+ISNULL(AEPEPV_pefuop.Period_5,0)
																		+ISNULL(AEPEPV_pefuop.Period_6,0)
																		+ISNULL(AEPEPV_pefuop.Period_7,0)
																		+ISNULL(AEPEPV_pefuop.Period_8,0)
																		+ISNULL(AEPEPV_pefuop.Period_9,0)
																		+ISNULL(AEPEPV_pefuop.Period_10,0)
																		+ISNULL(AEPEPV_pefuop.Period_11,0)
																		+ISNULL(AEPEPV_pefuop.Period_12,0),

					[Total 16-18 framework uplift balancing payment]  	=ISNULL(AEPEPV_pefub.Period_1,0)
																		+ISNULL(AEPEPV_pefub.Period_2,0)
																		+ISNULL(AEPEPV_pefub.Period_3,0)
																		+ISNULL(AEPEPV_pefub.Period_4,0)
																		+ISNULL(AEPEPV_pefub.Period_5,0)
																		+ISNULL(AEPEPV_pefub.Period_6,0)
																		+ISNULL(AEPEPV_pefub.Period_7,0)
																		+ISNULL(AEPEPV_pefub.Period_8,0)
																		+ISNULL(AEPEPV_pefub.Period_9,0)
																		+ISNULL(AEPEPV_pefub.Period_10,0)
																		+ISNULL(AEPEPV_pefub.Period_11,0)
																		+ISNULL(AEPEPV_pefub.Period_12,0),

				[Total 16-18 framework uplift completion payment]	 	=ISNULL(AEPEPV_pefucp.Period_1,0)
																		+ISNULL(AEPEPV_pefucp.Period_2,0)
																		+ISNULL(AEPEPV_pefucp.Period_3,0)
																		+ISNULL(AEPEPV_pefucp.Period_4,0)
																		+ISNULL(AEPEPV_pefucp.Period_5,0)
																		+ISNULL(AEPEPV_pefucp.Period_6,0)
																		+ISNULL(AEPEPV_pefucp.Period_7,0)
																		+ISNULL(AEPEPV_pefucp.Period_8,0)
																		+ISNULL(AEPEPV_pefucp.Period_9,0)
																		+ISNULL(AEPEPV_pefucp.Period_10,0)
																		+ISNULL(AEPEPV_pefucp.Period_11,0)
																		+ISNULL(AEPEPV_pefucp.Period_12,0),

				[OFFICIAL - SENSITIVE]= NULL

				FROM	[Valid].[LearnerDenorm] L
			INNER JOIN [Valid].[LearningDeliveryDenorm] LD on  L.LearnRefNumber = LD.LearnRefNumber AND LD.FundModel=36
			LEFT JOIN  [Reference].[LARS_LearningDelivery] LARS_LD ON LARS_LD.LearnAimRef = LD.LearnAimRef

			LEFT JOIN  [Rulebase].[AEC_ApprenticeshipPriceEpisode] AEPE on L.LearnRefNumber = AEPE.LearnRefNumber
			and AEPE.EpisodeStartDate >= @YearStart and  AEPE.EpisodeStartDate <= @YearEnd
				AND AEPE.PriceEpisodeAimSeqNumber = LD.AimSeqNumber
	

			--Get LARSApprenticeFunding for STD and FWK
			LEFT JOIN  [Reference].[LARS_ApprenticeshipFunding] LARS_AF_STD ON LARS_AF_STD.ApprenticeshipCode=LD.StdCode 
			AND LARS_AF_STD.ProgType=LD.ProgType AND LARS_AF_STD.ApprenticeshipType='STD' AND LARS_AF_STD.PwayCode=0
			LEFT JOIN  [Reference].[LARS_ApprenticeshipFunding] LARS_AF_FWK ON LARS_AF_FWK.ApprenticeshipCode=LD.FworkCode 
			AND LARS_AF_FWK.ProgType=LD.ProgType AND LARS_AF_FWK.ApprenticeshipType='FWK' and LARS_AF_FWK.PwayCode=LD.PwayCode
			LEFT JOIN [Reference].[LARS_Standard] LARS_STD ON LARS_STD.StandardCode = LD.StdCode
	
			LEFT JOIN  [Rulebase].[AEC_LearningDelivery] AELD on L.LearnRefNumber = AELD.LearnRefNumber AND AELD.AimSeqNumber = LD.AimSeqNumber
	
			LEFT JOIN  [Valid].[LearningDeliveryFAM] LDFAM on L.LearnRefNumber = LDFAM.LearnRefNumber

	
			LEFT JOIN [Report].[AppsIndicitiveReportPMRsCurrentYear] pmr on pmr.LearnRefNumber = L.LearnRefNumber and pmr.PriceEpisodeAimSeqNumber = LD.AimSeqNumber AND pmr.EpisodeStartDate = AEPE.EpisodeStartDate
			LEFT JOIN [Report].[AppsIndicitiveReportPMRsPreviousYears] pmrPrev on pmrPrev.LearnRefNumber = L.LearnRefNumber and pmrPrev.PriceEpisodeAimSeqNumber = LD.AimSeqNumber AND pmrPrev.EpisodeStartDate = AEPE.EpisodeStartDate

			-- Link to payments that haven't got an associated price episode (for example, if the learner withdrew early)
			LEFT JOIN [Report].[AppsIndicativeReportPMRsCurrentYearNoPriceEpisode] pmrNoPriceEp 
				ON LD.LearnRefNumber = pmrNoPriceEp.LearnRefNumber 
				AND LD.AimSeqNumber = pmrNoPriceEp.AimSeqNumber
			LEFT JOIN [Report].[AppsIndicativeReportPMRsPreviousYearsNoPriceEpisode] pmrPrevNoPriceEp 
				ON LD.LearnRefNumber = pmrPrevNoPriceEp.LearnRefNumber 
				AND LD.AimSeqNumber = pmrPrevNoPriceEp.AimSeqNumber

			LEFT JOIN [Report].[ValidLearningDeliveryFAM_ACT_EarliestAndLatestDates] FAM_ACT_PE ON L.LearnRefNumber = FAM_ACT_PE.LearnRefNumber AND LD.AimSeqNumber = FAM_ACT_PE.AimSeqNumber AND FAM_ACT_PE.LearnDelFAMType = 'ACT' 
					AND AEPE.EpisodeStartDate >= FAM_ACT_PE.LearnDelFAMDateFrom AND AEPE.EpisodeStartDate <= FAM_ACT_PE.LearnDelFAMDateTo
	
			LEFT JOIN [Report].[ValidLearningDeliveryFAM_ACT_EarliestAndLatestDates] FAM_ACT_AELD ON L.LearnRefNumber = FAM_ACT_AELD.LearnRefNumber AND LD.AimSeqNumber = FAM_ACT_AELD.AimSeqNumber AND FAM_ACT_AELD.LearnDelFAMType = 'ACT' 
					AND LD.LearnStartDate >= FAM_ACT_AELD.LearnDelFAMDateFrom AND LD.LearnStartDate <= FAM_ACT_AELD.LearnDelFAMDateTo
	
			LEFT JOIN [Report].[ValidLearningDeliveryFAM_LSF_EarliestAndLatestDates] FAM_LSF on L.LearnRefNumber = FAM_LSF.LearnRefNumber AND LD.AimSeqNumber = FAM_LSF.AimSeqNumber AND FAM_LSF.LearnDelFAMType = 'LSF'


			LEFT JOIN [Report].[ValidLearnerEmpStatsBeforeLearnStartDate]  LEmpSts on L.LearnRefNumber = LEmpSts.LearnRefNumber and LEmpSts.DateEmpStatApp <= LD.LearnStartDate


			--Periodised Values
			--PriceEpisodeOnProgPayment
			LEFT JOIN  [Rulebase].[AEC_ApprenticeshipPriceEpisode_PeriodisedValues] AEPEPV_paopp on AEPE.LearnRefNumber = AEPEPV_paopp.LearnRefNumber AND AEPE.PriceEpisodeIdentifier = AEPEPV_paopp.PriceEpisodeIdentifier	AND AEPEPV_paopp.AttributeName='PriceEpisodeOnProgPayment'
			--PriceEpisodeBalancePayment
			LEFT JOIN  [Rulebase].[AEC_ApprenticeshipPriceEpisode_PeriodisedValues] AEPEPV_pabp on AEPE.LearnRefNumber = AEPEPV_pabp.LearnRefNumber AND AEPE.PriceEpisodeIdentifier = AEPEPV_pabp.PriceEpisodeIdentifier AND AEPEPV_pabp.AttributeName='PriceEpisodeBalancePayment'
			--PriceEpisodeCompletionPayment
			LEFT JOIN  [Rulebase].[AEC_ApprenticeshipPriceEpisode_PeriodisedValues] AEPEPV_pacp on AEPE.LearnRefNumber = AEPEPV_pacp.LearnRefNumber AND AEPE.PriceEpisodeIdentifier = AEPEPV_pacp.PriceEpisodeIdentifier AND AEPEPV_pacp.AttributeName='PriceEpisodeCompletionPayment'
			--PriceEpisodeFirstDisadvantagePayment
			LEFT JOIN  [Rulebase].[AEC_ApprenticeshipPriceEpisode_PeriodisedValues] AEPEPV_dfp on AELD.LearnRefNumber = AEPEPV_dfp.LearnRefNumber AND AEPE.PriceEpisodeIdentifier = AEPEPV_dfp.PriceEpisodeIdentifier AND AEPEPV_dfp.AttributeName='PriceEpisodeFirstDisadvantagePayment'
			--PriceEpisodeSecondDisadvantagePayment
			LEFT JOIN  [Rulebase].[AEC_ApprenticeshipPriceEpisode_PeriodisedValues] AEPEPV_dsp on AELD.LearnRefNumber = AEPEPV_dsp.LearnRefNumber AND AEPE.PriceEpisodeIdentifier = AEPEPV_dsp.PriceEpisodeIdentifier AND AEPEPV_dsp.AttributeName='PriceEpisodeSecondDisadvantagePayment'
			--MathEngOnProgPayment
			LEFT JOIN  [Rulebase].[AEC_LearningDelivery_PeriodisedValues] AELDPV_meopp on AELD.LearnRefNumber = AELDPV_meopp.LearnRefNumber AND AELD.AimSeqNumber = AELDPV_meopp.AimSeqNumber	AND AELDPV_meopp.AttributeName='MathEngOnProgPayment'
			--MathEngBalPayment
			LEFT JOIN  [Rulebase].[AEC_LearningDelivery_PeriodisedValues] AELDPV_mebp on AELD.LearnRefNumber = AELDPV_mebp.LearnRefNumber AND AELD.AimSeqNumber = AELDPV_mebp.AimSeqNumber	AND AELDPV_mebp.AttributeName='MathEngBalPayment'
			--PriceEpisodeFirstProv1618Pay
			LEFT JOIN  [Rulebase].[AEC_ApprenticeshipPriceEpisode_PeriodisedValues] AEPEPV_pefpp on AELD.LearnRefNumber = AEPEPV_pefpp.LearnRefNumber AND AEPE.PriceEpisodeIdentifier = AEPEPV_pefpp.PriceEpisodeIdentifier AND AEPEPV_pefpp.AttributeName='PriceEpisodeFirstProv1618Pay'
			--PriceEpisodeSecondProv1618Pay
			LEFT JOIN  [Rulebase].[AEC_ApprenticeshipPriceEpisode_PeriodisedValues] AEPEPV_pespp on AELD.LearnRefNumber = AEPEPV_pespp.LearnRefNumber AND AEPE.PriceEpisodeIdentifier = AEPEPV_pespp.PriceEpisodeIdentifier AND AEPEPV_pespp.AttributeName='PriceEpisodeSecondProv1618Pay'
			--PriceEpisodeFirstEmp1618Pay
			LEFT JOIN  [Rulebase].[AEC_ApprenticeshipPriceEpisode_PeriodisedValues] AEPEPV_pefep on AELD.LearnRefNumber = AEPEPV_pefep.LearnRefNumber AND AEPE.PriceEpisodeIdentifier = AEPEPV_pefep.PriceEpisodeIdentifier AND AEPEPV_pefep.AttributeName='PriceEpisodeFirstEmp1618Pay'
			--PriceEpisodeSecondEmp1618Pay
			LEFT JOIN  [Rulebase].[AEC_ApprenticeshipPriceEpisode_PeriodisedValues] AEPEPV_pesep on AELD.LearnRefNumber = AEPEPV_pesep.LearnRefNumber AND AEPE.PriceEpisodeIdentifier = AEPEPV_pesep.PriceEpisodeIdentifier AND AEPEPV_pesep.AttributeName='PriceEpisodeSecondEmp1618Pay'
			--PriceEpisodeApplic1618FrameworkUpliftOnProgPayment
			LEFT JOIN  [Rulebase].[AEC_ApprenticeshipPriceEpisode_PeriodisedValues] AEPEPV_pefuop on AELD.LearnRefNumber = AEPEPV_pefuop.LearnRefNumber AND AEPE.PriceEpisodeIdentifier = AEPEPV_pefuop.PriceEpisodeIdentifier AND AEPEPV_pefuop.AttributeName='PriceEpisodeApplic1618FrameworkUpliftOnProgPayment'
			--PriceEpisodeApplic1618FrameworkUpliftBalancing
			LEFT JOIN  [Rulebase].[AEC_ApprenticeshipPriceEpisode_PeriodisedValues] AEPEPV_pefub on AELD.LearnRefNumber = AEPEPV_pefub.LearnRefNumber AND AEPE.PriceEpisodeIdentifier = AEPEPV_pefub.PriceEpisodeIdentifier AND AEPEPV_pefub.AttributeName='PriceEpisodeApplic1618FrameworkUpliftBalancing'
			--PriceEpisodeApplic1618FrameworkUpliftCompletionPayment
			LEFT JOIN  [Rulebase].[AEC_ApprenticeshipPriceEpisode_PeriodisedValues] AEPEPV_pefucp on AELD.LearnRefNumber = AEPEPV_pefucp.LearnRefNumber AND AEPE.PriceEpisodeIdentifier = AEPEPV_pefucp.PriceEpisodeIdentifier AND AEPEPV_pefucp.AttributeName='PriceEpisodeApplic1618FrameworkUpliftCompletionPayment'
			--LSF Cash 
			LEFT JOIN 
			(
				SELECT LD.LearnRefNumber, LD.AimType, LD.AimSeqNumber, AEPE.PriceEpisodeIdentifier, AEPE.EpisodeStartDate,
				CASE WHEN  AELD.LearnDelMathEng = 1 THEN ISNULL(AELDPV_lsfc.Period_1 ,0.00000) ELSE  ISNULL(AEPEPV_lsfc.Period_1 ,0.00000) END AS Period_1,
				CASE WHEN  AELD.LearnDelMathEng = 1 THEN ISNULL(AELDPV_lsfc.Period_2 ,0.00000) ELSE  ISNULL(AEPEPV_lsfc.Period_2 ,0.00000) END AS Period_2,
				CASE WHEN  AELD.LearnDelMathEng = 1 THEN ISNULL(AELDPV_lsfc.Period_3 ,0.00000) ELSE  ISNULL(AEPEPV_lsfc.Period_3 ,0.00000) END AS Period_3,
				CASE WHEN  AELD.LearnDelMathEng = 1 THEN ISNULL(AELDPV_lsfc.Period_4 ,0.00000) ELSE  ISNULL(AEPEPV_lsfc.Period_4 ,0.00000) END AS Period_4,
				CASE WHEN  AELD.LearnDelMathEng = 1 THEN ISNULL(AELDPV_lsfc.Period_5 ,0.00000) ELSE  ISNULL(AEPEPV_lsfc.Period_5 ,0.00000) END AS Period_5,
				CASE WHEN  AELD.LearnDelMathEng = 1 THEN ISNULL(AELDPV_lsfc.Period_6 ,0.00000) ELSE  ISNULL(AEPEPV_lsfc.Period_6 ,0.00000) END AS Period_6,
				CASE WHEN  AELD.LearnDelMathEng = 1 THEN ISNULL(AELDPV_lsfc.Period_7 ,0.00000) ELSE  ISNULL(AEPEPV_lsfc.Period_7 ,0.00000) END AS Period_7,
				CASE WHEN  AELD.LearnDelMathEng = 1 THEN ISNULL(AELDPV_lsfc.Period_8 ,0.00000) ELSE  ISNULL(AEPEPV_lsfc.Period_8 ,0.00000) END AS Period_8,
				CASE WHEN  AELD.LearnDelMathEng = 1 THEN ISNULL(AELDPV_lsfc.Period_9 ,0.00000) ELSE  ISNULL(AEPEPV_lsfc.Period_9 ,0.00000) END AS Period_9,
				CASE WHEN  AELD.LearnDelMathEng = 1 THEN ISNULL(AELDPV_lsfc.Period_10,0.00000) ELSE  ISNULL(AEPEPV_lsfc.Period_10,0.00000) END AS Period_10,
				CASE WHEN  AELD.LearnDelMathEng = 1 THEN ISNULL(AELDPV_lsfc.Period_11,0.00000) ELSE  ISNULL(AEPEPV_lsfc.Period_11,0.00000) END AS Period_11,
				CASE WHEN  AELD.LearnDelMathEng = 1 THEN ISNULL(AELDPV_lsfc.Period_12,0.00000) ELSE  ISNULL(AEPEPV_lsfc.Period_12,0.00000) END AS Period_12
			FROM 
				[Valid].[LearningDelivery] LD
			LEFT JOIN  [Rulebase].[AEC_ApprenticeshipPriceEpisode] AEPE on LD.LearnRefNumber = AEPE.LearnRefNumber 
			AND aepe.PriceEpisodeAimSeqNumber = ld.AimSeqNumber
			and AEPE.EpisodeStartDate >= @YearStart and  AEPE.EpisodeStartDate <= @YearEnd
			LEFT JOIN  [Rulebase].[AEC_LearningDelivery] AELD on LD.LearnRefNumber = AELD.LearnRefNumber AND AELD.AimSeqNumber = LD.AimSeqNumber
			--LearnSuppFundCash
			LEFT JOIN  [Rulebase].[AEC_LearningDelivery_PeriodisedValues] AELDPV_lsfc on AELD.LearnRefNumber = AELDPV_lsfc.LearnRefNumber 
			AND AELD.AimSeqNumber = AELDPV_lsfc.AimSeqNumber	AND AELDPV_lsfc.AttributeName='LearnSuppFundCash'
			--PriceEpisodeLSFCash
			LEFT JOIN  [Rulebase].[AEC_ApprenticeshipPriceEpisode_PeriodisedValues] AEPEPV_lsfc on AELD.LearnRefNumber = AEPEPV_lsfc.LearnRefNumber 
			AND AEPE.PriceEpisodeIdentifier = AEPEPV_lsfc.PriceEpisodeIdentifier AND AEPEPV_lsfc.AttributeName='PriceEpisodeLSFCash'	
			) LSF ON LSF.LearnRefNumber = LD.LearnRefNumber AND LSF.AimSeqNumber = LD.AimSeqNumber AND ISNULL(AEPE.EpisodeStartDate, '1900/01/01') = ISNULL(LSF.EpisodeStartDate, '1900/01/01')
	) A

	END