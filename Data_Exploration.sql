--Checking the date range of the data

SELECT MAX(started_at) AS `max date`, min(started_at) AS `min date`
FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024`;

--Checking total number of observations

select count(*)
FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024`;

--Checking for Columns with Null Values

--Count of Rows with a null value in any column --Returned  3,111,981 rows with at least one null value

select count(*)
FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024`
Where ride_id IS NULL
OR rideable_type IS NULL
OR started_at IS NULL
OR ended_at IS NULL
OR start_station_id IS NULL
OR start_station_name IS NULL
OR end_station_id IS NULL
OR start_lat IS NULL
OR start_lng IS NULL
OR end_lat IS NULL
OR member_casual IS NULL;

--Review of Rows with Missing Data. This syntax will give us all rows with at least one missing value so we can see which values are missing. 

select *
FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024`
Where ride_id IS NULL
OR rideable_type IS NULL
OR started_at IS NULL
Or ended_at IS NULL
OR start_station_id IS NULL
OR start_station_name IS NULL
OR end_station_id IS NULL
OR start_lat IS NULL
OR start_lng IS NULL
OR end_lat IS NULL
OR member_casual IS NULL;

--Exploring which colums are missing data. the below syntax will first count the total rows and then subtract the count of rows with a value in the specified column. the result is a table with a cound of null values from each column.

select count(*) - COUNT(ride_id) ride_id, --counts all rows and then subtracts the rows with a value in the specified column

 COUNT(*) - COUNT(rideable_type) rideable_type,
 COUNT(*) - COUNT(started_at) started_at,
 COUNT(*) - COUNT(ended_at) ended_at,
 COUNT(*) - COUNT(start_station_name) start_station_name,
 COUNT(*) - COUNT(start_station_id) start_station_id,
 COUNT(*) - COUNT(end_station_name) end_station_name,
 COUNT(*) - COUNT(end_station_id) end_station_id,
 COUNT(*) - COUNT(start_lat) start_lat,
 COUNT(*) - COUNT(start_lng) start_lng,
 COUNT(*) - COUNT(end_lat) end_lat,
 COUNT(*) - COUNT(end_lng) end_lng,
 COUNT(*) - COUNT(member_casual) member_casual

FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024`; 

--reviewing the date range of missing values

select max(started_at) started_at, min(started_at) started_at,
FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024`
Where ride_id IS NULL
OR rideable_type IS NULL
OR started_at IS NULL
Or ended_at IS NULL
OR start_station_id IS NULL
OR start_station_name IS NULL
OR end_station_id IS NULL
OR start_lat IS NULL
OR start_lng IS NULL
OR end_lat IS NULL
OR member_casual IS NULL;

--Checking for duplicates. Since ride_id is the primary key, each value must be unique. You can locate duplicate rows by first counting the number of Ride IDs and then checking to see if any are more than 1. 

select ride_id,
FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024`
group by ride_id
having count(*)>1;

--Exploring the values of each column to get a sense of the range of options

--How many different station names are there?

Select count(distinct start_station_name) start_station_name

FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024`; ---returns 2119 unique station names. 

--How many different member types are there?

Select count(distinct member_casual) member_type

FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024`; ---returns 2 unique member types. 

--What are they? 

Select distinct member_casual

FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024`; --Returns "member" and "casual"

--how many rideable_types are there?

Select count(distinct rideable_type) rideable_type

FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024`; --Returns 3 unique types. 

--What are they?

Select distinct rideable_type

FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024`; --Returns 3 unique values: electric_bike, classic_bike, docked_bike







