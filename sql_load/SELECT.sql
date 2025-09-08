SELECT 
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM (job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York')) AS month
FROM  
    job_postings_fact 
WHERE  
    EXTRACT(YEAR FROM (job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York'))= 2023   
    
GROUP BY
    month
ORDER BY
    month ASC;




  








-- count the number of job_postings for each month in 2023
-- adjust the job_posted_date to be in america/newyork time zone
-- assuming job_posted_date is stored in utc
-- group by and order by month