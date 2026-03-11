/*
================================================================================================================
Stored Procedure: Load Bronze Layer (Source > Bronze)
================================================================================================================
Script Purpose:
        This stored procedure loads data into the 'bronze' schema from external CSV files.
        It performs the following actions:
              -Truncates he bronze tables before loading data.
              -Uses the BULK INSERT command to load data from csv Files to bronze tables.
Parameters:
        None.
      This stored procedure does not accept any parameters or return any values.
      Usage Example:
        EXEC bronze.load_bronze;
==============================================================================================================
*/

create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime,@end_time datetime,@start_time_batch datetime,@end_time_batch datetime;
	set @start_time_batch = GETDATE();
	begin try
		print'==========================================';
		print'Loat At Bronze Layer';
		print'==========================================';

		print'-------------------------------------------';
		print'Loading crm Table';
		print'-------------------------------------------';

		set @start_time = getdate();
		print'>>>Truncating Table:bronze.crm_cust_info ';
		truncate table bronze.crm_cust_info;
		print'>>>Insert into Table:bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'C:\Users\DEV\Downloads\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		)
		set @end_time = GETDATE();
		print'>>Load Duration'+cast(datediff(second,@start_time,@end_time)as nvarchar) + 'second';
		print'>>----------------------------------------------------------------------------------';
		
		set  @start_time = getdate();
		print'>>>Truncating Table:bronze.crm_prd_info ';
		truncate table bronze.crm_prd_info;
		print'>>>Insert into Table:bronze.crm_prd_info';
		bulk insert bronze.crm_prd_info
		from 'C:\Users\DEV\Downloads\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print 'Load Duration'+ cast(datediff(second,@start_time,@end_time) as nvarchar)+'second';
		print'----------------------------------------------------------------------------------------';
		
		set @start_time = GETDATE();
		print'>>>Truncating Table:bronze.crm_sales_details ';
		truncate table bronze.crm_sales_details;
		print'>>>Insert into Table:bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'C:\Users\DEV\Downloads\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print'>>Load Duration:'+ cast(datediff(second,@start_time,@end_time)as nvarchar) + 'second';


		print'-------------------------------------------';
		print'Loading At erp Table';
		print'-------------------------------------------';

		set @start_time = GETDATE();
		print'>>>Trunacte Table:bronze.erp_erp_cus_AZ12';
		truncate table bronze.erp_cus_AZ12;
		print'>>>Inserting Data Into :bronze.erp_cust_AZ12';
		bulk insert bronze.erp_cus_AZ12
		from 'C:\Users\DEV\Downloads\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print'Load Duration:'+cast(datediff(second,@start_time,@end_time)as nvarchar) + 'second';
		print'-----------------------------------------------------------------------------------';


		set @start_time = GETDATE();
		print'>>>Truncate Table:bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101;
		print'>>>Inserting Data Into :bronze.erp_loc_a101';
		bulk insert bronze.erp_loc_a101
		from 'C:\Users\DEV\Downloads\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print'Load Duration:'+cast(datediff(second,@start_time,@end_time)as nvarchar)+ 'second';
		print'----------------------------------------------------------------------------------------';

		set @start_time = GETDATE(); 
		print'>>>Trunacte Table:bronze.erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2;
		print'>>>Inserting Data Into :bronze.erp_px_cat_g1v2';
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\DEV\Downloads\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = GETDATE();
		print'Load DUration:'+cast(datediff(second,@start_time,@end_time)as nvarchar) + 'Second';
		
		print'-------------------------------------------------------------------------------------';

		set @end_time_batch = GETDATE();
		print'Time Duration For Load Batch:'+ cast(datediff(second,@start_time_batch,@end_time_batch)as nvarchar) + 'Second';
	end try
	begin catch
		print'==================================================';
		print'Error Ocured DUring Loading At Bronze Layer';
		print'==================================================';
	end catch
	
end

