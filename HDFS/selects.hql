--Select top 10  most frequently purchased categories

select productCategory, count(*) as cnt
from Purchases
group by productCategory
order by cnt desc limit 10;

--Select top 10 most frequently purchased product in each category

select productName, productCategory
from (
    select productName, cnt, productCategory, row_number() over (PARTITION BY productCategory ORDER BY cnt DESC) as rownum
    from (
        select productName, count(productName) as cnt, productCategory
        from Purchases
        group by productName, productCategory
        order by productCategory, cnt
    ) table
) table2
where rownum <= 10;

