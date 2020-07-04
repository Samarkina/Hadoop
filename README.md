# Migrating data to RDBMS with Hadoop and Spark

Description:

This project contains processing data with Flume-Hive-Sqoop-RDBMS and Flume-Spark-RDBMS flows.

Plan:
1. Implement Random Events producer
2. Configure Flume to consume events using NetCat Source
3. Create external Hive table to process data
4. Execute complex select queries
5. JOIN events with geodata
6. Put Hive queries result to RDBMS via SQOOP
7. Spark Core

### Running the project:

For run docker
```
docker system prune  
```

Cloudera 
```
cloudera-vm -v $(pwd):/host
```

Flume
```
./runFlume.sh
```

For creating data
```
./randomProducer/createData.sh 
```

For run the project
```
./run.sh
```
