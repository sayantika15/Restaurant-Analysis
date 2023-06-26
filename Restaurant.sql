create database myproject;
use myproject;
select * from restinfo ;
select * from foodcategory ;

-- 1. What is the Average longitude and latitude of each restaurant?
SELECT distinct(name),
round(avg(latitude),2) as AvgLat, 
round(avg(longitude),2) as AvgLong
FROM restinfo
group by name with Rollup
order by name ;

-- 2. What are the Fast food restaurants per capita for all state.
select postalcode, count(*) as `Count of Fastfood Restaurant`
from foodcategory
where categories like "%Fast food%"
group by categories,postalcode
order by `Count of Fastfood Restaurant` desc;

-- 3. How many restaurants have unique names?
with unqnames as(select name,Count(*) as Occurance
from restinfo
group by name
having Occurance = 1)

select count(*) as `Unique Names` from unqnames;

-- 4. What are the top 10 most common categories of food served by the restaurants?
SELECT distinct(categories),name, COUNT(*) AS num_of_restaurants 
FROM foodcategory 
GROUP BY categories, name
ORDER BY num_of_restaurants DESC 
LIMIT 10;

-- 5.What are the names of the restaurants that have been updated in the month of May 2019?
select name,`New Date Updated`
from foodcategory
where `New Date Updated`>"2019-05-01" and `New Date Updated`<"2019-05-31";

alter table foodcategory add column `New Date Updated` date;

update foodcategory
set `New Date Updated` = str_to_date(dateUpdated, "%d-%m-%Y");

-- 6. How many Bars and Pubs are there in each city? Mention their names.
select f.name, r.city , count(distinct f.name) as `Bars`
from foodcategory f inner join restinfo r using (ID)
where categories = "Bars & Pubs" 
group by f.name, r.city ;



-- 7. How many restaurants are there in each province?
select distinct(name), province,count(*) as `Provincewise Restaurant` 
from restinfo
group by name ,province
order by `Provincewise Restaurant` desc;
