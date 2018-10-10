DROP TABLE IF EXISTS GeoData;
CREATE EXTERNAL TABLE GeoData (
    network string,
    country_name string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/geoData';

select *
from GeoData;
