/* Query 06: Average amount of money spent per session — purchasers only, July 2017 */

SELECT
  FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date))                          AS month,
  ROUND((SUM(product.productRevenue) / SUM(totals.visits)) / 1000000, 2)  AS avg_revenue_by_user_per_visit
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
  UNNEST(hits)    AS hits,
  UNNEST(product) AS product
WHERE totals.transactions >= 1
  AND product.productRevenue IS NOT NULL
GROUP BY month
