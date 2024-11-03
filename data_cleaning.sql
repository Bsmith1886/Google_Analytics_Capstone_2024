--Now that I have explored what is in my dataset in can clean it and prepare it for analysis. 

--I am choosing NOT to remove Null Values from my dataset since we have full information for some datapoints and not others, and since the missing values represent a large and poentially valuable subset of the data

--Creating a new view with calculated ride duration in minutes

Create View `lively-lock-439218-m3.Bicycle_data_2022_2023.ride_durations` AS
Select *,
  timestamp_diff(started_at,ended_at, MINUTE) as duration_in_minutes
FROM `lively-lock-439218-m3.Bicycle_data_2022_2023.bicycle_data`;


--Create new Table from view with day of week and day of month information and filtering out weird durations (less than 1 min and more than 1 day)

CREATE TABLE IF NOT EXISTS `lively-lock-439218-m3.Bicycle_data_2022_2023.cleaned` AS
(
  SELECT *,
    CASE EXTRACT(DAYOFWEEK FROM started_at)
      WHEN 1 THEN 'sunday'
      WHEN 2 THEN 'monday'
      WHEN 3 THEN 'tuesday'
      WHEN 4 THEN 'wednesday'
      WHEN 5 THEN 'thursday'
      WHEN 6 THEN 'friday'
      WHEN 7 THEN 'saturday'
    END AS day_of_week,
    CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'JAN'
      WHEN 2 THEN 'FEB'
      WHEN 3 THEN 'MAR'
      WHEN 4 THEN 'APR'
      WHEN 5 THEN 'MAY'
      WHEN 6 THEN 'JUN'
      WHEN 7 THEN 'JUL'
      WHEN 8 THEN 'AUG'
      WHEN 9 THEN 'SEP'
      WHEN 10 THEN 'OCT'
      WHEN 11 THEN 'NOV'
      WHEN 12 THEN 'DEC'
    END AS month
  FROM `lively-lock-439218-m3.Bicycle_data_2022_2023.ride_durations`
WHERE duration_in_minutes > 1 --filtering out ride durations less than one minute
  AND duration_in_minutes < 1440); --filtering out durations more than 1 day

--Checking the number of rows excluded from the cleaned data by removing ride_durations less than one minute and more than one day

SELECT 
 (SELECT count(*) from `lively-lock-439218-m3.Bicycle_data_2022_2023.cleaned`) as cleaned_count, --total rows 7,867,554
  (select count(*)from `lively-lock-439218-m3.Bicycle_data_2022_2023.bicycle_data`) as raw_count, --total rows 8,223,861
  (select count(*) from
  `lively-lock-439218-m3.Bicycle_data_2022_2023.bicycle_data`) - (select count(*) from `lively-lock-439218-m3.Bicycle_data_2022_2023.cleaned`); --total Difference 356,307

--set ride id as primary key

ALTER TABLE `lively-lock-439218-m3.Bicycle_data_2022_2023.cleaned` 
ADD PRIMARY KEY(ride_id) not enforced


