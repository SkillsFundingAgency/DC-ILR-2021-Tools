if exists(select 1 from sys.tables where object_id = object_id('dbo.File'))
begin
	DROP TABLE [dbo].[File]
end
go

CREATE TABLE [dbo].[File]([FileID] [int] IDENTITY(1,1) NOT NULL, [FileName] [varchar](55) NULL) ON [PRIMARY]
go