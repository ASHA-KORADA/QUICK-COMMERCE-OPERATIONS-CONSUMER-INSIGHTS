CREATE DATABASE QCOMMERCE

GO

SELECT * FROM [dbo].[quick_commerce_data_raw]

-- Counting null's in City column
SELECT COUNT(*) AS Null_city
FROM [dbo].[quick_commerce_data_raw]
WHERE City IS NULL
--52000

-- Removing Null's in City column
Delete 
FROM [dbo].[quick_commerce_data_raw]
WHERE City IS NULL

-- Checking null's in City column
SELECT COUNT(*) AS city_no_nulls
FROM [dbo].[quick_commerce_data_raw]
WHERE City IS NULL
--0

-- Counting of City rows
SELECT COUNT(*) City
FROM [dbo].[quick_commerce_data_raw]
--948000

-- Counting null's in Order_value column

SELECT COUNT(*) AS Null_ORDER_VALUE
FROM [dbo].[quick_commerce_data_raw]
WHERE Order_Value IS NULL

-- Counting null's in Items_Count column
SELECT COUNT(*) AS Null_ITEMS_COUNT
FROM [dbo].[quick_commerce_data_raw]
WHERE Items_Count IS NULL
--33228

-- Finding the mode of Items_count
SELECT TOP 1 Items_Count
FROM [dbo].[quick_commerce_data_raw]
WHERE Items_Count IS NOT NULL
GROUP BY Items_Count
ORDER BY COUNT(*) DESC
-- 19

-- Replace Null values With Mode value in Items_Count

UPDATE [dbo].[quick_commerce_data_raw]
SET Items_Count = 
( SELECT TOP 1 Items_Count
FROM [dbo].[quick_commerce_data_raw]
WHERE Items_Count IS NOT NULL
GROUP BY Items_Count
ORDER BY COUNT(*) DESC
)
WHERE Items_Count IS NULL
--33228

-- Counting null's in Customer_Rating column

SELECT COUNT(*) AS Null_Customer_Rating
FROM [dbo].[quick_commerce_data_raw]
WHERE Customer_Rating IS NULL
--44575

-- Finding the Mean/Avg of Customer_Rating

SELECT TOP 8 Avg(Customer_Rating) as Avg_Customer_Rating,Company
FROM [dbo].[quick_commerce_data_raw]
WHERE Customer_Rating IS NOT NULL
GROUP BY Company

-- Replace Avg/Mean of Customer_Rating

UPDATE qc 
SET Customer_Rating = ca.Avg_Customer_Rating
FROM [dbo].[quick_commerce_data_raw] qc
JOIN
(SELECT Company,AVG(Customer_Rating) as Avg_Customer_Rating
FROM [dbo].[quick_commerce_data_raw] 
WHERE Customer_Rating IS NOT NULL
GROUP BY Company
) ca 
on qc.Company = ca.Company
where qc.Customer_Rating is null;


-- Counting null's in Delivery_Partner_Rating column

SELECT COUNT(*) AS Null_Delivery_Partner_Rating
FROM [dbo].[quick_commerce_data_raw]
WHERE Delivery_Partner_Rating IS NULL
--98694


-- Finding  Avg/Mean of Delivery_Partner_Rating

SELECT Delivery_Time_Min,AVG(Delivery_Partner_Rating) AS AVG_Rating
FROM [dbo].[quick_commerce_data_raw]  
where Delivery_Partner_Rating IS NOT NULL
GROUP BY Delivery_Time_Min

-- Replace Avg/Mean of Delivery_Partner_Rating

UPDATE qc 
SET Delivery_Partner_Rating = dt.AVG_Rating
FROM [dbo].[quick_commerce_data_raw] qc
JOIN
(SELECT Delivery_Time_Min,AVG(Delivery_Partner_Rating) AS AVG_Rating
FROM [dbo].[quick_commerce_data_raw]  
where Delivery_Partner_Rating IS NOT NULL
GROUP BY Delivery_Time_Min
) dt 
on qc.Delivery_Time_Min  = dt.Delivery_Time_Min
where qc.Delivery_Partner_Rating is null;


-- Identifying Delivery Times with No Available Delivery Partner Ratings

SELECT
    Delivery_Time_Min,
    COUNT(*) AS total_rows,
    COUNT(Delivery_Partner_Rating) AS non_null_ratings
FROM [dbo].[quick_commerce_data_raw]
GROUP BY Delivery_Time_Min
HAVING COUNT(Delivery_Partner_Rating) = 0;

-- Replacing Missing Delivery Partner Ratings with Global Average Value

UPDATE [dbo].[quick_commerce_data_raw]
SET Delivery_Partner_Rating =
(
    SELECT AVG(Delivery_Partner_Rating)
    FROM [dbo].[quick_commerce_data_raw]
    WHERE Delivery_Partner_Rating IS NOT NULL
)
WHERE Delivery_Partner_Rating IS NULL;