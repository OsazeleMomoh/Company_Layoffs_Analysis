# Task 5: Company Layoffs Analysis (SQL)

This task entailed the analysis of employee layoff data of a number of companies for a consulting firm to provide their team with insights such as maximum total laid off, maximum percentage laid off, country and industry with most layoffs, month and year most layoffs happened, monthly, progression of total layoffs, etc to arrive at pointers for the companies involved in order to improve their business decisions. I used *SQL* for this task. I chose *SQL* for this task as this would be my first *SQL* project but this can be done using *R* and *Python* as well.

# Download Dataset and Project Files
- [Download Dataset (.csv)](https://github.com/OsazeleMomoh/Company_Layoffs_Analysis/blob/main/layoffs.csv)
- [Download Dataset (.json)](https://github.com/OsazeleMomoh/Company_Layoffs_Analysis/blob/main/layoffs.json)
- [Download Data Cleaning Project (SQL)](https://github.com/OsazeleMomoh/Company_Layoffs_Analysis/blob/main/Data%20Cleaning%20Project.sql)
- [Download EDA Project (SQL)](https://github.com/OsazeleMomoh/Company_Layoffs_Analysis/blob/main/EDA%20SQL%20Project.sql)

# Step 1: Prepare
In this step, we will identify and assess the features of our Layoffs dataset:
- It consists of 2361 rows of which 2360 are pure data and the other one row being the column headers.
- It consists of data recorded from year 2020 to year 2023.
- The data consists of 9 columns namely: company, location, industry, total_laid_off, percentage_laid_off, date, stage, country and funds_raised_millions
- The limitation is that the recent date point of our data is 2023, which is 3 years ago and as such, it is not current data. However, the data is quite comprehensive, original and reliable.

# Step 2: Process
In this step, we will process and clean our data with the help of SQL. I tried to import the data into MySQL in .csv format but I discovered that not all the rows were imported successfully (I got less than 600 rows) so I converted the dataset file to .json and imported that instead. The .json file imported the rows successfully without any errors. I have attached both file types of the dataset in this repository. Let's dive into processing our data for further analysis:

I normally follow this blueprint when cleaning data in SQL:
- Checking and removing duplicates
- Standardising the data for ease of reference
- Examine Null or Blank Values
- Removing unnecessary or unusable columns

# Step 3: Analyse
In this step, we explore the dataset to gain insights such as the company and year with the most laid off staff, maximum total laid off, maximum percentage laid off, country and industry with most layoffs, month and year most layoffs happened, monthly, progression of total layoffs, the rank of the companies and years with the highest layoffs, the stage of the company that experienced the most layoffs, companies sorted by funds raised. This would help my colleague in business intelligence, come up with a dashboard to aid the companies involved, in making effective business decisions. 

# Insights from Analysis
These are the insights realised from the exploration and analysis of the dataset:

- 
-
-
-
-

