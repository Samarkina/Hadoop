USE rdbms;

-- TopCategories
SELECT h.productCategory, h.cnt AS "Hive count", s.cnt AS "Spark count"
FROM hiveTopCategories as h
LEFT OUTER JOIN sparkTopCategories as s
ON h.productCategory = s.productCategory;

-- TopProducts
SELECT h.productName, h.productCategory, h.cnt as "Hive Count", s.cnt as "Spark Count", h.rownum as "Hive rownum", s.rownum as "Spark rownum"
FROM hiveTopProducts as h
LEFT OUTER JOIN sparkTopProducts AS s
ON h.productCategory = s.productCategory
AND h.productName = s.productName
ORDER BY h.productCategory, h.cnt DESC;

-- TopCountries
SELECT h.country_name, h.total AS "Hive total", s.total AS "Spark total"
FROM hiveTopCountries as h
LEFT OUTER JOIN sparkTopCountries as s
ON h.country_name = s.country_name
ORDER BY h.total DESC;