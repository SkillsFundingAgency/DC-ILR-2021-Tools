IF OBJECT_ID('StripSingleQuote') IS NOT NULL
BEGIN
    DROP FUNCTION StripSingleQuote
END
GO


CREATE FUNCTION [dbo].[StripSingleQuote] (@strStrip VARCHAR(MAX))
    RETURNS VARCHAR(MAX)
AS
BEGIN    
    RETURN (REPLACE(@strStrip ,'''''', ''''))
END

GO
