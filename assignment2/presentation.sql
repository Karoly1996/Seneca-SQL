-- find customer
CREATE OR REPLACE PROCEDURE find_customer (
 customer_id IN NUMBER,
 found OUT NUMBER
)
IS
BEGIN
 SELECT 1 INTO found
 FROM customers
 WHERE customer_id = find_customer.customer_id;
EXCEPTION
 WHEN no_data_found THEN
 found := 0;
 WHEN too_many_rows THEN
 DBMS_OUTPUT.PUT_LINE('Error: Multiple customers found for the given ID.');
 WHEN OTHERS THEN
 DBMS_OUTPUT.PUT_LINE('Error: An unexpected error occurred.');
END;
/
DECLARE
 v_customer_id NUMBER := 183; -- Change this to the customer ID you want to test
 v_found NUMBER;
BEGIN
 find_customer(v_customer_id, v_found);

 IF v_found = 1 THEN
 DBMS_OUTPUT.PUT_LINE('Customer with ID ' || v_customer_id || ' exists.');
 ELSE
 DBMS_OUTPUT.PUT_LINE('Customer with ID ' || v_customer_id || ' does not exist.');
 END IF;
END;
/
-- FIND PRODUCT
CREATE OR REPLACE PROCEDURE find_product (
 productId IN NUMBER,
 price OUT products.list_price%TYPE,
 productName OUT products.product_name%TYPE
) AS
 v_discount_factor NUMBER := 1; -- Initialize discount factor to 1 (no discount)
 v_month VARCHAR2(20);
BEGIN
 -- Check if the current month is November or December
 SELECT TO_CHAR(SYSDATE, 'Month') INTO v_month FROM DUAL;

 IF v_month IN ('November', 'December') THEN
 -- Apply discount for products in categories 2 and 5
 SELECT list_price * 0.9 INTO price
 FROM products
 WHERE product_id = productId
 AND category_id IN (2, 5);

 -- If the product exists, store its name
 SELECT product_name INTO productName
 FROM products
 WHERE product_id = productId;

 ELSE
 -- No discount for other months 
 SELECT list_price INTO price
 FROM products
 WHERE product_id = productId;

 -- If the product exists, store its name
 SELECT product_name INTO productName
 FROM products
 WHERE product_id = productId;
 END IF;

EXCEPTION
 WHEN NO_DATA_FOUND THEN
 -- Set price to 0 and productName to null if product not found
 price := 0;
 productName := NULL;
 WHEN TOO_MANY_ROWS THEN
 -- Display error message for multiple rows found
 DBMS_OUTPUT.PUT_LINE('Error: Multiple rows found for the product ID.');
 WHEN OTHERS THEN
 -- Display error message for any other exceptions
 DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
--GENERATE ORDER ID
CREATE OR REPLACE FUNCTION generate_order_id RETURN NUMBER IS
 v_new_order_id NUMBER;
BEGIN
 SELECT NVL(MAX(order_id), 0) + 1
 INTO v_new_order_id
 FROM orders;
 RETURN v_new_order_id;
END;
/
CREATE OR REPLACE PROCEDURE add_order (
 customer_id IN NUMBER,
 new_order_id OUT NUMBER
) AS
BEGIN
 new_order_id := generate_order_id();
 INSERT INTO orders (order_id, customer_id, status, salesman_id, order_date)
 VALUES (new_order_id, customer_id, 'Shipped', 56, SYSDATE);
END;
/
--ADD ORDER ITEM
CREATE OR REPLACE PROCEDURE add_order_item (
 orderId IN order_items.order_id%TYPE,
 itemId IN order_items.item_id%TYPE,
 productId IN order_items.product_id%TYPE,
 quantity IN order_items.quantity%TYPE,
 price IN order_items.unit_price%TYPE
) AS
BEGIN
 INSERT INTO order_items (order_id, item_id, product_id, quantity, unit_price)
 VALUES (orderId, itemId, productId, quantity, price);
END;
/
CREATE OR REPLACE PROCEDURE customer_order (
 customerId IN NUMBER,
 orderId IN OUT NUMBER
)
IS
 v_count NUMBER;
BEGIN
 -- Step 2: Check if the order ID exists for the given customer ID
 SELECT COUNT(*) INTO v_count
 FROM orders
 WHERE order_id = orderId -- corrected from customer_order.orderId
 AND customer_id = customerId;
 -- Step 3: If order ID exists, pass it to the caller
 IF v_count = 1 THEN
 orderId := orderId; -- no change needed, orderId already contains the valid value
 ELSE
 -- Step 4: If order ID does not exist, pass 0 to the caller
 orderId := 0;
 END IF;
END;
/
DECLARE
 v_customer_id NUMBER := 44; -- Change this to the customer ID you want to test
 v_order_id NUMBER := 82; -- Change this to the order ID you want to test
BEGIN
 customer_order(v_customer_id, v_order_id);

 IF v_order_id = 0 THEN
 DBMS_OUTPUT.PUT_LINE('No order found for customer ID ' || v_customer_id);
 ELSE
 DBMS_OUTPUT.PUT_LINE('Order ID for customer ID ' || v_customer_id || ' is ' || v_order_id);
 END IF;
END;
/
CREATE OR REPLACE PROCEDURE display_order_status (
 orderId IN NUMBER,
 status OUT orders.status%TYPE
)
AS
BEGIN
 -- Attempt to retrieve the status of the order
 SELECT status
 INTO status
 FROM orders
 WHERE order_id = orderId;

EXCEPTION 
 WHEN NO_DATA_FOUND THEN
 status := NULL;
 WHEN OTHERS THEN
 DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END display_order_status;
/
-- CANCEL_ORDER PROCEDURE
CREATE OR REPLACE PROCEDURE cancel_order (
 orderId IN NUMBER,
 cancelStatus OUT NUMBER
) AS
 v_orderStatus orders.status%TYPE;
BEGIN
 -- cancel status set to 0 so it doesnt exist
 cancelStatus := 0;

 -- check order if it exists
 SELECT status INTO v_orderStatus
 FROM orders
 WHERE order_id = orderId;

 -- if statement to check status is not null
 IF v_orderStatus IS NOT NULL THEN
 -- if statement to check if order is cancelled
 IF v_orderStatus = 'Canceled' THEN
 -- set status to 1
 cancelStatus := 1;
 -- check if order is shipped
 ELSIF v_orderStatus = 'Shipped' THEN
 -- if order is shipped set status to 2
 cancelStatus := 2;
 -- else statement to cancel status
 ELSE
 -- Update order status to 'Canceled'
 UPDATE orders
 SET status = 'Canceled'
 WHERE order_id = orderId;
 -- Set cancelStatus to 3 (order canceled successfully)
 cancelStatus := 3;
 END IF;
 END IF;

EXCEPTION
 WHEN NO_DATA_FOUND THEN
 -- Order does not exist
 cancelStatus := 0;
 WHEN OTHERS THEN
 -- Any other errors
 cancelStatus := -1;
END;
/
--Test
DECLARE
 v_order_id NUMBER := 44; -- Sample order ID to be canceled
 v_cancel_status NUMBER; -- Variable to hold the cancel status

BEGIN
 cancel_order(v_order_id, v_cancel_status);

 -- Check the cancel status and display appropriate message
 CASE v_cancel_status
 WHEN 0 THEN
 DBMS_OUTPUT.PUT_LINE('The order does not exist.');
 WHEN 1 THEN
 DBMS_OUTPUT.PUT_LINE('The order has already been canceled.');
 WHEN 2 THEN
 DBMS_OUTPUT.PUT_LINE('The order is shipped and cannot be canceled.');
 WHEN 3 THEN
 DBMS_OUTPUT.PUT_LINE('The order has been canceled successfully.');
 WHEN -1 THEN
 DBMS_OUTPUT.PUT_LINE('An error occurred while canceling the order.');
 ELSE
 DBMS_OUTPUT.PUT_LINE('Unknown status.');
 END CASE;
END;
/
SET SERVEROUTPUT ON;
select * from orders;
DECLARE
 v_customerId NUMBER := 1; -- Test customer ID
 v_orderId NUMBER := 105; -- Test order ID
BEGIN
 -- Call the customer_order procedure
 customer_order(v_customerId, v_orderId);
 -- Check the value of orderId after calling the procedure
 IF v_orderId = 0 THEN
 DBMS_OUTPUT.PUT_LINE('No order found for customer ID ' || v_customerId);
 ELSE
 DBMS_OUTPUT.PUT_LINE('Order ID found for customer ID ' || v_customerId);
 DBMS_OUTPUT.PUT_LINE('Order ID: ' || v_orderId);
 END IF;
END;
/



----------------------------------------------------------------------------------------------------------------------

-- MY PART

-- FIND PRODUCT
CREATE OR REPLACE PROCEDURE find_product (
 productId IN NUMBER,
 price OUT products.list_price%TYPE,
 productName OUT products.product_name%TYPE
) AS
 v_discount_factor NUMBER := 1; -- Initialize discount factor to 1 (no discount)
 v_month VARCHAR2(20);
BEGIN
 -- Check if the current month is November or December
 SELECT TO_CHAR(SYSDATE, 'Month') INTO v_month FROM DUAL;

 IF v_month IN ('November', 'December') THEN
 -- Apply discount for products in categories 2 and 5
 SELECT list_price * 0.9 INTO price
 FROM products
 WHERE product_id = productId
 AND category_id IN (2, 5);

 -- If the product exists, store its name
 SELECT product_name INTO productName
 FROM products
 WHERE product_id = productId;

 ELSE
 -- No discount for other months 
 SELECT list_price INTO price
 FROM products
 WHERE product_id = productId;

 -- If the product exists, store its name
 SELECT product_name INTO productName
 FROM products
 WHERE product_id = productId;
 END IF;

EXCEPTION
 WHEN NO_DATA_FOUND THEN
 -- Set price to 0 and productName to null if product not found
 price := 0;
 productName := NULL;
 WHEN TOO_MANY_ROWS THEN
 -- Display error message for multiple rows found
 DBMS_OUTPUT.PUT_LINE('Error: Multiple rows found for the product ID.');
 WHEN OTHERS THEN
 -- Display error message for any other exceptions
 DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

 -- NEXT ONE -- 

 -- CANCEL_ORDER PROCEDURE
CREATE OR REPLACE PROCEDURE cancel_order (
 orderId IN NUMBER,
 cancelStatus OUT NUMBER
) AS
 v_orderStatus orders.status%TYPE;
BEGIN
 -- cancel status set to 0 so it doesnt exist
 cancelStatus := 0;

 -- check order if it exists
 SELECT status INTO v_orderStatus
 FROM orders
 WHERE order_id = orderId;

 -- if statement to check status is not null
 IF v_orderStatus IS NOT NULL THEN
 -- if statement to check if order is cancelled
 IF v_orderStatus = 'Canceled' THEN
 -- set status to 1
 cancelStatus := 1;
 -- check if order is shipped
 ELSIF v_orderStatus = 'Shipped' THEN
 -- if order is shipped set status to 2
 cancelStatus := 2;
 -- else statement to cancel status
 ELSE
 -- Update order status to 'Canceled'
 UPDATE orders
 SET status = 'Canceled'
 WHERE order_id = orderId;
 -- Set cancelStatus to 3 (order canceled successfully)
 cancelStatus := 3;
 END IF;
 END IF;

EXCEPTION
 WHEN NO_DATA_FOUND THEN
 -- Order does not exist
 cancelStatus := 0;
 WHEN OTHERS THEN
 -- Any other errors
 cancelStatus := -1;
END;

 
