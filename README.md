# Google_Analytics_Capstone_2024

## Background - Business Task

A rideshare company in Chicago wishes to analyze how their customers use their products. They are looking to understand how casual and annual members use their services differently so they can convert casual riders to members. 

The company has provided customer data in CSV format going back several years. We will review data from Jan 2023 - Jan 2024. 

## Data Exploration

The data provided was in a series of CSV files each with varying amounts of data. Some of the files were too large to upload directly into bigquery, and first had to be uploaded to Google Cloud Storage. Once uploaded i was able to easily import them into a single bigquery table. 

Now that the files are loaded into Bigquery, I will use SQL to Explore the data. 

We have a total of 8,223,861 observations. The date range of the data is 1-1-2022 Through 4/30/2024. 

The Tabele schema is as follows:

![image](https://github.com/user-attachments/assets/84d619a1-f03d-45cc-99a2-a1ccdee9370b)


### Locating Rows with null values

There are a total of 1,937,747 rows with at least one null value. This represents about 25% of our observations which is a very significant numnber. Next I will explore these observiations with missing data in more detail to see if there are any patterns in the missing data. 

I counted the number of null values in each column and found that most of the missing values are from start station and end station information, as well as end station location (latitude).   

![image](https://github.com/user-attachments/assets/93aaf79c-f413-4ce8-a21b-6813bf6bf709)

There appear to be missing location information for observations throughout the data. The date range of observation with null values is the same as for the data itself. 

### Checking for duplicates

ride_id is the primary key of this dataset, meaning all values should be unique. I checked this column for duplicates and found that there were none. 


