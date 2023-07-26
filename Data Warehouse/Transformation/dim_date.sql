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
-- Create a new table to store the converted dates
-- Create the external table to store the converted dates

CREATE EXTERNAL TABLE dbo.dim_date
(
    date_id UNIQUEIDENTIFIER,
    [date] DATE,
    [day_of_week] INT,
    [day_of_month] INT,
    [week_of_year] INT,
    [month] INT,
    [quarter] INT,
    [year] INT
)
WITH (
	LOCATION = 'dim_date',
	DATA_SOURCE = [ivoryjoy_ivoryjoy_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO
-- Insert the converted data from the staging_date table
INSERT INTO dim_date (date_id, [date], [day_of_week], [day_of_month], [week_of_year], [month], [quarter], [year])
SELECT
    NEWID() AS date_id,
    CAST([date] AS DATE) AS [date],
    DATEPART(WEEKDAY, CAST([date] AS DATE)) AS [day_of_week],
    DATEPART(DAY, CAST([date] AS DATE)) AS [day_of_month],
    DATEPART(WEEK, CAST([date] AS DATE)) AS [week_of_year],
    DATEPART(MONTH, CAST([date] AS DATE)) AS [month],
    DATEPART(QUARTER, CAST([date] AS DATE)) AS [quarter],
    DATEPART(YEAR, CAST([date] AS DATE)) AS [year]
FROM dbo.staging_payment;

-- Retrieve top 100 records from the external date table
SELECT TOP 100 * FROM dbo.dim_date;

