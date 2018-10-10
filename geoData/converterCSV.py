import pandas as pd

t = pd.read_csv("GeoLite2-Country-Blocks-IPv4.csv")[["network", "geoname_id"]]\
    .set_index("geoname_id")
# print(t)
t2 = pd.read_csv("GeoLite2-Country-Locations-en.csv")[["country_name", "geoname_id"]]\
    .set_index("geoname_id")

result = t.join(t2, on="geoname_id").reset_index(drop=True).set_index("network")
result = result[~result.country_name.isna()]
print(result)
result.to_csv("GeoData.csv", header=None)