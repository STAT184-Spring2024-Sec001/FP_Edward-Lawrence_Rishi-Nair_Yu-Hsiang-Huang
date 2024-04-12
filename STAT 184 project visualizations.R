library(readr)  # for read_csv, which is faster than read.csv
library(dplyr)
library(ggplot2)
library(forcats) 
# Reading the data from the CSV file
file_path <- "C:/Users/Ivan9/Downloads/Crash_Reporting_-_Drivers_Data.csv"  # Update with your actual file path
crash_data <- read_csv(file_path)

# Displaying the structure of the dataset to confirm the names of the columns
str(crash_data)

# Extracting the 'Speed limit' and 'Injury Severity' columns
selected_data <- crash_data %>%
  select(`Speed Limit`, `Injury Severity`)  # Ensure these column names match your CSV exactly

# Display the first few rows of the extracted data
head(selected_data)

# Creating a histogram of crashes by speed limit
ggplot(selected_data, aes(x = `Speed Limit`)) +  # Make sure `Speed Limit` matches the column name in your dataset
  geom_histogram(bins = 20, fill = "blue", color = "black") +
  labs(title = "Histogram of Crashes by Speed Limit",
       x = "Speed Limit (mph)",
       y = "Number of Crashes") +
  theme_minimal()

# First, we count the number of occurrences of each injury severity for each speed limit
selected_data_summary <- crash_data %>%
  count(`Speed Limit`, `Injury Severity`) %>%
  mutate(`Injury Severity` = factor(`Injury Severity`, levels = c("NO APPARENT INJURY", "POSSIBLE INJURY", "SUSPECTED MINOR INJURY", "SUSPECTED SERIOUS INJURY", "FATAL INJURY")))

# Now we can create a stacked bar chart
ggplot(selected_data_summary, aes(x = factor(`Speed Limit`), y = n, fill = `Injury Severity`)) +
  geom_bar(stat = "identity") +
  labs(title = "Stacked Bar Chart of Crashes by Speed Limit and Injury Severity",
       x = "Speed Limit (mph)",
       y = "Crash Frequency") +
  theme_minimal() +
  scale_fill_brewer(palette = "Spectral") +  # Using a color palette that is distinct
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # To prevent overlapping of x labels
