if exists (select * from sys.databases where name = '${TargetDataStore}') 
begin 
	begin try 
		drop database [${TargetDataStore}]
	end try 
	begin catch 
			alter database [Intrajob] set single_user with rollback immediate; 
			drop database [${TargetDataStore}]
	end catch 
end
go

create database [${TargetDataStore}]
go