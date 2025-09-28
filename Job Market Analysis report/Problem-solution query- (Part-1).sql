-- SELECT THE DATABASE
USE JOB 


-- VIEW THE DATA --
SELECT * FROM JOBS_DATA


-- ## DQL STATEMENTS ## --


-- 1. How many records does this table contain?

SELECT COUNT(*) AS records_count 
FROM JOBS_DATA 


-- 2. Does the data has duplicates ?

SELECT COUNT(*) AS total_records,
       COUNT(DISTINCT job_id) AS unique_jobs
FROM JOBS_DATA 


-- 3. List the top 5 companies and the number of exact job postings.

SELECT company_name, count(*)
FROM JOBS_DATA 
GROUP BY company_name, [description] 
HAVING COUNT(*) > 1


-- 4. LIST FIRST 6 FIELDS (COLUMNS) AND DESCRIPTION TOKENS FOR FIVE RANDOM ROWS

SELECT TOP 5
    [index],
    title,
    company_name,
    [location],
    via,
    [description],
    description_tokens
FROM JOBS_DATA 
ORDER BY NEWID();


/* 5. Average Standardized Salary by Schedule Type and Remote Status
What is the average salary_standardized for jobs, broken down by schedule_type and whether they are work_from_home or not?
Include only Full-time and Contract jobs for this analysis. */

SELECT schedule_type,
        CASE 
            WHEN work_from_home = 1 THEN 'Remote'
            ELSE 'On-Site'
        END AS work_location_type,
        ROUND(AVG(salary_standardized),0) Average_Standardized_Salary
FROM JOBS_DATA 
WHERE schedule_type IN ('Full-time', 'Contract')
GROUP BY schedule_type, work_from_home
ORDER BY 3 DESC




/* 6. Top Job Posting Sources by Total Standardized Salary Offered
Which three job posting sources (via) collectively represent the highest sum 
of standardized salaries (salary_standardized)?*/

SELECT TOP 1 VIA, 
       SUM(salary_standardized) Total_Standardized_Salary
FROM JOBS_DATA 
GROUP BY VIA
ORDER BY 2 DESC 



/* 7. Job Titles with the Highest Proportion of Remote Opportunities
List the top 5 job titles that have the highest proportion of 
work_from_home positions among all their postings. Consider only titles with at least 3 total postings.*/

SELECT TOP 5
    TITLE,
    CAST(SUM(CASE WHEN work_from_home = 1 THEN 1 ELSE 0 END) / COUNT(*) AS FLOAT)
FROM JOBS_DATA 
GROUP BY TITLE
HAVING COUNT(*) > 3
ORDER BY 2 DESC 



/* 8. Overall Average Standardized Salary for Hourly vs. Yearly Rates
Compare the overall average standardized salary (salary_standardized) 
for jobs listed as 'hourly' (salary_rate = 'hour') versus 'yearly' (salary_rate = 'year'). */

SELECT salary_rate, 
    ROUND(AVG(salary_standardized), 0) Avg_Standardised_Salary
FROM JOBS_DATA 
GROUP BY salary_rate 
ORDER BY 2 DESC;

SELECT distinct salary_rate FROM JOBS_DATA 



/* 9. Locations with a High Concentration of Specific Tech Jobs
Identify locations (excluding 'Remote') that containins "developer" AND ("frontend" or "backend")
in their description_tokens. Count how many such jobs each identified location has.*/

SELECT [location], count(*) Count_of_CloudEgineers
FROM JOBS_DATA 
WHERE work_from_home <> 1
AND description_tokens LIKE '%developer%'
AND (description_tokens LIKE '%frontend%' or description_tokens LIKE '%backend%')
GROUP BY [location] 




/* 10. Salary Comparison for Recently Posted Jobs
Compare the average salary_standardized for jobs posted in the last 7 days (relative to the 
date_time column, assuming date_time represents "now" for the data point) versus jobs posted earlier. */

SELECT CASE 
        WHEN posted_at >= DATEADD(DAY, -7, GETDATE()) THEN 'POSTED LAST 7 DAYS'
        ELSE 'POSTED EARLIER' 
        END AS Posting_Period,
        ROUND(AVG(salary_standardized), 0) Average_Salary
FROM JOBS_DATA 
GROUP BY 
CASE 
        WHEN posted_at >= DATEADD(DAY, -7, GETDATE()) THEN 'POSTED LAST 7 DAYS'
        ELSE 'POSTED EARLIER' 
END
ORDER BY 2 DESC ;

-------------------------------------------------------continuation in Part-2---------------------------------------------------------------------------