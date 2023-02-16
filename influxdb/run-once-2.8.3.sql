# DDL
# Powerwall-Dashboard v2.8.3
# 
# Version 2.8.3 move alert data into the "alerts" retention policy. This script moves the
# existing data (in the "raw" retention policy) into the new "alerts" policy.
#
# Manual:
# docker exec --tty influxdb sh -c "influx -import -path=/var/lib/influxdb/run-once-2.8.3.sql"
#
# USE powerwall
SELECT * INTO "powerwall"."alerts"."alerts" FROM "powerwall"."raw"."alerts" GROUP BY *