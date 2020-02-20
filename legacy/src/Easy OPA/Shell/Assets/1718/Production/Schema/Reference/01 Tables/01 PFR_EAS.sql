IF OBJECT_ID('Reference.PFR_EAS') IS NOT NULL
BEGIN
    DROP TABLE  [Reference].[PFR_EAS]
END;

CREATE TABLE [Reference].[PFR_EAS]
(
	Ukprn				NVARCHAR(10),
	PaymentName			NVARCHAR(250),
	PaymentValue		DECIMAL(12,2),
	CollectionPeriod	INT
)