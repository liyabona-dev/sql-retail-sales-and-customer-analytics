-- ===========================================================================================
-- DATA QUALITY AND BUSINESS CHECKS
-- ===========================================================================================


-- 1. Find orders that do not have any associated payments.

SELECT o.OrderID
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;

-- 2. Detect payments where the payment amount does not match the order total.

SELECT o.OrderID,
       SUM(oi.Quantity * oi.UnitPrice) AS OrderTotal,
       SUM(p.Amount) AS TotalPaid
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Payments p ON o.OrderID = p.OrderID
GROUP BY o.OrderID
HAVING SUM(oi.Quantity * oi.UnitPrice) <> SUM(p.Amount);

-- 3. Find products with low inventory with less than 10 units.

SELECT ProductID,
       ProductName,
       Quantity
FROM Products 
WHERE Quantity < 10
ORDER BY Quantity ASC;

-- 4. Identify cancelled orders that still have payments recorded.

SELECT o.OrderID,
       SUM(p.Amount) AS TotalPaid
FROM Orders o
JOIN Payments p ON o.OrderID = p.OrderID
WHERE o.OrderStatus = 'Cancelled'
GROUP BY o.OrderID;

-- 5. Find duplicate customer emails (data integrity check).

SELECT Email, COUNT(*) AS EmailOccurrence
FROM Customers
GROUP BY Email
HAVING COUNT(*) > 1
ORDER BY EmailOccurrence DESC;


