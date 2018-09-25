--Select top 10  most frequently purchased categories

select productCategory, count(*) as cnt
from Purchases
group by productCategory
order by cnt desc limit 10;

--Select top 10 most frequently purchased product in each category
select productCategory, count(*) as cnt
from Purchases
group by productCategory
order by cnt desc limit 10;