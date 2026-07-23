# Financial Analytics Project: Exploring Federal Funds Rate Impacts on Macroeconomic Indicators

## Project Overview
The Federal Funds Rate is one of the primary tools the Federal Reserve utilizes for implementing monetary policy and is adjusted to influence inflation, employment, and overall economic output. While the effects of monetary policy are well understood conceptually, they are generally expected to occur with a delay rather than immediately. This project explores whether lagged relationships between Federal Funds Rate changes and major macroeconomic indicators can be identified through exploratory time-series analysis.

Federal Economic data is a topic I have become particularly interested in as the Federal Reserve underwent a regime change during the time of this project's development. Becoming more educated on the topic has captured my focus, and what better way to put my analytical skills to use than to produce an analysis of the effects of Monetary Policy on output. Intuitively, it made sense that the effects of Monetary Policy adjustment, specifically the Federal Funds Interest Rate, would have a lagged impact on Macroeconomics, which was something that I wanted to explore and potentially verify with this project. 

## Research Question
### How do changes in the Federal Funds Rate relate to subsequent changes in CPI, PCE, GDP, and the unemployment rate over multiple quarterly lag intervals?

## Project Workflow
1. Historical observations were downloaded from the Federal Reserve Economic Data (FRED) website and imported into a **MySQL database** for transformation and analysis.
2. Designed a MySQL relational database schema and developed an **ETL pipeline** to store & utilize indicator metadata and historical observations.
3. Generated 2 analytics-ready datasets through SQL transformations using **Common Table Expressions (CTEs) and SQL Views** to standardize reporting frequencies and engineer quarterly aggregated data.
4. Performed exploratory data analysis in Python through summary statistics, missing value assessment, and **time-series visualizations**.
5. Engineered lag features and quarter-over-quarter change variables to evaluate delayed monetary policy effects.
6. Implemented a reusable lag **parameter search algorithm** to calculate Pearson correlation coefficients across one-to eight-quarter lags to identify the strongest observed relationship for each indicator.
7. Interpreted the results, discussed the statistical limitations of the findings, and identified opportunities for future research.
   
## Technologies Used
### Languages: 
Python, SQL
### Libraries: 
Pandas, Matplotlib, Seaborn

## MySQL Database Design
![MySQL Schema](./sql/FEDSchema.png)

## Data Engineering
To prepare the data for analysis, I standardized indicator frequencies and engineered the data for downstream analytics. Using Common Table Expressions to initially demonstrate the logic for aggregations and then generating Views to display Short & Long formatted tables for modeling & visualizations. These transformations were implemented in the [QueryingDB.sql](./sql/QueryingDB.sql) file utilizing a combination of Common Table Expressions (CTEs) and SQL Views, creating 2 reusable analytical datasets for downstream visualization and analysis.

**Created Common Table Expressions (CTEs):** 
- Aggregating monthly observations into calendar-quarter averages while preserving existing quarterly observations and  producing a standardized dataset for time-series analysis.
- Obtaining Value & Percentage Change Statistics for Each Observation, incorporating the LAG() window function

**Created SQL Views:**
Two analytical views were created to support different stages of the project:
- Quarterly aggregated View of Indicator Values and Percentage Change Statistics in a long table format [macroeconomic_data_long.csv](./data/processed/macroeconomic_data_long.csv), designed for flexible visualization and business intelligence applications.
- Quarterly aggregated View of Indicator Values in a short table format with Columns: year, quarter, fed_funds_rate, cpi, gdp, pce, where [macroeconomic_data_short.csv](./data/processed/macroeconomic_data_short.csv) is optimized for exploratory data analysis, feature engineering, and lagged correlation analysis.

Although both long and wide formatted datasets were generated during the SQL transformation pipeline, the wide-format (macroeconomic_data_short) view was used for all subsequent exploratory analysis and lagged correlation modeling, as each indicator needed to exist as a separate variable for statistical comparison. The long table was generated for Power BI dashboarding if the analysis yielded insights requiring such. 

## Exploratory Data Analysis
The exploratory analysis examined the completeness, distribution, and long-term behavior of each macroeconomic indicator before feature engineering. Summary statistics were used to understand variable scale and dispersion, while time-series visualizations identified long-term trends, cyclical behavior, and potential structural differences across indicators.
### Federal Funds Rate
![Federal Funds Rate](images/fedfund_rate.png)
### Macroeconomic Indicators
![Indicators](images/macroeconomic_indicators.png)


## Feature Engineering

## Methodology
The analysis evaluated the lagged relationship by displaying a historical line graph showing the Pearson correlation coefficient between lagged changes in FedFund Rates and changes to each macro-indicator metric generated from Pandas' .corr() function. Correlations were computed across lag intervals ranging from one to eight quarters and visualized to identify the timing of the strongest observed statistical association. To keep the scope of the project manageable, I chose 8 quarters as the maximum length, limiting the evaluation to a timeframe that remains economically interpretable. This analysis utilized a reusable parameter search algorithm function, which generated a lagged column for each FedFund Interest Rate interval and then stored each Pearson coefficient for display. Lagged analysis was the chosen methodology for this project since monetary policy changes are expected to have a delayed rather than immediate impact on macroeconomic figures. 

## Results & Key Findings

## Limitations

## Future Improvements

## References
All data was gathered from the Federal Reserve Bank of St Louis Economic Database
- **Federal Funds Effective Rate (FEDFUNDS):** https://fred.stlouisfed.org/series/FEDFUNDS
- **Unemployment Rate (UNRATE):** https://fred.stlouisfed.org/series/UNRATE
- **Gross Domestic Product (GDP):** https://fred.stlouisfed.org/series/GDP
- **Consumer Price Index (CPI):** https://fred.stlouisfed.org/series/CPIAUCSL
- **Personal Consumption Expenditures (PCE):** https://fred.stlouisfed.org/series/PCE


