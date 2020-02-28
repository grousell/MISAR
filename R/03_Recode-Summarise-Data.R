
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

# Select variables of interest and rename

survey <- df %>%
  select (school,
          goal = "My goal for attending this session: - Open-Ended Response",
          expert = "On this topic, I consider myself:",
          useful = "In regards to this session, the content presented: - Is USEFUL to me",
          applicable = "In regards to this session, the content presented: - Is APPLICABLE to my job",
          changed = "In regards to this session, the content presented: - Has CHANGED my thinking",
          reinforced = "In regards to this session, the content presented: - Has REINFORCED my thinking",
          knowledge = "Concerning the content of the session, how much of the following has increased? - KNOWLEDGE of content presented",
          confidence = "Concerning the content of the session, how much of the following has increased? - CONFIDENCE that you can apply the knowledge in your job",
          motivation = "Concerning the content of the session, how much of the following has increased? - MOTIVATION to implement the content/techniques presented",
          session_valuable = "How much do you agree...I found this session valuable"
  )

# glimpse(survey)

# Recode Agree to Binary  -------------------------------------------------------

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
