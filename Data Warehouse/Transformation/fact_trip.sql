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
CREATE EXTERNAL TABLE  dbo.fact_trip
WITH (
    LOCATION     = 'fact_trip',
   DATA_SOURCE = [ivoryjoy_ivoryjoy_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
) 
AS
SELECT 
    st.trip_id,
    st.rider_id,
    st.start_station_id, 
    st.end_station_id, 
    st.start_at AS start_time_id,    
    st.ended_at AS end_time_id,
    st.rideable_type,
    DATEDIFF(second, st.start_at, st.ended_at) AS trip_duration,
    DATEDIFF(year, sr.birthday, st.start_at) AS rider_age
FROM 
    staging_trip st
JOIN staging_rider1 sr ON sr.rider_id = st.rider_id;

SELECT TOP 100 * FROM dbo.fact_trip;

