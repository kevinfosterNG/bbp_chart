DECLARE @start_datetime DATETIME = '2015-02-01'
DECLARE @end_datetime DATETIME = '2015-03-01'

;WITH bbp_history_filtered (server_name, package_name, package_run_duration, package_run_datetime, package_finish_datetime) AS (
  SELECT server_name, package_name, package_run_duration, package_run_datetime, package_run_datetime+CONVERT(datetime,package_run_duration)
  FROM bbp_package_history
  WHERE package_run_datetime BETWEEN @start_datetime AND @end_datetime
  AND package_run_result<>''
)
SELECT 
'['''+server_name+''','''+package_name+''', new Date('
,datepart(yyyy,package_run_datetime),',',datepart(mm,package_run_datetime),',',datepart(dd,package_run_datetime),',',datepart(hh,package_run_datetime),',',datepart(mi,package_run_datetime),',',datepart(ss,package_run_datetime),',',0
,'), new Date(',datepart(yyyy,package_finish_datetime),',',datepart(mm,package_finish_datetime),',',datepart(dd,package_finish_datetime),',',datepart(hh,package_finish_datetime),',',datepart(mi,package_finish_datetime),',',datepart(ss,package_finish_datetime),',',0
,')],'
FROM bbp_history_filtered
ORDER BY package_run_duration