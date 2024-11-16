--Exploring how Members vs Casual users use the service

--Types of bikes used by membership type, and average duration

SELECT member_casual, rideable_type, COUNT(*) AS total_trips, avg(duration_in_minutes) as average_duration
 FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024_cleaned` 
 GROUP BY member_casual, rideable_type
 ORDER BY member_casual, total_trips;

--Average duration by membership type

SELECT member_casual, avg(duration_in_minutes) as average_duration --Casual riders have a longer average usage
 FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024_cleaned` 
 GROUP BY member_casual;


--Member type by rides per month
SELECT member_casual, month, YEAR, count(ride_id) as total_rides
  FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024_cleaned`
  group by YEAR, month_order, month, member_casual
  order by year, month_order asc;

--Member type by Rides per day of weed
SELECT member_casual, day_of_week, count(ride_id) as total_rides,
  FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024_cleaned`
  group by day_order, day_of_week,member_casual
  order by day_order asc;

--Member type by rides per week and month, average duration and median duration

SELECT member_casual, day_of_week, month, YEAR, count(ride_id) as total_rides, avg(duration_in_minutes) as average_duration, APPROX_QUANTILES(duration_in_minutes, 2)[OFFSET(1)] AS median_duration
  FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024_cleaned`
  group by YEAR, month, day_order, day_of_week,member_casual
  order by year, month, day_order asc;

--Comparing average to median rides times to determine if data is skewed. Data appears to be skewed right. Average ride durations are higher than median. 

SELECT member_casual, count(ride_id) as total_rides, avg(duration_in_minutes) as average_duration, APPROX_QUANTILES(duration_in_minutes, 2)[OFFSET(1)] AS median_duration
  FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024_cleaned`
  group by member_casual;




