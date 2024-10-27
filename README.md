# Google_Analytics_Capstone_2024

## Background - Business Task

A rideshare company in Chicago wishes to analyze how their customers use their products. They are looking to understand how casual and annual members use their services differently so they can convert casual riders to members. 

The company has provided customer data in CSV format going back several years. We will review data from Jan 2022 - April 2024. 

## Data Exploration

The data provided was in a series of CSV files each with varying amounts of data. Some of the files were too large to upload directly into bigquery, and first had to be uploaded to Google Cloud Storage. Once uploaded i was able to easily import them into a single bigquery table. 

Now that the files are loaded into Bigquery, I will use SQL to Explore the data. 

We have a total of 8,223,861 observations. The date range of the data is 1-1-2022 Through 4/30/2024. 

The Table schema is as follows:

![image](https://github.com/user-attachments/assets/84d619a1-f03d-45cc-99a2-a1ccdee9370b)


### Locating Rows with null values

There are a total of 1,937,747 rows with at least one null value. This represents about 25% of our observations which is a very significant number. Next I will explore these observiations with missing data in more detail to see if there are any patterns in the missing data. 

I counted the number of null values in each column and found that most of the missing values are from start station and end station information, as well as end station location (latitude).   

![image](https://github.com/user-attachments/assets/93aaf79c-f413-4ce8-a21b-6813bf6bf709)

There appear to be missing location information for observations throughout the data. The date range of observation with null values is the same as for the data itself. 

Since most of the missing data is in the location information there is still usable duration information for the those rows with null values, I am choosing NOT to remove them from the dataset. SQL will simply ignore these values when calculating totals and averages so there is no risk to biasing the data with null values. Indeed, exporing the data with null values may lead us to some areas where data collection can be improved or where our metrics are not adequately measuring consumer behavior.

### Checking for duplicates

ride_id is the primary key of this dataset, meaning all values should be unique. I checked this column for duplicates and found that there were none. There are also 0 null values in this column.

### Reviewing the values of the columns

There are two columns with date and time information, they are both in the format YYYY-MM-DD HH:MM:SS UTC. 

There are 2036 unique values for start_station_name. 

There are two values in the member_casual column, they are member and casual. 

## Data Cleaning

Since I am interested in the bahvaiors of the various types of riders, one possible differentiator will be how long members rent the bikes for. To calculate this, I created a view with a new column called ride_durations that calculates the duration of each rental in minutes. 

Since we are exploring the consumer behavior of a recreational activity, and we have good time and day inforamtion, I want to explore if there are any intersting patterns in day of the week or month of year usage that differentiate casual and member users. So the next step will be creating a new table with 2 new columns that have the day of the week and month of the year of the rental for each user. I will use the view with the ride durations to create this new table so that I have a single table with all the datapoints im interested in ananlyzing together. 




