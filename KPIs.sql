-- Total Revenue

select sum(total_price) as total_revenue from pizza_sales

-- Average Order Value

select sum(total_price)/count(distinct order_id) as average_order_value from pizza_sales

-- Total Pizzas Sold

select sum(quantity) as total_pizzas_sold from pizza_sales
	
-- Total Orders

select count(distinct order_id) as total_orders from pizza_sales

-- Average Pizzas per order

select round((sum(quantity)*1.0) /(count(distinct order_id)*1.0),2) as average_pizzas_per_order from pizza_sales