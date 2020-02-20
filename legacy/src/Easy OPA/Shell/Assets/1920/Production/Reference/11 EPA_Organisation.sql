insert into Reference.EPAOrganisation (
	EPAOrgId,
	StandardCode
)
select	distinct
	OrgId,
	StandardCode
from	${EPAReferenceData.FQ}.dbo.OrganisationStandard
where	OrgId in (	select	EPAOrgID 
					from	Input.LearningDelivery)