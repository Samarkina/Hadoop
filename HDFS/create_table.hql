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

ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2012/07/01') location '/flume/events/2012/07/01';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2012/07/02') location '/flume/events/2012/07/02';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2012/07/03') location '/flume/events/2012/07/03';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2012/07/04') location '/flume/events/2012/07/04';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2012/07/05') location '/flume/events/2012/07/05';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2012/07/06') location '/flume/events/2012/07/06';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2012/07/07') location '/flume/events/2012/07/07';

select *
from Purchases;