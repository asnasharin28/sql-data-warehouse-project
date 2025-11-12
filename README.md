# 📊 Data Warehouse and Analytics Project

Welcome to the **Data Warehouse and Analytics Project** repository! 🚀  
This project demonstrates a complete **data warehousing and analytics solution**, from building a modern data warehouse to generating **actionable business insights**.

---

## 🏗️ Data Architecture

This project adopts the **Medallion Architecture (Bronze–Silver–Gold layers)** for a scalable and organized data pipeline.

| Layer | Description |
|:--|:--|
| 🥉 **Bronze Layer** | Stores raw data directly from source systems (CSV files → SQL Server Database). |
| 🥈 **Silver Layer** | Cleanses, standardizes, and normalizes data to prepare it for analysis. |
| 🥇 **Gold Layer** | Contains business-ready data modeled in a **Star Schema** for analytics and reporting. |

---

## 📖 Project Overview

This project includes:

- ✅ **Data Architecture** – Designing a modern data warehouse using the Medallion Architecture.  
- ✅ **ETL Pipelines** – Extracting, transforming, and loading data into SQL Server.  
- ✅ **Data Modeling** – Creating fact and dimension tables optimized for analytics.  
- ✅ **Analytics & Reporting** – Writing SQL-based reports and dashboards to generate insights.

---

## 🎯 Skills Demonstrated

This repository highlights core **data analytics and engineering skills**:

- 🧩 SQL Development & Query Optimization  
- 🏗️ Data Architecture & Schema Design  
- ⚙️ ETL Pipeline Development  
- 🧮 Data Cleaning & Transformation  
- 📊 Data Analytics & KPI Reporting

---

## 🛠️ Tools & Technologies

All tools used are **free and beginner-friendly**, ideal for analysts building hands-on experience:

| Tool | Purpose |
|:--|:--|
| 🗄️ **SQL Server Express** | Lightweight database server for data storage and transformation. |
| 💻 **SQL Server Management Studio (SSMS)** | GUI for database management and query execution. |
| 🧾 **Datasets (CSV Files)** | Source data from ERP and CRM systems. |
| 🧠 **Draw.io** | Used for data architecture, flow, and model diagrams. |
| 📘 **Notion** | Project documentation and task tracking. |
| 🔗 **Git & GitHub** | Version control and project collaboration. |

> 🧩 Includes a **Notion project template** and **step-by-step task tracking** for each project phase.

---

## 🚀 Project Requirements

### 🏗️ 1️⃣ Building the Data Warehouse (Data Engineering)

**Objective:**  
Develop a **modern data warehouse using SQL Server** to consolidate sales data and enable analytical reporting.

**Specifications:**

- Import ERP & CRM datasets from CSV files.  
- Cleanse and resolve data quality issues.  
- Integrate both sources into a unified, analytics-ready model.  
- Focus on the latest dataset (historization not required).  
- Document the data model and architecture for stakeholders and analysts.

---

### 📊 2️⃣ BI, Analytics & Reporting (Data Analysis)

**Objective:**  
Perform **SQL-based analytics** to extract insights on:

- 👥 Customer Behavior  
- 📦 Product Performance  
- 💰 Sales Trends  

These insights help stakeholders make **data-driven business decisions** and monitor key performance metrics.

📄 *For more details, see* [`docs/requirements.md`](./docs/requirements.md)

---

## 📂 Project File Structure

```plaintext
data-warehouse-and-analytics-project/
│
├── 📁 datasets/                          # Raw and sample data files
│   ├── erp_data.csv                      # ERP source data
│   ├── crm_data.csv                      # CRM source data
│   └── readme.txt                        # Info about data sources
│
├── 📁 docs/                              # Documentation & design files
│   ├── data_architecture.drawio          # Medallion architecture (Bronze, Silver, Gold)
│   ├── etl_pipeline.drawio               # ETL flow diagram
│   ├── data_models.drawio                # Star schema data model
│   ├── data_catalog.md                   # Dataset descriptions and metadata
│   ├── data_flow.drawio                  # Data flow visualization
│   ├── naming-conventions.md             # Standards for naming tables, fields, scripts
│   └── requirements.md                   # Detailed project requirements & goals
│
├── 📁 scripts/                           # SQL scripts for ETL and modeling
│   ├── 📁 bronze/                        # Raw data ingestion scripts
│   │   ├── 01_create_bronze_tables.sql
│   │   └── 02_load_raw_data.sql
│   │
│   ├── 📁 silver/                        # Data cleaning and transformation scripts
│   │   ├── 01_clean_transform.sql
│   │   └── 02_standardize_data.sql
│   │
│   ├── 📁 gold/                          # Analytical data model (star schema)
│   │   ├── 01_create_fact_tables.sql
│   │   └── 02_create_dimension_tables.sql
│   │
│   └── readme.txt                        # Notes about script execution order
│
├── 📁 analytics/                         # SQL queries and reports for insights
│   ├── customer_behavior_analysis.sql
│   ├── product_performance_analysis.sql
│   ├── sales_trends_analysis.sql
│   └── kpi_summary_report.sql
│
├── 📁 tests/                             # Data validation & QA scripts
│   ├── data_quality_checks.sql
│   ├── null_value_check.sql
│   └── duplicate_check.sql
│
├── 📁 outputs/                           # Final processed data or reports
│   ├── cleaned_data_exports/
│   ├── analytics_results/
│   └── visualizations/                   # Screenshots of Tableau / Power BI dashboards (optional)
│
├── README.md                             # Project overview and documentation
├── LICENSE                               # Open-source license (MIT)
├── .gitignore                            # Ignore unnecessary files/folders
└── requirements.txt                      # Dependencies and setup info









🛡️ License

This project is licensed under the MIT License.
You are free to use, modify, and share this project with proper credit.

🌟 About Me

👩‍💻 Asna Sharin P V — Data Analyst

I’m passionate about transforming raw data into meaningful insights.
Skilled in SQL, Excel, Tableau, Power BI, and data visualization, I focus on turning data into clear, actionable stories.

📬 Connect With Me

Let’s connect and collaborate!

🌐 Portfolio: https://asnasharinpv.netlify.app

💼 LinkedIn: https://linkedin.com/in/asna-sharin-b3757025a

💻 GitHub: https://github.com/asnasharin28

✉️ Email: asnasharin2003@gmail.com
