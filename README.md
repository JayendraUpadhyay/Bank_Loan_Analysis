# 🏦 Bank Loan Analysis | SQL + Power BI End-to-End Project

A comprehensive **Finance Domain Project** built using **SQL Server** and **Power BI Desktop**, performing both **data analytics and business intelligence reporting**.  
This project transforms raw financial loan data into actionable insights that help banks assess portfolio performance, borrower credit behavior, and funding efficiency.

---

## 📘 Project Overview

**Objective:**  
To analyze loan applications, funding rates, repayment behavior, and portfolio performance using advanced data modeling and visualization.

**Goals:**
- Evaluate total loan disbursements and repayments.
- Identify good vs bad loans to measure collection health.
- Track KPIs like *Average DTI, Average Interest Rate,* and *MoM Funding Growth.*
- Enable business users to filter and view data across multiple dimensions (State, Grade, Purpose, Tenure).

**Deliverables:**
- Cleaned and structured SQL database (`Bank_Loan_DB`)
- Data views and performance metrics created using SQL queries
- Interactive Power BI dashboard with navigation and dynamic KPIs

---

## 🧠 Domain Context

In the banking industry, understanding borrower risk and repayment trends is essential.  
Through this analysis, the project uncovers **insightful financial metrics** that aid in decision-making, such as:

- **Loan Origination Trends** (month-on-month analysis)
- **Customer Repayment Patterns**
- **Default Ratios and Portfolio Distribution**
- **State and Term-Wise Lending Performance**

---

## 🔧 Tech Stack

| Component | Tool/Technology |
|------------|----------------|
| Database | SQL Server (MySQL-compatible queries) |
| BI Tool | Power BI Desktop |
| Data Format | CSV |
| Analytics Logic | SQL Views, Aggregations, DAX Calculations |
| Domain | Finance / Banking Analytics |

---

## 🧩 Project Workflow

### 1️⃣ SQL Development Process
CREATE DATABASE Bank_Loan;
USE Bank_Loan;

-- Created loans_data table
-- Imported raw CSV data via SQL import utility
-- Cleaned and standardized date formats and numeric types


### Data Preparation:
- Removed nulls & handled missing Employee Titles
- Verified datatypes (`DECIMAL` for Amounts, `DATE` for Date fields)
- Established primary key (`id`)

### Analytical SQL Views
Examples of SQL Analytical Views created:

| Metric | SQL View Name | Description |
|--------|----------------|-------------|
| Total Loan Applications | `Total_Loan_Applications` | Monthly trend of loan applications |
| Funded Amounts | `Total_Funded_Amount` | Month-wise total funding issued |
| Total Repayment | `Total_Amount_Received` | Outgoing vs repaid amount summary |
| Average Interest Rate | `Average_Interest_Rate` | Tracks lending interest trends |
| DTI Ratio | `Average_DTI_Ratio` | Debt-to-income ratio across borrowers |
| Loan Health | `Good_Loan_Applications` / `Bad_Loan_Applications` | Classifies performing vs non-performing loans |

#### Additional SQL Analytical Layers:
- Regional Analysis by State  
- Loan Purpose Breakdown (credit card, education, home improvement, etc.)  
- Loan Term & Employee Length Analysis  

---

## 🧮 Key SQL Code Samples

**Total Loan Applications**<br>

`SELECT COUNT(id) AS Total_Loan_Applications FROM loans_data;`<br>
<img width="229" height="62" alt="Screenshot 2025-10-26 003033" src="https://github.com/user-attachments/assets/8c5a21c3-b430-4396-9dd7-032275c8d92b" />

---

**Month-on-Month Funding Trend**<br>

`CREATE VIEW Total_Funded_Amount AS`<br>
`SELECT MONTH(issue_date) AS Month, ROUND(SUM(loan_amount)) AS Monthly_Amount`<br>
`FROM loans_data`<br>
`GROUP BY MONTH(issue_date)`<br>
`ORDER BY MONTH(issue_date);`<br>
<img width="609" height="318" alt="Screenshot 2025-10-26 003319" src="https://github.com/user-attachments/assets/3274d87d-1a65-4b13-ab0b-99fe91c066e2" />

---

**Loan Performance Metrics View**<br>

`CREATE VIEW Loan_Performance_Metrics_View AS`<br>
`SELECT`<br>
`loan_status AS Loans_Status,`<br>
`COUNT(id) AS Total_Loan_Applications,`<br>
`SUM(loan_amount) AS Total_Funded_Amount,`<br>
`SUM(total_payment) AS Total_Amount_Received,`<br>
`AVG(int_rate)*100 AS Average_Interest_Rate,`<br>
`AVG(dti)*100 AS Average_DTI`<br>
`FROM loans_data`<br>
`WHERE (issue_date) BETWEEN '2021-01-01' AND '2021-12-31'`<br>
`GROUP BY loan_status;`<br>
<img width="924" height="141" alt="Screenshot 2025-10-26 003933" src="https://github.com/user-attachments/assets/e730f461-deba-4c9b-ad19-6df6e89bf423" />


---

## 💡 Power BI Dashboard Development

After building analytical SQL views, data was imported and modeled in Power BI.

### Data Modeling:
- Established 1:* relationship between `Date Table` and `Loans Data`
- Ensured single-direction filtering for accuracy  
- Built a structured model that supports DAX calculations like:
  - `[MTD Funded Amount]`
  - `[MoM Loan Applications]`
  - `[Good Loan %]` and `[Bad Loan %]`

### Dashboard Pages:

#### **1️⃣ Summary Dashboard**
- KPIs: Total Loans, Funded Amount, Receipts, Avg Interest, Avg DTI  
- Metrics: MTD vs MoM Growth Indicators  
- Donut chart showing Good Loans (repaying on time) vs Bad Loans (charged off)

#### **2️⃣ Overview Dashboard**
- Dynamic metric switching using Field Parameters  
- Charts: Issue Date Trends, Regional Analysis, Loan Purpose Breakdown  
- Insights: Month and state-wise performance comparison

#### **3️⃣ Detailed Data View**
- Tabular report of loans at customer level  
- Filters for state, purpose, grade, and loan term  
- Easily exportable for management reporting

---

### **Power BI Dashboards**
<img width="1433" height="805" alt="Screenshot 2025-10-25 234146" src="https://github.com/user-attachments/assets/b0e23b93-f15a-4de7-ac84-3bad23622f37" />

---

<img width="1433" height="808" alt="Screenshot 2025-10-25 234038" src="https://github.com/user-attachments/assets/5b2aea35-3633-4c51-9e5a-bcd46be98819" />

---

<img width="1435" height="808" alt="Screenshot 2025-10-25 234412" src="https://github.com/user-attachments/assets/dad6926a-3dd6-4a09-98dc-2430f2d86b1a" />

---

## 📊 Key Insights Derived

| Indicator | Insight |
|------------|----------|
| **Total Loan Applications** | ~38K analyzed across 1 year |
| **Good Loan Percentage** | 86% of total funded loans are performing well |
| **Bad Loan Ratio** | 14% flagged as charge-off/overdue |
| **Average DTI** | 13.4% |
| **Top Loan Purpose** | Debt Consolidation |
| **Highest Performing State** | California (based on volume & repayments) |

---

## 🧭 Business Value

This project helps financial institutions:
- **Monitor portfolio health** via live KPIs.  
- **Identify repayment gaps** and improve risk management.  
- **Focus lending on high-value customer segments.**  
- **Enable strategic insights** through intuitive visuals and dynamic analysis filters.

---

## 🧾 Tools Used

- **SQL Server Management Studio (SSMS)** — For query execution and database management  
- **Power BI Desktop** — For data modeling, KPIs, and visualization  
- **Excel/CSV** — Data import and validation  
- **DAX** — Optimization of power calculations  
- **Visualization Layer** — KPI cards, Donut charts, Line graphs, Tree maps  

---

## 🧑‍💻 About the Author

**Name:** Jayendra Upadhyay  
**Role:** Data Analyst | Power BI & SQL Developer  
**Specialization:** Business Intelligence, Dashboards, Data Modelling  
**Connect:** [https://www.linkedin.com/in/jayendra-upadhyay-13601a37a](https://www.linkedin.com/in/jayendra-upadhyay-13601a37a?lipi=urn%3Ali%3Apage%3Ad_flagship3_profile_view_base_contact_details%3Bv2TFlms2TRqZPh2iDfQv7g%3D%3D)

---

## 🌟 Future Scope
- Integration with **Power BI Service** for auto-refresh dashboards.  
- Implementation of **Forecasting Models for Default Prediction.**  
- Advanced segmentation using **Machine Learning Classification (Next Phase).**

---

## 🏁 Conclusion

The **Bank Loan Analysis Project** demonstrates complete **data analytics lifecycle skills** — from data ingestion and SQL-based modeling to insight-rich Power BI reporting.  
It highlights real-world abilities in **data visualization, data preparation, and financial reporting**, making it an ideal portfolio project for data analysis and BI roles.

---
