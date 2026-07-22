# FedFund Interest Rate & Macroeconomic Analysis: Evaluating the Relationship Between Federal Funds Rate Changes and Macroeconomic Indicators

## Project Overview

## Research Question

## Project Workflow

## Database Design

## Data Engineering

## Exploratory Data Analysis

## Feature Engineering

## Methodology
The analysis evaluated the lagged relationship by displaying a historical line graph showing the Pearson correlation coefficient between lagged changes in FedFund Rates and changes to each macro-indicator metric generated from Pandas' .corr() function. Correlations were computed across lag intervals ranging from one to eight quarters and visualized to identify the timing of the strongest observed statistical association. To keep the scope of the project manageable, I chose 8 quarters as the maximum length, limiting the evaluation to a timeframe that remains economically interpretable. This analysis utilized a reusable parameter search algorithm function, which generated a lagged column for each FedFund Interest Rate interval, and then stored each Pearson coefficient for display. Lagged analysis was the chosen methodology for this project since monetary policy changes are expected to have a delayed rather than immediate impact on macroeconomic figures. 

## Results

## Key Findings

## Limitations

## Future Improvements

## References
