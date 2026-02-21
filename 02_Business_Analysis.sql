


-- KPI Overview:
-- Calculate overall performance metrics for the dataset.

SELECT
    COUNT(Order_ID) AS Total_Orders,
    SUM(Order_Value) AS Total_Revenue,
    AVG(Order_Value) AS Avg_Order_Value,
    AVG(Delivery_Time_Min) AS Avg_Delivery_Time,
    AVG(Customer_Rating) AS Avg_Customer_Rating
FROM quick_commerce_data_raw;

-- Business Question:
-- Identify the quick commerce platform generating the highest total revenue.

SELECT TOP 1
       Company,
       SUM(Order_Value) AS Total_Revenue
FROM quick_commerce_data_raw
GROUP BY Company
ORDER BY Total_Revenue DESC;

-- Business Question:
-- Which company holds the largest market share in terms of order count?

SELECT
    Company,
    COUNT(Order_ID) AS Total_Orders
FROM quick_commerce_data_raw
GROUP BY Company
ORDER BY Total_Orders DESC;

-- Business Question:
-- Identify the most popular product category by total quantity ordered.

SELECT
    Product_Category,
    SUM(Items_Count) AS Total_Items_Sold
FROM quick_commerce_data_raw
GROUP BY Product_Category
ORDER BY Total_Items_Sold DESC;

-- Business Question:
-- Does payment method influence Average Order Value (AOV)?

SELECT
    Payment_Method,
    ROUND(AVG(Order_Value), 2) AS Avg_Order_Value
FROM quick_commerce_data_raw
GROUP BY Payment_Method
ORDER BY Avg_Order_Value DESC;

-- Business Question:
-- Which company generates the highest revenue per kilometer traveled?

SELECT
    Company,
    SUM(Order_Value) / SUM(Distance_Km) AS Revenue_Per_Km
FROM quick_commerce_data_raw
GROUP BY Company
ORDER BY Revenue_Per_Km DESC;

-- Business Question:
-- Which company shows the best alignment between delivery partner ratings and customer ratings?

SELECT
    Company,
    AVG(Delivery_Partner_Rating) AS Avg_Delivery_Partner_Rating,
    AVG(Customer_Rating) AS Avg_Customer_Rating,
    AVG(Delivery_Partner_Rating) - AVG(Customer_Rating) AS Rating_Gap
FROM quick_commerce_data_raw
GROUP BY Company
ORDER BY Rating_Gap ASC;

-- Business Question:
-- Identify cities(slow zones) where average delivery time exceeds
-- 10% above the global average.

SELECT
    City,
    AVG(Delivery_Time_Min) AS Avg_Delivery_Time
FROM quick_commerce_data_raw
GROUP BY City
HAVING AVG(Delivery_Time_Min) >
       (SELECT AVG(Delivery_Time_Min) * 1.1
        FROM quick_commerce_data_raw);

-- Business Question:
-- Identify product categories with high ratings but low sales volume.

SELECT
    Product_Category,
    AVG(Customer_Rating) AS Avg_Customer_Rating,
    COUNT(*) AS Total_Orders
FROM quick_commerce_data_raw
GROUP BY Product_Category
HAVING AVG(Customer_Rating) > 3.0
ORDER BY Total_Orders ASC;

-- Business Question:
-- Identify the company with the best operational efficiency
-- based on order volume and delivery time performance.

WITH CompanyAggregation AS (
    SELECT
        Company,
        COUNT(Order_ID) AS Total_Orders,
        AVG(Delivery_Time_Min) AS Avg_Delivery_Time
    FROM quick_commerce_data_raw
    GROUP BY Company
),
MinMax AS (
    SELECT
        MIN(Total_Orders) AS Min_Orders,
        MAX(Total_Orders) AS Max_Orders,
        MIN(Avg_Delivery_Time) AS Min_Delivery_Time,
        MAX(Avg_Delivery_Time) AS Max_Delivery_Time
    FROM CompanyAggregation
),
FinalEfficiency AS (
    SELECT
        c.Company,
        c.Total_Orders,
        c.Avg_Delivery_Time,
        (c.Total_Orders - m.Min_Orders) * 1.0 /
        (m.Max_Orders - m.Min_Orders) AS Orders_Scaled,
        (c.Avg_Delivery_Time - m.Min_Delivery_Time) * 1.0 /
        (m.Max_Delivery_Time - m.Min_Delivery_Time) AS Delivery_Time_Scaled
    FROM CompanyAggregation c
    CROSS JOIN MinMax m
)

SELECT
    Company,
    Total_Orders,
    Avg_Delivery_Time,
    (Orders_Scaled - Delivery_Time_Scaled) AS Efficiency_Score
FROM FinalEfficiency
ORDER BY Efficiency_Score DESC;

-- Business Question:
-- Which age group places the highest number of orders?

SELECT
    Age_Group,
    COUNT(*) AS Total_Orders
FROM (
    SELECT
        CASE
            WHEN Customer_Age <= 25 THEN '18-25'
            WHEN Customer_Age <= 35 THEN '26-35'
            WHEN Customer_Age <= 45 THEN '36-45'
            ELSE '46+'
        END AS Age_Group
    FROM quick_commerce_data_raw
) AS AgeData
GROUP BY Age_Group
ORDER BY Total_Orders DESC;

-- Business Question:
-- Evaluate whether discounts increase order volume or primarily affect revenue.

SELECT
    Discount_Applied,
    COUNT(*) AS Total_Orders,
    AVG(Order_Value) AS Avg_Order_Value,
    SUM(Items_Count) AS Total_Items_Purchased
FROM quick_commerce_data_raw
GROUP BY Discount_Applied;