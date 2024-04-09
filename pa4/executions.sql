-- calling the procedure to get details of a product by its name
CALL product_details_by_name_sproc('Botox');
CALL product_details_by_name_sproc('Shampoo');

-- calling the procedure to calculate the total income from all payments
CALL total_income_from_payments_sproc(@total);
SELECT @total;

-- calling the procedure to update the total income by adding income from the sales between two dates
SET @total_income = 10000;
CALL update_total_income_by_dates_sproc(@total_income, '2024-02-11', '2024-02-16');
SELECT @total_income;

-- calling the procedure to update the quantity of a product (current quantity - provided quantity)
CALL update_product_quantity_sproc(1, 5); -- in that case the quantity for Shampoo will be 15, so transaction will be commit

CALL update_product_quantity_sproc(7, 10); -- in that case we will have quantity for Botox -5. so transaction will be rollback
