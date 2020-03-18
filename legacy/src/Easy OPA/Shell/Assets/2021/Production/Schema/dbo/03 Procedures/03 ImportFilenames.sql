IF OBJECT_ID('ImportFilenames') IS NOT NULL
BEGIN
    DROP PROCEDURE  ImportFilenames
END
GO
CREATE PROCEDURE  ImportFilenames(@pipeSeperatedList  NVARCHAR(4000)) AS
BEGIN
	Declare @filename NVARCHAR(50) = NULL
	Declare @item NVARCHAR(50) = NULL
	WHILE LEN(@pipeSeperatedList) > 0
	BEGIN
		IF PATINDEX('%|%',@pipeSeperatedList) > 0
		BEGIN
			SET @filename = SUBSTRING(@pipeSeperatedList, 0, PATINDEX('%|%',@pipeSeperatedList))
			SET @pipeSeperatedList = SUBSTRING(@pipeSeperatedList, LEN(@filename + '|') + 1, LEN(@pipeSeperatedList))
		END
		ELSE
		BEGIN
			SET @filename = @pipeSeperatedList
			SET @pipeSeperatedList = NULL		
		END

		-- Import Filename
		IF (@filename IS NOT NULL)
		BEGIN			

			DECLARE @UKPRN NVARCHAR(8) = SUBSTRING(@filename, 5,8)
			DECLARE @Year NVARCHAR(4) = SUBSTRING(@filename, 14,4)
			DECLARE @DateYear NVARCHAR(4) = SUBSTRING(@filename, 19,4)
			DECLARE @DateMonth NVARCHAR(2) = SUBSTRING(@filename, 23,2)
			DECLARE @DateDay NVARCHAR(2) = SUBSTRING(@filename, 25, 2)
			DECLARE @DateHour NVARCHAR(2) = SUBSTRING(@filename, 28,2)
			DECLARE @DateMinute NVARCHAR(2) = SUBSTRING(@filename, 30, 2)
			DECLARE @DateSecond NVARCHAR(2) = SUBSTRING(@filename, 32, 2)
			DECLARE @SerialNumber NVARCHAR(2) = SUBSTRING(@filename, 35, 2)

			INSERT INTO [XML_FileNames] ([FileName], [FN03], [FN05], [FN06], [FN07]) VALUES 
			(
				@filename				
				,@UKPRN
				,@Year
				,@DateYear + '-' + @DateMonth + '-' + @DateDay  + ' ' + @DateHour + ':' + @DateMinute + ':' + @DateSecond
				,@SerialNumber
			)
						
		END	    
	END
END
GO


