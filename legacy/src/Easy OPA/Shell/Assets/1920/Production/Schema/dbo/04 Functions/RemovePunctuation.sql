IF OBJECT_ID('RemovePunctuation') IS NOT NULL
BEGIN
    DROP FUNCTION  RemovePunctuation
END
GO

CREATE FUNCTION RemovePunctuation 
(
@String1 nvarchar(4000)
) RETURNS nvarchar(4000)
AS BEGIN

DECLARE @tmp1   NVARCHAR(4000)     
SELECT @tmp1 = @string1

       -- replace spaces, hyphens, apostrophes, commas and full-stops  and then do a comparision


       SELECT @tmp1 = 
                     REPLACE                                  -- fullstops
                     (
                           REPLACE                           -- commas
                           (
                                  REPLACE                    -- apostrophes
                                  (
                                         REPLACE              -- hyphens
                                         (
                                                REPLACE -- spaces
                                                (
                                                       @string1
                                                       , N' '
                                                       , ''
                                                )
                                                ,N'-'
                                                , ''
                                         )
                                         ,N''''
                                         ,''
                                  )
                                  ,N','
                                  ,''
                           )
                           ,N'.'
                           ,''
                     )
return @tmp1;
END
