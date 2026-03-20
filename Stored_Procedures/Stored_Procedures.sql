-- ==============================================================================================================
-- STORED PROCEDURES
-- ==============================================================================================================

-- 1. Procedure to Add Customers

CREATE PROCEDURE AddCustomer
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(50),
    @PhoneNumber VARCHAR(50),
    @RegistrationDate DATE
AS
BEGIN 

INSERT INTO Customers(FirstName, LastName, Email, PhoneNumber,RegistrationDate)
VALUES(@FirstName, @LastName, @Email, @PhoneNumber, @RegistrationDate)

END;

-- Addig Customers
EXEC AddCustomer 'Shirley', 'Johnson', 'shirleyjohson@gmail.com','0789008978','2024-05-06';
EXEC AddCustomer  'Camilla', 'Claire', 'camillaclaire@gmail.com', '0897658900', '2024-05-07';
EXEC AddCustomer 'Davina', 'Davidson', 'davina.davidson@example.com', '0769805656', '2024-05-13';
EXEC AddCustomer  'Elijah', 'Mikaelson', 'elijah.mikaelson@example.com', '0658902314', '2024-05-22';
EXEC AddCustomer 'Olivia', 'Medupe', 'oliviamedupe@gmail.com', '0827892356', '2024-06-02';
EXEC AddCustomer 'Grace', 'Mackenzie', 'gracemackenzie@gmail.com', '0715674567', '2024-06-09';
EXEC AddCustomer 'Niklaus', 'Nyathi', 'niklausnyathi@gmail.com', '0731256891', '2024-06-17';
EXEC AddCustomer  'Hayley', 'Cambell', 'hayle.cambell@example.com', '0817890867', '2024-07-10';
EXEC AddCustomer  'Alison', 'Buyers', 'alison.buyers@example.com', '0727123679', '2024-07-18';
EXEC AddCustomer  'Emily', 'Smith', 'emily.smith@example.com', '0812345678', '2024-07-24';
EXEC AddCustomer  'Lucas', 'Tyler', 'lucastyler@gmail.com', '0823456789', '2024-08-05';
EXEC AddCustomer  'Mason', 'Anderson', 'masonanderson@gmail.com', '0875677890', '2024-08-18';
EXEC AddCustomer  'Logan', 'White', 'loganwhite@gmail.com', '0667890123', '2024-09-03';
EXEC AddCustomer  'Harper', 'Harris', 'harperharris@gmail.com', '0701234567', '2024-09-19';
EXEC AddCustomer  'Mia', 'Culpa', 'miaculpa@gmail.com', '0856789012', '2024-10-15';
EXEC AddCustomer  'Camilla', 'Brown', 'camillabrown@gmail.com', '0818769087', '2024-10-28';
EXEC AddCustomer  'Ethan', 'Grey', 'ethangrey@gmail.com', '0677888790', '2024-11-07';
EXEC AddCustomer   'Aurora', 'Eastwood', 'auroraeastwood@gmail.com', '0731234567', '2024-11-29';
EXEC AddCustomer 'Sophia', 'Wilson', 'sophiawilson@gmail.com', '0726787899', '2024-12-04';
EXEC AddCustomer   'Rebekka', 'Mickealson', 'rebekkamickealson@gmail', '0887643434', '2024-12-11';
EXEC AddCustomer 'Christen', 'Steward', 'christensteward@gmail.com', '0735678902', '2024-12-16';
EXEC AddCustomer  'Robert', 'Thompson', 'robertthompson@gmail.com','0876542314', '2024-12-26';
EXEC AddCustomer  'Amelia','Jackson', 'ameliajackson@gmail.com', '0690123456', '2025-01-03';
EXEC AddCustomer 'Charlotte', 'Thomas', 'charlottethomas@gmail.com', '0769899766', '2025-01-12';
EXEC AddCustomer  'Maria', 'Wayners','mariawayners@gmail.com', '0826782341', '2025-01-20';

-- =============================================================================================================

-- 2. Procedure to Add Employees

CREATE PROCEDURE AddEmployees
   @FirstName VARCHAR(50),
   @LastName VARCHAR(50),
   @JobTitle VARCHAR(50),
   @HireDate DATE
AS
BEGIN 

INSERT INTO Employees(FirstName,LastName, JobTitle, HireDate)
VALUES(@FirstName, @LastName, @JobTitle, @HireDate);

END;

-- Adding Employees
EXEC AddEmployees 'Alicia', 'Dupreez', 'Sales Consultant', '2024-01-17';
EXEC AddEmployees 'Justin', 'Edwards', 'Sales Consultant', '2024-03-01';
EXEC AddEmployees 'Keisha', 'Clark', 'Sales Consultant', '2024-06-18';
EXEC AddEmployees 'Hendry', 'Wonders', 'Sales Consultant', '2024-06-25';
EXEC AddEmployees 'Kasandra', 'Mandriakan', 'Sales Consultant', '2024-09-03';

-- =============================================================================================================

-- 3. Procedure to Add Products

CREATE PROCEDURE AddProducts
  @ProductName VARCHAR(50),
  @Category VARCHAR(50),
  @UnitPrice DECIMAL(10, 2),
  @Quantity INT,
  @Status VARCHAR(50)
AS
BEGIN

INSERT INTO Products(ProductName, Category, UnitPrice, Quantity, Status)
VALUES(@ProductName, @Category, @UnitPrice, @Quantity, @Status)

END;
    
-- Adding Products
EXEC AddProducts 'Wireless Charger', 'Accessories', 109, 20, 'Active';
EXEC AddProducts 'Gaming Console', 'Electronics', 11800.00, 25, 'Active';
EXEC AddProducts 'Smart TV', 'Electronics', 5400.00, 15, 'Active';
EXEC AddProducts 'Desk', 'Furniture', 16700.00, 10, 'Active';
EXEC AddProducts 'Sofa', 'Furniture', 6800.00, 20, 'Active';

-- =============================================================================================================  

-- 4. Procedure to add Orders with Orderitems

CREATE PROCEDURE CreateOrdersWithItems
  @CustomerID INT,
  @EmployeeID INT,
  @OrderDate DATE,
  @ProductID INT,
  @Quantity INT,
  @UnitPrice DECIMAL(10, 2)
AS
BEGIN

SET NOCOUNT ON;
DECLARE @OrderID INT;

-- Creating Order
INSERT INTO Orders(CustomerID, EmployeeID,OrderDate, OrderStatus)
VALUES(@CustomerID, @EmployeeID, @OrderDate, 'Pending')

-- Get the new OrderID
SET @OrderID = SCOPE_IDENTITY();

-- Insert order item
INSERT INTO OrderItems(OrderID, ProductID, Quantity, UnitPrice)
VALUES(@OrderID, @ProductID, @Quantity, @UnitPrice)

END;

-- Creating orders with order items
EXEC CreateOrdersWithItems 20, 6, '2024-03-15', 18, 1, 5400.00;
EXEC CreateOrdersWithItems 18, 3, '2024-05-12', 16, 2, 109.00;
EXEC CreateOrdersWithItems 16, 8, '2024-06-20', 20, 1, 6800.00;
EXEC CreateOrdersWithItems 11, 8, '2024-06-26', 3, 1, 5400.00;
EXEC CreateOrdersWithItems 18, 6, '2024-07-15', 17, 2, 11800.00;
EXEC CreateOrdersWithItems 22, 5, '2024-07-21', 14, 3, 950.00;
EXEC CreateOrdersWithItems 15, 4, '2024-08-02', 19, 1, 16700.00;
EXEC CreateOrdersWithItems 17, 9, '2024-08-11', 13, 1, 2800.00;
EXEC CreateOrdersWithItems 11, 8, '2024-08-17', 10, 20, 180.00;
EXEC CreateOrdersWithItems 16, 7, '2024-09-10', 15, 15, 2100.00;
EXEC CreateOrdersWithItems 19, 10, '2024-09-15', 13, 3, 2800.00;
EXEC CreateOrdersWithItems 27, 9, '2024-10-04', 12, 10, 3200.00;
EXEC CreateOrdersWithItems 24, 6, '2024-10-30', 16, 1, 109.00;
EXEC CreateOrdersWithItems 29, 7, '2024-11-04', 11, 1, 5200.00;
EXEC CreateOrdersWithItems 30, 8, '2024-11-16', 10, 1, 180.00;

-- =============================================================================================================

-- 5. Procedure to record payments

CREATE PROCEDURE RecordPayments
   @OrderID INT,
   @PaymentDate DATE,
   @PaymentMethod VARCHAR(50)
AS
BEGIN

SET NOCOUNT ON;

DECLARE @Amount DECIMAL(10,2);

SELECT @Amount = SUM(UnitPrice * Quantity)
FROM OrderItems
WHERE OrderID = @OrderID;

INSERT INTO Payments (OrderID, PaymentDate, PaymentMethod, Amount, PaymentStatus)
VALUES (@OrderID, @PaymentDate, @PaymentMethod, @Amount, 'Pending');

UPDATE Orders
SET OrderStatus = 'Completed'
WHERE OrderID = @OrderID;

END;

-- Recording Payments
EXEC RecordPayments 16, '2024-03-18', 'Card';
EXEC RecordPayments 17, '2024-05-12', 'Cash';
EXEC RecordPayments 19, '2024-06-26', 'Card';
EXEC RecordPayments 20, '2024-07-15', 'EFT';
EXEC RecordPayments 22, '2024-08-02', 'Card';
EXEC RecordPayments 24, '2024-08-17', 'Card';
EXEC RecordPayments 26, '2024-09-15', 'EFT';
EXEC RecordPayments 29, '2024-11-04', 'Card';
EXEC RecordPayments 30, '2024-11-16', 'EFT';