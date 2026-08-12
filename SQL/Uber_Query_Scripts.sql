
-- Use the 'Analysis' database for the following queries
USE Analysis;


-- Retrieve all data from the 'uber' table for review
SELECT * FROM Analysis.uber;


-- Get the schema details of the 'uber' table, such as column names, types, etc.
DESCRIBE uber;


-- Summarize missing (NULL) values in key columns to assess data quality
SELECT 
    SUM(CASE WHEN VendorID IS NULL THEN 1 ELSE 0 END) AS null_vendor_id,
    SUM(CASE WHEN tpep_pickup_datetime IS NULL THEN 1 ELSE 0 END) AS null_pickup,
    SUM(CASE WHEN tpep_dropoff_datetime IS NULL THEN 1 ELSE 0 END) AS null_dropoff,
    SUM(CASE WHEN passenger_count IS NULL THEN 1 ELSE 0 END) AS null_passenger_count,
    SUM(CASE WHEN trip_distance IS NULL THEN 1 ELSE 0 END) AS null_trip_distance,
    SUM(CASE WHEN pickup_longitude IS NULL THEN 1 ELSE 0 END) AS null_pickup_longitude,
    SUM(CASE WHEN pickup_latitude IS NULL THEN 1 ELSE 0 END) AS null_pickup_latitude,
    SUM(CASE WHEN dropoff_longitude IS NULL THEN 1 ELSE 0 END) AS null_dropoff_longitude,
    SUM(CASE WHEN dropoff_latitude IS NULL THEN 1 ELSE 0 END) AS null_dropoff_latitude,
    SUM(CASE WHEN payment_type IS NULL THEN 1 ELSE 0 END) AS null_payment_type,
    SUM(CASE WHEN fare_amount IS NULL THEN 1 ELSE 0 END) AS null_fare
FROM uber;


-- Display the column details for the 'uber' table again
SHOW COLUMNS FROM uber;


-- Retrieve all data again from the 'uber' table to confirm updates and for further analysis
SELECT * FROM Analysis.uber;


-- Identify and list records where fare_amount is less than or equal to 0, which is unusual or erroneous data
SELECT * 
FROM uber 
WHERE fare_amount <= 0;


-- Remove rows where the fare_amount is less than or equal to 0 (data cleanup)
DELETE FROM uber
WHERE fare_amount <= 0;


-- Summarize zero and negative values in key columns, possibly indicative of erroneous data
SELECT 
    SUM(CASE WHEN trip_distance = 0 THEN 1 ELSE 0 END) AS zero_trip_distance,
    SUM(CASE WHEN passenger_count = 0 THEN 1 ELSE 0 END) AS zero_passenger_count,
    SUM(CASE WHEN fare_amount = 0 THEN 1 ELSE 0 END) AS zero_fare_amount,
    SUM(CASE WHEN tip_amount = 0 THEN 1 ELSE 0 END) AS zero_tip_amount,
    SUM(CASE WHEN mta_tax = 0 THEN 1 ELSE 0 END) AS zero_mta_tax,
    SUM(CASE WHEN total_amount = 0 THEN 1 ELSE 0 END) AS zero_total_amount,
    SUM(CASE WHEN improvement_surcharge = 0 THEN 1 ELSE 0 END) AS zero_improvement_surcharge,
    SUM(CASE WHEN tolls_amount = 0 THEN 1 ELSE 0 END) AS zero_tolls_amount,
    SUM(CASE WHEN trip_distance < 0 THEN 1 ELSE 0 END) AS negative_trip_distance
FROM uber;


-- Disable safe updates to allow deletion of records based on conditions
SET SQL_SAFE_UPDATES = 0;


-- Delete records where the trip duration is 0 minutes (likely erroneous)
DELETE FROM uber
WHERE trip_duration_min = 0;


-- Remove rows with zero values in multiple key columns to clean up the dataset
DELETE FROM uber
WHERE trip_distance = 0
   OR passenger_count = 0
   OR fare_amount = 0
   OR total_amount = 0
   OR improvement_surcharge = 0;


-- Summarize zero and negative values again to ensure the data is cleaned up properly
SELECT 
    SUM(CASE WHEN trip_distance = 0 THEN 1 ELSE 0 END) AS zero_trip_distance,
    SUM(CASE WHEN passenger_count = 0 THEN 1 ELSE 0 END) AS zero_passenger_count,
    SUM(CASE WHEN fare_amount = 0 THEN 1 ELSE 0 END) AS zero_fare_amount,
    SUM(CASE WHEN tip_amount = 0 THEN 1 ELSE 0 END) AS zero_tip_amount,
    SUM(CASE WHEN mta_tax = 0 THEN 1 ELSE 0 END) AS zero_mta_tax,
    SUM(CASE WHEN total_amount = 0 THEN 1 ELSE 0 END) AS zero_total_amount,
    SUM(CASE WHEN improvement_surcharge = 0 THEN 1 ELSE 0 END) AS zero_improvement_surcharge,
    SUM(CASE WHEN tolls_amount = 0 THEN 1 ELSE 0 END) AS zero_tolls_amount,
    SUM(CASE WHEN trip_distance < 0 THEN 1 ELSE 0 END) AS negative_trip_distance
FROM uber;



-- Retrieve all data again after cleanup for verification
SELECT * FROM Analysis.uber;


-- Add new columns to store date, month, year, weekday, and hour for each ride's pickup time
ALTER TABLE uber
ADD COLUMN pickup_date DATE,
ADD COLUMN pickup_month VARCHAR(20),
ADD COLUMN pickup_year INT,
ADD COLUMN pickup_day_of_week VARCHAR(10),
ADD COLUMN pickup_hour INT;



-- Update the new columns based on the 'tpep_pickup_datetime' field
UPDATE uber
SET 
    pickup_date = DATE(tpep_pickup_datetime),
    pickup_month = MONTHNAME(tpep_pickup_datetime),
    pickup_year = YEAR(tpep_pickup_datetime),
    pickup_day_of_week = DAYNAME(tpep_pickup_datetime),
    pickup_hour = HOUR(tpep_pickup_datetime);



-- Retrieve all data to confirm the new columns have been correctly updated
SELECT * FROM Analysis.uber;



-- Add a new column for trip duration in minutes
ALTER TABLE uber ADD COLUMN trip_duration_min INT;


-- Update the new 'trip_duration_min' column by calculating the duration in minutes between pickup and dropoff
UPDATE uber
SET trip_duration_min = TIMESTAMPDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime);


-- Add a new column for tip percentage (tip amount relative to fare)
ALTER TABLE uber ADD COLUMN tip_percentage DECIMAL(10,2);



-- Calculate the tip percentage and update the 'tip_percentage' column
UPDATE uber
SET tip_percentage = 
    CASE 
        WHEN fare_amount > 0 THEN (tip_amount / fare_amount) * 100 
        ELSE 0 
    END;


-- Retrieve data again to verify the new tip percentage calculations
SELECT * FROM Analysis.uber;



-- Add new columns for fare per mile and fare per minute
ALTER TABLE uber 
ADD COLUMN fare_per_mile DECIMAL(10,2),
ADD COLUMN fare_per_minute DECIMAL(10,2);


-- Calculate and update 'fare_per_mile' and 'fare_per_minute' based on trip data
UPDATE uber
SET 
    fare_per_mile = CASE 
        WHEN trip_distance > 0 THEN fare_amount / trip_distance 
        ELSE NULL 
    END,
    fare_per_minute = CASE 
        WHEN trip_duration_min > 0 THEN fare_amount / trip_duration_min 
        ELSE NULL 
    END;
    
    

-- Retrieve all data again to ensure the fare calculations are correct
SELECT * FROM Analysis.uber;



-- Categorize fare amounts into three groups: Low, Medium, and High, and count the occurrences of each
SELECT 
    CASE
        WHEN fare_amount <= 30 THEN 'Low'
        WHEN fare_amount > 30 AND fare_amount <= 100 THEN 'Medium'
        WHEN fare_amount > 100 THEN 'High'
    END AS fare_category,
    
    COUNT(*) AS count
FROM uber
GROUP BY fare_category;


-- Categorize tip amounts into three groups: Low, Medium, and High, and count the occurrences of each
SELECT 
    
    CASE
        WHEN tip_amount <= 5 THEN 'Low'
        WHEN tip_amount > 5 AND tip_amount <= 20 THEN 'Medium'
        WHEN tip_amount > 20 THEN 'High'
    END AS tip_category,
    


-- Remove rows where the payment type is either 3 (unknown) or 4 (other), as these may be invalid or unnecessary
SELECT payment_type, COUNT(*) AS count
FROM uber
GROUP BY payment_type;


-- Remove rows where the payment type is either 3 (unknown) or 4 (other), as these may be invalid or unnecessary
DELETE FROM uber
WHERE payment_type IN (3, 4);


-- Add a new column to label payment types as 'Credit Card', 'Cash', or 'Others'
ALTER TABLE uber ADD COLUMN payment_type_label VARCHAR(20);


-- Update the 'payment_type_label' column based on the payment type value
UPDATE uber
SET payment_type_label = 
    CASE 
        WHEN payment_type = 1 THEN 'Credit Card'
        WHEN payment_type = 2 THEN 'Cash'
        ELSE 'Others'
    END;



-- Retrieve the updated 'uber' table to confirm all changes have been applied
SELECT * FROM Analysis.uber;



-- ANALYSIS AND INSIGHTS:

-- How much revenue is generated per passenger on average?

SELECT 
  AVG(total_amount / NULLIF(passenger_count, 0)) AS revenue_per_passenger
FROM uber;


-- What is the revenue trend by payment type (e.g., Cash vs Card)?

SELECT 
  payment_type_label,
  SUM(total_amount) AS payment_revenue,
  (SUM(total_amount) / (SELECT SUM(total_amount) FROM uber)) * 100 AS revenue_percentage
FROM uber
GROUP BY payment_type_label;



-- How do tips contribute to the overall revenue structure?

SELECT 
  SUM(tip_amount) AS total_tips,
  SUM(total_amount) AS total_revenue,
  (SUM(tip_amount) / SUM(total_amount)) * 100 AS tip_percentage
FROM uber;


-- Are extra charges (tolls, surcharges, etc.) significantly impacting total fare?

SELECT 
  (SUM(extra + tolls_amount + mta_tax + improvement_surcharge) / SUM(total_amount)) * 100 AS extra_charge_ratio
FROM uber;



-- What is the average speed per trip, and what factors impact it?

WITH HourlyAverages AS (
  SELECT 
    HOUR(tpep_pickup_datetime) AS pickup_hour,
    AVG(trip_distance) AS avg_trip_distance,
    AVG(TIMESTAMPDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime)) AS avg_trip_duration,
    AVG((trip_distance / NULLIF(TIMESTAMPDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime), 0)) * 60) AS avg_speed_kmph
  FROM uber
  GROUP BY HOUR(tpep_pickup_datetime)
)

SELECT 
  AVG(avg_trip_distance) AS overall_avg_trip_distance,
  AVG(avg_trip_duration) AS overall_avg_trip_duration,
  AVG(avg_speed_kmph) AS overall_avg_speed_kmph
FROM HourlyAverages;


-- What is the average distance traveled per trip 

SELECT 
  AVG(trip_distance) AS avg_trip_distance
FROM uber



-- What are the peak hours for pickups and drop-offs?

SELECT 
  HOUR(tpep_pickup_datetime) AS pickup_hour,
  COUNT(*) AS total_trips
FROM uber
GROUP BY HOUR(tpep_pickup_datetime)
ORDER BY total_trips DESC
LIMIT 5;


    

-- How does tip behavior vary based on payment type?


SELECT 
    payment_type_label,
    ROUND(AVG(tip_amount), 2) AS avg_tip
FROM 
    uber
GROUP BY 
    payment_type_label
ORDER BY 
    avg_tip DESC;
    
    
-- What is the tipping trend across different trip distances?

SELECT 
    CASE 
        WHEN trip_distance < 1 THEN '0-1 miles'
        WHEN trip_distance BETWEEN 1 AND 3 THEN '1-3 miles'
        WHEN trip_distance BETWEEN 3 AND 6 THEN '3-6 miles'
        WHEN trip_distance BETWEEN 6 AND 10 THEN '6-10 miles'
        ELSE '10+ miles'
    END AS distance_bucket,
    ROUND(AVG(tip_amount), 2) AS avg_tip
FROM 
    uber
GROUP BY 
    distance_bucket
ORDER BY 
    distance_bucket;
    
    
-- What is the average fare per passenger for different passenger counts?
    
SELECT 
    passenger_count,
    ROUND(AVG(fare_amount / passenger_count), 2) AS avg_fare_per_passenger
FROM 
    uber
WHERE 
    passenger_count > 0
GROUP BY 
    passenger_count
ORDER BY 
    passenger_count;
    
    
    
    
-- What is the total revenue generated

SELECT 
    SUM(total_amount) AS daily_revenue
FROM uber



-- What is the average trip fare per customer or per trip?

SELECT 
    AVG(fare_amount) AS average_fare
FROM uber;



-- What is the average tip per trip and tip percentage?

SELECT 
    AVG(tip_amount) AS avg_tip,
    AVG((tip_amount / NULLIF(fare_amount, 0)) * 100) AS avg_tip_percentage
FROM uber;



-- What is the average trip distance and duration?


SELECT 
    AVG(trip_distance) AS avg_distance,
    AVG(TIMESTAMPDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime)) AS avg_duration_min
FROM uber;



-- What is the revenue per mile?

SELECT 
    SUM(total_amount) / NULLIF(SUM(trip_distance), 0) AS revenue_per_mile
FROM uber;


-- What is the average number of passengers per trip?

SELECT 
    AVG(passenger_count) AS avg_passenger_count
FROM uber;

-- What is the average fare per minute and per mile?

SELECT 
    AVG(fare_amount / NULLIF(TIMESTAMPDIFF(MINUTE, tpep_pickup_datetime, tpep_dropoff_datetime), 0)) AS fare_per_min,
    AVG(fare_amount / NULLIF(trip_distance, 0)) AS fare_per_mile
FROM uber;


-- What is the percentage contribution of tips to total revenue?

SELECT 
    (SUM(tip_amount) / NULLIF(SUM(total_amount), 0)) * 100 AS tip_contribution_percentage
FROM uber;



SELECT * FROM Analysis.uber;