# Exploratory Data Analysis

SELECT *
FROM layoffs_new2;

# View the Maximum total laid off and maximum percentage laid off

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_new2;

#Let's view companies that have the maximum percentage laid off as 100%

SELECT *
FROM layoffs_new2
WHERE percentage_laid_off = 1;

#Let's sort companies by the total_laid_off, starting from the highest

SELECT *
FROM layoffs_new2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

#Let's sort companies by the funds raised, starting from the highest

SELECT *
FROM layoffs_new2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

# Let's view companies with the total staff laid off across all locations, starting from highest
SELECT company, SUM(total_laid_off)
FROM layoffs_new2
GROUP BY company
ORDER BY 2 DESC;

#View the date ranges for the data

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_new2;

#View the industry that got hit the most during the layoffs

SELECT industry, SUM(total_laid_off)
FROM layoffs_new2
GROUP BY industry
ORDER BY 2 DESC;

#View the country that got hit the most during the layoffs

SELECT country, SUM(total_laid_off)
FROM layoffs_new2
GROUP BY country
ORDER BY 2 DESC;

#View the date where the most layoffs happened

SELECT `date`, SUM(total_laid_off)
FROM layoffs_new2
GROUP BY `date`
ORDER BY 2 DESC;

#View the year where the most layoffs happened

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_new2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;

#View the stage of the company that experienced the most layoffs

SELECT stage, SUM(total_laid_off)
FROM layoffs_new2
GROUP BY stage
ORDER BY 2 DESC;

#View the monthly progression of total layoffs - Rolling total

SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_new2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_roll
FROM layoffs_new2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1
)
SELECT `MONTH`, total_roll, SUM(total_roll) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;

#View the company, the year and the total laid off staff

SELECT company, YEAR(`date`) AS `YEAR`, SUM(total_laid_off)
FROM layoffs_new2
WHERE YEAR(`date`) IS NOT NULL
GROUP BY company, `YEAR`
ORDER BY 1;

#View the rank of companies with the highest layoffs
#filter the ranking by years

WITH Company_Year (Company, Years, Total_laid_off) AS
(
SELECT company, YEAR(`date`) AS `YEAR`, SUM(total_laid_off)
FROM layoffs_new2
WHERE YEAR(`date`) IS NOT NULL
GROUP BY company, `YEAR`
), Company_Year_Rank AS
(
SELECT *, DENSE_RANK() OVER(PARTITION BY Years ORDER BY Total_laid_off DESC) AS Ranking
FROM Company_Year
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;