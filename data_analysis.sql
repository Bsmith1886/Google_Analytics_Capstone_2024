--Exploring how Members vs Casual users use the service

--Types of bikes used by membership type, and average duration

SELECT member_casual, rideable_type, COUNT(*) AS total_trips, avg(duration_in_minutes) as average_duration
 FROM `lively-lock-439218-m3.Bicycle_data_2022_2023.cleaned` 
 GROUP BY member_casual, rideable_type
 ORDER BY member_casual, total_trips;

--Average duration by membership type

SELECT member_casual, avg(duration_in_minutes) as average_duration --Casual riders have a longer average usage
 FROM `lively-lock-439218-m3.Bicycle_data_2022_2023.cleaned` 
 GROUP BY member_casual;

--Creating a view with ordered month and days, extract year to its own Column

CREATE VIEW `lively-lock-439218-m3.Bicycle_data_2022_2023.week_ordered_view` as
SELECT *,
  CASE day_of_week
    WHEN 'sunday' THEN 1
    WHEN 'monday' THEN 2
    WHEN 'tuesday' THEN 3
    WHEN 'wednesday' THEN 4
    WHEN 'thursday' THEN 5
    WHEN 'friday' THEN 6
    WHEN 'saturday' THEN 7
  END AS day_order,

  case month
    WHEN 'JAN' THEN 1
    WHEN 'FEB' THEN 2
    WHEN 'MAR' THEN 3
    WHEN 'APR' THEN 4
    WHEN 'MAY' THEN 5
    WHEN 'JUN' THEN 6
    WHEN 'JUL' THEN 7
    WHEN 'AUG' THEN 8
    WHEN 'SEP' THEN 9
    WHEN 'OCT' THEN 10
    WHEN 'NOV' THEN 11
    WHEN 'DEC' THEN 12
  END AS month_order,
  Extract(year from started_at) as YEAR

 FROM `lively-lock-439218-m3.Bicycle_data_2022_2023.cleaned` 

--Member type by rides per month
SELECT member_casual, month, YEAR, count(ride_id) as total_rides
  FROM `lively-lock-439218-m3.Bicycle_data_2022_2023.week_ordered_view`
  group by YEAR, month_order, month, member_casual
  order by year, month_order asc;

--Member type by Rides per day of weed
SELECT member_casual, day_of_week, count(ride_id) as total_rides,
  FROM `lively-lock-439218-m3.Bicycle_data_2022_2023.week_ordered_view`
  group by day_order, day_of_week,member_casual
  order by day_order asc;

--Member type by rides per week and month, average duration and median duration

SELECT member_casual, day_of_week, month, YEAR, count(ride_id) as total_rides, avg(duration_in_minutes) as average_duration, APPROX_QUANTILES(duration_in_minutes, 2)[OFFSET(1)] AS median_duration
  FROM `lively-lock-439218-m3.Bicycle_data_2022_2023.week_ordered_view`
  group by YEAR, month, day_order, day_of_week,member_casual
  order by year, month, day_order asc;

--Comparing average to median rides times to determine if data is skewed. Data appears to be skewed right. Average ride durations are higher than median. 

SELECT member_casual, count(ride_id) as total_rides, avg(duration_in_minutes) as average_duration, APPROX_QUANTILES(duration_in_minutes, 2)[OFFSET(1)] AS median_duration
  FROM `lively-lock-439218-m3.Bicycle_data_2022_2023.week_ordered_view`
  group by member_casual;




