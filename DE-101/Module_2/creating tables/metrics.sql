--overview
select
		sum(sales) as total_sales,
		sum(profit) as total_profit,
		sum(profit) / sum(sales) as Profit_ratio,
		sum(profit) / count(distinct order_id) as Profit_per_Order,
		sum(sales) / count(distinct customer_id) as Sales_per_Customer,
		avg(discount) as Avg_Discount
from orders;

--Monthly Sales by segment dynamic
select 
		date_part('year', order_date) as year,
		date_part('month', order_date) as month,
		segment,
		sum(sales) as Mounthly_sales_by_segment
from orders 
group by segment, date_part('year', order_date), date_part('month', order_date) 
order by 1,2;

--Monthly Sales by Product Category dynamic
select 
		date_part('year', order_date) as year,
		date_part('month', order_date) as month,
		category ,
		sum(sales) as Mounthly_sales_by_product_category
from orders 
group by category , date_part('year', order_date), date_part('month', order_date) 
order by 1,2;

--Sales and Profit by Customer
select 
		customer_id,
		sum(sales) as Sales_by_customer,
		sum(profit) as Profit_by_customer
from orders
group by customer_id
order by 2 desc,1;

--Sales per region dynamic
select 
		region,
		date_part('year', order_date) as year,
		date_part('month', order_date) as month,
		sum(sales) as Sales_per_region
from orders
group by region, date_part('year', order_date), date_part('month', order_date)
order by 
		year, month,
		Sales_per_region desc;