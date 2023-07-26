IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'ivoryjoy_ivoryjoy_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [ivoryjoy_ivoryjoy_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://ivoryjoy@ivoryjoy.dfs.core.windows.net' 
	)
GO
CREATE EXTERNAL TABLE  dbo.fact_payment
WITH (
    LOCATION     = 'fact_payment',
   DATA_SOURCE = [ivoryjoy_ivoryjoy_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
) 

AS

SELECT
    payment_id,
    rider_id,
    date,
    amount
FROM dbo.staging_payment 


SELECT TOP 100 * FROM dbo.fact_payment;