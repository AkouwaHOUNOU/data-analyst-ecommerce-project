-- E-COMMERCE DATA ANALYSIS - SQL

-- DATA CLEANING EXAMPLE
SELECT *
FROM sales
WHERE TRY_CAST(Quantity AS INT) IS NOT NULL;

-- REVENUE BY COUNTRY
SELECT 
    Country,
    SUM(TRY_CAST(Quantity AS INT) * TRY_CAST(UnitPrice AS FLOAT)) AS Revenue
FROM sales
WHERE TRY_CAST(Quantity AS INT) IS NOT NULL
GROUP BY Country
ORDER BY Revenue DESC;

-- TOP CUSTOMERS
SELECT 
    CustomerID,
    SUM(TRY_CAST(Quantity AS INT) * TRY_CAST(UnitPrice AS FLOAT)) AS TotalSpent
FROM sales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

-- TOTAL NUMBER OF SALES
SELECT COUNT(DISTINCT InvoiceNo) AS TotalSales
FROM sales;

-- AVERAGE REVENUE PER CUSTOMER
WITH revenue_per_client AS (
    SELECT 
        CustomerID,
        SUM(TRY_CAST(Quantity AS INT) * TRY_CAST(UnitPrice AS FLOAT)) AS Revenue
    FROM sales
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
)
SELECT AVG(Revenue) AS AvgRevenue
FROM revenue_per_client;

-- TOP PRODUCTS BY QUANTITY
SELECT TOP 5
    Description,
    SUM(TRY_CAST(Quantity AS INT)) AS TotalSold
FROM sales
WHERE TRY_CAST(Quantity AS INT) IS NOT NULL
GROUP BY Description
ORDER BY TotalSold DESC;
