-- --------------------------------------------------------------------------
--                      AMAZON SALES ANALYSIS PROJECT
-- ---------------------------------------------------------------------------
-- Tools      : MySQL 8.0
-- Database   : amazonsalesdb
-- Dataset    : Amazon Sales Dataset

-- Objectives:
-- 1. Analyze Sales Performance
-- 2. Analyze Customer Behaviour
-- 3. Analyze Product Performance
-- 4. Analyze Regional Performance
-- 5. Analyze Payment Trends
-- 6. Generate Business Insights
-- ---------------------------------------------------------------------------

-- DATABASE SELECTION
USE amazonsalesdb;
-----------------------------------------------------------------------------
--                            DATA UNDERSTANDING
-- --------------------------------------------------------------------------
-- TOTAL RECORDS
SELECT COUNT(*) AS Total_Records
FROM amazon_sales;

-- VIEW 1ST 10 RECORDS
SELECT * 
FROM amazon_sales
LIMIT 10;

-- TABLE STRTUCTURE
DESCRIBE amazon_sales;

-- NUMBER OF COLUMNS
SELECT COUNT(*)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA=`amazonsalesdb`
AND TABLE_NAME=`amazon_sales`;

-- DISTINCT CATEGORIES
SELECT DISTINCT Category
FROM amazon_sales;

-- DISTINCT BRANDS
SELECT DISTINCT Brand
FROM amazon_sales;

-- DISTINCT PAYMENT METHODS
SELECT DISTINCT PaymentMethod
FROM amazon_sales;

-- DISTINCT ORDER STATUS
SELECT DISTINCT OrderStatus
FROM amazon_sales;

-- DISTINCT STATES
SELECT DISTINCT State
FROM amazon_sales;

-- DISTINCT CITIES
SELECT DISTINCT City
FROM amazon_sales;

-- ----------------------------------------------------------------------
--                               DATA CLEANING
-- -----------------------------------------------------------------------
-- CHECK NULL VALUES IN IMPORTANT COLUMNS
SELECT 
SUM(CASE WHEN OrderID IS NULL THEN 1 ELSE 0 END) AS OrderID_Null,
SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS CustomerID_Null,
SUM(CASE WHEN ProductID IS NULL THEN 1 ELSE 0 END) AS ProductID_Null,
SUM(CASE WHEN ProductName IS NULL THEN 1 ELSE 0 END) AS ProductName_Null,
SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS Category_Null,
SUM(CASE WHEN Brand IS NULL THEN 1 ELSE 0 END) AS Brand_Null,
SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Quantity_Null,
SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) AS UnitPrice_Null,
SUM(CASE WHEN TotalAmount IS NULL THEN 1 ELSE 0 END) AS TotalAmount_Null,
SUM(CASE WHEN PaymentMethod IS NULL THEN 1 ELSE 0 END) AS PaymentMethod_Null,
SUM(CASE WHEN OrderStatus IS NULL THEN 1 ELSE 0 END) AS OrderStatus_Null,
SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Country_Null,
SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null,
SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS City_Null
FROM amazon_sales;

-- CHECK BLANK VALUES
SELECT *
FROM amazon_sales
WHERE OrderID = "" OR
CustomerID='' OR
ProductID='' OR
ProductName='' OR
Category='' OR
Brand='' OR
PaymentMethod='' OR
OrderStatus='' OR
Country='' OR
State='' OR
City='';

-- FINDING DUPLICATE ORDER ID'
SELECT OrderID,
Count(*)AS Duplicate_Count
FROM amazon_sales
GROUP BY OrderID
HAVING COUNT(*) > 1;

-- CHECK NEGATIVE QUANTITY
SELECT Quantity
FROM amazon_sales
WHERE Quantity < 0;

-- CHECK INVALID UNIT PRICE
SELECT UnitPrice
FROM amazon_sales
WHERE UnitPrice <= 0;

--  CHECK INVALID TOTAL AMOUNT
SELECT TotalAmount
FROM amazon_sales
WHERE TotalAmount <= 0;

-- CHECK INVALID DISCOUNT
SELECT Discount
FROM amazon_sales
WHERE Discount <= 0;

-- CHECK INVALID TAX
SELECT Tax
FROM amazon_sales
WHERE Tax <= 0;

-- -----------------------------------------------------------------------
--                         DATA CLEANING SUMMERY
-- -----------------------------------------------------------------------
-- Checked NULL Values
-- Checked Blank Values
-- Checked Duplicate Order IDs
-- Checked Duplicate Customer IDs
-- Checked Duplicate Product IDs
-- Checked Invalid Quantity
-- Checked Invalid Unit Price
-- Checked Invalid Total Amount
-- Checked Invalid Discount
-- Checked Invalid Tax

-- Dataset is ready for analysis.

-- ----------------------------------------------------------------------
--                              KPI ANALYSIS
-- ----------------------------------------------------------------------
-- TOTAL SALES
SELECT 
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales;

-- TOTAL ORDERS
SELECT 
COUNT(DISTINCT OrderID) AS Total_Orders
FROM amazon_sales;

-- TOTAL CUSTOMERS
SELECT 
COUNT(DISTINCT CustomerNAme) AS Total_Customers
FROM amazon_sales;

-- TOTAL PRODUCTS 
SELECT 
COUNT(DISTINCT ProductName) AS Total_Products
FROM amazon_sales;

-- TOTAL BRANDS
SELECT 
COUNT(DISTINCT Brand) AS Total_Brand
FROM amazon_sales;

-- TOTAL CATEGORIES
SELECT 
COUNT(DISTINCT Category) AS Total_Categories
FROM amazon_sales;

-- TOTAL QUANTITY SOLD
SELECT 
SUM(Quantity) AS Total_Quantity
FROM amazon_sales;

-- AVERAGE ORDER VALUE
SELECT
ROUND(SUM(TotalAmount) / COUNT(DISTINCT OrderID),2) AS Average_Order_Value
FROM amazon_sales;

-- MINIMUM & MAXIMUM SALES
SELECT
MIN(TotalAmount) AS Minimum_Sale,
MAX(TotalAmount) AS Maximum_Sale
FROM amazon_sales;

-- TOTAL DISCOUT
SELECT 
SUM(Discount) AS Total_Discount
FROM amazon_sales;

-- TOTAL TAX
SELECT 
SUM(Tax) AS Total_Tax
FROM amazon_sales;

-- TOTAL SHIPPING COST
SELECT 
SUM(ShippingCost) AS Total_ShippingCost
FROM amazon_sales;

-- AVERAGE QUANTITY PER ORDER
SELECT
SUM(Quantity) / COUNT(DISTINCT OrderID) AS Average_Quantity_PerOrder
FROM amazon_sales;

-- AVERAGE SALES PER CUSTOMER
SELECT
ROUND(SUM(TotalAmount) / COUNT(DISTINCT CustomerName),2) AS Average_Sales_Per_Customer
FROM amazon_sales;

-- AVERAGE SALES PER PRODUCT
SELECT
ROUND(SUM(TotalAmount) / COUNT(DISTINCT ProductName),2) AS Average_Sales_Per_Product
FROM amazon_sales;

-- DATASET SUMMERY
SELECT
COUNT(*) AS Total_Rows,
COUNT(DISTINCT CustomerID) AS Customers,
COUNT(DISTINCT ProductID) AS Products,
COUNT(DISTINCT Category) AS Categories,
COUNT(DISTINCT Brand) AS Brands,
COUNT(DISTINCT State) AS States,
COUNT(DISTINCT City) AS Cities
FROM amazon_sales;

-- ------------------------------------------------------------------------
--                        CATEGORY  ANALYSIS
-- ------------------------------------------------------------------------
-- CATEGORY WISE TOTAL SALES
SELECT Category,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY Category
ORDER BY Total_Sales DESC;

-- CATEGORY WISE TOTAL ORDERS
SELECT Category,
COUNT(DISTINCT OrderID) AS Total_Orders
FROM amazon_sales
GROUP BY Category
ORDER BY Total_Orders DESC;

-- CATEGORY WISE QUANTITY SOLD
SELECT Category,
SUM(Quantity) AS Total_Quantity
FROM amazon_sales
GROUP BY Category
ORDER BY Total_Quantity DESC;

-- AVERAGE SALE PER CATEGORY
SELECT Category,
ROUND(AVG(TotalAmount),2) AS Average_Sales
FROM amazon_sales
GROUP BY Category
ORDER BY Average_Sales DESC;

-- HIGHEST SELLING CATEGORY
SELECT Category,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY Category
ORDER BY Total_Sales DESC
LIMIT 1;

-- LOWEST SELLING CATEGORY
SELECT Category,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY Category
ORDER BY Total_Sales ASC
LIMIT 1;

-- CATEGORY SALES CONTRIBUTION %
SELECT Category,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(SUM(TotalAmount) * 100/ (SELECT SUM(TotalAmount) FROM amazon_sales),2) AS Sales_Percentage 
FROM amazon_sales
GROUP BY Category
ORDER BY Sales_Percentage DESC;

-- CATEGORY PERFORMENCE SUMMERY 
SELECT Category,
COUNT(DISTINCT OrderID) AS Orders,
SUM(Quantity) AS Quantity_Sold,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(AVG(TotalAmount),2) AS Average_Sales
FROM amazon_sales
GROUP BY Category
ORDER BY Total_Sales DESC;

-- ----------------------------------------------------------------------
--                         PRODUCTS ANALYSIS
-- ----------------------------------------------------------------------
-- PRODUCTS WISE TOTAL SALES 
SELECT ProductName,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY ProductName
ORDER BY Total_Sales DESC;

-- TOP 10 PRODUCTS BY SALES
SELECT ProductName,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY ProductName
ORDER BY Total_Sales DESC
LIMIT 10;

-- BOTTOM 10 PRODUCTS BY SALES
SELECT ProductName,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY ProductName
ORDER BY Total_Sales ASC
LIMIT 10;

-- AVERAGE SALES BY PRODUCTS
SELECT ProductName,
ROUND(AVG(TotalAmount),2) AS Average_Sales
FROM amazon_sales
GROUP BY ProductName
ORDER BY Average_Sales DESC;

-- PRODUCT WISE QUANTITY SOLD
SELECT ProductName,
SUM(Quantity) AS Total_Quantity
FROM amazon_sales
GROUP BY ProductName
ORDER BY Total_Quantity DESC;

-- TOP 10 PRODUCTS BY QUANTITY
SELECT ProductName,
SUM(Quantity) AS Total_Quantity
FROM amazon_sales
GROUP BY ProductName
ORDER BY Total_Quantity DESC
LIMIT 10;

-- PRODUCTS WISE ORDERS
SELECT ProductName,
COUNT(DISTINCT OrderID) AS Total_Orders
FROM amazon_sales
GROUP BY ProductName
ORDER BY Total_Orders DESC;

-- TOP PRODUCT BY SALES
SELECT ProductName,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY ProductName
ORDER BY Total_Sales DESC
LIMIT 1;

-- PRODUCT SALES CONTRIBUTION %
SELECT ProductName,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(SUM(TotalAmount) *100/ (SELECT SUM(TotalAmount) FROM amazon_sales),2) AS Sales_Percentage
FROM amazon_sales
GROUP BY ProductName
ORDER BY Sales_Percentage DESC;

-- PRODUCT PERFORMANCE SUMMERY 
SELECT ProductName,
COUNT(DISTINCT OrderID) AS Orders,
SUM(Quantity) AS Quantity_Sold,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(AVG(TotalAmount),2) AS Avg_Sales
FROM amazon_sales
GROUP BY ProductName
ORDER BY Total_Sales DESC;

-- -----------------------------------------------------------------------
--                            BRAND ANALYSIS
-- ------------------------------------------------------------------------
-- BRAND WISE TOTAL SALES
SELECT Brand,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY Brand
ORDER BY Total_Sales DESC;

-- TOP 10 BRANDS BY SALES
SELECT Brand,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY Brand
ORDER BY Total_Sales DESC
LIMIT 10;

-- BRAND WISE QUANTITY SOLD
SELECT Brand,
SUM(Quantity) AS Total_Quantity
FROM amazon_sales
GROUP BY Brand
ORDER BY Total_Quantity DESC;

-- BRAND WISE ORDERS
SELECT Brand,
COUNT(DISTINCT OrderID) AS Total_Orders
FROM amazon_sales
GROUP BY Brand
ORDER BY Total_Orders DESC;

-- AVERAGE SALES BY BRAND
SELECT Brand,
Round(AVG(TotalAmount),2) AS Average_Sales
FROM amazon_sales
GROUP BY Brand
ORDER BY Average_Sales DESC;

-- BEST PERFORMING BRAND
SELECT Brand,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY Brand
ORDER BY Total_Sales DESC
LIMIT 1;

-- LOWEST PERFORMING BRAND
SELECT Brand,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY Brand
ORDER BY Total_Sales ASC
LIMIT 1;

-- BRAND SALES CONTRIBUTION %
SELECT Brand,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(SUM(TotalAmount)*100/ (SELECT SUM(TotalAmount) FROM amazon_sales),2) AS Sales_Percentage
FROM amazon_sales
GROUP BY Brand
ORDER BY Total_Sales DESC;

-- BRAND PERFORMENCE SUMMERY
SELECT Brand,
COUNT(DISTINCT OrderID) AS Total_Orders,
SUM(Quantity) AS Total_Quantity,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(AVG(TotalAmount),2) AS Average_Sales
FROM amazon_sales
GROUP BY Brand
ORDER BY Total_Sales DESC;

-- ------------------------------------------------------------
--                CUSTOMER ANALYSIS
-- ------------------------------------------------------------
-- CUSTOMER WISE TOTAL SALES
SELECT CustomerName,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY CustomerName
ORDER BY Total_Sales DESC;

-- TOP 10 CUSTOMERS BY SALES
SELECT CustomerName,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY CustomerName
ORDER BY Total_Sales DESC
LIMIT 10;

-- CUSTOMER WISE ORDERS
SELECT CustomerName,
COUNT(DISTINCT OrderID) AS Total_Orders
FROM amazon_sales
GROUP BY CustomerName
ORDER BY Total_Orders DESC;

-- CUSTOMER WISE QUANTITY PURCHASED
SELECT CustomerName,
SUM(Quantity) AS Total_Quantity
FROM amazon_sales
GROUP BY CustomerName
ORDER BY Total_Quantity DESC;

--  AVERAGE SPENDING BY CUSTOMER
SELECT CustomerName,
ROUND(AVG(TotalAmount),2) AS Average_Sales
FROM amazon_sales
GROUP BY CustomerName
ORDER BY Averagae_Sales DESC;

-- BEST CUSTOMER
SELECT CustomerName,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY CustomerName
ORDER BY Total_Sales DESC
LIMIT 1;

-- CUSTOMER SALES CONTRIBUTION %
SELECT CustomerName,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(SUM(TotalAmount) * 100/ (SELECT SUM(TotalAmount) FROM amazon_sales),2) AS Sales_Percentage
FROM amazon_sales
GROUP BY CustomerName
ORDER BY Sales_Percentage DESC;

-- CUSTOMER PERFORMANCE SUMMERY
SELECT CustomerName,
COUNT(DISTINCT OrderID) AS Total_Orders,
SUM(Quantity) AS Total_Quantity,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(AVG(TotalAmount),2) AS Average_Spending
FROM amazon_sales
GROUP BY CustomerName
ORDER BY Total_Sales DESC;

-- ----------------------------------------------------------------------
--                  GEOGRAPHICS ANALYSIS
-- ---------------------------------------------------------------------
-- STATE WISE TOTAL SALES
SELECT State,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY State
ORDER BY Total_Sales DESC;

-- TOP 10 STATE BY SALES
SELECT State,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 10;

-- CITY WISE TOTAL SALES
SELECT City,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY City
ORDER BY Total_Sales DESC;

-- TOP 10 CITIES BY SALES
SELECT City,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY City
ORDER BY Total_Sales DESC
LIMIT 10;

-- STATE WISE ORDERS
SELECT State,
COUNT(DISTINCT OrderID) AS Total_Orders
FROM amazon_sales
GROUP BY State
ORDER BY Total_Orders DESC;

-- STATE WISE QUANTITY SOLD
SELECT State,
SUM(Quantity) AS Total_Quantity
FROM amazon_sales
GROUP BY State
ORDER BY Total_Quantity DESC;

-- CITY WISE ORDERS
SELECT City,
COUNT(DISTINCT OrderID) AS Total_Orders
FROM amazon_sales
GROUP BY City
ORDER BY Total_Orders DESC;

-- CITY WISE QUANTITY SOLD
SELECT City,
SUM(Quantity) AS Total_Quantity
FROM amazon_sales
GROUP BY City
ORDER BY Total_Quantity DESC;

-- BEST PERFORMING STATE
SELECT State,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 1;

-- BEST PERFORMING CITY
SELECT City,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY City
ORDER BY Total_Sales DESC
LIMIT 1;

-- STATE SALES CONTRIBUTION %
SELECT State,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(SUM(TotalAmount) * 100/ (SELECT SUM(TotalAmount) FROM amazon_sales),2) AS Sales_Percentage
FROM amazon_sales
GROUP BY State
ORDER BY Total_Sales DESC;

-- CITY SALES CONTRIBUTION %
SELECT City,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(SUM(TotalAmount) * 100/ (SELECT SUM(TotalAmount) FROM amazon_sales),2) AS Sales_Percentage
FROM amazon_sales
GROUP BY City
ORDER BY Total_Sales DESC;

-- GEOGRAPHICS PERFORMANCE SUMMERY
SELECT State,
COUNT(DISTINCT OrderID) AS Total_Orders,
SUM(Quantity) AS Total_Quantity,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(AVG(TotalAmount),2) AS Average_Sales
FROM amazon_sales
GROUP BY State
ORDER BY Total_Sales DESC;

SELECT City,
COUNT(DISTINCT OrderID) AS Total_Orders,
SUM(Quantity) AS Total_Quantity,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(AVG(TotalAmount),2) AS Average_Sales
FROM amazon_sales
GROUP BY City
ORDER BY Total_Sales DESC;

-- --------------------------------------------------------------
--                 ORDER STATUS ANALYSIS
-- --------------------------------------------------------------
-- ORDER STATUS WISE SALES
SELECT Orderstatus,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY OrderStatus
ORDER BY Total_Sales DESC;

-- ORDER STATUS WISE ORDERS
SELECT Orderstatus,
COUNT(DISTINCT OrderID) AS Total_Orders
FROM amazon_sales
GROUP BY OrderStatus
ORDER BY Total_Orders DESC;

-- ORDER STATUS WISE QUANTITY SOLD
SELECT Orderstatus,
SUM(Quantity) AS Total_Quantity
FROM amazon_sales
GROUP BY OrderStatus
ORDER BY Total_Quantity DESC;

-- AVERGAE ORDER VALUE BY STATUS
SELECT Orderstatus,
ROUND(AVG(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY OrderStatus
ORDER BY Total_Sales DESC;

-- MOST COMMON ORDER STATUS
SELECT Orderstatus,
COUNT(DISTINCT OrderID) AS Total_Orders
FROM amazon_sales
GROUP BY OrderStatus
ORDER BY Total_Orders DESC
LIMIT 1;

-- ORDER STATUS DISTRIBUTION
SELECT Orderstatus,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(SUM(TotalAmount) *100/ (SELECT SUM(TotalAmount) FROM amazon_sales),2) AS Sales_Percenatge
FROM amazon_sales
GROUP BY OrderStatus
ORDER BY Sales_Percenatge DESC;

-- ORDER STATUS PERFORMANCE SUMMERY
SELECT OrderStatus,
COUNT(DISTINCT OrderID) AS Total_Orders,
SUM(Quantity) AS Total_Quantity,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(AVG(TotalAmount),2) AS Average_Order_Value
FROM amazon_sales
GROUP BY OrderStatus
ORDER BY Total_Sales DESC;

-- ---------------------------------------------------------------
--               PAYMENT METHOD ANALYSIS
-- ---------------------------------------------------------------
-- PAYMENT METHOD WISE TOTAL SALES
SELECT PaymentMethod,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY PaymentMethod
ORDER BY Total_Sales DESC;

-- PAYMENT METHOD WISE TOTAL ORDERS
SELECT PaymentMethod,
COUNT(DISTINCT OrderID) AS Total_Orders
FROM amazon_sales
GROUP BY PaymentMethod
ORDER BY Total_Orders DESC;

-- PAYMENT METHOD WISE QUANTITY SOLD
SELECT PaymentMethod,
SUM(Quantity) AS Total_Quantity
FROM amazon_sales
GROUP BY PaymentMethod
ORDER BY Total_Quantity DESC;

-- AVERAGE ORDER VALUE BY PAYMENT METHOD
SELECT PaymentMethod,
ROUND(AVG(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY PaymentMethod
ORDER BY Total_Sales DESC;

-- MOST USED PAYMENT METHOD
SELECT PaymentMethod,
COUNT(DISTINCT OrderID) AS Total_Orders
FROM amazon_sales
GROUP BY PaymentMethod
ORDER BY Total_Orders DESC
LIMIT 1;

-- PAYMENT METHOD CONTRIBUTION %
SELECT PaymentMethod,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(SUM(TotalAmount) *100/ (SELECT SUM(TotalAmount) FROM amazon_sales),2) AS Sales_Percenatge
FROM amazon_sales
GROUP BY PaymentMethod
ORDER BY Sales_Percenatge DESC;

-- PAYMENT METHOD PERFORMANCE SUMMERY
SELECT PaymentMethod,
COUNT(DISTINCT OrderID) AS Total_Orders,
SUM(Quantity) AS Total_Quantity,
ROUND(SUM(TotalAmount),2) AS Total_Sales,
ROUND(AVG(TotalAmount),2) AS Average_Order_Value
FROM amazon_sales
GROUP BY PaymentMethod
ORDER BY Total_Sales DESC;

-- -----------------------------------------------------------------
--                   TIME ANALYSIS
-- -----------------------------------------------------------------
-- YEAR WISE SALES
SELECT YEAR(OrderDate) AS Year,
ROUND(SUM(TotalAmount),2) AS Yearly_Sales
FROM amazon_sales
GROUP BY YEAR(OrderDate)
ORDER BY Year;

-- MONTH WISE SALES
SELECT YEAR(OrderDate) AS year,
MONTHNAME(OrderDate) AS Month_Name,
MONTH(OrderDate) AS Month_Number,
ROUND(SUM(TotalAmount),2) AS Monthly_Sales
FROM amazon_sales
GROUP BY YEAR(OrderDate),MONTH(OrderDate),MONTHNAME(OrderDate)
ORDER BY Year,Month_Name;

-- YEAR-MONTH SALES
SELECT DATE_FORMAT(STR_TO_DATE(OrderDate, '%d/%m/%Y'), '%Y-%m') AS `Year_Month`,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY DATE_FORMAT(STR_TO_DATE(OrderDate, '%d/%m/%Y'), '%Y-%m')
ORDER BY `Year_Month`;

-- QUARTER WISE SALES
SELECT YEAR(OrderDate) AS year,
CONCAT('Q',QUARTER(OrderDate)) AS Quarter,
ROUND(SUM(TotalAmount),2) AS Quarter_Sales
FROM amazon_sales
GROUP BY YEAR(OrderDate), QUARTER(OrderDate)
ORDER BY QUARTER(OrderDate);

-- YEAR WISE ORDERS
SELECT YEAR(OrderDate) AS Year,
COUNT(DISTINCT OrderID) AS Yearly_Orders
FROM amazon_sales
GROUP BY YEAR(OrderDate)
ORDER BY Year;

-- MONTH WISE ORDERS
SELECT MONTH(OrderDate) AS Month,
COUNT(DISTINCT OrderID) AS Monthly_Orders
FROM amazon_sales
GROUP BY MONTH(OrderDate),MONTHNAME(OrderDate)
ORDER BY MONTH(OrderDate);

-- MONTH WISE QUANTITY SOLD
SELECT DATE_FORMAT(OrderDate,'%Y-%m') AS `Year_Month`,
SUM(Quantity) AS Quantity_Sold
FROM amazon_sales
GROUP BY DATE_FORMAT(OrderDate,'%Y-%m')
ORDER BY `Year_Month`;

-- HIGHEST SALES MONTH
SELECT DATE_FORMAT(OrderDate,'%Y-%m') AS `Year_Month`,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY DATE_FORMAT(OrderDate,'%Y-%m')
ORDER BY Total_Sales DESC
LIMIT 1;

-- HIGHEST SALES YEAR
SELECT YEAR(OrderDate) AS Year,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY YEAR(OrderDate)
ORDER BY Total_Sales DESC
LIMIT 1;

-- MONTHLY PERFORMANCE SUMMERY
SELECT DATE_FORMAT(OrderDate,'%Y-%m') AS `Year_Month`,
COUNT(DISTINCT OrderID) AS Total_Orders,
SUM(Quantity) AS Total_Quantity,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY DATE_FORMAT(OrderDate,'%Y-%m')
ORDER BY `Year_Month`;

-- -----------------------------------------------------------------
--                    HAVING CLAUSE ANALYSIS
-- ------------------------------------------------------------------
-- CATEGORY WITH SALES MORE THAN 1,000,000
SELECT Category,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY Category
HAVING Total_Sales > 1000000
ORDER BY Total_Sales DESC;

-- PRODUCTS SOLD MORE THAN 100 UNITS
SELECT ProductName,
SUM(Quantity) AS Total_Quantity
FROM amazon_sales
GROUP BY ProductName
HAVING Total_Quantity >100
ORDER BY Total_Quantity DESC;

-- CUSTOMERS WITH TOTAL PURCHASE ABOVE 10,000
SELECT CustomerName,
ROUND(SUM(TotalAmount),2) AS Total_Sales
FROM amazon_sales
GROUP BY CustomerName
HAVING Total_Sales > 10000
ORDER BY Total_Sales DESC;

-- STATE WITH MORE THAN 100 ORDERS
SELECT State,
COUNT(DISTINCT OrderID) AS Total_Orders
FROM amazon_sales
GROUP BY State
HAVING Total_Orders >100
ORDER BY Total_Orders DESC;

-- BRANDS WITH AVERAGE SALES GREATER THAN 500
SELECT Brand,
ROUND(AVG(TotalAmount),2) AS Average_Sales
FROM amazon_sales
GROUP BY Brands
HAVING Average_Sales > 500
ORDER BY Average_Sales DESC;

-- -----------------------------------------------------------------
--                 CTE ANALYSIS
-- -----------------------------------------------------------------
-- CATEGORY SALES 
WITH CategorySales AS (
    SELECT Category,
	ROUND(SUM(TotalAmount), 2) AS Total_Sales
    FROM amazon_sales
    GROUP BY Category)
SELECT Category,
Total_Sales
FROM CategorySales
ORDER BY Total_Sales DESC;

-- TOP 10 PRODUCTS
WITH ProductSales AS(
    SELECT ProductName,
    ROUND(SUM(TotalAmount), 2) AS Total_Sales
    FROM amazon_sales
    GROUP BY ProductName)
SELECT ProductName,
Total_Sales
FROM ProductSales
ORDER BY ProductSales DESC
LIMIT 10;

-- CUSTOMERS ABOVE AVERAGE SPENDING
WITH CustomerSales AS(
  SELECT CustomerName,
   ROUND(SUM(TotalAmount), 2) AS Total_Sales
   FROM amazon_sales
   GROUP BY CustomerName),
   AverageSales AS(
   SELECT CustomerName,
   ROUND(AVG(TotalAmount), 2) AS Average_Sales
   FROM amazon_sales 
   GROUP BY CustomerName)
SELECT c.CustomerName,
ROUND(c.Total_Sales,2) AS Total_Sales
FROM CustomerSales c
CROSS JOIN AverageSales a
WHERE c.Total_Sales > a.Average_Sales
ORDER BY Total_Sales DESC;

-- ----------------------------------------------------------------
--                 WINDOWS FUNCTION ANALYSIS
-- ----------------------------------------------------------------
-- CATEGORY RANKING BY SALES
SELECT
    Category,
    Total_Sales,
    RANK() OVER (ORDER BY Total_Sales DESC) AS Sales_Rank
FROM CategorySales
ORDER BY Sales_Rank;

-- PRODUCTS RANKING BY SALES
SELECT
    ProductName,
    Total_Sales,
    RANK() OVER (ORDER BY Total_Sales DESC) AS Product_Rank
FROM ProductSales
ORDER BY Product_Rank;

-- BRAND RANKING BY SALES
WITH BrandSales AS(
    SELECT Brand,
    ROUND(SUM(TotalAmount), 2) AS Total_Sales
    FROM amazon_sales
    GROUP BY Brand)
SELECT Brand,
Total_Sales,
RANK() OVER(ORDER BY Total_Sales DESC) AS Brand_Rank
FROM BrandSales
ORDER BY Brand_Rank;

-- MONTHLY SALES WITH PREVIOUS SALES
WITH MonthlySales AS(
   SELECT DATE_FORMAT(STR_TO_DATE(OrderDate, "%D-%Y-%M"),"%Y-%M") AS `Year_Month`,
   ROUND(SUM(TotalAmount), 2) AS Total_Sales
   FROM amazon_sales
   GROUP BY DATE_FORMAT(STR_TO_DATE(OrderDate,"%D-%Y-%M"), "%Y-%M") )
SELECT `Year_Month`,
Total_Sales,
LAG(Total_Sales) 
OVER (ORDER BY `Year_Month`) AS Previous_Month_Sales
FROM Monthly Sales
ORDER BY `Year_Month`;

-- RUNNING TOTAL MONTHLY SALES
SELECT `Year_Month`,
Total_Sales,
ROUND(SUM(Total_Sales) OVER (ORDER BY `Year_Month`),2) AS Running_Total
FROM Monthly Sales
ORDER BY `Year_Month`;
   
    



-- -----------------------------------------------------------------
--                        BUSINESS INSIGHTS 
-- -----------------------------------------------------------------
/*
1. Electronics generated the highest overall sales among all product categories.

2. Memory Card 128GB was the best-selling product based on total revenue.

3. CoreTech was the top-performing brand in terms of total sales.

4. Pooja Kapoor generated the highest customer sales value.

5. Texas (TX) recorded the highest overall sales among all states.

6. Credit Card was the most frequently used payment method.

7. Delivered was the most common order status, indicating successful order fulfillment.

8. May 2024 recorded the highest monthly sales during the analysis period.

9. Sales were concentrated in a few high-performing categories, products, and regions.

10. These insights can help businesses improve inventory planning, marketing strategies, customer targeting, and sales performance.
*/

-- -----------------------------------------------------------------
--                                CONCLUSION
-- ------------------------------------------------------------------
/*
This project analyzed Amazon Sales data using MySQL.

The analysis included:
✓ Data Understanding
✓ Data Cleaning
✓ Exploratory Data Analysis
✓ KPI Analysis
✓ Category Analysis
✓ Product Analysis
✓ Brand Analysis
✓ Customer Analysis
✓ Geographic Analysis
✓ Order Status Analysis
✓ Payment Method Analysis
✓ Time Analysis

The project provides meaningful business insights that support data-driven decision-making and demonstrates practical SQL skills for data analysis.
*/






