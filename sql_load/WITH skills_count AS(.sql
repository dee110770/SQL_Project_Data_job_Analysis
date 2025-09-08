WITH skills_count AS(
    SELECT 
    skills_job_dim.skill_id,
    COUNT(skills_job_dim.skill_id) AS id_count
    FROM skills_job_dim 
    INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_job_dim.job_id
    GROUP BY skills_job_dim.skill_id
    ORDER BY id_count DESC
    LIMIT 5 
)     

SELECT 
    skills_dim.skills,
    skills_count.skill_id,
    skills_count.id_count
FROM skills_count
INNER JOIN skills_dim ON skills_count.skill_id= skills_dim.skill_id
ORDER BY skills_count.id_count DESC;


-- top 5 skills frequently mentioned in job postings
-- find skill ids with the highest counts in the skills-job-dim
-- join it to the skills-dim table to get skill names
