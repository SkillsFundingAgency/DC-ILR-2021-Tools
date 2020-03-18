
 IF OBJECT_ID('Reference.OLASSEASResult') IS NOT NULL
BEGIN
    DROP TABLE  [Reference].[OLASSEASResult]
END;

  CREATE TABLE [Reference].[OLASSEASResult]
  (
	PaymentType NVARCHAR(250),
	PaymentValue	DECIMAL(12,2)
  )

--IF OBJECT_ID('Reference.PFR_EAS') IS NOT NULL
--BEGIN
--    DROP TABLE  [Reference].[PFR_EAS]
--END;

--  CREATE TABLE [Reference].[PFR_EAS]
--  (
--	Ukprn				NVARCHAR(10),
--	PaymentName			NVARCHAR(250),
--	PaymentValue		DECIMAL(12,2),
--	CollectionPeriod	INT
--  )

IF OBJECT_ID('Reference.PFR_OLASS') IS NOT NULL
BEGIN
    DROP TABLE  [Reference].[PFR_OLASS]
END;

  CREATE TABLE [Reference].[PFR_OLASS]
  (
	Ukprn				NVARCHAR(10),
	PaymentName			NVARCHAR(250),
	PaymentValue		DECIMAL(12,2),
	CollectionPeriod	INT
  )


  
  		
  GO

