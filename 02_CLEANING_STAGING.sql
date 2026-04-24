-- =============================================
-- SPORTS ANALYTICS PROJECT
-- Sheet 2: Cleaning & Staging Layer
-- =============================================

USE WAREHOUSE SPORTS_ANALYTICS_WH;
USE DATABASE SPORTS_DB;
USE SCHEMA ANALYTICS;

-- Create a clean staging table from raw data
CREATE OR REPLACE TABLE FOOTBALL_PLAYERS_STAGING AS
SELECT
    RK                                      AS PLAYER_RANK,
    TRIM(PLAYER)                            AS PLAYER_NAME,
    TRIM(NATION)                            AS NATION,
    TRIM(POS)                               AS POSITION,
    TRIM(SQUAD)                             AS TEAM,
    TRIM(COMP)                              AS LEAGUE,
    AGE,
    MP                                      AS MATCHES_PLAYED,
    STARTS,
    MIN                                     AS MINUTES_PLAYED,
    GLS                                     AS GOALS,
    AST                                     AS ASSISTS,
    CRDY                                    AS YELLOW_CARDS,
    CRDR                                    AS RED_CARDS,
    CURRENT_TIMESTAMP()                     AS LOADED_AT
FROM FOOTBALL_PLAYERS_RAW
WHERE PLAYER IS NOT NULL
  AND SQUAD IS NOT NULL;

-- Verify staging table
SELECT COUNT(*) AS STAGING_ROWS FROM FOOTBALL_PLAYERS_STAGING;

-- Preview staging table
SELECT * FROM FOOTBALL_PLAYERS_STAGING LIMIT 10;
