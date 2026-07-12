/*=========================================================
File Name : 07_sales_team_analysis.sql
Project   : CRM Sales Pipeline Analysis
Author    : Aniket Singh
Purpose   : Analyze sales team performance, manager efficiency,
            and regional office contribution.
=========================================================*/


USE crm_sales_pipeline;

/*=====================================================
    SECTION A : Sales Team Overview
=====================================================*/


-- Total number of sales agents.

SELECT COUNT(sales_agent) AS total_sales_agents
FROM sales_teams;

-- Number of sales agents under each manager.

SELECT manager , COUNT(sales_agent) AS No_of_sales_agents
FROM sales_teams
GROUP BY manager;

-- Number of sales agents in each regional office.

SELECT regional_office , COUNT(sales_agent) AS no_of_sales_agents
FROM sales_teams
GROUP BY regional_office;

-- Which manager supervises the most sales agents?

SELECT manager , COUNT(sales_agent) AS no_of_sales_agents
FROM sales_teams
GROUP BY manager
ORDER BY COUNT(sales_agent) DESC
LIMIT 1; 

-- Which regional office has the most sales agents?

SELECT regional_office , COUNT(sales_agent) AS no_of_sales_agents
FROM sales_teams
GROUP BY regional_office
ORDER BY COUNT(sales_agent) DESC
LIMIT 1; 


/*=====================================================
    SECTION B : SALES PERFORMANCE
=====================================================*/

-- Which sales agent generated the highest total deal value?

SELECT sales_agent , SUM(close_value) AS total_deal_value
FROM sales_pipeline
GROUP BY sales_agent
ORDER BY SUM(close_value) DESC
LIMIT 1;

-- Top 10 sales agents by total deal value.

SELECT sales_agent , SUM(close_value) AS total_deal_value
FROM sales_pipeline
GROUP BY sales_agent
ORDER BY total_deal_value DESC
LIMIT 10;

-- Average deal value by sales agent.

SELECT sales_agent , AVG(close_value) AS average_deal_value
FROM sales_pipeline
GROUP BY sales_agent
ORDER BY average_deal_value DESC;

-- Which manager's team generated the highest total deal value?

SELECT st.manager , SUM(sp.close_value) AS total_deal_value
FROM sales_teams AS st
INNER JOIN
sales_pipeline AS sp
ON st.sales_agent = sp.sales_agent
GROUP BY st.manager
ORDER BY total_deal_value DESC
LIMIT 1; 

-- Which regional office generated the highest total deal value?

SELECT st.regional_office , SUM(sp.close_value) AS total_deal_value
FROM sales_teams AS st
INNER JOIN
sales_pipeline AS sp
ON st.sales_agent = sp.sales_agent
GROUP BY st.regional_office
ORDER BY total_deal_value DESC
LIMIT 1; 

-- Which sales agent closed the most won deals?

SELECT st.sales_agent , COUNT(sp.deal_stage) AS won_deals
FROM sales_teams AS st
INNER JOIN 
sales_pipeline AS sp
ON st.sales_agent = sp.sales_agent
WHERE deal_stage = 'Won'
GROUP BY st.sales_agent
ORDER BY COUNT(sp.deal_stage) DESC
LIMIT 1;

-- Which sales agent lost the most deals?

SELECT st.sales_agent , COUNT(sp.deal_stage) AS lost_deals
FROM sales_teams AS st
INNER JOIN 
sales_pipeline AS sp
ON st.sales_agent = sp.sales_agent
WHERE deal_stage = 'Lost'
GROUP BY st.sales_agent
ORDER BY COUNT(sp.deal_stage) DESC
LIMIT 1;

-- Which manager has the highest win rate?

SELECT st.manager ,
SUM(CASE WHEN sp.deal_stage = 'Won' THEN 1 ELSE 0 END) * 100.0
/ COUNT(*)
AS win_rate
FROM sales_teams AS st
INNER JOIN sales_pipeline AS sp
ON st.sales_agent = sp.sales_agent
GROUP BY st.manager
ORDER BY win_rate DESC
LIMIT 1;