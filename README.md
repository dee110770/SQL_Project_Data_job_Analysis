# Introduction
Dive into the data job market! Focusing on data analyst roles, this project explores top-paying jobs, In-demand skills, and where high demand meets high salary in data analytics.

SQL queries? Check them out here:[project_sql folder](/project_sql/)

# Background
Driven by a quest to navigate the data scientist job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills,streamlining others work to find optimal jobs.

Data hails from this [data site](/csv_files/). This [folder](/sql_load/) is packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data scientist jobs?

2. What skills are required for these top-paying jobs?

3. What skills are most in demand for data scientists?

4. Which skills are associated with higher salaries?

5. What are the most optimal skills to learn?

# Tools I used
For my deep dive into the data Scientist job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & Github:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each Query for this project aimed at investigating specific aspects of the data scientist job market. Here's how I approached each question:

### 1. Top Paying Data Scientist Jobs
To identify the highest-paying roles, I filtered data scientist positions by average yearly salary and location, focusing on remote jobs.This query highlights the high paying opportunities in the field.

``` sql
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
```

Here's the breakdown of the top data scientist jobs in 2023:
- **Salary Range:** Top 10 paying data scientist roles span from $300K–$550K indicating significant salary potential in the field
- **Diverse Employers:** Selby Jennings,Walmart, Reddit,Demandbase are among those offering high salaries,showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles from Data Scientist, Head of data science to Quant Researcher leading the pack.

## 💼 Top-Paying Data Scientist Roles

| Job Title                                          | Company            | Average Salary (USD) |
|---------------------------------------------------|---------------------|-----------------------|
| Staff Data Scientist/Quant Researcher              | Selby Jennings      | 550,000               |
| Staff Data Scientist - Business Analytics          | Selby Jennings      | 525,000               |
| Data Scientist                                     | Algo Capital Group  | 375,000               |
| Director Level - Product Management - Data Science | Teramind            | 320,000               |
| Distinguished Data Scientist                       | Walmart             | 300,000               |
| Head of Battery Data Science                       | Lawrence Harvey     | 300,000               |
| Principal Data Scientist                           | Storm5              | 300,000               |



2. ### Top Paying Data Scientist Skills

To uncover the most valuable technical skills in the data scientist job market, I filtered remote, full-time positions by average yearly salary. This query surfaces the tools and platforms most commonly associated with high-paying roles, offering insight into which skills drive compensation and career growth.

```
WITH top_paying_jobs AS (
  SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Scientist' 
    AND job_location = 'Anywhere'  
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10 
)  


SELECT 
  top_paying_jobs.*,
  skills
from top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id= skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```
Here's the breakdown of the skillset that is most rewarding in relation to the top paying data science roles:
- **Salary Concentration:** SQL & Python dominate the paying listings, appearing in multpile roles above $500k
- **Big data tools:** Like Spark, Hadoop and cassandra are tightly clusteres around $375k mark ideal for roles in data engineering or large scale analytics
- **Machine learning Stack:** Tensorflow,Pytorch,Keras,Scikit-learn,Datarobot all appear in roles around $320k, showing strong demand for deep learning and model deployment skills.
- **Cloud Platforms:** AWS,Azure,GCP are consistently tied to salaries above $300k, reinforcing their importance in scalable data workflows.

## 🚀 Top-Paying Data Science Skills (2023)

| Skill       | Average Salary (USD) |
|------------|------------------------|
| gdpr       | 217,738                |
| golang     | 208,750                |
| atlassian  | 189,700                |
| selenium   | 180,000                |
| opencv     | 172,500                |
| pytorch    | 171,250                |
| keras      | 165,000                |
| tensorflow | 162,500                |
| airflow    | 160,000                |
| tableau    | 158,750                |




3. ### Top demanding skills in Data science Industry
This analysis highlights the most in-demand skills for data science roles, with Python and SQL leading the pack. I used this insight to prioritize my learning roadmap and tailor my portfolio toward tools that consistently appear in high-value job listings.

```

SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id= skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Scientist'
    AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;   
```
Here's a breakdown of the most sought-after technical skills driving demand in the data science job market. These skills consistently appear in high-volume job listings, making them essential for professionals aiming to align with industry expectations and maximize career opportunities.

- **Python:** python is the clear leader essential for data wrangling, modeling, and automation.
- **SQL:** SQL remains foundational for querying and managing structured data.
- **R** R is still relevant, especially in statistical analysis and academic settings
- **Cloud & BI tools:** Sow strong demand, signaling the importance of cloud fluency & visual storytelling.

| Skill     | Demand Count |
|-----------|--------------|
| Python    | 10,390       |
| SQL       | 7,488        |
| R         | 4,674        |
| AWS       | 2,593        |
| Tableau   | 2,458        |


*Table showing demand for data science skills with Python, SQL, R, AWS, and Tableau listed on the y-axis. Python has the highest demand count, followed by SQL, R, AWS, and Tableau. The overall tone is informative, emphasizing the prominence of Python and SQL in the data science job market.*

4. ### Skills with highest salaries

This analysis highlights remote data scientist roles with valid salary data to identify the top-paying technical skills. This query reveals which tools consistently align with higher compensation across job listings.

```
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
```
Here is the breakdown of the technical skills that are very rewarding:

- **GDPR – $217,738** High demand for data privacy and compliance expertise, especially in regulated industries.

- **Golang – $208,750** Valued for backend development and high-performance data systems.

- **Atlassian – $189,700** Popular in enterprise environments for workflow and project management integration.

- **Selenium – $180,000** Used in automated testing and quality assurance for data-driven applications.

- **OpenCV – $172,500** Essential for computer vision tasks like image recognition and video analysis.

| **Skill**   | **Average Salary (USD)** |
|-------------|--------------------------|
| GDPR        | 217,738                  |
| Golang      | 208,750                  |
| Atlassian   | 189,700                  |
| Selenium    | 180,000                  |
| OpenCV      | 172,500                  |
| TensorFlow  | 170,000                  |
| Java        | 167,500                  |
| Docker      | 165,000                  |
| Kubernetes  | 162,500                  |
| Python      | 160,000                  |
| SQL         | 157,500                  |


*This table lists the top skills for data scientists in 2023 based on their average salary. The data provides insights into which technical skills are most valuable in the field of data science, helping professionals focus on key areas for career growth.*


5. ### Top Optimal Skills
This analysis examines remote data scientist roles with valid salary data to pinpoint the top-paying technical skills. The goal is to identify which tools and technologies consistently correspond to higher compensation across job listings.


```
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
```

| Rank | Skill      | Average Salary (USD) | Demand Count |
| ---- | ---------- | -------------------- | ------------ |
| 1    | C          | \$164,865            | 48           |
| 2    | Go         | \$164,691            | 57           |
| 3    | Qlik       | \$164,485            | 15           |
| 4    | Looker     | \$158,715            | 57           |
| 5    | Airflow    | \$157,414            | 23           |
| 6    | AWS        | \$155,000            | 52           |
| 7    | Snowflake  | \$155,400            | 18           |
| 8    | Tableau    | \$152,350            | 33           |
| 9    | PyTorch    | \$150,700            | 27           |
| 10   | TensorFlow | \$149,980            | 31           |


Here is the breakdown of High Demand vs. High Salary Skills

A few skills are both highly demanded and well-compensated:

- **Go** → 57 postings, $164,691

- **Looker** → 57 postings, $158,715

- **AWS** → 52 postings, $155,000

These are strategic skills that balance market demand and pay — ideal for career growth.

**High Salary vs. Low Demand Skills**

Some tools command high pay but have fewer job postings, making them niche yet valuable:

- **Qlik** → $164,485 (15 postings)

- **Airflow** → $157,414 (23 postings)

- **Snowflake** → $155,400 (18 postings)

Upskilling in these specialized tools can give a competitive salary edge despite lower demand.






# What I learned
Throughout this adventure, I've  managed to do a few things such as :
 - **Complex query:** Mastered the art of advance SQ, merging tables like a pro and wielding WITH clauses.
 - **Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
 - Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions
This project enhanced my SQL skills and provided valuable insights into the data scientist job market.The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data scientists can better position themselves in a competitive job market by focusing on high-demand, high-alary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data science.


