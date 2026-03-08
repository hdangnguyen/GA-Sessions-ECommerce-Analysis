/* Query 03: Revenue by traffic source by week and by month in June 2017 */

WITH month_data AS (
  SELECT
    'Month' AS time_type,
    FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
    trafficSource.source AS source,
    SUM(p.productRevenue) / 1000000 AS revenue
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201706*`,
    UNNEST(hits) AS hits,
    UNNEST(product) AS p
  WHERE p.productRevenue IS NOT NULL
  GROUP BY 1, 2, 3
),

week_data AS (
  SELECT
    'Week' AS time_type,
    FORMAT_DATE('%Y%W', PARSE_DATE('%Y%m%d', date)) AS week,
    trafficSource.source AS source,
    SUM(p.productRevenue) / 1000000 AS revenue
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201706*`,
    UNNEST(hits) AS hits,
    UNNEST(product) AS p
  WHERE p.productRevenue IS NOT NULL
  GROUP BY 1, 2, 3
)

SELECT 
  * FROM month_data
UNION ALL
SELECT 
  * FROM week_data
ORDER BY time_type