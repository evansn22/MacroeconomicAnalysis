CREATE database fed_project;
USE fed_project;

CREATE TABLE indicators (
  indicator_id int NOT NULL AUTO_INCREMENT,
  indicator_code varchar(20) DEFAULT NULL,
  indicator_name varchar(100) DEFAULT NULL,
  category varchar(50) DEFAULT NULL,
  frequency varchar(20) DEFAULT NULL,
  unit_measure varchar(30) DEFAULT NULL,
  source varchar(50) DEFAULT NULL,
  PRIMARY KEY (`indicator_id`),
  UNIQUE KEY `indicator_code` (`indicator_code`)
); 
CREATE TABLE indicator_values (
    indicator_id INT NOT NULL,
    observation_date DATE NOT NULL,
    indicator_value DECIMAL(12,4) NOT NULL,
    value_change DECIMAL(12,4),
    percent_change DECIMAL(8,6),

    PRIMARY KEY (indicator_id,observation_date),

    FOREIGN KEY (indicator_id)
        REFERENCES indicators(indicator_id)
        ON DELETE CASCADE,

    UNIQUE (indicator_id, observation_date)
);

INSERT INTO indicators
(
    indicator_code,
    indicator_name,
    category,
    frequency,
    unit_measure,
    source
)
VALUES
('CPIAUC', 'Consumer Price Index for All Urban Consumers: All Items in U.S. City Average', 'Inflation', 'Monthly', 'Index', 'FRED'),
('UNRATE', 'Unemployment Rate', 'Labor', 'Quarterly', 'Percent', 'FRED'),
('GDP', 'Real Gross Domestic Product', 'Growth', 'Quarterly', 'Billions of Dollars', 'FRED'),
('PCE', 'Personal Consumption Expenditures', 'Growth', 'Monthly', 'Billions of Dollars', 'FRED'),
('FEDFUNDS', 'Federal Funds Effective Rate', 'Monetary', 'Monthly', 'Percent', 'FRED');
