CREATE DATABASE ENERGYDB2;
USE ENERGYDB2;
-- 1. country table
CREATE TABLE country (
    CID VARCHAR(10) PRIMARY KEY,
    Country VARCHAR(100) UNIQUE
);

SELECT * FROM COUNTRY;

-- 2. emission_3 table
CREATE TABLE emission_3 (
    country VARCHAR(100),
    energy_type VARCHAR(50),
    year INT,
    emission INT,
    per_capita_emission DOUBLE,
    FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM EMISSION_3;


-- 3. population table
CREATE TABLE population (
    countries VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (countries) REFERENCES country(Country)
);

SELECT * FROM POPULATION;

-- 4. production table
CREATE TABLE production (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    production INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);


SELECT * FROM PRODUCTION;

-- 5. gdp_3 table
CREATE TABLE gdp_3 (
    Country VARCHAR(100),
    year INT,
    Value DOUBLE,
    FOREIGN KEY (Country) REFERENCES country(Country)
);

SELECT * FROM GDP_3;

-- 6. consumption table
CREATE TABLE consumption (
    country VARCHAR(100),
    energy VARCHAR(50),
    year INT,
    consumption INT,
    FOREIGN KEY (country) REFERENCES country(Country)
);

SELECT * FROM CONSUMPTION;

-- 1. Total emission per country for the most recent year available
SELECT
    country,
    SUM(emission) AS total_emission
FROM emission_3
WHERE year = (SELECT MAX(year) FROM emission_3)
GROUP BY country
ORDER BY total_emission DESC;

-- 2. Top 5 countries by GDP in the most recent year
SELECT
    Country,
    Value AS GDP
FROM gdp_3
WHERE year = (SELECT MAX(year) FROM gdp_3)
ORDER BY Value DESC
LIMIT 5;

-- 3. Compare energy production and consumption by country and year
SELECT
    p.country,
    p.year,
    p.energy,
    p.production,
    c.consumption,
    (p.production - c.consumption) AS difference
FROM production p
JOIN consumption c
ON p.country = c.country
AND p.year = c.year
AND p.energy = c.energy
ORDER BY p.country, p.year;

-- 4. Which energy types contribute most to emissions?
SELECT
    energy_type,
    SUM(emission) AS total_emission
FROM emission_3
GROUP BY energy_type
ORDER BY total_emission DESC;

-- 5. Global emissions year over year
SELECT
    year,
    SUM(emission) AS global_emission
FROM emission_3
GROUP BY year
ORDER BY year;

-- 6. GDP trend for each country
SELECT
    Country,
    year,
    Value AS GDP
FROM gdp_3
ORDER BY Country, year;

-- 7. Population growth vs total emissions
SELECT
    e.country,
    e.year,
    p.Value AS population,
    SUM(e.emission) AS total_emission
FROM emission_3 e
JOIN population p
ON e.country = p.countries
AND e.year = p.year
GROUP BY e.country, e.year, p.Value
ORDER BY e.country, e.year;
-- 8. Energy consumption trend over years
SELECT
    country,
    year,
    SUM(consumption) AS total_consumption
FROM consumption
GROUP BY country, year
ORDER BY country, year;

-- 9. Average yearly change in per capita emissions
WITH emission_change AS
(
SELECT
country,
year,
per_capita_emission,
per_capita_emission -
LAG(per_capita_emission)
OVER(PARTITION BY country ORDER BY year) AS yearly_change
FROM emission_3
)

SELECT
country,
AVG(yearly_change) AS avg_yearly_change
FROM emission_change
GROUP BY country;

-- 10. Emission-to-GDP ratio
SELECT
e.country,
e.year,
SUM(e.emission)/g.Value AS emission_gdp_ratio
FROM emission_3 e
JOIN gdp_3 g
ON e.country=g.Country
AND e.year=g.year
GROUP BY e.country,e.year,g.Value
ORDER BY emission_gdp_ratio DESC;

-- 11. Energy consumption per capita
SELECT
c.country,
c.year,
SUM(c.consumption)/p.Value AS consumption_per_capita
FROM consumption c
JOIN population p
ON c.country=p.countries
AND c.year=p.year
GROUP BY c.country,c.year,p.Value
ORDER BY c.country,c.year;

-- 12. Energy production per capita
SELECT
pr.country,
pr.year,
SUM(pr.production)/po.Value AS production_per_capita
FROM production pr
JOIN population po
ON pr.country=po.countries
AND pr.year=po.year
GROUP BY pr.country,pr.year,po.Value
ORDER BY pr.country,pr.year;

-- 13. Countries with highest energy consumption relative to GDP
SELECT
c.country,
c.year,
SUM(c.consumption)/g.Value AS consumption_gdp_ratio
FROM consumption c
JOIN gdp_3 g
ON c.country=g.Country
AND c.year=g.year
GROUP BY c.country,c.year,g.Value
ORDER BY consumption_gdp_ratio DESC;

-- 14. GDP growth vs Production growth
WITH GDPGrowth AS
(
SELECT
Country,
year,
Value,
Value -
LAG(Value)
OVER(PARTITION BY Country ORDER BY year) AS GDP_Growth
FROM gdp_3
),

ProductionGrowth AS
(
SELECT
country,
year,
SUM(production) AS production,
SUM(production) -
LAG(SUM(production))
OVER(PARTITION BY country ORDER BY year) AS Production_Growth
FROM production
GROUP BY country,year
)

SELECT
g.Country,
g.year,
g.GDP_Growth,
p.Production_Growth
FROM GDPGrowth g
JOIN ProductionGrowth p
ON g.Country=p.country
AND g.year=p.year;

-- 15. Top 10 countries by population and emissions
SELECT
p.countries,
p.year,
p.Value AS population,
SUM(e.emission) AS total_emission
FROM population p
JOIN emission_3 e
ON p.countries=e.country
AND p.year=e.year
GROUP BY p.countries,p.year,p.Value
ORDER BY population DESC
LIMIT 10;
-- 16. Countries that reduced per capita emissions the most
SELECT
    e1.country,
    (e1.per_capita_emission - e2.per_capita_emission) AS reduction
FROM emission_3 e1
JOIN emission_3 e2
ON e1.country = e2.country
WHERE e1.year = (
    SELECT MIN(year)FROM emission_3
    WHERE country = e1.country
)
AND e2.year = (
    SELECT MAX(year)
    FROM emission_3
    WHERE country = e2.country
)
ORDER BY reduction DESC;
-- 17. Global share (%) of emissions
SELECT
country,
SUM(emission) AS total_emission,
ROUND(
SUM(emission)/
(SELECT SUM(emission) FROM emission_3)*100,2
) AS global_share_percentage
FROM emission_3
GROUP BY country
ORDER BY global_share_percentage DESC;

-- 18. Global average GDP, emission and population
SELECT
g.year,

AVG(g.Value) AS avg_gdp,

AVG(e.emission) AS avg_emission,

AVG(p.Value) AS avg_population

FROM gdp_3 g

JOIN emission_3 e
ON g.Country=e.country
AND g.year=e.year

JOIN population p
ON g.Country=p.countries
AND g.year=p.year

GROUP BY g.year
ORDER BY g.year;




