/* Query 01: Calculate total visits, pageviews, transactions for Jan, Feb and March 2017 */

SELECT 
  FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) AS month,
  COUNT(totals.visits)        AS visits,
  SUM(totals.pageviews)       AS pageviews,
  SUM(totals.transactions)    AS transactions
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`
WHERE _table_suffix BETWEEN '0101' AND '0331'
GROUP BY month
ORDER BY month
