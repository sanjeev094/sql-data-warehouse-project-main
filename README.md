# Data Warehouse and Analytics Project

## Overview

This project focuses on building a modern data warehouse using SQL Server to integrate, clean, and transform sales data from CRM and ERP source systems.

The project follows the Medallion Architecture, consisting of Bronze, Silver, and Gold layers, to organize data and prepare it for business intelligence, reporting, and analytics.

## Objectives

- Build a centralized data warehouse using SQL Server.
- Integrate data from CRM and ERP source systems.
- Develop ETL pipelines for data ingestion and transformation.
- Clean and standardize raw data.
- Design a star schema using fact and dimension tables.
- Implement data quality checks and validation.
- Perform SQL-based analytics to identify business insights.

## Technologies Used

- **Database:** Microsoft SQL Server
- **Query Language:** SQL
- **Database Management:** SQL Server Management Studio (SSMS)
- **Version Control:** Git and GitHub
- **Data Modeling:** Draw.io

## Data Architecture

The project uses the Medallion Architecture with three layers.

### 1. Bronze Layer

- Stores raw data from CRM and ERP systems.
- Imports source CSV files into SQL Server.
- Preserves the original source data before transformation.

### 2. Silver Layer

- Cleans and standardizes the raw data.
- Handles missing values, duplicates, and inconsistent formats.
- Integrates data from different source systems.
- Prepares reliable data for analytical processing.

### 3. Gold Layer

- Stores business-ready data.
- Organizes data into fact and dimension tables.
- Implements a star schema for efficient analytical queries.
- Supports reporting and business intelligence.

## Project Structure

```text
sql-data-warehouse-project/
├── 00_setup/
│   └── Database setup instructions
├── 01_datasets/
│   ├── source_crm/
│   └── source_erp/
├── 02_docs/
│   ├── requirements.md
│   └── Data architecture and model documentation
├── 03_scripts/
│   ├── init_database.sql
│   ├── bronze/
│   ├── silver/
│   └── gold/
└── 04_tests/
    └── Data quality validation scripts
```

## Data Sources

The project uses CSV files from two source systems.

- **CRM:** Customer and sales-related information.
- **ERP:** Additional business, customer, and product-related information.

The data from both systems is integrated into a unified analytical model.

## ETL Pipeline

The data warehouse pipeline consists of the following steps:

1. **Extract:** Read the source CSV files from the CRM and ERP systems.
2. **Load:** Import raw data into the Bronze layer.
3. **Transform:** Clean, standardize, and integrate the data in the Silver layer.
4. **Model:** Create analytical fact and dimension tables in the Gold layer.
5. **Validate:** Run data quality checks to ensure consistency and reliability.
6. **Analyze:** Execute SQL queries to generate meaningful business insights.

## Key Features

- Integration of multiple source systems.
- Layered data processing using Medallion Architecture.
- SQL-based ETL pipeline development.
- Data cleansing and standardization.
- Fact and dimension table modeling.
- Star schema implementation.
- Data quality testing and validation.
- Analytical SQL queries for business reporting.

## Business Intelligence and Analytics

The project supports analysis in the following areas.

### Customer Analysis

- Understand customer distribution and purchasing behavior.
- Identify customer segments.
- Analyze customer contribution to sales.

### Product Analysis

- Evaluate product performance.
- Identify top-performing products.
- Compare product sales and revenue.

### Sales Analysis

- Analyze overall sales performance.
- Identify sales trends.
- Compare revenue across products and customers.
- Generate metrics to support business decisions.

## Project Requirements

### Data Engineering

- Import data from CRM and ERP CSV files.
- Clean and resolve data quality issues.
- Integrate the source systems into a unified data warehouse.
- Build Bronze, Silver, and Gold layers.
- Develop a documented analytical data model.
- Focus on the latest available dataset rather than historical tracking.

### Data Analytics

- Write SQL queries for customer behavior analysis.
- Evaluate product performance.
- Identify sales trends and patterns.
- Generate business metrics for reporting and decision-making.

## Setup and Execution

1. Install Microsoft SQL Server and SQL Server Management Studio.
2. Clone the project repository.
3. Place the source CSV files in the appropriate dataset folders.
4. Open SQL Server Management Studio and connect to your database instance.
5. Execute `03_scripts/init_database.sql` to initialize the database.
6. Execute the Bronze layer scripts to load raw data.
7. Run the Silver layer scripts to clean and transform the data.
8. Execute the Gold layer scripts to create analytical tables.
9. Run the data quality tests in `04_tests/`.
10. Execute analytical SQL queries to explore the results.

**Note:** Update the dataset paths in the loading scripts according to your local system before executing the pipeline.

## Documentation

Project documentation includes:

- Data warehouse requirements.
- Data architecture diagrams.
- Data model documentation.
- ETL pipeline scripts.
- Data quality validation scripts.
- Analytical SQL queries.

## Author

**Sanjeev Singh**

This project demonstrates my practical implementation of SQL, data warehousing, ETL pipelines, data modeling, and business analytics.

