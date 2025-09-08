


SELECT 
    first_quarter_job_postings.job_title_short,
    first_quarter_job_postings.job_location,
    first_quarter_job_postings.job_via,
    first_quarter_job_postings.job_posted_date :: DATE,
    first_quarter_job_postings.salary_year_avg
FROM first_quarter_job_postings
WHERE first_quarter_job_postings.salary_year_avg > 70000
AND first_quarter_job_postings.job_title_short = 'Data Analyst'
ORDER BY first_quarter_job_postings.salary_year_avg DESC;



-- Find job postings from the 1st quarter that have slary greater than 70k
-- combine job posting tables from the first quarter of 2023(jan-mar)
-- get job postings with an average slary > 70000