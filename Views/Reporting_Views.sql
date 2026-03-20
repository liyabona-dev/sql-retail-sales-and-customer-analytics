-- ==========================================================================
-- REPORTING VIEWS
-- ==========================================================================


-- 1. vw_OrderSummary
-- Purpose: Provides a financial overview of each order.

CREATE VIEW vw_OrderSummary AS
WITH Tot_Order AS (
    SELECT OrderID, SUM(Quantity * UnitPrice) AS OrderTotal
    FROM OrderItems
    GROUP BY OrderID
),
Tot_Paid AS (
    SELECT OrderID, SUM(Amount) AS TotalPaid
    FROM Payments
    GROUP BY OrderID
)
SELECT
    o.OrderID,
    o.OrderDate,
    o.OrderStatus,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    tod.OrderTotal,
    COALESCE(tpd.TotalPaid, 0) AS TotalPaid,
    tod.OrderTotal - COALESCE(tpd.TotalPaid, 0) AS RemainingBalance
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Employees e ON o.EmployeeID = e.EmployeeID
JOIN Tot_Order tod ON o.OrderID = tod.OrderID
LEFT JOIN Tot_Paid tpd ON o.OrderID = tpd.OrderID;

-- 2. vw_CustomerLifetimeValue
-- Purpose: Shows customer value over time.

CREATE VIEW vw_CustomerLifetimeValue AS
SELECT
    c.CustomerID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    COUNT(DISTINCT o.OrderID) AS TotalOrders,
    COALESCE(SUM(oi.Quantity * oi.UnitPrice), 0) AS TotalSpending,
    CASE 
        WHEN COUNT(DISTINCT o.OrderID) = 0 THEN 0
        ELSE SUM(oi.Quantity * oi.UnitPrice) / COUNT(DISTINCT o.OrderID)
    END AS AverageOrderValue
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- 3. vw_ProductSalesPerformance
-- Purpose: Analyzes product sales performance.

CREATE VIEW vw_ProductSalesPerformance AS
SELECT  p.ProductID,
        p.ProductName,
        p.Category,
        SUM(oi.Quantity) AS TotalQuantitySold,
        SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
FROM Products p
LEFT JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID,p.ProductName,p.Category;

-- 4. vw_EmployeeSalesPerformance
-- Purpose: Measures employee contribution to sales.

CREATE VIEW vw_EmployeeSalesPerformance AS
SELECT
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    COUNT(DISTINCT o.OrderID) AS TotalOrdersHandled,
    COALESCE(SUM(oi.Quantity * oi.UnitPrice), 0) AS TotalRevenueGenerated
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
LEFT JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY e.EmployeeID, e.FirstName, e.LastName;


-- 5. vw_PendingAndProblemOrders
-- Purpose: Flags orders needing attention.

CREATE VIEW vw_PendingAndProblemOrders AS
WITH Tot_Order AS (
    SELECT OrderID, SUM(Quantity * UnitPrice) AS OrderTotal
    FROM OrderItems
    GROUP BY OrderID
),
Tot_Paid AS (
    SELECT OrderID, SUM(Amount) AS TotalPaid
    FROM Payments
    GROUP BY OrderID
)
SELECT
    o.OrderID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    o.OrderDate,
    o.OrderStatus,
    COALESCE(tpd.TotalPaid, 0) AS TotalPaid,
    tod.OrderTotal - COALESCE(tpd.TotalPaid, 0) AS RemainingBalance
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Tot_Order tod ON o.OrderID = tod.OrderID
LEFT JOIN Tot_Paid tpd ON o.OrderID = tpd.OrderID
WHERE o.OrderStatus = 'PENDING'
   OR tod.OrderTotal - COALESCE(tpd.TotalPaid, 0) > 0;

