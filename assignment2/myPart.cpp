//Complete this function
void cancelOrder(Connection* conn, int orderId, int customerId) {
 try {
// call cancel order procedure
 Statement* stmt = conn->createStatement();
 // calling stored procedure with 2 paramters 
 stmt->setSQL("BEGIN cancel_order(:1, :2); END;");
 stmt->setInt(1, orderId); // Set the order ID
 // register output paramater
 // define datatype of output (PREPERATION)
 stmt->registerOutParam(2, Type::OCCIINT, sizeof(int)); // Register the output parameter for cancel status
 stmt->executeUpdate(); // Execute the procedure
 // catching the output
 int cancelStatus = stmt->getInt(2); // Retrieve the cancel status
 conn->terminateStatement(stmt); // Terminate the statement
 // Handle the cancel status by switch
 switch (cancelStatus) {
  // no data found
 case 0:
 cout << "The order does not exist or does not belong to the customer." << endl;
 break;
 case 1:
 cout << "The order has been already canceled." << endl;
 break;
 case 2:
 cout << "The order is shipped and cannot be canceled." << endl;
 break;
 // was not cancelled or shipped 
 case 3:
 cout << "The order is canceled successfully." << endl;
 break;
 // -1 
 default:
 cout << "Unexpected cancel status: " << cancelStatus << endl;
 break;
 }
 }
 catch (SQLException& sqlExcp) {
 cout << "Error: " << sqlExcp.getErrorCode() << " - " << sqlExcp.getMessage() << endl;
 }
}

// // FIND PRODUCT
CREATE OR REPLACE PROCEDURE find_product (
 productId IN NUMBER,
 price OUT products.list_price%TYPE,
 productName OUT products.product_name%TYPE
) AS
 v_discount_factor NUMBER := 1; // Initialize discount factor to 1 (no discount)
 v_month VARCHAR2(20);
BEGIN
 // Check if the current month is November or December
 SELECT TO_CHAR(SYSDATE, 'Month') INTO v_month FROM DUAL;

 IF v_month IN ('November', 'December') THEN
 // Apply discount for products in categories 2 and 5
 SELECT list_price * 0.9 INTO price
 FROM products
 WHERE product_id = productId
 AND category_id IN (2, 5);

 // If the product exists, store its name
 SELECT product_name INTO productName
 FROM products
 WHERE product_id = productId;

 ELSE
 // No discount for other months 
 SELECT list_price INTO price
 FROM products
 WHERE product_id = productId;

 // If the product exists, store its name
 SELECT product_name INTO productName
 FROM products
 WHERE product_id = productId;
 END IF;

EXCEPTION
 WHEN NO_DATA_FOUND THEN
 // Set price to 0 and productName to null if product not found
 price := 0;
 productName := NULL;
 WHEN TOO_MANY_ROWS THEN
 // Display error message for multiple rows found
 DBMS_OUTPUT.PUT_LINE('Error: Multiple rows found for the product ID.');
 WHEN OTHERS THEN
 // Display error message for any other exceptions
 DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

 // NEXT ONE // 

 // CANCEL_ORDER PROCEDURE
CREATE OR REPLACE PROCEDURE cancel_order (
 orderId IN NUMBER,
 cancelStatus OUT NUMBER
) AS
 v_orderStatus orders.status%TYPE;
BEGIN
 // cancel status set to 0 so it doesnt exist
 cancelStatus := 0;

 // check order if it exists
 SELECT status INTO v_orderStatus
 FROM orders
 WHERE order_id = orderId;

 // if statement to check status is not null
 IF v_orderStatus IS NOT NULL THEN
 // if statement to check if order is cancelled
 IF v_orderStatus = 'Canceled' THEN
 // set status to 1
 cancelStatus := 1;
 // check if order is shipped
 ELSIF v_orderStatus = 'Shipped' THEN
 // if order is shipped set status to 2
 cancelStatus := 2;
 // else statement to cancel status
 ELSE
 // Update order status to 'Canceled'
 UPDATE orders
 SET status = 'Canceled'
 WHERE order_id = orderId;
 // Set cancelStatus to 3 (order canceled successfully)
 cancelStatus := 3;
 END IF;
 END IF;

EXCEPTION
 WHEN NO_DATA_FOUND THEN
 // Order does not exist
 cancelStatus := 0;
 WHEN OTHERS THEN
 // Any other errors
 cancelStatus := -1;
END;

 



/// 
setSQL(const string& sql):

This method is used to set the SQL command that will be executed by a Statement object.
It takes a string parameter containing the SQL command to be executed.
For example, stmt->setSQL("SELECT * FROM my_table"); would set the SQL command to select all rows from the my_table table.
setInt(unsigned int paramIndex, int value):

This method is used to set the value of an integer parameter in a SQL command.
It takes two parameters: paramIndex, which specifies the position of the parameter in the SQL command (starting from 1), and value, which is the integer value to be set.
For example, stmt->setInt(1, orderId); would set the first parameter in the SQL command to the value of the orderId variable.
registerOutParam(unsigned int paramIndex, Type type, int maxSize):

This method is used to register an output parameter in a SQL command.
It takes three parameters: paramIndex, which specifies the position of the parameter in the SQL command (starting from 1), type, which specifies the data type of the parameter, and maxSize, which specifies the maximum size of the parameter (for character data types).
Output parameters are used to retrieve values returned by stored procedures or functions.
For example, stmt->registerOutParam(2, Type::OCCIINT, sizeof(int)); would register the second parameter in the SQL command as an output parameter of type integer.
executeUpdate():

This method is used to execute an SQL command that performs an update operation (e.g., INSERT, UPDATE, DELETE).
It returns the number of rows affected by the update operation.
For example, stmt->executeUpdate(); would execute the SQL command set using setSQL() and perform the update operation specified by the command.
terminateStatement(Statement* stmt):

This method is used to terminate (close) a Statement object and release any associated resources.
It takes a pointer to the Statement object that needs to be terminated.
Once a Statement object is terminated, it cannot be used to execute further SQL commands.
For example, conn->terminateStatement(stmt); would terminate the Statement object referenced by the stmt pointer.