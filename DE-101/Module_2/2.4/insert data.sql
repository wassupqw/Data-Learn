-- insert data into module_2.customer_dim
insert into module_2.customer_dim(customer_id, customer_name)
select 
		customer_id,
		customer_name 
from public.orders
group by customer_id, customer_name;

-- insert data into geography_dim
insert into module_2.geography_dim
select
		row_number() over() as geo_id,
		country,
		city,
		state,
		region,
		case
			when postal_code is null then '5408'
			else postal_code 
		end as postal_code,
		person
from
		(select 
				country, city, state, p.region, person, postal_code
		 from public.orders as o
		 	inner join public.people as p
		 	on o.region = p.region
		 group by country, city, state, p.region, person, postal_code) as tab1;
		
-- insert data into order_date_dim
insert into module_2.order_date_dim 
select 
		o.order_date as order_date,
		extract(year from o.order_date) as "year",
		extract(quarter from o.order_date) as "quarter",
		extract(month from o.order_date) as "month",
		extract(week from o.order_date) as "week",
		extract(day from o.order_date) as "day"
from public.orders as o
group by
		o.order_date,
		extract(year from o.order_date),
		extract(quarter from o.order_date),
		extract(month from o.order_date),
		extract(week from o.order_date),
		extract(day from o.order_date)
order by 
		o.order_date;

-- insert data into ship_date_dim
insert into module_2.ship_date_dim
select 
		o.ship_date as ship_date,
		extract(year from o.ship_date) as "year",
		extract(quarter from o.ship_date) as "quarter",
		extract(month from o.ship_date) as "month",
		extract(week from o.ship_date) as "week",
		extract(day from o.ship_date) as "day"
from public.orders as o
group by
		o.ship_date,
		extract(year from o.ship_date),
		extract(quarter from o.ship_date),
		extract(month from o.ship_date),
		extract(week from o.ship_date),
		extract(day from o.ship_date)
order by 
		o.ship_date;	
	
-- insert data into product_dim

ALTER TABLE module_2.product_dim --to fix error, segment later in sales_fact
DROP COLUMN segment;

ALTER TABLE module_2.product_dim --to fix error of duplicating key value product_id: for one product_id can be more than 1 product_name
DROP COLUMN product_name;	
	
insert into module_2.product_dim 
select 
		product_id,
		category,
		subcategory as sub_category 
from public.orders 
group by 
		product_id,category, subcategory;
	
-- insert data into shipping_dim
insert into module_2.shipping_dim 
select 
		row_number() over() as ship_id,
		ship_mode 
from public.orders 
group by ship_mode;

-- insert data into sales_fact

ALTER TABLE module_2.sales_fact 
ADD COLUMN segment VARCHAR(80);

ALTER TABLE module_2.sales_fact  
ADD COLUMN product_name VARCHAR(130);

insert into module_2.sales_fact
select
		row_id,
		quantity,
		sdd.ship_date,
		odd.order_date,
		cd.customer_id,
		pd.product_id,
		gd.geo_id,
		sd.ship_id,
		discount,
		sales,
		profit,
		o.order_id,
		case 
			when r.order_id is not null then 'YES'
			else 'NO' 
		end as returned,
		segment,
		product_name 
from public.orders o
inner join module_2.customer_dim cd 
		on o.customer_id = cd.customer_id
inner join module_2.geography_dim gd 
		on (o.city = gd.city and o.postal_code = gd.postal_code::numeric)
inner join module_2.order_date_dim odd 
		on o.order_date = odd.order_date
inner join module_2.product_dim pd 
		on o.product_id = pd.product_id 
inner join module_2.ship_date_dim sdd 
		on o.ship_date = sdd.ship_date
inner join module_2.shipping_dim sd 
		on o.ship_mode = sd.ship_mode
left join (select distinct order_id from public."returns") as r 
		on o.order_id = r.order_id
order by row_id;

