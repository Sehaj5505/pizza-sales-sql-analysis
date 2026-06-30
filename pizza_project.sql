CREATE DATABASE pizza_project;
USE pizza_project;

CREATE TABLE pizza_type(
		pizza_type_id VARCHAR(30) PRIMARY KEY,
        name varchar(100) NOT NULL,
        category VARCHAR(15),
        ingredients text
        );

select * from pizza_type;

CREATE TABLE pizzas(
		pizza_id VARCHAR(20) PRIMARY KEY,
        pizza_type_id VARCHAR(30) NOT NULL,
        size CHAR(3),
        price FLOAT,
        constraint FK_pizza_type_id foreign key (pizza_type_id) references pizza_type(pizza_type_id)
        );

CREATE TABLE orders (
		order_id integer PRIMARY KEY,
        order_date DATE,
        order_time time
        );

CREATE TABLE order_details(
		order_detail_id INTEGER PRIMARY KEY,
        order_id INTEGER NOT NULL,
        pizza_id VARCHAR(20) NOT NULL,
        quantity TINYINT,
        constraint FK_order_id foreign key (order_id) references orders(order_id),
        constraint FK_pizza_id foreign key (pizza_id) references pizzas(pizza_id)
        );


-- =============================================================================================

-- Sales Performance

-- =============================================================================================

-- Question 1) - Total Revenue generated


SELECT
	SUM(od.quantity * p.price) AS
total_revenue
FROM order_details as od
JOIN pizzas as p
	ON od.pizza_id = p.pizza_id;
    
-- =============================================================================================

-- Question 2 A)  - Revenue by Pizza Type

SELECT 
	pt.name AS pizza_name,
    ROUND(SUM(od.quantity * p.price),2) AS revenue
FROM order_details AS od
JOIN pizzas AS p
	on od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC;

-- ---------------------------------------------------------------------------------------------

-- Question 2 B) - Revenue By Pizza Size

SELECT
	p.size,
    ROUND(SUM(od.quantity * p.price),2) as revenue
FROM order_details AS od
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY revenue DESC;

-- ---------------------------------------------------------------------------------------------

-- Question 2 C) - Revenue By Category

SELECT 
	pt.category,
    ROUND(SUM(od.quantity * p.price),2) AS revenue
FROM order_details AS od
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY revenue DESC;

-- =============================================================================================

-- Question 3 A) Highest & Lowest Revenue Pizza Types

SELECT
	pt.name AS pizza_name,
    ROUND(SUM(od.quantity * p.price),2) AS revenue
FROM order_details AS od
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC;

-- ---------------------------------------------------------------------------------------------

-- Question 3 B) highest & lowest Revenue by Category 

SELECT 
	pt.category,
    ROUND(SUM(od.quantity * p.price),2) AS revenue
FROM order_details AS od
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY revenue DESC;

-- =============================================================================================

-- Question 4 A)  performing pizzas

SELECT 
	pt.name AS pizza_name,
    ROUND(SUM(od.quantity * p.price),2) AS revenue
FROM order_details AS od
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 5;

-- ---------------------------------------------------------------------------------------------

-- Question 4 B) Bottom 5 Performing Pizzas 

SELECT pt.name AS pizzas_name,
	ROUND(SUM( od.quantity * p.price),2) as revenue
FROM order_details AS od
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue ASC
LIMIT 5;

-- =============================================================================================

-- Question 5 - Top 5 Pizzas By Quantity Sold 

SELECT 
	pt.name AS pizza_name,
    SUM(od.quantity) AS Total_quantity 
FROM order_details AS od
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;

-- =============================================================================================

-- Question 6 - Revenue Contribution By Pizza Size

SELECT
	p.size,
	ROUND(SUM(od.quantity * p.price),2) AS revenue,
    ROUND(SUM( od.quantity * p.price) * 100 / ( SELECT SUM(od2.quantity * p2.price)
    FROM order_details od2
    JOIN pizzas p2
    ON od2.pizza_id = p2.pizza_id),2) AS percentage_contribution
FROM order_details AS od
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY percentage_contribution DESC;

-- =============================================================================================

-- Question 7) Revenue Contribution By Category 

SELECT
pt.category,
	ROUND(SUM(od.quantity * p.price),2) AS revenue,
    ROUND(
		SUM(od.quantity * p.price) * 100 /
        (SELECT SUM(od2.quantity * p2.price)
        FROM order_details od2
        JOIN pizzas p2
			ON od2.pizza_id = p2.pizza_id),2) AS percentage_contribution
FROM order_details AS od
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY percentage_contribution DESC;

-- =============================================================================================

-- Question 8 A: Daily Revenue Trend 

SELECT 
	o.order_date,
    ROUND(SUM(od.quantity * p.price),2) AS
    daily_revenue
FROM orders AS o
JOIN order_details AS od
	ON o.order_id = od.order_id
JOIN pizzas AS p 
	ON od.pizza_id = p.pizza_id
GROUP BY o.order_date
ORDER BY o.order_date;

-- ---------------------------------------------------------------------------------------------

-- Question 8 B: Monthly Revenue Trend 

SELECT 
	MONTH( o.order_date) AS month,
    ROUND(SUM(od.quantity * p.price),2) AS
    monthly_revenue
FROM orders AS o
JOIN order_details AS od
	ON o.order_id = od.order_id
JOIN pizzas AS p 
	ON od.pizza_id = p.pizza_id
GROUP BY MONTH(o.order_date)
ORDER BY month;

-- ---------------------------------------------------------------------------------------------

-- Question 8 C: Weekly Revenue Trend 

SELECT 
DAYNAME(o.order_date) AS day,
ROUND(SUM(od.quantity * p.price),2) AS revenue
FROM orders AS o
JOIN order_details AS od
	ON o.order_id = od.order_id
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id 
GROUP BY day
ORDER BY FIELD(day,
					'MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY','SUNDAY');

-- =============================================================================================

-- Question 9) Average Monthly Revenue By Category 

SELECT 
	category,
    ROUND(AVG(monthly_revenue),2) AS avg_monthly_revenue
FROM ( 
		SELECT 
			pt.category,
			MONTH(o.order_date) AS month,
			SUM(od.quantity * p.price) AS monthly_revenue
		FROM orders AS o
        JOIN order_details AS od
			ON o.order_id = od.order_id
		JOIN pizzas AS p
			ON od.pizza_id = p.pizza_id
		JOIN pizza_type AS pt
			ON p.pizza_type_id = pt.pizza_type_id
		GROUP BY pt.category,MONTH(o.order_date)) AS monthly_data
GROUP BY category
ORDER BY avg_monthly_revenue DESC;

-- =============================================================================================

-- Question 10 A: Poor Performing Pizzas (By Revenue)

SELECT
	pt.name AS pizza_name,
    ROUND(SUM(od.quantity * p.price),2) AS revenue
FROM order_details AS od
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY  pt.name
ORDER BY revenue ASC
limit 5;

-- ---------------------------------------------------------------------------------------------

-- Question 10 B: Poor Performing Pizzas (By Quantity)

SELECT 
	pt.name AS pizza_name,
    SUM(od.quantity) AS total_quantity
FROM order_details AS od
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity ASC
LIMIT 5;

-- =============================================================================================

-- Customer Behavior

-- =============================================================================================

-- Question 11 A: Order By Hour

SELECT 
	HOUR(order_time) AS hour,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY hour
ORDER BY total_orders DESC;

-- ---------------------------------------------------------------------------------------------

-- Question 11 B:  Order By Day

SELECT 
	DAYNAME(order_date) AS day,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY day
ORDER BY FIELD(day,
					'MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY','SUNDAY');
					
-- ---------------------------------------------------------------------------------------------

-- Question 11 C: Daily Order Frequency

SELECT 
	order_date,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY order_date;

-- =============================================================================================

-- Question 12 A: Average Order Size 

SELECT 
	ROUND(AVG(total_quantity),2) AS avg_order_size
FROM (SELECT
			order_id,
            SUM(quantity) AS total_quantity
		FROM order_details
        GROUP BY order_id) AS order_sizes;

-- ---------------------------------------------------------------------------------------------

-- Question 12 B: Average Revenue Per Order

SELECT 
	ROUND(avg(order_revenue),2) AS avg_order_value
FROM( SELECT	
			od.order_id,
            SUM(od.quantity * p.price) AS order_revenue
				FROM order_details AS od
                JOIN pizzas AS p
			GROUP BY od.order_detail_id) AS order_values;


-- =============================================================================================

-- Question 13: Average Pizzas Per Order

SELECT 
	ROUND(AVG(total_pizzas),2) AS avg_pizzas_per_order
FROM( SELECT
			order_id,
			SUM(quantity) AS total_pizzas
		FROM order_details
        GROUP BY order_id) AS order_summary;
        
-- =============================================================================================

-- Question 14: Popular Pizza Combinations

SELECT
		pt1.name AS pizza_1,
        pt2.name AS pizza_2,
        COUNT(*) AS combination_count
FROM order_details od1
JOIN order_details od2
		ON od1.order_id = od2.order_id
        AND od1.pizza_id < od2.pizza_id
JOIN pizzas p1
		ON od1.pizza_id = p1.pizza_id
JOIN pizzas p2
		ON od2.pizza_id = p2.pizza_id
JOIN pizza_type pt1
		ON p1.pizza_type_id = pt1.pizza_type_id
JOIN pizza_type pt2
		ON p2.pizza_type_id = pt2.pizza_type_id
GROUP BY pt1.name, pt2.name
ORDER BY combination_count DESC
LIMIT 5;


-- =============================================================================================

-- Question 15: Orders With Only Vegetarian Pizzas

SELECT
		COUNT(DISTINCT od.order_id) AS veg_only_orders
FROM order_details AS od 
JOIN pizzas AS p
		ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
		ON p.pizza_type_id = pt.pizza_type_id
WHERE od.order_id NOT IN (
							SELECT DISTINCT od2.order_id
                            FROM order_details od2
                            JOIN pizzas AS p2
								ON od2.pizza_id = p2.pizza_id
							JOIN pizza_type AS pt2
								ON p2.pizza_type_id = pt2.pizza_type_id
                                WHERE pt2.category != 'veggie');

-- =============================================================================================

-- Question 16: Most Popular Pizza Size

SELECT
	p.size,
    SUM(od.quantity) AS total_quantity
FROM order_details AS od
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_quantity DESC;

-- =============================================================================================

-- Question 17: Weekend Vs Weekday Analysis

SELECT 
	CASE WHEN DAYOFWEEK(o.order_date) IN (1,7) THEN 'weekend' ELSE 'weekday'
    END AS day_type,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(od.quantity * p.price),2) AS revenue
FROM orders AS o
JOIN order_details AS od
	ON o.order_id = od.order_id
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
GROUP BY day_type;


-- =============================================================================================

-- Question 18: Weekend Revenue By Pizza Type


SELECT
	pt.name AS pizza_name,
    ROUND(SUM(od.quantity * p.price),2) AS revenue
FROM orders AS o
JOIN order_details AS od
	ON o.order_id = od.order_id
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
WHERE DAYOFWEEK(o.order_date) IN (1,7)
GROUP BY pt.name
ORDER BY revenue DESC;

-- =============================================================================================

-- Question 19 A: Orders By Hour

SELECT 
	HOUR(order_time) AS hour,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY hour
ORDER BY total_orders DESC;

-- ---------------------------------------------------------------------------------------------

-- Question 19 B: orders By Day

SELECT
	DAYNAME(order_date) AS day,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY day
ORDER BY total_orders DESC;

-- =============================================================================================

-- Question 20 A: Size Preference At Peak Hour

SELECT 
		p.size,
        SUM(od.quantity) AS total_quantity
FROM orders AS o
JOIN order_details AS od
		ON o.order_id = od.order_id
JOIN pizzas AS p
		ON od.pizza_id = p.pizza_id
WHERE HOUR(o.order_time) = (SELECT HOUR(order_time)
		FROM orders 
        GROUP BY HOUR(order_time)
        ORDER BY COUNT(*) DESC
        LIMIT 1)
GROUP BY p.size
ORDER BY total_quantity DESC;

-- ---------------------------------------------------------------------------------------------


-- Question 20 B: Pizza Type At Peak Hour

SELECT pt.name,
		SUM(od.quantity) AS total_quantity
FROM orders AS o
JOIN order_details AS od
		ON o.order_id = od.order_id
JOIN pizzas AS p
		ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
		ON p.pizza_type_id = pt.pizza_type_id
WHERE HOUR(o.order_time) = (SELECT HOUR(order_time) 
		FROM orders 
        GROUP BY HOUR(order_time)
        ORDER BY COUNT(*) DESC
        LIMIT 1)
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;


-- ---------------------------------------------------------------------------------------------

-- Question 20 C: Category At Peak Hour

SELECT 
	pt.category,
    SUM(od.quantity) AS total_quantity
FROM orders AS o
JOIN order_details AS od
	ON o.order_id = od.order_id
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
WHERE HOUR(o.order_time) = (SELECT HOUR(order_time)
	FROM orders 
    GROUP BY HOUR(order_time)
    ORDER BY COUNT(*) DESC
    LIMIT 1)
GROUP BY pt.category
ORDER BY total_quantity DESC;

-- =============================================================================================

-- Question 21: Avg Pizzas Per Order During Peak Hour

SELECT 
	ROUND(AVG(order_quantity),2) AS avg_pizzas_peak_hour
FROM (SELECT
		o.order_id,
        SUM(od.quantity) AS order_quantity 
	FROM orders AS o
    JOIN order_details AS od
		ON o.order_id = od.order_id
	WHERE HOUR(o.order_time) = ( SELECT HOUR(order_time)
									FROM orders
                                    GROUP BY HOUR(order_time)
                                    ORDER BY COUNT(*) DESC
                                    LIMIT 1)
GROUP BY o.order_id) AS peak_orders;


-- =============================================================================================

-- Operational Insights

-- =============================================================================================

-- Question 22: Monthly Pizza Sales Trend

SELECT
	MONTH(o.order_date) AS month,
	SUM(od.quantity) AS total_pizzas_sold
FROM orders AS o
JOIN order_details AS od
	ON o.order_id = od.order_id
GROUP BY MONTH(o.order_date)
ORDER BY month;

-- =============================================================================================

-- Question 23: Total Quantity Per Pizza Type

SELECT
	pt.name AS pizza_name,
    SUM(od.quantity) AS total_quantity
FROM order_details AS od
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC;

-- =============================================================================================

-- Question 24: Ingredient Usage

SELECT
	pt.ingredients,
    SUM(od.quantity) AS total_usage
FROM order_details AS od
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.ingredients
ORDER BY total_usage DESC;

-- =============================================================================================

-- Question 25: MOST AND LEAST USED INGREDIENT COMBINATIONS

SELECT 
	pt.ingredients,
    SUM(od.quantity) AS total_usage
FROM order_details AS od
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.ingredients
ORDER BY total_usage DESC;

-- =============================================================================================

-- Question 26: Monthly Requirement For Top 3 Ingredient Combinations

SELECT
	DATE_FORMAT(o.order_date,'%Y-%m') AS month,
    pt.ingredients,
    SUM(od.quantity) AS total_usage
FROM orders AS o
JOIN order_details AS od
	ON o.order_id = od.order_id
JOIN pizzas AS p
	ON od.pizza_id = p.pizza_id
JOIN pizza_type AS pt
	ON p.pizza_type_id = pt.pizza_type_id
WHERE pt.ingredients IN ( SELECT ingredients 
									FROM(
										SELECT pt.ingredients,
                                        SUM(od.quantity) AS total_usage
									FROM order_details AS od
                                    JOIN pizzas AS p
										ON od.pizza_id = p.pizza_id
									JOIN pizza_type AS pt
										ON p.pizza_type_id = pt.pizza_type_id
									GROUP BY pt.ingredients
                                    ORDER BY total_usage DESC
                                    LIMIT 3) AS top_ingredients)
GROUP BY month,pt.ingredients
ORDER BY month, total_usage DESC;

-- =============================================================================================

-- Question 27: Supply Chain Optimization Insights

-- High-demand ingredient combinations such as  cheese & tomato and cheese & chicken 

-- are consistently used due to strong demand for popular pizzas.

-- monthly usage trends show relatively stable demand with slight fluctuations, 
-- indicarting predictable inventory requirements.

-- it is recommended to  maintain higher inventory levels for these ingredients,
--  to avoid stock shortages during peak periods.

-- bulk procurement stratergies should be applied for high-demand ingredients to reduce overall procurement costs.

-- Low demand ingredient combination should be stocked minimally to avoid wastage and optimize inventory efficiency. 


-- =============================================================================================


-- Question 28: High Demand Period Insights

-- Customer demand peaks during specific hours of the day,perticulary during 
-- lunch and dinner periods,indicating high operational load during therse times.

-- certain days of the week, especially weekends, show higher order, volumes and revenue
-- requiring increased staffing and faster service operations. 

-- monthly trends indicate fluctuations in demand with some months experiencing higher sales volumes,
-- suggesting the need for advance inventory planning. 

-- these high-demand periods require operational adjustments such as optimised staff
-- scheduling,efficient kitchen workflows, and sufficien inventory availability to maintain service quality

-- =============================================================================================

-- Quesion 29: Operational Efficiency Improvements

-- Peak hours suck as lunch and dinner periods require optimized kitchen workflows 
-- to handle high order volumes efficiently. 

-- pre-preparation of high demand pizzas and ingredients can significantly reduce 
-- preparation time during peak periods. 

-- staffing levels should be increased during weekends and peak hours to ensure 
-- faster order proccessing and delivery. 

-- inventory should be manged proactively by maintaining suffiecient stock of 
-- high-demand ingredients to avoid delays and shortages. 

-- Delivery operations can be optimized by clustering nearby orders and improving
-- route planning to reduce delivery time. 

-- introducing combo offers and pre-defined meal options can streamline order
-- preparation and improve service speed. 

-- =============================================================================================

-- Strategic Decisions 

-- =============================================================================================

-- Question 30: Low-performing Pizzas & Actions

-- Analysis shows that certain pizzas such as Brie carre and spinach supreme
-- consistently generae low revenue and low sales volume. 

-- These pizzas indicate weak customer demand and contribute minimally to overall performance
-- while increasing menu complexity and operational costs. 

-- it is recommended to consider removing these low-performing pizzas to streamline the menu alter
-- and improve operational efficiency 

-- alternatively, pricing adjustments or targeted promotions can be tested before removal
-- to evaluate if performance can be improved

-- focusing on high-performing pizzas will help maximize revenue and optimize resourse utilization

-- =============================================================================================

-- Question 31: Inventory Optimization Stratergy

-- Inventory can be optimized by aligning stock levels with actual customer demand pattern

-- High demand ingredients such as cheese and chicken which are commanly used in 
-- top performing pizzas, should be maintainedat higher stock levels and procured in bulk 
-- to avoid shortages during peak periods and reduce procurement costs. 

-- monthly demand trends should be used to adjust inventory dynamically, ensuring that stock
-- levels match fluctuations in customer demand

-- low demand ingredients associated with underperforming pizzas should be stocked minimally
-- to reduce wastage and unnecessary storage costs.

-- removing ord redesigning low-performaning pizzas will further reduce excess inventory usage
-- and improve overall efficiency 

-- implementing an inventory tracking system will help monitor stock levels in real time,
-- enabling better demand forecasting and preventing both overstocking and stockout. 

-- overall, a demand-driven inventory approach will help minimize waste, control costs,
-- and improve operational efficiency.

-- =============================================================================================

-- Question 32: Vegetarian Expansion Decision

-- Analysis shows that vegetarian-only orders account for approximately 10-11% 
-- of total orders, indicating a niche but consistent customer segment

-- while vegetarian demand in present, it is not dominant campared to overall sales,
-- suggesting that aggresive expansion may not be justified

-- A selective expansion stratergy is recommended focusing on improving excisting 
-- vegetarian option and introducing a limited number of new high-quality items.

-- Targeted promotion and menu optimisation for vegetarian pizzas can help
-- increase demand without over-investing in this segment.

-- overall a balanced approach should be adopted rather than a large scale expansion. 

-- =============================================================================================

-- Question 33: New Size/category Opportunity

-- Analysis of sales trends shows that standard pizza sales such as medium and large
-- Generate the highest demand, while extreme sizes like XL and XXL have very low sales. 

-- This indicates that introducing additional extreme sizes may not be beneficial

-- However there is an opportunity to introduce a mid range or family size pizza
-- that caters to group orders and provides better value for customers. 

-- In terms of categories, high performing categories should be expanded with new
-- veriations while low performing categories should be improved rather than expanded.

-- overall the focus should be on optimizing and slightly expanding succesful segments 
-- rather than introducing completely new or untested options.

-- =============================================================================================

-- Question 34: New Ingredient combination Opportunity

-- Analysis of ingredient usage and popular pizza combinations shows that certain
-- ingredients such as cheese, tomato, and chicken are frequently used in high demand pizzas.

-- these recurrung patterns indicate strong customer preference for specific ingredient combination

-- This creates an opportunity to introduce new pizzas by combining these popular ingredients
-- in innovative way to attract customers and increase sales.

-- Additionally analyzing frequently ordered pizza combinations suggests that customers
-- prefer complementary flavours which can be leveraged to design new menu items.

-- Overall, new ingredient combinations should be developed based on existing high demand
-- ingredients rather than introducing completely unfamiliar options

-- =============================================================================================

-- Question 35: Family Size pizza Decision

-- Analysis shows that large pizzas generate the highest revenue and sales, valume,
-- indicating strong customer preference for bigger portion sizes.

-- However extremely large sizes such as XL and XXL have very low demand 
-- suggesting that customers do not prefer oversized options

-- this indicates an opportunity to introduce a family size pizza that is slightly
-- larger than the standard large size but more practical than XL or XXL

-- A family size option can cater to group orders and provide better value for money.
-- potentially increasing average order value and overall revenue.

-- Therefore, introducing a well balanced family size pizza is recommended
-- provided it is positioned between large and XL sizes.

-- =============================================================================================

-- Question 36: Supplier Cost Optimization Stratergy

-- Analysis of ingredient usage shows that certain ingredients such as cheese, chicken
-- and tomato are used frequentlyin high demand pizzas

-- these high usage ingredients contribute significantly to overall procurement costs,
-- making them ideal condidates for supplier price negotiations.

-- negatiating better pricing or bulk purchase agreements for these ingredients can
-- lead to substantial cost savings.

-- since demand for these ingredients is consistent across months, long terms supplier stabilize pricing.
-- contracts can also be considered to stabilize pricing.

-- Focusing on high demand ingredients for cost optimization will have the greatest 
-- impact on reducing overall expanses without affecting product quality.

-- =============================================================================================
-- =============================================================================================
