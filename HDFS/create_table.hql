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

ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2016/04/01') location '/flume/events/2016/04/01';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2016/04/02') location '/flume/events/2016/04/02';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2016/04/03') location '/flume/events/2016/04/03';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2016/04/04') location '/flume/events/2016/04/04';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2016/04/05') location '/flume/events/2016/04/05';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2016/04/06') location '/flume/events/2016/04/06';
ALTER TABLE Purchases ADD PARTITION (purchaseDate = '2016/04/07') location '/flume/events/2016/04/07';

select *
from Purchases;