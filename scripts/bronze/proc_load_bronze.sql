/* 
============================================================
STORED PROCEDURE: bronze.load_bronze
------------------------------------------------------------
Purpose:
 - Load raw source files into Bronze layer tables.
 - Performs TRUNCATE + BULK INSERT for all Bronze tables.
 - Tracks load duration for each table and the entire batch.
 - Includes TRY...CATCH error handling for safe execution.

Execution Notes:
 - This procedure uses BULK INSERT commands to load CSV files.
 - It DOES NOT accept any input parameters.
 - Designed for daily/periodic batch ingestion of raw data.

How to Execute:
    EXEC bronze.load_bronze;

Prerequisites:
 - CSV source files must exist in the specified file paths.
 - File format: comma-separated (FIELDTERMINATOR = ',')
 - Run under a SQL Server account with BULK INSERT permission.

============================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze 
AS
BEGIN

    DECLARE @start_time        DATETIME, 
            @end_time          DATETIME,
            @batch_start_time  DATETIME,
            @batch_end_time    DATETIME;

    BEGIN TRY
        
        SET @batch_start_time = GETDATE();

        PRINT '========================================';
        PRINT 'LOADING BRONZE LAYER';
        PRINT '========================================';


        -----------------------------------------------------
        -- LOADING CRM TABLES
        -----------------------------------------------------
        PRINT '-----------------------------------------';
        PRINT 'LOADING CRM TABLES';
        PRINT '-----------------------------------------';


        ------------------------- 1 -------------------------
        SET @start_time = GETDATE();

        PRINT '>>TRUNCATING TABLE : bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>>INSERTING DATA INTO TABLE : bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\pc\Desktop\Data Analyst\MySQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' 
            + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------';


        ------------------------- 2 -------------------------
        SET @start_time = GETDATE();

        PRINT '>>TRUNCATING TABLE : bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>>INSERTING DATA INTO TABLE : bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\pc\Desktop\Data Analyst\MySQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' 
            + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------';


        ------------------------- 3 -------------------------
        SET @start_time = GETDATE();

        PRINT '>>TRUNCATING TABLE : bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>>INSERTING DATA INTO TABLE : bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\pc\Desktop\Data Analyst\MySQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' 
            + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------';



        -----------------------------------------------------
        -- LOADING ERP TABLES
        -----------------------------------------------------
        PRINT '-----------------------------------------';
        PRINT 'LOADING ERP TABLES';
        PRINT '-----------------------------------------';


        ------------------------- 4 -------------------------
        SET @start_time = GETDATE();

        PRINT '>>TRUNCATING TABLE : bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>>INSERTING DATA INTO TABLE : bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\pc\Desktop\Data Analyst\MySQL\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' 
            + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------';


        ------------------------- 5 -------------------------
        SET @start_time = GETDATE();

        PRINT '>>TRUNCATING TABLE : bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>>INSERTING DATA INTO TABLE : bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\pc\Desktop\Data Analyst\MySQL\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' 
            + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------';


        ------------------------- 6 -------------------------
        SET @start_time = GETDATE();

        PRINT '>>TRUNCATING TABLE : bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>>INSERTING DATA INTO TABLE : bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\pc\Desktop\Data Analyst\MySQL\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        WITH ( FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' 
            + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
        PRINT '--------------------------------';

       
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
