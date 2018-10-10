USE rdbms;

select * from hiveTopCategories order by cnt desc;
select * from hiveTopProducts order by productCategory, cnt desc;
select * from hiveTopCountries;

select * from sparkTopCategories order by cnt desc;
select * from sparkTopProducts order by productCategory, cnt desc;
select * from sparkTopCountries;