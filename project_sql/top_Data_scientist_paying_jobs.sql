
/*
What are the top_paying data scientist jobs?
- Identify the top 10 highest-paying data scientist roles that are available remotely
-focus on job postings with specified salaries (remove nulls)
-why? HighlightTHE top-paying opportunities for data scientists
*/


SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Scientist' 
    AND job_location = 'Anywhere'  
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;    

