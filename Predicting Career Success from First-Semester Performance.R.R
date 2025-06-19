# Load required packages
library(tidyverse)

# Read data
df <- read_csv("education_career_success.csv")

# a. Rename columns
colnames(df) <- colnames(df) %>%
  str_trim() %>%
  str_replace_all(" ", "_") %>%
  tolower()

# b. Handle missing values
colSums(is.na(df))  # Check missing

# Drop rows with NAs (optional: could impute instead)
df <- df %>% drop_na()

# c. Correct data types
df <- df %>%
  mutate(
    gender = as.factor(gender),
    field_of_study = as.factor(field_of_study),
    current_job_level = as.factor(current_job_level),
    entrepreneurship = as.factor(entrepreneurship)
  )

# d. No columns removed, all relevant
# e. Clean strings
levels(df$field_of_study) <- str_to_title(levels(df$field_of_study))

# f. Create education level
df <- df %>%
  mutate(education_level = cut(university_gpa,
                               breaks = c(0, 2.5, 3.0, 3.5, 4.0),
                               labels = c("Low", "Moderate", "Good", "Excellent"),
                               include.lowest = TRUE))

# g. Reorder levels
levels(df$education_level) <- c("Low", "Moderate", "Good", "Excellent")

summary(df %>%
          select(starting_salary, career_satisfaction, university_gpa,
                 internships_completed, certifications,
                 soft_skills_score, networking_score, job_offers))

  
# Scatter plot: GPA vs Salary
ggplot(df, aes(x = university_gpa, y = starting_salary)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "GPA vs Starting Salary") +
  theme_minimal()

# Bar chart: Salary by internships
df %>%
  group_by(internships_completed) %>%
  summarise(avg_salary = mean(starting_salary)) %>%
  ggplot(aes(x = factor(internships_completed), y = avg_salary)) +
  geom_col(fill = "steelblue") +
  labs(title = "Avg Salary by Internships Completed", x = "Numbers of Internships Completed", y = "Salary") +
  theme_minimal()

# Avg Salary by Field
df %>%
  group_by(field_of_study) %>%
  summarise(avg_salary = mean(starting_salary)) %>%
  ggplot(aes(x = reorder(field_of_study, avg_salary), y = avg_salary)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Average Starting Salary by Field of Study", x = "Field", y = "Salary (USD)") +
  theme_minimal()
# Avg Job Offers by Field
df %>%
  group_by(field_of_study) %>%
  summarise(avg_offers = mean(job_offers)) %>%
  ggplot(aes(x = reorder(field_of_study, avg_offers), y = avg_offers)) +
  geom_col(fill = "salmon") +
  coord_flip() +
  labs(title = "Average Job Offers by Field of Study", x = "Field", y = "Job Offers") +
  theme_minimal()

# Heatmap: Field vs Satisfaction
heat_data <- df %>%
  group_by(field_of_study) %>%
  summarise(avg_satisfaction = mean(career_satisfaction))

ggplot(heat_data, aes(x = "", y = reorder(field_of_study, avg_satisfaction), fill = avg_satisfaction)) +
  geom_tile() +
  scale_fill_gradient(low = "lightyellow", high = "blue") +
  labs(title = "Satisfaction by Field of Study", y = "Field", x = "") +
  theme_minimal()

# Scatter: Soft Skills vs Satisfaction
ggplot(df, aes(x = soft_skills_score, y = career_satisfaction)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "lm", color = "blue") +
  labs(title = "Soft Skills vs Career Satisfaction") +
  theme_minimal()

# Boxplot: Networking Score vs Promotion Time
df %>%
  mutate(network_group = cut(networking_score, breaks = c(0, 4, 7, 10), labels = c("Low", "Medium", "High"))) %>%
  ggplot(aes(x = network_group, y = years_to_promotion, fill = network_group)) +
  geom_boxplot() +
  labs(title = "Promotion Speed by Networking Score") +
  theme_minimal()

# Create new variables for grouping analysis
df <- df %>%
  mutate(
    soft_skill_group = cut(soft_skills_score, breaks = c(0, 4, 7, 10), labels = c("Low", "Medium", "High")),
    network_group = cut(networking_score, breaks = c(0, 4, 7, 10), labels = c("Low", "Medium", "High"))
  )

# Group and summarize: Average salary and satisfaction by education level
df %>%
  group_by(education_level) %>%
  summarise(avg_salary = mean(starting_salary), avg_satisfaction = mean(career_satisfaction))

# Rank fields by salary and satisfaction
df %>%
  group_by(field_of_study) %>%
  summarise(avg_salary = mean(starting_salary), avg_satisfaction = mean(career_satisfaction)) %>%
  arrange(desc(avg_salary))

# Count distribution of job levels
df %>%
  count(current_job_level)

df %>%
  count(current_job_level) %>%
  ggplot(aes(x = reorder(current_job_level, n), y = n, fill = current_job_level)) +
  geom_col() +
  labs(title = "Distribution of Current Job Levels", x = "Job Level", y = "Count") +
  coord_flip() +
  theme_minimal()




