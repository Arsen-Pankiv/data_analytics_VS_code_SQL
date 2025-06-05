/*  Question: What are the most optimal skills to learn (high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why ? Targets skills that offer job security (high demand) and financial benefits (high salaries)


*/


WITH top_demanded_jobs AS
    (SELECT
        skills_dim.skill_id,
        skills_dim.skills AS skill_name,
        COUNT(skills_job_dim.job_id) AS num_of_postings
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_postings_fact.salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY
        skills_dim.skill_id),top_paying_jobs AS
    (SELECT
        skills_dim.skill_id,
        skills_dim.skills AS skill_name,
        ROUND(AVG(job_postings_fact.salary_year_avg),0) AS salary_per_skill
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_postings_fact.salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY
        skills_dim.skill_id)

SELECT
    top_demanded_jobs.skill_id,
    top_demanded_jobs.skill_name,
    top_demanded_jobs.num_of_postings,
    top_paying_jobs.salary_per_skill

FROM top_demanded_jobs
INNER JOIN top_paying_jobs ON top_demanded_jobs.skill_id = top_paying_jobs.skill_id
WHERE
    top_demanded_jobs.num_of_postings > 15
ORDER BY
    top_paying_jobs.salary_per_skill DESC,
    top_demanded_jobs.num_of_postings DESC
LIMIT 25