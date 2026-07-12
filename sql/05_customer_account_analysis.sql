/*=========================================================
File Name : 05_customer_account_analysis.sql
Project   : CRM Sales Pipeline Analysis
Author    : Aniket Singh
Purpose   : Analyze customer accounts to identify
            high-value customers, sector performance,
            and customer contribution to sales.
=========================================================*/


/*=====================================================
    SECTION A : Customer Overview
=====================================================*/


USE crm_sales_pipeline;


-- Total number of customer accounts.

SELECT COUNT(account) AS total_customer_accounts
FROM accounts;

-- Number of customers in each sector.

SELECT sector , COUNT(*) AS customer_count
FROM accounts
GROUP BY sector;

-- Number of customers in each office location.

SELECT office_location , COUNT(*) AS customer_count
FROM accounts
GROUP BY office_location;

-- Top 10 customer accounts by annual revenue.

SELECT account , revenue
FROM accounts
ORDER BY revenue DESC
LIMIT 10;

-- Average annual revenue by sector.

SELECT sector , AVG(revenue) AS average_annual_revenue
FROM accounts
GROUP BY sector
ORDER BY AVG(revenue) DESC;

-- Sector with the highest average annual revenue.

SELECT sector , AVG(revenue) AS average_annual_revenue
FROM accounts
GROUP BY sector
ORDER BY AVG(revenue) DESC
LIMIT 1;

-- Company with the highest number of employees.

SELECT account , employees
FROM accounts
WHERE employees = (SELECT MAX(employees) FROM accounts);

-- Average number of employees by sector.

SELECT sector , AVG(employees) AS average_employees
FROM accounts
GROUP BY sector
ORDER BY AVG(employees) DESC;


/*=====================================================
    SECTION B : CUSTOMER SALES ANALYSIS
=====================================================*/


-- Highest total deal value by customer

SELECT account , SUM(close_value) AS total_deal_value
FROM sales_pipeline
GROUP BY account
ORDER BY SUM(close_value) DESC
LIMIT 1;

-- Top 10 customers by deal value

SELECT account , SUM(close_value) AS total_deal_value
FROM sales_pipeline
GROUP BY account
ORDER BY SUM(close_value) DESC
LIMIT 10;


-- Average deal value per customer

SELECT account , AVG(close_value) AS average_deal_value
FROM sales_pipeline
GROUP BY account;


-- Highest total deal value by sector

SELECT a.sector ,  SUM(sp.close_value) AS total_deal_value
FROM accounts AS a
INNER JOIN 
sales_pipeline AS sp
ON a.account = sp.account
GROUP BY a.sector
ORDER BY SUM(sp.close_value) DESC
LIMIT 1;

-- Highest total deal value by office location

SELECT a.office_location , SUM(sp.close_value) AS total_deal_value
FROM accounts AS a 
INNER JOIN 
sales_pipeline AS sp
ON a.account = sp.account
GROUP BY a.office_location
ORDER BY SUM(sp.close_value) DESC 
LIMIT 1;

-- Most Sales opportunities by sector

SELECT a.sector , COUNT(sp.account) AS sales_opportunities
FROM accounts AS a 
INNER JOIN 
sales_pipeline AS sp
ON a.account = sp.account
GROUP BY a.sector
ORDER BY COUNT(sp.account) DESC 
LIMIT 1;

-- Customers with most won deals

SELECT account , COUNT(deal_stage) AS won_deals
FROM sales_pipeline
WHERE deal_stage = 'Won'
GROUP BY account
ORDER BY COUNT(deal_stage) DESC 
LIMIT 1;

-- Customers with most lost deals

SELECT account , COUNT(deal_stage) AS lost_deals
FROM sales_pipeline
WHERE deal_stage = 'Lost'
GROUP BY account
ORDER BY COUNT(deal_stage) DESC 
LIMIT 1;
