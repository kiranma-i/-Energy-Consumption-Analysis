

# 🌍 World Wide Energy Consumption Analysis

## 📌 Project Overview

This project analyzes global energy consumption, production, emissions, GDP, and population data using **MySQL**. The dataset consists of multiple related tables containing country-wise energy statistics over several years. The objective is to derive meaningful insights by writing advanced SQL queries and performing trend, comparative, and ratio analysis.

---

## 📊 Dataset

The project uses six CSV files imported into a MySQL database.

### Tables

- **Country** – Master table containing country information.
- **Emission** – Country-wise emissions by energy type.
- **Production** – Energy production by country and energy source.
- **Consumption** – Energy consumption by country and energy source.
- **GDP** – GDP (PPP) values by country and year.
- **Population** – Population data by country and year.

---

## 🗄️ Database Schema

The **Country** table acts as the central table.

### Relationships

```
Country (1)
│
├── Emission (Many)
├── Production (Many)
├── Consumption (Many)
├── GDP (Many)
└── Population (Many)
```

---

## 🛠️ Technologies Used

- MySQL
- SQL
- MySQL Workbench

---

## 📈 Analysis Performed

The project answers several business questions, including:

### General & Comparative Analysis

- Total emissions by country for the latest available year
- Top 5 countries by GDP
- Comparison of energy production and consumption
- Energy sources contributing the most to emissions

### Trend Analysis

- Global emissions over time
- GDP trends by country
- Population growth vs emissions
- Energy consumption trends
- Average yearly change in per-capita emissions

### Ratio & Per Capita Analysis

- Emission-to-GDP ratio
- Energy consumption per capita
- Energy production per capita
- Consumption relative to GDP
- GDP growth vs production growth

### Global Comparisons

- Top 10 countries by population and emissions
- Countries reducing per-capita emissions the most
- Global emission share by country
- Global average GDP, emissions, and population by year

---

## 💡 SQL Concepts Used

- SELECT
- WHERE
- GROUP BY
- ORDER BY
- LIMIT
- Aggregate Functions (SUM, AVG)
- INNER JOIN
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions (LAG)
- Foreign Keys
- One-to-Many Relationships

---

## 📂 Project Structure

```
World-Wide-Energy-Consumption-Analysis/
│
├── Dataset/
│   ├── country.csv
│   ├── emission.csv
│   ├── production.csv
│   ├── consumption.csv
│   ├── gdp.csv
│   └── population.csv
│
├── SQL/
│   └── energy_analysis.sql
│
├── Images/
│   └── ER_Diagram.png
│
└── README.md
```

---

## 🚀 How to Run the Project

1. Install **MySQL** and **MySQL Workbench**.
2. Create a new database.
3. Import all six CSV files.
4. Create the required tables.
5. Execute the SQL script.
6. Run the analysis queries to generate insights.

---

## 📌 Key Learnings

- Designing relational databases
- Creating foreign key relationships
- Writing advanced SQL queries
- Using JOINs and Window Functions
- Performing business-oriented data analysis
- Trend and comparative analysis using SQL

---

## 📷 Sample Analysis

The project includes analyses such as:

- Country-wise emissions
- GDP rankings
- Production vs Consumption comparison
- Global emission share
- Per-capita energy analysis
- Emission-to-GDP ratio
- GDP and production growth trends

---

## 🎯 Future Improvements

- Build an interactive Power BI dashboard.
- Add SQL stored procedures and views.
- Create indexes to improve query performance.
- Automate data loading using Python.

---

## 👩‍💻 Author

**Kiran Macha**

- GitHub: https://github.com/kiranma-i
- LinkedIn: https://www.linkedin.com/in/kiran-macha
