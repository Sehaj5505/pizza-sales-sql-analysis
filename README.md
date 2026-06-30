# 🍕 Pizza Sales Data Analysis using SQL

## 📌 Project Overview

This project focuses on analyzing a pizza company's sales data using SQL to uncover meaningful business insights. The objective was to understand sales performance, customer ordering behavior, operational efficiency, and identify strategic opportunities that can help improve overall business performance.

The analysis was performed on a relational database consisting of four interconnected datasets. By writing SQL queries and interpreting the results, this project demonstrates how raw business data can be transformed into actionable insights.

---

## 🎯 Business Objectives

The main objectives of this project were to:

- Analyze overall sales performance
- Identify top-performing and low-performing pizzas
- Understand customer ordering behavior
- Analyze revenue across pizza sizes and categories
- Study monthly sales trends
- Optimize inventory and ingredient management
- Provide strategic business recommendations based on data

---

## 🗂 Dataset Information

The project consists of four CSV datasets.

### 📄 Orders
Contains order date and time.

| Column |
|---------|
| order_id |
| order_date |
| order_time |

---

### 📄 Order Details
Contains information about pizzas ordered.

| Column |
|---------|
| order_detail_id |
| order_id |
| pizza_id |
| quantity |

---

### 📄 Pizzas
Contains pizza size and pricing details.

| Column |
|---------|
| pizza_id |
| pizza_type_id |
| size |
| price |

---

### 📄 Pizza Types
Contains pizza names, categories and ingredients.

| Column |
|---------|
| pizza_type_id |
| name |
| category |
| ingredients |

---

## 🛠 Tools Used

- MySQL Workbench
- SQL
- Git & GitHub

---

## 📚 SQL Concepts Used

This project includes a wide range of SQL concepts, including:

- Database Design
- Primary Keys & Foreign Keys
- Joins
- Aggregate Functions
- GROUP BY
- ORDER BY
- CASE Statements
- Subqueries
- Common Date & Time Functions
- Filtering
- Self Join
- Data Aggregation
- Business KPI Analysis

---

# 📊 Project Analysis

The project was divided into four business areas.

## 1️⃣ Sales Performance

- Total Revenue
- Revenue by Pizza Type
- Revenue by Size
- Revenue by Category
- Top Performing Pizzas
- Low Performing Pizzas
- Top 5 Pizzas by Quantity Sold
- Monthly Revenue Analysis
- Revenue Contribution by Size
- Revenue Contribution by Category

---

## 2️⃣ Customer Behavior

- Average Order Size
- Average Revenue per Order
- Average Pizzas per Order
- Most Popular Pizza Size
- Peak Ordering Hours
- Weekend vs Weekday Analysis
- Popular Pizza Combinations
- Vegetarian Customer Analysis
- Customer Preferences During Peak Hours

---

## 3️⃣ Operational Insights

- Monthly Pizza Sales
- Pizza Demand Analysis
- Ingredient Usage Analysis
- Monthly Ingredient Requirements
- Inventory Optimization
- Supply Chain Recommendations
- Operational Efficiency Improvements

---

## 4️⃣ Strategic Business Decisions

- Identify Low Performing Products
- Menu Optimization
- Family Size Pizza Recommendation
- Vegetarian Menu Expansion Analysis
- New Ingredient Combination Opportunities
- Supplier Cost Optimization
- Inventory Cost Reduction Strategies

---

# 📈 Key Insights

Some important insights obtained during the analysis include:

- Large pizzas generated the highest revenue and were also the most popular size.
- XL and XXL pizzas showed comparatively low demand.
- Customer orders peaked during lunch, dinner, and weekends.
- Average customer order consisted of around 2–3 pizzas.
- Vegetarian-only orders represented approximately 10–11% of total orders.
- Certain pizzas consistently underperformed in both revenue and quantity sold.
- Cheese, Chicken, and Tomato were among the most frequently used ingredient combinations.
- Demand trends can be used to improve inventory planning and staffing decisions.

---

# 💡 Business Recommendations

Based on the analysis, the following recommendations were made:

- Promote high-performing pizzas through targeted marketing campaigns.
- Remove or redesign consistently low-performing pizzas.
- Introduce a practical family-size pizza instead of expanding XL/XXL sizes.
- Improve existing vegetarian options rather than aggressively expanding the category.
- Maintain higher inventory for high-demand ingredients.
- Implement demand-based inventory planning.
- Negotiate supplier pricing for frequently used ingredients.
- Increase staffing during peak business hours and weekends.

---

# 📂 Database Schema

```
Orders
   │
   │ order_id
   ▼
Order Details
   │
   │ pizza_id
   ▼
Pizzas
   │
   │ pizza_type_id
   ▼
Pizza Types
```

---

# 🚀 Project Outcome

This project helped strengthen practical SQL skills while demonstrating how SQL can be used to solve real business problems. Instead of focusing only on writing queries, the project emphasizes business understanding, analytical thinking, and actionable recommendations based on data.

---

## 👨‍💻 Author

**Sehajpreet Kaur**

Aspiring Data Analyst
