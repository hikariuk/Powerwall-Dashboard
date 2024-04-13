# DDL
# Powerwall-Dashboard v4.2.1.1-cc
# 
# Version 4.2.1.1-cc: Added Solis Cloud data.
#
# Manual:
# docker exec --tty influxdb sh -c "influx -import -path=/var/lib/influxdb/run-once-4.2.1.1-cc.sql"
#
# USE powerwall
CREATE DATABASE powerwall

# Solis Cloud data
CREATE CONTINUOUS QUERY cq_soliscloud_strings ON powerwall BEGIN SELECT mean(data_uPv1) AS S1_Voltage, mean(data_iPv1) AS S1_Current, mean(data_pow1) AS S1_Power, mean(data_uPv2) AS S2_Voltage, mean(data_iPv2) AS S2_Current, mean(data_pow2) AS S2_Power INTO powerwall.strings.:MEASUREMENT FROM (SELECT data_uPv1, data_iPv1, data_pow1, data_uPv2, data_iPv2, data_pow2 FROM raw.inverterDetail) GROUP BY time(1m), month, year fill(linear) END
CREATE CONTINUOUS QUERY cq_soliscloud_grid ON powerwall BEGIN SELECT mean(data_uAc1) AS AC_Voltage, mean(data_iAc1) AS AC_Current, mean(data_fac) AS Grid_Frequency, mean(data_pac) AS RT_Power INTO powerwall.grid.:MEASUREMENT FROM (SELECT data_uAc1, data_iAc1, data_fac, data_pac FROM raw.inverterDetail) GROUP BY time(1m), month, year fill(linear) END
CREATE CONTINUOUS QUERY cq_soliscloud_alerts ON powerwall RESAMPLE FOR 2m BEGIN SELECT max(*) INTO powerwall.alerts.:MEASUREMENT FROM (SELECT * FROM raw.alarmList) GROUP BY time(1m), month, year END
