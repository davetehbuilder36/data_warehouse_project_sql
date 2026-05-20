# SQL Data Warehouse Project | Bronze, Silver, Gold Architecture

## Project Overview
This project demonstrates the design and implementation of a modern SQL Server data warehouse using the Medallion Architecture (Bronze, Silver, Gold layers).

The goal was to build an end-to-end data warehouse pipeline that ingests raw CRM and ERP data from CSV files, transforms and cleans the data, and delivers business-ready analytical views for reporting and decision-making.

---

## Architecture
The project follows a 3-layer warehouse design:
<img width="1451" height="747" alt="image" src="https://github.com/user-attachments/assets/e09e3cff-6671-40eb-b2ae-bac45bac8d74" />

### Bronze Layer (Raw Data)
Purpose:
Store raw source data exactly as received.

Characteristics:
- Source ingestion from CSV files
- No transformations
- Full batch loads
- Truncate and insert strategy
- Object type: Tables

Source systems:
- CRM data
- ERP data

---

### Silver Layer (Cleaned Data)
Purpose:
Clean, standardize, and enrich source data.

Transformations performed:
- Duplicate removal
- Data cleansing
- NULL handling
- Standardization of country values
- Gender normalization
- Date validation and conversion
- Sales amount recalculation
- Product cost cleanup
- Data enrichment
- Derived columns

Object type:
- Tables

Load strategy:
- Batch processing
- Full refresh

---

### Gold Layer (Business Layer)
Purpose:
Deliver business-ready analytical models.

Objects created:
- Views
- Dimension tables
- Fact tables

Transformations:
- Business logic implementation
- Data integration
- Aggregations
- Star schema modeling

Models:
- Dimensional model
- Star schema
- Aggregated business views

---

## Tech Stack
- SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL
- CSV Files
- Stored Procedures
- Data Warehouse Modeling

---

## Project Structure
```text
DataWarehouse/
│
├── bronze/
│   ├── crm_cust_info
│   ├── crm_prd_info
│   ├── crm_sales_details
│   ├── erp_cust_az12
│   ├── erp_loc_a101
│   └── erp_px_cat_g1v2
│
├── silver/
│   ├── cleaned CRM tables
│   ├── cleaned ERP tables
│   └── transformed business data
│
└── gold/
    ├── dim_customers
    ├── dim_products
    └── fact_sales
