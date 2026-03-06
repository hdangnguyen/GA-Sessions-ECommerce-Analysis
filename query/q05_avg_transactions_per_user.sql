/* Query 05: Average number of transactions per user that made a purchase in July 2017 */

SELECT
  FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date))                        AS month,
  ROUND(SUM(totals.transactions) / COUNT(DISTINCT fullVisitorId), 4)     AS avg_total_transactions_per_user
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
  UNNEST(hits)    AS hits,
  UNNEST(product) AS product
WHERE totals.transactions >= 1
  AND product.productRevenue IS NOT NULL
GROUP BY month
