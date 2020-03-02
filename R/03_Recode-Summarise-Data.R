
# 02_Recoding and Summarise Data ---------------------------------------------
# Load Packages -----------------------------------------------------------
library(tidyverse)

# Load survey data ------

df_1 <- read_csv ("https://raw.githubusercontent.com/grousell/MISAR/master/Data/survey_data_1.csv")
df_2 <- read_csv ("https://raw.githubusercontent.com/grousell/MISAR/master/Data/survey_data_2.csv")


# Merge two data sets together --------------------------------------------

df <- df_1 %>%
  left_join (df_2, by = c ("RespondentID"))

remove (df_1, df_2)


# Recoding data   -------------------------------------------------------

survey <- survey %>%
  mutate (agree_R = recode (agree,
                             "Strongly Agree" = "1",
                             "Agree" = "1",
                             "Neither Agree or Disagree" = "0",
                             "Disagree" = "0",
                             "Strongly Disagree" = "0"))

# Check that recoding worked

# table (survey$agree, survey$agree_R)

# Summary Tables ----------------------------------------------------------

agree_table <- survey  %>%
  group_by (agree) %>%
  count () %>%
  ungroup() %>%
  mutate (perc = n / sum(n)
          ) %>%
  na.omit(agree) %>%
  mutate (agree = parse_factor(agree, levels = c("Strongly Disagree",
                                                 "Disagree",
                                                 "Neither Agree or Disagree",
                                                 "Agree",
                                                 "Strongly Agree")))


agree_table %>%
  ggplot (aes(x = agree, y = perc)) +
  geom_col()
