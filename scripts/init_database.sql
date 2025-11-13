/* 
DataWarehouse Initialization Script
-----------------------------------
This script resets and initializes the DataWarehouse environment.
It performs the following steps:

1. Drops the existing DataWarehouse database (if present)
2. Creates a fresh DataWarehouse database
3. Adds the standard data engineering schemas:
      - bronze : raw ingestion layer
      - silver : cleaned & transformed layer
      - gold   : analytics & reporting layer
*/


/* Drop the database if it already exists */
USE master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END
GO


/* Create the DataWarehouse database */
CREATE DATABASE DataWarehouse;
GO


/* Switch context to the new database */
USE DataWarehouse;
GO


/* Create data engineering layer schemas */
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
