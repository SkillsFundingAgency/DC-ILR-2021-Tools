select
  UnrequiredAlias.UKPRN,
  LearnRefNumber,
  PriceEpisodeIdentifier,
  [Period],
  max(
    case
      AttributeName
      when 'PriceEpisodeApplic1618FrameworkUpliftBalancing' then Value
      else null
    end
  ) as PriceEpisodeApplic1618FrameworkUpliftBalancing,
  max(
    case
      AttributeName
      when 'PriceEpisodeApplic1618FrameworkUpliftCompletionPayment' then Value
      else null
    end
  ) as PriceEpisodeApplic1618FrameworkUpliftCompletionPayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeApplic1618FrameworkUpliftOnProgPayment' then Value
      else null
    end
  ) as PriceEpisodeApplic1618FrameworkUpliftOnProgPayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeBalancePayment' then Value
      else null
    end
  ) as PriceEpisodeBalancePayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeBalanceValue' then Value
      else null
    end
  ) as PriceEpisodeBalanceValue,
  max(
    case
      AttributeName
      when 'PriceEpisodeCompletionPayment' then Value
      else null
    end
  ) as PriceEpisodeCompletionPayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeFirstDisadvantagePayment' then Value
      else null
    end
  ) as PriceEpisodeFirstDisadvantagePayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeFirstEmp1618Pay' then Value
      else null
    end
  ) as PriceEpisodeFirstEmp1618Pay,
  max(
    case
      AttributeName
      when 'PriceEpisodeFirstProv1618Pay' then Value
      else null
    end
  ) as PriceEpisodeFirstProv1618Pay,
  max(
    case
      AttributeName
      when 'PriceEpisodeInstalmentsThisPeriod' then Value
      else null
    end
  ) as PriceEpisodeInstalmentsThisPeriod,
  max(
    case
      AttributeName
      when 'PriceEpisodeLearnerAdditionalPayment' then Value
      else null
    end
  ) as PriceEpisodeLearnerAdditionalPayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeLevyNonPayInd' then Value
      else null
    end
  ) as PriceEpisodeLevyNonPayInd,
  max(
    case
      AttributeName
      when 'PriceEpisodeLSFCash' then Value
      else null
    end
  ) as PriceEpisodeLSFCash,
  max(
    case
      AttributeName
      when 'PriceEpisodeOnProgPayment' then Value
      else null
    end
  ) as PriceEpisodeOnProgPayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeProgFundIndMaxEmpCont' then Value
      else null
    end
  ) as PriceEpisodeProgFundIndMaxEmpCont,
  max(
    case
      AttributeName
      when 'PriceEpisodeProgFundIndMinCoInvest' then Value
      else null
    end
  ) as PriceEpisodeProgFundIndMinCoInvest,
  max(
    case
      AttributeName
      when 'PriceEpisodeSecondDisadvantagePayment' then Value
      else null
    end
  ) as PriceEpisodeSecondDisadvantagePayment,
  max(
    case
      AttributeName
      when 'PriceEpisodeSecondEmp1618Pay' then Value
      else null
    end
  ) as PriceEpisodeSecondEmp1618Pay,
  max(
    case
      AttributeName
      when 'PriceEpisodeSecondProv1618Pay' then Value
      else null
    end
  ) as PriceEpisodeSecondProv1618Pay,
  max(
    case
      AttributeName
      when 'PriceEpisodeSFAContribPct' then Value
      else null
    end
  ) as PriceEpisodeSFAContribPct,
  max(
    case
      AttributeName
      when 'PriceEpisodeESFAContribPct' then Value
      else null
    end
  ) as PriceEpisodeESFAContribPct,
  max(
    case
      AttributeName
      when 'PriceEpisodeTotProgFunding' then Value
      else null
    end
  ) as PriceEpisodeTotProgFunding
from
  (
    select
    UKPRN,
      LearnRefNumber,
      PriceEpisodeIdentifier,
      AttributeName,
      cast(substring([PeriodValue].[Period], 8, 2) as int) as [Period],
      [PeriodValue].[Value]
    from
      Rulebase.AEC_ApprenticeshipPriceEpisode_PeriodisedValues unpivot (
        [Value] for [Period] in (
          Period_1,
          Period_2,
          Period_3,
          Period_4,
          Period_5,
          Period_6,
          Period_7,
          Period_8,
          Period_9,
          Period_10,
          Period_11,
          Period_12
        )
      ) as PeriodValue
  ) as UnrequiredAlias
  join dbo.UKPRNForProcedures ufp
	on ufp.UKPRN = UnrequiredAlias.UKPRN
group by
UnrequiredAlias.UKPRN,
  LearnRefNumber,
  PriceEpisodeIdentifier,
  [Period]
