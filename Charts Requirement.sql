-- Hourly Trend for Total Pizzas sold

select extract(hour from order_time) as order_time ,sum(quantity) as total_orders
from pizza_sales
group by 1
order by 1

-- Weekend Trend for Total Orders

select extract(week from order_date) as week_number,extract(year from order_date) as order_year, count(distinct order_id) as total_orders
from pizza_sales
group by 1,2
order by 1

-- Percentage of Sales by Pizza Category

select pizza_category,cast(sum(total_price) as decimal(10,2)) as total_sales, cast((sum(total_price) * 100.0/ (select sum(total_price) from pizza_sales)) as decimal(10,2)) as percentage_of_total_sales from pizza_sales
group by 1
order by 1

-- Percentage of Sales by Pizza Size

select pizza_size,
	cast(sum(total_price) as decimal(10,2)) as total_sales,
		cast((sum(total_price) * 100 /(select sum(total_price) from pizza_sales)) as decimal(10,2)) as percentage_of_total_sales
from pizza_sales
group by 1
order by 3 desc

-- Total Pizzas Sold by Pizza Category

select pizza_category,sum(quantity) as total_sales
from pizza_sales
group by 1
order by 2 desc

-- Top 5 Best Sellers by Revenue

select pizza_name,sum(total_price) as total_revenue
from pizza_sales
group by 1
order by 2 desc
limit 5

-- Top 5 Best Sellers by Total Quantity

select pizza_name,sum(quantity) as total_quantity
from pizza_sales
group by 1
order by 2 desc
limit 5

-- Top 5 Best Sellers by Total Orders

select pizza_name,count(distinct order_id) as total_orders
from pizza_sales
group by 1
order by 2 desc
limit 5

-- Bottom 5 Best Sellers by Revenue

select pizza_name,sum(total_price) as total_revenue
from pizza_sales
group by 1
order by 2 asc
limit 5

-- Bottom 5 Best Sellers by Total Quantity

select pizza_name,sum(quantity) as total_quantity
from pizza_sales
group by 1
order by 2 asc
limit 5

-- Bottom 5 Best Sellers by Total Orders

select pizza_name,count(distinct order_id) as total_orders
from pizza_sales
group by 1
order by 2 asc
limit 5