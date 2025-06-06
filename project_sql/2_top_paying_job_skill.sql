/* From the previous query we got top 10 paying data analyst jobs
- what are the top skills inside these top 10 paying jobs, the most common ones

Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst job from first query
- Add the specific skills required for there roles
- Why? it provides a detailed look at which high-paying jobs demand certain skills, helping job seekers undetstand which skills to develop taht align with top salaries
*/

WITH top_paying_jobs AS
    (SELECT
        job_id,
        job_title,
        salary_year_avg,
        company_dim.name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_work_from_home = true AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10)

SELECT
    top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC





/* FOR SECOND JOIN
skill_id = 0
after first JOIN = 8
skills_dim =  1

after first JOIN = 66 rows
skills_dim num of rows = 259 rows


/* FOR FIRST JOIN
job_id = 552322
top_paying_jobs = 1 rows
skills_job_dim = 13 rows
INNER JOIN  = 13 rows
 */




