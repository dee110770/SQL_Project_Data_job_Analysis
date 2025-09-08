WITH first_quarter_job_postings AS (

    SELECT*
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
    )

SELECT 
    skills_job_dim.skill_id,
    skills_dim.type,
    first_quarter_job_postings.salary_year_avg
FROM first_quarter_job_postings
LEFT JOIN skills_job_dim ON skills_job_dim.job_id = first_quarter_job_postings.job_id
LEFT JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE first_quarter_job_postings.salary_year_avg > 70000
ORDER BY first_quarter_job_postings.salary_year_avg DESC;


--get corresponding skill and skill type for each job posting in q1
-- Include those without skills too
-- Look at skills and type of job with salary> 70000