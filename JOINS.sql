--**left joint:**

SELECT
    job_postings.job_id,
    job_postings.job_title_short,
    job_postings.company_id,
    companies.name AS name

FROM job_postings_fact AS job_postings
LEFT JOIN company_dim AS companies ON job_postings.company_id = companies.company_id


/*
job_postings_fact:
company_id = 6156 = 43 rows

company_dim:
company_id = 6156 = 1

after left join:
company_id = 6156 = 43
*/

--number of rows of job_postings_fact: 787k of rows
-- numer of rows after LEFT JOIN: 787k of rows

--**right joint:**

SELECT
    job_postings.job_id,
    job_postings.job_title_short,
    job_postings.company_id,
    companies.name AS name

FROM job_postings_fact AS job_postings

RIGHT JOIN company_dim AS companies ON job_postings.company_id = companies.company_id

-- RIGHT JOIN: 787k of rows
/* 
what if we had more companoes listed in that 
company_dim table than in job_posting_facts in this case we can spot these inrregularities
*/



--**Inner join:**

SELECT
job_postings.job_id,
job_postings.job_title
FROM job_postings_fact AS job_postings

INNER JOIN skills_job_dim AS skills_to_job ON job_postings.job_id = skills_to_job.job_id


SELECT
job_postings.job_id,
job_postings.job_title,
skills_to_job.skill_id,
skills.skill
FROM job_postings_fact AS job_postings

INNER JOIN skills_job_dim AS skills_to_job ON job_postings.job_id = skills_to_job.job_id

INNER JOIN skills_dim AS skills ON skills_to_job.skill_id = skills.skill_id