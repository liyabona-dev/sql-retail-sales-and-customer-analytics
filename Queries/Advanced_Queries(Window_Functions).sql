-- ====================================================================================================================
-- ADVANCED QUERIES (WINDOW FUNCTIONS)
-- ====================================================================================================================
USE RetailSalesAndCustomerAnalyticsDB;

-- 1. Rank customers based on total spending.

SELECT c.CustomerID,
       c.FirstName + ' ' + c.LastName AS CustomerFullName,
       SUM(oi.Quantity * oi.UnitPrice) AS TotalSpending,
       DENSE_RANK() OVER(ORDER BY SUM(oi.Quantity * oi.UnitPrice) DESC) AS
customer_dense_rank
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY c.CustomerID,  c.FirstName, c.LastName;

-- 2. Top 3 best-selling products within each category.

SELECT *
 FROM (SELECT p.ProductID,
       p.ProductName,
       p.Category,
       SUM(oi.Quantity) AS QuantitySold,
       DENSE_RANK() OVER (PARTITION BY  p.Category
       ORDER BY SUM(oi.Quantity) DESC) AS
products_rank
FROM Products p
JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category ) AS pr
WHERE pr.products_rank <= 3;


-- 3. Running total of daily revenue.

SELECT OrderDate,
       SUM(DailyRevenue) OVER (ORDER BY OrderDate) AS RunningRevenue
FROM (
    SELECT CAST(o.OrderDate AS DATE) AS OrderDate,
           SUM(oi.Quantity * oi.UnitPrice) AS DailyRevenue
    FROM Orders o
    JOIN OrderItems oi ON o.OrderID = oi.OrderID
    GROUP BY CAST(o.OrderDate AS DATE)
) t;


-- 4. Identify the previous order date for each customer.

SELECT c.CustomerID,
       c.FirstName + ' ' + c.LastName AS CustomerFullName,
       o.OrderDate,
       LAG(o.OrderDate) OVER (PARTITION BY c.CustomerID
        ORDER BY o.OrderDate ASC)  AS
previous_order_date
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 5. Calculate the difference in days between consecutive customer orders.

SELECT CustomerID,
       OrderDate,
       DATEDIFF(day,
       LAG(OrderDate) OVER (PARTITION BY CustomerID
       ORDER BY OrderDate),
       OrderDate)  AS
days_since_last_order
FROM Orders;