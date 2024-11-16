# Google_Analytics_Capstone_2024

## Background - Business Task

A rideshare company in Chicago wishes to analyze how their customers use their products. They are looking to understand how casual and annual members use their services differently so they can convert casual riders to members. 

The company has provided customer data in CSV format going back several years. We will review data from Jan 2022 - April 2024. 

## Data Exploration

The data provided was in a series of CSV files each with varying amounts of data. Some of the files were too large to upload directly into bigquery, and first had to be uploaded to Google Cloud Storage. Once uploaded i was able to easily import them into a single bigquery table. 

Now that the files are loaded into Bigquery, I will use SQL to Explore the data. 

We have a total of 13,081,836 observations. The date range of the data is 1-1-2022 Through 5/30/2024. 

The Table schema is as follows:

![image](https://github.com/user-attachments/assets/d18e1b87-c1c1-4165-b4e4-b36f34a6e505)



### Locating Rows with null values

There are a total of 3,111,981 rows with at least one null value. This represents about 25% of our observations which is a very significant number. Next I will explore these observiations with missing data in more detail to see if there are any patterns in the missing data. 

I counted the number of null values in each column and found that most of the missing values are from start station and end station information, as well as end station location (latitude).   

![image](https://github.com/user-attachments/assets/a54d6879-7dea-47b2-8da7-7366b40ade68)


There appear to be missing location information for observations throughout the data. The date range of observation with null values is the same as for the data itself. 

Since most of the missing data is in the location information there is still usable duration information for the those rows with null values, I am choosing NOT to remove them from the dataset. SQL will simply ignore these values when calculating totals and averages so there is no risk to biasing the data with null values. Indeed, exporing the data with null values may lead us to some areas where data collection can be improved or where our metrics are not adequately measuring consumer behavior.

### Checking for duplicates

ride_id is the primary key of this dataset, meaning all values should be unique. I checked this column for duplicates and found that there were none. There are also 0 null values in this column.

### Reviewing the values of the columns

There are two columns with date and time information, they are both in the format YYYY-MM-DD HH:MM:SS UTC. 

There are 2119 unique values for start_station_name. 

There are two values in the member_casual column, they are member and casual. 

## Data Cleaning

Since I am interested in the bahvaiors of the various types of riders, one possible differentiator will be how long members rent the bikes for. To calculate this, I created a view with a new column called ride_durations that calculates the duration of each rental in minutes. 

Since we are exploring the consumer behavior of a recreational activity, and we have good time and day inforamtion, I want to explore if there are any intersting patterns in day of the week or month of year usage that differentiate casual and member users. 

The next step will be creating a new table that has the following new colmns:
1. Day of Week
2. Month of Year
3. Year
4. Ride Duration in Minutes
The Table Schema for this new table is the following:
![image](https://github.com/user-attachments/assets/32eff7a4-fd97-4828-a831-624de58fd2ad)

At this point I have not yet removed any data from my dataset, I still have my original numeber of observations. I will now remove any data with any odd ride durations. Since we know the company only rents out bike for 1 day at a time, any rental that is more than one day should be removed. Similarly, any ride duration that is less than 1 minute should be removed. This will help to prevent these datapoint from creating biases in metrics like average and median durations. Since this table will only be used temporarily to do this particular analysis, I used a view to filter out these strange duration. The result was the removal of 575,281, which represents 4.3% of our data. This is not an insignificant number. While it is not a part of this analysis it would be wise to investigate where those obvservations are originating from. 



The company only rents bikes for the day, so next I will review to see if there are any strange durations that should be removed. When I created my new clean table I removed any rider durations that were less than 1 min or more than 24 hours. I also set ride_id is the primary key (not enforced). 

Once this was complete my clean data table had a total of 7,867,554 observations. 

##




