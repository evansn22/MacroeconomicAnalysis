USE fed_project;

-- Transforming observations on a Monthly Frequency into Quarterly Observations For Standardization
WITH quarterly_data AS (
SELECT indicator_name, unit_measure, i.indicator_id, YEAR(observation_date) AS YEAR, QUARTER(observation_date) AS QUARTER, AVG(indicator_value) AS VALUE
FROM indicator_values v JOIN indicators i ON v.indicator_id = i.indicator_id
GROUP BY indicator_id, QUARTER(observation_date), YEAR(observation_date)
),

-- Obtaining VALUE & Percentage Change Statistics For Each Observation
value_changes AS (
SELECT indicator_id, indicator_name, unit_measure, VALUE, YEAR, QUARTER,
VALUE - LAG(VALUE) OVER (PARTITION BY indicator_id ORDER BY YEAR, QUARTER) AS value_change 
FROM quarterly_data
),

percent_changes AS(
SELECT *,
value_change/LAG(VALUE) OVER (PARTITION BY indicator_id ORDER BY YEAR, QUARTER) percent_change
FROM value_changes
)
SELECT indicator_name,unit_measure, YEAR, QUARTER, VALUE, value_change, Concat((Round(percent_change*100,2)),'%') as percentageChange
FROM percent_changes
WHERE YEAR=2020 AND QUARTER <= 2
ORDER BY indicator_id;


-- Creating A Fully Standardized View For Modeling in Long & Short Formats
CREATE VIEW macroeconomic_modeling_quarterly AS
SELECT indicator_name, i.indicator_id, unit_measure, category, YEAR(observation_date) AS YEAR, QUARTER(observation_date) AS QUARTER, AVG(indicator_value) AS VALUE
FROM indicator_values v JOIN indicators i ON v.indicator_id = i.indicator_id
GROUP BY indicator_id, QUARTER(observation_date), YEAR(observation_date);

SELECT * FROM macroeconomic_modeling_quarterly
WHERE YEAR = 2020;

CREATE VIEW macroeconomic_modeling_long AS
SELECT YEAR, QUARTER, indicator_name, category,VALUE, unit_measure,
VALUE - LAG(VALUE) OVER (PARTITION BY indicator_name ORDER BY YEAR, QUARTER) AS value_change, 
(VALUE - LAG(VALUE) OVER (PARTITION BY indicator_name ORDER BY YEAR, QUARTER))/LAG(VALUE) OVER (PARTITION BY indicator_name 
ORDER BY YEAR, QUARTER) AS percent_change
FROM macroeconomic_modeling_quarterly;

SELECT * FROM macroeconomic_modeling_long
WHERE YEAR=2020;

CREATE VIEW macroeconomic_modeling_short AS
SELECT YEAR, QUARTER,
MAX(CASE WHEN indicator_name = 'Federal Funds Effective Rate' THEN VALUE END) AS fed_funds_rate,
MAX(CASE WHEN indicator_name = 'Consumer Price Index for All Urban Consumers: All Items in U.S. City Average' THEN VALUE END) AS cpi,
MAX(CASE WHEN indicator_name = 'Personal Consumption Expenditures' THEN VALUE END) AS pce,
MAX(CASE WHEN indicator_name = 'Unemployment Rate' THEN VALUE END) AS unemployment_rate,
MAX(CASE WHEN indicator_name = 'Real Gross Domestic Product' THEN VALUE END) AS gdp
FROM macroeconomic_modeling_long
GROUP BY QUARTER, YEAR;

SELECT * FROM macroeconomic_modeling_short
;

