-- =============================================
-- SPORTS ANALYTICS PROJECT
-- Sheet 4: Views & Dashboard Layer
-- =============================================

USE WAREHOUSE SPORTS_ANALYTICS_WH;
USE DATABASE SPORTS_DB;
USE SCHEMA ANALYTICS;

-- -----------------------------------------------
-- VIEW 1: Top Scorers View
-- -----------------------------------------------
CREATE OR REPLACE VIEW SPORTS_DB.ANALYTICS.VW_TOP_SCORERS AS
SELECT 
    PLAYER_NAME,
    TEAM,
    LEAGUE,
    NATION,
    POSITION,
    GOALS,
    ASSISTS,
    GOALS + ASSISTS                                     AS GOAL_CONTRIBUTIONS,
    ROUND((GOALS / NULLIF(MINUTES_PLAYED,0))*90, 2)    AS GOALS_PER_90
FROM SPORTS_DB.ANALYTICS.FOOTBALL_PLAYERS_STAGING
WHERE GOALS IS NOT NULL
  AND MINUTES_PLAYED > 500;

-- -----------------------------------------------
-- VIEW 2: League Summary View
-- -----------------------------------------------
CREATE OR REPLACE VIEW SPORTS_DB.ANALYTICS.VW_LEAGUE_SUMMARY AS
SELECT
    LEAGUE,
    COUNT(DISTINCT TEAM)                AS TOTAL_TEAMS,
    COUNT(DISTINCT PLAYER_NAME)         AS TOTAL_PLAYERS,
    SUM(GOALS)                          AS TOTAL_GOALS,
    SUM(ASSISTS)                        AS TOTAL_ASSISTS,
    ROUND(AVG(GOALS), 2)                AS AVG_GOALS_PER_PLAYER,
    ROUND(AVG(AGE), 1)                  AS AVG_PLAYER_AGE
FROM SPORTS_DB.ANALYTICS.FOOTBALL_PLAYERS_STAGING
GROUP BY LEAGUE;

-- -----------------------------------------------
-- VIEW 3: Team Performance View
-- -----------------------------------------------
CREATE OR REPLACE VIEW SPORTS_DB.ANALYTICS.VW_TEAM_PERFORMANCE AS
SELECT
    TEAM,
    LEAGUE,
    COUNT(DISTINCT PLAYER_NAME)         AS SQUAD_SIZE,
    SUM(GOALS)                          AS TOTAL_GOALS,
    SUM(ASSISTS)                        AS TOTAL_ASSISTS,
    SUM(YELLOW_CARDS)                   AS YELLOW_CARDS,
    SUM(RED_CARDS)                      AS RED_CARDS,
    ROUND(AVG(AGE), 1)                  AS AVG_AGE,
    ROUND(AVG(MINUTES_PLAYED), 0)       AS AVG_MINUTES
FROM SPORTS_DB.ANALYTICS.FOOTBALL_PLAYERS_STAGING
GROUP BY TEAM, LEAGUE;

-- -----------------------------------------------
-- Verify all views created
-- -----------------------------------------------
SHOW VIEWS IN SCHEMA SPORTS_DB.ANALYTICS;

-- -----------------------------------------------
-- Query your views (like a dashboard!)
-- -----------------------------------------------
SELECT * FROM SPORTS_DB.ANALYTICS.VW_TOP_SCORERS 
ORDER BY GOALS DESC LIMIT 10;

SELECT * FROM SPORTS_DB.ANALYTICS.VW_LEAGUE_SUMMARY 
ORDER BY TOTAL_GOALS DESC;

SELECT * FROM SPORTS_DB.ANALYTICS.VW_TEAM_PERFORMANCE 
ORDER BY TOTAL_GOALS DESC LIMIT 10;
