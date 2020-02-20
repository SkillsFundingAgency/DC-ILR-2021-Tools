IF OBJECT_ID('Reference.FCSContract') IS NOT NULL
BEGIN
	DROP TABLE [Reference].[FCSContract]
END;
                
CREATE TABLE [Reference].[FCSContract]
(
	UKPRN						NVARCHAR(200),
	OrganisationIdentifier		NVARCHAR(10),
	FundingStreamPeriodCode		NVARCHAR(20),
	Period                      NVARCHAR(100),
	contractNumber              NVARCHAR(100),
    contractAllocationNumber    NVARCHAR(100)
)

-- TODO: Index