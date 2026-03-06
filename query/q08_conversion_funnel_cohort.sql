/* Query 08: Cohort map — Product View → Add to Cart → Purchase, Jan–Mar 2017
   
   eCommerceAction.action_type codes:
     '2' = Product Detail View
     '3' = Add to Cart
     '6' = Purchase (requires productRevenue IS NOT NULL to confirm actual transaction)
   
   Key design decision:
   - Two-step CTE: first classify raw hits, then aggregate counts + compute rates.
   - This avoids re-scanning the full nested table multiple times.
*/

WITH
  data_overview AS (
    SELECT
      FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date))  AS month,
      eCommerceAction.action_type                       AS action_type,
      totals.transactions,
      product.productRevenue
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`,
      UNNEST(hits)    AS hits,
      UNNEST(product) AS product
    WHERE _table_suffix BETWEEN '0101' AND '0331'
  ),

  data_count AS (
    SELECT
      month,
      COUNTIF(action_type = '2')                                  AS num_product_view,
      COUNTIF(action_type = '3')                                  AS num_addtocart,
      COUNTIF(action_type = '6' AND productRevenue IS NOT NULL)   AS num_purchase
    FROM data_overview
    GROUP BY month
    ORDER BY month
  )

SELECT
  *,
  ROUND(num_addtocart / num_product_view * 100.0, 2)  AS add_to_cart_rate,
  ROUND(num_purchase  / num_product_view * 100.0, 2)  AS purchase_rate
FROM data_count
