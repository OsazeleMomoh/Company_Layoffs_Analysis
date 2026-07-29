# Data Cleaning Practice

SELECT *
FROM layoffs;

#1. Remove Duplicates
#2. Standardize Data
#3. Examine Null or Blank Values
#4. Remove any unnecessary columns

#For best practice, create and perform cleaning processes on new tables

CREATE TABLE layoffs_new
LIKE layoffs;

SELECT *
FROM layoffs_new;

#Insert same values into newly created table

INSERT layoffs_new
SELECT *
FROM layoffs;

#1. Identifying Duplicates - using row number as identifier
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 
`date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_new;

#Create CTE to check for duplicates

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 
`date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_new
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

# Check individual rows to verify duplicates before deleting
 
SELECT *
FROM layoffs_new
WHERE company = 'Yahoo';

# Creating a new table for updates (deletes, updates, etc)

CREATE TABLE `layoffs_new2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` text,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

# Inserting values into layoffs_new2 table like layoffs_new

INSERT layoffs_new2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, 
total_laid_off, percentage_laid_off, `date`, stage, country, 
funds_raised_millions) AS row_num
FROM layoffs_new;

# Check if values where inserted correctly

SELECT *
FROM layoffs_new2;

# Deleting Duplicates - using delete statement

DELETE
FROM layoffs_new2
WHERE row_num > 1;

#2. Standardizing Data

# Trimming leading spaces for 'company' column

SELECT company, TRIM(company)
FROM layoffs_new2;

UPDATE layoffs_new2
SET company = TRIM(company);

#Maintaining uniformity in 'industry' column

SELECT DISTINCT industry
FROM layoffs_new2
ORDER BY 1;

SELECT *
FROM layoffs_new2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_new2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

#Maintaining uniformity in 'country' column

SELECT DISTINCT country
FROM layoffs_new2
ORDER BY 1;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_new2
ORDER BY 1;

UPDATE layoffs_new2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

#Standardizing 'date' column

SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_new2;

#Convert 'date' column from text to date and update table - Case statement

UPDATE layoffs_new2
SET `date`= CASE
	WHEN `date` LIKE '%/%/%'
	THEN STR_TO_DATE(`date`, '%m/%d/%Y')
    ELSE `date`
END;

#Modify 'date' column from string to date format - Additional verification

ALTER TABLE layoffs_new2
MODIFY COLUMN `date` DATE;

#Examining Null or Blank Values

#Since the raw data file is in .json, 
#we have to first update the string 'null' to mysql 'null' database values
#and then alter the individual columns to integer values

UPDATE layoffs_new2
SET total_laid_off = NULL
WHERE LOWER(total_laid_off) = 'NULL';

ALTER TABLE layoffs_new2
MODIFY COLUMN total_laid_off INT NULL;

UPDATE layoffs_new2
SET percentage_laid_off = NULL
WHERE LOWER(percentage_laid_off) = 'NULL';

ALTER TABLE layoffs_new2
MODIFY COLUMN percentage_laid_off INT NULL;

UPDATE layoffs_new2
SET funds_raised_millions = NULL
WHERE LOWER(funds_raised_millions) = 'NULL';

ALTER TABLE layoffs_new2
MODIFY COLUMN funds_raised_millions INT NULL;

SELECT *
FROM layoffs_new2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

#Update blank values to SQL null values for uniformity

UPDATE layoffs_new2
SET industry = NULL 
WHERE industry = ''
OR industry = 'NULL';

SELECT * 
FROM layoffs_new2
WHERE industry IS NULL;

#Check individual company columns to see if columns can be populated
SELECT *
FROM layoffs_new2
WHERE company LIKE 'Juul';

#Join statement to cross-reference populated and unpopulated data in industry column

SELECT *
FROM layoffs_new2 AS t1
JOIN layoffs_new2 AS t2
	ON t1.company = t2.company
	AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

#close-up view of both industry columns

SELECT t1.industry, t2.industry
FROM layoffs_new2 AS t1
JOIN layoffs_new2 AS t2
	ON t1.company = t2.company
	AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

#Update column with populated values
UPDATE layoffs_new2 AS t1
JOIN layoffs_new2 AS t2
	ON t1.company = t2.company
	AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

#4. Removing columns with unusable data

SELECT *
FROM layoffs_new2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

#Deleting unusable data
DELETE
FROM layoffs_new2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

#Check to verify data is deleted
SELECT *
FROM layoffs_new2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

#Deleting 'row_num' column
SELECT *
FROM layoffs_new2;

ALTER TABLE layoffs_new2
DROP COLUMN row_num;

#Check to verify data is deleted
SELECT *
FROM layoffs_new2;