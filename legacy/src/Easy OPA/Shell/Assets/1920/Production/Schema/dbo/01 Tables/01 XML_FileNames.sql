IF OBJECT_ID('XML_FileNames') IS NOT NULL
BEGIN
    DROP TABLE  XML_FileNames
END;

  CREATE TABLE [XML_FileNames]
  (
    [FileName]			NVARCHAR(50) NOT NULL PRIMARY KEY,
    [FileFormat]		NVARCHAR(20)	DEFAULT('X'),
    [Amalgamated]		NVARCHAR(20)	DEFAULT('N'),
    [FN01]				NVARCHAR(3)		DEFAULT('ILR'),
    [FN01a]				NVARCHAR(1)		DEFAULT('-'),
    [FN02]				NVARCHAR(1)		DEFAULT('A'),	-- Transmission Type
    [FN02a]				NVARCHAR(1)		DEFAULT('-'),
    [FN03]				NVARCHAR(20),							-- UKPRN
    [FN03a]				NVARCHAR(1)		DEFAULT('-'),
    [FN05]				NVARCHAR(20)	DEFAULT(1213),  -- Collection Year
    [FN05a]				NVARCHAR(1)		DEFAULT('-'),
    [FN06]				NVARCHAR(25),						-- Date Time stamp
    [FN06a]				NVARCHAR(1)		DEFAULT('-'),
    [FN07]				NVARCHAR(3)		DEFAULT(1),		-- Serial Number
    [FN07a]				NVARCHAR(1)		DEFAULT('-'),
    [FN08]				NVARCHAR(3)		DEFAULT('XML')	-- File extension
  )
