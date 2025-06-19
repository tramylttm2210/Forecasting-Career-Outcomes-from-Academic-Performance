# Education & Career Success Analysis

## Purpose  
To analyze a 5,000-record synthetic dataset of academic and career variables—identifying which early performance indicators most strongly predict salary, job offers, and satisfaction, and providing actionable insights for educators and career advisors.

---

## Tools & Packages  
- **Data cleaning:** `janitor`, `lubridate`, `dplyr`  
- **Visualization:** `ggplot2`  
- **Analysis:** Descriptive statistics, correlation analysis, linear regression  

---

## Project Overview  
Cleaned and profiled a 5,000-record dataset using R’s `summary()` and `glimpse()`, ensured data completeness, filtered outliers, and standardized variables to establish a reliable baseline.

---

## Exploratory Data Analysis  
- **Grade Distributions:** Histograms of first-semester GPA (most students clustered between 3.0–3.8)  
- **Experience vs. Salary:** Boxplots comparing internship counts to starting salary  
- **Correlation Mapping:** Scatterplots and heatmaps revealing which course grades correlate most with career metrics  

---

## Regression & Predictive Modeling  
- Built **simple linear regression** models to quantify how variations in early GPA forecast starting salary and career satisfaction  
- Generated **scatter plots with trend lines** to visualize predictive strength  

---

## Key Insights  
- **GPA & Internships:** Limited direct impact on starting salary—other factors (e.g., certifications, networking) may matter more  
- **Field of Study:** STEM majors (Math, Engineering) showed higher average salaries and offer counts  
- **Soft Skills & Networking:** No strong correlation with early career satisfaction or promotion speed  

---

## Forecasting Future Outcomes  
- **Extrapolated** GPA-salary relationship to estimate marginal impacts on income  
- **Predicted** that a 0.1-point boost in first-semester GPA could yield ~2–3% higher starting salary  
- **Projected** stability in career satisfaction across varying soft-skill levels  
**Insight:** Early, targeted academic support can produce measurable gains in long-term career readiness.
