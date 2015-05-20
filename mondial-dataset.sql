/*********************** 
Author: Deepak Luitel
Assignment Part 2: SQL 
CMSC424 Database Design
Spring 2015
***********************/

/*Question no:1*/
SELECT name "Name", area "Sq kms", area*0.386102 "Sq miles" 
FROM continent;

/*Question no:2*/
SELECT DISTINCT c.name Name, c.population Population, 
        co.name country, co.population "COUNTRY POP"
FROM city c, country co 
WHERE c.country = co.code ORDER by c.population;

/*Question no:3*/
SELECT DISTINCT co.NAME "Countries in Europe" 
FROM country co JOIN encompasses en
ON co.CODE = en.COUNTRY
WHERE en.CONTINENT = 'Europe'; 
    
/*Question no:4*/
WITH tmp as (SELECT DISTINCT Country.NAME COUNTRY, org.NAME ORGANIZATION, 
      Country.CAPITAL, org.CITY "HQ City", country.CODE CODE 
      FROM Organization org LEFT JOIN country ON org.country = country.code)
SELECT DISTINCT tmp.COUNTRY, tmp.Organization, tmp.CAPITAL, 
      city.population "CAPITAL POPULATION", tmp."HQ City" 
FROM tmp LEFT JOIN City 
ON tmp.CAPITAL = city.NAME AND tmp.CODE = city.COUNTRY;

/*Question no:5*/
WITH tmp as (SELECT Country.NAME Country, Encompasses.CONTINENT, 
    Encompasses.PERCENTAGE*Country.AREA "INCLUDED AREA"
    FROM Country LEFT JOIN Encompasses ON Country.CODE = Encompasses.COUNTRY) 
SELECT DISTINCT tmp.COUNTRY, tmp.CONTINENT,tmp."INCLUDED AREA" 
FROM tmp 
ORDER BY tmp."INCLUDED AREA" DESC;



