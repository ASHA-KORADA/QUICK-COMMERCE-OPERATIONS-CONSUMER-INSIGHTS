🔎 Overview

This project analyzes operational performance and consumer behavior in the Quick Commerce industry using a structured end-to-end data analytics workflow.

The objective is to extract actionable business insights related to:

• Revenue performance

• Delivery efficiency

• Customer satisfaction

• Consumer segmentation

• Expansion strategy

The project demonstrates data cleaning, exploratory analysis, SQL querying, KPI measurement, and dashboard storytelling using industry-standard tools.

📁 Dataset

The dataset contains 1 million+ rows of transactional records of quick commerce orders, including:
Order details (Order ID, Order Value, Items Count),
Company / Platform,
Delivery Time,
Delivery Partner Rating,
Customer Rating,
Product Category,
City,
Customer Age,
Discount Applied.

  • After cleaning, the final dataset contains approximately 948,000 records.

🛠 Tools & Technologies

• SQL (PostgreSQL / MySQL / SQL Server) – Data cleaning & advanced queriesCTEs, Window Functions, NTILE Segmentation).

• 📊Power BI Desktop – Dashboard & KPI visualization

• 📂 Power Query – Data transformation and cleaning layer for reshaping and preparing the data.

• 🧠 DAX (Data Analysis Expressions) – Used for calculated measures, dynamic visuals, and conditional logic.

• 📝Data Modeling & BI: Power BI (Star Schema, Advanced DAX).


🔄 Project Workflow

1️⃣ Data Loading (MS SQL SERVER)

Imported CSV dataset

Inspected structure & data types

Identified missing values

2️⃣ Data Cleaning

Removed null city records

Imputed missing values using:

Mode (Items_Count)

Company-level averages (Customer Rating)

Global average (Delivery Partner Rating)

Standardized column formats

3️⃣ Exploratory Data Analysis (EDA)

Revenue distribution

Delivery time impact on ratings

Customer segmentation

Discount impact analysis


4️⃣ SQL Analysis

Executed structured queries to analyze:

Total revenue by platform

Average order value (AOV)

Operational efficiency score

Customer segmentation (Economy / Standard / Premium)

Expansion-ready cities

Revenue concentration & cumulative contribution

Delivery time vs rating correlation

5️⃣ Power BI Dashboard Development

Built interactive dashboards including:

Revenue & AOV comparison

Delivery performance analysis

Customer segmentation visuals

Operational efficiency comparison

Strategic expansion insights



🖥️ Dashboard Features

Page 1: Executive Summary – High-level KPIs, Revenue Trends, and Platform Performance.
Screenshots:: https://github.com/ASHA-KORADA/QUICK-COMMERCE-OPERATIONS-CONSUMER-INSIGHTS/blob/main/1Executive%20Summary.png

Page 2: Operational Efficiency – Last-mile logistics analysis and delivery bottleneck identification.

Page 3: Consumer Insights – Analyzing customer spending habits and mapping ratings against sales to identify high-potential, under-tapped market opportunities.

Page 4: Strategic Recommendations – Data-driven insights for business stakeholders.



📊 Dashboard Highlights

• Identified fastest platform based on average delivery time

• Measured correlation between delivery time and partner ratings

• Segmented customers based on spending behavior

• Identified cities suitable for expansion using performance criteria

• Calculated efficiency score combining demand and speed


📈 Key Results

• Delivery speed is a major competitive differentiator.

• Premium customers contribute higher average order value.

• Demand is driven more by mature consumers than younger.

• Faster deliveries positively influence partner ratings.

•Certain cities demonstrate strong demand and operational efficiency for expansion.
