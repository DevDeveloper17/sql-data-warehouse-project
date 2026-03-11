/*
==================================================================
Create Database and Schemas
==================================================================
Script Purpose:
          This script creates a new database named 'DataWarehouse' after checking if it already exists.
          If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
          within the database: 'bronze', 'silver', and 'gold. 
WARNING:
Running this script will drop the entire 'DataWarehouse' database if it exists. 
All data in the database will be permanently deleted. Proceed with caution and 
ensure you have proper backups before running this script.
*/

use master;
go

--Drop and recreate 'datawarehouse' database 

if exists(select 1 from sys.database where name = 'datawarehouse')
begin
  alter databse datawarehouse set single_user with rollback immediate;
  drop datawarehouse;
end;
go

--create 'datawarehouse' database
create database datawarehouse;

--create datawarehouse database
use datawarehouse;

-- create  schema 
CREATE SCHEMA bronze
go
CREATE SCHEMA silver
go
CREATE SCHEMA gold;
