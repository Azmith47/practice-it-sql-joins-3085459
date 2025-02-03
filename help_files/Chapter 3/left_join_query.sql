-- SQLite
-- ONE to MANY AND ONE to MANY LEFT JOIN
SELECT 
  c.CustomerKey,
  c.FirstName,
  c.LastName,
  e.EmailAddress,
  g.GeographyKey
FROM
  DimCustomer c
LEFT JOIN customer_email_a e
ON c.CustomerKey = e.CustomerKey
LEFT JOIN customer_address_us g
ON c.CustomerKey = g.CustomerKey;

-- Total sales for each product
SELECT 
  p.ProductKey,
  p.EnglishProductName,
  SUM(s.OrderQuantity) Units_Sold,
  SUM(s.SalesAmount) Total_Sales
FROM
  DimProduct p
LEFT JOIN FactInternetSales s
ON p.ProductKey = s.ProductKey
GROUP BY 
  p.ProductKey,
  p.EnglishProductName;

-- ONE to MANY LEFT JOIN 
-- Using CTE to get Total Sales of Products
-- And using windowing technique
WITH Sales_Table AS
  (SELECT 
    p.ProductKey,
    p.EnglishProductName ProductName,
    s.OrderDate,
    s.OrderQuantity,
    COALESCE(s.SalesAmount, 0) AS SalesAmount
  FROM
    DimProduct p
  LEFT JOIN FactInternetSales s
  ON p.ProductKey = s.ProductKey)
SELECT 
  ProductKey,
  ProductName,
  SUBSTRING(OrderDate, 0,11) AS OrderDate,
  SalesAmount,
  SUM(SalesAmount) over (partition by ProductKey) Total_Product_Sales
FROM Sales_Table
WHERE SalesAmount > 0
ORDER BY OrderDate;

-- Complex Query Joins
SELECT 
  r.ResellerName,
  r.AddressLine1,
  r.AddressLine2,
  g.City,
  g.StateProvinceCode,
  g.PostalCode,
  g.CountryRegionCode,
  s.ProductKey,
  p.ProductSubcategoryKey,
  s.SalesAmount
FROM
  DimReseller r
JOIN DimGeography g
ON r.GeographyKey = r.GeographyKey
LEFT JOIN FactResellerSales s
ON r.ResellerKey = s.ResellerKey 
LEFT JOIN DimProduct p
ON s.ProductKey = p.ProductKey
WHERE g.CountryRegionCode = 'AU'
ORDER BY s.SalesAmount;