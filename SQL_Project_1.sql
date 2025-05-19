--Create Table--
create table  retail_sales
       (
           transactions_id INT PRIMARY KEY,	
           sale_date DATE,	
           sale_time TIME,
           customer_id	INT,
           gender	VARCHAR(15),
           age	INT,
           category	VARCHAR(15),
           quantiy	INT,
           price_per_unit FLOAT,	
           cogs	FLOAT,
           total_sale FLOAT
       )
select*from retail_sales
limit 10;	   

select count(*)
from retail_sales

--Datea cleaning--
select*from retail_sales
where transactions_id is null;

select*from retail_sales
where sale_date is null;

select*from retail_sales
where sale_time is null;

select*from retail_sales
where 
    transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
    or
	price_per_unit is null
	or
	cogs is null
	or 
	total_sale is null

delete from retail_sales
where 
    transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
    or
	price_per_unit is null
	or
	cogs is null
	or 
	total_sale is null

--Data Exploration--

-- How many sales we have?
select count(*) as total_sale from  retail_sales

--How many customers we have ?
select count(distinct customer_id) as total_sale from  retail_sales

--How many unique categories we have ?
select distinct category from retail_sales

--Data Analysis & Business Key Problems & Answers


--Write a SQL query to calculate the total sales made on '2022-11-05'
select*from retail_sales

select * 
from retail_sales
where sale_date ='2022-11-05'

--Write a SQL query to calculate all transaction where the category is 'clothing and quantity sold is more than 4 in the month of Nov 2022
select *
from retail_sales
where category = 'Clothing' 
   And  
   TO_CHAR(sale_date,'YYYY-MM')='2022-11'
   And quantiy >=4 

_
--Write a SQL query to calculate the total sales(total_sale) for each category.
select
category,
sum(total_sale) as Total_Sale

from retail_sales
group by category

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category. 

select
   avg(age)
from retail_sales
where category = 'Beauty'

--Write SQL query to find all transaction where the total_sale is greater than 1000.
select
*
from retail_sales
where total_sale > 1000

--Write SQL query to find the total number of transaction(transaction_id) made by each gender by each category
select 
category,
gender,
COUNT(*) as total_trans
from retail_sales
group by gender , category
order by 1

--Write SQL query to calculate the average sales for each month,find out best selling month in each year
select
year,
month,
avg_sale
from
(
select
     EXTRACT(YEAR from sale_date) as year,
	 EXTRACT(MONTH from sale_date) as MONTH,
avg(total_sale) as avg_sale,
rank () over(partition by EXTRACT(YEAR from sale_date) ORDER BY  avg(total_sale)DESC )
from retail_sales
group by 1,2
) as t1
where rank=1

--Write the SQL query to find the top 5 customers based on the highest total sale
select
  customer_id,
  sum (total_sale) as total_sales
from retail_sales
group by 
  customer_id
order by
  2 desc
limit 5


--Write SQL query to find the number of unique customers who purchased items from each category.
select
count(distinct(customer_id))as unique_customer,
category
from retail_sales
group by category

--Write SQL query to create each shift and number of ordes (ex. Morning <= 12,Afternoon Between 12 & 17, evening >17)
with hurly_sale 
as
(
select*,
    case 
	   when EXTRACT (HOUR FROM sale_time) < 12 then 'Morning'
	   when EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 then 'Afternoon'
       else 'Evening'
  	end as shift
from retail_sales
)
select
   shift,
   COUNT(*) as total_orders
from hurly_sale
group by shift

--End of Project1--