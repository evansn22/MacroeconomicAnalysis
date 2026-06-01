USE fed_project;

-- Calculating the number of observations for each indicator type
SELECT indicator_name, count(*) as observations 
FROM indicator_values JOIN indicators ON indicator_values.indicator_id = indicators.indicator_id 
GROUP BY indicator_name;

-- Querying for Most Recent & Oldest Date
SELECT indicator_name , max(observation_date) as most_recent, min(observation_date) as oldest
FROM indicator_values JOIN indicators ON indicator_values.indicator_id = indicators.indicator_id 
GROUP BY indicator_name, indicators.indicator_id;

-- Checking for NULL values in IndicatorValues table
SELECT * 
FROM indicator_values
WHERE indicator_value is Null;

-- Confirming no duplicate observations are present
SELECT indicator_id, observation_date, count(*) as cnt
FROM indicator_values
GROUP BY indicator_id, observation_date
HAVING cnt!=1;


