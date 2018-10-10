#!/usr/bin/env bash

hive -f ./HDFS/create_table.hql
hive -f ./HDFS/selects.hql
hive -f ./geoData/join.hql

service mysqld stop && (mysqld_safe --skip-grant-tables &) && sleep 2 && echo
mysql --user root -t < ./RDBMS/create_table.sql

./SQOOP/export_data.sh

mysql --user root -t < ./RDBMS/select.sql

hdfs dfs -mkdir /geoData
hdfs dfs -put /host/PycharmProjects/Hadoop/geoData/GeoData.csv /geoData/GeoData.csv

spark-submit ./Spark/spark.py

mysql --user root -t < ./RDBMS/validate.sql
