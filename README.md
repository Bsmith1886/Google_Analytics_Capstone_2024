# Google_Analytics_Capstone_2024

### Disclaimer

The following analysis was conducted using free tools (BigQuery and Tableau). As a result, the methods used are not the ones I would have chosen if I had access to enterprise-level data management tools. I was unable to connect Tableau directly to the database where the data was stored, and file limitations meant that the CSV exports had to be much smaller than I would have liked. Typically, I would connect directly to a database and perform many of the calculations in SQL or directly in visualization tools (in this case Tableau, but Power BI and Excel are equally capable of performing many of these calculations depending on the dataset size).  

That said, here we go.

## Background - Business Task

A rideshare company in Chicago wishes to analyze how their customers use their products. They aim to understand how casual and annual members use their services differently to convert casual riders into members.  

The company provided customer data in CSV format spanning several years. We will review data for 2023, since that is the last full year of data available. 

Quick Links:

Data Source: [Bicycle Trip Data](https://console.cloud.google.com/bigquery?ws=!1m4!1m3!3m2!1scoursera-project-1-409719!2sBicycle_Data_Coursera_Project)
 - Downloaded 11/16/2024
 - Accessed 11/23/2024

SQL Queries:

- [Data Exploration](https://github.com/Bsmith1886/Google_Analytics_Capstone_2024/blob/bdd38f9ca1368d188453e42c535ac4cf16ec04c6/Data_Exploration.sql)
- [Data Cleaning](https://github.com/Bsmith1886/Google_Analytics_Capstone_2024/blob/bdd38f9ca1368d188453e42c535ac4cf16ec04c6/data_cleaning.sql)
- [Data Analysis](https://github.com/Bsmith1886/Google_Analytics_Capstone_2024/blob/bdd38f9ca1368d188453e42c535ac4cf16ec04c6/data_analysis.sql)

Visualizations:

 - [Tableau Dashboards](https://public.tableau.com/views/GoogleCapstone-BicycleSharingCompanyAnalysis/UsagebyMemberType?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


## Data Exploration

The data was provided in a series of CSV files, each containing varying amounts of data. Some of the files were too large to upload directly into BigQuery and first had to be uploaded to Google Cloud Storage. Once uploaded, I could easily import them into a single BigQuery table.  

Now that the files are loaded into BigQuery, I will use SQL to explore the data.  

We have a total of 13,081,836 observations. The date range of the data is 1/1/2022 through 5/30/2024.  

The table schema is as follows:  

![image](https://github.com/user-attachments/assets/d18e1b87-c1c1-4165-b4e4-b36f34a6e505)

### Locating Rows with Null Values

Observations:

  1. There are a total of 3,111,981 rows with at least one null value. This represents about 25% of our observations, which is a very significant number.   
  Next, I will explore these observations with missing data in more detail to identify any patterns in the missing data.  
  
  2. Most of the missing values are from the start station and end station information, as well as the end station location (latitude).  
  
  ![image](https://github.com/user-attachments/assets/a54d6879-7dea-47b2-8da7-7366b40ade68)
  
  3. There appear to be missing location information for observations throughout the dataset. The date range of observations with null values matches the 
  overall dataset.  

Since most of the missing data is in the location information, there is still usable duration information for rows with null values. I am choosing NOT to remove them from the dataset. SQL will simply ignore these values when calculating totals and averages, so there is no risk of biasing the data with null values. Indeed, exploring the data with null values may lead us to areas where data collection can be improved or where our metrics are not adequately measuring consumer behavior.  

### Checking for Duplicates

 1. Primary Key = ride_id
 2. 0 Duplicates
 3. 0 Null Values


### Reviewing the Values of the Columns

  1.  2 columns with date and time information, both in the format `YYYY-MM-DD HH:MM:SS UTC`.
    a. started_at
    b. ended_at
  2. 2,119 unique values for `start_station_name`.
  3. 2 values in the `member_casual` column: `member` and `casual`.  

## Data Cleaning

Since I am interested in the behaviors of the different types of riders, one possible differentiator is how long members rent the bikes. To calculate this, I created a view with a new column called `ride_durations` that calculates the duration of each rental in minutes.  

Since we are exploring the consumer behavior of a recreational activity and have good time and day information, I want to explore if there are any interesting patterns in day-of-week or month-of-year usage that differentiate casual and member users.  

The next step will be creating a new table with the following new columns:  

1. Day of Week  
2. Month of Year  
3. Year  
4. Ride Duration in Minutes  

The table schema for this new table is as follows:  
![image](https://github.com/user-attachments/assets/32eff7a4-fd97-4828-a831-624de58fd2ad)

At this point, I have not yet removed any data from my dataset; I still have my original number of observations. Next, I will remove any data with odd ride durations. Since we know the company only rents out bikes for one day at a time, any rental lasting more than one day should be removed. Similarly, any ride duration shorter than one minute should also be removed. This will help prevent these data points from biasing metrics like average and median durations.  

Since this table will only be used temporarily for this particular analysis, I used a view to filter out these strange durations. The result was the removal of 575,281 observations, representing 4.3% of the data. This is not an insignificant number. While not a part of this analysis, it would be wise to investigate where those observations are originating from.  

After filtering, my clean data table had a total of 12,506,555 observations.

## Analysis






