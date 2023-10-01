'''
==================================================================

TASK

You are a Data Scientist who works for the Ministry of Law 
and Human Rights in a department that deals with patent archives. 
Your supervisor wants to see the cumulative number of patents 
related to cancer on an annual basis in the ministry database with 
condition :

- the patent was registered in 2012 to 2023
- the patent contains the keyword "data mining"

Display the cumulative number of patents sorted by largest year and smallest month.

==================================================================

DATA

To answer this question, you will use dataset from Google BigQuery.

1. Log in to Google Cloud Console and select Google BigQuery.
2. In the Google BigQuery search bar, please type “patents”. You will see the 
result as shown beside.
3. Under patents-public-data, you will use dataset with name uspto_oce_cancer 
and table publications.

==================================================================

Submission

1. Create a file to store your answers. This file can have extension .sql or .txt.
2. Save this assignment with filename : h8dsft_ngc_data_wrangling_in_sql.sql.
3. Push your answer into your own GitHub repository.

==================================================================
'''

-- QUERRY HERE

SELECT
  year,
  month,
  COUNT(Patent_Title) AS total_patent
FROM (
  SELECT
    LEFT(Grant_or_Publication_Date, 4) AS year,
    IF(SUBSTR(Grant_or_Publication_Date, 5, 1) = '0',
      SUBSTR(Grant_or_Publication_Date, 6, 1),
      SUBSTR(Grant_or_Publication_Date, 5, 2)
    ) AS month,
    Patent_Title
  FROM `patents-public-data.uspto_oce_cancer.publications`
  WHERE
    Patent_Title LIKE '%data mining%'
    AND CAST(LEFT(Grant_or_Publication_Date, 4) AS INT64) >= 2012
)
GROUP BY
  year,
  month
ORDER BY
  year DESC,
  month DESC;