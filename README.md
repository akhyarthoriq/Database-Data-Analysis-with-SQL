# SQL Labs Challenge

This repository contains SQL scripts for solving real-world business analytics challenges. The focus is on analyzing traffic sources, campaign performance, conversion rates, and trends across various dimensions.

## Objectives
1. Analyze monthly trends in sessions, orders, and conversion rates.
2. Split and evaluate campaign performance (e.g., brand vs. nonbrand).
3. Assess traffic sources and their contributions to business growth.
4. Investigate landing page performance and conversion funnels.
5. Analyze billing page performance and its revenue impact.

## Repository Structure
The repository is organized as follows:

```
SQL-Labs-Challenge/
├── queries/
│   ├── 01_monthly_trends.sql         # Monthly trends analysis
│   ├── 02_campaign_split.sql         # Campaign-based analysis
│   ├── 03_traffic_analysis.sql       # Traffic source performance
│   ├── 04_conversion_rate.sql        # Conversion rate analysis
│   ├── 05_lander_analysis.sql        # Landing page performance
│   ├── 06_funnel_analysis.sql        # Conversion funnel analysis
│   ├── 07_billing_analysis.sql       # Billing page performance
│   ├── 08_utm_content_analysis.sql   # UTM content performance
│   ├── 09_weekly_trends.sql          # Weekly trends for key channels
├── data/                          # Placeholder for sample data (optional)
└── README.md                      # Project documentation
```

## Queries Overview
### 1. Monthly Trends (`01_monthly_trends.sql`)
Analyzes trends in sessions, orders, and conversion rates on a monthly basis, focusing on key traffic sources like Gsearch.

### 2. Campaign-Based Analysis (`02_campaign_split.sql`)
Splits and evaluates performance by campaign type (e.g., brand vs. nonbrand), highlighting differences in engagement.

### 3. Traffic Source Analysis (`03_traffic_analysis.sql`)
Evaluates traffic sources like Gsearch, Bsearch, Organic, and Direct, including their conversion rates and session contributions.

### 4. Conversion Rate Analysis (`04_conversion_rate.sql`)
Examines session-to-order conversion rates across various timeframes to assess overall site performance.

### 5. Landing Page Analysis (`05_lander_analysis.sql`)
Measures landing page performance and estimates revenue impact during specific test periods.

### 6. Funnel Analysis (`06_funnel_analysis.sql`)
Tracks user progress through the conversion funnel, from landing pages to order completion, and calculates click-through rates at each stage.

### 7. Billing Analysis (`07_billing_analysis.sql`)
Analyzes sessions and revenue for different billing page variants, providing insights into revenue per session and overall impact.

### 8. UTM Content Analysis (`08_utm_content_analysis.sql`)
Examines performance by `utm_content`, including session counts, order counts, and conversion rates.

### 9. Weekly Trends Analysis (`09_weekly_trends.sql`)
Tracks weekly session trends for key channels like Gsearch and Bsearch to identify growth patterns and channel efficiency.

## How to Use
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/SQL-Labs-Challenge.git
2. Load your database with relevant sample data (if required).
3. Run the SQL scripts in the queries/ folder using your preferred SQL client or command line.

## Tool Used
- SQL
- Database Platforms: MySQL/PostgreSQL/SQLite (choose based on your setup)
  
## Author
This repository was created and maintained by **Akhyar Thoriq Alfatah**.
