/*=========================================================
File Name : 08_time_analysis.sql
Project   : CRM Sales Pipeline Analysis
Author    : Aniket Singh
Purpose   : Analyze sales trends over time, including
            monthly, quarterly, and yearly performance,
            seasonality, and deal closing patterns.
=========================================================*/


USE crm_sales_pipeline;


/*=====================================================
    SECTION A : Monthly Analysis
=====================================================*/


-- Total revenue by month.

SELECT YEAR(close_date) AS years , MONTHNAME(close_date) AS months_name,
SUM(close_value) total_deal_value
FROM sales_pipeline
GROUP BY  years , months_name;

-- Number of opportunities by month.

SELECT YEAR(engage_date) AS years , MONTHNAME(engage_date) AS months_name,
COUNT(opportunity_id) no_of_opportunity
FROM sales_pipeline
GROUP BY years , months_name;

-- Number of won deals by month.

SELECT YEAR(close_date) AS years , MONTHNAME(close_date) AS months_name,
COUNT(close_date) no_of_won_deals
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY years, months_name;

-- Number of lost deals by month.

SELECT YEAR(close_date) AS years , MONTHNAME(close_date) AS months_name,
COUNT(close_date) no_of_lost_deals
FROM sales_pipeline
WHERE deal_stage = 'Lost'
GROUP BY years, months_name;

-- Average deal value by month.

SELECT YEAR(close_date) AS years , MONTHNAME(close_date) AS months_name,
AVG(close_value) average_deal_value
FROM sales_pipeline
GROUP BY years, months_name;

-- Highest revenue month.

SELECT YEAR(close_date) AS years , MONTHNAME(close_date) AS months_name,
SUM(close_value) total_revenue
FROM sales_pipeline
GROUP BY years, months_name
ORDER BY total_revenue DESC
LIMIT 1;

-- Lowest revenue month.

SELECT YEAR(close_date) AS years , MONTHNAME(close_date) AS months_name,
SUM(close_value) total_revenue
FROM sales_pipeline
GROUP BY years, months_name
ORDER BY total_revenue ASC
LIMIT 1;


/*=====================================================
    SECTION B – Quarterly Analysis
=====================================================*/


-- Total revenue by quarter.

SELECT QUARTER(close_date) AS  quarter ,
SUM(close_value) AS total_revenue
FROM sales_pipeline
GROUP BY quarter;

-- Number of opportunities by quarter.

SELECT QUARTER(engage_date) AS  quarter ,
COUNT(opportunity_id) no_of_opportunity
FROM sales_pipeline
GROUP BY quarter;

-- Average deal value by quarter.

SELECT QUARTER(close_date) AS  quarter ,
AVG(close_value) average_deal_value
FROM sales_pipeline
GROUP BY quarter;


-- Quarter with the highest revenue.

SELECT QUARTER(close_date) AS  quarter ,
SUM(close_value) highest_revenue
FROM sales_pipeline
GROUP BY quarter
ORDER BY highest_revenue DESC
LIMIT 1;

-- Quarter with the most won deals.

SELECT QUARTER(close_date) AS  quarter ,
COUNT(deal_stage) highest_won_deals
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY quarter
ORDER BY highest_won_deals DESC
LIMIT 1;


/*=====================================================
    SECTION C : SALES CYCLE ANALYSIS
=====================================================*/


-- Average number of days between: engage_date → close_date

SELECT AVG(DATEDIFF(close_date, engage_date)) AS average_days
FROM sales_pipeline
WHERE close_date IS NOT NULL;

-- Shortest sales cycle.

SELECT opportunity_id , DATEDIFF(close_date, engage_date) AS days
FROM sales_pipeline
WHERE close_date IS NOT NULL
ORDER BY days ASC
LIMIT 1;

-- Longest sales cycle.

SELECT opportunity_id , DATEDIFF(close_date, engage_date) AS days
FROM sales_pipeline
WHERE close_date IS NOT NULL
ORDER BY days DESC
LIMIT 1;

-- Average sales cycle by deal stage.

SELECT deal_stage , 
AVG(DATEDIFF(close_date, engage_date)) AS average_deal_cycle
FROM sales_pipeline
WHERE close_date IS NOT NULL
GROUP BY deal_stage;

-- Sales agent with the shortest average sales cycle.

SELECT sales_agent, AVG(DATEDIFF(close_date, engage_date)) AS average_days
FROM sales_pipeline
WHERE close_date IS NOT NULL
GROUP BY sales_agent
ORDER BY average_days ASC
LIMIT 1;
