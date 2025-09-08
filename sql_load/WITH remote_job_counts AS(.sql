WITH remote_job_counts AS(
SELECT 
    sj.skill_id,
    COUNT(jf.job_id) AS job_counts
FROM skills_job_dim sj
INNER JOIN job_postings_fact jf 
    ON sj.job_id = jf.job_id
WHERE jf.job_work_from_home = True
AND jf.job_title_short = 'Data Analyst'
GROUP BY sj.skill_id
)

SELECT 
    remote_job_counts.skill_id,
    skills_dim.skills,
    remote_job_counts.job_counts
FROM remote_job_counts
INNER JOIN skills_dim ON remote_job_counts.skill_id= skills_dim.skill_id
ORDER BY remote_job_counts.job_counts DESC
LIMIT 5;





-- Find the count of the number of remote job postingd per skill
-- Display the top 5 skills by their demand in remote jobs
-- Include skill ID, name, and count of postings requring the skill