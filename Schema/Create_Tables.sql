USE RetailSalesAndCustomerAnalyticsDB;

CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    PhoneNumber VARCHAR(255) NULL,
    RegistrationDate DATE NOT NULL
);
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    JobTitle VARCHAR(255) NOT NULL,
    HireDate DATE NOT NULL
);
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    Category VARCHAR(255) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL CHECK (UnitPrice > 0),
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Active','Discontinued'))
);
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL,
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR(50) NOT NULL 
        CHECK (OrderStatus IN ('Pending','Completed','Cancelled')),

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),

    CONSTRAINT FK_Orders_Employees
        FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
CREATE TABLE OrderItems (
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2) NOT NULL CHECK (UnitPrice > 0),

    CONSTRAINT FK_OrderItems_Orders
        FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderItems_Products
        FOREIGN KEY (ProductID) REFERENCES Products(ProductID),

    CONSTRAINT UQ_Order_Product UNIQUE (OrderID, ProductID)
);
CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL 
        CHECK (PaymentMethod IN ('Card','Cash','EFT')),
    Amount DECIMAL(10,2) NOT NULL CHECK (Amount > 0),
    PaymentStatus VARCHAR(50) NOT NULL 
        CHECK (PaymentStatus IN ('Pending','Failed','Refunded')),

    CONSTRAINT FK_Payments_Orders
        FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);