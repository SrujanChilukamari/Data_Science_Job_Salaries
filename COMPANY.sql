
# Create Database 
CREATE SCHEMA COMPANY;

# Use that Database 
USE COMPANY;

# LOAD DATASET -- COMPANY_DATA , JOB_DATA

SELECT * FROM COMPANY;  -- id, company_name
SELECT * FROM JOBS; -- id, work_year, experience_level, employment_type, job_title, salary, salary_currency, 
-- salary_in_usd, employee_residence, remote_ratio, company_location, company_size

-- Task 1:- Basic Analysis (Queries)

#1) What is the average salary for all the jobs in the dataset?
SELECT JOB_TITLE , ROUND(AVG(SALARY)) FROM JOBS ;

#2) What is the highest salary in the dataset and Which job role does it correspond to? 
SELECT JOB_TITLE , MAX(SALARY) FROM JOBS
GROUP BY 1 ;

#3) What is the average salary for Data Scientist in US?
SELECT JOB_TITLE , AVG(SALARY) FROM JOBS
WHERE JOB_TITLE = 'DATA SCIENTIST' AND COMPANY_LOCATION = 'US' ;

#4) What is the number of jobs available for each job title?
SELECT JOB_TITLE , COUNT(JOB_TITLE) FROM JOBS 
GROUP BY 1 ;

#5) What is the total salary paid for all Data Analyst jobs in DE(Location)?
SELECT JOB_TITLE , SUM(SALARY) FROM JOBS 
WHERE JOB_TITLE LIKE '%DATA ANALYST%' AND COMPANY_LOCATION = 'DE'
GROUP BY 1 ;

#6) What are the TOP 5 highest paying job titles and their corresponding average salaries?
SELECT JOB_TITLE , ROUND(AVG(SALARY)) FROM JOBS 
GROUP BY 1 
ORDER BY 2 DESC 
LIMIT 5 ;

#7) What is the Number of jobs available in each location?
SELECT COMPANY_LOCATION , COUNT(*) FROM JOBS 
GROUP BY 1 
ORDER BY 2 DESC ;

#8) What are the TOP 3 job titles that have the most jobs available in dataset?
SELECT JOB_TITLE , COUNT(*) FROM JOBS 
GROUP BY 1 
ORDER BY 2 DESC 
LIMIT 3 ;

#9) What is the average salary for Data Engineers in US?
SELECT JOB_TITLE , ROUND(AVG(SALARY)) FROM JOBS 
WHERE JOB_TITLE LIKE '%DATA ENGINEER%' AND COMPANY_LOCATION = 'US'
GROUP BY 1;

#10) What are the TOP 5 cities with the highest average salaries? 
SELECT COMPANY_LOCATION , ROUND(AVG(SALARY)) FROM JOBS 
GROUP BY 1 
ORDER BY 2 DESC 
LIMIT 5 ;


-- Task 2:- Moderate Analysis (Queries) 

#1) What is the average salary for each job title, and 
#What is the total number of jobs available for each job title? */
SELECT JOB_TITLE , AVG(SALARY) , COUNT(*) FROM JOBS 
GROUP BY 1 ;

#2) What are the TOP 5 job titles with the highest total salaries, and 
#What is the total number of jobs available for each job title? */
SELECT JOB_TITLE , SUM(SALARY) , COUNT(*) FROM JOBS 
GROUP BY 1 
ORDER BY 2 DESC ;

/* 3) What are the TOP 5 locations with the highest total salaries, and 
What is the total number of jobs available for each location? */
SELECT JOB_TITLE ,COMPANY_LOCATION , SUM(SALARY) , COUNT(*) FROM JOBS 
GROUP BY 1 ,2
ORDER BY 3 DESC  
LIMIT 5 ;

#4) What is the average salary for each job title in each location, and 
#What is the total number of jobs available for each job title in each location?
SELECT JOB_TITLE , COMPANY_LOCATION , AVG(SALARY) , COUNT(*) FROM JOBS 
GROUP BY 1 ,2 ;

#5) What is the average salary for each job title in each location, and 
#What is the percentage of jobs available for each job title in each location?
SELECT JOB_TITLE ,COMPANY_LOCATION, AVG(SALARY) , 
COUNT(*)*100 / (SELECT COUNT(*) FROM JOBS WHERE COMPANY_LOCATION = J.COMPANY_LOCATION ) AS JOB_PERCENTAGE FROM JOBS AS J
GROUP BY 1 , 2 ;

#6) What are the TOP 5 job titles with the highest average salaries, and 
#What is the total number of jobs available for each job title?
SELECT JOB_TITLE , ROUND(AVG( SALARY),0) , COUNT(*) FROM JOBS 
GROUP BY 1 
ORDER BY 2 DESC ;

#7) What is the average salary for each job title, and 
#What is the percentage of jobs available for each job title in the dataset?
SELECT JOB_TITLE , AVG(SALARY) , (COUNT(*) * 100 / ( SELECT COUNT(JOB_TITLE) FROM JOBS)) FROM JOBS
GROUP BY 1 ;

/* 8) What is the total number of jobs available for each year of experience, and 
What is the average salary for each year of experience? */
SELECT experience_level , COUNT(*) , AVG(SALARY) FROM JOBS 
GROUP BY 1 ;

#9) What are the job titles with the highest average salaries in each location?
SELECT JOB_TITLE , COMPANY_LOCATION , AVG(SALARY) FROM JOBS 
GROUP BY 1 ,2 
ORDER BY 3 DESC ;


-- Task 3:- Advance Analysis (Queries)

SELECT * FROM JOBS; -- id, work_year, experience_level, employment_type, job_title, salary,
--  salary_currency, salary_in_usd, employee_residence, remote_ratio, company_location, company_size
SELECT * FROM COMPANY ; -- id, company_name

#1) What are the TOP 5 job titles with the highest salaries, and 
#What is the name of the company that offers the highest salary for each job title?
 SELECT COMPANY_NAME , JOB_TITLE , MAX(SALARY)  FROM JOBS JOIN COMPANY USING (ID) 
 GROUP BY 1 , 2 
 ORDER BY 3 DESC 
 LIMIT 5 ;
 
#2) What is the total number of jobs available for each job title, and 
#What is the name of the company that offers the highest salary for each job title?
SELECT COMPANY_NAME , JOB_TITLE , COUNT(*) ,MAX(SALARY ) FROM JOBS JOIN COMPANY USING (ID) 
 GROUP BY 1 , 2
 ORDER BY 4 DESC ;
 
#3) What are the TOP 5 cities with the highest average salaries, and 
#What is the name of the company that offers the highest salary for each city?
SELECT COMPANY_NAME , COMPANY_LOCATION , ROUND(AVG(SALARY)) FROM JOBS JOIN COMPANY USING (ID)
GROUP BY 1,2
ORDER BY 3 DESC 
LIMIT 5 ;

#4) What is the average salary for each job title in each company, and 
#What is the rank of the each job title within each company based on the average salary?
SELECT JOB_TITLE ,COMPANY_NAME, AVG(SALARY) , RANK() OVER (PARTITION BY COMPANY_NAME ORDER BY AVG(SALARY)DESC)AS RANKK
 FROM JOBS JOIN COMPANY USING (ID)  GROUP BY 1,2 ;
 
#5) What is the total number of jobs available for each job title in each location,and 
#What is the rank of each job title within each location based on the total number of jobs?
SELECT JOB_TITLE , COMPANY_LOCATION , COUNT(*) , RANK() OVER (PARTITION BY COMPANY_LOCATION ORDER BY COUNT(*) DESC ) AS RANKK
FROM JOBS GROUP BY 1,2;

#6) What are the TOP 5 companies with highest average salaries for Data Scientist positions, and 
#What is the rank of each company based on the average salary?
SELECT COMPANY_NAME , JOB_TITLE , AVG(SALARY) , RANK() OVER (ORDER BY AVG(SALARY) DESC) AS RANKK
 FROM JOBS JOIN COMPANY USING (ID) WHERE JOB_TITLE LIKE '%Data Scientist%' 
 GROUP BY 1 , 2 
 LIMIT 5 ;
 
# 7) What is the total number of jobs available for each year of experience in each location, and 
#What is the rank of each year of experience within each location based on the total number of jobs?
SELECT JOB_TITLE , experience_level ,COMPANY_LOCATION , COUNT(*) , RANK() OVER (PARTITION BY COMPANY_LOCATION ORDER BY COUNT(*) DESC) AS RANKK
FROM JOBS JOIN COMPANY USING (ID)
GROUP BY  1 , 2 , 3


