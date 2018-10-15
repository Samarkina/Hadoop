DELETE FILE /host/PycharmProjects/Hadoop/geoData/GeoData.csv;
DELETE FILE /host/PycharmProjects/Hadoop/geoData/udf.py;
ADD FILE /host/PycharmProjects/Hadoop/geoData/GeoData.csv;
ADD FILE /host/PycharmProjects/Hadoop/geoData/udf.py;

drop table if exists TopCountries;
create table TopCountries as
SELECT country_name, SUM(productPrice) as total
from (
    SELECT TRANSFORM (
    purchaseDate2,
    productName,
    productPrice,
    productCategory,
    clientIPAddress
    )
    USING 'python udf.py'
    AS (purchaseDate2 string,
    productName string,
    productPrice float,
    productCategory string,
    clientIPAddress string,
    network string,
    country_name string)
    FROM Purchases
    ) as table
GROUP BY country_name
ORDER BY total DESC
LIMIT 10;