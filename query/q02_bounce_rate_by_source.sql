/* Query 02: Bounce rate per traffic source in July 2017 */

SELECT
  trafficSource.source                                            AS source,
  SUM(totals.visits)                                             AS total_visits,
  SUM(totals.bounces)                                            AS total_no_of_bounces,
  ROUND(SUM(totals.bounces) / SUM(totals.visits) * 100, 3)      AS bounce_rate
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`
GROUP BY source
ORDER BY total_visits DESC
