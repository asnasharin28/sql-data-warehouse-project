USE DataWarehouse;

/* 
============================================================
DDL SCRIPT: CREATE BRONZE TABLES
------------------------------------------------------------
Purpose:
 - Drop and recreate all Bronze layer tables
 - Prepare schema for raw data ingestion
 - Safe to run multiple times
============================================================
*/

------------------------------------------------------------
-- TABLE 1: bronze.crm_cust_info
-- Purpose: Raw customer details from CRM
------------------------------------------------------------
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


------------------------------------------------------------
-- TABLE 2: bronze.crm_prd_info
-- Purpose: Raw product information from CRM
------------------------------------------------------------
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


------------------------------------------------------------
-- TABLE 3: bronze.crm_sales_details
-- Purpose: Raw CRM sales transactions
------------------------------------------------------------
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


------------------------------------------------------------
-- TABLE 4: bronze.erp_cust_az12
-- Purpose: ERP customer demographic information
------------------------------------------------------------
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);
GO


------------------------------------------------------------
-- TABLE 5: bronze.erp_loc_a101
-- Purpose: ERP customer location details
------------------------------------------------------------
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);
GO


------------------------------------------------------------
-- TABLE 6: bronze.erp_px_cat_g1v2
-- Purpose: ERP product category attributes
------------------------------------------------------------
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
