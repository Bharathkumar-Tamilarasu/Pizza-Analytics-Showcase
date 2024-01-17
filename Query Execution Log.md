# Pizza Analytics Showcase

## Query Execution Log

**Author**: Bharathkumar Tamilarasu <br />
**Email**: bharathkumar.t.17@gmail.com <br />
**Website**: https://bharathkumart17.wixsite.com/portfolio <br />
**LinkedIn**: https://www.linkedin.com/in/bharathkumar-tamilarasu-218429222/  <br />
##
	
### A.	KPI’s

#### I.	Total Revenue

````sql
SELECT SUM(TOTAL_PRICE) AS TOTAL_REVENUE
FROM PIZZA_SALES
````

**Results:**

| total_revenue |
|---------------|
| 817860.0508   |

#### II. Average Order Value

````sql
SELECT SUM(TOTAL_PRICE) / COUNT(DISTINCT ORDER_ID) AS AVERAGE_ORDER_VALUE
FROM PIZZA_SALES
````

**Results:**

| average_order_value |
|---------------------|
| 38.30726233         |

#### III. Total Pizzas Sold

````sql
SELECT SUM(QUANTITY) AS TOTAL_PIZZAS_SOLD
FROM PIZZA_SALES
````

**Results:**

| total_pizzas_sold |
|-------------------|
| 49574             |

#### IV. Total Orders

````sql
SELECT COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS
FROM PIZZA_SALES
````

**Results:**

| total_orders |
|--------------|
| 21350        |

#### V.	Average Pizzas Per Order

````sql
SELECT ROUND((SUM(QUANTITY) * 1.0) / (COUNT(DISTINCT ORDER_ID) * 1.0),2) AS AVERAGE_PIZZAS_PER_ORDER
FROM PIZZA_SALES
````

**Results:**

| average_pizzas_per_order |
|--------------------------|
| 2.32                     |

### B.	Hourly Trend for Total Pizzas Sold

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



### E.	Percentage of Sales by Pizza Size

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



### F.	Total Pizzas Sold by Pizza Category

````sql
SELECT PIZZA_CATEGORY,
	SUM(QUANTITY) AS TOTAL_SALES
FROM PIZZA_SALES
GROUP BY 1
ORDER BY 2 DESC
````

 
**Results:**



### G.	Top 5 Best Sellers by Revenue, Total Quantity and Total Orders

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



### H.	Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders

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



