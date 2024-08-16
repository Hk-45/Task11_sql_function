create or replace function get_Profit(productId varchar)
RETURNS varchar AS $$
DECLARE
	profit_status varchar;
    total_profit float;
BEGIN
	select sum(profit) as "sumOfProfit" into total_profit from sales 
	where product_id = productId;
	case 
			When total_profit between 0 And 50 THEN  profit_status := 'min profit' ;
			When total_profit between 50 And 100  THEN profit_status := 'good profit';
			When total_profit between 100 And 200  THEN profit_status := 'best profit';
			When total_profit > 200 THEN profit_status := 'great profit';
			Else profit_status := 'no  profit';
	END CASE;
	RETURN profit_status;
END
$$ LANGUAGE plpgsql;

select product_id, sum(profit), get_profit(product_id) from sales 
group by product_id, get_profit(product_id)