# Database Schema

## Overview

The CRM Sales Opportunities dataset consists of four related tables.

### 1. Accounts
Stores customer company information.

Primary Key:
- account

### 2. Products
Stores product information.

Primary Key:
- product

### 3. Sales Teams
Stores sales representatives and managers.

Primary Key:
- sales_agent

### 4. Sales Pipeline
Stores every sales opportunity.

Primary Key:
- opportunity_id

Foreign Keys:
- account
- product
- sales_agent

Fact Table:
- sales_pipeline

Dimension Tables:
- accounts
- products
- sales_teams