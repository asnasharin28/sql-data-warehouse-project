USE DataWarehouse;

/* 
============================================================
DDL SCRIPT: CREATE BRONZE TABLES
------------------------------------------------------------
Purpose:
 - Create all tables inside the Bronze schema
 - Drop the tables if they already exist
 - This script prepares the Bronze layer for raw data ingestion
 - Safe to run multiple times
============================================================
*/


/* ---------------------------------------------------------
   TABLE 1: bronze.crm_cust_info
   Purpose: Stores raw customer details from CRM
--------------------------------------------------------- */
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info (
    cst_id              INT,
    cst_key             NVARCHAR(50),
    cst_firstname       NVARCHAR(50),
    cst_lastname        NVARCHAR(50),
    cst_marital_status  NVARCHAR(50),
    cst_gndr            NVARCHAR(50),
    cst_create_date     DATE
);
GO


/* ---------------------------------------------------------
   TABLE 2: bronze.crm_prd_info
   Purpose: Stores raw product information from CRM
--------------------------------------------------------- */
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50), 
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);
GO


/* ---------------------------------------------------------
   TABLE 3: bronze.crm_sales_details
   Purpose: Stores raw CRM sales transaction details
--------------------------------------------------------- */
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num   NVARCHAR(50),        
    sls_prd_key   NVARCHAR(50),
    sls_cust_id   INT,
    sls_order_dt  INT,
    sls_ship_dt   INT,
    sls_due_dt    INT,
    sls_sales     INT,
    sls_quantity  INT,
    sls_price     INT
);
GO


/* ---------------------------------------------------------
   TABLE 4: bronze.erp_cust_az12
   Purpose: Stores ERP customer demographic/identity data
--------------------------------------------------------- */
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);
GO


/* ---------------------------------------------------------
   TABLE 5: bronze.erp_loc_a101
   Purpose: Stores ERP customer location data
--------------------------------------------------------- */
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);
GO


/* ---------------------------------------------------------
   TABLE 6: bronze.erp_px_cat_g1v2
   Purpose: Stores ERP product category and attributes
--------------------------------------------------------- */
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);
GO


/* ---------------------------------------------------------
OPTIONAL: Execute initial Bronze Load (if data exists)
--------------------------------------------------------- */
EXEC bronze.load_bronze;
GO



/* 
============================================================
STORED PROCEDURE: bronze.load_bronze
------------------------------------------------------------
Purpose:
 - Truncate Bronze tables
 - Bulk insert CSV data into Bronze layer
 - Log start/end times for each table
 - Handle errors gracefully using TRY...CATCH
 - Designed for repeated daily batch loads
============================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze 
AS
BEGIN

    DECLARE @start_time DATETIME, 
            @end_time   DATETIME,
            @batch_start_time DATETIME,
            @batch_end_time   DATETIME;

    BEGIN TRY
        
        /* Start batch timer */
        SET @batch_start_time = GETDATE();

        PRINT '========================================';
        PRINT 'LOADING BRONZE LAYER';
        PRINT '========================================';


        /* -----------------------------------------------------
           CRM TABLE LOADING SECTION
        ----------------------------------------------------- */
        PRINT '-----------------------------------------';
        PRINT 'LOADING CRM TABLES';
        PRINT '-----------------------------------------';


        /* Table 1: crm_cust_info */
        SET @start_time = GETDATE();

        PRINT '>>TRUNCATING TABLE : bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>>INSERTING DATA INTO TABLE : bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\pc\Desktop\Data Analyst\MySQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------';


        /* Table 2: crm_prd_info */
        SET @start_time = GETDATE();

        PRINT '>>TRUNCATING TABLE : bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>>INSERTING DATA INTO TABLE : bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\pc\Desktop\Data Analyst\MySQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------';


        /* Table 3: crm_sales_details */
        SET @start_time = GETDATE();

        PRINT '>>TRUNCATING TABLE : bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>>INSERTING DATA INTO TABLE : bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\pc\Desktop\Data Analyst\MySQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------';



        /* -----------------------------------------------------
           ERP TABLE LOADING SECTION
        ----------------------------------------------------- */
        PRINT '-----------------------------------------';
        PRINT 'LOADING ERP TABLES';
        PRINT '-----------------------------------------';


        /* Table 4: erp_cust_az12 */
        SET @start_time = GETDATE();

        PRINT '>>TRUNCATING TABLE : bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>>INSERTING DATA INTO TABLE : bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\pc\Desktop\Data Analyst\MySQL\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------';


        /* Table 5: erp_loc_a101 */
        SET @start_time = GETDATE();

        PRINT '>>TRUNCATING TABLE : bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>>INSERTING DATA INTO TABLE : bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\pc\Desktop\Data Analyst\MySQL\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------';


        /* Table 6: erp_px_cat_g1v2 */
        SET @start_time = GETDATE();

        PRINT '>>TRUNCATING TABLE : bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>>INSERTING DATA INTO TABLE : bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\pc\Desktop\Data Analyst\MySQL\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------';


        /* Finish batch timer */
        SET @batch_end_time = GETDATE();

        PRINT '============================================';
        PRINT 'Loading Bronze layer is completed ';
        PRINT '>> -Total Load Duration : ' 
              + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) 
              + ' seconds';
        PRINT '============================================';

    END TRY 

    BEGIN CATCH 
        
        PRINT '==================================================';
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
        PRINT 'ERROR Message: ' + ERROR_MESSAGE();
        PRINT 'ERROR Number:  ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'ERROR State:   ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '==================================================';

    END CATCH

END;
GO
