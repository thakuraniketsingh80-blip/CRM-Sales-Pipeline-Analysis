/*=========================================================
File Name : 06_product_analysis.sql
Project   : CRM Sales Pipeline Analysis
Author    : Aniket Singh
Purpose   : Analyze product performance, pricing,
            revenue contribution, and product
            opportunity trends.
=========================================================*/


/*=====================================================
    SECTION A : Product Overview
=====================================================*/


USE crm_sales_pipeline;


-- Total number of products.

SELECT COUNT(product) AS total_products
FROM products;

-- Number of products in each series.

SELECT series , COUNT(product) AS product_count
FROM products
GROUP BY series;

-- Average sales price by series.

SELECT series , AVG(sales_price) AS average_sales_price
FROM products
GROUP BY series;

-- Highest priced product.

SELECT product , MAX(sales_price) AS highest_price
FROM products
GROUP BY product
ORDER BY MAX(sales_price) DESC
LIMIT 1;

-- Lowest priced product.

SELECT product , MIN(sales_price) AS lowest_price
FROM products
GROUP BY product
ORDER BY MIN(sales_price) ASC
LIMIT 1;

-- Most expensive product series (based on average sales price).

SELECT series , AVG(sales_price) AS average_sales_price
FROM products
GROUP BY series
ORDER BY AVG(sales_price) DESC
LIMIT 1;

-- Price range (MAX - MIN) for each product series.

SELECT series , (MAX(sales_price) -  MIN(sales_price)) AS price_range
FROM products
GROUP BY series;

/*=====================================================
    SECTION B : PRODUCT PERFORMANCE
=====================================================*/


-- Which product generated the highest total deal value?

SELECT product , SUM(close_value) AS total_deal_value
FROM sales_pipeline
GROUP BY product
ORDER BY SUM(close_value) DESC
LIMIT 1;

-- Top 10 products by total deal value.

SELECT product , SUM(close_value) AS total_deal_value
FROM sales_pipeline
GROUP BY product
ORDER BY SUM(close_value) DESC
LIMIT 10;

-- Average deal value by product.

SELECT product , AVG(close_value) AS average_deal_value 
FROM sales_pipeline
GROUP BY product;

-- Which product appears in the most opportunities?

SELECT product , COUNT(opportunity_id) AS opportunity_count
FROM sales_pipeline
GROUP BY product
ORDER BY COUNT(opportunity_id) DESC
LIMIT 1;

-- Which product generated the most won deals?

SELECT product , COUNT(deal_stage) AS won_deals
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY product
ORDER BY COUNT(deal_stage) DESC
LIMIT 1;

-- Which product generated the most lost deals?

SELECT product , COUNT(deal_stage) AS lost_deals
FROM sales_pipeline
WHERE deal_stage = 'Lost'
GROUP BY product
ORDER BY COUNT(deal_stage) DESC
LIMIT 1;

-- Which product generated the highest average deal value?

SELECT product , AVG(close_value) AS average_deal_value
FROM sales_pipeline
GROUP BY product
ORDER BY AVG(close_value) DESC
LIMIT 1;
