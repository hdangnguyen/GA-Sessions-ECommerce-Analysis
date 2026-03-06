/* Query 07: Other products purchased by customers who also bought "YouTube Men's Vintage Henley" in July 2017
   
   Key design decision:
   - Use DISTINCT in the buyer_list CTE to deduplicate fullVisitorId before joining.
     Without DISTINCT, a user who bought the Henley 3 times would appear 3 times,
     causing all their other purchases to be counted 3× (duplication bug).
*/

WITH
  buyer_list AS (
    SELECT DISTINCT fullVisitorId
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
      UNNEST(hits)    AS hits,
      UNNEST(product) AS product
    WHERE product.v2ProductName = "YouTube Men's Vintage Henley"
      AND totals.transactions >= 1
      AND product.productRevenue IS NOT NULL
  )

SELECT
  product.v2ProductName           AS other_purchased_products,
  SUM(product.productQuantity)    AS quantity
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
  UNNEST(hits)    AS hits,
  UNNEST(product) AS product
JOIN buyer_list USING (fullVisitorId)
WHERE product.v2ProductName != "YouTube Men's Vintage Henley"
  AND product.productRevenue IS NOT NULL
  AND totals.transactions >= 1
GROUP BY other_purchased_products
ORDER BY quantity DESC
