create database
ecommerce_analytics;
use ecommerce_analytics;
CREATE TABLE ecommerce_sales (
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Customer_ID VARCHAR(20),
    Region VARCHAR(30),
    City VARCHAR(50),
    Category VARCHAR(50),
    Product VARCHAR(100),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Discount_Pct DECIMAL(5,2),
    Sales DECIMAL(12,2),
    Cost DECIMAL(12,2),
    Profit DECIMAL(12,2),
    Channel VARCHAR(30),
    Customer_Segment VARCHAR(30),
    Payment_Method VARCHAR(30),
    Order_Status VARCHAR(30)
);

use ecommerce_analytics;
alter table ecommerce_sales
modify order_date varchar(30);

select count(*) as total_rows
from ecommerce_sales;

use ecommerce_analytics;
select sum(sales) as total_sales
from ecommerce_sales;

select sum(profit) as total_profit
from ecommerce_sales;
select
   region,
   sum(sales) as total_sales
   from ecommerce_sales
   group by region
   order by total_sales desc;
   
select
   product,
   sum(sales) as total_sales
   from  ecommerce_sales
   group by product
   order by total_sales desc
   limit 10;

select
   category,
   sum(sales) as total_sales,
   sum(cost) as total_cost,
   sum(profit) as total_profit
   from ecommerce_sales
   group by category
   order by total_sales desc;
   
select
   year(order_date) as year,
   month(order_date) as month,
   sum(sales) as revenue
   from ecommerce_sales
   group by year(order_date),
   month(order_date)
   order by year,month;
   
select order_date, order_date_new
from ecommerce_sales
limit 10;

alter table ecommerce_sales
add column order_date_new date;

set sql_safe_updates = 0;

update ecommerce_sales
set order_date_new =
str_to_date(order_date,'%d-%b-%y');

select
   year(order_date_new) as year,
   month(order_date_new) as month,
   sum(sales) as revenue
   from ecommerce_sales
   group by year(order_date_new),
   month(order_date_new)
   order by year,month;
   
select
   customer_segment,
   count(distinct customer_id) as total_customers,
   sum(sales) as total_sales,
   sum(profit) as total_profit
   from ecommerce_sales
   group by customer_segment
   order by total_sales desc;
   
select
   order_status,
   count(*) as total_orders,
   sum(sales) as total_sales,
   sum(profit) as total_profit
   from ecommerce_sales
   group by order_status
   order by total_orders desc;
   
select
   customer_id,
   count(distinct order_id) as total_orders
   from ecommerce_sales
   group by customer_id
   having count(distinct order_id)>1
   order by total_orders desc;
   
select
   count(*) as repeat_customers from (
   select customer_id
   from ecommerce_sales
   group by customer_id
   having count(distinct order_id)>1
   ) as repeat_customer_list;
   
