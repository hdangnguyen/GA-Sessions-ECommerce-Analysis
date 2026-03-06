# 📊 Unlocking User Behavior: Google Analytics Session Analysis

![BigQuery](https://img.shields.io/badge/Database-BigQuery-4285F4?style=flat&logo=google-cloud&logoColor=white)
![SQL](https://img.shields.io/badge/Language-SQL-orange?style=flat&logo=mysql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-success)

## 📌 Executive Summary
**Queried Google's public GA Sessions 2017 dataset on BigQuery to uncover e-commerce conversion bottlenecks and user behavior patterns.**

This project analyzes the `bigquery-public-data.google_analytics_sample.ga_sessions_2017*` dataset — a real-world e-commerce web analytics dataset — to answer two critical business questions:
1. **Where are users dropping off in the purchase funnel?** (Product View → Add to Cart → Purchase)
2. **How does browsing behavior differ between buyers and non-buyers?**

Using **Advanced SQL on BigQuery** (UNNEST, CTEs, COUNTIF, FORMAT_DATE, FULL JOIN), the analysis surfaces actionable insights for the product and marketing teams.

> **🚀 [View the Full Interactive Portfolio Write-up Here](https://hdangnguyen.github.io/projects/ga-session-analysis.html)**

---

## 🛠 Technical Stack & Skills
- **BigQuery SQL:** Nested field flattening with `UNNEST`, CTEs, Conditional Aggregation (`COUNTIF`), Date Functions (`FORMAT_DATE`, `PARSE_DATE`), FULL JOIN for safe multi-segment joins.
- **Dataset:** `bigquery-public-data.google_analytics_sample.ga_sessions_2017*` (Google public data)
- **Metrics Designed:** Conversion Funnel Rates (Add-to-Cart Rate, Purchase Rate), Average Pageviews per Segment.

---

## 🔍 Featured Case Studies

### Case Study 1: E-Commerce Conversion Funnel (Query 08)
- **Business Problem:** Traffic was healthy but revenue wasn't growing proportionally. Where are users dropping off?
- **Technique:** Mapped `eCommerceAction.action_type` codes to classify each hit as Product View (2), Add to Cart (3), or Purchase (6). Computed funnel rates as percentages for monthly comparison.
- **Key Findings:**
    - Add-to-Cart Rate improved from **28.47% (Jan) → 37.29% (Mar)** — a 31% relative improvement.
    - Despite healthy cart adds, **65–72% of cart-adders never complete a purchase** → cart abandonment is the #1 revenue leak.
    - March outperformed all months across every metric (Purchase Rate: **12.64%**).
- **Recommendation:** Implement automated cart abandonment email sequences (1h / 24h / 72h triggers) and reverse-engineer March's performance drivers.

### Case Study 2: Purchaser vs. Non-Purchaser Behavior (Query 04)
- **Business Problem:** Marketing was spending budget equally on all visitors. What separates a buyer from a browser?
- **Technique:** Segmented users into mutually exclusive groups using transaction and revenue filters. Computed Average Pageviews per Unique Visitor per group.
- **Key Findings:**
    - Non-purchasers rack up **316–334 pageviews/user** vs only **94–124 for buyers** — high pageviews signal **indecision, not engagement**.
    - The engagement gap shrank from 3.4× (June) to 2.7× (July), suggesting improved targeting or UX.
- **Recommendation:** Serve exit-intent interventions to users exceeding ~200 pageviews without converting. Improve site search and filtering UX.

---

## 📊 Query Repository

| ID | Business Question | Key SQL Techniques | Script |
| :--- | :--- | :--- | :--- |
| **Q01** | Total visits, pageviews, transactions (Jan–Mar 2017) | `FORMAT_DATE`, `GROUP BY` | [View SQL](./query/q01_monthly_traffic_overview.sql) |
| **Q02** | Bounce rate by traffic source (Jul 2017) | `Aggregation`, `ROUND`, `ORDER BY` | [View SQL](./query/q02_bounce_rate_by_source.sql) |
| **Q03** | Revenue by traffic source — Week vs Month (Jun 2017) | `CTEs`, `UNION ALL`, `UNNEST` | [View SQL](./query/q03_revenue_by_source_week_month.sql) |
| **Q04** | Avg pageviews: Purchaser vs Non-Purchaser (Jun–Jul 2017) | `CTEs`, `FULL JOIN`, `DISTINCT` | [View SQL](./query/q04_avg_pageviews_by_purchaser_type.sql) |
| **Q05** | Avg transactions per purchasing user (Jul 2017) | `Aggregation`, `DISTINCT` | [View SQL](./query/q05_avg_transactions_per_user.sql) |
| **Q06** | Avg revenue per session — purchasers only (Jul 2017) | `SUM`, `Division`, `ROUND` | [View SQL](./query/q06_avg_revenue_per_session.sql) |
| **Q07** | Cross-sell: other products bought with Vintage Henley (Jul 2017) | `Subquery`, `CTE`, `IN clause` | [View SQL](./query/q07_cross_sell_products.sql) |
| **Q08** | Cohort map: View → Add to Cart → Purchase (Jan–Mar 2017) | `CTEs`, `COUNTIF`, `action_type` | [View SQL](./query/q08_conversion_funnel_cohort.sql) |

---

## 📂 Project Structure
```text
├── query/
│   ├── q01_monthly_traffic_overview.sql
│   ├── q02_bounce_rate_by_source.sql
│   ├── q03_revenue_by_source_week_month.sql
│   ├── q04_avg_pageviews_by_purchaser_type.sql
│   ├── q05_avg_transactions_per_user.sql
│   ├── q06_avg_revenue_per_session.sql
│   ├── q07_cross_sell_products.sql
│   └── q08_conversion_funnel_cohort.sql
└── README.md
```
