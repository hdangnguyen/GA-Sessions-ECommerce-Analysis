/* Query 03: Revenue by traffic source by week and by month in June 2017 */

WITH
  month_data AS (
    SELECT
      'Month'                                                       AS time_type,
      FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date))              AS time,
      trafficSource.source                                          AS source,
      ROUND(SUM(product.productRevenue) / 1000000, 4)              AS revenue
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201706*`,
      UNNEST(hits)    AS hits,
      UNNEST(product) AS product
    WHERE product.productRevenue IS NOT NULL
    GROUP BY time_type, time, source
  ),

  week_data AS (
    SELECT
      'Week'                                                        AS time_type,
      FORMAT_DATE('%Y%W', PARSE_DATE('%Y%m%d', date))              AS time,
      trafficSource.source                                          AS source,
      ROUND(SUM(product.productRevenue) / 1000000, 4)              AS revenue
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201706*`,
      UNNEST(hits)    AS hits,
      UNNEST(product) AS product
    WHERE product.productRevenue IS NOT NULL
    GROUP BY time_type, time, source
  )

SELECT * FROM month_data
UNION ALL
SELECT * FROM week_data
ORDER BY time_type, revenue DESC

-- Note: ORDER BY time_type groups Month and Week into separate clusters for readability.
