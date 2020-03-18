-- [Report].[EFAHNSSumaryReport] table
IF OBJECT_ID('[Report].[EFAHNSSumaryReport]') IS NOT NULL
BEGIN
    DROP TABLE  [Report].[EFAHNSSumaryReport]
END

CREATE TABLE [Report].[EFAHNSSumaryReport] (
	[StudentNumbers_A_A] INT,
	[StudentNumbers_A_B] INT,
	[StudentNumbers_A_C] INT,
	[StudentNumbers_A_D] INT,
	[StudentNumbers_A_E] INT,
	[StudentNumbers_A_F] INT,
	[StudentNumbers_B_A] INT,
	[StudentNumbers_B_B] INT,
	[StudentNumbers_B_C] INT,
	[StudentNumbers_B_D] INT,
	[StudentNumbers_B_E] INT,
	[StudentNumbers_B_F] INT,
	[StudentNumbers_C_A] INT,
	[StudentNumbers_C_B] INT,
	[StudentNumbers_C_C] INT,
	[StudentNumbers_C_D] INT,
	[StudentNumbers_C_E] INT,
	[StudentNumbers_C_F] INT,
	[StudentNumbers_D_A] INT,
	[StudentNumbers_D_B] INT,
	[StudentNumbers_D_C] INT,
	[StudentNumbers_D_D] INT,
	[StudentNumbers_D_E] INT,
	[StudentNumbers_D_F] INT,
	[StudentNumbers_E_A] INT,
	[StudentNumbers_E_B] INT,
	[StudentNumbers_E_C] INT,
	[StudentNumbers_E_D] INT,
	[StudentNumbers_E_E] INT,
	[StudentNumbers_E_F] INT,
	[HNS_Students_1624] INT
)
GO
