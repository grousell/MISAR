

# 02_Recoding and Summarise Data ---------------------------------------------
# Load Packages -----------------------------------------------------------
library(tidyverse)

# Load survey data, select variables of interest and rename

survey <- read_csv("https://raw.githubusercontent.com/grousell/MISAR/master/Data/survey_data.csv") %>%
  select (goal = "My goal for attending this session: - Open-Ended Response",
          expert = "On this topic, I consider myself:",
          useful = "In regards to this session, the content presented: - Is USEFUL to me",
          applicable = "In regards to this session, the content presented: - Is APPLICABLE to my job",
          changed = "In regards to this session, the content presented: - Has CHANGED my thinking",
          reinforced = "In regards to this session, the content presented: - Has REINFORCED my thinking",
          agree = "How much do you agree...I found this session valuable"
  )
glimpse(survey)


# Recode Agree to Binary  -------------------------------------------------------

survey <- survey %>%
  mutate (agree_R = recode (agree,
                             "Strongly Agree" = "1",
                             "Agree" = "1",
                             "Neither Agree or Disagree" = "0",
                             "Disagree" = "0",
                             "Strongly Disagree" = "0"))

# Check that recoding worked
table (survey$agree, survey$agree_R)


# Summary Tables ----------------------------------------------------------

# Base R

table (survey$agree) # Counts
data.frame (table (survey$agree)) # Counts
data.frame(prop.table (table (survey$agree))) # Proportion


