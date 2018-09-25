DROP TABLE IF EXISTS Purchases;
CREATE EXTERNAL TABLE Purchases (
    purchaseDate2 string,
    productName string,
    productPrice float,
    productCategory string,
    clientIPAddress string
)  PARTITIONED BY (purchaseDate string)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS SEQUENCEFILE
LOCATION '/flume/events/';

ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2015/01/01') location '/flume/events/2015/01/01';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2015/01/02') location '/flume/events/2015/01/02';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2015/01/03') location '/flume/events/2015/01/03';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2015/01/04') location '/flume/events/2015/01/04';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2015/01/05') location '/flume/events/2015/01/05';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2015/01/06') location '/flume/events/2015/01/06';

select *
from Purchases;