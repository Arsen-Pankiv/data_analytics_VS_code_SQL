/*
Question: What are the top+paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are avaialble remotely.
- Focuses on job postings with specified salaries (remove nulls.)
- Moreover, job_postings_fact doesn't have company name only company ID but company_dim table has both, let's add company name as well
- Why ? Highligh the top-paying opportunities for Data Analysts, offering some useful the insights.
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    job_postings_fact.company_id,
    company_dim.name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
