/*
The top skills based on salary for my role
-- The top 5 skills according to the job postings
-- Roles with salaries(removve the nulls)
-- Get the average for the salaries

*/

SELECT 
    skills,
   ROUND(AVG(salary_year_avg), 0) as avg_salary
FROM job_postings_fact    
INNER JOIN skills_job_dim ON job_postings_fact.job_id= skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
WHERE salary_year_avg IS NOT NULL
AND job_title_short = 'Data Scientist'
AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25;

