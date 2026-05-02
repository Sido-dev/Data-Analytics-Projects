# 📊 RFM Analysis (Customer Segmentation using BigQuery)

## 🚀 Overview

This project implements an end-to-end **RFM (Recency, Frequency, Monetary) Analysis** pipeline to segment customers based on their purchasing behavior. It transforms raw transactional data into **business-ready insights** using scalable cloud-based analytics.

The entire workflow is built using **Google BigQuery**, focusing on efficient data processing, ranking, scoring, and final customer segmentation.

---

## 🎯 What This Project Does

* Combines multiple monthly sales datasets into a single unified table
* Calculates **RFM metrics** for each customer

    Recency – calculated using OrderDate (days since last purchase)

    Frequency – calculated using CustomerID (total number of orders)

    Monetary – calculated using OrderValue (total amount spent)

* Assigns **rankings** based on recency, frequency, and monetary value
* Converts rankings into **decile-based scores (1–10)**
* Computes an overall **RFM score**
* Segments customers into meaningful business categories

---

## 🧱 Workflow

### 1️⃣ Data Preparation

* Merged all monthly sales tables into a single dataset for yearly analysis
* Ensured consistency in schema and data types

### 2️⃣ RFM Metrics Calculation

* **Recency:** Days since last purchase
* **Frequency:** Total number of transactions
* **Monetary:** Total spending

### 3️⃣ Ranking System

* Customers ranked using window functions:

  * Recent customers ranked higher
  * Frequent buyers ranked higher
  * High spenders ranked higher

### 4️⃣ Scoring (Deciles)

* Assigned scores from **1 to 10** using distribution-based bucketing
* Higher score = better customer value

### 5️⃣ Final Segmentation

Customers are grouped into business-friendly segments such as:

* VIP Champions Customers
* Loyal Customers
* Potential Loyalists
* New Customers
* Promising
* Need Attention
* At Risk
* Lost / Inactive

---

## 🛠️ Tech Stack

* **Platform:** Google BigQuery
* **Language:** SQL
* **Core Concepts:**

  * CTEs (Common Table Expressions)
  * Window Functions (ROW_NUMBER, NTILE)
  * Aggregations (SUM, COUNT, MAX)
  * Date Functions
  * Data Transformation & Segmentation

---

## ⚙️ How to Run

1. Upload your dataset into **Google BigQuery**
2. Replace the **project ID and dataset name** with your own
3. Execute the SQL steps sequentially
4. The final output will be a **segmented customer table ready for analysis or dashboards**

---

## ⚠️ Handling Date Format Issue (Important)

If the `sales202512` table throws an error due to incorrect date format in the `OrderDate` column, create a cleaned version of the table with the correct `DATE` datatype before running the pipeline.

After creating the corrected table, replace:

* `sales202512` ➝ `sales202512_new`

This ensures:

* Consistent schema across all monthly tables
* No query failures during data merging
* Accurate RFM calculations

---

## 📊 Output

The final dataset includes:

* Customer-level RFM metrics
* Ranking and scoring (1–10 scale)
* Total RFM score
* Business-defined customer segments

---

## 💡 Use Cases

* Customer segmentation & targeting
* Marketing campaign optimization
* Identifying high-value customers
* Churn detection
* Business intelligence dashboards

---

## 🔥 Key Highlights

* End-to-end RFM pipeline implementation
* Clean transformation from raw data to BI-ready output
* Integration with tools like Power BI or Tableau

---


Sudhanshu Narayane (Sido-dev) 

Focused on Data Analytics, SQL, and building impactful data-driven solutions.