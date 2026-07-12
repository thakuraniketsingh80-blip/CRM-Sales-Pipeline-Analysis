/*=========================================================
File Name : 03_data_validation.sql
Project   : CRM Sales Pipeline Analysis
Author    : Aniket Singh
Purpose   : Validate imported CRM data by checking row
            counts, duplicates, NULL values, date
            consistency, and numeric integrity.
=========================================================*/



/*=====================================================
    SECTION A : ROW COUNT VALIDATION
=====================================================*/


USE crm_sales_pipeline;


-- Total rows of accounts

SELECT COUNT(*) AS total_accounts
FROM accounts;  

-- Total rows of Products

SELECT COUNT(*) AS total_products
FROM products; 

-- Total rows in Sales Pipeline

SELECT COUNT(*) AS total_sales_pipeline
FROM sales_pipeline;

-- Total rows in Sales Teams

SELECT COUNT(*) AS total_sales_teams
FROM sales_teams;


/*=====================================================
    SECTION B : DUPLICATE PRIMARY KEY VALIDATION
=====================================================*/

-- checking duplicate in primary key in accounts

SELECT COUNT(*) AS duplicate_count
FROM accounts
GROUP BY account
HAVING COUNT(*) > 1;

-- checking duplicate in primary key in products

SELECT COUNT(*) AS duplicate_count
FROM products
GROUP BY product
HAVING COUNT(*) > 1;

-- checking duplicate in primary key in sales_pipeline

SELECT COUNT(*) AS duplicate_count
FROM sales_pipeline
GROUP BY opportunity_id
HAVING COUNT(*) > 1;

-- checking duplicate in primary key in sales_teams

SELECT COUNT(*) AS duplicate_count
FROM sales_teams
GROUP BY sales_agent
HAVING COUNT(*) > 1;

/*=====================================================
    SECTION C : NULL VALUE VALIDATION
=====================================================*/

-- Checking NULL values in accounts
 
SELECT *
FROM accounts
WHERE account IS NULL 
OR sector IS NULL 
OR revenue IS NULL;

-- Checking NULL values in products

SELECT *
FROM products
WHERE product IS NULL 
OR sales_price IS NULL;

-- Checking NULL values in sales_pipeline

SELECT *
FROM sales_pipeline
WHERE opportunity_id IS NULL 
OR sales_agent IS NULL
OR product IS NULL
OR account IS NULL
OR deal_stage IS NULL
OR engage_date IS NULL
OR close_date IS NULL
OR close_value IS NULL;

-- Checking NULL values in sales_teams

SELECT *
FROM sales_teams
WHERE sales_agent IS NULL 
OR manager IS NULL
OR regional_office IS NULL;

/*=====================================================
    SECTION D : DATE VALIDATION
=====================================================*/

-- The earliest engagement date.

SELECT *
FROM sales_pipeline
WHERE engage_date = 
(SELECT MIN(engage_date) FROM sales_pipeline);


-- The latest engagement date.

SELECT *
FROM sales_pipeline
WHERE engage_date = 
(SELECT MAX(engage_date) FROM sales_pipeline);


-- The earliest close date.

SELECT *
FROM sales_pipeline
WHERE close_date = 
(SELECT MIN(close_date) FROM sales_pipeline);

-- The latest close date.

SELECT *
FROM sales_pipeline
WHERE close_date = 
(SELECT MAX(close_date) FROM sales_pipeline);

-- Detect Opportunities Where Close Date Precedes Engagement Date

SELECT * 
FROM sales_pipeline
WHERE engage_date > close_date;

/*=====================================================
    SECTION E : NUMERIC VALUE VALIDATION
=====================================================*/

-- The minimum close_value.

SELECT * 
FROM sales_pipeline
WHERE close_value =
(SELECT MIN(close_value) FROM sales_pipeline);

-- The maximum close_value.

SELECT * 
FROM sales_pipeline
WHERE close_value =
(SELECT MAX(close_value) FROM sales_pipeline);

-- The total close_value.

SELECT SUM(close_value) AS total_revenue
FROM sales_pipeline;

-- The average close_value.

SELECT AVG(close_value) AS average_revenue  
FROM sales_pipeline;

-- detect negetive close_value.

SELECT * 
FROM sales_pipeline
WHERE close_value < 0;

-- detect zero close_value.

SELECT * 
FROM sales_pipeline
WHERE close_value = 0;
-- Yes, the deals which are lost has zero close value.