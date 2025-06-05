/* Question: what are the most in demand skills?
-  Join job postings to inner job table similar to query 2
- identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- why ? retrieves the top 5 skills with the highest demand in the job market.
*/


SELECT 
    skills_dim.skills AS skill_name,
    COUNT(skills_job_dim.job_id) AS num_of_postings
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND job_location = 'Anywhere'
GROUP BY
    skills_dim.skills
ORDER BY
    num_of_postings DESC
LIMIT 5



