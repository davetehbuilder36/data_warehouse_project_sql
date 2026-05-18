CREATE or ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '==================================================='
		PRINT 'Loading Bronze layer'
		PRINT '==================================================='

		PRINT '---------------------------------------------------'
		PRINT 'Loading crm tables'
		PRINT '---------------------------------------------------'
	
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\david\OneDrive\Desktop\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time ) AS NVARCHAR) + ' seconds.';
		-----------------------------------------------------------
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\david\OneDrive\Desktop\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time ) AS NVARCHAR) + ' seconds.';
		--------------------------------------------------------------------------------

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\david\OneDrive\Desktop\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time ) AS NVARCHAR) + ' seconds.';
		--------------------------------------------------------------------------------
		---------------------------------------------------------------------
		PRINT '---------------------------------------------------'
		PRINT 'Loading erp tables'
		PRINT '---------------------------------------------------'

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\david\OneDrive\Desktop\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time ) AS NVARCHAR) + ' seconds.';
		--------------------------------------------------------------------------------
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\david\OneDrive\Desktop\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time ) AS NVARCHAR) + ' seconds.';
		--------------------------------------------------------------------------------

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\david\OneDrive\Desktop\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time ) AS NVARCHAR) + ' seconds.';
		--------------------------------------------------------------------------------
	set @batch_end_time = GETDATE();
	PRINT '>> Loadind Data into the Brone layer took: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time ) AS NVARCHAR) + ' seconds';
	
	END TRY
	BEGIN CATCH
		PRINT '==================================================='
		PRINT 'Error occured during loading bronze layer'
		PRINT 'Error message: ' + ERROR_MESSAGE()
		PRINT 'Error number: ' + CAST(ERROR_NUMBER() AS NVARCHAR)
		PRINT '==================================================='
	END CATCH
END

EXEC [bronze].[load_bronze];
