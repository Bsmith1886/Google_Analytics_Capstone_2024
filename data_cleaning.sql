--Now that I have explored what is in my dataset in can clean it and prepare it for analysis. 

--I am choosing NOT to remove Null Values from my dataset since we have full information for some datapoints and not others, and since the missing values represent a large and poentially valuable subset of the data

--Creating a new table with calculated ride duration in minutes

CREATE TABLE IF NOT EXISTS `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024.cleaned` AS
SELECT 
  *,
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
  END AS month,
  EXTRACT(YEAR FROM started_at) AS year,
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS duration_in_minutes
FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024`;



--Created view with day and month ordering, and filtered out weird durations

CREATE VIEW `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024_cleaned` AS

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

FROM `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024_durations`
WHERE duration_in_minutes > 1
  AND duration_in_minutes < 1440;

--Checking the number of rows excluded from the cleaned data by removing ride_durations less than one minute and more than one day

SELECT 
 (SELECT count(*) from `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024_cleaned`) as cleaned_count, -- total rows 12,506,555
  (select count(*)from `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024_durations`) as raw_count, --total rows 1,308,1836
  (select count(*) from
  `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024_durations`) - (select count(*) from `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024_cleaned`); --total Difference 356,307

--set ride id as primary key

ALTER TABLE `coursera-project-1-409719.Bicycle_Data_Coursera_Project.bicycyle_data_2022_2023_2024_durations` 
ADD PRIMARY KEY(ride_id) not enforced


