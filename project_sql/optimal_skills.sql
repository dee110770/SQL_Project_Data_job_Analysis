/*
 what are the optimal skills to learn (its in high demand) 
- identify skills in high demand and associated with high average salaries for data analyst roles
 -Concentrate on remote positions with specified salaries
-why? target skills that offer security (high demand) and financial benefits 
*/

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact 
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Scientist' AND job_work_from_home = TRUE 
AND salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
HAVING  COUNT(skills_job_dim.job_id)  > 10
ORDER BY avg_salary DESC, demand_count DESC
LIMIT 20;
