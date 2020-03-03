truncate table Reference.LARS_Standard
insert into Reference.LARS_Standard (
	EffectiveTo,
	StandardCode,
	NotionalEndLevel
)
select	distinct
		ls.EffectiveTo,
		ls.StandardCode,
		ls.NotionalEndLevel
from	${runmode.inputsource}.LearningDelivery
			inner join ReferenceInput.ReferenceInput.[LARS_LARSStandard] ls
				on ls.StandardCode = LearningDelivery.StdCode
go