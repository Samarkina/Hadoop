from pyspark import SparkContext
from pyspark.sql import HiveContext, SQLContext, Row
from pyspark.sql.functions import col, lit, row_number, udf, sum
from pyspark.sql.types import StringType, IntegerType, LongType
from pyspark.sql.window import Window

def writeMYSQL(df, table):
    return df.write.jdbc(
        url="jdbc:mysql://localhost:3306/rdbms",
        table=table,
        mode="overwrite",
        properties={
            "user": "root"
        }
    )

# Initializing Spark
sc = SparkContext()
sc.setLogLevel("WARN")

rdd = sc.sequenceFile("hdfs:///flume/events/*/*/*").map(lambda x: Row(*x[1].split(",")))
sqlContext = HiveContext(sc)

df = sqlContext.createDataFrame(rdd, ["purchaseDate2", "productName", "productPrice", "productCategory", "clientIPAddress"]).cache()

#sparkTopCategories
topCategories = df.groupBy("productCategory")\
    .count()\
    .select(col("productCategory"), col("count").alias("cnt"))\
    .orderBy(col("count").desc())\
    .limit(10)
topCategories.show()
writeMYSQL(topCategories, "sparkTopCategories")

#sparkTopProducts
topProducts = df.groupBy("productCategory", "productName")\
    .count()\
    .orderBy(col("productName").asc(), col("productCategory").asc(), col("count").desc())\
    .withColumn("rownum",
                row_number().over(
                    Window
                        .partitionBy("productCategory")
                        .orderBy(col("count").desc())
                ))\
    .where(col("rownum") <= lit(10))\
    .select(col("productName"), col("productCategory"), col("count").alias("cnt"), col("rownum"))
topProducts.show()
writeMYSQL(topProducts, "sparkTopProducts")

#sparkTopCountries
def udfFunc():
    import socket, struct, bisect
    def addressInNetwork(ipaddr, netmask):
        return ipaddr & netmask == netmask

    def net2dec(network):
        netaddr, bits = network.split('/')
        netmask = struct.unpack('!I', socket.inet_aton(netaddr))[0] & ((0xffffffff << (32 - int(bits))) & 0xffffffff)
        return netmask

    def listOne(geolite):
        geolite0 = []
        for string in geolite:
            geolite0.append(string[0])
        return geolite0

    geolite = sc.textFile("hdfs:///geoData/GeoData.csv").map(lambda x: x.split(",", 1)).map(lambda x: (net2dec(x[0]), x[1], x[0])).collect()
    geolite.sort()
    geolite0 = listOne(geolite)

    def i2c(clientIPAddress):
        ipaddr = struct.unpack('!I', socket.inet_aton(clientIPAddress))[0]
        pos = bisect.bisect_left(geolite0, ipaddr) - 1
        if addressInNetwork(ipaddr, geolite[pos][0]):
            return geolite[pos][1]
        else:
            return "Kateland"

    return udf(i2c, StringType())

dfIpToCountry = udfFunc()

topCountries = df.select(col("productPrice"), dfIpToCountry(col("clientIPAddress")).alias("country_name"))\
    .cache()\
    .groupBy("country_name")\
    .agg(sum(col("productPrice")).alias("total"))\
    .orderBy(col("total").desc())\
    .limit(10)

topCountries.show()
writeMYSQL(topCountries, "sparkTopCountries")
