-- =============================================
-- SPORTS ANALYTICS PROJECT
-- Sheet 3: Business Analytics Queries
-- =============================================

USE WAREHOUSE SPORTS_ANALYTICS_WH;
USE DATABASE SPORTS_DB;
USE SCHEMA ANALYTICS;

-- -----------------------------------------------
-- ANALYSIS 1: Top 10 Goal Scorers
-- -----------------------------------------------
SELECT 
    PLAYER_NAME,
    TEAM,
    LEAGUE,
    NATION,
    GOALS,
    ASSISTS,
    GOALS + ASSISTS AS GOAL_CONTRIBUTIONS
FROM FOOTBALL_PLAYERS_STAGING
WHERE GOALS IS NOT NULL
ORDER BY GOALS DESC
LIMIT 10;

-- -----------------------------------------------
-- ANALYSIS 2: Best Players by League
-- (Which league has highest avg goals?)
-- -----------------------------------------------
SELECT
    LEAGUE,
    COUNT(DISTINCT PLAYER_NAME)         AS TOTAL_PLAYERS,
    ROUND(AVG(GOALS), 2)                AS AVG_GOALS,
    ROUND(AVG(ASSISTS), 2)              AS AVG_ASSISTS,
    SUM(GOALS)                          AS TOTAL_GOALS
FROM FOOTBALL_PLAYERS_STAGING
WHERE GOALS IS NOT NULL
GROUP BY LEAGUE
ORDER BY TOTAL_GOALS DESC;

-- -----------------------------------------------
-- ANALYSIS 3: Top Performing Teams
-- -----------------------------------------------
SELECT
    TEAM,
    LEAGUE,
    COUNT(DISTINCT PLAYER_NAME)         AS SQUAD_SIZE,
    SUM(GOALS)                          AS TEAM_GOALS,
    SUM(ASSISTS)                        AS TEAM_ASSISTS,
    ROUND(AVG(MINUTES_PLAYED), 0)       AS AVG_MINUTES
FROM FOOTBALL_PLAYERS_STAGING
WHERE GOALS IS NOT NULL
GROUP BY TEAM, LEAGUE
ORDER BY TEAM_GOALS DESC
LIMIT 10;

-- -----------------------------------------------
-- ANALYSIS 4: Player Efficiency Index
-- (Goals per 90 minutes - used by real scouts!)
-- -----------------------------------------------
SELECT
    PLAYER_NAME,
    TEAM,
    LEAGUE,
    POSITION,
    GOALS,
    MINUTES_PLAYED,
    ROUND((GOALS / NULLIF(MINUTES_PLAYED, 0)) * 90, 2) AS GOALS_PER_90_MINS
FROM FOOTBALL_PLAYERS_STAGING
WHERE MINUTES_PLAYED > 500
  AND GOALS > 0
ORDER BY GOALS_PER_90_MINS DESC
LIMIT 10;

-- -----------------------------------------------
-- ANALYSIS 5: Discipline Report
-- (Most yellow + red cards by team)
-- -----------------------------------------------
SELECT
    TEAM,
    LEAGUE,
    SUM(YELLOW_CARDS)                   AS TOTAL_YELLOW,
    SUM(RED_CARDS)                      AS TOTAL_RED,
    SUM(YELLOW_CARDS + RED_CARDS)       AS TOTAL_CARDS
FROM FOOTBALL_PLAYERS_STAGING
WHERE YELLOW_CARDS IS NOT NULL
GROUP BY TEAM, LEAGUE
ORDER BY TOTAL_CARDS DESC
LIMIT 10;

SELECT TEAM, TOTAL_GOALS, TOTAL_ASSISTS
FROM SPORTS_DB.ANALYTICS.VW_TEAM_PERFORMANCE
ORDER BY TOTAL_GOALS DESC
LIMIT 10;

SELECT PLAYER_NAME, GOALS, ASSISTS, GOALS_PER_90
FROM SPORTS_DB.ANALYTICS.VW_TOP_SCORERS
ORDER BY GOALS DESC
LIMIT 10;

SELECT LEAGUE, TOTAL_GOALS, TOTAL_PLAYERS, AVG_GOALS_PER_PLAYER
FROM SPORTS_DB.ANALYTICS.VW_LEAGUE_SUMMARY
ORDER BY TOTAL_GOALS DESC;
