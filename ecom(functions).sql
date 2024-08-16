select * from sales

select product_id, sum(sales) from sales group by product_id

select product_id, sales,
    case
       When sales < 100 Then 'Normal Selling'
       When sales between 100 and 1000 Then  'Good Selling'
       When sales between 1000 and 1200 Then 'Best selling'
     Else  'Not good selling'
    End 
from sales

--1 : get sales of the products	
Create or Replace Function get_total_sales(sale int)
Returns varchar as $$
Declare 
	product_sales varchar;
begin
    case
       When sale < 100 Then product_sales := 'Normal Selling';
       When sale between 100 and 1000  Then product_sales :=  'Good Selling';
       When sale between 1000 and 1200 Then product_sales :=  'Best selling';
     Else product_sales := 'Not good selling';
    End case;
   Return product_sales;
end
$$ language plpgsql
 
select product_id, sales, get_total_sales(sales::int) from sales 
where get_total_sales(sales::int) = 'Best selling' 

select *, get_total_sales(sales::int) from sales

select * from sales

select order_date, sum(sales) from sales group by order_date

--2 : check sales per order date 
Create or Replace Function get_sales_date(total_sale int)
Returns varchar as $$
Declare 
     total varchar;
BEGIN
   Case
   When total_sale < 1000 Then total := 'Normal Sales on this dates';
   When total_sale between 1000 and 5000 Then total := 'Good sales on this date';
   When total_sale between 5000 and 10000 Then total := 'Best sales on this date';
   Else  total := 'this is best sales of the month';
  End Case;
  Return total;
END
$$ Language plpgsql;

select order_date, sales, get_sales_date(sales::int) from sales 
where get_sales_date(sales::int)= 'Best sales on this date'


select customer_name, age from customer order by age Desc 

--3 : check category of age 
Create or Replace Function category_customer(cust_age int)
Returns varchar as $$
Declare 
      customer_age varchar;
BEGIN
    Case 
	 When cust_age < 25 Then customer_age := 'Young customer';
     When cust_age between 25 And 40 Then customer_age := 'Middle age customer';
     When cust_age between 40 and 55 Then customer_age := 'Senior age customer';
     Else customer_age := 'super senior customer';
    End Case;
     Return customer_age;
END
$$ Language plpgsql

select customer_name, age, category_customer(age) from customer 
where category_customer(age) = 'Senior age customer'

select distinct state from customer 

--4 : check customer states
Create or Replace Function customer_state(get_state varchar)
Returns Varchar as $$
Declare 
      getcustomerState varchar;
Begin
   select customer_name into getcustomerState from customer where  state = get_state;
   Case
	   when get_state in ('Florida', 'New York') Then getcustomerState := 'Customer lives in Florida or New York';
       When get_state in ('New Jersey', 'New Mexico') Then getcustomerState := 'Customer lives in New Jersey or New Mexico';
       Else getcustomerState := 'Any other state of US';
   End Case;
   Return getcustomerState; 
End 
$$ Language plpgsql;

select customer_name, customer_state(state) from customer

select sum(sales), sum(quantity), order_line from sales group by order_line

--5 : check total sales per product
Create or Replace Function get_total(productId varchar)
Returns varchar as $$
Declare 
     SumOfSales float;
     sumOfQuantity float ;
Begin 
  select sum(sales) as "sumofsales", sum(quantity) as "sumofquantity" into sumOfSales, sumOfQuantity from sales 
  where product_id = productId;
   
   Return SumOfSales;
End
$$ Language plpgsql

select product_id, sales, get_total(product_id) from sales

create index product_index on sales(product_id)








