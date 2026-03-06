/* Query 04: Average number of pageviews by purchaser type (purchasers vs non-purchasers) in June, July 2017
   
   Key design decisions:
   - Uses FULL JOIN (not INNER JOIN) to prevent data loss in months where one segment has zero users.
   - Purchasers:     transactions >= 1 AND productRevenue IS NOT NULL
   - Non-Purchasers: transactions IS NULL AND productRevenue IS NULL (mutually exclusive)
*/

WITH
  base AS (
    SELECT
      FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date))  AS month,
      totals.transactions,
      product.productRevenue,
      totals.pageviews,
      fullVisitorId
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`,
      UNNEST(hits)    AS hits,
      UNNEST(product) AS product
    WHERE _table_suffix BETWEEN '0601' AND '0731'
  ),

  purchase AS (
    SELECT
      month,
      ROUND(SUM(pageviews) / COUNT(DISTINCT fullVisitorId), 8)  AS avg_pageviews_purchase
    FROM base
    WHERE transactions >= 1
      AND productRevenue IS NOT NULL
    GROUP BY month
  ),

  non_purchase AS (
    SELECT
      month,
      ROUND(SUM(pageviews) / COUNT(DISTINCT fullVisitorId), 8)  AS avg_pageviews_non_purchase
    FROM base
    WHERE transactions IS NULL
      AND productRevenue IS NULL
    GROUP BY month
  )

SELECT *
FROM purchase
FULL JOIN non_purchase USING (month)
ORDER BY month
