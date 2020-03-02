
# 02_Merge Data Sets -------------------------------------

library(tidyverse)

# Load 2 data sets with common identiifer ---------------------------------

df_1 <- read_csv ("https://raw.githubusercontent.com/grousell/MISAR/master/Data/survey_data_1.csv")
df_2 <- read_csv ("https://raw.githubusercontent.com/grousell/MISAR/master/Data/survey_data_2.csv")

# Merge two data sets together --------------------------------------------

df_left_join <- df_1 %>%
  left_join (df_2, by = c ("RespondentID"))

length (df_left_join$RespondentID) # How many observations?

df_inner_join <- df_1 %>%
  inner_join (df_2, by = c ("RespondentID"))

length (df_inner_join$RespondentID) # How many observations?

df_anti_join <- df_1 %>%
  anti_join (df_2, by = c ("RespondentID"))

length (df_anti_join$RespondentID) # How many observations?


