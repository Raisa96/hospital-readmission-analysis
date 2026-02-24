-- Hospital Readmission Analysis (SQL)
-- Assumes you load data/hospital_readmissions.csv into a table named hospital_readmissions

-- 1) Overall 30-day readmission rate
SELECT
  AVG(CAST(readmitted_within_30_days AS FLOAT)) AS readmission_rate_30d
FROM hospital_readmissions;

-- 2) Readmission rate by primary diagnosis
SELECT
  primary_diagnosis,
  COUNT(*) AS admissions,
  AVG(CAST(readmitted_within_30_days AS FLOAT)) AS readmission_rate_30d
FROM hospital_readmissions
GROUP BY primary_diagnosis
ORDER BY readmission_rate_30d DESC;

-- 3) Readmission rate by discharge destination
SELECT
  discharge_destination,
  COUNT(*) AS admissions,
  AVG(CAST(readmitted_within_30_days AS FLOAT)) AS readmission_rate_30d
FROM hospital_readmissions
GROUP BY discharge_destination
ORDER BY readmission_rate_30d DESC;

-- 4) Readmission rate by age band
WITH age_bands AS (
  SELECT *,
    CASE
      WHEN age < 35 THEN '18-34'
      WHEN age < 50 THEN '35-49'
      WHEN age < 65 THEN '50-64'
      WHEN age < 80 THEN '65-79'
      ELSE '80+'
    END AS age_band
  FROM hospital_readmissions
)
SELECT
  age_band,
  COUNT(*) AS admissions,
  AVG(CAST(readmitted_within_30_days AS FLOAT)) AS readmission_rate_30d
FROM age_bands
GROUP BY age_band
ORDER BY age_band;

-- 5) Monthly trend
SELECT
  SUBSTR(admit_date,1,7) AS year_month,
  COUNT(*) AS admissions,
  AVG(CAST(readmitted_within_30_days AS FLOAT)) AS readmission_rate_30d
FROM hospital_readmissions
GROUP BY SUBSTR(admit_date,1,7)
ORDER BY year_month;

-- 6) High-risk cohort example: CHF + Emergency + SNF
SELECT
  COUNT(*) AS admissions,
  AVG(CAST(readmitted_within_30_days AS FLOAT)) AS readmission_rate_30d
FROM hospital_readmissions
WHERE primary_diagnosis = 'CHF'
  AND admission_type = 'Emergency'
  AND discharge_destination = 'SNF';
