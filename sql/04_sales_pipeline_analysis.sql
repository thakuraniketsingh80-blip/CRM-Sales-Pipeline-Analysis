/*=========================================================
File Name : 04_sales_pipeline_analysis.sql
Project   : CRM Sales Pipeline Analysis
Author    : Aniket Singh
Purpose   : Analyze the sales pipeline by evaluating deal
            stages, pipeline value, deal distribution,
            and overall sales performance.
=========================================================*/


/*=====================================================
    SECTION A : Pipeline Overview
=====================================================*/


USE crm_sales_pipeline;


-- Total number of opportunities.

SELECT COUNT(opportunity_id) AS total_opportunities
FROM sales_pipeline;

-- Total pipeline value.

SELECT SUM(close_value)  AS total_pipeline_value
FROM sales_pipeline;

-- Average deal value.

SELECT AVG(close_value) AS average_deal_value
FROM sales_pipeline;

-- Total number of Won deals

SELECT COUNT(deal_stage) AS won_deals
FROM sales_pipeline
WHERE deal_stage = 'Won';

-- Total number of Lost deals

SELECT COUNT(deal_stage) AS lost_deals
FROM sales_pipeline
WHERE deal_stage = 'Lost';

/*=====================================================
    SECTION B : Deal Stage Analysis
=====================================================*/

-- Number of opportunities in each deal stage.

SELECT deal_stage ,COUNT(*) AS opportunity_count
FROM sales_pipeline
GROUP BY deal_stage;

-- Total pipeline value by deal stage.

SELECT deal_stage ,SUM(close_value)  AS total_value
FROM sales_pipeline
GROUP BY deal_stage;

-- Average deal value by deal stage.

SELECT deal_stage ,AVG(close_value)  AS average_deal_value
FROM sales_pipeline
GROUP BY deal_stage;

-- Which deal stage has the highest number of opportunities?

SELECT deal_stage,COUNT(*) AS opportunity_count
FROM sales_pipeline
GROUP BY deal_stage
ORDER BY COUNT(deal_stage) DESC
LIMIT 1;

-- Which deal stage has the highest pipeline value?

SELECT deal_stage,SUM(close_value) AS total_value
FROM sales_pipeline
GROUP BY deal_stage
ORDER BY SUM(close_value) DESC
LIMIT 1;