/*=========================================================
File Name : 02_create_tables.sql
Project   : CRM Sales Pipeline Analysis
Author    : Aniket Singh
Purpose   : Create all database tables with appropriate
            data types and primary key constraints.
=========================================================*/

USE crm_sales_pipeline;

create table accounts(
account	VARCHAR(100) primary key,
sector	VARCHAR(50),
year_established INT,
revenue	DECIMAL(10,2),
employees INT,
office_location	VARCHAR(100),
subsidiary_of	VARCHAR(100)
);


create table products(
product	VARCHAR(100) primary key,
series	VARCHAR(50),
sales_price	decimal(10,2)
);

create table sales_teams(
sales_agent	VARCHAR(100) primary key,
manager	VARCHAR(100),
regional_office	VARCHAR(50)
);

create table sales_pipeline(
opportunity_id	VARCHAR(20) primary key,
sales_agent	VARCHAR(100),
product	VARCHAR(100),
account	VARCHAR(100),
deal_stage	VARCHAR(50),
engage_date	DATE,
close_date	DATE,
close_value	DECIMAL(10,2)
);