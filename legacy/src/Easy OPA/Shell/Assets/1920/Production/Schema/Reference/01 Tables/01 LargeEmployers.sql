IF OBJECT_ID('Reference.LargeEmployers') IS NOT NULL
BEGIN
	DROP TABLE [Reference].[LargeEmployers]
END;
                
CREATE TABLE [Reference].[LargeEmployers]
(
	ERN				NVARCHAR(9)
)

-- TODO: Index
