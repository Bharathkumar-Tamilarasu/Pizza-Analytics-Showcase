# Pizza Analytics Showcase

## Query Execution Log

**Author**: Bharathkumar Tamilarasu <br />
**Email**: bharathkumar.t.17@gmail.com <br />
**Website**: https://bharathkumart17.wixsite.com/portfolio <br />
**LinkedIn**: https://www.linkedin.com/in/bharathkumar-tamilarasu-218429222/  <br />
##
	
### A.	KPI’s

We need to analyze key indicators for our pizza sales data to gain insights into our business performance. Specifically, we want to calculate the following metrics:

#### I.	Total Revenue

The sum of the total price of all pizza orders.

````sql
SELECT SUM(TOTAL_PRICE) AS TOTAL_REVENUE
FROM PIZZA_SALES
````

**Results:**

| total_revenue |
|---------------|
| 817860.0508   |

#### II. Average Order Value

The average amount spent per order, calculated by dividing the total revenue by the total number of orders.

````sql
SELECT SUM(TOTAL_PRICE) / COUNT(DISTINCT ORDER_ID) AS AVERAGE_ORDER_VALUE
FROM PIZZA_SALES
````

**Results:**

| average_order_value |
|---------------------|
| 38.30726233         |

#### III. Total Pizzas Sold

The sum of the quantities of all pizzas sold.

````sql
SELECT SUM(QUANTITY) AS TOTAL_PIZZAS_SOLD
FROM PIZZA_SALES
````

**Results:**

| total_pizzas_sold |
|-------------------|
| 49574             |

#### IV. Total Orders

The total number of orders placed.

````sql
SELECT COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES
````

**Results:**

| total_orders |
|--------------|
| 21350        |

#### V.	Average Pizzas Per Order

The average number of pizzas sold per order, calculated by dividing the total number of pizzas sold by the total number of orders.

````sql
SELECT ROUND((SUM(QUANTITY) * 1.0) / (COUNT(DISTINCT ORDER_ID) * 1.0),2) AS AVERAGE_PIZZAS_PER_ORDER
FROM PIZZA_SALES
````

**Results:**

| average_pizzas_per_order |
|--------------------------|
| 2.32                     |


### B.	Hourly Trend for Total Pizzas Sold

This query help us to identify any patterns or fluctuations in order volumes on a hourly basis.

````sql
SELECT EXTRACT(HOUR FROM ORDER_TIME) AS ORDER_TIME,SUM(QUANTITY) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY 1
ORDER BY 1
````

**Results:**

| order_time | total_orders |
|------------|--------------|
| 9          | 4            |
| 10         | 18           |
| 11         | 2728         |
| 12         | 6776         |
| 13         | 6413         |
| 14         | 3613         |
| 15         | 3216         |
| 16         | 4239         |
| 17         | 5211         |
| 18         | 5417         |
| 19         | 4406         |
| 20         | 3534         |
| 21         | 2545         |
| 22         | 1386         |
| 23         | 68           |

### C.	Weekly Trend for Total Orders

This query will allow us to identify peak weeks or periods of high order activity.

````sql
SELECT EXTRACT(WEEK FROM ORDER_DATE) AS WEEK_NUMBER,
	EXTRACT(YEAR FROM ORDER_DATE) AS ORDER_YEAR,
	COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY 1,2
ORDER BY 1
````

**Results:(First 5 Weeks)**

| week_number | order_year | total_orders | week_number |
|-------------|------------|--------------|-------------|
| 1           | 2015       | 254          | 21          |
| 2           | 2015       | 427          | 22          |
| 3           | 2015       | 400          | 23          |
| 4           | 2015       | 415          | 24          |
| 5           | 2015       | 436          | 25          |


### D.	Percentage of Sales by Pizza Category

This query will provide insights into the popularity of various pizza categories and their contribution to overall sales.

````sql
SELECT PIZZA_CATEGORY,
	CAST(SUM(TOTAL_PRICE) AS DECIMAL(10,2)) AS TOTAL_SALES,
	CAST((SUM(TOTAL_PRICE) * 100.0 / (SELECT SUM(TOTAL_PRICE) FROM PIZZA_SALES)) AS DECIMAL(10,2))
		AS PERCENTAGE_OF_TOTAL_SALES
FROM PIZZA_SALES
GROUP BY 1
ORDER BY 1
````

 
**Results:**

| pizza_category | total_sales | percentage_of_total_sales |
|----------------|-------------|---------------------------|
| Chicken        | 195919.5    | 23.96                     |
| Classic        | 220053.1    | 26.91                     |
| Supreme        | 208197      | 25.46                     |
| Veggie         | 193690.45   | 23.68                     |


### E.	Percentage of Sales by Pizza Size

This query will help us understand customer preferences for pizza sizes and their impact on sales.

````sql
SELECT PIZZA_SIZE,
	CAST(SUM(TOTAL_PRICE) AS DECIMAL(10,2)) AS TOTAL_SALES,
	CAST((SUM(TOTAL_PRICE) * 100 /(SELECT SUM(TOTAL_PRICE)FROM PIZZA_SALES)) AS DECIMAL(10,2))
		AS PERCENTAGE_OF_TOTAL_SALES
FROM PIZZA_SALES
GROUP BY 1
ORDER BY 3 DESC
````
 
**Results:**

| pizza_size | total_sales | percentage_of_total_sales |
|------------|-------------|---------------------------|
| L          | 375318.7    | 45.89                     |
| M          | 249382.25   | 30.49                     |
| S          | 178076.5    | 21.77                     |
| XL         | 14076       | 1.72                      |
| XXL        | 1006.6      | 0.12                      |


### F.	Total Pizzas Sold by Pizza Category

This query will allow us to compare the sales performance of different pizza categories.

````sql
SELECT PIZZA_CATEGORY,
	SUM(QUANTITY) AS TOTAL_SALES
FROM PIZZA_SALES
GROUP BY 1
ORDER BY 2 DESC
````
 
**Results:**

| pizza_category | total_sales |
|----------------|-------------|
| Classic        | 14888       |
| Supreme        | 11987       |
| Veggie         | 11649       |
| Chicken        | 11050       |


### G.	Top 5 Best Sellers by Revenue, Total Quantity and Total Orders

These queries will help us identify the most popular pizza options.

#### I.	By Revenue

````sql
SELECT PIZZA_NAME,
	SUM(TOTAL_PRICE) AS TOTAL_REVENUE
FROM PIZZA_SALES
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
````

**Results:**

| pizza_name                   | total_revenue |
|------------------------------|---------------|
| The Thai Chicken Pizza       | 43434.25      |
| The Barbecue Chicken Pizza   | 42768         |
| The California Chicken Pizza | 41409.5       |
| The Classic Deluxe Pizza     | 38180.5       |
| The Spicy Italian Pizza      | 34831.25      |

 

#### II. By Total Quantity

````sql
SELECT PIZZA_NAME,
	SUM(QUANTITY) AS TOTAL_QUANTITY
FROM PIZZA_SALES
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
````
 
**Results:**

| pizza_name                 | total_quantity |
|----------------------------|----------------|
| The Classic Deluxe Pizza   | 2453           |
| The Barbecue Chicken Pizza | 2432           |
| The Hawaiian Pizza         | 2422           |
| The Pepperoni Pizza        | 2418           |
| The Thai Chicken Pizza     | 2371           |


#### III. Total Orders

````sql
SELECT PIZZA_NAME,
	COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
````
 
**Results:**

| pizza_name                 | total_orders |
|----------------------------|--------------|
| The Classic Deluxe Pizza   | 2329         |
| The Hawaiian Pizza         | 2280         |
| The Pepperoni Pizza        | 2278         |
| The Barbecue Chicken Pizza | 2273         |
| The Thai Chicken Pizza     | 2225         |

### H.	Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders

These queries will enable us to identify underperforming or less popular pizza options.

#### I.	By Revenue

````sql
SELECT PIZZA_NAME,
	SUM(TOTAL_PRICE) AS TOTAL_REVENUE
FROM PIZZA_SALES
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5
````
 
**Results:**

| pizza_name                | total_revenue |
|---------------------------|---------------|
| The Brie Carre Pizza      | 11588.49981   |
| The Green Garden Pizza    | 13955.75      |
| The Spinach Supreme Pizza | 15277.75      |
| The Mediterranean Pizza   | 15360.5       |
| The Spinach Pesto Pizza   | 15596         |


#### II. By Total Quantity

````sql
SELECT PIZZA_NAME,
	SUM(QUANTITY) AS TOTAL_QUANTITY
FROM PIZZA_SALES
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5
````

**Results:**

| pizza_name                | total_quantity |
|---------------------------|----------------|
| The Brie Carre Pizza      | 490            |
| The Mediterranean Pizza   | 934            |
| The Calabrese Pizza       | 937            |
| The Spinach Supreme Pizza | 950            |
| The Soppressata Pizza     | 961            |
 

#### III. Total Orders


````sql
SELECT PIZZA_NAME,
	COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5
````

**Results:**

| pizza_name                | total_orders |
|---------------------------|--------------|
| The Brie Carre Pizza      | 480          |
| The Mediterranean Pizza   | 912          |
| The Calabrese Pizza       | 918          |
| The Spinach Supreme Pizza | 918          |
| The Chicken Pesto Pizza   | 938          |


