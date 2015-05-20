/******************* 
Deepak Luitel
Database Design
CMSC 424
Spring 2015
********************/

/*Query:1*/
WITH tmp AS (SELECT country, count(country) count 
              FROM organization 
              GROUP BY country) 
SELECT DISTINCT country.name, tmp.count 
FROM tmp, country 
WHERE tmp.country = country.code AND count > 1 
ORDER BY country.name;

/*Query 2*/
WITH tmp AS (SELECT country, count(country) count 
              FROM organization 
              GROUP BY country),
     names AS (SELECT max(count) num 
                FROM tmp) 
SELECT country.name, names.num 
FROM names, tmp, country 
WHERE tmp.count = names.num AND country.code = tmp.country;
     
/*Query:3*/          
WITH tmp as (SELECT code 
              FROM country 
              WHERE name = 'Poland'),
      names(code) as (SELECT country1 
                      FROM borders,tmp 
                      WHERE country2 = code UNION 
                      SELECT country2 
                      FROM borders,tmp 
                      WHERE country1 = code)
SELECT country.name FROM country, names WHERE country.code = names.code;

/*Query 4*/
WITH tmp as (SELECT code 
              FROM country 
              WHERE name = 'Poland'),
     names(code) as (SELECT country1 
                      FROM borders,tmp 
                      WHERE borders.country2 = tmp.code UNION 
                    SELECT country2 
                      FROM borders,tmp 
                      WHERE borders.country1 = tmp.code),
     sec(code) as (SELECT country1 
                      FROM borders,names 
                      WHERE borders.country2 = names.code UNION 
                  SELECT country2 
                      FROM borders,names 
                      WHERE borders.country1 = names.code)
SELECT country.name 
FROM country, sec 
WHERE country.code = sec.code AND country.name<>'Poland';

/*Query 5*/
WITH tmp AS (SELECT code 
              FROM country 
              WHERE name = 'Poland'),
     zero(code) AS (SELECT country1 
                      FROM borders,tmp 
                      WHERE borders.COUNTRY2 = tmp.code UNION 
                    SELECT country2 
                      FROM borders,tmp 
                      WHERE borders.COUNTRY1 = tmp.code),
     one(code) AS (SELECT country1 
                      FROM borders,zero 
                      WHERE borders.COUNTRY2 = zero.code UNION 
                  SELECT country2 
                      FROM borders,zero 
                      WHERE borders.COUNTRY1 = zero.code),
     one_only(code) AS (SELECT * 
                          FROM one MINUS 
                        SELECT * 
                          FROM zero)
SELECT country.name 
FROM country,one_only 
WHERE country.code = one_only.code AND country.name<>'Poland';

/*Query 6*/
WITH tmp AS (SELECT DISTINCT sea, country 
              FROM geo_sea),
    tmp1 AS (Select DISTINCT tmp.sea, tmp.country, economy.gdp 
              FROM tmp JOIN economy ON tmp.country = economy.country)
SELECT sea, count(country) num, sum(tmp1.gdp) GDP 
FROM tmp1 
GROUP BY sea 
ORDER BY num DESC;


/*Query 7*/
WITH tmp AS (SELECT river, count(country) num 
              FROM geo_river 
              GROUP BY river)
SELECT river, num AS "Num Countries" 
FROM tmp 
WHERE num =(SELECT max(num) FROM tmp);

/*Query 8*/
WITH tmp AS (SELECT river, count(city) num 
              FROM located 
              WHERE river IS NOT NULL 
              GROUP BY river)
SELECT river, num AS "Num Countries" 
FROM tmp 
WHERE num =(SELECT max(num) FROM tmp);

/*Query 9*/
SELECT DISTINCT sea1 AS seas
      FROM mergeswith 
      WHERE sea2 = 'Mediterranean Sea' 
UNION
SELECT DISTINCT sea2
      FROM mergeswith
      WHERE sea1 = 'Mediterranean Sea';

/*Query 10*/
CREATE TABLE Country_Border (
  Country_name  varchar(100),
  Length        int);
  
INSERT INTO Country_Border 
(SELECT name, length 
  FROM borders, country WHERE country1=country.code
UNION ALL
  SELECT name, length 
  FROM borders, country WHERE country2=country.code);

/*Query 11*/
DELETE FROM country_border
WHERE country_name IN (SELECT country_name 
                        FROM country_border 
                        GROUP BY country_name 
                        HAVING count(length) = 1);



