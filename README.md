# sports-analytics-snowflake

## Project Overview
End-to-end sports analytics pipeline built on Snowflake 
using real 2024-25 football player data (2,854 records 
across 5 major European leagues).

## Architecture
## Tech Stack
- **Cloud Warehouse:** Snowflake
- **Transformation:** SQL, dbt
- **Visualization:** Power BI
- **Data Source:** Kaggle - Football Players Stats 2024-25

## Layers Built
| Layer | Table/View | Description |
|---|---|---|
| Raw | FOOTBALL_PLAYERS_RAW | Data as-is from CSV |
| Staging | FOOTBALL_PLAYERS_STAGING | Cleaned & typed data |
| Analytics | VW_TOP_SCORERS | Top scorers with Goals/90 |
| Analytics | VW_LEAGUE_SUMMARY | League level KPIs |
| Analytics | VW_TEAM_PERFORMANCE | Team level KPIs |

## Key KPIs Built
- Goals per 90 Minutes (Player Efficiency Index)
- League Goal Comparison
- Team Performance Score
- Discipline Report (Cards Analysis)
- Squad Size vs Goals Correlation

## How to Run
1. Create Snowflake account (free trial)
2. Run scripts in order: 01 → 02 → 03 → 04
3. Connect Power BI to Snowflake using credentials
