USE RetailSalesAndCustomerAnalyticsDB;

-- Customers
INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber, RegistrationDate)
VALUES
('John', 'Smith', 'john.smith@email.com', '0712345678', '2024-01-10'),
('Sarah', 'Johnson', 'sarah.johnson@email.com', '0723456789', '2024-02-15'),
('Michael', 'Brown', 'michael.brown@email.com', '0734567890', '2024-03-01'),
('Emily', 'Davis', 'emily.davis@email.com', NULL, '2024-03-18'),
('Daniel', 'Wilson', 'daniel.wilson@email.com', '0745678901', '2024-04-05'),
('Thabo', 'Nkosi', 'thabo.nkosi@email.com', '0756789012', '2024-04-07'),
('Nomsa', 'Dlamini', 'nomsa.dlamini@email.com', '0767890123', '2024-04-09'),
('Peter', 'Williams', 'peter.williams@email.com', NULL, '2024-04-11'),
('Linda', 'Martins', 'linda.martins@email.com', '0778901234', '2024-04-13'),
('James', 'Anderson', 'james.anderson@email.com', '0789012345', '2024-04-15'),
('Zanele', 'Mthembu', 'zanele.mthembu@email.com', '0790123456', '2024-04-17'),
('Chris', 'Taylor', 'chris.taylor@email.com', NULL, '2024-04-19'),
('Fatima', 'Khan', 'fatima.khan@email.com', '0711122233', '2024-04-21'),
('Sipho', 'Mabaso', 'sipho.mabaso@email.com', '0722233344', '2024-04-23'),
('Ayesha', 'Patel', 'ayesha.patel@email.com', '0733344455', '2024-04-25');

-- Employees
INSERT INTO Employees (FirstName, LastName, JobTitle, HireDate)
VALUES
('Alice', 'Mokoena', 'Sales Consultant', '2022-06-01'),
('Brian', 'Naidoo', 'Sales Consultant', '2023-01-15'),
('Lerato', 'Khumalo', 'Store Manager', '2021-09-10'),
('Kabelo', 'Molefe', 'Sales Consultant', '2023-08-01'),
('Nadia', 'Hassan', 'Sales Consultant', '2024-01-20');

-- Products
INSERT INTO Products (ProductName, Category, UnitPrice, Quantity, Status)
VALUES
('Laptop', 'Electronics', 15000.00, 10, 'Active'),
('Smartphone', 'Electronics', 9000.00, 25, 'Active'),
('Office Chair', 'Furniture', 2500.00, 15, 'Active'),
('Desk Lamp', 'Furniture', 800.00, 30, 'Active'),
('Wireless Mouse', 'Accessories', 450.00, 50, 'Active'),
('Tablet', 'Electronics', 6500.00, 12, 'Active'),
('Monitor', 'Electronics', 4200.00, 8, 'Active'),
('Keyboard', 'Accessories', 350.00, 40, 'Active'),
('Headphones', 'Accessories', 1200.00, 20, 'Active'),
('USB Flash Drive', 'Accessories', 180.00, 60, 'Active'),
('Printer', 'Electronics', 5200.00, 6, 'Active'),
('Bookshelf', 'Furniture', 3200.00, 5, 'Active'),
('Coffee Table', 'Furniture', 2800.00, 4, 'Active'),
('Webcam', 'Accessories', 950.00, 18, 'Active'),
('Router', 'Electronics', 2100.00, 10, 'Active');

-- Orders
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, OrderStatus)
VALUES
(1, 1, '2024-04-10', 'Completed'),
(2, 2, '2024-04-12', 'Completed'),
(3, 1, '2024-04-15', 'Pending'),
(1, 3, '2024-04-18', 'Completed'),
(6, 2, '2024-04-20', 'Completed'),
(7, 4, '2024-04-21', 'Completed'),
(8, 5, '2024-04-22', 'Pending'),
(9, 1, '2024-04-23', 'Completed'),
(10, 2, '2024-04-24', 'Completed'),
(11, 3, '2024-04-25', 'Pending'),
(12, 4, '2024-04-26', 'Completed'),
(13, 5, '2024-04-27', 'Completed'),
(14, 1, '2024-04-28', 'Completed'),
(15, 2, '2024-04-29', 'Pending'),
(3, 3, '2024-04-30', 'Completed');

-- OrderItems
INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1, 1, 15000.00),
(1, 5, 2, 450.00),
(2, 2, 1, 9000.00),
(2, 5, 1, 450.00),
(3, 3, 1, 2500.00),
(4, 1, 1, 15000.00),
(4, 4, 2, 800.00),
(5, 6, 1, 6500.00),
(6, 7, 2, 4200.00),
(7, 8, 1, 350.00),
(8, 9, 1, 1200.00),
(9, 10, 3, 180.00),
(10, 11, 1, 5200.00),
(11, 12, 1, 3200.00),
(12, 13, 1, 2800.00),
(13, 14, 2, 950.00),
(14, 15, 1, 2100.00),
(15, 1, 1, 15000.00),
(15, 5, 2, 450.00);

-- Payments
INSERT INTO Payments (OrderID, PaymentDate, PaymentMethod, Amount, PaymentStatus)
VALUES
(1, '2024-04-10', 'Card', 15900.00, 'Pending'),
(2, '2024-04-12', 'EFT', 9450.00, 'Pending'),
(4, '2024-04-18', 'Cash', 10000.00, 'Pending'),
(4, '2024-04-19', 'Card', 6600.00, 'Pending'),
(5, '2024-04-20', 'Card', 6500.00, 'Pending'),
(6, '2024-04-21', 'EFT', 8400.00, 'Pending'),
(7, '2024-04-22', 'Cash', 350.00, 'Pending'),
(8, '2024-04-23', 'Card', 1200.00, 'Pending'),
(9, '2024-04-24', 'Card', 540.00, 'Pending'),
(10, '2024-04-25', 'EFT', 5200.00, 'Pending'),
(11, '2024-04-26', 'Card', 3200.00, 'Pending'),
(12, '2024-04-27', 'Cash', 2800.00, 'Pending'),
(13, '2024-04-28', 'Card', 1900.00, 'Pending'),
(14, '2024-04-29', 'EFT', 2100.00, 'Pending');
