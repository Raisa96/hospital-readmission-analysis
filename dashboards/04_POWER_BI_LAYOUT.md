# Power BI Dashboard Layout — Hospital Readmissions

## Page 1: Executive Overview
**Top KPIs (cards)**
- Readmission Rate (30d)
- Admissions
- Avg LOS
- % Emergency Admissions

**Visuals**
1. Line chart: Readmission Rate by Month (Year-Month)
2. Bar chart: Readmission Rate by Primary Diagnosis
3. Bar chart: Readmission Rate by Discharge Destination
4. Histogram or column chart: Readmission Rate by Age Band
5. Table: High-risk cohort (filterable)

**Slicers**
- Year-Month
- Primary Diagnosis
- Admission Type
- Insurance
- Discharge Destination

## Recommended DAX Measures
```DAX
Admissions = COUNTROWS(hospital_readmissions)

Readmission Rate 30d = AVERAGE(hospital_readmissions[readmitted_within_30_days])

Avg LOS = AVERAGE(hospital_readmissions[length_of_stay_days])

Emergency % =
DIVIDE(
    CALCULATE(COUNTROWS(hospital_readmissions), hospital_readmissions[admission_type] = "Emergency"),
    COUNTROWS(hospital_readmissions)
)

Readmissions Count =
CALCULATE(COUNTROWS(hospital_readmissions), hospital_readmissions[readmitted_within_30_days] = 1)
```

## Notes
- Create a calculated column `Year-Month` from `admit_date` for trending.
- Use conditional formatting in the table to highlight high-risk.
